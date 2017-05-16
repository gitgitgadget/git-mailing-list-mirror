Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BB4201A7
	for <e@80x24.org>; Tue, 16 May 2017 01:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdEPBPR (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 21:15:17 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34324 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdEPBPP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 21:15:15 -0400
Received: by mail-qk0-f196.google.com with SMTP id u75so20279052qka.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 18:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=qWhhmMfxR3985txeREQNCDRz0rTQeUukgwDAkmZdg/I=;
        b=Fwwb+p6qMpbBjnCJg35Eunb1/mfN2yTgsFu8VTRZL/rCy1B8ekrXI+2Ibib2p8+HpH
         4YjDwQ1iiAjn9SaaoI5XhAbQSvVpx/gceCOV6dltu7B0HxDS/VNBpjb22sIg/h4aPtDE
         mFlAdYhoTehhRjVg3OkGFHS7xdHmGcJVZnUPVUJG72fpxOAy+LAW/JkZMamthNGCCtj7
         hascBQVpGEvaT9aZrhAQ6v0R/yAVFRuKyH0SSKik7BcGEfRGhyrzbAo0OcSinN3ki0om
         i73MtTfzzAmyjbf7/LF/et5tM82HCYj3qKV1STjkyMZswLZd3gDfLqJnpnBrbgQo6/UI
         R86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=qWhhmMfxR3985txeREQNCDRz0rTQeUukgwDAkmZdg/I=;
        b=ilAUyIQ9gz8lrA5vC095M5hH8mXExReTxVkfzShO8LI5KW/7OrVGqLEV9C4P1a4WSB
         TexkSZ7Dq6DzcQl29T7WiyaAXtXznUCE3DDmQXiibtmt1CyXGl/VDC+3okjLfUdT/702
         kPHqtAciGYkhzE8xqp1VSf3RWB6nRKrK+z85uPPlnijodb0IF1/UleOltruU/cgnuBQP
         fXi01/lXruKeWznFS40H021Za/QJHL9aT9dUF2wRCKoA6sB5Hou3zvd1TmHS9ck7AHRO
         Q86vb7m+2VEk+xF5mGYtf2qKb2Q/MGzfroP0Q6s3B1984Lda6tr06ZO4ulaMmLCqCoh7
         3aPA==
X-Gm-Message-State: AODbwcCceduBwvEh6+IGqzfaBg/qfEpa4j85BABgokeLEB7sp3k+rDf7
        2SMlTjr39Bw+9A==
X-Received: by 10.55.18.91 with SMTP id c88mr8635220qkh.143.1494897314836;
        Mon, 15 May 2017 18:15:14 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d34sm9776735qta.59.2017.05.15.18.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 18:15:14 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
To:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <d195af80f27e4fea85a96d6435b36139@exmbdft7.ad.twosigma.com>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "benpeart@microsoft.com" <benpeart@microsoft.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "peff@peff.net" <peff@peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <00db0fd9-e873-79f4-0497-0fec6c98d937@gmail.com>
Date:   Mon, 15 May 2017 21:15:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d195af80f27e4fea85a96d6435b36139@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 5/15/2017 5:21 PM, David Turner wrote:
>
>> -----Original Message-----
>> From: Ben Peart [mailto:peartben@gmail.com]
>> Sent: Monday, May 15, 2017 3:14 PM
>> To: git@vger.kernel.org
>> Cc: gitster@pobox.com; benpeart@microsoft.com; pclouds@gmail.com;
>> johannes.schindelin@gmx.de; David Turner <David.Turner@twosigma.com>;
>> peff@peff.net
>> Subject: [PATCH v1 2/5] Teach git to optionally utilize a file system monitor to
>> speed up detecting new or changed files.
>
>> @@ -342,6 +344,8 @@ struct index_state {
>>  	struct hashmap dir_hash;
>>  	unsigned char sha1[20];
>>  	struct untracked_cache *untracked;
>> +	time_t last_update;
>> +	struct ewah_bitmap *bitmap;
>
> The name 'bitmap' doesn't tell the reader much about what it used for.
>
>> +static int update_istate(const char *name, void *is) {
>
> Rename to mark_file_dirty?  Also why does it take a void pointer?  Or return int (rather than void)?
>

Thanks for the feedback.  I'll do some renaming and change the types passed.


>> +void refresh_by_fsmonitor(struct index_state *istate) {
>> +	static has_run_once = FALSE;
>> +	struct strbuf buffer = STRBUF_INIT;
>
> Rename to query_result? Also I think you're leaking it.
>

Good catch!  I missed the leak there.  Fixed for the next roll.
