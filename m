Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4D11F42B
	for <e@80x24.org>; Sat, 11 Nov 2017 02:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754532AbdKKCuu (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 21:50:50 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:50125 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdKKCut (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 21:50:49 -0500
Received: by mail-wr0-f169.google.com with SMTP id o88so10048732wrb.6
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 18:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DsDVGN7zGdCDg9vCAE2h0b/t6aE/vQDORxs5RTovBgA=;
        b=FR6BCLjzeJNRcWJkIfzShEhwxPqZHeBOP0hvjLR+oqci3qSmj1vzeTqsYT/IrCNKDI
         EWnULvU7epm3BmFL6kzLONT1oF4KmNjkQvShngiA5OzEtjmgLGgLgiNmz5ipjqhed9vR
         MQPHzyynF4aeukY1S2heJ/jkT96rLI+EmOo7kSewjcWrB66Ci69BQTurKBOH/hjXOVTx
         +oX50LA7LUpW1HUAbbOc7wcGlml/2Quk12Kt4jd4Td2vo5bh9irY6OCMa7QCMCCxmQPA
         JbXzQ+PAggD+qHyiFpy4iQXMxNiSOpAiShE6HtgNJEXLomRDmuucul6623MvRcAi6Hx3
         JMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DsDVGN7zGdCDg9vCAE2h0b/t6aE/vQDORxs5RTovBgA=;
        b=JMnhE4fJl6KhI3STsJ6eNixIzOZuT6s8O7mHk3tZNQ+3IBhaG1XfjzUyaEdABaocu8
         kr4RIaPiJEmlyol+BfzHVyrUZEoAly2KnW/eohpMJqCbxZCtbYeeKJVPTZAHIsG92mWE
         MS4S/CxTETGH5NA3t6sN6mhJ/Wmw4yDsthuXQC81HB5SFCumwWFPybU2sxn4CwXLfMbs
         ZbSyXOBF8iXLwWg85kVwCYjgh8vS1FqUNQ7kOMHcQqs5dslZzO9frVqY6AI46F21QnTM
         iBjDXBEB4WPiulGlNc91izHEb9xnAaIS6TXuWjbhvJlSwsdIjC9j9v+7A5GS3OLEXbi5
         yxew==
X-Gm-Message-State: AJaThX6mdr0XJW4UsjAFz2cqXw6swFcxV8s5K4/Umk3r4CxUIzjrBoEG
        r1eTk4e0MQYzBcq21XD0DMBxEzEF0Hc=
X-Google-Smtp-Source: AGs4zMZ3QAqqX2yCXS0cmiTdSjanhe2r1CgZI///gbBHiiCaZF6t0PWE5pmv2HVt4rjWO6KW+9hPsQ==
X-Received: by 10.223.135.143 with SMTP id b15mr1694860wrb.278.1510368648525;
        Fri, 10 Nov 2017 18:50:48 -0800 (PST)
Received: from [192.168.1.8] (93-87-220-139.dynamic.isp.telekom.rs. [93.87.220.139])
        by smtp.gmail.com with ESMTPSA id g4sm7632779wrh.19.2017.11.10.18.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 18:50:47 -0800 (PST)
Subject: Re: Unify annotated and non-annotated tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     anatoly techtonik <techtonik@gmail.com>, git@vger.kernel.org
References: <CAPkN8x+MELCnttE+xptKzYXsYPWqbiE59LABrwNBhFroayc+wQ@mail.gmail.com>
 <ec4be1c2-a0cc-cec8-a566-06c11c8abe06@gmail.com>
 <xmqqh8u1efh5.fsf@gitster.mtv.corp.google.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <59bd5e13-01a5-6c39-04bf-c60cab4004e5@gmail.com>
Date:   Sat, 11 Nov 2017 03:50:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8u1efh5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2017 03:06, Junio C Hamano wrote:

> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
> 
>> If you would like to mimic output of "git show-ref", repeating 
>> commits for each tag pointing to it and showing full tag name as 
>> well, you could do something like this, for example:
>>
>> 	for tag in $(git for-each-ref --format="%(refname)" refs/tags)
>> 	do
>> 		printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>> 	done
>>
>>
>> Hope that helps a bit.
> 
> If you use for-each-ref's --format option, you could do something
> like (pardon a long line):
> 
> git for-each-ref --format='%(if)%(*objectname)%(then)%(*objectname)%(else)%(objectname)%(end) %(refname)' refs/tags
> 
> without any loop, I would think.

... and I did have a feeling it should be possible in a single Git 
command :P Thanks.
