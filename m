Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B654201A4
	for <e@80x24.org>; Mon, 15 May 2017 05:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758920AbdEOFue (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 01:50:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36345 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758229AbdEOFud (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 01:50:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so10860442pge.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kZYOzwRSKUhfKAGETfkAKJm9+RtI7HJ+evaVWk33OP8=;
        b=GZVM+WICKFdSZkwrkuLCpOt3CwMV8RjtEUYyXqHjY1UD5WcMJJXvXaXqMaOpDe/doF
         owJ5JMWipP5tl8jCpdFmaVO6D8iTpL8QEni+boqEGMifHkpOyz/OJ+PA6g9xBrjRaLYB
         wVr9jVYfAd49MqFZ62pEjmTN4Asn8DhesIPICfNxmpjhmm8QQOb7J52hZTo5JLeRrLUL
         SL+hJq090Z4KvgfHYdoUdmbLmUYUytksp/3QGKc66ibdkRuFiD/KYc9r6m2aDzZGtwm9
         PBkfzoGjSsz44Rp4UplVky5lxREjI3kLvWTqc6bO2xGhUDVh7LFtPSKaUCdNO0T9i7Y3
         FhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=kZYOzwRSKUhfKAGETfkAKJm9+RtI7HJ+evaVWk33OP8=;
        b=ssZBOLiUO1SvTFc+wGGPW1dZRpF0Ol5mWG+f4uFm3r4t+8RRHYybrpwEdNpz3Hmzmg
         SNPEnO8pqT5hq1xMJmTbYWO0wKvNXX+D+CC3YOTyrsTO8LMpLp6iJhVZt0TOHnIO0WEi
         Zz0lzLnx7Bma4+ORz59uiEOyo6LYy0i7/E573I6pnN/bNv0e1O+1vFndUA2h07thSgtt
         HNMxmDtIxGjkWVGA98axtK++gV59S6yEkN7j61eGRppTwAfHPA2yyouFQWLxBSdayHoU
         C0PUXDmRseaUxiSOmkai/YgXN4Y6dobPTERr/RkVXoRiQggKYIiseJ4IEUtPhZt8NVBB
         B+TQ==
X-Gm-Message-State: AODbwcCqW1C7HsoTDmqEwgIqvzgMoi/eLqlJdoTsLleVwLSaTwM2+fDR
        mbqGwPdsXbIoTg==
X-Received: by 10.84.143.195 with SMTP id 61mr6093602plz.158.1494827433006;
        Sun, 14 May 2017 22:50:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id a19sm17688178pfe.81.2017.05.14.22.50.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 22:50:30 -0700 (PDT)
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
Subject: Re: [PATCH v2 18/29] grep: catch a missing enum in switch statement
References: <20170513231509.7834-1-avarab@gmail.com>
        <20170513231509.7834-19-avarab@gmail.com>
Date:   Mon, 15 May 2017 14:50:29 +0900
In-Reply-To: <20170513231509.7834-19-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 13 May 2017 23:14:58 +0000")
Message-ID: <xmqqwp9ivfbu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add a die(...) to a default case for the switch statement selecting
> between grep pattern types under --recurse-submodules.
>
> Normally this would be caught by -Wswitch, but the grep_pattern_type
> type is converted to int by going through parse_options(). Changing
> the argument type passed to compile_submodule_options() won't work,
> the value will just get coerced. The -Wswitch-default warning will
> warn about it, but that produces a lot of noise across the codebase,
> this potential issue would be drowned in that noise.
>
> Thus catching this at runtime is the least worst option. This won't

least bad, I guess?

> ever trigger in practice, but if a new pattern type were to be added
> this catches an otherwise silent bug during development.

Good future-proofing.  When this and Peff's "BUG" thing both
graduates, we can turn this into a BUG, I think.

Thanks.

>
> See commit 0281e487fd ("grep: optionally recurse into submodules",
> 2016-12-16) for the initial addition of this code.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/grep.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 3ffb5b4e81..a191e2976b 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -495,6 +495,8 @@ static void compile_submodule_options(const struct grep_opt *opt,
>  		break;
>  	case GREP_PATTERN_TYPE_UNSPECIFIED:
>  		break;
> +	default:
> +		die("BUG: Added a new grep pattern type without updating switch statement");
>  	}
>  
>  	for (pattern = opt->pattern_list; pattern != NULL;
