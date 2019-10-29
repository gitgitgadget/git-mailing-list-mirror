Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530501F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 14:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfJ2OF6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 10:05:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55124 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfJ2OF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 10:05:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id g7so2710536wmk.4
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GNrJJsYnpFU1gGBFcNSKdiz6YUj1+nadlC5fsSuu+m8=;
        b=OJNvikXizmwsuRwY7Hs+iTV2TyzFLh85r0S0odp552sJ7/ly+0fpOl4SXzL8pr1qDu
         w6THRrzmjAXQ1phe+ZU7d0Vg/D2Dxv3PTA8QRhdvNYV4HOUTCpAk87qhw1+If3i8rNxU
         b05SXhgfO6x67evFcQcuabbNNW+acWL+cv1aer1uUopV+S2jtkAxMXLdHc4lL2yPuA+Q
         8DFYhSQPO64IS1OyPHFPXQM83R5Oc5AF9JtLAXWjPCCDZoeNwpA1gryinJgFdU7unUQt
         g1VcUXk9OiKMTwyTyJhfA0K0QgafJo7fvszy6GNg32RQRoZWv+yUTnAX8RYGRctnaR4b
         OEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GNrJJsYnpFU1gGBFcNSKdiz6YUj1+nadlC5fsSuu+m8=;
        b=DuyqKRGtSs5zjZB1o6WukW4Qnq/eg0nAMblrCbL48aM9PjGw68o2dlZvBi6/3eCJAt
         UqdUoLHTPwkYFQw8MXhblZ/6LbUzg4PdLpuphuUNZqsDn6w3QFUvCXGKND1hCvEslrLX
         TNK4hTPpBdZbVYu3kys/+PQaUsClBJ3FvqDxc4qmmJDL26dx12TtP/Qf0TuMMg4Wq+6+
         r6j60L7zmO4aZVCdR/PFI6I0prurpI2YjDlCBvt0nwZbx2mAGtMrdspI9eY0VQorIepv
         9byD3tfWvioPGGX7MaiR3sTa1CmQQ4OSyVPcC5oc92ooAy6zcDeI3b5Xyz5LqOqeHPJf
         Tqug==
X-Gm-Message-State: APjAAAXA94hT7O9RYBCiAE+3/D2N5BR31rq37VPDMDV4Qb0z1yZxkTSU
        C6fhN6IHIcyx+z8/sILINj6MQWb8
X-Google-Smtp-Source: APXvYqwhNbC7F/e37QWDhCMEK8zqVke9lIzpI4Cyb81p05pfH72TpWojl2S0VcTt1pcXvSZda5m4/w==
X-Received: by 2002:a1c:2b45:: with SMTP id r66mr4226378wmr.163.1572357955416;
        Tue, 29 Oct 2019 07:05:55 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.gmail.com with ESMTPSA id w22sm3101907wmc.16.2019.10.29.07.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 07:05:54 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: GIT_COMMITTER_* and reflog
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Luke Dashjr <luke@dashjr.org>, git@vger.kernel.org
References: <201910252149.23787.luke@dashjr.org>
 <20191026022039.GE39574@google.com>
 <xmqqv9scark1.fsf@gitster-ct.c.googlers.com>
 <20191026173702.GA5522@sigill.intra.peff.net>
 <xmqqr22ybcs7.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <08310159-41f9-43e2-5d54-a48fd403ad07@gmail.com>
Date:   Tue, 29 Oct 2019 14:05:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqr22ybcs7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio/Peff

On 27/10/2019 12:20, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> If somebody wants to pursue a patch, I suspect the solution is probably
>> something like this (totally untested):
> 
> Looks sensible.  It is very much unsatisfying that datestamp(),
> which is used by fmt_ident() when no date string is given, seems to
> totally bypass date.c::get_time(), which means the framework to give
> fake timestamp via GIT_TEST_DATE_NOW cannot be used to write
> reproducible tests.
> 
> Given that datestamp() is only used by the push certificate and
> fast-import codepaths and nowhere else, I suspect that "fixing" it
> retroactively to honor GIT_TEST_DATE_NOW would not have any negative
> fallout, but that's not something I should be contemplating on
> during the -rc period ;-)

It would allow for more robust am/rebase --ignore-date tests as we would 
know what date to expect rather than just checking the timezone.

Best Wishes

Phillip

> 
> Thanks.
> 
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index d60767ab73..2ebf2feeb8 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -1658,7 +1658,10 @@ static int files_log_ref_write(struct files_ref_store *refs,
>>   	if (logfd < 0)
>>   		return 0;
>>   	result = log_ref_write_fd(logfd, old_oid, new_oid,
>> -				  git_committer_info(0), msg);
>> +				  fmt_ident(getenv("GIT_COMMITTER_NAME"),
>> +					    getenv("GIT_COMMITTER_EMAIL"),
>> +					    WANT_COMMITTER_IDENT, NULL, 0),
>> +				  msg);
>>   	if (result) {
>>   		struct strbuf sb = STRBUF_INIT;
>>   		int save_errno = errno;
>>
>> -Peff
