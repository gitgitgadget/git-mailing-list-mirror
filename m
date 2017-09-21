Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D6F20281
	for <e@80x24.org>; Thu, 21 Sep 2017 02:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdIUCGF (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 22:06:05 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:55179 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdIUCGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 22:06:04 -0400
Received: by mail-qt0-f174.google.com with SMTP id i13so4635349qtc.11
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 19:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BBv4GE5zulCRcHFYUKcoQNIUwniKUW5tZntkVFcvWgE=;
        b=iUcUmAm7i8ISj4HzZbd1Kcg1tLS9XrXjmOajXIDEnu1wPvnhI2OFzrS0mKNqOyWTFp
         ZqV1pWEmkov8yD/t0q2bIA0qwOEReNrLBrvtSXRpZHv7uF+4D+WE/CFOoVZgRaohIEpd
         2/Wkk8vREn8EGocAltP/fUdqY5g9DXB2R7wNP2LbMGoN5zT3J7GYZFbMiJ4x8jE7N3fZ
         JToi8mjocIxW+Ab0vlLg5FM8h0B1Obd2iuOpL+WaDHJPOPPsKHRiOMeS+iByOw7CUjpk
         IJq91bX+LzzB1bIqg6QxJODtc3sekLXABbw/oUH4nLytoIAkHTub11Zp6KSRTKenhWSr
         3xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BBv4GE5zulCRcHFYUKcoQNIUwniKUW5tZntkVFcvWgE=;
        b=P92LgHZ8n6kJRYxoOyNN7F8yKKidoLsPIrdtPNx37SaqYTt9Mo/1IuiJYuLHFsMZR+
         kozSp0WHpzJEQN+GVPIz2aNA1lTMNTvb3yCfj/90dQTApmsddzAKF0/UeX1y375opQBI
         +1wtAO9Y5OcnY5RvD6CdqtvrWsEPXNIG6xEp4nThw+t2SpjCW5H5YgZxUrW3RR4w0Bu5
         aHr6SmUVmcAJrBAOwpZssZCNG4sX2GFm33YIWMqLOdsRXPGDADrxozIURuTp5oVfnriX
         nIwnJY5Huyl7VdPCfzO+72rboZoLZwdnzyioXTxfeR4EOHtAt2hdpVGQVyMGmUjEuHAr
         17vQ==
X-Gm-Message-State: AHPjjUglCwklDl2dECOPHiNV5665Ow/bhKhx/uLPoBEUqFZJ0Pc3MIgo
        sN8zGKfoKJ/ZJqSNQrZ95qI=
X-Google-Smtp-Source: AOwi7QDcKlkAWDZwcdRD7n89VgUj6INpGPj290ts04cEy5Zzu4DCYTJaeW/fwMt0ouhLnftFP1YmWQ==
X-Received: by 10.237.34.228 with SMTP id q33mr1016329qtc.278.1505959563207;
        Wed, 20 Sep 2017 19:06:03 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id v192sm243268qka.76.2017.09.20.19.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 19:06:02 -0700 (PDT)
Subject: Re: [PATCH v7 03/12] update-index: add a new --force-write-index
 option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-4-benpeart@microsoft.com>
 <xmqq7ewtor9u.fsf@gitster.mtv.corp.google.com>
 <682237f1-4747-5712-e95b-285379eb1b69@gmail.com>
 <xmqq8th8n7rf.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <28891f82-32e5-dc46-961c-a44e86e84989@gmail.com>
Date:   Wed, 20 Sep 2017 22:06:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8th8n7rf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/2017 9:46 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> Lets see how my ascii art skills do at describing this:
> 
> Your ascii art is fine.  If you said upfront that the capital
> letters signify points in time, lower letters are file-touching
> events, and time flows from left to right, it would have been
> perfect ;-)
> 

Rats, so close and yet... ;-)

>> There is no real concern about accumulating too many changes as 1) the
>> processing cost for additional modified files is fairly trivial and 2)
>> the index ends up getting written out pretty frequently anyway as
>> files are added/removed/staged/etc which updates the
>> fsmonitor_last_update time.
> 
> I still see some impedance mismatch here.  The optimization
> described is valid but the code to do the optimization would avoid
> writing the index file out when the in-core index is dirty only
> because the status reported by fsmonitor changed--if there were
> other changes (e.g. the code added a new index entry), even with the
> optimization, you would still want to write the index out, right?
> 

Yes, that is exactly how it works.  FSMONITOR_CHANGED is only set when 
the fsmonitor index extension is added or removed but all the other 
logic to flag the index dirty (CE_ENTRY_CHANGED/REMOVED/ADDED, 
UNTRACKED_CHANGED, etc) still exists and will still trigger the index to 
be written out as it always has.  It's not to say some of these other 
changes could not do the same optimization (I haven't looked) if 
recomputing is cheaper than writing out the index.

> With or without the need for forced flush to help debugging, would
> that suggest that you need two bits now, instead of just a single
> 'active-cache-changed' bit?
> 
> By keeping track of that new bit that tells us if we have
> fsmonitor-only changes that we _could_ flush, this patch can further
> reduce the need for forced flushing (i.e. if we know we didn't get
> fsmonitor induced dirtyness, force_write can still be no-op), no?
> 

Yes, I suppose we _could_ add a 2nd bit (and then add the logic to set 
that bit every time a fsmonitor change was made) but I don't see that it 
really buys us anything useful.  The force write flag in update-index is 
off by default and the only scenario we have that someone would set it 
is for test cases where the perf of writing out the index when it is not 
needed just doesn't matter.

>>
>> The challenge came when it was time to test that the changes to the
>> index were correct.  Since they are lazily written by default, I
>> needed a way to force the write so that I could verify the index on
>> disk was correct.  Hence, this patch.
>>
>>
>>>>    		OPT_END()
>>>>    	};
>>>>    @@ -1147,7 +1150,7 @@ int cmd_update_index(int argc, const char
>>>> **argv, const char *prefix)
>>>>    		die("BUG: bad untracked_cache value: %d", untracked_cache);
>>>>    	}
>>>>    -	if (active_cache_changed) {
>>>> +	if (active_cache_changed || force_write) {
>>>>    		if (newfd < 0) {
>>>>    			if (refresh_args.flags & REFRESH_QUIET)
>>>>    				exit(128);
