Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC641F597
	for <e@80x24.org>; Wed, 25 Jul 2018 07:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeGYIja (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 04:39:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54866 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbeGYIja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 04:39:30 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so7321343itb.4
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UFoPg8Muj/2G+CFuWKnLLv2Hws19n9oUVZef5Q8tOYQ=;
        b=f5jUecMtC0tCoCX8uWSkhOWmciz00y0e2y5SM/CGsilJNzBnBFqx8gtzKygnpjvL5R
         p3ayxvnyUN01yvtq2Jt/TtuP7A6u3gBp7MqFm2RlJRTQDXOneJGJMpXL25PS4vSxt3hH
         AOOqbUNW9+rV0MSdFmxLTpwhqBKE+W86L2BQ60SjWqTuks2fACFGY+vV/urV5wOtVzEQ
         gxAkMLtXmzSYthpr2vaf4qhdMiI+r3y2GV7AcHwhOI6j5BCBmgogOjXUM3XWsvbUO2og
         9EpeJoJ27U8gQvW6wTCB0AiJf8Mv3SWkuu/Bdzu2niopxEH06AFnD7oLyZRfOx7J0yg9
         rSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UFoPg8Muj/2G+CFuWKnLLv2Hws19n9oUVZef5Q8tOYQ=;
        b=gmrtMkaIEl6PoMe/3DcJtyvVi+4YwLVa/IDbAhEhNfamGE997VSVW+HI9qxPihKasC
         uITkU0NraFq9DBvwMH+OCxpvpS8wQ3HAyTHysVVwWx6uov+uC0MtHYMbx4/KbfyBLs1J
         sYPTSF5raeIe0nopH3U1QS3sncRTv3n95CsQEH28mYI4rDd7mGqvR6MYvtgQ15XQQmow
         BmceYbGKEW/sSUxl/Cc1VhzyzoUZQCbqJmr0+rZVVJBjt8DMfusgH9/SQ8nL7JTpr4gv
         RZW529GVqPY9xv3SErn0m7ak9O0ij2+s0xfbNimnuxHYym3BEvJfTjzfq2IHrD3hAcLO
         7Q7g==
X-Gm-Message-State: AOUpUlEz8Fir2SGsdXci6K/v+5Azl6/knOfb+UiGlanf5ln2IP3CVypT
        4r6sbaR9K8ZjaukNhE6yo0zwsWQTGgdxX8HZc1Cg4w==
X-Google-Smtp-Source: AAOMgpeiANu+APiq/L/OReHimBror4Bx3Cm/fS9RyC/lUmRkdrpdzlEhlmOl8i2KdI+e55JZHCVZT4gbc8TOxPfxdmg=
X-Received: by 2002:a02:8d43:: with SMTP id o3-v6mr18297813jal.133.1532503746808;
 Wed, 25 Jul 2018 00:29:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 00:29:06
 -0700 (PDT)
In-Reply-To: <cf9889ba-89c5-dc97-d888-aa42aa9dee68@drbeat.li>
References: <20180724215223.27516-1-dev+git@drbeat.li> <20180724215223.27516-3-dev+git@drbeat.li>
 <20180724215953.GD136514@aiede.svl.corp.google.com> <cf9889ba-89c5-dc97-d888-aa42aa9dee68@drbeat.li>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 25 Jul 2018 09:29:06 +0200
Message-ID: <CAP8UFD2PxA4s=Gb-6paUAdWpmqMWpis3mn0Zz9nzqQhHt1EEBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] remote-odb: un-inline function remote_odb_reinit
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jul 25, 2018 at 12:03 AM, Beat Bolli <dev+git@drbeat.li> wrote:
>
> On 24.07.18 23:59, Jonathan Nieder wrote:
>>
>> Beat Bolli wrote:

>>> -inline void remote_odb_reinit(void)
>>> +void remote_odb_reinit(void)
>>
>> This looks like an oversight in
>> https://public-inbox.org/git/20180713174959.16748-6-chriscool@tuxfamily.org/:
>> there isn't any reason for this function to be inline.
>>
>> Christian, can you squash it in on your next reroll?
>
> That would probably make sense. I didn't check how mature the topics
> were that caused errors.

Ok, it is in the next version I will send.

Thanks,
Christian.
