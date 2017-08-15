Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E499208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbdHOTBV (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:01:21 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38235 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbdHOTBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:01:19 -0400
Received: by mail-qk0-f194.google.com with SMTP id m84so1491435qki.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lHVnt7kTAwtocPVlJMeR3ItA8MRmXq39jgl5b/7jfOE=;
        b=iI7lEnyavbZE7Q+dJ4vkzXzTqeCQZpTW6kb0W02Q7l9NkNjtbygw4dM03qy8C4+7zx
         Ap26Rnp4WQB57lrnIHmcSpBSHQrx1ueABg7pu3/R2/tlG9C1Y3e/W75/9j2qUMXWKqA7
         auvmhjS5QQHpBn4i8PpUe3syOnIgRUXnhJBeDfAxJyT2RjbhnvpLj8wSHHSab++ylxbZ
         eYHSFrVR6gI9sFf91fUq83z3OcdsFZBoC5DGHxSjl7KRS/vN1GW5+jOeBQS0NWgtbSRc
         UAtD0LRvW6a7mz27DRAatyDUjDKGj7AtxzHKrk7BOjZDIVYH3WOuTxd8D9YE1DV1sOl9
         kYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lHVnt7kTAwtocPVlJMeR3ItA8MRmXq39jgl5b/7jfOE=;
        b=CQLJdcY2B7b6TbH4R1IdvElIf4FlMX0C/j0fzl2TUauV1U4s4Jsjn+rXpaGTpkgDnE
         ks5HL/ndn48XLeXnoGYWN873hFbx64Xr9o4saDda/tcewwaP1XXQA3MVJ87LXTr9HvEs
         P4y8Zp56WkKp9yPPT5f54h7h+oF8GLSnSIKJyMfrxOFwYgaV6ljhd2Tc7pjkz+6q/u5f
         8bitMTnJq5qU/DpiXa/kerXTwrfhhitPrhwkxvzDnWONsNZ0EebJkJ4yoOTx6ESxN53J
         6Aj19Y2mDgcREYWzWfejMAegEuXF3j+LWJ8XnB7Z5xEWaI2Ac6PkHZ2xlFNfC7CJfbCU
         InEg==
X-Gm-Message-State: AHYfb5hIbtChHRt881kcuI4kuWS11zaMSvDAhfl/0QU2e2RpxIia02xi
        zMTUadzEra7Diw==
X-Received: by 10.55.198.205 with SMTP id s74mr13436046qkl.211.1502823678305;
        Tue, 15 Aug 2017 12:01:18 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id m15sm7659840qtc.48.2017.08.15.12.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 12:01:16 -0700 (PDT)
Subject: Re: [PATCH] sub-process: print the cmd when a capability is
 unsupported
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b9a458ca-6e4a-1ef2-79e1-f2a3e6d0a665@gmail.com>
Date:   Tue, 15 Aug 2017 15:01:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170815173611.2267-1-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/15/2017 1:36 PM, Christian Couder wrote:
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
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   sub-process.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/sub-process.c b/sub-process.c
> index 6edb97c1c6..6b133f8dce 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -158,7 +158,8 @@ static int handshake_version(struct child_process *process,
>   
>   static int handshake_capabilities(struct child_process *process,
>   				  struct subprocess_capability *capabilities,
> -				  unsigned int *supported_capabilities)
> +				  unsigned int *supported_capabilities,
> +				  const char *cmd)
>   {
>   	int i;
>   	char *line;
> @@ -184,8 +185,8 @@ static int handshake_capabilities(struct child_process *process,
>   			if (supported_capabilities)
>   				*supported_capabilities |= capabilities[i].flag;
>   		} else {
> -			warning("external filter requested unsupported filter capability '%s'",
> -				p);
> +			warning("subprocess '%s' requested unsupported capability '%s'",
> +				cmd, p);
>   		}
>   	}
>   
> @@ -206,8 +207,10 @@ int subprocess_handshake(struct subprocess_entry *entry,
>   
>   	retval = handshake_version(process, welcome_prefix, versions,
>   				   chosen_version) ||
> -		 handshake_capabilities(process, capabilities,
> -					supported_capabilities);
> +		 handshake_capabilities(process,
> +					capabilities,
> +					supported_capabilities,
> +					entry->cmd);
>   
>   	sigchain_pop(SIGPIPE);
>   	return retval;
> 

Looks good to me.

