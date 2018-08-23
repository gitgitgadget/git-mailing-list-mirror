Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85C41F954
	for <e@80x24.org>; Thu, 23 Aug 2018 16:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeHWTi5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:38:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35027 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeHWTi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:38:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so5108465wre.2
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KPmSQwKfcBLbtebY5p2kVdAm+1RFVo1SUwGhsdibxEU=;
        b=ByQ0SOBSMwKMw2Ej6feAYaHP2VhNohCexOWGf+ddl3G2g6RmchRQWNtxpP66puhSac
         /NytUa0f6vB/4qgDxc2bbfDFUIG2DNKHEd6rsOJuvUPQsU0ToNw5xjvK9Y78QZ/pByRa
         DOyQyfGaiJ/8CRkhs7Yq97Ua+fpg3yFV3FTG/noejhSnTZYrI6nZ8OG6FgqiII6LDZqq
         5jCaxTgK6TnKpoEC07/RB+c7Zd/rsaTQjSPtfD7oUN33IXbXFyaF/HBt+1+doIqKZO9c
         1/5rN+YW1Jn1Beg0dsD+AbkPhOaHpI8bjfCP0Ch2ceNwhtKXnQecIQBA0e+77RHZuahZ
         VISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KPmSQwKfcBLbtebY5p2kVdAm+1RFVo1SUwGhsdibxEU=;
        b=q5GSrmxn3PoODRm+PeyfouNi7AcxolSP/1gpkZaT/0DLM81KX0grc/pwYJs/Fab7rG
         Iqd4cvA0Ft2LGN4hJ5TOo6BOj+FRZ49YYpWw/GyYgt8Qka8DebQtdphpkaCed8BASg8X
         Qk6OzHMoUNwgK2zF6KVGM7d73qtm5owh9n4z5k3z6WzTHt/dhVV6Cj24MZ/hK2vdMVV7
         UfwNPZeMnovPdaIbHEHdx9eAOuOArPjnuqnaeWIgMIUooVo0KhGfKpN5jfP3J3UfZVKY
         11IU0xWPs51s1GGLwd2ff5vKlfvx71ulydRtZa9/svAxLtilBbEJIFa1PE0Pg9kBXA5r
         QrMw==
X-Gm-Message-State: APzg51A9mJB3+L+9ojCj2sp0Kht0igJpGitJ1Pm4ogvsYpDfEa1iM+sY
        927Ah27czh+71l9y6/vGhSY=
X-Google-Smtp-Source: ANB0VdaP1uGe7MDZpbAbldvBF7I0JCxS6C4j32eIESceY8ftjhOTK0JIukL/8x2pj9JduIe1gZYGPQ==
X-Received: by 2002:a5d:6604:: with SMTP id n4-v6mr2767445wru.281.1535040514681;
        Thu, 23 Aug 2018 09:08:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o33-v6sm9650470wrf.11.2018.08.23.09.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 09:08:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org
Subject: Re: [PATCH v2 2/2] tests: fix and add lint for non-portable seq
References: <20180823091427.1756-1-avarab@gmail.com>
        <20180823152502.3886-2-avarab@gmail.com>
Date:   Thu, 23 Aug 2018 09:08:33 -0700
In-Reply-To: <20180823152502.3886-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Aug 2018 15:25:02 +0000")
Message-ID: <xmqqefepjcam.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> GNU seq is not a POSIX command, and doesn't exist on

s/GNU //; the command did not even originate there, but came from V8
and/or Plan9 IIRC.

> e.g. OpenBSD. We've had the test_seq wrapper since d17cf5f3a3 ("tests:
> Introduce test_seq", 2012-08-04), but use of it keeps coming back,
> e.g. in the recently added "fetch negotiator" tests being added here.
>
> So let's also add a check to "make test-lint". The regex is aiming to
> capture the likes of $(seq ..) and "seq" as a stand-alone command,
> without capturing some existing cases where we e.g. have files called
> "seq".
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> Now with a fix & check in v2 for the seq issue mentioned in
> https://public-inbox.org/git/87a7pdfltp.fsf@evledraar.gmail.com/

Thanks.

>  t/check-non-portable-shell.pl        |  1 +
>  t/t5552-skipping-fetch-negotiator.sh | 12 ++++++------
>  t/t5703-upload-pack-ref-in-want.sh   |  4 ++--
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index c8f10d40a1..75f38298d7 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -42,6 +42,7 @@ sub err {
>  	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
>  	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
>  	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
> +	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';

Looking at $(wc -l) thing a few lines above, I am not sure if this
deviation is a good idea.  Wouldn't /\bseq\s/ be sufficient?

