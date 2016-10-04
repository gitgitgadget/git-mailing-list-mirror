Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCA920986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbcJDVAV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:00:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34356 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbcJDVAT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:00:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so16357468wmb.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2frzNyEPS4GO7BK1U/0xIVDeCs/djVJlL4M3wzUheB0=;
        b=LpIhD+rIym9prUCJAYpzFnQ/Sske7ggF9SD7eawJr1/CXJ3OiylZTuQovcCo/aPJt+
         s2479XxwKObNPvx8V2gIEU9T0oZICQjLmH5EMEHJ7Cl0TZsT5ouuLnD6ksdUlvYFsCua
         Dpzlf9nzlZscAIeJtF5QQ/fTpLME5gssQuoayhQ6b+4deEn9itPj54myLc9uu9RpzfGe
         gdwC5T3xviSCUfCjCJdCwqDWMNXJBtEVFbWEe5+XLSHuytNjUQ9Z9fvxVT0onxCcVKS0
         CaT98jMpBSCZrJj4zfCm8y4P8HrGoO+9XAd7IbAj8HOCi+AWpkteZA2WjTvSmrr43dN/
         GZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2frzNyEPS4GO7BK1U/0xIVDeCs/djVJlL4M3wzUheB0=;
        b=YZuQ/wSflZqm2oyayHRXwGWscjpDmPNlf+BqbIb/2GZTP7kqS2M07Vjg1ExFowYH7/
         h0QPEUAwsaDCEZcX+1elVZkgnwtSz0TZlO3y0N2laMEimpmRMOFkfWhlj3r0u4Os7XRb
         RdVP36FgRRL7P469NDHO1+JWA2bt83dUWNzxlMWghZAZaWgd7hbUMexlNeHNMRFTYZ2V
         DUgScqBWnBzrs53IGjEhKZNDLP3IFsBzlA1sSkIm2Hlx/G8cClBMCw6UCN3hwiy719g/
         uwXr/R/n0kYnzPpV6SpUx0M1gPqm8UJElTDMEHznof6u73g2UlXP0kNJ85ojgpe54atV
         9U4A==
X-Gm-Message-State: AA6/9RluNn+vXSwb7yoR2cnAVAGLOLzYHSgKJFAx7rbWyDkFwWzkS8VJl11ce5nihWDymw==
X-Received: by 10.194.108.230 with SMTP id hn6mr3240263wjb.122.1475614818268;
        Tue, 04 Oct 2016 14:00:18 -0700 (PDT)
Received: from [192.168.1.26] (dbs112.neoplus.adsl.tpnet.pl. [83.23.44.112])
        by smtp.googlemail.com with ESMTPSA id k2sm26040307wmg.23.2016.10.04.14.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 14:00:17 -0700 (PDT)
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-12-larsxschneider@gmail.com>
 <2a604438-b6cd-876d-0ec2-90027dea99b9@gmail.com>
 <EF3723DE-B34A-4314-94C9-E3EB38EAB92A@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d4ad73af-d14b-03dd-0634-d8919a1d2ddd@gmail.com>
Date:   Tue, 4 Oct 2016 23:00:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <EF3723DE-B34A-4314-94C9-E3EB38EAB92A@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Some of answers and comments may got invalidated by v9]

W dniu 30.09.2016 o 21:38, Lars Schneider pisze:
>> On 27 Sep 2016, at 17:37, Jakub Narębski <jnareb@gmail.com> wrote:
>>
>> Part second of the review of 11/11.
[...]
>>> +
>>> +	if (start_command(process)) {
>>> +		error("cannot fork to run external filter '%s'", cmd);
>>> +		kill_multi_file_filter(hashmap, entry);
>>> +		return NULL;
>>> +	}
>>
>> I guess there is a reason why we init hashmap entry, try to start
>> external process, then kill entry of unable to start, instead of
>> trying to start external process, and adding hashmap entry when
>> we succeed?
> 
> Yes. This way I can reuse the kill_multi_file_filter() function.

I don't quite understand.  If you didn't fill the entry before
using start_command(process), you would not need kill_multi_file_filter(),
which in that case IIUC just removes the just created entry from hashmap.
Couldn't you add entry to hashmap in the 'else' part?  Or would it
be racy?

[...]
>>> +static void read_multi_file_filter_values(int fd, struct strbuf *status) {
>>
>> This is more
>>
>>  +static void read_multi_file_filter_status(int fd, struct strbuf *status) {
>>
>> It doesn't read arbitrary values, it examines 'metadata' from
>> filter for "status=<foo>" lines.
> 
> True!
>
>>> +		if (pair[0] && pair[0]->len && pair[1]) {
>>> +			if (!strcmp(pair[0]->buf, "status=")) {
>>> +				strbuf_reset(status);
>>> +				strbuf_addbuf(status, pair[1]);
>>> +			}
>>
>> So it is last status=<foo> line wins behavior?
> 
> Correct.

Perhaps this should be described in code comment.
 
>>>
>>> +	fflush(NULL);
>>
>> Why this fflush(NULL) is needed here?
> 
> This flushes all open output streams. The single filter does the same.

I know what it does, but I don't know why.  But "single filter does it"
is good enough for me.  Still would want to know why, though ;-)
 
>>>
>>> +	if (fd >= 0 && !src) {
>>> +		if (fstat(fd, &file_stat) == -1)
>>> +			return 0;
>>> +		len = xsize_t(file_stat.st_size);
>>> +	}
>>
>> Errr... is it necessary?  The protocol no longer provides size=<n>
>> hint, and neither uses such hint if provided.
> 
> We require the size in write_packetized_from_buf() later.

Don't we use write_packetized_from_fd() in the case of fd >= 0?

[...]

Best,
-- 
Jakub Narębski

