Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5B920D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 23:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbdFAXa1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 19:30:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36183 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFAXa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 19:30:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so9551823pfb.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8uNxmGlLzLsWFfcfOAxOZ2Pw5RB7uowFvXSb02C4Xdo=;
        b=oxfgbOvSTO1CAyyH0sZjukdjwc5CKsX4EDAFWHqBdhASqYfQnTtcINZ3MXwHL6nePO
         IV2THUm/yhgfM7LcMYGi4+h6w7gfyCMZ5+mmRYpmzxW3rO30l+HdOH7wwyMe7UQnWlhV
         /jPOWfphN976BVpUUf8u7IrW6NZyLsF/w63YxAdfU8WfA/8l0QLdAwvDEUcmqR8dSG/u
         Y1R3bir8gDv1O9vSxmX6/478O5nxqq9m2RZ+hytv9CwduypJXX0c1DmbubIwvLU22fT1
         hjVxbSgdtTe00JM4EG7HcR4uTX/G6oOxmAqf0CsAMoE0bEHZusMFeBDR+5F1eTGahHHI
         rYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8uNxmGlLzLsWFfcfOAxOZ2Pw5RB7uowFvXSb02C4Xdo=;
        b=q9k+ZnM/iUDIjB83KZuAhhg2+LFRAVmLAKh1PjbrgJhCZzRjgD4/ei2Sc3aVZVrak2
         z4OYsNUZrHvULvGwjUtXoB8Cop3WvsQhdfeCdsfvopwd+j0sVR1mD9l/keNsYKXjMtI9
         PTezTDmm8hs3pVRQwy7PHL1IKCHhp7uAUk0xrv8PdTjR+9vKPbJmXC8xbdonke8a39up
         bPGFnCv1U2LfeoEdIzGxLx8P+ubbFg2Y5QHu2M/YO7f7jkjRbrSuC8Kb2g7Hk0d2xikg
         rHyGH33t5daK03Zq80Fz2ldb1cEYN4prOQo7Uj4fYtSZD+0Rk3Ux4v8WOcBY7zIcO538
         h7Jw==
X-Gm-Message-State: AODbwcCGwnlIJ58h/a7wtdTPVdgeUZPd5cCEPe8PxL4JoXIaDvjLdf9P
        5Zmddho7lzehPg==
X-Received: by 10.98.9.91 with SMTP id e88mr3546622pfd.177.1496359825910;
        Thu, 01 Jun 2017 16:30:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id f1sm30260806pgc.8.2017.06.01.16.30.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 16:30:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/8] PCRE v2, PCRE v1 JIT, log -P & fixes
References: <20170601182056.31142-1-avarab@gmail.com>
Date:   Fri, 02 Jun 2017 08:30:24 +0900
In-Reply-To: <20170601182056.31142-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 1 Jun 2017 18:20:48 +0000")
Message-ID: <xmqqbmq74773.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> See <20170525200528.22037-1-avarab@gmail.com> for v3
> (https://public-inbox.org/git/20170525200528.22037-1-avarab@gmail.com/).
>
> This is on top of "[PATCH v4 00/31] Easy to review grep & pre-PCRE
> changes".
>
> Changes:
>
> Ævar Arnfjörð Bjarmason (8):
>   grep: don't redundantly compile throwaway patterns under threading
>   grep: skip pthreads overhead when using one thread
>   log: add -P as a synonym for --perl-regexp
>   grep: add support for the PCRE v1 JIT API
>   grep: un-break building with PCRE < 8.32
>   grep: un-break building with PCRE < 8.20
>
> No changes.
>
>   grep: un-break building with PCRE >= 8.32 without --enable-jit
>
> NEW: It turns out that a PCRE version that supports JIT, but is built
> without JIT support will fail at link time since there's no
> pcre_jit_exec symbol.
>
> It also turns out (contrary to what I claimed on list before, my
> mistake) that there's no way to detect this through some macro. All
> the pcre include files are the same with/without --enable-jit, only
> the object file differs.
>
> So there's now a NO_LIBPCRE1_JIT flag to the Makefile, which is off by
> default, but turned on on MinGW. I have not tested that
> config.mak.uname change, but everything else I could test on Linux.
>
> The reason for why it's NO_LIBPCRE1_JIT not USE_LIBPCRE1_JIT is that
> in practice pretty much everyone who builds pcre builds it with JIT
> (I've looked through various Linux/BSD distro build files), it's MinGW
> that's the exception here. Given the performance gain it makes sense
> to make it the default.
>
>   grep: add support for PCRE v2
>
> Almost no changes, just:
>
>  * A trivial change to stop redundantly assigning to pcre2_jit_on,
>    mistakenly left over from an earlier version.
>
>  * Updated commit message / perf numbers for the extra patches in the
>    series both here and in v3.

Nicely summarised and matches what I received; thanks, will replace.
