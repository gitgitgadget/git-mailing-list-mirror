Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D405320372
	for <e@80x24.org>; Fri,  6 Oct 2017 19:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdJFTon (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 15:44:43 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:48464 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdJFTom (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 15:44:42 -0400
Received: by mail-pf0-f176.google.com with SMTP id n24so10019086pfk.5
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eTt80R3bM9z0ewH8/8L6f2rBL4VWOBhX2kie1roZy6w=;
        b=Ws7O7xCKfeWrap/bPQX/tNNmTKGJFJ+d6mos+ae8HuXTyL50mMAfPo+CmGhdacX8IC
         qRMaxP1AuRGsuXnLNnXIcTRd5pYvdOXBhUSg+hoNV4Jx9nfnJNrELq1xAadIdyEy61Zz
         dDhOI5Ozj6jqiNUKtHTvERH5aV58F8hJvFVveWQT8RUPl+AiBB2ijW0O9qyEj0uePlm/
         ZdHYpGBkbAqbUu4iFntGbfOXK3a5LB3KpZBq5eCy977To+wb+9wyS8XyJIXtehAsGQMX
         xsJ90HQlnlhaZ5uF4s51AWKgmaoosulmRMvENiv8Vl6qIHc2lmmtu13DAEcf+hM35seb
         KxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eTt80R3bM9z0ewH8/8L6f2rBL4VWOBhX2kie1roZy6w=;
        b=j2OPx+bQF1qWA075r5Rbr7BQUtj/T8rNPFvmPGmzh2ob2iylhoJqCv3N3XbhzfAt7e
         hrNT6kWMIbQJRcxtCNo0a7OjfinjqgVhPt/ZmYl3ACUgoJbVqpdqatl0VCS9sp2eytpd
         mdE1QG3+uzw93bzGHdnX/q8rOh/338xB1otLgdDtLVe2V1YtbrSRcEV7y63H3jrcWPwP
         8xRr4SxD+hxfqQJtqDbzVhG+BEF7SN/QzBMKzotE8ZCetGqcp6Cf9Y7uOjYSt5f2OKyl
         oX5Nk0C8k4XI42EOsSKNlysjD2pwNc6JmnZbe9DzFz9MM2bm0V/0CUq2mSto0stAQApu
         9muw==
X-Gm-Message-State: AMCzsaVlTRC0cYZNjUBuBW69Zi9QGzKPiTyhasmSKLnYz93n3dT72z9S
        MnSoacOJSvHwoFNIYQ4xVWseCzmSWCrmj+RQcs8=
X-Google-Smtp-Source: AOwi7QDcQBJF5Gm1kRdzAqrnbp/DPGEplJXnfv0m5Rf/XmYSqGnisPUcPQCNZAnx55sLMH2X8deo5iv8ZiC3rRwbTgA=
X-Received: by 10.98.35.194 with SMTP id q63mr3114829pfj.15.1507319082304;
 Fri, 06 Oct 2017 12:44:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Fri, 6 Oct 2017 12:44:41 -0700 (PDT)
In-Reply-To: <xmqqvajsv60e.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
 <b5fc950e4594fb9dec07ec8872c0df8514d149ff.1507228170.git.martin.agren@gmail.com>
 <xmqqefqhyqyg.fsf@gitster.mtv.corp.google.com> <CAN0heSojqHEQQfwUaGuLH2TjN+aHSFHg4WAvcd5Ksnxd-54YMg@mail.gmail.com>
 <xmqqvajsv60e.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 6 Oct 2017 21:44:41 +0200
Message-ID: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] read-cache: leave lock in right state in `write_locked_index()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 October 2017 at 14:02, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> On 6 October 2017 at 04:01, Junio C Hamano <gitster@pobox.com> wrote:
>>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>>
>>>> v2: Except for the slightly different documentation in cache.h, this i=
s
>>>> a squash of the last two patches of v1. I hope the commit message is
>>>> better.
>>>
>>> Yeah, it is long ;-) but readable.
>>
>> "Long but readable"... Yeah. When I rework the previous patch (document
>> the closing-behavior of `do_write_index()`) I could address this. I
>> think there are several interesting details here and I'm not sure which
>> I'd want to leave out, but yeah, they add up...
>
> I didn't mean "long is bad" at all in this case.
>
> Certainly, from time to time we find commits with overlong
> explanation that only states obvious, and they are "long and bad".
> But I do not think this one falls into the same category as those.

Ok, thanks. I've got a rerolled series running through the final checks
right now. I did end up making this log message a bit more succinct.
