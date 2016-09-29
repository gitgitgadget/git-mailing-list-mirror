Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD134207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbcI2VAH (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34688 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933604AbcI2VAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id w72so590873wmf.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=foTDtJ48BkVDUrz6mJCdfnQDNOToF2Mw9N7SstuuBK0=;
        b=VCDSU4L0rAIwV+VI/aiW8ahNzAyTFxkDILTgLYcRxwKjhZzr3OFVYBAt7uI7UudvZ2
         T/hTvtsQ+r69rAxo5cQnvmTN6yuI8jRaQaqyuEbVhBRhiNSReXQTEeu2A/Yd3zZItoyU
         7YYkYyUbl9hUNTKzbu0Uvi2wM6vkpCtaZ3nM8zW7PvWOtH75hWObeI9CYLiuS/mmAZcM
         nAfrSPsMqCMb4DkQVKG/Zs26fM5BzI2mPZrNolnM/rL1B02XMfsQK6qM8tZOU6xZAGFR
         qp9q8XgiCbKUWY77ETt0FUiapozlnZO6ChDpILdHRFiKlayqdTSnxvePc3tLpZQhjyQe
         eTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=foTDtJ48BkVDUrz6mJCdfnQDNOToF2Mw9N7SstuuBK0=;
        b=V9SawOmjHgNBrCSWRhB2XF4lUlR3vAnNLig3Z79UdTYpLl7L7j7XYr6kKRfx8xh04D
         S+RVlP9/P0igTYS8VDGCyDSSzvUaZMPHMEYzBCIOvIdH/XcqBYlbWR94j2gzneE11gkj
         GAKXcCOydXbEAo8+MBRuBGWDgBa3QunGYu9Adw1PnG+E/qaOIfI1HjMQ5edIrfBysQLo
         uTa5Vx9P2msXoIIIWruSx0sF9LLlRr9wrZReDgmy6xHQo/Qo3VU4OtaLTkFYEHzaKc83
         c8jeyomO5PbQuMTkFEje2GYFIwBKkUYjj3vdjaP4Cxa/CTaHGKq9I5cbAN+Sjh27PDDl
         6bsw==
X-Gm-Message-State: AA6/9RklIjgr5/YWd+ZwqFNL86KrI2zDNRKJEq6Bxt/cmXlKFLOFOcDhX0V8CYRyigpRdQ==
X-Received: by 10.28.38.69 with SMTP id m66mr476987wmm.133.1475182804449;
        Thu, 29 Sep 2016 14:00:04 -0700 (PDT)
Received: from [192.168.1.26] (eln216.neoplus.adsl.tpnet.pl. [83.21.207.216])
        by smtp.googlemail.com with ESMTPSA id s6sm16093473wjm.25.2016.09.29.14.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Sep 2016 14:00:03 -0700 (PDT)
Subject: Re: [PATCH v8 00/11] Git filter protocol
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
 <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
 <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f9a6dd02-34c0-d48b-3cbc-73202488920c@gmail.com>
Date:   Thu, 29 Sep 2016 22:59:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.09.2016 o 13:57, Torsten Bögershausen pisze: 
> On 29/09/16 12:28, Lars Schneider wrote:

>> This is what happens:
>>
>> 1) Git exits
>> 2) The filter process receives EOF and prints "STOP" to the log
>> 3) t0021 checks the content of the log
>>
>> Sometimes 3 happened before 2 which makes the test fail.
>> (Example: https://travis-ci.org/git/git/jobs/162660563 )
>>
>> I added a this to wait until the filter process terminates:
>>
>> +wait_for_filter_termination () {
>> +    while ps | grep -v grep | grep -F "/t0021/rot13-filter.pl" >/dev/null 2>&1
>> +    do
>> +        echo "Waiting for /t0021/rot13-filter.pl to finish..."
>> +        sleep 1
>> +    done
>> +}
>>
>> Does this look OK to you?
> Do we need the ps at all ?
> How about this:
> 
> +wait_for_filter_termination () {
> +    while ! grep "STOP"  LOGFILENAME >/dev/null
> +    do
> +        echo "Waiting for /t0021/rot13-filter.pl to finish..."
> +        sleep 1
> +    done
> +}

Or even better: make filter driver write its pid to pidfile, and then
"wait $(cat rot13-filter.pid)".  That's what we do in lib-git-daemon.sh
(I think).

If the problem is exit status of "wait" builtin, then filter driver
can remove its pidfile after writing "STOP", just before ending.

-- 
Jakub Narębski

