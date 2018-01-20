Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FC61F424
	for <e@80x24.org>; Sat, 20 Jan 2018 22:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756736AbeATW0n (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 17:26:43 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38679 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756712AbeATW0l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 17:26:41 -0500
Received: by mail-ot0-f195.google.com with SMTP id v5so4455441oth.5
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N24nuQMxeSl+5f+RWvwUYX4vlSEjZh9hmWamYuClHf8=;
        b=Ghvv4rkSZ6I5F2/TYU12/sLTkXv419Pm7NWMowqheHD9kXshOy0TIrkYDKS3kMPQyK
         BU/VoyzPqg4NFFqOwjqm6aRapwzqLIY4XJbyNLZdRhmjwc+0y1K144s88IXTczbYi+Cf
         pq62HxYbi/NsOLn2IACCmaEIe2MH1kVpF8euPrfhULxa5JIHET8s5y1bVC+BIhPdGeCC
         Cj+eX4KeKZ9WT4GQF1N43j4uR9l75hDiYLWBpk+t/Ira4PBhpKIMZnvn84h11M0hu7d7
         68EG8A1OCSh3uMm2qYnpEX8f6iqIrvr5plYMRbIPDPF2zoTosWvocs/ZkKiD9LC15fEw
         lRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N24nuQMxeSl+5f+RWvwUYX4vlSEjZh9hmWamYuClHf8=;
        b=ZESLqvthAZDJj6z+UF11I1n0h/oiENBmWpsbMaMkxnQupx2F/6pxizulJ4lbpIRh7m
         da9vEZIQ0l1504sbFUZ7DCKBNL2/kIh9YA8jfy9O0e0caPWIp8gxjty1YtusV2fcWKuj
         GAJ92R+u/1f5t3YKqcLUbp+E33u20fRt7ft/NCN8r42fBGg3NmlqXzc6/8AZDjNkHsh1
         a8GOFaoKMpXWhBAYlOJufgm+TnWkL3TiOeZCr3PXJfylJ9azSs3GwMVBhAleY9bP60BI
         nL2Aw4fb1MAinvlD3y6BZGtpsl1tkWRfHxsXbFaLPQL39prfolQRPOymCB2G5hxDfot2
         3pDg==
X-Gm-Message-State: AKwxytfPb4In3EsLxWDMw+h8VhPQH9uuUyAn5cqk17K+RHxb4Y2ZNWM6
        Sryfcl9pGaKgIWwog0uzOYkUDYmq9B2LFtJGf83XHg==
X-Google-Smtp-Source: AH8x226ua87ITwZ2svvEho5uU59L1Gmsp2LStAooFTKLoXvcZ/zEhH+ibT5HdE7Gb4JQ0BuJRxW26xp/NowOOWXPEUg=
X-Received: by 10.157.7.164 with SMTP id 33mr1512839oto.276.1516487201058;
 Sat, 20 Jan 2018 14:26:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.160.203 with HTTP; Sat, 20 Jan 2018 14:26:10 -0800 (PST)
In-Reply-To: <CAPig+cQ9mMVvMLKSQOKxinc5iuRK61yTDQ511ZdNqEOtbCGoAQ@mail.gmail.com>
References: <1516404987-3420-1-git-send-email-gs051095@gmail.com> <CAPig+cQ9mMVvMLKSQOKxinc5iuRK61yTDQ511ZdNqEOtbCGoAQ@mail.gmail.com>
From:   Gargi Sharma <gs051095@gmail.com>
Date:   Sat, 20 Jan 2018 22:26:10 +0000
Message-ID: <CAOCi2DGOkotCb+4SUCZShOp=r_=QMhMYBq4GUq-ATe=OE0XM3w@mail.gmail.com>
Subject: Re: [PATCH v3] mru: Replace mru.[ch] with list.h implementation
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 20, 2018 at 12:59 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jan 19, 2018 at 6:36 PM, Gargi Sharma <gs051095@gmail.com> wrote:
>> Replace the custom calls to mru.[ch] with calls to list.h. This patch is
>> the final step in removing the mru API completely and inlining the logic.
>> This patch leads to significant code reduction and the mru API hence, is
>> not a useful abstraction anymore.
>
> A couple minor style nits below... (may not be worth a re-roll)

I can send a v4, it shouldn't be a problem. :)

>
>> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
>> ---
>> diff --git a/cache.h b/cache.h
>> @@ -1587,10 +1588,10 @@ extern struct packed_git {
>>  } *packed_git;
>>
>>  /*
>> - * A most-recently-used ordered version of the packed_git list, which can
>> - * be iterated instead of packed_git (and marked via mru_mark).
>> + * A most-recently-used ordered version of the packed_git list.
>>   */
>> -extern struct mru packed_git_mru;
>> +extern struct list_head packed_git_mru;
>> +
>
> Unnecessary extra blank line.
>
>>  struct pack_entry {
>>         off_t offset;
>> diff --git a/packfile.c b/packfile.c
>> @@ -859,9 +859,9 @@ static void prepare_packed_git_mru(void)
>>  {
>>         struct packed_git *p;
>>
>> -       mru_clear(&packed_git_mru);
>> -       for (p = packed_git; p; p = p->next)
>> -               mru_append(&packed_git_mru, p);
>> +       for (p = packed_git; p; p = p->next) {
>> +               list_add_tail(&p->mru, &packed_git_mru);
>> +       }
>
> Unnecessary braces on for-loop.
>
>>  }
