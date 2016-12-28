Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD361FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 07:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbcL1HqR (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 02:46:17 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34388 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbcL1HqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 02:46:16 -0500
Received: by mail-yw0-f175.google.com with SMTP id t125so182918023ywc.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 23:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bnz8pu8V+voLpGN3DtZ+l9cHA92Y8fQ5PUZ5m5f4w4s=;
        b=czrj3EYPCwGN6rKaeEnbFWLk6uV4UerDEcXcLfbLImF9YFf72UguVFHQ5QRy9cP6+u
         jdjpnS0uo0xZqdwA18BNnf4QE4t16t6CSz6Kl99/aBwphpGfcc49RBqfspY7yRnbgBIV
         Nhs3vBY5u3mQK0PeTR+Vi5Umd30HDJSsSHIs2jW9X09D8qRtxvPhiTnssIfzcmvq5kM0
         C59f6L8ojmwyaYjZ0LA46bn0qNpIAhEa1EMuIqVuvouymYf8u0IKcSnXsbPGiAwDRrSc
         BxojMypdQjiJmNXiaIySYCgWwjh5+WLf7lCrt05OZOyspYRL7uuX+1Ffz9H1pbWf4l0P
         Aiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bnz8pu8V+voLpGN3DtZ+l9cHA92Y8fQ5PUZ5m5f4w4s=;
        b=GEnjoVCq77p3nmiF54rST0IvbjVWji1Cg5hdPcSEJEKvFCKZ/cW8v+xWvjrcd+V0ma
         KBW6ELUCv2xaFH9pi92yGnNS3pE5zFF7qUKu8PV9PqeJvMaMQloz5jSE1pEmALBJRunO
         lboLWcj4dT795WaT73CF3AujNi7Q8Jo3sS9yleRTSD+U7TeK3BXitVRorxc7lg53EPE7
         yUmJbwmHBm24gZ05klXq3m+1Ckwh+0QIkiRa+C65oiV27XJzMxXuRrDqSVXeipu0RNOB
         FUC4eWKkiLnte1cr0ff3qWjRmO6oMYuSo9syWI3wm8rfbbfsaPdc/GpjypORkqt2Vc1R
         ROoQ==
X-Gm-Message-State: AIkVDXJ6TbshBXjI9bX1f7ZEACMaby1wKWyDZVjBDIeUgOmfvGrFE6lQQeqBZaUtZbgP55TagyBSnlfa9ox1zg==
X-Received: by 10.129.85.11 with SMTP id j11mr27378506ywb.123.1482911175556;
 Tue, 27 Dec 2016 23:46:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Tue, 27 Dec 2016 23:45:45 -0800 (PST)
In-Reply-To: <xmqqzijh6phz.fsf@gitster.mtv.corp.google.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com> <20161227162357.28212-4-Karthik.188@gmail.com>
 <xmqqzijh6phz.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 28 Dec 2016 13:15:45 +0530
Message-ID: <CAOLa=ZQPde5Xtthj7UqvZBxxVVSrmO2yvP6uKY-NkSuP71xLZw@mail.gmail.com>
Subject: Re: [PATCH v9 03/20] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 2:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is done by introducing 'if_atom_parser()' which parses the given
>> %(if) atom and then stores the data in used_atom which is later passed
>> on to the used_atom of the %(then) atom, so that it can do the required
>> comparisons.
>>
>> Add tests and Documentation for the same.
>
> s/Documentation/documentation/

Thanks, will change.

-- 
Regards,
Karthik Nayak
