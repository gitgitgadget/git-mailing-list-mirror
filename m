Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF419C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 08:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1879610FC
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 08:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFGJAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:00:49 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36422 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGJAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 05:00:49 -0400
Received: by mail-pf1-f178.google.com with SMTP id c12so12616611pfl.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xtSEuEhkMoKdNhOOXRAuf5+O7NppcrJpYM+ovAb9Ido=;
        b=RStAuALjsbPMQhKF0GFhQ1It2frntrBIfQT3kVYRJCb7s5Is/rcRizCkWsv74rzU73
         N6LBsIKGRdUw+0Ufyxtl4mpXsidVM6UKQezsz0MAXeeIakkryabmXivDzb1rqx72BTRW
         o1d12rdFUfj/VDZFgH+iGuGg6/A6+Czga38ATxiQLcXk/+FAqfjpnCIH4BRPf96s4mEB
         IIsQUsY4uDrnDwVB7Wv5lIigZOeAnYVxj2XN8RWOmtGKMtYUCE7XmOtXZ4V0OOYuegcl
         KSKtiLR2ZcRXRwOIBUCcE7/aneqFY7BCSnCzQCoWsVZG2rzO5mchPqTSPLltxf124ttQ
         q8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtSEuEhkMoKdNhOOXRAuf5+O7NppcrJpYM+ovAb9Ido=;
        b=azEHyqz59XU7/vNb1T0I10Cl7ifaxiO6G+WC+ToL/8lglSRrYqCD3haThHYBAZ9uMQ
         ugDtgGEbhKWb0xFy3qBg7FmKQ5+/BLjWBHfMpd1h0+RFKMXBfY6QxiYZxjEXHyR/Dy/l
         JBJM58m/WIQ30YgGJSyabniQYxYh2oKNl2mbI0D8Mze5+LC34d0inkVchK6c+G+Jr8by
         PEqWoI3gNHEgghOkaSnT9bjNiBZ1uQ9rxYCIdTUVVLlmgBgGtL8/BtouoYlgsXx3Tyn/
         LDsAj0PRQkHlTbqY8fL/W9nWh24PRujkxxhjCWEv2Fhngg5RseSyPSXws8eukh6KzG+v
         AC5A==
X-Gm-Message-State: AOAM530/v5BUNi8fJdxVrfJQqvIRd/fRsAzCRn9XOfmCI4HC8xf60nNy
        Fb9frs1A4GbJORBX4qVZ1P1xKTXi625j/Q==
X-Google-Smtp-Source: ABdhPJxBcYba5oMLKCLAt96aivlzdtfb0GIsNN8u1gKKiTU7RZX0sYYWXqNfJZ3bW69dn3R70yFpNw==
X-Received: by 2002:a63:701:: with SMTP id 1mr5512607pgh.198.1623056277972;
        Mon, 07 Jun 2021 01:57:57 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-52.three.co.id. [116.206.12.52])
        by smtp.gmail.com with ESMTPSA id s13sm6958673pjm.34.2021.06.07.01.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 01:57:57 -0700 (PDT)
Subject: Re: [GSoC] My Git Dev Blog - Week 3
To:     Atharva Raykar <raykar.ath@gmail.com>, git <git@vger.kernel.org>
References: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <37725450-9769-01f1-d615-b3869ebbb33d@gmail.com>
Date:   Mon, 7 Jun 2021 15:57:55 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 06/06/21 19.26, Atharva Raykar wrote:
> Hi,
> 
> Here is my latest instalment in my weekly Git blog:
> http://atharvaraykar.me/gitnotes/week3
> 

You said:

> Simple enough, I thought. Just fast-forward merge (A) on master, and then, uhh, cherry pick and apply (B) on top of the newly merged (A). Resolve any conflict in this stage. That way I get (A) and (B) in their pristine individuality, as well as a third branch that combines both the changes.

But before, you said:

> Once it was becoming clear that would not happen, I thought of combining those two branches on another branch (that would hold all my patches so far).

Are you merging two branches that contains your separated patchsets 
directly to your own `master` branch, or are you merging them to 
temporary branch that is branched directly from `master`?

Also, you advised that:

> Check your resolved conflict before continuing the merge

IMO, once you have resolved all the conflicts, compile and test before 
commit the resulting merge. This way, it will be nicer for review.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
