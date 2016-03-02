From: Joe Einertson <joe@kidblog.org>
Subject: Re: git-rebase + git-mergetool results in broken state
Date: Wed, 2 Mar 2016 16:29:04 -0600
Message-ID: <CA+hqKG8sgameMXX1eG3tBBbGomzjY6o+SY=DOBB-iTo4TL5rrQ@mail.gmail.com>
References: <CA+hqKG8M97SEmejrdr-OC0yQc=ofY4yWej4gG_6B2jsqGq8imw@mail.gmail.com>
	<20160301163801.GA18095@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 23:29:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abFGa-00017A-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 23:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbcCBW3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 17:29:07 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34129 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbcCBW3G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2016 17:29:06 -0500
Received: by mail-oi0-f48.google.com with SMTP id m82so2626398oif.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 14:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kidblog-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=d6MhIgXfKULM9T9uAaHuNejpyLpW8QLChkTSz/4JW+Q=;
        b=c16Kz83FoQYC8jmDcaDjfndot3hWz1N330grd4zMfkTZGX0eww/isWqtxdTqnjA8XB
         tjw8vtWaXNSYeYBNIu2vNVrCXf55Nzx5IdZ5veeoh0vI/Gby2DMt9V3ru0Jp3WE+pQSV
         RhYBLrB6aeZfeAJw0ZAV45XT7GiMsKP9BB40Hu/dnh2CVAjs4aoeexDi9QOYI0oZA1Jl
         a3q0EKmJ0G1ytIP1s2PpWE5Fb269wgVAQxyrZtRwQGRfay6NB/hi+zDHadsFgp2VrWHB
         qu0n59SNzo4/n2Qptl8qa4SfFatJgaMWMr8rZnXhDQBbEtEuoKbMo+LHfvJfjJjElSMy
         GJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=d6MhIgXfKULM9T9uAaHuNejpyLpW8QLChkTSz/4JW+Q=;
        b=E1VS0IfRsIB/CbUXyfcwWq74gI7XsNvG35akSsK0TxMxBvRSKw5GyhZptVAuI8zCMv
         8GQz1y3Lkb62e0DtA7rv8lyuusZhY6rvrkfjgCNxf4e0LRIDhZX0I0DFIj5VO7snrfV+
         Qf3+Z70Ys+RY2u2y/ncRi1hNtEg3rJM0ESVt4UqCb0w/LE3y9gxiWHfoeUXtoYq36RC+
         sDBkD1fWVISO/3JL/xs1pLvb8AxP22hyWV4x0dtwreXojLuEw5LSM3A8E1Hphe0lHAin
         sn2oPez7KHQMaJhcpFo4kbzXXwvUSPVvQSVvJ3Ogd592p5WiOX4FhEloAU3ES5m0KvLZ
         75yw==
X-Gm-Message-State: AD7BkJI7EYzXvHp2nUoW/d5iF+g/kbvC9zWxAC0pJCdQqcrPW6rc3w6sH9HD4qS5dq7L/AXmnyk0nFooEHABew==
X-Received: by 10.202.235.214 with SMTP id j205mr14269408oih.23.1456957744571;
 Wed, 02 Mar 2016 14:29:04 -0800 (PST)
Received: by 10.157.6.3 with HTTP; Wed, 2 Mar 2016 14:29:04 -0800 (PST)
X-Originating-IP: [2601:445:101:400:2085:2154:9f0f:2302]
In-Reply-To: <20160301163801.GA18095@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288158>

Thanks for the thorough response. Here is some basic info:

$ git --version
git version 2.5.0
$ cat /etc/issue
Ubuntu 15.10
$ git config merge.tool
kdiff3

The issue seems as if it may be related to different renames of the
same file/folder in both the master branch and the feature branch.

I have a minimal repro in a repository located here:
https://github.com/royaldark/git-mergetool-issue

The repository has 2 branches, master and feature-branch. There are 3
commits: the initial commit, an additional commit on master, and a
commit on the feature branch. The initial commit has a folder named
"a" with a text file in it. The commit on the feature branch renames
that folder to "b", and the second commit on master renames it to "c".
Both commits modify the text file in the folder.

To repro the issue,
1. Clone the repo
2. git checkout feature-branch
3. git rebase master (or git merge master, either way works)
4. git mergetool

This produces errors like the following:
mv: cannot stat =E2=80=98a/b.txt=E2=80=99: No such file or directory
cp: cannot stat =E2=80=98./a/b_BACKUP_32417.txt=E2=80=99: No such file =
or directory
mv: cannot move =E2=80=98.merge_file_EYnyGH=E2=80=99 to =E2=80=98./a/b_=
BASE_32417.txt=E2=80=99: No
such file or directory
/usr/lib/git-core/git-mergetool: 229: /usr/lib/git-core/git-mergetool:
cannot create ./a/b_LOCAL_32417.txt: Directory nonexistent
/usr/lib/git-core/git-mergetool: 229: /usr/lib/git-core/git-mergetool:
cannot create ./a/b_REMOTE_32417.txt: Directory nonexistent

As for your thoughts on a workaround, you were exactly right:
> I'm not sure about a workaround, but.. it might possibly work if
> you were to `mkdir -p` the directory mentioned above, but that's
> a guess.  If that does workaround the issue then please let us
> know since that would be an interesting data point.

The following steps do NOT cause the issue:
1. git checkout feature-branch
2. git rebase master (or git merge master, either way works)
3. mkdir a
4. git mergetool

Creating the "a" directory solves the issue, and git-mergetool runs
without error.

Please let me know if I can provide any additional information.

-Joe

On Tue, Mar 1, 2016 at 10:38 AM, David Aguilar <davvid@gmail.com> wrote=
:
> On Tue, Feb 23, 2016 at 04:44:49PM -0600, Joe Einertson wrote:
>> I'm experiencing an annoying issue which leaves the repository in a
>> weird, broken state. I am attempting a rather vanilla rebase, rebasi=
ng
>> the commits from a feature branch on top of the newest commits on
>> master.
>
> Can you tell us a little more about what's in the branch being
> rebased?  Is it perhaps a public project that you can share so
> that we can reproduce the issue?
>
> Here are a few more questions that can help narrow down the
> issue:
>
> * What Git vesion are you using?
>
> * What mergetool are you using?
>   - See the output "git config merge.tool"
>
> * What platform are you on?  Are you on Windows?
>
> * Does the conflicting commit contain renames?
>
> I'm trying to figure out whether we are missing a `mkdir -p`
> somewhere, and whether we hadn't run into this in the past
> because the merge needs to involve renames.
>
>> So, I run a typical series of commands:
>> 1. git checkout feature-branch
>> 2. git rebase master (conflicts ensue)
>> 3. git mergetool
>>
>> The conflicts are expected, but when using mergetool to resolve them=
,
>> I encounter many "no such file or directory" errors.
>>
>> mv: cannot stat
>> =E2=80=98app/components/mediaManager/kbImageEditor.directive.coffee=E2=
=80=99: No such
>> file or directory
>> cp: cannot stat
>> =E2=80=98./app/components/mediaManager/kbImageEditor.directive_BACKU=
P_13615.coffee=E2=80=99:
>> No such file or directory
>> mv: cannot move =E2=80=98.merge_file_ogGjXX=E2=80=99 to
>> =E2=80=98./app/components/mediaManager/kbImageEditor.directive_BASE_=
13615.coffee=E2=80=99:
>> No such file or directory
>> /usr/lib/git-core/git-mergetool: 229: /usr/lib/git-core/git-mergetoo=
l:
>> cannot create ./app/components/mediaManager/kbImageEditor.directive_=
LOCAL_13615.coffee:
>> Directory nonexistent
>> /usr/lib/git-core/git-mergetool: 229: /usr/lib/git-core/git-mergetoo=
l:
>> cannot create ./app/components/mediaManager/kbImageEditor.directive_=
REMOTE_13615.coffee:
>> Directory nonexistent
>
> * Does the directory ./app/components/medaiManager/ exist in master?
>
> * Did a commit on master perhaps move its content somewhere else?
>
> * Does that directory have some chmod permissions, or is it owned
>   by a different user?
>
> * Are you able to create new files in that directory?
>
>> This leaves weird dangling files like '.merge_file_ogGjXX' in the
>> repo, and I assume I should not proceed with the merge since it
>> couldn't even create the files to compare.
>
> If you got a failure at this step you can safely delete those
> temporary dangling files and then follow the advice given by
> `git status`.
>
> Typically it'll list files with conflicts.  Open them with
> your $EDITOR, resolve conflicts like normal, and add the
> result using `git add`.  Nonetheless, we'd like to get to the
> bottom of this issue.
>
>> Is this a known issue? Is there any workaround? Is it safe to procee=
d
>> with the merge?
>
> I've never ran into this myself, and it's never been reported
> here so this is not a known issue.
>
> It's still safe to proceed with the merge and resolve files the
> normal way.  If you would rather undo the rebase and go back to
> your original state (before the rebase) then you can do
> `git rebase --abort` anytime.
>
> I'm not sure about a workaround, but.. it might possibly work if
> you were to `mkdir -p` the directory mentioned above, but that's
> a guess.  If that does workaround the issue then please let us
> know since that would be an interesting data point.
> --
> David
