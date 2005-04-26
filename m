From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 12:58:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261256150.18901@ppc970.osdl.org>
References: <Pine.LNX.4.44.0504261129500.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 21:51:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQW5e-0004uu-RI
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 21:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVDZT4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 15:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVDZT4h
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 15:56:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:50857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261761AbVDZT4e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 15:56:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QJuQs4019220
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 12:56:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QJuJWH004304;
	Tue, 26 Apr 2005 12:56:23 -0700
To: Bram Cohen <bram@bitconjurer.org>
In-Reply-To: <Pine.LNX.4.44.0504261129500.4678-100000@wax.eds.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Bram Cohen wrote:
> 
> If one person renames a file and another person modifies it then the
> changes should be applied to the moved file.

Bzzt. Wrong answer.

The _right_ answer is "if one person moves a function, and another person 
modifies the function, the changes should be applied to the moved 
function".

Which is clearly a _much_ more common case than file renames.

In other words, if your algorithm doesn't handle the latter, then there is 
no point in handling the former either.

And _if_ your algorithm handles the latter, then there's no point in 
handling file renames specially, since the algorithm will have done that 
too, as a small part of it.

		Linus
