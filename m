Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A261FD09
	for <e@80x24.org>; Mon, 29 May 2017 00:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750861AbdE2AxK (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 20:53:10 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33156 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2AxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 20:53:09 -0400
Received: by mail-pg0-f51.google.com with SMTP id u187so15359303pgb.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Q1zE3Z7vauvcbXXLRuv+ckY25eirvRQg6pbQxaEVDzk=;
        b=SQOkv7goEuljvArKQfp+q404IBfBxRacAxEUg8gEvJgdqV/L6XxEIEMOPCbWLnO11R
         h/atpbRQ4ImVvyp/WbBnLQt+yrXs/O/ZODqm3M2N1BMZbtd/f5kR9IymYVFLpZ0XqR9d
         H+2ILidh0ExwKR/zHnGgoyNITzMDY9Dc3BazgaKjKIObyVPDNqf4Sr2vUJ5Eev4WBg22
         DPGQbJxIHkFdAt3hrP91qAWuzTIwHbMkqiTNxRrhhJxxYeUF9K/PiazEYA0kdp7Hq5YI
         pR5jCkFYDb1v0yMXkdYBS0yutJEPyTKcVTr0uIeWyVKwMVsDKRW3rY1L2x2u/LZ5HRwD
         XysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Q1zE3Z7vauvcbXXLRuv+ckY25eirvRQg6pbQxaEVDzk=;
        b=FBDEBoZhJ9TRPcKUIYpavffmIcOyEkOjmMbJfxh4e/E2HJRaV+rRBwr14S9pRs5pff
         jtsokQ+t39VYnrF+lAruqUu7vAuSo3aHdT7KtMynyxBUtcuKDjxKOWwUMttv6MqC+6Kx
         1ZLoGlBBn1x+ziOgllU9VMTYC/MY1SD7Wb+iCQb46UuoZMDamTGa1rRxezTAMV+6c4E2
         Dy4GEvDvn2fbOLY7xKxzk0ZpU2pfPNjA645Qh6r+FntgOOIvq7s0WzEyahtb0FHA/XT7
         KB7N1FAAIgYjYKCFfOAqWs5h0BM2GMvC4ODQ/LPafo+0K6qDXI/YDdsJI3xfCoM4W0LG
         1z4A==
X-Gm-Message-State: AODbwcBL+0l6nWezbgkBBh8i3pDif5h6UcEPj74/jSb7W3HrUzT5onVa
        CBkhGrnOqKrBBQ==
X-Received: by 10.84.233.132 with SMTP id l4mr72782839plk.148.1496019188865;
        Sun, 28 May 2017 17:53:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id 134sm13639006pgf.14.2017.05.28.17.53.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 17:53:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
        <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
        <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
        <CACBZZX6zG0z90coXz_Xzqvdp+9LpJ4RE2dAJggfLL-nd0nkWVQ@mail.gmail.com>
Date:   Mon, 29 May 2017 09:53:06 +0900
In-Reply-To: <CACBZZX6zG0z90coXz_Xzqvdp+9LpJ4RE2dAJggfLL-nd0nkWVQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 28 May
 2017 12:29:22
        +0200")
Message-ID: <xmqqh904a3gt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>
>> Here are some links to past explorations:
>>
>>   http://public-inbox.org/git/20160208152858.GA17226@sigill.intra.peff.net/
>>
>>   http://public-inbox.org/git/87vb2d37ea.fsf@web.de/
>
> There's a third and possibly least shitty option that isn't covered in
> those threads; We could just make a pass over the strftime format
> ourselves and replace %z and %Z with the timezone (as done for
> DATE_ISO8601_STRICT in date.c), then hand the rest off to strftime().

I do not know about %Z but certainly for %z that sounds the least
bad.

In a nearby message René seems to have come up with the same idea,
too ;-)
