From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: [Announce] submitGit for patch submission (was "Diffing submodule
 does not yield complete logs")
Date: Fri, 22 May 2015 09:33:20 +0100
Message-ID: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 22 10:33:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YviOY-0003CJ-HX
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 10:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109AbbEVIdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 04:33:25 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33184 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbbEVIdV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 04:33:21 -0400
Received: by iebgx4 with SMTP id gx4so26411235ieb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=yHEIUhtT79U9sagtnVkcQII9THOb9PvsfpsiWwmmNew=;
        b=xutcJwFvmWzxUEtrnC80kFssADJHirkF8qF9lU5XYiLvvAkCcbhluBOzUTwod+BDsK
         D1JDWUMu0HsuLpCm1L9/SnXqa4sTVsTzQ3x32S+Vi5SCBBcrLzrMZ6pNeSbYN8utOOQ2
         XkpDqQcIqeg/fhzp/t+sTCHGYIn07tMhHODgRYBZNavb2vTeNO7hoN/baAVmc7RL2msv
         Sm2jytKu+jnqH5BTvXytrcjF7h7p97EqFH8r5dxG56C8Gprfc4a3MYCWmyZO4EX9o+Te
         3Sd8VYsNVS6cDxxoKC+qp4Y8b2m0/VxyJD4wmgcWEYwnx09nhuxeW17FA9d/tgtCU0db
         BVLA==
X-Received: by 10.107.32.73 with SMTP id g70mr9312166iog.23.1432283600429;
 Fri, 22 May 2015 01:33:20 -0700 (PDT)
Received: by 10.79.35.162 with HTTP; Fri, 22 May 2015 01:33:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269699>

On Tuesday, 19 May 2015, Stefan Beller <sbeller@google.com> wrote:
> On Tue, May 19, 2015 at 12:29 PM, Robert Dailey
> <rcdailey.lists@gmail.com> wrote:
> > How do you send your patches inline?
[snip]
> This workflow discussion was a topic at the GitMerge2015 conference,
> and there are essentially 2 groups, those who know how to send email
> and those who complain about it. A solution was agreed on by nearly all
> of the contributors. It would be awesome to have a git-to-email proxy,
> such that you could do a git push <proxy> master:refs/for/mailinglist
> and this proxy would convert the push into sending patch series to the
> mailing list. It could even convert the following discussion back into
> comments (on Github?) but as a first step we'd want to try out a one
> way proxy.
>
> Unfortunately nobody stepped up to actually do the work, yet :(


Hello, I'm stepping up to do that work :) Or at least, I'm implementing a
one-way GitHub PR -> Mailing list tool, called submitGit:

https://submitgit.herokuapp.com/

Here's what a user does:

* create a PR on https://github.com/git/git
* logs into https://submitgit.herokuapp.com/ with GitHub auth
* selects their PR on https://submitgit.herokuapp.com/git/git/pulls
* gets submitGit to email the PR as patches to themselves, in order to
check it looks ok
* when they're ready, get submitGit to send it to the mailing list on
their behalf

All discussion of the patch *stays* on the mailing list - I'm not
attempting to change
anything about the Git community process, other than make it easier
for a wider group
people to submit patches to the list.

For hard-core contributors to Git, I'd imagine that git format-patch &
send-email
remain the fastest way to do their work. But those tools are _unfamiliar to the
majority of Git users_ - so submitGit aims to cater to those users, because they
definitely have valuable contributions to make, which would be tragic
to throw away.

I've been working on submitGit in my spare time for the past few
weeks, and there
are still features I plan to add (like guiding the user to more
'correct' word wrapping,
sign-off, etc), but given this discussion, I wanted to chime in and
let people know
what's here so far. It would be great if people could take the time to
explore the tool
(you don't have to raise a git/git PR in order to try sending one *to
yourself*, for
instance) and give feedback on list, or in GitHub issues:

https://github.com/rtyley/submitgit/issues

I've been lucky enough to discuss the ideas around submitGit with a
few people at
the Git-Merge conf, so thanks to Peff, Thomas Ferris Nicolaisen, and Emma Jane
Hogbin Westby for listening to me (not to imply their endorsement of
what I've done,
just thanks for talking about it!).

Roberto
