From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Fri, 1 Jul 2005 21:22:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507012119360.3019@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com>
 <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com>
 <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org> <42C5D553.80905@timesys.com>
 <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org> <42C61351.10306@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Taht <mike.taht@timesys.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 06:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoZNk-0003xM-1H
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 06:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVGBEUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 00:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVGBEUz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 00:20:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261739AbVGBEUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 00:20:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j624KYjA028005
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 1 Jul 2005 21:20:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j624KOIo010838;
	Fri, 1 Jul 2005 21:20:28 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C61351.10306@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 1 Jul 2005, H. Peter Anvin wrote:
> 
> Any reason not to simply append objects to an existing packfile?

What happens when somebody screws up in the middle?

The one thing I care about more than anything else is consistency. We are 
careful about writing objects in the right order, and we can re-create the 
state from the originator etc. But if we start appending stuff and 
something goes wrong in the middle, I'm just not going to touch it. A 
"truncate and hope for the best" algorithm? 

Besides, the result is not a valid git archive any more. 

		Linus
