Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0812E208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 11:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeHGNi3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 09:38:29 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33671 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHGNi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 09:38:28 -0400
Received: by mail-lj1-f181.google.com with SMTP id s12-v6so13136627ljj.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 04:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D5cCA8+OKy6+d55uhpCOPJzQM+S/ggdHssRETXn6K6c=;
        b=rlbPgtm7XEs/EW9UQjlYIdC0yR5xopv+NeCY7rkDJDSCOtFvST5k1mvs9ZBN98eVzS
         VXIEGkxdaOGgPY1nYRKQkmXmjN6n+vHZB0HzP3mzSDw1UdQvBQoCTdcwJlKBqJFxwXBR
         iQaRZnyXMKOy38Z2iBSm1c/dZlLh2WkrM9Pj+pc+JBXkxRku7Rn+1IMYmLxdITW02P8+
         flOeCU9G31+pDPxaoX4qEKR/AS0AY7mdMwTngfOEZmSisBrc4eTwbx15r09lS/R0l0rv
         MttC7ajgha92v+Rl9rLpCxB5hB0twp3hGyDgpqOyNmLdDXC5kQLEhVV+xElE0olLwkLP
         Jc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5cCA8+OKy6+d55uhpCOPJzQM+S/ggdHssRETXn6K6c=;
        b=IzDmNVDdT414fq9kCdio0NiCvIcu1jXriyBV+/C7aqyld+YULajHy+iT7+Z4Z1hALm
         7fTYwSsy7+9H8VLdKtU8nbKMpjvlTcVGrYOgRhqiDXsPKhuaAMKWW6NfnOCT6H6/7KNN
         QOYfF9/Q7OG8KekC6HO/edWQ8TRXXg+si36rDMKj+eYDHMRyM9NwFsgxaNQNkkb8RIlQ
         80JezEZZTzvTb4+sJXLATLiMM1kVREzUxijgoela0HT//UBNVjuKrYjQr18xNqXvO8Yh
         NO1QDc6pZxgWlPclve604CD6yiG8ovTkdtUAdoUOn2ffQWNWFMOZ5kqjydVbcgyG22xx
         lgzQ==
X-Gm-Message-State: AOUpUlGgv9kNc+Pk59Pbk8FEwEx5GANF2nCYJbqiDCcJqyUZ8UE9AzAB
        mLcc3Un0+OoVBSWmIOw7pTo=
X-Google-Smtp-Source: AAOMgpdnD9TujnaWNuOOr4bluwFtN8KJuW46EB43QuPlSokQu/e7vfarHZgMX0yTvbTsbZz6cZwT3g==
X-Received: by 2002:a2e:5810:: with SMTP id m16-v6mr16283940ljb.134.1533641075787;
        Tue, 07 Aug 2018 04:24:35 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id p88-v6sm203065ljp.90.2018.08.07.04.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 04:24:34 -0700 (PDT)
Subject: Re: [PATCH v3] t4150: fix broken test for am --scissors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
 <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com>
 <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
 <27bb8e3b-5b1d-dcc2-b002-df6941c62ee6@gmail.com>
 <xmqqd0uvntgg.fsf@gitster-ct.c.googlers.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <2757a1be-408c-27a5-f30c-1606a3a558db@gmail.com>
Date:   Tue, 7 Aug 2018 13:24:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqd0uvntgg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-06 22:14, Junio C Hamano wrote:
> Andrei Rybak <rybak.a.v@gmail.com> writes:
>>
>> Only changes since v2 are more clear tag names.
> 
> ... and updated log message, which I think makes it worthwhile to
> replace the previous one plus the squash/fixup with this version.

My bad, totally forgot that I had been tweaking it after I sent out v2.
