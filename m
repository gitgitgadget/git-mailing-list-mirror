Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194FF1F462
	for <e@80x24.org>; Wed, 22 May 2019 18:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfEVS3d (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 14:29:33 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37852 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVS3d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 14:29:33 -0400
Received: by mail-wm1-f41.google.com with SMTP id 7so3227983wmo.2
        for <git@vger.kernel.org>; Wed, 22 May 2019 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OOv3tMYoBVkNuHyK0PkCZ+z7Nyvpo27fNjUuB8MiwoM=;
        b=BgdwfsJGvCzaebk3Rlj2e2wwoZqLIoWAQoDkyeoX0HSOIAVv4o+zG8TmIycCKVI4Oh
         0YO+nd60xxi9hSu9rl+52oNnjpy1GCv+9KPa9PckuxY4swjvgUbecWAvpohYZ3z459pJ
         z+ZY+Y7W4QTw9GPLfPtLUJpEI6XEWU9i2IOv//LFztKTN1nTfcwT/7lQ+ct+yyCgCfjg
         ugBR/319uy3GnGfclyceOlIKOxanPDvo5fAjCN15nSGjSQV8xjx7fUE9xBDAEPo/j2Jy
         6WoZbXf+NQ7diMFf1Fdy8F8g+X6tkv5CqPsQDVtgc1ZadpXFudsH5p1pdUHIIyS3rSWw
         Xhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=OOv3tMYoBVkNuHyK0PkCZ+z7Nyvpo27fNjUuB8MiwoM=;
        b=enjDp5ZrpKBxDv6UbFSz/9qJPjHVPhhoIJHy/n8MJgorpHiK9F2GVmGpqtYPTOiIst
         cnwhSBoAxPWyRYUitU3PR32xf7pKd9/0LVzz/RcRJzSxcZIXp0HVIXZEhYOfxjk5m3jN
         Onuq/6rclK72lzdnJET32C/T2R4wEqw9FVCkL2k/3YekgjFxVS2BmuXtJVfzXKXYN8am
         9YG7d4T8BegA8jku+bEV8vl6dgBkgjh4Tbbrvq2OrosDoKGQProZ5O/hax2m0ZGQiQ89
         dqJY8SzR9nrZiy6sq1ug8ESEi2Cis+qdGiIy157lTztsTPMSMR2y+dyIU6Z76Vv1zo0Y
         UHvA==
X-Gm-Message-State: APjAAAX2HiUNU9AWITPtIrct5tkYsQW3BoKadrftTS1MUXJidOmEd2ER
        DSrr9Hf7/zZrRib9DAKSTGlhgrPip54=
X-Google-Smtp-Source: APXvYqx5XciB/7jyoHLIIBcQlde59Hu4PsFvwGPTMmpvUZxEiEM0Pj48Tq/vFA8YGCWz6EMBJDyJRQ==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr9174223wmj.25.1558549770731;
        Wed, 22 May 2019 11:29:30 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egt208.neoplus.adsl.tpnet.pl. [83.21.83.208])
        by smtp.gmail.com with ESMTPSA id s127sm8280675wmf.48.2019.05.22.11.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 11:29:29 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Revision walking, commit dates, slop
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
        <20190518015005.GA951@szeder.dev>
        <20190518035828.pjaqfrkkvldhri6v@glandium.org>
        <20190518041706.ct6ie5trvxgdhjar@glandium.org>
        <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
        <86mujhpewj.fsf@gmail.com>
        <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com>
        <86ftp9p7i8.fsf@gmail.com> <864l5opuz1.fsf@gmail.com>
        <88662e18-db51-cb48-3307-0ea2a91c4ebe@gmail.com>
Date:   Wed, 22 May 2019 20:29:26 +0200
In-Reply-To: <88662e18-db51-cb48-3307-0ea2a91c4ebe@gmail.com> (Derrick
        Stolee's message of "Mon, 20 May 2019 21:20:45 -0400")
Message-ID: <86lfyyny0p.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/20/2019 7:27 PM, Jakub Narebski wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> Derrick Stolee <stolee@gmail.com> writes:
>>>> On 5/20/2019 7:02 AM, Jakub Narebski wrote:
>>>>>
>>>>> Are there any blockers that prevent the switch to this
>>>>> "generation number v2"?
>> [...]
>>=20
>>>>                      Using the generation number column for the correc=
ted
>>>> commit-date offsets (assuming we also guarantee the offset is strictly
>>>> increasing from parent to child), these new values will be backwards-
>>>> compatible _except_ for 'git commit-graph verify'.
>>>
>>> O.K., so the "generation number v2 (legacy)" would be incremental and
>>> backward-compatibile in use (though not in generation and validation).
>>>
>>> Do I understand it correctly how it is calculated:
>>>
>>>   corrected_date(C) =3D max(committer_date(C),
>>>                           max_{P =E2=88=88 parents(C)}(corrected_date(P=
)) + 1)
>>=20
>> This should probably read
>>=20
>>     offset_date(P) =3D committer_date(P) + gen_v2(P)
>>     corrected_date(C) =3D max(committer_date(C),
>>                             max_{P =E2=88=88 parents(C)}(offset_date(P))=
 + 1)

Restating it yet again:

   A.  corrected_date(C) =3D max(committer_date(C),
                               max_P(committer_date(P) + offset(P)) + 1)

   B.  offset(C) =3D max(corrected_date(C) - committer_date(C),
                       max_P(offset(P)) + 1)

> The final definition needs two conditions on the offset of a commit C for
> every parent P:
>
>  1. committer_date(C) + offset(C) > committer_date(P) + offset(P)
>  2. offset(C) > offset(P)

The equation (B) ensures the (2) condition, i.e offset(C) > offset(P).
The equation (A) ensures that condition (1) is fulfulled, because from
(B) we have

   corrected_date(C) <=3D committer_date(C) + offset(C)

This from (B) and (A( we get:

   committer_date(C) + offset(C) >=3D corrected_date(C) >
                                 >  committer_date(P) + offset(P)

> Condition (1) will give us the performance benefits related to the
> committer-date heuristic. Condition (2) will give us backwards-compatibil=
ity
> with generation numbers.

Well, we should check/test if performance benefits of "offset date"
("corrected date with rising offset") truly holds.

Best,
--
Jakub Nar=C4=99bski
