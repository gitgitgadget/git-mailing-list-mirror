Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3855B215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeD3PoS (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:44:18 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:40069 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753582AbeD3PoR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:44:17 -0400
Received: by mail-yb0-f196.google.com with SMTP id o80-v6so1849891ybc.7
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y1zjdHC7BlD5mtpJp4hSXLBhEsMALdFyiQvAz0FmDjk=;
        b=QIUswIbVLk2gbKujH+7l3BtljVa6jdKaA3F8e03Sl2U5L4nK1QwieCli5VQztMifyc
         a5skjJX8N/il2Ixq8VwCGDnsIMVQ8f1/gShL3XKR433SyM4+wEVmCnNY0xw480sdqXkC
         DsiW8t9cSaXHAlszvkTX8qCIRpwdaD2Pntk8yhnSu+yfgBl02xGVkSVef7yqHSYnk3h/
         /XMaZZUOCo0m+CN0BV9DDDOvV8dva3sD5fnKTBytDd1VUQlAYhtwrc+dp7VrPpfmJfs+
         bFgKCKNxv12cNpGGRZbgoDonymKspQX7LGZkMAbKbuz9DfE+MbhWD2h2b8XhH2GbxRiV
         eX8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y1zjdHC7BlD5mtpJp4hSXLBhEsMALdFyiQvAz0FmDjk=;
        b=j8TTwnaxz5l0ij2yb7zK9f9hFu5Ql+2UpVsRygg7DCfxve+7ruZ9pndctmbrxjrKFk
         M5kgIQZznodn8srjsilX49CG4c3YmNNaSj8X7yVsCHZoL07Iypq8N1UT2qRzAgvBnb5V
         xR+axZnBW4NahdCmFboKXSNmkeXT95DlF98TcROASHX2STNiRJ95U8JNdqS5OBV7D7gk
         U+9HAbD2n2jXBe0ZUaKyatFUZR61UBku3Jut9Jd8T+Hi00YtSNrtyRq+l3dULqZEnp6z
         9fqlnUPGw8IY81ROhT7Y/JEZiYUBkOp4rbu1Gb1A5yQ1rjMnC7zpNdqbEhJ3H+7f84eC
         IPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y1zjdHC7BlD5mtpJp4hSXLBhEsMALdFyiQvAz0FmDjk=;
        b=GVYcvCRq5NYgMW7zXp0faHknblSmDf1L/c1JacwhVlhlj/pNsdz5uxdRAo2s2Wb7uA
         jv0LibSNgCFwvmOK88b6Ox8yN48XYhekL00OMbyVshco9cyprZpHe9xRjDm9OTZ9PUVM
         cDCARTngop9s3kVMcNnZPo0z1LlzbNma3V3NWITNL6/IkiS1O2yu9CBJzeECNM6X0KhG
         19WqnydQFwgekrvk+jOQjDCyC9K8qCWmPzuJGWxY+Zc1t1f5XEFkHHwU28XUT0sD8bv9
         IHBGQa76hyz2+plk2D40AV2MDOgZ09D1/7PvlC1tfzwF3xp26zDZ3n1/PoYB+9ft0NO5
         8VEw==
X-Gm-Message-State: ALQs6tCSxfPe60OcYTSqNPwKeMIrB/syqOtUHMlY/2SWSQN4UG+VwnRc
        dC/7usXdjtFGGdo/au/THWOmEr+MzwOSW6y0EP8=
X-Google-Smtp-Source: AB8JxZpWx7xeNXVKhZg3Z3NojvOqpkE2jLazml3bX7Q2keM/cBWSI0kmLqPRO/Ut04hr3pCoGC7GZqaiCkDZalvfZ28=
X-Received: by 2002:a25:d8ca:: with SMTP id p193-v6mr7526624ybg.157.1525103056661;
 Mon, 30 Apr 2018 08:44:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:aaa5:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 08:43:56
 -0700 (PDT)
In-Reply-To: <CA+CzEk8c1Pt+n9Jy5vL9_K60Q=6VKnLTdBY1JFRnb-POuRFv0Q@mail.gmail.com>
References: <20180405022810.15796-1-joel@teichroeb.net> <nycvar.QRO.7.76.6.1804061813240.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <80781666-fe94-f718-ff57-4faeddb9a183@gmail.com> <CA+CzEk8c1Pt+n9Jy5vL9_K60Q=6VKnLTdBY1JFRnb-POuRFv0Q@mail.gmail.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Mon, 30 Apr 2018 08:43:56 -0700
X-Google-Sender-Auth: KK4-C0tKoB-CpBQQ8gqMNRB2eOw
Message-ID: <CA+CzEk_qwHs5qUstyFeepzwvCBR=9SvH90+__f-gfxFySETZzQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Convert some stash functionality to a builtin
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-sending, but this time in plain text (why doesn't gmail for android
support that...)

On Mon, Apr 30, 2018 at 7:35 AM, Joel Teichroeb <joel@teichroeb.net> wrote:
> Hi Paul,
>
> That sounds great to me!
>
> Thanks,
> Joel
>
>
> On Sat, Apr 28, 2018, 3:06 PM Paul-Sebastian Ungureanu
> <ungureanupaulsebastian@gmail.com> wrote:
>>
>> Hello Joel,
>>
>> >> Since there seems to be interest from GSOC students who want to
>> >> work on converting builtins, I figured I should finish what I
>> >> have that works now so they could build on top of it.
>>
>> First of all, I must thank you for submitting this series of patches. It
>> is a great starting point to convert 'git stash'.
>>
>> I would like to continue your work on "git stash" if that is fine with
>> you. I will continue to build on top of it, starting with applying some
>> patches in order to implement what was already suggested in this thread.
>>   During the summer, I am planning to finish this process and,
>> hopefully, have a 100% C, built-in 'git stash'.
>>
>> Best regards,
>> Paul
