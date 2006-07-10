From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: can I get only the list of merges?
Date: Mon, 10 Jul 2006 11:51:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607101145590.5623@g5.osdl.org>
References: <20060710192622.70c51a81.diegocg@gmail.com> <E1FzzlS-0003JE-9C@moooo.ath.cx>
 <Pine.LNX.4.64.0607101103160.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Diego Calleja <diegocg@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 20:51:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G00qq-00010D-Dy
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 20:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWGJSvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 14:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbWGJSvV
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 14:51:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30893 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422654AbWGJSvV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 14:51:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6AIpCnW029281
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Jul 2006 11:51:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6AIp950014365;
	Mon, 10 Jul 2006 11:51:10 -0700
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <Pine.LNX.4.64.0607101103160.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23636>



On Mon, 10 Jul 2006, Linus Torvalds wrote:
>
> However, if you want a _sneaky_ way of doing it, and want a graphical 
> result, and have a recent version of git, you can also just do something 
> like
> 
> 	gitk --full-history -- %%nonexistant-file%%
> 
> which will give you each commit that changes that nonexistant file (there 
> should be none ;), and the full commit history for those (ie all the 
> merges).

Btw, a better way to do the same is probably

	gitk --full-history -- a//b

which is guaranteed to not match any files and doesn't depend on just an 
_unlikely_ filename. Instead, it depends on the fact that a name with a 
double slash should not exist in a git archive.

(There are other possibilities too - instead of "a//a", you can just use 
the filename ".git", for the same reasons - it definitely won't be tracked 
by git).

		Linus
