Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AED21FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 12:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755728AbeARMsW (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 07:48:22 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:41865 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755155AbeARMsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 07:48:21 -0500
Received: by mail-oi0-f49.google.com with SMTP id n81so15582035oig.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 04:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W6aRbuBsYDerpNapLNAjA9zQU69/bwIwKQ/F1OaxFAI=;
        b=C3qZpL7+K4HFT1HTL+x+WLF2lFUxCo8a/uRaPENGsRGsDUlOq1K3eYdxTfIvFstkPW
         xu4k+8D9EPfWtzrST3KOhzv8ukUjcOhucDjum1K16f+PZb/RnYuuPfxgsLUSDVXqsILe
         LvH1EYIIyW0dJse4IR60RhwjdEAgQeU3NoradH+Rl68N96D+SvLpsl0abrpa9MZiKt4n
         a2Xg0Kf41188CtXoW/4t+HiVaG1Z+fwyRzR8IJ2Jfz2aNvgKz1Racw/eNyUyyzRBB/Zc
         svHs4IMxLHngarcz/ItbugljU3QzhQ9U8PyPep/DRY3cvmHOXfvE+jtSO5qsMi0PR18I
         2Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W6aRbuBsYDerpNapLNAjA9zQU69/bwIwKQ/F1OaxFAI=;
        b=IeypmoEAzHZiEVlUP2S0RbvQOmvB6mzGTBMoByuC/Byt3jwKcixmHCEwAs3M13u6c8
         iC/icWmxiCMP/ubABNi9caG92sD+WVd8K/VpyWGk+93m5fxgQkJQvrg7PKgGL5wlVl4p
         Mf96U4E6H9G/9FczqDJAVkhSLvN3OatW/38m4T+9pu6/zNA/sOJ47YOu3XJgt6tvvpnd
         kPBWRrTj/d6iM9HY6boHL+fThBaffam/MxOKP4q+dlKiNZpmX9BYe+DSVyJddvmBrDQV
         oirtQUntnyBrSAf6+twrEOANocNOA62119m+FKI072SGX/jxqptQAWlm1iib6fB7sLW8
         0VGw==
X-Gm-Message-State: AKwxytdZgTRWfKMLA/hqJ+l5NQvbYkLWJOWoG+LElbn1VRC+gBPpOkLp
        36GZ39HkgKtD6LtfpixzVoYbfNHDosg7hQBbBvU=
X-Google-Smtp-Source: ACJfBovjz/bW6HJkkvf1reuvHyd1d2wBYJPcjgYEBhMCV6/i+pA5v8ItRTthKzQQ3tnvx5B+VqqUzJML4FFj2LHewg4=
X-Received: by 10.202.81.212 with SMTP id f203mr2928825oib.117.1516279701189;
 Thu, 18 Jan 2018 04:48:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Thu, 18 Jan 2018 04:47:50 -0800 (PST)
In-Reply-To: <CAM0VKjmGo5gjUBpTQp9M+pvZzBMDAmYYCu-5VfG-8LYRxU7i0Q@mail.gmail.com>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com> <20180114101820.4273-3-pclouds@gmail.com>
 <CAM0VKjmGo5gjUBpTQp9M+pvZzBMDAmYYCu-5VfG-8LYRxU7i0Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 18 Jan 2018 19:47:50 +0700
Message-ID: <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 6:36 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> This series, queued as 'nd/shared-index-fix', makes the 32 bit Linux
> build job fail on Travis CI.  Unfortunately, all it can tell us about
> the failure is this:
>
>   Test Summary Report
>   -------------------
>   t1700-split-index.sh                             (Wstat: 256 Tests: 23
>   Failed: 1)
>     Failed test:  23
>     Non-zero exit status: 1
>   Files=3D809, Tests=3D18491, 401 wallclock secs ( 7.22 usr  1.60 sys + 2=
63.16
>   cusr 49.58 csys =3D 321.56 CPU)
>   Result: FAIL
>
> because it can't access the test's verbose log due to lack of
> permissions.
>
>
>   https://travis-ci.org/git/git/jobs/329681826#L2074

I may need help getting that log (or even better the trash directory
of t1700). I tried -m32 build, then valgrind on amd64 (because it
didn't work with my 32 build), running the tests with dash and even
the linux32 docker version that comes with "ci" directory. Everything
worked for me.
--=20
Duy
