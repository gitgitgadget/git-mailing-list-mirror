Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADFE1F42E
	for <e@80x24.org>; Fri,  4 May 2018 09:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEDJ6W (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 05:58:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37719 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbeEDJ6U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 05:58:20 -0400
Received: by mail-qk0-f194.google.com with SMTP id d74so16130508qkg.4
        for <git@vger.kernel.org>; Fri, 04 May 2018 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=veqeM8iNGhh5Xf/wRK9LCAT6j7V67CYzlCpuHMYxJXQ=;
        b=MfdsZliFm6IPnB2FJor9Rxol9s5NbbEj89WB4ooTeMUxSDpN5VO3t45DSEdHhKv8g1
         w8GMKz0Zt8TGTd5J63j20DN+mn3ZdlboCV+J1W44h/4buvBcbTFbONaboTG9lDiV37F+
         ZEkFKl5M9ChUqo2++duljlnuFTiGrfSf0Fff431t14a9eU9NCN7MpqAG8ANmcJhqOhQH
         6FjDxNyyr1cz2VkIze/BnPJNQLb47bJcr0do1jc9avkgXYy97MIIgcu9xjJ1AUCAeHRR
         QwRKazxOuOfm36kC/NgguSW5hUQJrrP8RlrmRaubToUX7DI3Ei/VOwqLwUdk7aj+dJPj
         p+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=veqeM8iNGhh5Xf/wRK9LCAT6j7V67CYzlCpuHMYxJXQ=;
        b=IV0izWzns9W0uxhgo7tODvVpDA6MHRz6dH9GvKFZz+vRi8uVwaKvlkzX0WHPIxnoUh
         OH22Az36Yymuhf0uxE1jItYcZ/Sibuo/djyfO2PeEYbK9vqpdaAu1/lSgCl3TRXltKJL
         8dqg+NavfVpbgLXcX8DRvtOiBYBKcoEHBw/KSN5S9DWaQdv9fqi8IFCGjvfqIPXfB5Jd
         QlHSzphCvxnZkt+H86mZSFciDs9NuYdXTabPpK7ohc6WE3OuXzwDV0sUSL2hqIT0cbGW
         3doYkluIge2hRgnjXS4o8e0RSkBILgYAcOII4LKCLQsoiVc3WgxJGF1AJcwAmwmvy9nv
         otQw==
X-Gm-Message-State: ALQs6tAMb85ZjGlE/KRUv8iHFhxJ4VRx2CLJZbKbnH21en8Ykw1bSEbf
        KhNIRKjvNPWbKGWSpDuDtktYQS/BV6L+FB+y0HM=
X-Google-Smtp-Source: AB8JxZoi2TtQh1dVEDw1yO/8qyb0J3KBQNEdJntDyIcGTrTCbfRJnheMx/DM3aa6cdhnH7LypHg8qr7K1Fd57bCKP+g=
X-Received: by 10.233.220.1 with SMTP id q1mr19865936qkf.361.1525427900051;
 Fri, 04 May 2018 02:58:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 4 May 2018 02:58:19 -0700 (PDT)
In-Reply-To: <20180503131840.27956-1-avarab@gmail.com>
References: <87y3h1ykwn.fsf@evledraar.gmail.com> <20180503131840.27956-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 May 2018 05:58:19 -0400
X-Google-Sender-Auth: HgYsXp0o7E9bM6st8PlbKBOKAhc
Message-ID: <CAPig+cR59-OEDL7GDNZF2v7a-NOrUH2zC9EwDvuog8QLRtvKTA@mail.gmail.com>
Subject: Re: [PATCH v2] checkout & worktree: introduce checkout.implicitRemote
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 9:18 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Introduce a checkout.implicitRemote setting which can be used to
> designate a remote to prefer (via checkout.implicitRemote=3Dorigin) when
> running e.g. "git checkout master" to mean origin/master, even though
> there's other remotes that have the "master" branch.
> [...]
> The new checkout.implicitRemote config allows me to say that whenever
> that ambiguity comes up I'd like to prefer "origin", and it'll still
> work as though the only remote I had was "origin".
> [...]
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1084,6 +1084,23 @@ browser.<tool>.path::
> +checkout.implicitRemote::
> +       When you run 'git checkout <something>' and only have one
> +       remote, it may implicitly fall back on checking out and
> +       tracking e.g. 'origin/<something>'. This stops working as soon
> +       as you have more than one remote with a '<something>'
> +       reference. This setting allows for setting the name of a
> +       special remote that should always win when it comes to

"special" is overly broad. "preferred" may better convey the intended
meaning. Simply dropping "special" also works.

Subjective; not worth a re-roll.

> +       disambiguation. The typical use-case is to set this to
> +       `origin`.
> ++
> +Currently this is used by linkgit:git-checkout[1] when 'git checkout
> +<something>' will checkout the '<something>' branch on another remote,
> +and by linkgit:git-worktree[1] when 'git worktree add' when referring

"when ... when"?

> +to a remote branch.  This setting might be used for other
> +checkout-like commands or functionality in the future when
> +appropriate.

Not sure the final sentence adds value as user-facing documentation
(versus the commit message in which it may).

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.=
txt
> @@ -60,6 +60,11 @@ with a matching name, treat as equivalent to:
>  $ git worktree add --track -b <branch> <path> <remote>/<branch>
> +It's also possible to use the `checkout.implicitRemote` setting to
> +designate a special remote this rule should be applied to, even if the

Again, you could drop "special".

> +branch isn't unique across all remotes. See `checkout.implicitRemote`
> +in linkgit:git-config[1].

I have a hard time digesting this paragraph. Perhaps it wants to say:

    Option `checkout.implicitRemote` can be configured to designate a
    <remote> to use when <branch> isn't unique across all remotes.
    See ...

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -450,6 +450,24 @@ test_expect_success 'git worktree --no-guess-remote =
option overrides config' '
> +test_expect_success '"add" <path> <branch> dwims with checkout.implicitR=
emote' '
> +       test_when_finished rm -rf repo_upstream repo_dwim foo &&
> +       setup_remote_repo repo_upstream repo_dwim &&
> +       git init repo_dwim &&

Maybe replace "dwim" here and in the test title with something else
since checkout.implicitRemote is no longer about DWIM'ing?

> +       (
> +               cd repo_dwim &&
> +               git remote add repo_upstream2 ../repo_upstream &&
> +               git fetch repo_upstream2 &&
> +               test_must_fail git worktree add ../foo foo &&
> +               git -c checkout.implicitRemote=3Drepo_upstream worktree a=
dd ../foo foo
> +       ) &&
> +       (
> +               cd foo &&
> +               test_branch_upstream foo repo_upstream foo &&
> +               test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/fo=
o
> +       )
> +'
