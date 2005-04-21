From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] multi item packed files
Date: Thu, 21 Apr 2005 13:07:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504211301240.2344@ppc970.osdl.org>
References: <200504211113.13630.mason@suse.com> <Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org>
 <m3u0m0q69a.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 22:02:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOhrT-0003xU-BI
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 22:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVDUUFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVDUUFm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:05:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:17321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261842AbVDUUFe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 16:05:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3LK5Qs4022657
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Apr 2005 13:05:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3LK5PuM021154;
	Thu, 21 Apr 2005 13:05:25 -0700
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m3u0m0q69a.fsf@defiant.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, Krzysztof Halasa wrote:
> 
> If someone needs better on-disk ratio, (s)he can go with 1 KB filesystem
> or something like that, without all the added complexity of packing.

I really think the argument that "you can use filesystem feature XYZ" is 
bogus.

I know that I'm not willing to switch filesystems on a whim. I suspect 
nobody else is either. I'm not going to create a loopback filesystem just 
for git, it's just too much pain.

And dammit, if I'm the original author and likely biggest power-user, and 
_I_ can't be bothered to use special filesystems, then who can? Nobody.

This is why I absolutely do not believe in arguments like "if your
filesystem doesn't do tail packing, you shouldn't use it" or "if your
don't have name hashing enabled in your filesystem it's broken".

I'm perfectly willing to optimize for the common case, but that's as far 
as it goes. I do not want to make fundamental design decisions that depend 
on the target filesystem having some particular feature. 

(I'll happily make decisions that say that the target _OS_ has to have a 
particular feature, though. I'll require a sane base-level for 
functionality, but not something like filesystem details).

			Linus
