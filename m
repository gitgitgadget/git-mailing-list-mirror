From: Bruno Haible <bruno@clisp.org>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 00:41:27 +0100
Message-ID: <200702120041.27419.bruno@clisp.org>
References: <200702111252.28393.bruno@clisp.org> <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOEK-0002T0-CD
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbXBKXfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbXBKXfc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:35:32 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:58755 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbXBKXfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:35:32 -0500
Received: from linuix.haible.de (cable-137-244.iesy.net [81.210.137.244])
	by post.webmailer.de (klopstock mo50) (RZmta 4.5)
	with ESMTP id B01032j1BJjUP5 ; Mon, 12 Feb 2007 00:35:30 +0100 (MET)
User-Agent: KMail/1.5.4
In-Reply-To: <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY4JDyuz6KRYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39332>

Hello Johannes,

Thanks for the helpful answer.

> Yes, because there were only 147 commits which changed the file. But git 
> looked at all commits to find that.

Ouch.

> Basically, we don't do file versions. File versions do not make sense, 
> since they strip away the context.

Is there some other concept or command that git offers? I'm in the situation
where I know that 'tr' in coreutils version 5.2.1 had a certain bug and
version 6.4 does not have the bug, and I want to review all commits that
are relevant to this. I know that the only changes in tr.c are relevant
for this, and I'm interested in a display of the minimum amount of relevant
commit messages. If "git log" is not the right command for this question,
which command is it?

> > 2) Why so much system CPU time, but only on MacOS X?
> 
> Probably the mmap() problem. Does it go away when you use git 1.5.0-rc4?

No, it became even worse: git-1.5.0-rc4 is twice as slow as git-1.4.4 for
this command:
  git-1.4.4: 25 seconds real time, 24 seconds of CPU time (12 user, 12 system)
  git-1.5.0: 50 seconds real time, 39 seconds of CPU time (20 user, 19 system)

Bruno
