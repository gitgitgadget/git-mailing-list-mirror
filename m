From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: pt_BR initializaton
Date: Sun, 10 Mar 2013 17:12:43 +0800
Message-ID: <CANYiYbG1hqRCmUD=J4xMe8GPk8Uu4+Vb+b30e-tySPWE7JPo8Q@mail.gmail.com>
References: <CAN_hzmot2vHRYeZWaoh=pbeoG3RNvzsKkUv+9jVs4WUU74tkbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Harring Figueiredo <harringf@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 10:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEcJb-00035H-Jn
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 10:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab3CJJMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 05:12:45 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34946 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab3CJJMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 05:12:44 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so391846wid.17
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 01:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Zgz9G4C0KcCNM0Q+b0eFMTLgD04VJJXN/ss6iKN4bIg=;
        b=yGaeEyiTvl5KUXGJ7eqxna/Z+Rl9cKZARA4E+pnDC6z5XuvFwOdJa4zOljOWso7tkJ
         tr2j9J/hD5J17ZTT99Nhzk2s4FrBUg/1dhC7ejhSGlGFreefzrgiWwJdypCjxgKHWh2t
         mDSbtz4enuaANpZj3B3i+MiXYCNxhtbCm4ljGP5zphXs4tZD0ncsrxrib8i4l5C3VOo5
         ExGD/mKI6rqfe6230W3x9vSCR8vfLlvY21sI6lnURWAmJIBgedic12saZD2iQBLLt5/J
         t53SeCkigcZSsNbcVwFJd1hAUDMNWb7to6xUFnVmehGXbkWlytdNqbaeTmhN+lAIy6+Y
         bK9A==
X-Received: by 10.194.19.135 with SMTP id f7mr13018499wje.27.1362906763373;
 Sun, 10 Mar 2013 01:12:43 -0800 (PST)
Received: by 10.194.80.40 with HTTP; Sun, 10 Mar 2013 01:12:43 -0800 (PST)
In-Reply-To: <CAN_hzmot2vHRYeZWaoh=pbeoG3RNvzsKkUv+9jVs4WUU74tkbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217793>

Hi Harring,

I'm glad to see that there will be another locale for Git.
I reviewed three commit from you. There are some problems:

Because git has a strict and high standard for commit log, so

1. your commit log must have "Signed-off-by: " line(s).
    Commit using "commit -s", or using alias such as
    "git config --global alias.ci 'commit -s'" may help.
    Such line(s) are signatures of reviewers and contributors for
    your commit, and these line(s) are ordered by the time of
    contributions.

2. 50+72 rule.
    The first line of your commit should no longer than 50
    characters, and should not contain characters other than
    standard ascii characters. This is because when your
    commit save as patch file using git format-patch, first line
    of your commit will be used as filename, and as email
    subject.

    Then a blank line to separate subject and other contents
     if there are any other descriptions for your commit.

    Other lines in your commit log messages should be
    wrapped at line 72 or less, and you can use unicode
    characters.

3. Add "l10n:" prefix in subject of your commit log messages.
    You can find out how other l10n contributors writing
     there commit log message, using this command:

    git log -- po/

4. Squash trivial commits before send to upstream.
    If you find it is hard to write your commit log message,
    it may indicate that you have make too many trivial
    commits. In this case, you should squash your commit
    before send them to upstream using "git rebase -i
    --autosquash" command.

    Tips: trivial commit (for backup or fixup previous commit)
            may commit using "--fixup" or "--squash" option, such as:

                git commit --fixup HEAD

            and these commits will be squash automatically when:

                git rebase -i --autosquash

There is a script in po-helper branch, and I use it to check
commits from other l10n contributors, and it may also help
for you:

    https://github.com/git-l10n/git-po/blob/po-helper/po/po-helper.sh

This discussion may also help:

    http://article.gmane.org/gmane.comp.version-control.git/198626


2013/3/10 Harring Figueiredo <harringf@gmail.com>:
>
>
> Hello Jiang,
>
> Please pull the changes from https://github.com/harringf/git-po.git  to
> initialize the pt_BR translation.
>
> Thank you,
>
> Harring Figueiredo


-- 
Jiang Xin
