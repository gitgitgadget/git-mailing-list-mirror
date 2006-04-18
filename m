From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Log message printout cleanups
Date: Tue, 18 Apr 2006 08:37:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604180827040.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
 <7vodyzkehq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
 <7vejzvka09.fsf@assigned-by-dhcp.cox.net> <7v7j5nk9bf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604171751540.3701@g5.osdl.org> <7vd5ffig70.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 17:37:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVsGl-0003HT-HC
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 17:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWDRPh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 11:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWDRPh2
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 11:37:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932284AbWDRPh1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 11:37:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3IFbMtH006030
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 08:37:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3IFbMuF014959;
	Tue, 18 Apr 2006 08:37:22 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5ffig70.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18858>



On Mon, 17 Apr 2006, Junio C Hamano wrote:
> 
> I think this does what both of us want.  One thing I noticed is
> that log-tree-diff-flush does "---\n" under --patch-with-stat
> but not under --stat; I matched that here.

Looks very nice now. Thanks.

My only slight complaint is that I think it should be possible to do

	git log --cc --stat

to get both patches and stat, but that doesn't work. You have to write

	git log --cc --patch-with-stat

to get both ;/

But that's just a small (and unimportant) detail.

Here's another really small detail: with merges, there's two newlines 
between the diffstat and the diff. That bug doesn't show up with regular 
commits.

But this all looks very nice. I agree that "git log --stat" is a very nice 
way to look at the log, much better than "git-whatchanged". And the thing 
that has really fallen out of this all is how you can do

	git log --stat --full-diff drivers/pci/

which git-whatchanged historically didn't support (of course, now it 
does, but you're right, the new "git log" is so nice that I'm starting to 
teach myself not to use "git whatchanged" any more).

		Linus
