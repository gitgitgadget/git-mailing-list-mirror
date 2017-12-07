Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729AF20954
	for <e@80x24.org>; Thu,  7 Dec 2017 17:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbdLGRkg (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:40:36 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33079 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbdLGRh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 12:37:56 -0500
Received: by mail-pg0-f68.google.com with SMTP id g7so4953511pgs.0
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l20RXw326e8R9WI2qfK2CuUV0zWBosHyMpx66yvSNtg=;
        b=rAMcnMin/khQhXgQjDCaDJWOPLZ33hX2y1P6a751TkbQSI1gHYr1zaWs9lYZSp0dAB
         Qc2HDlUAfT4LJ6LFX43wgSKonvLHGWJA000Dtokdl0VZYDFnLMyXbUcXjL/ofP+CYXNC
         AXziHy7Ydk8J6uGWMi5AjUhl0rGL9Y9ae0sEjL6/AOVbcCG1JRvqk1FvOj7PM1BnLSfE
         CuKwEXfGE0j16kTcmbYid2ybkntGsqiPIgdNScRshWuF7mqI/kT2OU9T4g8q8sbeI+0k
         uqPgYD1CZCDiW8MXM3vTQReOnsxv9J4XqaIfVa47Mx+h2cUShvA3BsyQJYl11U3w3FNf
         xipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l20RXw326e8R9WI2qfK2CuUV0zWBosHyMpx66yvSNtg=;
        b=fJ85zg06JbqLsSJkziXyu5UZePCuZzZHH1tBGMo2/Jfm9rX88oxPnp5tiHLswJSMUq
         qwu7O52xB3MJ69SZH8OOLaGrqMfYdoxgX3Ty84CqCpQdvYGNp8gC4aLvwV8+YgI0QdEp
         vSOYnLRi3h5C+WJlknHYmAY40vcLZdgjSrxq2fmQiuctlcxZm26wh+VkfgSOrpsUj7Kx
         ZGK+ntGi1UwuY3LnP50DFiVs/1QFih3Qk8ZjVIEJ4dl44NV5qCiSGv9VHjDydhUfM6U1
         C1/NkPnbLXVrf3r7SSUd4EB698nEv3pitEVc0hEouipkUs7+6svYp9+bsxRaLtlbNR39
         aizA==
X-Gm-Message-State: AJaThX7qjIlB60sJhAL2CT+YUWWO2QdDAC2r+kF2Il2AUkElRqqS+Y7K
        zE721tw3I/JcNpj36plf8Jw=
X-Google-Smtp-Source: AGs4zMYBciZBVycU93jFBOadPkfn+Yz+sL2QjByT8rTr3AhfkBQwT42IhLt42KlnAom5TRN6PCNZmA==
X-Received: by 10.99.115.9 with SMTP id o9mr26264174pgc.198.1512668276122;
        Thu, 07 Dec 2017 09:37:56 -0800 (PST)
Received: from ?IPv6:2405:204:71ce:188a:cb7b:a122:cf1e:bf1e? ([2405:204:71ce:188a:cb7b:a122:cf1e:bf1e])
        by smtp.gmail.com with ESMTPSA id q74sm9823548pfd.134.2017.12.07.09.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2017 09:37:55 -0800 (PST)
Subject: Re: [PATCH v5 2/2] launch_editor(): indicate that Git waits for user
 input
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net, peff@peff.net
References: <20171207151641.75065-1-lars.schneider@autodesk.com>
 <20171207151641.75065-3-lars.schneider@autodesk.com>
 <xmqqr2s6ee7e.fsf@gitster.mtv.corp.google.com>
 <FCBDBD58-0593-4FFC-B574-61D67CAF13C6@gmail.com>
 <D17F94FA-702E-4E37-BDA5-94F0FFD5BD01@gmail.com>
 <xmqqmv2uec0p.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <dfb2cde5-a499-8da3-9695-8c8fd46a96ad@gmail.com>
Date:   Thu, 7 Dec 2017 23:07:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqmv2uec0p.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 07 December 2017 10:00 PM, Junio C Hamano wrote:
> +
> +		if (print_waiting_for_editor) {
> +			/*
> +			 * A dumb terminal cannot erase the line later on. Add a
> +			 * newline to separate the hint from subsequent output.
> +			 *


> +			 * In case the editor emits further cruft after what
> +			 * we wrote above, separate it from our message with SP.

I guess this part of the comment could be improved a little. I currently 
interpret it as "See if the editor emits further cruft, print a space in 
that case". Though, it's not what we are doing. Something like the 
following, perhaps?

      In a non-dumb terminal, separate our message from further cruft
      that might be emitted by the editor with SP.



> +			 */
> +			const char term = is_terminal_dumb() ? '\n' : ' ';
> +
> +			fprintf(stderr,
> +				_("hint: Waiting for your editor to close the file...%c"),
> +				term);
> +			fflush(stderr);
> +		}
>   
>   		p.argv = args;
>   		p.env = env;
> @@ -63,6 +80,13 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>   		if (ret)
>   			return error("There was a problem with the editor '%s'.",
>   					editor);
> +
> +		if (print_waiting_for_editor && !is_terminal_dumb())
> +			/*
> +			 * Go back to the beginning and erase the entire line to
> +			 * avoid wasting the vertical space.
> +			 */
> +			fputs("\r\033[K", stderr);
>   	}
>   
>   	if (!buffer)
> 

