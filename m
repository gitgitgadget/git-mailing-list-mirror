Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5901F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 22:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756106AbcJTWtg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 18:49:36 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36173 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756054AbcJTWtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 18:49:36 -0400
Received: by mail-pf0-f176.google.com with SMTP id e6so44512824pfk.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 15:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=er39PMCwxwAixh6V8/OpNbJVTAsDPYTeaS4mp8uqIFs=;
        b=OPDaTOUBIyLPZTY1qjwUlcZHNeET3mWS0Cie3sDgBY5ILN1/dtK0TKo7MDiU0DBk7i
         XK1Qk+tjZEeifRvq0oZnhyBVZ9t0gUKdoZ4BJW77W6PZ9V6I9/Oyb1NVndKBTd6TyOkD
         ny/v0Iu081q+/sCPdyH3JK1CwPiIwhZTKFUkqvwrhWVTUnh0ktwqs4gIYGAdutHo3UtQ
         H2cWDvuZ7kUbQBBerQo/8SwveKK+71ZmSDnk8Ab/0IUC/9G/ACb1jGzgEF+GQmpG+uq3
         ASssqTk/6K7Xl4bYDRKLov84+3DvHYc+auBVaqEOoGfKmhn8ww9tIt5rD2ekXDyzMRQ8
         d/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=er39PMCwxwAixh6V8/OpNbJVTAsDPYTeaS4mp8uqIFs=;
        b=KIv36UUNvJKNTX5vjGTvlh+QGxXvXsgei9HPQnebmwobROoeoVqChbPYqpE/Zna3vX
         RQ/DysbJ7JUFoTRwzk7VvKgzh+8TWnFQ3jprRpj2ODk66O/X9mKvQ3GgaYSBzrvEp8c3
         ESZwqfYtVd7is1Gf6UIvTI2ReLg75Dcqc4uohrB7e41JCImSpadaqhdn+HkKnrjLE2ww
         y1HIcsUUAzXoMTSJLsl6UdUoln2uAom3i21EoUORayAOzKYmvcerpSChR8prGe3fumA/
         NFiog+8zqPcFshF1M/pwVpnvNaudWPktd4/jzfukUuxxdw1wMatFhzC2YqQs66C+m06S
         jYmg==
X-Gm-Message-State: AA6/9RkDbnxV4FMXyKj1kxfV7J79SB2BSqVE00M7yWo1j8A5OVBJxTJRKfNk+AuHcyvaoXeu
X-Received: by 10.98.13.20 with SMTP id v20mr5513230pfi.80.1477003775038;
        Thu, 20 Oct 2016 15:49:35 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:7cf8:6ddc:3f3c:18d4])
        by smtp.gmail.com with ESMTPSA id e125sm74056736pfg.11.2016.10.20.15.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2016 15:49:33 -0700 (PDT)
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476998988.git.jonathantanmy@google.com>
 <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
 <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
 <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com>
 <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
 <xmqqr37aej26.fsf@gitster.mtv.corp.google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <5656444f-14ba-b58c-4ad6-e72cc15a13cb@google.com>
Date:   Thu, 20 Oct 2016 15:49:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqr37aej26.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/20/2016 03:45 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> If we do that, there is also the necessity of creating a string that
>> combines the separators and '=' (I guess '\n' is not necessary now,
>> since all the lines are null terminated). I'm OK either way.
>>
>> (We could cache that string, although I would think that if we did
>> that, we might as well write the loop manually, like in this patch.)
>
> I wonder if there is a legit reason to look for '=' in the first
> place.  "Signed-off-by= Jonathan Tan <jt@my.home>" does not look
> like a valid trailer line to me.
>
> Isn't that a remnant of lazy coding in the original that tried to
> share a single parser for contents and command line options or
> something?

That is true - I think we can take the allowed separators as an argument 
(meaning that we can have different behavior for file parsing and 
command line parsing), and since we already have that string, we can use 
strcspn. I'll try this out in the next reroll.
