Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE8D1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 20:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfBDUPl (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 15:15:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42371 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfBDUPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 15:15:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so1252548wrx.9
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 12:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0xzFFYODGwOnE1xHCf7JpM8FBs8V/eyLZV4VCjoZK9g=;
        b=YebjgD2GJGP1ETFWp0KvWUOl11lbvoCDuSIbeXW7TdoLoCjie9zfw8rh5lmXb2mFLd
         TNqC6nQzTI73DWfuH47QYz2ZFZWggoq3jXz0bLxAxaDhiaq7WFdWXR8RCPZMKMtSt9+L
         xKJEtM9x9pfOHCY4ppLpPCbJyv7fa+4gBM2t2YHcHIUEWip9BOPuZhvtTBC679Dv50Nm
         JCnJVRYkJH5Cl6OWVRmpLU1rL9d5kOFFB5AVJtMfUVARNEpKnH0lul0F/di4WoEpJVXc
         yx93lxB3aVgzyIWsnkhaLg4a7ww2Gpy8UaUbZzd9/GA16UIJfpz7tycgg1/GLLAokh15
         MyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0xzFFYODGwOnE1xHCf7JpM8FBs8V/eyLZV4VCjoZK9g=;
        b=TJeGF1PrQKmxUItDiTPe9j+uzEjcURd7APIFGTkmqe0d3JJ3OxDA/Nc9HRC9rORXTH
         jM+cLsuIVpvzUkR0F9buJsgl8WM8G6lrXsin08vMZW4ZmcTlvrwdefJI3UHd79Go2Y+k
         XL0bdNdP0nDK6Xptslp9F/9DwRTHkRKJeha6x11GJCMCSHs1q2+JK10HuPOmp6i5QIYx
         PxRmjMJevGdbHOlUkScrvdUPV0xnYRxooVTj/8P9H2bwUHxTd+V2/Ks+pA04LYu/5W8F
         KEy6o0ZyHz8yJYuMes4ZHDZQR55paj2o2dRdTWd4zBYwiERq5V3pSW6PTCJrKe++MTL5
         4zQg==
X-Gm-Message-State: AHQUAuYfvLuJbrL5poZrEf9JEQJos0zHrdea1UujfdGfosl8hrtsrEGd
        ahKsjQ2nh7m+JjVhxjvnpG4=
X-Google-Smtp-Source: AHgI3Ibe4XC/t9V0D8w8vtlx1tgLMai6B6ZyFI2YY5B9Zf7NV8m+uhTHPVpeENxVDPxoDr93c0yexQ==
X-Received: by 2002:adf:f347:: with SMTP id e7mr839625wrp.25.1549311338771;
        Mon, 04 Feb 2019 12:15:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a12sm27211281wro.18.2019.02.04.12.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 12:15:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/1] Makefile: improve SPARSE_FLAGS customisation
References: <3ccf0255-8a15-effc-ce6b-eabb61625f90@ramsayjones.plus.com>
        <xmqqmunfxjve.fsf@gitster-ct.c.googlers.com>
        <4a8f6b3f-3844-b4e8-2ed2-4078b592dd4b@ramsayjones.plus.com>
        <xmqqwomfv2w5.fsf@gitster-ct.c.googlers.com>
        <365a9539-4ce1-121a-ec8c-2e52a5828091@ramsayjones.plus.com>
Date:   Mon, 04 Feb 2019 12:15:37 -0800
In-Reply-To: <365a9539-4ce1-121a-ec8c-2e52a5828091@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 4 Feb 2019 19:20:12 +0000")
Message-ID: <xmqqy36vtimu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 04/02/2019 18:12, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>> 
>>>> Thanks for a detailed and clear explanation here and in the cover
>>>> letter.  I agree with the motivation and most of the things I see in
>>>> this patch, but one thing that stands out at me is if we still want
>>>> to += append to SP_EXTRA_FLAGS in target specific way.  Before this
>>>> patch, because SPARSE_FLAGS was a dual use variable, it needed +=
>>>> appending to it in these two places, but that rationale is gone with
>>>> this patch.
>>>
>>> As Luc surmised, in his reply, my intention was that SP_EXTRA_FLAGS
>>> should be used for any 'internal' settings (not just the target
>>> specific settings), whereas SPARSE_FLAGS would now be used _only_ for
>>> user customisation.
>> 
>> OK, if that is the case, then not using "+= append" on SP_EXTRA_FLAGS
>
> Err, no, that clearly wouldn't be an improvement! As I said above,
> this is not just for target specific settings.

Ah, do you mean that there may be globally applicable internal
setting?  I would have expected that such an option would be done
directly on the command line, e.g.

$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) \
		-Wsparse-settings-for-everybody $<

But it is fine either way, as long as the purpose of the macro is
documented clearly enough ;-)

Thanks.
