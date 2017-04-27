Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC49207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 18:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938661AbdD0S1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 14:27:49 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35835 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164145AbdD0S1I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 14:27:08 -0400
Received: by mail-pf0-f181.google.com with SMTP id v14so34403189pfd.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tDoK0Bvc4eT8v8AtxuaeHmVi8nbXrWVGB+LE8XQ6/WM=;
        b=wLY+5zmJ6zKOCua6wAGB/a/+XU/bwBg3LUrkqxLz3OcQO5kOIN/IcxdaHLk32ToSYe
         WmGX+zuAOqyh8uD8lPE1zCYRCtFQf0fuuuf5+QwjS/4eOYhncXbvtDPwKv9b3VaLFXkY
         2b2xmcvWoNkE6df0t0/3hXateyWM08qi3mxQJO5EBPudVJlJXlmPO9rEXv4+fYVxp0cU
         dQPemRG+BHIGcAcpyN7vFVGccQgeVFRS+4/NotdbEbUaBneaiUB3t1Rw3U7Udl3M1mdq
         rV+UCNXo0MxVmO5jEulSYJrNJt4KVExge2SMbbcS74+XOHfohkgjwnADwoP77vsC+X94
         7oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tDoK0Bvc4eT8v8AtxuaeHmVi8nbXrWVGB+LE8XQ6/WM=;
        b=uZJY8HcwM+Pi0LqNGURGcR2JzqGVPdyFUFfnBnkZi81h8qXHGdz+QaBJg1M0L7nyq/
         wJL+7MMFgQN8xsdtdwBqD2NguAX6/6AkZfkH3OWptlTka8mbJenOs2ESYT4LkeJzWPbT
         6/X7JI3JTYSkyZi9TxL2/rMH+dlis+7qsUQWmxbmdZ0u9Mba7gMPL/Fpe8eF2LoHWbjO
         jtY5AgL8s37hLTRWkT+IuOpfrs1JRfJl0dOmOkuAd90RqeAcfxGWq+ce/qhJmWg+8ScN
         mge5h6tmbdB2zLopMLMukI8P9m3IagLtVusJr5IpnbXUy3J/4OM1kdhsuUb1bpwNOhaw
         53mQ==
X-Gm-Message-State: AN3rC/6lLogT3V1+1TXnUrrqFDD45lwPMboTqUNWOz/6k0RjwvGaD7gt
        ss7Z/kipU6mrw3KLLFgdi4WnXVqo9U4U
X-Received: by 10.99.126.23 with SMTP id z23mr7600819pgc.63.1493317626886;
 Thu, 27 Apr 2017 11:27:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 27 Apr 2017 11:27:06 -0700 (PDT)
In-Reply-To: <20170426231236.27219-5-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com> <20170426231236.27219-5-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Apr 2017 11:27:06 -0700
Message-ID: <CAGZ79kbsRv058PVwaWNtxKOH2LFnGk=VFTtt39FTqujkbz5E5A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] clone: add a --no-tags-submodules to pass
 --no-tags to submodules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> From: Brandon Williams <bmwill@google.com>
>
> Add a --no-tags-submodules which does for --no-tags what the existing
> --shallow-submodules does for --depth, i.e. doing:
>
>     git clone --recurse-submodules --no-tags --no-tags-submodules <url>
>
> Will clone the superproject and all submodules with --no-tags
> semantics.

My gut reaction to this is that it is ugly and maybe we should rather have
a --no-tags[=3D<repo-spec>].

We have had the discussion for e.g. git-push, for which we would like to
have a way to specify to push the superproject, or some submodules or
all of them, or just the superproject and changed submodules,
such that there we have a "git push --recurse-submodules=3D \
[check|on-demand|only|no]" which comes close to what I mean by
"repo-spec".

> This change does not implement a submodule.*.tags config .gitmodules
> configuration option corresponding to the existing submodule.*.shallow
> facility, which would make --no-tags have full feature parity with
> --shallow-submodules.

Okay, that can be added later if desired.

> Signed-off-by: Brandon Williams <bmwill@google.com>
> Code-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Commit-message-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> Git-Completion-Code-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
> Docs-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Tests-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Quite a lot of collaboration. ;)

> @@ -499,6 +499,8 @@ static int clone_submodule(const char *path, const ch=
ar *gitdir, const char *url
>                 argv_array_push(&cp.args, "--quiet");
>         if (progress)
>                 argv_array_push(&cp.args, "--progress");
> +       if (no_tags)
> +               argv_array_push(&cp.args, "--no-tags");

Here you would need to also push --no-tags-submodules to keep it recursive?

> diff --git a/t/t5616-clone-submodules-tags.sh b/t/t5616-clone-submodules-=
tags.sh
> new file mode 100755
> index 0000000000..3c88265352
> --- /dev/null
> +++ b/t/t5616-clone-submodules-tags.sh

Name is good as it describes the niche we're looking at.
(previous commit sounded as if you wanted to introduce
a plain clone-submodules.sh)

> @@ -0,0 +1,72 @@
> +#!/bin/sh
> +
> +test_description=3D'Test cloning of repos with submodules & the --[no-]t=
ags option'
> +
> +. ./test-lib.sh
> +
> +pwd=3D$(pwd)
> +
> +test_expect_success 'setup' '
> +       git checkout -b master &&
> +       test_commit commit1 &&
> +       test_commit commit2 &&
> +       mkdir sub &&
> +       (
> +               cd sub &&
> +               git init &&
> +               test_commit subcommit1 &&
> +               test_commit subcommit2 &&
> +               test_commit subcommit3
> +       ) &&

This can be written easier with

    test_create_repo sub &&
    test_commit -C sub subcommit1 &&
    test_commit -C sub subcommit2 &&
    test_commit -C sub subcommit3 &&

Most submodule code thought naming a submodule
"sub" was a good idea. I also wrote such code. But please
let's stop with this tradition. Name the submodule after your
favorite dish (that hopefully doesn't have "sub" in its name),
as it is much easier to read the test code when there are fewer
strings "sub".


> +       git submodule add "file://$pwd/sub" sub &&
> +       git commit -m "add submodule" &&
> +       git tag addsubcommit1
> +'
> +
> +test_expect_success 'tags clone implies tags submodule' '
> +       test_when_finished "rm -rf super_clone" &&
> +       git clone --recurse-submodules "file://$pwd/." super_clone &&
> +       git -C super_clone for-each-ref --format=3D"%(refname:strip=3D2)"=
 refs/tags/ >tags &&

Why do we need to strip the refnames here? Full ref names ought to be fine?
Specifically when testing in combination of single-branch (does that imply
any tags setting), I'd rather expect an rstrip and then counting refs/heads
and refs/tags.

Thanks,
Stefan
