From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 13:12:48 -0500
Message-ID: <20060131181248.GE11955@fieldses.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060130185822.GA24487@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 19:13:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4002-0000TP-72
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 19:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWAaSND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 13:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWAaSND
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 13:13:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:17626 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751308AbWAaSNB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 13:13:01 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F3zzk-0003ut-D2; Tue, 31 Jan 2006 13:12:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15330>

On Tue, Jan 31, 2006 at 09:30:48AM -0800, Linus Torvalds wrote:
> I really think you should explain it one of two ways:
> 
>  - ignore it. Never _ever_ use git-update-index directly, and don't tell 
>    people about use individual filenames to git-commit. Maybe even add 
>    "-a" by default to the git-commit flags as a special installation 
>    addition.
> 
>  - talk about the index, and revel in it as a way to explain the staging 
>    area. This is what the old tutorial.txt did before it got simplified.
> 
> The "ignore the index" approach is the simple one to explain. It's 
> strictly less powerful, but hey, what else is new? 

Yeah, I do wonder what's likely to be the best approach for most users.
My goal with the new tutorial was to get a reader doing something fun
and useful as quickly as possible.  So it just refers elsewhere for any
discussion of the index file or SHA1 names.  But probably everyone needs
to pick up that stuff eventually anyway, and maybe it's better to get to
it a little sooner, I dunno.

Besides the git-add/git-commit thing, the other thing that caught me by
suprise was the behaviour of git reset.  I expected there to be an
"inverse" to git commit -a, meaning that

	1) the sequence
		git reset HEAD^
		git commit -a
	   would be a no-op, in the sense that the new commit would
	   get the same changes as the old one, and
	2) the sequence
		git commit -a
		git reset HEAD^
	   would be a no-op, in the sense that "git diff" would report
	   the same diff before and after.

But there isn't, and explaining how --soft and --mixed actually work
requires referring to the index file.

Is that something that can be fixed in the tools or does the user
fundamentally need to know about the index file to do this kind of
stuff?

--b.
