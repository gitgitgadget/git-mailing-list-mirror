Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC241F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGAMDS (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:03:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44245 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfGAMDS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:03:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so14259875qtk.11
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jfE5HY82bYLaWx+Tyo9m8OgLEiXlMRxXJPp2y1i9m0=;
        b=EJMD4n2LQGUEKnl+56RCGIc5nEvFuZpDDWSLX8NkunxlMgZH6b5whKm9l/XXkS8/TQ
         gsP90oklvnQOR/Ik7zM8X6IuGGB+QhuHaJuW09twHthi8fh3AdtIC0aRVbNmQOX7fD98
         rBKzWDLhAitQGOT1NugBEenT7gSUfgbjlxrw/+Ja+R9HRSKKgpXFmgOatHKeFtG9yNUi
         0Xdvq4YKaaR4FCXA74xFW7t5v4MJcwCfBjou2r0iuEH8x8apIAjazzHhP02CWYsxhB5H
         Yk4vjgNry9sP6ZNZXB5LNu1kCwTL1UwisOHPrWchwkG1vaEFeiPFQFCHaTBFRRp2QF2+
         0hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jfE5HY82bYLaWx+Tyo9m8OgLEiXlMRxXJPp2y1i9m0=;
        b=PHeBEogfv7aEgddePSH6hRjUywZqcF2LpWoLhcsP1NEaGPMoQMQB9GRA6SXE5plNGb
         sUUST7SqIARWuV7llh03c6jG9ia1h4pWe/7RMBN9ruEQguKAWPR1bYLdWm530P4EAVtg
         fgMG8IZUP7uf5LG074Mth2q91MFemuPoSr3eDa7EG8bFHiaRa6xZxok3HYGQuhnRYP+2
         SDf02kbOY6PqZ2yQ3OTUnwQBHxgDU6BtTVAQFeigaHOB5p1qvof0BPLI96ZPz4oIdiUf
         zztDPxkQ+QvhWCaA+KtoOTyOLNIW0XdCqHVZR7AkF4lLGvTG3xFHpXlbx7kZR0T3dU+N
         1UWg==
X-Gm-Message-State: APjAAAVhELNNGjWAtvkZFntp5iofjVyQMkmqOWH1tXXolokLlETaPSWP
        JFZYd4mpcux9WSV1dw/Rbgo=
X-Google-Smtp-Source: APXvYqwdYIrA8qe6VVJyWKmRQ6OmYKf0bS8+zlK33uHCTWQ4ThF5gCjPLJZPzJrJprKHY2qtsNCRYw==
X-Received: by 2002:a0c:d91b:: with SMTP id p27mr20641856qvj.236.1561982596950;
        Mon, 01 Jul 2019 05:03:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8d39:716e:a6fa:35c4? ([2001:4898:a800:1012:3e6d:716e:a6fa:35c4])
        by smtp.gmail.com with ESMTPSA id j2sm5009445qtb.89.2019.07.01.05.03.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 05:03:16 -0700 (PDT)
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
 <20190630222537.GA21696@sigill.intra.peff.net>
 <3e5c0286-7514-9e00-fbc5-5b0ad9403d30@kdbg.org>
 <20190701091602.GA24791@sigill.intra.peff.net>
 <20190701113304.GK21574@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <100c5c85-59b6-f68c-7da6-b05637534858@gmail.com>
Date:   Mon, 1 Jul 2019 08:03:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190701113304.GK21574@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry I'm late to the thread. Thanks for reporting this issue, Johannes.

On 7/1/2019 7:33 AM, SZEDER Gábor wrote:
> On Mon, Jul 01, 2019 at 05:16:02AM -0400, Jeff King wrote:
>> I see Gábor suggested using "wc -c" elsewhere in the thread. That would
>> be fine with me, too, though I think the required sed there may be
>> getting pretty unreadable, too. :)
> 
> It could be done even without 'sed', though at the expense of running
> a coupe more 'wc -c's in a loop:>
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 79bfaeafa9..bacec5e2e4 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -443,7 +443,12 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
>  		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
>  		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
>  		ls .git/objects/pack >expect &&
> -		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
> +		MINSIZE=$(
> +			for pack in .git/objects/pack/*pack
> +			do
> +				wc -c <"$pack"
> +			done | sort -n | head -n 1
> +		) &&
>  		git multi-pack-index repack --batch-size=$MINSIZE &&
>  		ls .git/objects/pack >actual &&
>  		test_cmp expect actual
> @@ -455,7 +460,12 @@ test_expect_success 'repack creates a new pack' '
>  		cd dup &&
>  		ls .git/objects/pack/*idx >idx-list &&
>  		test_line_count = 5 idx-list &&
> -		THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
> +		THIRD_SMALLEST_SIZE=$(
> +			for pack in .git/objects/pack/*pack
> +			do
> +				wc -c <"$pack"
> +			done | sort -n | head -n 3 | tail -n 1
> +		) &&
>  		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
>  		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
>  		ls .git/objects/pack/*idx >idx-list &&
> 
> Is it really better?  Dunno, but at least there is no subtlety with
> the leading padding spaces.

Your change is certainly more straight-forward, and avoids all issues
around Perl compatibility.

It does have the issue of more 'wc' processes, which is a downside. The
count here is not too bad, but if we need to duplicate this pattern elsewhere
we may be better off creating a stat(1) replacement in test-lib.sh.

Thanks,
-Stolee
