Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD29C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiCAKAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiCAKAN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:00:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6C57155
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:59:32 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s24so21264332edr.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 01:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gWIkNow0ySiwa+h5WF7mjSIBRoti/2viwOXWzDfRLsI=;
        b=rg27UjTaXw7wdDcVEiAV7zH5XfGcU4h1sYnjpbbum7xk3LA+jI0+A52Geh4IXtd6ha
         6oIpiDhw8h/QVCSIEBuFuHciRVpY6YiBYcFzALrA1FwQbSxMNrCCMOlSL7dHrrWMNDVV
         r6jA8ZwGCTlPGpRujG4fEZ8y6rbAnqZhTuO5omElrWPFRu8evWIv/qPSk69zO0AFPmIf
         WZ7mZknrBycw7v+QhANhk7gy+fh49HqppjswfDiAktCysPLHH0KmMXDEXeU9ccEnWNJN
         oAvRhtwi80wLpoXp0kkp0lI3Cx7X1iPKIOLcMxHiyTcSGqO2HJ0Xd8wkAzFQSfeOFTI5
         YF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gWIkNow0ySiwa+h5WF7mjSIBRoti/2viwOXWzDfRLsI=;
        b=0BciJQazqGsTdOxLZblxshn43svxYmsi4QKoy5q4iRnTS11PSjLSSz1WCtX2y4/dtv
         bdyBMaWwPDhFnRmgPDC56+Be5eK/Bg8HekMEM93i1wBryAi8F0cwRW+2L5/79ldWWdVb
         QvL6aXUW4UP+VPIAPIG5H5TkWCxRjqYGP+0aiFd8mXUmDbrwM3Nqcvha73gwGJXnssPu
         gx5+iBZdm7wTTOwfMU/lv0JpsL6sE2I7dh4wjfkDjDwL4JuUSEqZHyz1NB13KJVv9fYJ
         dOzCXw1AiutYb9deinkJ+Uzm4bdiJ+1u7S9xVAsHQj+H9kRmzLY9SQ4BQUVLankx3mOZ
         N5Dw==
X-Gm-Message-State: AOAM531tnxvekr+HsaX2zVmb1sRWc5FiAf7nd2buvMQV1uZ1P8XOx67l
        6aTIGh4aZp10w17XTJxw71cuA1Sxa3n5HI+uQ/etnaRZ+wy9AZ6S
X-Google-Smtp-Source: ABdhPJzH1Fj4ox7oNXKijS01Lqiw/NG7PeoIwYcKsqPfIC4iktugMRz4lvpv6qkRtBAgUuicAxt9ynIGSCPpNtHrFeY=
X-Received: by 2002:a05:6402:528e:b0:407:80ff:6eed with SMTP id
 en14-20020a056402528e00b0040780ff6eedmr23628738edb.165.1646128771309; Tue, 01
 Mar 2022 01:59:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
 <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com> <d5b18c7949fdea966d31b2b8ca3f8aa8ed3a86b6.1646032466.git.gitgitgadget@gmail.com>
 <220228.86o82r5nzm.gmgdl@evledraar.gmail.com>
In-Reply-To: <220228.86o82r5nzm.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 10:59:19 +0100
Message-ID: <CAPMMpogv995t102biwYVCcvTTdF7beXNMorn3KyWceuRcbAZPA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t3200: tests for new branch.autosetupmerge option "simple"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 10:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Feb 28 2022, Tao Klerks via GitGitGadget wrote:
>
> > +test_expect_success 'simple tracking works when remote branch name mat=
ches' '
> > +     test_create_repo otherserver &&
> > +     test_commit -C otherserver my_commit 1 &&
> > +     git -C otherserver branch feature &&
> > +     git config branch.autosetupmerge simple &&
> > +     git config remote.otherserver.url otherserver &&
> > +     git config remote.otherserver.fetch refs/heads/*:refs/remotes/oth=
erserver/* &&
>
> Shouldn't these use test_config, or if the tests below need them do that
> via a helper, so later added tests don't need to reset this state?

Yes, I will look at this; I was naively (and clearly incorrectly)
following a pattern I saw in this same test file.

>
> > +     git fetch otherserver &&
> > +     git branch feature otherserver/feature &&
> > +     rm -fr otherserver &&
>
> Instead of "rm -rf" after, do above:
>
>     test_when_finished "rm -rf otherserver" &&
>     git init otherserver
>
> (you don't need "test_create_repo" either, just use "git init")

Will do, thx!

>
> > +     test $(git config branch.feature.remote) =3D otherserver &&
> > +     test $(git config branch.feature.merge) =3D refs/heads/feature
>
> Use:
>
>     echo otherserver >expect &&
>     git config ... >actual &&
>     test_cmp expect actual
>
> etc., the pattern you're using here will hide git's exit code on
> segfaults, abort() etc., and also makes for less useful debug info on
> failure than test_cmp.

Again, thank you! (I will look at test_cmp_config() as Eric suggested)

>
>
> > +'
> > +
> > +test_expect_success 'simple tracking skips when remote branch name doe=
s not match' '
> > +     git config branch.autosetupmerge simple &&
> > +     git config remote.local.url . &&
> > +     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &=
&
>
> ditto config setup above, this is quite hard to follow in sequence since
> yo uneed to reason about all existing config. Let's start with a clean
> slate for each test_expect_success and setup the specific config we want
> instead.fallow since
>
> > +     (git show-ref -q refs/remotes/local/main || git fetch local) &&
>
> This likewise hides segfaults etc. Use:
>
>     test_might_fail git show-ref ...
>
> But maybe this whole thing should use "git rev-parse --verify" or
> something?

Honestly, I think this bad pattern is just a premature optimization against
a pretty-fast local fetch. Will simplify, and do the same for existing
patterns in this file.

>
> > +     git branch my-other local/main &&
> > +     test -z "$(git config branch.my-other.remote)" &&
> > +     test -z "$(git config branch.my-other.merge)"
>
> ditto test_cmp comments, but here:
>
>     git ... >out &&
>     test_must_be_empty out
>

OK, will look, thx.
