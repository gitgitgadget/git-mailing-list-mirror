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
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C491F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfGAOHK (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:07:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38382 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbfGAOHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:07:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id 9so6663296ple.5
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G23cUY5f6oYZSTMVfldLHRKR+cNU0Yhc428/380T4V4=;
        b=OGulHDIubzxKtcJOQMy+VkMAg+xO58g7TkFi6o7WUVMnw6a9efOzgxWVd2vQcyCeJa
         A91O2KyiyzdPkaVmyTfnJRc7ZABPMxv1Xbkq8CUdFXI6wvKItSmscQxCzFnpf3Tp6shb
         /sgCry0Wu9FCt8HQoD61Zpb6BgY8pWKh3j4SFwqoDsk5joILQm79UxxPKa6/KHUlXtJc
         5c306nSIT8SIz/f5ChD0bPGxqSNJ/DqqxYb+4UT2GXRAe96XaAP36DHn7qf60pmCTh3K
         i9fH0QLyGYf2obNoLVg4v85mfAteS9/nBcsbzBcrUOrL3IVXtgCRi3v/lYybVhWjJsyy
         H2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G23cUY5f6oYZSTMVfldLHRKR+cNU0Yhc428/380T4V4=;
        b=S8v5K7LoJxrl1ofutkS3t+a7edT+yMki97hoXYKc86bNXHLxpaBBY41ZxLMh6vfixR
         YigjlO9EnT1klhq4wTMKOtrcUL4clVCyZFxOr9mvfujzrNz0Li4QNxW4UsJRwCvKUxMQ
         VumjHvFISR/uKCYEYRb0Mfvr7CLQuAwSq/Zm5xH5ijZ9h34rtlVbG2hRNZ3AvqAbp0rB
         QiOTm5S5ElYJPsqnjAP2dEklsjfaYEffiPbKxEtoIQnD69L2ejJ0UZW1lNgyoAgucsPl
         tI4z2T6DPrkWfEdhY2BGuV6xNUmsMwROy95z0ktZoO+3UtOxTMdLhH+zWbpDbO5Vn6bu
         XkuQ==
X-Gm-Message-State: APjAAAUIyQBm5zilAsEDBSNfNco5NcaCMZMfOBEYVL61MxLPdbsnW9iH
        gIuqmtzglgNt/PQ8NyzXmlluAKG24rU=
X-Google-Smtp-Source: APXvYqzXWJr5lx3goWUzN9UDL63SlvwGG4mXDPrRevxaAZhu+TS64h5VmZeNZR/HI1BHDB1CuCY92A==
X-Received: by 2002:a17:902:a60d:: with SMTP id u13mr21327481plq.144.1561990028599;
        Mon, 01 Jul 2019 07:07:08 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id f10sm9428700pgo.14.2019.07.01.07.07.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:07:07 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
 <20190628062457.GA18662@sigill.intra.peff.net>
From:   Barret Rhoden <brho@google.com>
Message-ID: <4d466fce-15df-3a73-f5f9-f29bc5b79a04@google.com>
Date:   Mon, 1 Jul 2019 10:07:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190628062457.GA18662@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/19 2:24 AM, Jeff King wrote:
> On Wed, Jun 26, 2019 at 03:29:29PM -0700, Junio C Hamano wrote:
> 
>> * br/blame-ignore (2019-06-20) 9 commits
>>   - blame: add a test to cover blame_coalesce()
>>   - blame: use the fingerprint heuristic to match ignored lines
>>   - blame: add a fingerprint heuristic to match ignored lines
>>   - blame: optionally track line fingerprints during fill_blame_origin()
>>   - blame: add config options for the output of ignored or unblamable lines
>>   - blame: add the ability to ignore commits and their changes
>>   - blame: use a helper function in blame_chunk()
>>   - Move oidset_parse_file() to oidset.c
>>   - fsck: rename and touch up init_skiplist()
>>
>>   "git blame" learned to "ignore" commits in the history, whose
>>   effects (as well as their presence) get ignored.
>>
>>   Will merge to 'next'.
>>   cf. <20190620163820.231316-1-brho@google.com> (v9)
> 
> My -Wunused-parameter branch complained about merging with this. Since
> it's in 'next', we'd want something like this on top, I think (ideally
> after Barret confirms my hand-waving below).

Looks good to me.

Thanks,

Barret


> 
> -- >8 --
> Subject: [PATCH] blame: drop some unused function parameters
> 
> These unused parameters were introduced recently as part of the
> br/blame-ignore topic. I assume they are not indicative of bugs, but are
> just leftovers from the development process (they were introduced by the
> series but not used in any of its iterations).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   blame.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/blame.c b/blame.c
> index 86f6b2bd33..acb1bf7f7a 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -981,7 +981,7 @@ static int *fuzzy_find_matching_lines(struct blame_origin *parent,
>   	return result;
>   }
>   
> -static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *file)
> +static void fill_origin_fingerprints(struct blame_origin *o)
>   {
>   	int *line_starts;
>   
> @@ -1035,7 +1035,7 @@ static void fill_origin_blob(struct diff_options *opt,
>   	else
>   		*file = o->file;
>   	if (fill_fingerprints)
> -		fill_origin_fingerprints(o, file);
> +		fill_origin_fingerprints(o);
>   }
>   
>   static void drop_origin_blob(struct blame_origin *o)
> @@ -1653,7 +1653,6 @@ static void guess_line_blames(struct blame_origin *parent,
>    */
>   static void ignore_blame_entry(struct blame_entry *e,
>   			       struct blame_origin *parent,
> -			       struct blame_origin *target,
>   			       struct blame_entry **diffp,
>   			       struct blame_entry **ignoredp,
>   			       struct blame_line_tracker *line_blames)
> @@ -1802,7 +1801,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
>   			samep = n;
>   		}
>   		if (ignore_diffs) {
> -			ignore_blame_entry(e, parent, target, &diffp, &ignoredp,
> +			ignore_blame_entry(e, parent, &diffp, &ignoredp,
>   					   line_blames + e->s_lno - tlno);
>   		} else {
>   			e->next = diffp;
> 

