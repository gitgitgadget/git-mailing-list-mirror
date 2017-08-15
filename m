Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010CA1F667
	for <e@80x24.org>; Tue, 15 Aug 2017 09:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbdHOJa3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 05:30:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33961 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdHOJa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 05:30:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id y192so780794pgd.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U3bwELEtNDHi8I3ktcfMyD09+LJ9wLCbsACZvLYonls=;
        b=FU8IrPtNX/l4h40QjX6Y1ozTl4a8BYqDWkNpPB1vemouEOvwuXoj3C3ZgIMrqXEfB5
         0y6u5IfeGEYDeK4o/V21Ntc4MropCbJtZyhCsThNvgpvVxBhExBnr8NvQ/M1bEdH9oMu
         K4WpNkTV7ch1zcu510PQQmMbbgnU9Ib0YCsw/JjNmc+XhWMw9WjOb6Z0+YsZF4ihGWn/
         Cz1umjjjOvxLE5rfUGae2D7XmaNSrSZSIvZmcBkKczGAzI6nmaxq7UjWkA9eDzEVZ9NH
         F3OZ7w5765ZQlG+Ck+s7KwLgor5y3fGe53lHqHe300yXkOGpEDCpj80L0CLemJ+MkpL+
         GIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U3bwELEtNDHi8I3ktcfMyD09+LJ9wLCbsACZvLYonls=;
        b=hvCEyl21bDAqGSQ63wtSUZKhRv5c6H+Qh3tJfmVUcpuLE30zii5ElYqc0iFjPZzgni
         9SfckVaFKylN4kxd4cEbTicUOiH+bpxJkA+5lBnbg5qNFNalQgfeV1F7pnVG77CV0NKk
         M1QufXqYWwcNpsr2Dn/+I2Mwe22JDL7ZBxn5cvvxijDraiWXKZsDq+ZmV8+ljb3WyOP7
         wrOYoL9JYCbBGUYtUjx4tSve4eAeajq5JdqWpHSr6ave8H3uv0bXGYJ6oTmRiT8yx92v
         OrNRT+QeP3BbsNrE5lZ5LVa8cwxQN4MOUor0H6Tuc1nF1KVpAGOHMCKYXIdyJqIQImAX
         kSrQ==
X-Gm-Message-State: AHYfb5hz7YOuZTzCbZKxLYzFvy64IKYWwMSZUOoeKwOPQuxKoX8GANPY
        yQRiU/OR2u7ewg==
X-Received: by 10.84.224.7 with SMTP id r7mr31380424plj.332.1502789427885;
        Tue, 15 Aug 2017 02:30:27 -0700 (PDT)
Received: from ?IPv6:2405:204:700b:d138:d4f3:b513:ec16:b5d5? ([2405:204:700b:d138:d4f3:b513:ec16:b5d5])
        by smtp.gmail.com with ESMTPSA id a63sm16375608pfc.165.2017.08.15.02.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 02:30:27 -0700 (PDT)
Subject: Re: [PATCH] hook: use correct logical variable
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com>
 <20170814084646.30781-1-kaarticsivaraam91196@gmail.com>
 <xmqqwp66ui5h.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <4e2c5bd8-48c9-fc8c-2c2c-ede3951019fc@gmail.com>
Date:   Tue, 15 Aug 2017 15:01:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp66ui5h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 14 August 2017 11:24 PM, Stefan Beller wrote:

> On Mon, Aug 14, 2017 at 1:46 AM, Kaartic Sivaraam
> <kaarticsivaraam91196@gmail.com> wrote:
>> Sign-off added should be that of the "committer" not that of the
>> "commit's author".
>>
>> Use the correct logical variable that identifies the committer.
>>
>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>> ---
>>   This fixes a small issue when trying to do the following with the script enabled,
>>
>>      $ git commit --amend -s
>>
>>   If the commit being amended was signed off by the commit's author then the above command
>>   would *append* the sign-off of the committer followed by that of the commit's author.
>>   That' because the script is invoked only after the sign-off is added by the '-s' option AND
>>   the default of 'trailer.ifexists' for interpret-trailers currently defaults to the 'addIfDifferentNeighbor'
>>   thus interpret-trailer fails to identify the existing sign-off of the commit's author and adds it.
> The background knowledge provided up to here seems like
> a valuable information that we'd want to preserve in the commit
> history, i.e. make it part of the commit message?
I didn't do that previously expecting a few people would get confused by 
this (it did turn out
to be true). I could have made it more clearer but didn't attempt as I 
thought it wasn't worth
the effort. Yeah, it sometimes takes time to *simplify* things.

I guess Junio's suggestion found below seems concise enough although it 
doesn't
capture the reason I did the change.

         Sign-off added should be that of the "committer", not that of
         the "commit's author"; that is how the rest of Git adds sign-off
         using sequencer.c::append_signoff().


---
Kaartic
