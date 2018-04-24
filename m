Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162601F424
	for <e@80x24.org>; Tue, 24 Apr 2018 02:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeDXCjE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 22:39:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45581 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932709AbeDXCjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 22:39:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id p5-v6so18545995wre.12
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 19:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1lPJtRdLOF8IbiyMsKeLrnyHg0+YISG793u+s8Ekbvw=;
        b=sC8DzOskjDzMSQEkNJFHnEJz3hY/wKfchWkoQROmcH2cZx2c7mYRUhG1Bp2BJ73cFK
         9b293ciMICC0G4tfXhPj2FMdyrgT3HijI8bjZHM6Hb8tKA3qYDmlbO1ksOh/iagRCMQj
         9WcRpCRqfwdXTaJjYaP7BP/iURmMTGYgkNBckyFzD0awqw7d8CJ9G6N9nz1aMMf90li/
         vX0RtI1M7a7W6dLeIsJCrFQp86TT8i+VTGvzqQQzlWB8OGUbbYSSEgel/OoxUI+4P5K8
         WCtCAADQDIJv0xqVrucjWvEwOEV7ExbiJ+BeKDyOWrdh0RJb9MX7q28XpJ4nEK+N9Q2m
         USbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1lPJtRdLOF8IbiyMsKeLrnyHg0+YISG793u+s8Ekbvw=;
        b=mSMqJ4kBfk6/KwY7HA0zKOdvQfADDW4WO45Z0mT9BLJ+bxNnI9WLR4uQx62jaqTmlj
         GZ5Z3/f9nw9yVKcVlt23dX1mqiNxrjUkCv3DMUVuMm+gjc+m9DZFVpTmg4VHc57mTb9x
         NoGaT4e+OcoKrrr9bNWl5brG0H7RRzYJh3JFLCdt5ywaZRF14l3Bg+E7ciXuartF8/Eg
         60wjBI9oAXYRiaSzxlPV+54O90dpuBd4Bh/umyt/lkhsM5DJx9OK1+qsa15oxucMl1Wa
         6eOHyhXONTrifKdni2BOlPN/1+JECTwQsy0e69DDA9icpk+HCx9nYF28gnltvJ5XKW77
         /jSg==
X-Gm-Message-State: ALQs6tAppB5EQ3pZzP58TYkZ+jjSEbStY+MDPDufjXSn/IZCxE0BxK3d
        wupA4Z7kGYY2iYJjorDFxdI=
X-Google-Smtp-Source: AIpwx4/4xUe1q8HxXPc0etWN8vC5rJMLv9IJmweHXbmdb8g8uH1Pnkc6XgfGkj9rJRORclVps+OLkw==
X-Received: by 2002:adf:afe4:: with SMTP id y36-v6mr19387243wrd.107.1524537541640;
        Mon, 23 Apr 2018 19:39:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x67sm16478676wma.23.2018.04.23.19.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 19:38:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 01/11] argv_array: offer to split a string by whitespace
References: <cover.1524262793.git.johannes.schindelin@gmx.de>
        <cover.1524303776.git.johannes.schindelin@gmx.de>
        <6ec155b834768f38765c63907a48b1bd7ab6bafc.1524303776.git.johannes.schindelin@gmx.de>
        <xmqq8t9d8kvm.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 24 Apr 2018 11:38:58 +0900
In-Reply-To: <xmqq8t9d8kvm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 24 Apr 2018 10:15:57 +0900")
Message-ID: <xmqqefj572gt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> +void argv_array_split(struct argv_array *array, const char *to_split)
>> +{
>> +	while (isspace(*to_split))
>> +		to_split++;
>> +	for (;;) {
>> +		const char *p = to_split;
>> +
>> +		if (!*p)
>> +			break;
>> +
>> +		while (*p && !isspace(*p))
>> +			p++;
>> +		argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
>
> Can *p be '\0' at this point?

My thinko.  We do want to stop on NUL even though our isspace() says
NUL is not a space.  And using while (isspace(*p)) below without
checking for NUL also makes sense.

Sorry for the noise.



