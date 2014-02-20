From: David Aguilar <davvid@gmail.com>
Subject: Re: Fwd: Git Directory Diff for submodule
Date: Thu, 20 Feb 2014 14:41:23 -0800
Message-ID: <CAJDDKr5czZezBZC1HtS9EjKvpPn-sxQTJOWLABRBVw2ei2BFVg@mail.gmail.com>
References: <CAN-m_UmNudmxJnA95h1nYqi7GGxtzKqqpgFHmJZ+MTnxRoEd6g@mail.gmail.com>
	<CAN-m_UnQ7Yzuq7n6mxmsd3XcfLSVxMdnLiGFDiN1Ph3ZiFqwew@mail.gmail.com>
	<CAN-m_U=eYSEXfVBcD1Rfx-YvGx5Wu+hB2uAc=6xX_HO7bS0FUg@mail.gmail.com>
	<52F54441.6090209@web.de>
	<CAN-m_UnSqTnLydyVF2TLxOia9vzmQr9e4+xWh8aVNBosfCq5nA@mail.gmail.com>
	<53066D8A.6070909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R8OhYm9yIExpcHTDoWs=?= <gabor.liptak@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Feb 20 23:41:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGcJa-0001rv-Nf
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 23:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbaBTWl2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Feb 2014 17:41:28 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:45339 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbaBTWlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Feb 2014 17:41:24 -0500
Received: by mail-qc0-f181.google.com with SMTP id c9so4045692qcz.26
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 14:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YVRVK2E80tK0HG5uGxRWdH/KxhnBAUaiKEJ+9ThpRJs=;
        b=NXV+evlMNfi2VB6316s49NcNJE8YPHK1cNankCKPDgvJJg2MFdBqiLZ/lHS77QXnqu
         zfC/ntWgyO/4NVEV9xd2tEBBPapKk1JDD8HKJDPiSrmHcFdelu/3Hj1tP/hF3Cnu1SIu
         ikSTrjhjr8LoddJeiQHgbPz3inMGKCkd4RDPn8bOGWoFsGbw+OeugHYPjKHuOPiun59M
         ghDYCxJtyZFPMmzarV91Nc65ix4ecL3eXYWMSnIni/1kcWfdrNCQ8mV3jw3kDMQcJS3J
         VzyQv9ARnultt4UPP1T4ffB4GKqS8bdUQJBkQ458wpmiYvTyCRvWAA5n3nyGdNYjYuX+
         G/2Q==
X-Received: by 10.140.100.135 with SMTP id s7mr4907828qge.114.1392936083788;
 Thu, 20 Feb 2014 14:41:23 -0800 (PST)
Received: by 10.229.176.194 with HTTP; Thu, 20 Feb 2014 14:41:23 -0800 (PST)
In-Reply-To: <53066D8A.6070909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242449>

On Thu, Feb 20, 2014 at 1:03 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Sorry for the late reply, but here we go ...
>
> Am 10.02.2014 07:33, schrieb G=C3=A1bor Lipt=C3=A1k:
>> Hi Jens,
>>
>> So "git status" says:
>>
>> liptak@liptak-kubuntu:~/Projects/MAIN_MODULE/platform/SUBMODULE
>> [master]$ git status
>> # On branch master
>> # Your branch is up-to-date with 'origin/master'.
>> #
>> # Changes not staged for commit:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working
>> directory)
>> #
>> #       modified:   xxxxxx.java
>> #       modified:   xxxxxxx.java
>> # ...
>> # ...
>> # ...
>> # ...
>> # ...
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>>
>> git config core.worktree gives back: "../../../../platform/SUBMODULE=
"
>
> Which looks a bit strange but is perfectly ok for a repository
> that uses a gitfile, as the core.worktree setting is relative
> to the git directory the gitfile references and not the directory
> the gitfile lives in. A quick glance at the find_worktree
> subroutine in git-difftool.perl makes me think that difftool is
> not aware of that fact. David, does that make sense?

That does make sense. It sounds like that may need to be adjusted.

What does `git rev-parse --show-toplevel` print? It seems like the
find_worktree() logic needs to be extended to handle .git files.

>> The submodule was inited simply with "git submodule init" +
>> "git.submodule update"

Or possibly, as you mention below, it could be that "git submodule
init" ended up writing the wrong core.worktree value. I'm not very
familiar with how they are initialized, but the paths do seem sane, so
I doesn't seem like that's the issue.

If it's a problem in difftool we can probably find a way to do the
right thing. It looks like the core.worktree is relative to the
=2Egit/modules/XXX directory rather than the submodule (and
super-project)'s worktree.

Here's our current logic:

sub find_worktree
{
    my ($repo) =3D @_;

    # Git->repository->wc_path() does not honor changes to the working
    # tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree'
    # config variable.
    my $worktree;
    my $env_worktree =3D $ENV{GIT_WORK_TREE};
    my $core_worktree =3D Git::config('core.worktree');

    if (defined($env_worktree) and (length($env_worktree) > 0)) {
        $worktree =3D $env_worktree;
    } elsif (defined($core_worktree) and (length($core_worktree) > 0)) =
{
        $worktree =3D $core_worktree;
    } else {
        $worktree =3D $repo->wc_path();
    }
    return $worktree;
}

John, any thoughts?

>> MAINMODULE/.gitsubmodules file contains similar entry:
>> [submodule "platform/SUBMODULE"]
>> path =3D platform/SUBMODULE
>> url =3D ssh://git@somehost/foo/bar.git
>>
>> MAINMODULE/.git/config:
>> [submodule "platform/SUBMODULE"]
>> url =3D ssh://git@somehost/foo/bar.git
>>
>> MAINMODULE/platform/SUBMODULE/.git:
>> gitdir: ../../.git/modules/platform/SUBMODULE
>>
>> MAINMODULE/.git/modules/platform/SUBMODULE/config:
>> [core]
>> repositoryformatversion =3D 0
>> filemode =3D true
>> bare =3D false
>> logallrefupdates =3D true
>> worktree =3D ../../../../platform/SUBMODULE
>> [remote "origin"]
>> url =3D ssh://git@somehost/foo/bar.git
>> fetch =3D +refs/heads/*:refs/remotes/origin/*
>>
>> So for me it seems that somehow the relative path inside
>> MAINMODULE/.git/modules/platform/SUBMODULE/config gets configuread
>> wrong during submodule init+update.
>>
>> I tried to update the
>> MAINMODULE/.git/modules/platform/SUBMODULE/config to contain
>> ../../platform/SUBMODULE as worktree path, then meld was correctly
>> started, but the compare tree was not usable. For file changes it
>> displayed always: XXXXX.java: Dangling symlink. So this is still not=
 a
>> complete solution somehow.
>>
>> Regards,
>>
>> G=C3=A1bor Lipt=C3=A1k
>>
>> 2014-02-07 Jens Lehmann <Jens.Lehmann@web.de>:
>>> Am 07.02.2014 10:15, schrieb G=C3=A1bor Lipt=C3=A1k:
>>>> I think I have found a bug related to submodules and directory dif=
f.
>>>> See the details at hXXp://stackoverflow.com/q/21623155/337621.
>>>
>>> Let's inline the recipe one finds after decrypting this link:
>>>
>>> ~/Projects/MAINMODULE/platform/SUBMODULE [master]$ git difftool -to=
ol=3Dmeld --dir-diff --cached
>>>   fatal: Could not switch to '../../../../platform/': No such file =
or directory
>>>   diff --raw --no-abbrev -z --cached: command returned error: 128
>>> ~/Projects/MAINMODULE/platform/SUBMODULE [master]$ cd ..
>>> ~/Projects/MAINMODULE/platform [master]$ cd ..
>>> ~/Projects/MAINMODULE [master]$ git difftool -tool=3Dmeld --dir-dif=
f --cached
>>>   // NO PROBLEM, works.
>>> ~/Projects/MAINMODULE [master]$ git version
>>>   git version 1.8.4
>>>
>>>
>>>> If you need any further details, just ask.
>>>
>>> - Does this only happen when you use difftool? E.g. what does
>>>   "git status" inside the submodule say?
>>>
>>> - What does "git config core.worktree" print when run in the
>>>   submodule?
--=20
David
