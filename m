Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED4A208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbdHOR7B (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:59:01 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:35377 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbdHOR7A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:59:00 -0400
Received: by mail-ua0-f174.google.com with SMTP id d29so5648350uai.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ANtXrjhQyy6qjBEAK4lY0OaLyOrkyy1ZEVHqoBP1v34=;
        b=EdQ48r0EiuadUvRuvNRVKXrXOlVRmRTdxgjIB99Em8VCy3l9WQjXNnigwXRSxMt48P
         uak5BJ5QOxxipvplQ9S+Mg8X5vFQVaJfJ1h8unN2GTyCdrxlata68pWYb3Zceq2q7Iv+
         hX7VxcbBKFSnVYYBgvgRktBe20Q/SOLm6HAWPsLamNqmqOwyX7oqqrEoZrNAYZvUQ1fq
         JlFWWr0A/CRAh6D4HfHhp8rDqnCsv9ggqnqpW9Ckh4iBWpDWZwQ/3ryijsJeo/vf2adc
         W3c3u3llet/MYkeiN3/lx+Q0KDpTl5y3Dthd/+UQeLwaprmydM+fb7NS0GKWo/ry7lWR
         0ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ANtXrjhQyy6qjBEAK4lY0OaLyOrkyy1ZEVHqoBP1v34=;
        b=CvACNtYJPNB6NZo6K7XdqxFSywYysqgBTkBdHv0N5viuieI09yfnCSzrchkv1g6GXk
         BnpF77MCZDDnHjla+54U2PKx40EzEvpwkXFcAaFAghpGekdhRVxpyW7p07/mnW4EyEHd
         b0zKzWGO5USO8EvVg0BIEmeeFDEPkG0HxnmIMkTB9biW5ds16KB7c5pidST6qT2k+R2M
         eAYhN26jjidkfoi8KYQEND5eznB9cf8F2fDJV/RaeG4Gr7y41cMm/RpcDwd7KDn+RIlT
         WnBfH8ieilkdPJ7x9TgTRZVokoPC+jQ+93gHwz87o9MCeUfJWr8ZRsvn9s5muDqcaUYh
         asBw==
X-Gm-Message-State: AHYfb5hY13CcMP2hh61vxF2jg8C7ZyKrexkQia4LVt2PlkjNCe3UKx2C
        28uFLCu2N6LrrC1hDICGwQbB2fcswQ==
X-Received: by 10.159.53.33 with SMTP id o30mr18583001uao.43.1502819939388;
 Tue, 15 Aug 2017 10:58:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.148.92 with HTTP; Tue, 15 Aug 2017 10:58:38 -0700 (PDT)
In-Reply-To: <bad7dafc-247c-bf5e-8cfd-5445badeef1c@gmail.com>
References: <CAKNmmv3_K4gB6FbcmAjXyviMbU2Ts7Rh7txkOof+-36rF_1+Gw@mail.gmail.com>
 <bad7dafc-247c-bf5e-8cfd-5445badeef1c@gmail.com>
From:   Jason Karns <jason.karns@gmail.com>
Date:   Tue, 15 Aug 2017 13:58:38 -0400
Message-ID: <CAKNmmv3_rFNDDFVEeShAb3mEMOBL4z=oZXP8Df72D44stB_7BA@mail.gmail.com>
Subject: Re: Bug: `git remote show <remote>` reports different HEAD branch
 than refs/remotes/<remote>/HEAD
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 1:09 PM, Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:
> Hi Jason,
>
> On 15/08/2017 16:26, Jason Karns wrote:
>> I have a git repo that shows a different branch in
>> `.git/refs/remotes/origin/HEAD` than is reported by `git remote show
>> origin`.
>>
>> The branch is `github-rename` in refs/remotes/origin/HEAD, but shows
>> `master` in output of git-remote-show
>>
>> ```
>> $ cat .git/refs/remotes/origin/HEAD
>> ref: refs/remotes/origin/github-rename
>>
>> $ git remote show origin
>> * remote origin
>>   Fetch URL: git@XXXX.git
>>   Push  URL: git@XXXX.git
>>   HEAD branch: master
>>   Remote branches:
>>     github-rename     tracked
>>     master            tracked
>>     qa                tracked
>>     refactor-test     tracked
>>   Local branches configured for 'git pull':
>>     github-rename merges with remote github-rename
>>     master        merges with remote master
>>   Local refs configured for 'git push':
>>     github-rename pushes to github-rename (up to date)
>>     master        pushes to master        (up to date)
>> ```
>>
>> git version 2.14.1
>>
>>
>> Background:
>>
>> Prior to my repo being cloned, the default branch was configured to be
>> `some-random-branch` on github. My repo was cloned and the HEAD branch
>> was set to `some-random-branch` correctly (in `refs/`). However,
>> git-remote-show reported `master` as the HEAD branch.
>>
>> Later, `some-random-branch` was deleted from the remote. It _remained_
>> as the HEAD branch locally according to `refs/`.
>>
>> In order to test the remote-show command, I changed the HEAD branch to
>> a branch that actually existed by running `git remote set-head origin
>> github-rename`. It changed the HEAD branch in `refs/` but remote-show
>> continues to report `master` as the remote's HEAD.
>
> I am no expert here, but reading the docs, it seems like you may have
> wrong expectations.
>
> Documentation for "git remote set-head"[1] explains that this command
> is used to set default remote branch (locally), where later you can
> use remote name only to specify that specific (remote) branch instead.
>
> Example shows that for remote named "origin", if you set default
> branch name to "master" (actually being "origin/master" locally),
> then whenever you want to type "origin/master", you can type "origin"
> only instead (set default branch name is implied).
>
> For the given example, that is what you can see inside
> "refs/remotes/origin/HEAD", being set to "refs/remotes/origin/master".
>
> So it is something _you_ set _locally_ to aid you in working with the
> remote repository.


Cool, this is all to my expectations.

>
> On the other hand, what "git remote show" outputs for HEAD is a name
> of actually checked-out branch inside that remote repository - it`s
> what`s stored inside HEAD file of the remote repository root.
>
> So it is something set on the _remote_ end, you can`t influence it
> from your local repository.


So _this_ is not what I expected. Thanks for clarifying.

Considering that a fresh clone replicates the remote's default branch
as the local default for that remote, I wager (in the majority of
cases) that these two are the same. It would seem that what I would
like in this case is a feature change to git-remote-show to show both
the locally-configured and remote-configured defaults for the given
remote (similar in spirit to how git-remote-show already shows local
vs remote information: branches and their configurations for
push/pull).

Such a feature would be the "read" side of the remote set-head
command, and also be useful for highlighting cases where the local and
remote defaults do not match.

If I might suggest adding "Local default branch: xxx" to the
remote-show output, following the HEAD branch output. (Perhaps,
printing "(not set)" if the default isn't configured locally.)

````
$ git remote show origin | head
* remote origin
  Fetch URL: git@XXXX
  Push  URL: git@XXXX
  HEAD branch: develop
  Local default branch: foo
  Remote branches:
```

Or perhaps adding a line at the bottom with the other local refs. That
would allow additional notices when/if the local and remote defaults
differ.

>
> What you _could_ do in your specific case, as you mention using
> GitHub, is following their help page for "setting the default
> branch"[2] for your GitHub repository (which you track locally as
> "origin") to "github-rename".
>
> (in general, non-GitHub repository case, one could usually run there
> either `git checkout github-rename`, if it`s not a bare repository,
> or `git symbolic-ref HEAD refs/heads/github-rename`, if it`s a bare
> repository)
>
> Afterwards, running `git remote show origin` inside your local
> repository should output "github-rename" as HEAD value, as desired.
>

In my case, the github configuration is correct, and the set-head
command was only used to test the output of git-remote-show. The crux
of my misunderstanding is that I thought git-remote-show should be
reporting the contents of `refs/remotes/origin/HEAD`. Having that
information reported somehow (preferably through git-remote-show)
would have clarified this for me.


> p.s. To set your default remote branch locally to checked-out branch
> on the remote end automatically, you can use `git remote set-head
> origin --auto`, as documented[1]. It will inspect what`s inside
> "HEAD" of the remote named "origin", and update your local
> "refs/remotes/origin/HEAD" accordingly.
>
> [1] https://git-scm.com/docs/git-remote#git-remote-emset-headem
> [2] https://help.github.com/articles/setting-the-default-branch/
>
> Regards,
> Buga

Thanks for clarifying. Having this information surfaced a bit would be
a nice improvement, IMO.

Jason
