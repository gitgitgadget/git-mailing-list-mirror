From: "Elijah Newren" <newren@gmail.com>
Subject: Is incremental staging really the common mode? [Was: Re: Git User's Survey 2008 partial summary, part 4 - how do we use Git]
Date: Sun, 7 Sep 2008 14:17:23 -0600
Message-ID: <51419b2c0809071317g6f916b19p1c2792595be58047@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Stephan Beyer" <s-beyer@gmx.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQiN-00023f-65
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 22:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbYIGURY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 16:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755699AbYIGURY
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 16:17:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:28292 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbYIGURY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 16:17:24 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1141760rvb.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=S07iJ76EMGe1KB6usfThsN//ynbLkJy9M1+KSDSb/R4=;
        b=aeCIx4XW/FAF1KTJy1DxKJvtUlTZC9Hhixi0bn3EYctCXbGQcnqtQ3MrCoDuA+KQ/h
         vTDgN863vjRd/X5gZWv6DrI3dPl5WuYsYa7tVybkJ+s9U6rsPRGGyUct8XKtOQASKBbS
         bKYNzhEQ80Z4apiYhXaW8I8oX2rxr6S3Xp4r8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=dP7VnOgCgd6ljvCV4v1ExHkom9c72d/V8nybLqHgbERLh93H86Pw73qnznoU6oJgp1
         O3ivo7cdmm6iOd+Ltsd7cz+nasdmSnq5KI+m6eHY+y/kLraAyb9JPuX9AJhxG/lk8+TL
         HOVTRT5gLdMxfKSm02vVyyzRDwJZ4VdsSKuNY=
Received: by 10.141.164.13 with SMTP id r13mr8313529rvo.53.1220818643175;
        Sun, 07 Sep 2008 13:17:23 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Sun, 7 Sep 2008 13:17:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95172>

Hi,

On Sat, Sep 6, 2008 at 4:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> This is partial summary of Git User's Survey 2008 after more that 2000
> (yes, that is more than _two thousands_ responses) just after the 6 days
> of running the survey.  It is based on "Analysis" page for this survey:
>  http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8
>
<snip>
> git add + git commit   | 65% (1012)
> git commit -a          | 63%  (981)
<snip>
> Analysis: strangely "git add + git commit" is slightly more used than
> "git commit -a"; I would suspect that "git commit -a" would dominate a
> bit over other forms of committing.  What is for me more suprising is
> that "git commit <file>..." has such large presence in often used
> commands; I would think that it should be mostly used as 'sometimes'
> command.

Does this data really compare usage of incremental staging of commits
vs. non-incremental all-changes-included commits?

You didn't have a git add + git commit -a, so if people feel like they
have brand new files to add to the repository often, adding new files
alone would cause them to mark the git add + git commit box as "often"
(or maybe I was the only one dumb enough to think this was
significantly related to adding new files?).  That alone could account
for the difference, assuming others misunderstood as I did.

Also, you didn't have a continuum of "often" to compare between.  For
example, I marked "add -p" as something I use often (btw, a huge
thanks to whoever added interactive hunk editing to that command),
though that doesn't mean I use it as much as commit -a.  I would say
that I use both add and add -p forms of incremental staging "often",
yet both combined with commit are still far less than my usage of
commit -a.

There may be another issue at play here too: some may have come to
feel that usage of commit -a is error prone and better to avoid.
Maybe I'm the only one, but every once in a while I start
incrementally staging a commit, forget about it, come back to the
project later, and then do a commit -a out of habit (since commit -a
is so common).  Oops -- there goes all my careful staging work!

Actually, I'm really not hit by that last bug anymore, since EasyGit
prevents it for me.  But it's an annoyance of mine with core git.


This topic does make me wonder whether I am missing something, though,
particularly due to Junio's recent comments about diff defaults[1]:

'If they understand "the meaning of the index", not just as literal reading
of the manual page "it is a staging area to prepare for the next commit",
but including the reason why there is a "staging area" and how it is to be
used, they would reach the conclusion that "diff by default will show the
leftover from incremental staging and it is the right thing".'

Despite believing that I understand the index pretty well and use it
often, and love being able to get the unstaged portion of my changes,
I never came to any such conclusion and it hit me by surprise.  There
seems to be an assumption in what Junio has written that incremental
staging is the common mode of operation; given that assumption I can
buy the rest of his argument.  But that seems at odds with my
perception of the default mode of operation, which is at least
partially backed up by Linus' admission that commit -a is the common
case.[2]  Is incremental staging really the common mode of operation?

Am I still missing something fundamental about the index?


Elijah


[1] http://article.gmane.org/gmane.comp.version-control.git/92820

[2] http://marc.info/?l=git&m=116493011406600&w=2
