Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F1C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4AE610EA
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhJ2KiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhJ2KiH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 06:38:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75062C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:35:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k7so15415622wrd.13
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sPm5mg8ZLoFJy5lBYR5Q5eP7wlsc0elf/64g1SeIR9Y=;
        b=L3/7u8i2RB2YFn0TgcxZkB2MW/tyKYghDTFDF3/SR0vuRldfpwgj0v79HBGSQHYvN7
         XAk2qPlcAeOq3+SUnWIjfglZ+mbut+17ljNPnts5PhhgVyjJTO9Ua3BtngxfCMZ9o4/D
         wzHlo7dK5XXTR/wMNDJp9hnpGDcg0/obVK3Wf/DC0D9zriGrH8iXBjlRacXQssWZXR7t
         o/tRUfMFxc+wyAUlunj3jW7NTSf3iuY+b32pwftpHpU77AE6qDQEHhRCcYa7VyHiYeG5
         F1Y2CSfzwHNZFEOJksFfe8org5OprXnq071bcLSf8g0nbvl/jlNkMzdrsj0lWz222Yxa
         7n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sPm5mg8ZLoFJy5lBYR5Q5eP7wlsc0elf/64g1SeIR9Y=;
        b=ddPsgNpmhtnmvA90bu6QuZaYLOFQkjdpqfPhiU6bEdeLBD5HdkyQ9vIAb4me5t8NfQ
         //4/5W5sTWHwWa83ldGLHfFz4doAvj0MhbNyLZq02MFFzXFUfelt1P1JfBJSXTpis3bJ
         tQ+fcmvAKOcZgTfFZ96kQizEFZF+ZMe3Z6YjcktYByuOv4h2FSjw8Jths9CK1GAFMqfo
         jJOjiZlpdcrRLz12cEKwGEXTXzhvVQmEIzHMKOd3LHEreIcR9srU4srsdeU5RL/zBLL7
         WPr3BkvMLpgmCqif5cYlwCNfc/kZupx5+a/seKDS3msLSgjKX/TOWqweb5iFEYJKEwtB
         YRWA==
X-Gm-Message-State: AOAM533Q87vNBGASFKwDiiHv4nIkGWHNyymFx//Kn6HiC9hDVD2l118U
        VCDn3XbEZAneKvAJp2WWeZQ=
X-Google-Smtp-Source: ABdhPJz+/im1yA/TzJntIlutmz4x41avKtFhfba9G0HNZBxL8IRQJXEq/BeMMfg0Uagbw71JUG9CRQ==
X-Received: by 2002:adf:db46:: with SMTP id f6mr13130590wrj.413.1635503738120;
        Fri, 29 Oct 2021 03:35:38 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id o11sm8326413wry.0.2021.10.29.03.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 03:35:37 -0700 (PDT)
Message-ID: <e911836c-1212-5d89-5e2a-78cc6c8f81be@gmail.com>
Date:   Fri, 29 Oct 2021 11:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 03/15] diff --color-moved: factor out function
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
 <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
 <658aec2670c78f9753a5acccab20d3a1741403e6.1635336262.git.gitgitgadget@gmail.com>
 <xmqqmtmsq0lg.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqmtmsq0lg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 28/10/2021 22:51, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This code is quite heavily indented and having it in its own function
>> simplifies an upcoming change.
> 
> And this should show as "moved" lines correctly in the output from
> "log -p --color-moved -w"?

rather that "-w" one can use "--color-moved-ws=allow-indentation-change" 
to highlight moved lines where the indentation has changed. It took me a 
while to realize why "-w" does not do anything here but it is because 
the lines are moved as well as having their indentation changed.

> ... not really.  There is an unfortunate artificial line wrapping in
> the original, which was unwrapped by this move, so the blocks do not
> exactly match.

Yes that's a shame, it seemed overkill to have one commit moving the 
code as is and then another reformatting it. All of the moved lines 
apart from the one that is unwrapped are highlighted with 
"--color-moved-ws=allow-indentation-change".

Best Wishes

Phillip

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   diff.c | 51 ++++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 34 insertions(+), 17 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index bd8e4ec9757..09af94e018c 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1098,6 +1098,38 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
>>   	return rp + 1;
>>   }
>>   
>> +static void fill_potential_moved_blocks(struct diff_options *o,
>> +					struct hashmap *hm,
>> +					struct moved_entry *match,
>> +					struct emitted_diff_symbol *l,
>> +					struct moved_block **pmb_p,
>> +					int *pmb_alloc_p, int *pmb_nr_p)
>> +
>> +{
>> +	struct moved_block *pmb = *pmb_p;
>> +	int pmb_alloc = *pmb_alloc_p, pmb_nr = *pmb_nr_p;
>> +
>> +	/*
>> +	 * The current line is the start of a new block.
>> +	 * Setup the set of potential blocks.
>> +	 */
>> +	hashmap_for_each_entry_from(hm, match, ent) {
>> +		ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
>> +		if (o->color_moved_ws_handling &
>> +		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
>> +			if (compute_ws_delta(l, match->es, &(pmb[pmb_nr]).wsd))
>> +				pmb[pmb_nr++].match = match;
>> +		} else {
>> +			pmb[pmb_nr].wsd = 0;
>> +			pmb[pmb_nr++].match = match;
>> +		}
>> +	}
>> +
>> +	*pmb_p = pmb;
>> +	*pmb_alloc_p = pmb_alloc;
>> +	*pmb_nr_p = pmb_nr;
>> +}
>> +
>>   /*
>>    * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
>>    *
>> @@ -1198,23 +1230,8 @@ static void mark_color_as_moved(struct diff_options *o,
>>   		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
>>   
>>   		if (pmb_nr == 0) {
>> -			/*
>> -			 * The current line is the start of a new block.
>> -			 * Setup the set of potential blocks.
>> -			 */
>> -			hashmap_for_each_entry_from(hm, match, ent) {
>> -				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
>> -				if (o->color_moved_ws_handling &
>> -				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
>> -					if (compute_ws_delta(l, match->es,
>> -							     &pmb[pmb_nr].wsd))
>> -						pmb[pmb_nr++].match = match;
>> -				} else {
>> -					pmb[pmb_nr].wsd = 0;
>> -					pmb[pmb_nr++].match = match;
>> -				}
>> -			}
>> -
>> +			fill_potential_moved_blocks(
>> +				o, hm, match, l, &pmb, &pmb_alloc, &pmb_nr);
>>   			if (adjust_last_block(o, n, block_length) &&
>>   			    pmb_nr && last_symbol != l->s)
>>   				flipped_block = (flipped_block + 1) % 2;

