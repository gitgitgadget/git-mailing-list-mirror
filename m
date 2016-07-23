Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463D4203E1
	for <e@80x24.org>; Sat, 23 Jul 2016 10:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbcGWKPv (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 06:15:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35934 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbcGWKPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 06:15:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so9233692wma.3
        for <git@vger.kernel.org>; Sat, 23 Jul 2016 03:15:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3IkUSeUXekzKwoQ9oUGm1+OICsRk3Qq8nKhjDCnMnHI=;
        b=yTT5Pq77a4Gnia/iL1/2oBA7vrjfR7qPeB1B1e/SvsovO0CVc5uKc/CYBuf5W3M3Vc
         uDD1F5heoL1Wkxls2DjgRj2j5iLJtSrAT+6MEYy1xDQdF1sDJ34RCebCRzHNWQ1q9214
         8MegREOyXA0ZpAR3dpcPDR2T89hXSA222GScYg9GXgh/Wic/i7eyKO3ni4UIuY1iDj9q
         PseTtiLnFYUEHqJ6ONIxkI6siQ4L/wkPo1dmtP5qkosJT1408xGggcKPgpMV8T4nv585
         ii+QGIghbi9KadTSzV773TWtxDWoTH7WiyEJOWcIjBMHAefrb0ExOshM4RHOCADtxYrC
         PBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=3IkUSeUXekzKwoQ9oUGm1+OICsRk3Qq8nKhjDCnMnHI=;
        b=WDlFKGXMPlH3X5kC+T1CQoc3ClywJ0CkbLhbfUSpNINJf8pY18WCS4YjV4kaj/w7/n
         Hj5UqKLAqOiMbac4hSc18IhqfXFL/mYYyy7cQktliIS7Q2lev0onhBhYC5tq4LaHJkvP
         +KqgJzqouRyWOM304XEpw2zhIHwoddHIrhjaz2RZOCJAjbvznqajMj6MMllHiChyfNyw
         P3sdBpoejv9/sq3RhbSBoi4/J4FQWr5DqiD9x+N1PmZJ04+5T/8/BR7R4jslCdZed4GR
         lKo/BKHpYx+OadLCsIopJ1jU15/HuNSOElKshQBQsxRs/lUvN2skDVlSaeX0POw4yed/
         hm1g==
X-Gm-Message-State: AEkooutXeqkYboFIfXACIwVhfcSsWybDu4XzNBMBazER+5ahLS0y8NI7P4HVB/26sb4fQg==
X-Received: by 10.194.156.195 with SMTP id wg3mr6056365wjb.152.1469268947405;
        Sat, 23 Jul 2016 03:15:47 -0700 (PDT)
Received: from [192.168.1.26] (dcf38.neoplus.adsl.tpnet.pl. [83.23.57.38])
        by smtp.googlemail.com with ESMTPSA id f10sm5171244wje.14.2016.07.23.03.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jul 2016 03:15:46 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] date: document and test "raw-local" mode
To:	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20160722195105.GA19542@sigill.intra.peff.net>
 <20160722195144.GE19648@sigill.intra.peff.net>
Cc:	Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <579343C9.1040902@gmail.com>
Date:	Sat, 23 Jul 2016 12:15:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160722195144.GE19648@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-22 o 21:51, Jeff King pisze:

> The "raw" format shows a Unix epoch timestamp, but with a
> timezone tacked on. The timestamp is not _in_ that zone, but
> it is extra information about the time (by default, the zone
> the author was in).

I would say that "Unix time" (name according to Wikipedia) is
zone-less, but the information is correct.

> 
> The documentation claims that "raw-local" does not work. It
> does, but the end result is rather subtle. Let's describe it
> in better detail, and test to make sure it works (namely,
> the epoch time doesn't change, but the zone does).

Subtle, and not very useful (unless you want to know your
own timezone difference)... or do we adjust timezone offset
shown across DST change for the locale?

> 
> While we are rewording the documentation in this area, let's
> not use the phrase "does not work" for the remaining option,
> "--relative". It's vague; do we accept it or not? We do
> accept it, but it has no effect (which is a reasonable
> outcome).

Anyway, replacing vague "does not work" with explanation of
what is the result is a very good idea.

> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/rev-list-options.txt | 9 ++++++---
>  t/t0006-date.sh                    | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 5d1de06..3ec75d4 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -725,8 +725,8 @@ include::pretty-options.txt[]
>  	`iso-local`), the user's local time zone is used instead.
>  +
>  `--date=relative` shows dates relative to the current time,
> -e.g. ``2 hours ago''. The `-local` option cannot be used with
> -`--raw` or `--relative`.
> +e.g. ``2 hours ago''. The `-local` option has no effect for
> +`--relative`.

Do I understand it correctly: --relative is a short form for more
generic --date=relative (which probably should be spelled 
--date-format=relative), and that --date=relative-local is the
same as --date=relative, that is *-local suffix does not change
how date is formatted?

Because I don't think you can say --relative-local ("The `-local`
option has no effect on `--relative`"), can you?

Nevertheless the proposed change is definite improvement.

>  +
>  `--date=local` is an alias for `--date=default-local`.
>  +
> @@ -746,7 +746,10 @@ format, often found in email messages.
>  +
>  `--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
>  +
> -`--date=raw` shows the date in the internal raw Git format `%s %z` format.
> +`--date=raw` shows the date in the internal raw Git format `%s %z`
> +format. Note that the `-local` option does not affect the
> +seconds-since-epoch value (which is always measured in UTC), but does
> +switch the accompanying timezone value.

Which is correct, logical, and next to useless, I think.


BTW. one kind of format that Git does not support (I think) is the
varying kind, where the precision changes with the distance from now,
so that we can get most precision in limited width.  That's what
`ls --long` does:

 * 'Jun 29 16:47' for dates falling in current year (more precision)
 * 'Nov 23  2015' for dates outside (less precision, same width)

Many other programs switch from relative to absolute time when date
in question is far in the past that relative is not very good.

>  +
>  `--date=format:...` feeds the format `...` to your system `strftime`.
>  Use `--date=format:%c` to show the date in your system locale's
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 4c8cf58..482fec0 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -47,6 +47,7 @@ check_show short "$TIME" '2016-06-15'
>  check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
>  check_show raw "$TIME" '1466000000 +0200'
>  check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
> +check_show raw-local "$TIME" '1466000000 +0000'
>  
>  # arbitrary time absurdly far in the future
>  FUTURE="5758122296 -0400"
> 

