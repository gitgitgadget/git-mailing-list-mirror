Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2F1C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 23:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhKVXbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhKVXbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:31:11 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5401C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 15:28:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x6so71806224edr.5
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 15:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dKAdxZDlEITLLZyuxy8HLL4SaTNXVhQ2IPAgKR2/2q4=;
        b=DWDfE5pCxZouAKVgPqOWBJJQTTxKDSLysTCvvLz2fsUuhP4s7sMUOO0M7+A0I02jTJ
         /bv5YovZAvUGAG0F6o4ggyvJ/1y0Aj+Jvmv2onB7fLzqUiw6P7Za+qTH5rzTy3Y0IOjw
         KSnIWCZ1rGBcUIuLPnT+n7BlF6hOzMeuJLe4uprYTGghhAYn6zt8F2AoiWDYkVUyRgfl
         Rd7/LYY+nSE4/qoEdHR7xYKafRxIQuE8z1dJzzurKusR9Gsj0jQI+JK1DleM7KsSkr62
         0car23z/zN8bt+67TVRAMVNye2SRkbYGZEaQcMgY9RICZu+SmyiKePEvgYv8GFLq6u2O
         ZpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dKAdxZDlEITLLZyuxy8HLL4SaTNXVhQ2IPAgKR2/2q4=;
        b=AAcDCQZrZIeux7mch+OwZ7xTSL9p9FcKvTGL0quUHNrkrgk0cXzH+fq48pNS6yNNxn
         004nJLW5sCTC+r+/virVYKnjFSyeNG2Wx4ZAHoXhpIW0akXUX8SpXo+IS+k2BNInjejQ
         6RqOJBA9MQXEgQcL+zOvTMGtdvnrRjHdOAP9TU9C8Ko95Bbe+Bt8IAyyxTQ+9D1bCAVr
         EcpUiC9edBc0EijZzK1g4cs3NTWQR5ZFNgmMUsoCQiumRzSyh1En981gpRSWvG2QQYy4
         GDwvItkrpN23cjRluGsKCb8FbqdZoL63p1LwH0qBEiiOiR84gl/U0PYzxK6DlKjLGYNl
         3faQ==
X-Gm-Message-State: AOAM532SGT7Kjzs2tvvEoNv/gM9aavmsV3BcxiTG/hlAkwz0j70cMiHO
        M73hj+C3l7WNUrLYGPStW/s=
X-Google-Smtp-Source: ABdhPJwSY8v7O9S5QdTqxKl6yFl0UWgboTsJ0Ax1xN4SKVu2aoglPAyZp0+EdvHQPnL3RvxjG78ndQ==
X-Received: by 2002:a50:ee96:: with SMTP id f22mr1477395edr.77.1637623682176;
        Mon, 22 Nov 2021 15:28:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cw5sm4584706ejc.74.2021.11.22.15.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:28:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpIjB-001DWS-Ay;
        Tue, 23 Nov 2021 00:28:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup??? Merge branch 'ab/ci-updates' into seen
Date:   Tue, 23 Nov 2021 00:12:24 +0100
References: <pull.1081.git.1637578930464.gitgitgadget@gmail.com>
 <211122.86ee78yxts.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2111222257430.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111222257430.63@tvgsbejvaqbjf.bet>
Message-ID: <211123.8635nnydmm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Mon, 22 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Nov 22 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>> > index c0bae709b3b..c508c18ad44 100755
>> > --- a/ci/run-build-and-tests.sh
>> > +++ b/ci/run-build-and-tests.sh
>> > @@ -45,9 +45,8 @@ linux-gcc-4.8)
>> >  	export MAKE_TARGETS=3Dall
>> >  	;;
>> >  esac
>> > -make -C contrib/scalar test
>> > -
>> >  make $MAKE_TARGETS
>> > +make -C contrib/scalar test
>> >
>> >  check_unignored_build_artifacts
>>
>> The CI breakage was introduced with the merger with ab/ci-updates, but
>> the combination of the two just reveals an existing breakage in
>> js/scalar.
>
> Which shows that I was wrong to pander to your repeated demand to include
> Scalar in the CI builds already at this early stage.

Us finding an a bug in a topic that's happening outside of CI means we
shouldn't have added it to CI in the first place? Isn't spotting these
issues a good thing?

What I'm pointing out is that this isn't an issue that happened because
of the merger with ab/ci-updates, but merely turned into a CI failure
because of it.

Before that in your initial patch to integrate it into CI[1] the
relevant part of the patch was, with extra context added by me:

    [...]
       linux-gcc-4.8|pedantic)
               # Don't run the tests; we only care about whether Git can be
               # built with GCC 4.8 or with pedantic
               ;;
       *)
               make test
               ;;
       esac
       make test
       ;;
     esac
    +make -C contrib/scalar test
=20=20=20=20=20
     check_unignored_build_artifacts

I.e. it added scalar testing to the linux-gcc-4.8 & "pedantic" jobs,
which are meant to be compile-only.

The other issue is that the "test" Makefile target in
contrib/scalar/Makefile attempts to build the top-level from scratch,
but fails (which is how it turned into a CI failure). The same thing
happens when running it outside fo CI.

I don't think I've been demanding that you do anything. I have been
asking if there's a good reason for why we wouldn't test this code we've
got in-tree. Your commit[1] states:

    Since Scalar depends on `libgit.a`, it makes sense to ensure in the CI
    and the PR builds that it does not get broken in case of industrious
    refactorings of the core Git code.

Which is rationale that I entirely agree with, the only extent to which
I don't is that I don't think it goes far enough, i.e. shouldn't we also
add this to "make test" and not just CI? Why shouldn't I see failures
locally, and only when I push to CI (unless I go out of my way to run
the tests-like-CI-would)?

In any case, both of these breakages are present in your version of the
version of the patches, but not the change I've been proposing on-top to
add it to CI and "make test". You've also refused to talk about why you
insist on that particular approach, which is shown to be more fragile
here. So it seems rather odd to blame my suggestions (or "demands") for
them.

1. https://lore.kernel.org/git/1b0328fa236a35c2427b82f53c32944e513580d3.163=
7158762.git.gitgitgadget@gmail.com/

