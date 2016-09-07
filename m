Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B1F1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 20:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbcIGUir (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 16:38:47 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33847 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754975AbcIGUio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 16:38:44 -0400
Received: by mail-pa0-f65.google.com with SMTP id gi6so1374326pac.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2zHUTqe2BEDIfFjPflZSAEmKVxDCQvJVIM+QjgnJGck=;
        b=M0UbWXdDgIlfOYA9SsWL6F8THG2H2UBfahyVoDkiQOypOoqH8LLDR/tHNcMOSmKvqX
         om7cqbov02O394WRcNXyyeBq4wZGDMH4b/lpygjl6QjvYl7EpvzvDjH1ll39bPL0gDoz
         YBGsc+f9eec7nIqZOWpTO7bA7YUj1V+96JeQDFb7/MVAr3tmGjEH+S7Jn/X1NbE6QK7R
         RTu/I5NavFThWDdoC95si5OZVUSNm1i1Tx4DsNFS4yx8k0VqmC0sSr7cqUjeOUpQ2aiC
         iAZHbTkZZFb8Wq5cdO4i2Rn2KQM7rstleb+aemORvvwWVYe/PMlHHSgMPimfp46/q9ie
         EnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2zHUTqe2BEDIfFjPflZSAEmKVxDCQvJVIM+QjgnJGck=;
        b=CnPO7wbwpyHQ9tuzStXZDhbqmyGgPN3cev0GAa4G6pyogXLjYJzpdJlswBLxXtyqMc
         BBZjOmi0EwE7FQq7e7TkrHU4joZD8pXuvpCYyLRoA5TNl/TJ9uSKTT4A06MEviFXvo3e
         JkcAOthAGRqPgqud3cpNF0P1d7XFlZ/ZJH+OFxF8htAaJd0gWXnCPcY///g7S0g7pPXy
         4HVEZVqt7bvP1ZXNUqX/mzmcilWhZeRFtb60+86p1Rp+1YvJzZxy2l0b4wgymHSWWr1i
         mhCqKvcsX476ZYu3bc7OwmJlFk9/pGKd3GO45PvJtPiaNHstdB1J5JLoEzJwcz8ex/hn
         gmTg==
X-Gm-Message-State: AE9vXwMj72DbkyhStQqMRE6NE6KJBcVXPK6VvOye71XTsfbTKJA7yYMpHS2+2V1XIjfq/A==
X-Received: by 10.66.194.196 with SMTP id hy4mr52112802pac.63.1473280718649;
        Wed, 07 Sep 2016 13:38:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:60fa:bcd3:3f9b:dd2])
        by smtp.gmail.com with ESMTPSA id f11sm486506pfe.1.2016.09.07.13.38.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 13:38:37 -0700 (PDT)
Date:   Wed, 7 Sep 2016 13:38:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        spearce@spearce.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
Message-ID: <20160907203836.GB25016@google.com>
References: <cover.1472853827.git.jonathantanmy@google.com>
 <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1472853827.git.jonathantanmy@google.com>
 <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
 <xmqqoa3zocud.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqoa3zocud.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:

>> diff --git a/connect.c b/connect.c
>> index 722dc3f..0c2221e 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -165,6 +165,9 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>>  			continue;
>>  		}
>>  
>> +		if (!strcmp(name, "capabilities^{}"))
>> +			continue;
>
> While it is true that ignoring this line anywhere in the ref
> advertisement is safe, it feels a bit strange to do so, when we know
> that it can appear _only_ when there is no other ref advertised.  I
> guess you can argue that it is good to be lenient to accept what
> others produce, but on the other hand, it can also be argued that
> having this among real ref advertisement would be a protocol
> violation that we may want to diagnose and prod the other side to
> fix their software (but still not fail).

By "it can also be argued", do you mean that you would prefer that
behavior?

It sounds like the worst of both worlds to me --- git would allow the
buggy server behavior, leading people not to fix their servers, but it
would print an ugly error message, so end-users would associate git
with confusing messages.

Given that there aren't any servers that are going to produce this
kind of bad input anyway, I prefer a die().

Thanks,
Jonathan
