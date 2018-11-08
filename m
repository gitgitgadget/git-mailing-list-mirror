Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B4B1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 22:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeKIILu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 03:11:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42056 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeKIILt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 03:11:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id h21-v6so224160edq.9
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cNqdB+ylS5EeB5Ha4bNqIP1QPUDs3d9wU4WElWsolF8=;
        b=cX3NV7fLhjpKTrnGRhUwkyyBvgM3lJE2FNvXe6a3daTqFC42NAR8oZebpB6Di/L6eN
         Gw47LfinKHcI4Ojz3QUdmHPp5r2yA/s296FKSWkTJRFA3zfmCyz0JBVkRaVJNqGaaZqF
         glJ8GWMedJNB3wFG+3mR3+Aj2liC2erVhaZqfTWrDo6NMrQQ8aK3iFxePNmPtDG+qN1M
         088LAjtyfHx0iSx1KuA6+QCEO5uoxMgsG/nJlEHFtNdJL3/Xs+7KlH8VsJFxpUhXtz9G
         HcfFHMNdTWEje8mW4eb8oU5vWmFmJZBk4/K/EGLij0Z9lPYgCByKRP9d6MUMFmvMGfbw
         X5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cNqdB+ylS5EeB5Ha4bNqIP1QPUDs3d9wU4WElWsolF8=;
        b=Mn9a+FKNY7ZrL493s2CBP7tn5Uh+xbNImKLzozOFjA4kqpvnPg7h0AsDP34KNw1jVo
         GlSKniD19467546YILzS9ujTyxylxCuoEKdTRii0leXC1MpfUyrDYmuLjJofqn7fcRQQ
         U2Wg1Y/aQGxXLhr9kvo92A5SwAo/OZhFNctsj6JrZgGKmm/x/j3cHchje3VcO3lpwmAO
         kqgu5rfwAjDvw/Xy5pLGwmAji93S34ZZg8n3LbUxBiINCqAY6cmKo67GJu2F79dB51kC
         OsACGRCzMvfFnf62N9sKsZ7dv9k9jdvaWCvElrNcfaY70a76JD4QXOsOPB7cyJ/K7y6d
         +eJg==
X-Gm-Message-State: AGRZ1gKMRpxoJXIaA69xe2phlR5VPz+nVTKIptNUurNjUB2b3Bkn3Wru
        HCuSPjslPvVFMVKvYcdxzu0=
X-Google-Smtp-Source: AJdET5e3Hh765laJKV+aZNRRh7f4BviKz7f36MfcIuRtVuDy18uSIsOIr2yPWp/0vXUX+C7GxmaqVQ==
X-Received: by 2002:a50:e442:: with SMTP id e2-v6mr207151edm.80.1541716448680;
        Thu, 08 Nov 2018 14:34:08 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id x17-v6sm760071eje.64.2018.11.08.14.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 14:34:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] range-diff: fix regression in passing along diff options
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet> <20181107122202.1813-3-avarab@gmail.com> <CAPig+cTeNcn_raJWfEK_C_du1v1KYQFTVmWA9B4DNHAXoFHw-w@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cTeNcn_raJWfEK_C_du1v1KYQFTVmWA9B4DNHAXoFHw-w@mail.gmail.com>
Date:   Thu, 08 Nov 2018 23:34:06 +0100
Message-ID: <87k1ln5hcx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 08 2018, Eric Sunshine wrote:

> On Wed, Nov 7, 2018 at 7:22 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> In 73a834e9e2 ("range-diff: relieve callers of low-level configuration
>> burden", 2018-07-22) we broke passing down options like --no-patch,
>> --stat etc. Fix that regression, and add a test for some of these
>> options being passed down.
>
> Thanks both (Ævar and Dscho) for cleaning up my mess, and sorry for
> not responding sooner; I only just found time to read the discussion
> thread. One comment below...
>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/range-diff.c b/range-diff.c
>> @@ -453,7 +453,8 @@ int show_range_diff(const char *range1, const char *range2,
>>                 memcpy(&opts, diffopt, sizeof(opts));
>> -               opts.output_format = DIFF_FORMAT_PATCH;
>> +               if (!opts.output_format)
>> +                       opts.output_format = DIFF_FORMAT_PATCH;
>
> Looking at diff.c:parse_diff_opt() and enable_patch_output(), rather
> than introducing this new conditional, I'm thinking that a more
> correct fix would be:
>
>     opts.output_format |= DIFF_FORMAT_PATCH;
>
> (note the '|=' operator). This would result in 'opts.output_format'
> containing (DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT), just as it did
> prior to 73a834e9e2 when --no-patch was specified.

Maybe I'm misunderstanding, but if you mean this on top:

    diff --git a/range-diff.c b/range-diff.c
    index 488844c0af..ea317f92f9 100644
    --- a/range-diff.c
    +++ b/range-diff.c
    @@ -453,8 +453,7 @@ int show_range_diff(const char *range1, const char *range2,
                    struct strbuf indent = STRBUF_INIT;

                    memcpy(&opts, diffopt, sizeof(opts));
    -               if (!opts.output_format)
    -                       opts.output_format = DIFF_FORMAT_PATCH;
    +               opts.output_format |= DIFF_FORMAT_PATCH;
                    opts.flags.suppress_diff_headers = 1;
                    opts.flags.dual_color_diffed_diffs = dual_color;
                    opts.output_prefix = output_prefix_cb;

Then the --stat test I've added here fails, because unlike "diff" the
"--stat" (and others) will implicitly "--patch" and you need
"--no-patch" as well (again, unlike with "diff").

Right now --stat is pretty useless, but it could be made to make sense,
and at that point (and earlier) I think it would be confusing if
"range-diff" had different semantics with no options v.s. one option
like "--stat" v.s. "--stat -p" compared to "diff".
