Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0BC2021E
	for <e@80x24.org>; Sun, 20 Nov 2016 16:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbcKTQwm (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 11:52:42 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36841 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbcKTQwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 11:52:41 -0500
Received: by mail-yw0-f196.google.com with SMTP id r204so24973199ywb.3
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 08:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kgkfGv6BRVZ9FMe7MmtYxlMBggNXzF6inTIaXBAeeDY=;
        b=wUx21VFckQ7TOT5K4BHvPJkmgDbVdZKxSpO6/BIhNRxJf1Zvc5jo6mrTWY9zPO37ST
         gQ5dDftMWPC/wLoIgDJMZiLQn7k8kldI+Ak049jV2Ydmdlp7LyZXLYgxuKwpyJox1Qor
         tRJbKeExL8FOfai1LVkp54xM1SzlczRq72nia9soN7lzVcHrxNYD7s7iIt1JVPnHnhqH
         hI9v9hetkdG3DKvKsGNvTYFPAha130V5Up5b590Hi/Zr/W2o39nrqGSbSdRYcXhagAbr
         SH5IzHtutPa7rKj/KWG/m7/ifLr2O2+9e3NTjCtaMq/OMjj2iCuuIAh7ENA4VfqkX9WC
         XSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kgkfGv6BRVZ9FMe7MmtYxlMBggNXzF6inTIaXBAeeDY=;
        b=lsV1YFSLAqw9LiAVwSmBt9WCtKXDo+wyZMp5lr9ZupYMG3v8G858XEi8bbi7M0gJwt
         H5aGeQ3sFivp2W8DBzyE9Gyb8ZEXVnn2hrx4twFy5/clYZraXaD4Aif8btBAiYiSbQQK
         rygnxLXZKdwgzghiHChgcEM8g2VnpAnmz/J9ab9NbormOfYodhpb2Vif1PlVQuNwsYTd
         j6aOiXYIjVZxBCgGL1mZkd1XJ/nW/XJU5GfCAlV+RS58Yp6Ozoy8o/yAx71tWA8oOIlB
         TDLzWr/7MGMR+eRRfJcB3lTqqssQ6mN47KwYxYhCg+3O/obAu3Pl6oGwdBGSxdE9T+Vf
         z8Pw==
X-Gm-Message-State: AKaTC01LXRnoSabhFODhZ66eedxZzkk0EWKxUqPLOKI4bCG1R2uvZPRsn5Z2Tl17nkP3VYKce54TvtjjuLmxyw==
X-Received: by 10.13.229.70 with SMTP id o67mr9228810ywe.131.1479660760501;
 Sun, 20 Nov 2016 08:52:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sun, 20 Nov 2016 08:52:10 -0800 (PST)
In-Reply-To: <CAOLa=ZRf+vPOPK=ovP7JmJ52qdgwuqkpGH4UfP=+caQeyu9Ucw@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
 <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com> <20d067ef-9e2c-0d1f-f81a-06c154e95e4f@gmail.com>
 <CAOLa=ZRf+vPOPK=ovP7JmJ52qdgwuqkpGH4UfP=+caQeyu9Ucw@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 20 Nov 2016 22:22:10 +0530
Message-ID: <CAOLa=ZRL=UrfjZ0AypY5d_=-bi6JVfLsx5_3sVvf_rOapJ+m5g@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 20, 2016 at 8:46 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Fri, Nov 18, 2016 at 11:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>>>>> to get remotes from /refs/foo/abc/xyz we'd need to do
>>>>>> strip=1,strip=-1, which could be
>>>>>> done but ...
>>>>>
>>>>> ... would be unnecessary if this is the only use case:
>>>>>
>>>>>> strbuf_addf(&fmt,
>>>>>> "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)",
>>>>>> local.buf, remote.buf);
>>>>>
>>>>> You can "strip to leave only 2 components" and compare the result
>>>>> with refs/remotes instead, no?
>>>>>
>>>>
>>>> Of course, my only objective was that someone would find it useful to
>>>> have these two additional
>>>> atoms. So if you think it's unnecessary we could drop it entirely :D
>>>>
>>>> --
>>>> Regards,
>>>> Karthik Nayak
>>>
>>> I think having strip and rstrip make sense, (along with support for
>>> negative numbers) I don't think we need to make them work together
>>> unless someone is interested, since we can use strip=-2 to get the
>>> behavior we need today.
>>
>> I am OK with multiple strips Karthik suggests, e.g.
>>
>>     %(refname:strip=1,rstrip=-1)
>>
>> if it is cleanly implemented.
>>
>> I have a bit of trouble with these names, though.  If we call one
>> strip and the other rstrip, to only those who know about rstrip it
>> would be clear that strip is about stripping from the left.  Perhaps
>> we should call it lstrip for symmetry and ease-of-remembering?
>>
>>     refs/heads/master:lstrip=-1 => master (strip all but one level
>>     from the left)
>>
>>     refs/heads/master:rstrip=-2 => refs/heads (strip all but two
>>     levels from the right)
>>
>>     refs/heads/master:lstrip=1,rstrip=-1 => heads (strip one level
>>     from the left and then strip all but one level from the right)
>>
>> I dunno.
>
> We could have lstrip and rstrip as you suggested and perhaps make it work
> together too. But I see this going off the scope of this series. Maybe
> I'll follow up
> with another series introducing these features. Since we can currently
> make do with
> 'strip=2' I'll drop this patch from v8 of this series and pursue this
> idea after this.
>

I meant 'strip=-2'. I mean I'll add in the negative striping in this
series and follow
up with something that'd introduce lstrip and rstrip.

-- 
Regards,
Karthik Nayak
