Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662E41F453
	for <e@80x24.org>; Mon,  5 Nov 2018 20:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeKFFWL (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 00:22:11 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:37582 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeKFFWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 00:22:11 -0500
Received: by mail-qk1-f177.google.com with SMTP id 131so17062739qkd.4
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uVCejz3QUpkAkt2ROpW0dmC4C3GiTGvrAbN8ifxi1ck=;
        b=mkaD/zpqz/xZWazeVzTjNN75zvFIDT5/lFi61xZL5HuyftfMyaxC78gcqcgDDVaCYW
         yJVdtG971hJ6YveWBS9uJ7dcCqj56FtJu7yBefoNg2asu4gPg+aKPe0DHN3slJockKcv
         cylzBWXHD0ADnyjCWd/a5Cm1cc2Xk9aqwOF1DWSyWUf/hbFfgGDYyNj5za8GN1hCcXRs
         6fwxDjgyPPF5OpTsMl2NhmhKx5hYz5ahzJFfDNQ+q2UdwTs2WAnhYTGba0u8mK+iHDbA
         PIRZOxN7DmEE3Rwm0rvtaoz+eTfH1VIoLfbGeo2cEnz4kWKAnd/NzjA5qN9ApoOxOVZ1
         vAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uVCejz3QUpkAkt2ROpW0dmC4C3GiTGvrAbN8ifxi1ck=;
        b=W8PxzRxzah4y72u4/vM6Ncjr5WIt8hoQIuBMQLMD9tc62QEO3ocuGsFGJWMcjnDycS
         fvzin1eTp67JgElNeQJN9bWp9PWIUWIGM2PhR0kgszwjnSerbPSa66Krs5ZpBtVoddj4
         XekB8sTloEf5HKkp7vv5j473K5LGuuQ7ELO2YQWuwX7VhDcakZH49Ixk0RV4frwY9DuW
         PQDS2x91MF09SxLfXVuLDqZjJFTSbaBV0kE3EYVPXmgGJ08GVGDxeVazgtymBtOSAaOM
         3bqD+Xg8OiAZS43oLoakrG71HzjEymI5IfZRvddeli/BKHrN0d1oyAYzL0vm6vQ0ieNG
         TPFw==
X-Gm-Message-State: AGRZ1gIWHLHhJremCYK8/hqdPhLHQlN2+Qaf2z0uDk3PXCLHLfudZWf9
        0TCZ+Hqy78TUlp8rSj0/PJS/gnyr
X-Google-Smtp-Source: AJdET5eALIrA6fqInOnIKh6oJ1KSHB9lhrzPmVy9t/BeqFcD2KuPi8VgHm6hw7Mxl7Ik7SZpZ5DVlQ==
X-Received: by 2002:a37:9ce:: with SMTP id 197mr21361944qkj.164.1541448050980;
        Mon, 05 Nov 2018 12:00:50 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m49sm1099588qtb.40.2018.11.05.12.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:00:50 -0800 (PST)
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>
References: <20181030191608.18716-1-peartben@gmail.com>
 <xmqqsh0nyqx9.fsf@gitster-ct.c.googlers.com>
 <dbc2eb4f-842e-f49a-256f-3a140d801bb0@gmail.com>
 <xmqqa7momlx6.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <140226a2-a40e-1965-b665-46eec81d907a@gmail.com>
Date:   Mon, 5 Nov 2018 15:00:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqa7momlx6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/4/2018 7:02 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>>>> +	if (*dtype == DT_UNKNOWN)
>>>> +		*dtype = get_dtype(NULL, istate, pathname, pathlen);
>>>
>>> We try to defer paying cost to determine unknown *dtype as late as
>>> possible by having this call in last_exclude_matching_from_list(),
>>> and not here.  If we are doing this, we probably should update the
>>> callpaths that call last_exclude_matching_from_list() to make the
>>> caller responsible for doing get_dtype() and drop the lazy finding
>>> of dtype from the callee.  Alternatively, the new "is excluded from
>>> vfs" helper can learn to do the lazy get_dtype() just like the
>>> existing last_exclude_matching_from_list() does.  I suspect the
>>> latter may be simpler.
>>
>> In is_excluded_from_virtualfilesystem() dtype can't be lazy because it
>> is always needed (which is why I test and die if it isn't known).
> 
> You make a call to that function even when virtual-file-system hook
> is not in use, i.e. instead of the caller saying
> 
> 	if (is_vfs_in_use()) {
> 		*dtype = get_dtype(...);
>                  if (is_excluded_from_vfs(...) > 0)
> 			return 1;
> 	}
> 
> your caller makes an unconditional call to is_excluded_from_vfs().
> Isn't that the only reason why you break the laziness of determining
> dtype?
> 
> You can keep the caller simple by making an unconditional call, but
> maintain the laziness by updating the callig convention to pass
> dtype (not *dtype) to the function, e.g..
> 
> 	if (is_excluded_from_vfs(pathname, pathlen, dtype) > 0)
> 		return 1;
> 
> and then at the beginning of the helper
> 
> 	if (is_vfs_in_use())
> 		return -1; /* undetermined */
> 	*dtype = get_dtype(...);
> 	... whatever logic it has now ...
> 
> no?
> 

Oops!  You're right, I docall get_dtype() even if the vfs isn't in use. 
I'll add an additional test to avoid doing that.  Thank you.

I did look into moving the delay load logic into is_excluded_from_vfs() 
but get_dtype() is static to dir.c and I'd prefer to keep it that way if 
possible.

>> Your comments are all feedback on the code - how it was implemented,
>> style, etc.  Any thoughts on whether this is something we could/should
>> merge into master (after any necessary cleanup)?  Would anyone else
>> find this interesting/helpful?
> 
> I am pretty much neutral.  Not strongly opposed to it, but not all
> that interested until seeing its integration with the "userland" to
> see how the whole thing works ;-)
> 
