Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2963B1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932146AbeAXUlR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:41:17 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33613 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXUlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:41:16 -0500
Received: by mail-pg0-f65.google.com with SMTP id u1so3537612pgr.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6VOO+SXUEZ+fWhSnGk1yWhgs7WZpObdqVOBtmASsfr8=;
        b=QxA5Y2m0txwxq7epgoaalXTALxQwNRiW+01wDwPMWYyt6oK7uEOzU1PW4IipP4NuEB
         fEtGwQn5U1qNPsrXyOS0g0YWOpQ+Rsgo7LOMBCMj+BBXIPInRQplm3HvVob7yj82gAlH
         BbBO6VLaWr8VP1E+9ykDeexZieqJJnQoMoUbY+f9ZDbQadHh3BdNNJy6YY5bmomSzXGo
         swaD5Oh8vWZ/gO8kOVJie5bh6m4lqx5rWqv0w/+UtYPK9GEqN0vuQ7PgnWPSbixc48UA
         recD/8L4AkAxYufF07pnb+xYKnktVOnNo08r9KtX+we9Kw84o67U/XAFKShd20rcIsId
         8NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6VOO+SXUEZ+fWhSnGk1yWhgs7WZpObdqVOBtmASsfr8=;
        b=H4Rr7AFYSUKerBwPElo6s+BUwCx1sjjy3Fma5jHm6TTohOuGXKUGp6rgIfEATf2Zrh
         Bl682pc/dWdNAwnjIEQx9Hqg9wabTNkWNZoWCNbyzadrrrc37wTp9Igz+nFYvYjaIIz5
         uUo9fZZPeFH3De/VtkGB5CiZsglNpSGtgyLmhFEMA0CJD2FP4HeOxS4Z7MtCkvP/sK3V
         1xEC31eIJpSFb/Nd2qHXCqSyA+xnPMwe84zg08lCMtphb20HNY8wjztdhi5QQEe5dG1L
         96zHcn7mDlo7KYw5avLmo7MZbB/AYru3tKF/RZE2DxFh2JFBPdm2Ha3L992Kv7+CHhvI
         ZUTw==
X-Gm-Message-State: AKwxytdhBtidIg0bdkcf1y52qe6hGnMQHBAumh4cpsu6NgdyK4/o5s5H
        u2p415xUz6s9us/nlN/Yttg=
X-Google-Smtp-Source: AH8x2276z7v/Ox1Wk08CoTX3U9LZ3hQUaS86kAa6wruVFFw2Mc7FOsW6dp0M2uH5u+URLXJ+MKAwYQ==
X-Received: by 2002:a17:902:bb0a:: with SMTP id l10-v6mr5295375pls.130.1516826476148;
        Wed, 24 Jan 2018 12:41:16 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id g74sm11336105pfd.73.2018.01.24.12.41.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 12:41:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/5] nd/fix-untracked-cache-invalidation updates
References: <20180118095036.29422-1-pclouds@gmail.com>
        <20180124093023.9071-1-pclouds@gmail.com>
        <87d11zh40i.fsf@evledraar.gmail.com>
Date:   Wed, 24 Jan 2018 12:41:14 -0800
In-Reply-To: <87d11zh40i.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 24 Jan 2018 12:47:57 +0100")
Message-ID: <xmqqwp07c7md.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Jan 24 2018, Nguyễn Thái Ngọc Duy jotted:
>
>> This is a small update where the last two patches on 'pu' are merged
>> in one. The final content is exactly the same as on 'pu'.
>>
>> Nguyễn Thái Ngọc Duy (3):
>>   dir.c: avoid stat() in valid_cached_dir()
>>   dir.c: fix missing dir invalidation in untracked code
>>   dir.c: stop ignoring opendir() error in open_cached_dir()
>>
>> Ævar Arnfjörð Bjarmason (2):
>>   status: add a failing test showing a core.untrackedCache bug
>>   update-index doc: note a fixed bug in the untracked cache
>
> Looks good to me.

Yup, looks good.  Thanks, both.
