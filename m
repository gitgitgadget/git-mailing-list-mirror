Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97EBA1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 14:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdHPOGX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 10:06:23 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37492 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPOGW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 10:06:22 -0400
Received: by mail-qk0-f193.google.com with SMTP id x77so3408983qka.4
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hlLnNOycsHXmSYYoIbPnM6wSiIGS/EQkH9HKRgms1hM=;
        b=WhXScXWffOdU8PSDK7Gcz9sXnUliDWJjDPgcNmM24uyjCklJK4VuDVGb09EBDASchJ
         wV024fnM4koqrj73YZeE2gJq6VYdT87VUWIeLfwBU82ymtAJFonrG9wJRu6RFOyls3XY
         YVh8RaIO8TtWYvCF5mr0BekMBpgDEEYeoWNUlIW0cIKXpfNZFJAVk25u2nlwng7cnI+U
         cCxMRXn9FNFr5Phkn0SEFiC1eLiaZK6pTn9l0LoS+Oknuw+QvTa4BMX2VMqvJ+wn9JKc
         ozUuhcbuwyDMICiBDQEQhC375LQ0DrOJeeDHugkIV3vlOd2bgC7v0KvBbY0Yfo5K7P1r
         JO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hlLnNOycsHXmSYYoIbPnM6wSiIGS/EQkH9HKRgms1hM=;
        b=NHEdCuFNEN2ifR9TdJ19R110avwoitOukE2MJf5v3/KIbdN4ZRCbi22YiNSquA8OQh
         xg5v4qBT26DlZWBGpkpBvKNxDjFjEXWI9DwMXKLHihT3Owpl7YmXSdglza1lZnBVKgZq
         mpM22h/2JskMbOZlE7aWzbb+affNFnMlo4a5j+t9OUF+CUJZxL0TPLibjjohttXEyiUZ
         fb92pOIuWO/uWJncZ0sNTCD8g9T3vtKZ0CEANtQIAab+3Zc8AErF05WRV4xxyDdYTHxZ
         dUxVMBj+TbRz9L7wOgIlfF/RvyMUiaR1oeJIFneLJW1H43z9Ljp7UVA6ixm9urRtV/0s
         uoPg==
X-Gm-Message-State: AHYfb5im8rv6zgSobhP9zYQEQzec2n5RE+un+rHXWEzY1uH/EztK2on+
        LxLwgK/uSThreA==
X-Received: by 10.55.111.4 with SMTP id k4mr2138657qkc.287.1502892381675;
        Wed, 16 Aug 2017 07:06:21 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s64sm544472qke.90.2017.08.16.07.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 07:06:19 -0700 (PDT)
Subject: Re: [PATCH v2] sub-process: print the cmd when a capability is
 unsupported
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170816124036.25236-1-chriscool@tuxfamily.org>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <758d36a7-8066-7e1a-30d0-62baf2796520@gmail.com>
Date:   Wed, 16 Aug 2017 10:06:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170816124036.25236-1-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/16/2017 8:40 AM, Christian Couder wrote:
> In handshake_capabilities() we use warning() when a capability
> is not supported, so the exit code of the function is 0 and no
> further error is shown. This is a problem because the warning
> message doesn't tell us which subprocess cmd failed.
> 
> On the contrary if we cannot write a packet from this function,
> we use error() and then subprocess_start() outputs:
> 
>      initialization for subprocess '<cmd>' failed
> 
> so we can know which subprocess cmd failed.
> 
> Let's improve the warning() message, so that we can know which
> subprocess cmd failed.
> 
> Helped-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Change since previous version:
> 
>    - Use process->argv[0] instead of adding a new parameter to
>      handshake_capabilities(), thanks to Lars.
> 
>   sub-process.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sub-process.c b/sub-process.c
> index 6edb97c1c6..6ccfaaba99 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -184,8 +184,8 @@ static int handshake_capabilities(struct child_process *process,
>   			if (supported_capabilities)
>   				*supported_capabilities |= capabilities[i].flag;
>   		} else {
> -			warning("external filter requested unsupported filter capability '%s'",
> -				p);
> +			warning("subprocess '%s' requested unsupported capability '%s'",
> +				process->argv[0], p);
>   		}
>   	}
>   
> 

This one is even cleaner.  Thanks Lars for pointing out the fact we 
already had the cmd name.  Looks good.
