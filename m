Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC9A201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbdEOSba (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:31:30 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35464 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935358AbdEOSb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:31:29 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so62251534pfb.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5OpldMBDfJQgSKUW5ulLqjH4wgNtwCmILC0atw6ooHA=;
        b=TCLpVBDd1ZpVnhuH+aRkaVVsZxubXBJqkItETvp7n34tezeKiDJkEpoDXdbjWPU6PY
         NJ3sqpwyQM/RN54HsjWgsDY5Ubm9/taoAFteLuHXV1447Mam1pc4E6uXq7ICX/hMF3kW
         xfDXW34fC0NBqij+xmpC+vi+40mm0OmFvy27VeYz+hqdU9Q03bP2rExGyFeEO2VB6Y9v
         CJxiYQE7E6h+3oO2C6KligurEn7i+Qfh0F11POByszDi3JynYy9mq4cT+8sUb/MTcON5
         RYI9uBHmXavh6UkJluu1D/hYMI/6fZe6uIBpJ9eyhXUdJe0u08WcuEboTIR7/AQyqtQ0
         vwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5OpldMBDfJQgSKUW5ulLqjH4wgNtwCmILC0atw6ooHA=;
        b=DO6pvUT9oHwczC6qPGAjka6JwWbSBU3pvA5eOqRFJtyqHqM9kXhnhmDX8zpMgdizgy
         CrfvXh3TuMRSElQE1DaaZVTFRSqpwChw+xq5ihP+py4+Ga+ToEW1c12f5DkLCWxWC1sM
         bfhxqjj7NZLjxNWot0i62N6gcdQsKJqDF4BfqD5z47SclBkq4qoJKIvjX3D3gDKPq5VV
         YDAIxuSKoCeN8TVXWBwhd2FGaouml6TndNDJZxswVuKGSlwxUrNqlmaag2Rn0cb7e6Im
         X8NfPgwF6HOevj1zb1CU2+6f+GvZ4N0/VgS4mZudazWaFEEondvm8cWp11CoTpOLPWez
         agWA==
X-Gm-Message-State: AODbwcAV/63flHefFOVzpSgiXQd0JXaeSL1cLAZPITS24THHZGUN2OSi
        wHjGBKHSvj0z+juF
X-Received: by 10.98.14.86 with SMTP id w83mr7696120pfi.83.1494873088804;
        Mon, 15 May 2017 11:31:28 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f484:2515:b6cf:fcc0])
        by smtp.gmail.com with ESMTPSA id z64sm5677131pfd.20.2017.05.15.11.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 11:31:27 -0700 (PDT)
Subject: Re: [PATCH 05/19] diff.c: emit_line_0 can handle no color setting
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-6-sbeller@google.com>
Cc:     peff@peff.net, gitster@pobox.com, mhagger@alum.mit.edu,
        jrnieder@gmail.com, bmwill@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <847ecb20-ebbe-7f7a-e532-4e75e69c05c2@google.com>
Date:   Mon, 15 May 2017 11:31:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170514040117.25865-6-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/13/2017 09:01 PM, Stefan Beller wrote:
> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> In later patches we may pass lines that are not colored to
> the central function emit_line_0, so we
> need to emit the color only when it is non-NULL.

The diff below seems to just make emit_line_0 allow NULL for set and 
reset, unlike what the commit message above describes. (And is that 
necessary? Couldn't the caller just pass "" if they don't want any 
setting and/or resetting?)

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 381b572d76..48f0fb98dc 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -532,11 +532,13 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>  		len--;
>
>  	if (len || sign) {
> -		fputs(set, file);
> +		if (set)
> +			fputs(set, file);
>  		if (sign)
>  			fputc(sign, file);
>  		fwrite(line, len, 1, file);
> -		fputs(reset, file);
> +		if (reset)
> +			fputs(reset, file);
>  	}
>  	if (has_trailing_carriage_return)
>  		fputc('\r', file);
>
