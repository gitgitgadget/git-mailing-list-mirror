Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC2A1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 04:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbeFAEQb (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 00:16:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40908 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFAEQa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 00:16:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id x2-v6so309881wmh.5
        for <git@vger.kernel.org>; Thu, 31 May 2018 21:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7R0wesfW4HpBLsIm1mgqf5xy9tiUxr71dJVA37x6cHw=;
        b=UQiG6FdhDu4wjIw6FASmFWg0lxDx7BI5DfFefTh68WK0ztcoWBJ3/xau1GyE4OWhHJ
         RKojCO7blQqwBiJf50iM4bkAunbxoPLzcBSTK0cNTw15ReCu9Ja4qfDsOhdtao1HljB3
         BoaGybgorID4HIslYf88JFrp7yUy4zLCRS+mhDq1DJXOByzJaQd3PhOwFpmQtnzaIh9X
         QuJR0CvRx1aKCtnGlAWEdn1VhCbSSN6wrf4hQwrP+dDpwEp3V1Zf1tMSV+uD48UAzM/Q
         fmV0s8wuWnMecH5Adu4AMKigExVl2M1CYEgUTTz3m5ke8XIFmNsrPufpciYkRphV7rUI
         iWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7R0wesfW4HpBLsIm1mgqf5xy9tiUxr71dJVA37x6cHw=;
        b=Wrfim8X9RuPMopK3Fr1IKb1jigd41SrLqrE3mI8O1r1iwoAzuiFfiFJwJ3do2yxflP
         WTno+tujB3wwxXvFdhmqCFnpHvc2QrQ/w8KlgFHeB1Nm1AeDAFkqmtHkHNWTkxChznwO
         qbZI/ZV/dl5TFQsB+6jNaH43IIsfV9wWPPEsTHeQekT0shgGuf4CnfEf+0Qi9rHq8fFt
         owlRRUMnXwOT36OWlMjDtecA8DCQQrLVzbI9aQ2kMH5AuyOceFKKXxmyZ+fEydFrrdXG
         9ihGmsKpcLWh3FN5tgwhLSuyuWb2DGKnIrFGotIDLXYtwXqH4DA/Md4pRL2eJYtNOonK
         dlVw==
X-Gm-Message-State: ALKqPwcTuX2nkIqIcJYldB+vWAft6LJEy8GpY8RtkE8HLtR+mzPH/RDT
        IH8sNGNr65pxX38p0H1+4wlO54tC
X-Google-Smtp-Source: ADUXVKK7GDQ1PHzxd+RGPJRZFn+0nfucueiqTAml81ybHh05dkpnXrfL+DzZEx9JTI9Y6YjiUtOclg==
X-Received: by 2002:a1c:aac3:: with SMTP id t186-v6mr1498945wme.14.1527826589371;
        Thu, 31 May 2018 21:16:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m58-v6sm28436114wrf.61.2018.05.31.21.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 21:16:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/9] checkout.[ch]: introduce an *_INIT macro
References: <20180531195252.29173-1-avarab@gmail.com>
        <87a7sg9sjz.fsf@evledraar.gmail.com>
        <20180531195252.29173-5-avarab@gmail.com>
Date:   Fri, 01 Jun 2018 13:16:28 +0900
In-Reply-To: <20180531195252.29173-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 31 May 2018 19:52:47 +0000")
Message-ID: <xmqqsh6787kz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add an *_INIT macro for the tracking_name_data similar to what exists
> elsewhere in the codebase, e.g. OID_ARRAY_INIT in sha1-array.h. This
> will make it more idiomatic in later changes to add more fields to the
> struct & its initialization macro.

Makes sense; Thomas's comment on 3/9 still stands at this point, as
we have no outside users of the definition of the callback data yet
at this point.

>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  checkout.c | 2 +-
>  checkout.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/checkout.c b/checkout.c
> index 8d68f75ad1..629fc1d5c4 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -25,7 +25,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
>  
>  const char *unique_tracking_name(const char *name, struct object_id *oid)
>  {
> -	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
> +	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
>  	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
>  	cb_data.dst_oid = oid;
>  	for_each_remote(check_tracking_name, &cb_data);
> diff --git a/checkout.h b/checkout.h
> index 04b52f9ffe..a61ec93e65 100644
> --- a/checkout.h
> +++ b/checkout.h
> @@ -10,6 +10,8 @@ struct tracking_name_data {
>  	int unique;
>  };
>  
> +#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
> +
>  /*
>   * Check if the branch name uniquely matches a branch name on a remote
>   * tracking branch.  Return the name of the remote if such a branch
