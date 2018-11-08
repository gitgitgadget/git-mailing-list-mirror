Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD271F453
	for <e@80x24.org>; Thu,  8 Nov 2018 03:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeKHM5h (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 07:57:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53976 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbeKHM5g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 07:57:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id f10-v6so3853641wme.3
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 19:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lklwV4UOZRRVzJIEVm9GGpuvkoUB30GMn+7xgnN6qnM=;
        b=DlFTDvF5Ym5gzLutfObtcL+lC/zKvbZoHVUo/2iMSxPAsPJ6j6B4PuDFcut0QrXRrT
         Psz8EPbzobxxG+48CqKXVwPadoWTOfX7jakq5XqQrbUz8pMzhfw4cus2xLhlO3m7XJI1
         nG4+9gOX8BXltTCmX0HfLQpQ/5gz5a8lg5jatH5Eo4pgXfa46yoQURym7ZwFiTFZNRgG
         K4amgob0jT5htHP1zyWjWU7AjoINcTFp07BPSGCCezxNaQRxNN1RgX+VBUNZugDeyjfl
         JNF/uypbR1u8wbRhKE8FHNrYf73NrgBUf9J9cR76pzuP2Zd+a6N6OKF5aFVcJK7AUW93
         O6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lklwV4UOZRRVzJIEVm9GGpuvkoUB30GMn+7xgnN6qnM=;
        b=QmRYA2KpiKtBUI8aqtl66E72o6/8JocaKfprkRhUtRz6lelQyvEHcpt+xVLyp2U3k1
         7biFl+joZWEtpj0IUveszumvQ267UvGVqL6lQezO/JP5z9hRfoEGVimLBfpf699QFUdg
         XfcZsLOTm/z5wZm329IWcHXMPk7nxWXVeVEgVqw3PY+4v4CKfclk/WXthNTGk/eWChj9
         C46ke+I+k2fRzbV99Zros2Y0Qa6dgVxteIZ+GcdfB32L/IhmpNKNtmN6WlzWHvLPHmVD
         bGzx6dX6/h6lexMlA1x9xvhw6Qc80Wy5KS4bAQSu67Cz/4q6HpHfn77MJYu2xfxH4hU2
         IkLg==
X-Gm-Message-State: AGRZ1gJW9vBUZgSeHdTgNkCyKaagpf7Kv027UYqlw9yJSb2Yv2/UvYqK
        1dEwbQsgkMCguMWZ2psES+w7vigkxPQ=
X-Google-Smtp-Source: AJdET5ctum8UFmPEw0c8pew41t9xOKTAlK207KDZN8zRiJLTzhJkDbQF/t32uoD1+qtoa0Kb3Z5yDQ==
X-Received: by 2002:a1c:c502:: with SMTP id v2-v6mr2038818wmf.17.1541647452785;
        Wed, 07 Nov 2018 19:24:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j18-v6sm5791342wmf.39.2018.11.07.19.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 19:24:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v3] i18n: make GETTEXT_POISON a runtime option
References: <20181024114725.3927-1-avarab@gmail.com>
        <20181101193115.32681-1-avarab@gmail.com>
Date:   Thu, 08 Nov 2018 12:24:08 +0900
In-Reply-To: <20181101193115.32681-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 1 Nov 2018 19:31:15 +0000")
Message-ID: <xmqqpnvg8d5z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  * We error out in the Makefile if you're still saying
>    GETTEXT_POISON=YesPlease.

I expected this would be irritating, but it turns out it is worse
than mere irritation but is a severe hinderance to affect my
performance, as I (and my bots) keep building and testing different
versions of Git under different configurations.

I know it was done to help those who only ever build a single track
at a time and mostly moving forward, but I'm very much tempted to
remove this part, perhaps demote it to a warning of some sort.


>  ifdef GETTEXT_POISON
> -	BASIC_CFLAGS += -DGETTEXT_POISON
> +$(error The GETTEXT_POISON option has been removed in favor of runtime GIT_TEST_GETTEXT_POISON. See t/README!)
>  endif

-- >8 --
Makefile: ease dynamic-gettext-poison transition

Earlier we made the entire build to fail when GETTEXT_POISON=Yes is
given to make, to notify those who did not notice that text poisoning
is now a runtime behaviour.

It turns out that this too irritating for those who need to build
and test different versions of Git that cross the boundary between
history with and without this topic to switch between two
environment variables.  Demote the error to a warning, so that you
can say something like

	make GETTEXT_POISON=Yes GIT_TEST_GETTEXT_POISON test

during the transition period, without having to worry about whether
exact version you are testing has or does not have this topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f3a9995e50..6b492f44a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1447,7 +1447,7 @@ ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
 ifdef GETTEXT_POISON
-$(error The GETTEXT_POISON option has been removed in favor of runtime GIT_TEST_GETTEXT_POISON. See t/README!)
+$(warning The GETTEXT_POISON option has been removed in favor of runtime GIT_TEST_GETTEXT_POISON. See t/README!)
 endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
