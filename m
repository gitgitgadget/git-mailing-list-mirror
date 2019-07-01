Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167991F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfGAOQL (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:16:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41744 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfGAOQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:16:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so4643923pgj.8
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xqT14s19R3/xOgBsqP7epPb5ebNNoRVCXh5hQpZmb6s=;
        b=ho0Ux+JktDUMDv2uCuhADNuDGIkwQ1/ij0UFQ3gKajcBC55P12yhOgZ3FnaxQFQwlJ
         dM2rmoL/PJCSjoAs1WoYTXawN4Yvndb70vFUszjxY6AWY8pJneZ9XUceAIUv9EFaGght
         EZl0p9ng3u2be3Tpk6pTP3lRwy9dr6KM2j99r2SwzRrAj3dOzomMZguIRFfnhFXumato
         z65zcqTbKNyBSEPdwWK7rFA7fSqqlf75eYu4U29sfBD5D+yXKechUH+0msNPsYhFfTXv
         DsgtaGYtTarp8GqURoN6sltsEtonOdG8FCrrc8t0Usev10KWcZsaG+CRcisWMUdi1psO
         fi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xqT14s19R3/xOgBsqP7epPb5ebNNoRVCXh5hQpZmb6s=;
        b=ameRucVPZq1VHiNN/M8c/dp/AmBM+DxjP5zA2G3LSmrIiDzbx+bfH7ZDh1jHKUq9af
         qfgXDrmwM6SyNnWRR2lBNzyLefX+3aE7ImlkiyKe9Jh5V15CBS+e0n22ToAlgPVDbYB7
         RmH70pzQGC+/ZvmEDJG0I1/1Uqhvzz8hIyh0tFqL/udPu4cZsE1wnqFfOt94O/51J87P
         NKzgGIDiBpzfkfiDqV55+0tLylsU81CZPRCD8vI/a8wbR0MPbMfW99/cUT1YThVUptzd
         pXKrWYlerwtPs/ugkKobUEXLRqjvyTX9uOdLYZFTyWQ8KzqYgbY4u04hsk9VUpe75ESC
         i0Ow==
X-Gm-Message-State: APjAAAWEQ4B5uKRx6qjRJCnG8+KymL0IQbpowr0Gmts0SWNXCbC9+jN4
        XNBWTVRWPbuEeM5D2TMXgsVzKw==
X-Google-Smtp-Source: APXvYqzESvWeMOQzsMmbOn0qFnmRq4plf2eKk4II/o93PDY5dM9pYwQsMiwbIwr4HfFO4ArVsd/N7Q==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr31671962pjc.10.1561990569914;
        Mon, 01 Jul 2019 07:16:09 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id y22sm23510029pfo.39.2019.07.01.07.16.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:16:09 -0700 (PDT)
Subject: Re: [PATCH] t8014: remove unnecessary braces
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190629171954.GG21574@szeder.dev>
 <20190630181732.4128-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <0835ac2f-59aa-a9bb-5e47-6617dae1f810@google.com>
Date:   Mon, 1 Jul 2019 10:16:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190630181732.4128-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll squash this fix in for v10.

On 6/30/19 2:17 PM, michael@platin.gs wrote:
> From: Michael Platings <michael@platin.gs>
> 
> Signed-off-by: Michael Platings <michael@platin.gs>
> ---
>   t/t8014-blame-ignore-fuzzy.sh | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
> index 6f1a94caef..6e61882b6f 100755
> --- a/t/t8014-blame-ignore-fuzzy.sh
> +++ b/t/t8014-blame-ignore-fuzzy.sh
> @@ -298,28 +298,28 @@ EOF
>   last_test=13
>   
>   test_expect_success setup '
> -	{ for i in $(test_seq 2 $last_test)
> +	for i in $(test_seq 2 $last_test)
>   	do
>   		# Append each line in a separate commit to make it easy to
>   		# check which original line the blame output relates to.
>   
>   		line_count=0 &&
> -		{ while IFS= read line
> +		while IFS= read line
>   		do
>   			line_count=$((line_count+1)) &&
>   			echo "$line" >>"$i" &&
>   			git add "$i" &&
>   			test_tick &&
>   			GIT_AUTHOR_NAME="$line_count" git commit -m "$line_count"
> -		done } <"a$i"
> -	done } &&
> +		done <"a$i"
> +	done &&
>   
> -	{ for i in $(test_seq 2 $last_test)
> +	for i in $(test_seq 2 $last_test)
>   	do
>   		# Overwrite the files with the final content.
>   		cp b$i $i &&
>   		git add $i
> -	done } &&
> +	done &&
>   	test_tick &&
>   
>   	# Commit the final content all at once so it can all be
> 

