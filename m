Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753A31F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 08:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeCQICF (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 04:02:05 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37594 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeCQICD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 04:02:03 -0400
Received: by mail-ot0-f195.google.com with SMTP id t2-v6so3395049otj.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XR9IqG1TpkS+eI+0KJvRIwbZTj3s7mUpOijnixaUAtk=;
        b=MER0zqaRtmUJvHoC2Yq/Em29812Dys88iWxSAPHvi3N60cCU/1TXk6gwfT4nPR1uNg
         A4+JKcDhTEMkp60vuWc6jTJAo0L8afF/6hepJClAVEgfWZQUr4Nol47QGjUWavqilC9y
         GrCJPdN8IdJcwuKJdjnvG2V+rJImS1kByA7zCeRxVBnZwcrM+sSmej5SuNUVi0+0doKx
         JqonHZzSWJaDM3/SRB4eufg+OrTDFxI9s8QXAOf9mVGASsKM/Pfl4Bv5ge4vVPrLrPiO
         oMlE5LsaiL9LMg8NdckC7hGU1f7h9koU+LstQnf7pQpUxuFpnfx/2HIygWx4lqIBqYhf
         NunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XR9IqG1TpkS+eI+0KJvRIwbZTj3s7mUpOijnixaUAtk=;
        b=b0ng8n1nlH3atBmiG2psB6n3Dl7DdT3dUenm2BQp7paj5KkFGCsoAyXuUpDzrfaW5k
         88PG4O+hb5w5sgXyB0upaaDPxQNIYT0r/OLzI4FB3mKAY07K7/VcotCTxOw3tKko4H4T
         Tltubzvo+QA+0Pqppk6svC0B0b12ebPSw1qxpBUsb+QopQXGMCO+uFEyug4VF+sd6PQ9
         /JLxllg2IO9YL0yeeicZN+YMoHZrZNOf0DaEcTgwKiX2lSDwoZb6yFignrtLVUd084cj
         2Vgv9dalTKqen5fn8FP7O8Ga1WVl45Qf2xINpAr/EfcyMhquxVrt7L+UPq+INrVQ+h3C
         1T1Q==
X-Gm-Message-State: AElRT7HS0w3seJMemWmBiAOT9ikwqL5q3sCrXrVMiu/HF+AqWihRo/8b
        VVgCY7dsOwjbYoK/gmghGn1JNwi88l0DwKcXp/E=
X-Google-Smtp-Source: AG47ELtXxz549INp/X4NR0THzsf24sFkPk7LTr0q7eX6t9A2qjOMn6G9z2uvY56ObUyE4mP8IcaX4JtqgE7Qr/7Hbsc=
X-Received: by 2002:a9d:154c:: with SMTP id z12-v6mr2128349otz.65.1521273721711;
 Sat, 17 Mar 2018 01:02:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sat, 17 Mar 2018 01:01:31 -0700 (PDT)
In-Reply-To: <20180316212208.GC12333@sigill.intra.peff.net>
References: <20180303014605.10603-1-pclouds@gmail.com> <20180316193355.20161-1-pclouds@gmail.com>
 <20180316212208.GC12333@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 09:01:31 +0100
Message-ID: <CACsJy8A3_itjs0MRar+Aog=0yZDuAK2-x4MU=Rvqh2C6Le-7Aw@mail.gmail.com>
Subject: Re: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc job
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 10:22 PM, Jeff King <peff@peff.net> wrote:
>> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>> index 3735ce413f..f6f346c468 100755
>> --- a/ci/run-build-and-tests.sh
>> +++ b/ci/run-build-and-tests.sh
>> @@ -7,6 +7,22 @@
>>
>>  ln -s "$cache_dir/.prove" t/.prove
>>
>> +if [ "$jobname" = linux-gcc ]; then
>> +     gcc-6 --version
>> +     cat >config.mak <<-EOF
>> +     CC=gcc-6
>> +     CFLAGS = -g -O2 -Wall
>> +     CFLAGS += -Wextra
>> +     CFLAGS += -Wmissing-prototypes
>> +     CFLAGS += -Wno-empty-body
>> +     CFLAGS += -Wno-maybe-uninitialized
>> +     CFLAGS += -Wno-missing-field-initializers
>> +     CFLAGS += -Wno-sign-compare
>> +     CFLAGS += -Wno-unused-function
>> +     CFLAGS += -Wno-unused-parameter
>> +     EOF
>> +fi
>
> Why isn't this just turning on DEVELOPER=1 if we know we have a capable
> compiler?

DEVELOPER=1 is always set even before this patch. It's set and
exported in lib-travisci.sh.
-- 
Duy
