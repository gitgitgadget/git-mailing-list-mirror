From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: reset doesn't reset a revert?
Date: Sun, 4 Oct 2009 14:37:55 -0400
Message-ID: <c376da900910041137v6766de4u1419a8209751dcb9@mail.gmail.com>
References: <98300251CB1D46A0B635B4495138C3A7@teddy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-2?B?T2N0YXZpYW4gUuK6bmn+4w==?= <orasnita@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuVzj-0006aH-6n
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 20:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbZJDSie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Oct 2009 14:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757440AbZJDSie
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 14:38:34 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:51439 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431AbZJDSid convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Oct 2009 14:38:33 -0400
Received: by ewy7 with SMTP id 7so2891117ewy.17
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cuy3+zn21UkCPTUWzCWo/URoQ2ZOSMGb7xweQoi2ruM=;
        b=FhPrTCefF1pfpUGQCwPmYq8FtlvSJdJ0ruhrF5pK5eSfa90b2CI9cvuCk7wl5X8Gee
         yVNyrTwZM2cqzgeGJ5YhJ661mCEmTRot6GykidpX9e/pYjYxiefU/Y9Mir+DyeyDLmsi
         AZDNCORjssGR4DMBEKwSa5cUrSPf08Kokf0os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HItLAeIY+ABcB3+rbltMza2T5j5Qw7JZA2xgttBn/8OHt3IkldHz4pUMAwibBgSwVo
         exLh9R5jqFojra2LCzMQwR93k2/QVCAwufHhRGkpEn4gqu7BTqI1d4Y5zt/GYmBX3+rc
         yKBFPTP8frU/uH4PDtSAb8yVqtx6r09MB6hkc=
Received: by 10.216.85.213 with SMTP id u63mr872197wee.15.1254681475648; Sun, 
	04 Oct 2009 11:37:55 -0700 (PDT)
In-Reply-To: <98300251CB1D46A0B635B4495138C3A7@teddy>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129514>

>
> E:\lucru\git\k>git =A0revert HEAD~
> fatal: Cannot revert a root commit
>
> #Does anyone know what does this mean? So I've tried with HEAD^ inste=
ad.
>

Git revert isn't like svn revert.  GIt revert creates a new commit off
of the HEAD that introduces a change that's the opposite of the change
introduced in the commit you specify.  The first commit in a
repository doesn't introduce any change because there's no previous
commit.

Like it says, you can't revert the first commit in the history.

> E:\lucru\git\k>git =A0revert HEAD^
> More?
> More?
> Finished one revert.
> [master 1beba20] Revert "Added baz to file.txt"
> 1 files changed, 0 insertions(+), 1 deletions(-)
>
> # What should I respond to the questions More?
> #I've seen that no matter what I type, it adds to the "HEAD" and tell=
s that
> that commit can't be found, so I just pressed enter.
>
>

It seems the caret is special to the windows command prompt.  I don't
know what it does, but a line of nonsense that ends in ^ causes the
More? More? response you described.  Try quoting the argument so your
shell doesn't mangle it.

>
> #And it seems that not only the repository was changed, but the worki=
ng
> directory also. Is it correct?
>

That's how revert usually works,

> #Well, now let's say I discovered that this new commit was an error a=
nd I
> want to reset it.
> #And I used HEAD^ because HEAD~ didn't work with revert.
>
> E:\lucru\git\k>git reset HEAD^
> More?
> More?
> E:\lucru\git\k>git log --pretty=3Dformat:"%s %h"
> WARNING: terminal is not fully functional
> Revert "Added baz to file.txt" 1beba20
> Added baz to file.txt fabd2f2
> First commit e969cd5
> (END)
>
> #Well, git reset didn't reset the latest commit.
> #Does anyone know why or what I am doing wrong?
>

I don't know what the ^ means, but I'm guessing it's not getting
passed to git.  I'm guessing what you really did is `git reset HEAD`
which clears the index but doesn't undo any commits.

> E:\lucru\git\k>git status
> # On branch master
> nothing to commit (working directory clean)
> E:\lucru\git\k>git reset HEAD~
> file.txt: locally modified
> E:\lucru\git\k>git log --pretty=3Dformat:"%s %h"
> WARNING: terminal is not fully functional
> Added baz to file.txt fabd2f2
> First commit e969cd5
> (END)
>
> #This time git reset resetted the latest HEAD.
> #It seems that git reset wants the HEAD~ commit, while git revert wan=
ts the
> HEAD^ commit. Do you know why (or can I find an explanation for this
> somewhere)?
>

Windows' command shell sucks.  I don't use it.  I don't recommend it.
Try Cygwin.  Or PuTTYcyg.

> E:\lucru\git\k>type file.txt
> foo
> bar
>
> #However, git reset modified just the repository and not the working
> directory.
>

git reset has three modes.  --hard, --soft, and --mixed.  If you
weren't using windows' shell you could type man git-reset to find out
about them.  Try googling git reset.  Basically git reset doesn't mess
with your working copy files unless you ask it to.

> I added the line baz in the file file.txt, commited this change and t=
hen
> reverted to the previous commit. This has also deleted the line "baz"=
 from
> the file.
> Then I resetted the last commit (the revert), however the line "baz" =
didn't
> appear in the file.
>

Reset and revert are very different commands.  Make sure you
understand the difference.

Adam
