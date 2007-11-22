From: jhud7196@artax.karlin.mff.cuni.cz
Subject: Re: Git in a Nutshell guide
Date: Thu, 22 Nov 2007 17:57:10 +0100 (CET)
Message-ID: <47297.194.138.12.144.1195750630.squirrel@artax.karlin.mff.cuni.cz>
References: <1195477504.8093.15.camel@localhost> <fhsc7b$k4g$1@ger.gmane.org>
    <1195737303.19260.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Jonas Juselius" <jonas@iki.fi>
X-From: git-owner@vger.kernel.org Thu Nov 22 17:57:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvFMv-00017v-Cb
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 17:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbXKVQ5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 11:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbXKVQ5T
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 11:57:19 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:45287 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXKVQ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 11:57:19 -0500
Received: from artax.karlin.mff.cuni.cz (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id 3EF1798052;
	Thu, 22 Nov 2007 17:57:10 +0100 (CET)
Received: from 194.138.12.144
        (SquirrelMail authenticated user jhud7196)
        by artax.karlin.mff.cuni.cz with HTTP;
        Thu, 22 Nov 2007 17:57:10 +0100 (CET)
In-Reply-To: <1195737303.19260.27.camel@localhost>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65832>

> I'm planning to write a section in the "Nutshell guide" on rewriting
> history and rebasing. I have a question related to rewriting history. As
> usual, I'll assume that the part of the history I'm mucking with has not
> been pushed or pulled by anyone.
> Suppose I have been working on some topic branch for a while and been
> overly trigger happy, i.e. I have produced a ridiculous number of
> commits along the way. At some point when I'm done I want to publish my
> changes, but doing so would create an insanely obese history full of
> near nonsense commits. What I want to do is to slim down the commit log
> into pieces that actually makes sense. What is the preferred (or best,
> most convenient) way of doing this? The way I have done this previously
> is essentially:
>
> 1.  git branch -m mytopic tmp_mytopic  # rename
> 2.  git branch mytopci tmp_mytpoic~42  # go back in history
> Loop:
> 3.1 git log; git diff; git annotate...
> 3.2 git diff tmp_mytopic~42..tmp_mytopic~33 | git-apply
> 3.3 git commit -m "sane commit message" -a
> 4.  git branch -d tmp_mytopic
>
> If I need to reorder commits I can first use git-rebase -i to get
> everything streamlined. There must be a better way of doing this, right?

IIRC rebase -i is also capable of merging the commits. So you can use it
for the whole thing.

--
                                              Jan Hudec <bulb@ucw.cz>
