From: Andreas Gal <gal@uci.edu>
Subject: Re: git and symlinks as tracked content
Date: Tue, 3 May 2005 12:57:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
References: <1115145234.21105.111.camel@localhost.localdomain>
 <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 21:54:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3Sn-00018i-I9
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVECT6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVECT6x
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:58:53 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:52641 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261661AbVECT5z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:57:55 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j43Jvp1Z030793;
	Tue, 3 May 2005 12:57:51 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j43JvpiV030789;
	Tue, 3 May 2005 12:57:51 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>  - S_IFCHR/S_IFBLK (0020000 or 0060000), with the 20-byte SHA1 not being a 
>    SHA1 at all, but just the major:minor numbers in some nice binary 
>    encoding. Probably: two network byte order 32-bit values, with twelve 
>    bytes of some non-zero signature (the SHA1 of all zeroes should be 
>    avoided, so the signature really should be soemthing else than just 
>    twelve bytes of zero).

Yuck. Thats really ugly. Right now all files have a uniform touch to them. 
For every hash you can locate the file, determine its type/tag, unpack it, 
and check the SHA1 hash. The proposal above breaks all that. Why not just 
introduce a new object type "dev" and put major minor in there. It 
will still always hash to the same SHA1 hash value, but fits much better in the 
overall design. 

Andreas
