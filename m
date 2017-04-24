Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676791FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 11:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1169145AbdDXLGJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 07:06:09 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36564 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169082AbdDXLEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 07:04:32 -0400
Received: by mail-io0-f180.google.com with SMTP id p80so69528043iop.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=00u8vHdB7us9jyBMrukCUUefCh2dhwGwtiJ354eQ0Hs=;
        b=pJixt6yt0Zd439kOcacC5cj3e66hFIJOJNnfUkjvJJtfNaMr7s6XTPdIzLZDqRY2hd
         9DxMmiki4UALBW+Mjcfrv7oWxqaS0mLloKN4cZFkCfSy8zLX7E9p+JslUSrWc+23EieP
         FxzAk1jjW1TAA7f10vYmiylRcuk/AN78RnG+0vVOYikmD8VqiX6TjOIG8yUSStTwvBrQ
         vbFtnODPL+OdaDnd7xjsdN9Dm5vKLtBczpdP0qeSwzp4+F6F0NQkimFeK9Hp+uY7C0dX
         mP65u1Zuhwewh5vASfBi26wWPWFcMNAm0/eIkYAVrtL9P5j8WE6RVvDPNZLqmForehFp
         i3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=00u8vHdB7us9jyBMrukCUUefCh2dhwGwtiJ354eQ0Hs=;
        b=FV2vwgWQtP3JdPn4b5J4i+ybjVFcF26r5uK9osDgIGL85aOXnMnWlv366LB2UpVJcz
         8s/y2fcxF1OKt7yL/iEa/wOPrOxmZ57pAoMfxA8ksWBqw2XKeJ24YGuZh4adni2FTcK4
         pEZFr3/ZmWwnQC257z09lExr21q0Il5ZrPFQ/4a6C7pVFRWkXJdP7Ffsyl9y8kZqkk4y
         Fnf1aTuHVQVAwN0AI9GN/+Xo3JDHSyixoR+wTP3cs9kOAutwbG1povM0G8ssdJ9qZ1GZ
         ctqhRYd4jP00wSjw2cB0/XBLw6Q1YZ5wVEVe/YbTZVtU9rPCG5z6BujTo0Sj0fDeHeII
         0f+w==
X-Gm-Message-State: AN3rC/5V/7Exd1d1VAb+JPEUMu9xFtPKSq7lhFa9IfzKAprFqc3WI0Wg
        katIFOtOkyvOjSy4PxC21JdDiLJvig==
X-Received: by 10.157.43.110 with SMTP id f43mr5507640otd.79.1493031871074;
 Mon, 24 Apr 2017 04:04:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.6.166 with HTTP; Mon, 24 Apr 2017 04:04:10 -0700 (PDT)
In-Reply-To: <CACsJy8DPtfyAAX_cmRLib=eKPMWnew5CsYDV6V3xTTiEg1Kksg@mail.gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com> <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
 <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
 <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com>
 <xmqq60i2im72.fsf@gitster.mtv.corp.google.com> <CAJgfmqXqfp3A+A74dfkKjQb_26ZNH9anY52-G2L5ipg=+6--2w@mail.gmail.com>
 <CANgJU+WbbF2yzg53D7NasN_nxqytOh=UoutmMPak77JhiJHx4A@mail.gmail.com>
 <CAH_OBidR8ewMO_B0HM2SU=B+uV=kRjpOKVMcvohEkZ1PSgT92w@mail.gmail.com> <CACsJy8DPtfyAAX_cmRLib=eKPMWnew5CsYDV6V3xTTiEg1Kksg@mail.gmail.com>
From:   shawn wilson <ag4ve.us@gmail.com>
Date:   Mon, 24 Apr 2017 07:04:10 -0400
Message-ID: <CAH_OBid8nNGX2fFJkGcS1=bDQBjMvXn4ZeJ9wJ4VNGOMh-AeRQ@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     demerphq <demerphq@gmail.com>,
        "Fred .Flintstone" <eldmannen@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 5:28 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 24, 2017 at 3:33 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
>> Late to the party, but I too would also like json format output (mainly so I
>> could pipe stuff to jq instead of looking at the man page for which %thing
>> I'm looking for). That said, it's not at the PR level of want for me.
>>
>> OTOH, format=xml would be even more handy IMHO... Which I see has hit both
>> SO and this ml in the past. Either way /some/ machine output would be a good
>> thing :)
>
> Personally I'd rather avoid linking to another library just for
> json/xml formatting. libgit2 would be a great place to have
> functionality like this and it looks like you don't even have to touch
> C [1] to do that.
>
> [1] https://gist.github.com/m1el/42472327b4be382b02eb


Heh, well, I guess if it's like that (simple), I don't really care :)
I was under the impression (no idea why) that it was limited to C or
java (and friends). Given this means I don't have to figure out
someone's json structure or refer to an xsd, I'll live w/ this.
