Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A2A201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 20:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755349AbdCKUV7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 15:21:59 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:36487 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdCKUV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 15:21:57 -0500
Received: by mail-it0-f54.google.com with SMTP id h10so12575344ith.1
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 12:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mCYZdS+Rj1RUhYpxy4C/fMPv9cQKk+ZUITENTleLC/U=;
        b=Gzb/2bq1Z/HmqjvUZzBBtNPdfThLSrZowFQAAvYjpskaGquEj5Wuun3yIRBIq7FMNZ
         SwwmcOc+VI1p4+z9FJi0puhknZJcso+JfKFDOFa+Z6CqUClLFg2Dn+7LW9Qvwd9Ux6ys
         8UejYdh4IGeD5hduYowTsOKxB/cC+4lKqBclI29JBSp1jVEOXrygbml4hG7JkPhUAJTb
         l9hzNnclK71w5VfeC/rktRHJ68V/i72JpB64dO63vdJu2mTJ9oXBkf15HBRJoUqB1wra
         PbS83HeLGqwW1S+VBbA2Ro9dENegQjLKalyxvn7n1XE7c1KtUTJKau2UHte5hdNBNE0J
         +rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mCYZdS+Rj1RUhYpxy4C/fMPv9cQKk+ZUITENTleLC/U=;
        b=LkrSqJY/QJ62AJDAjbuxHHHuXTtY7H5Law2aWrvNTi8PbQDW9VWEi6qRvUwDhL+3SK
         +ifFWKFTjIQC8SVmHQc3vJQd4tdJ15YjgAJUhkZ7+9uOoxellI7+fK/t3KM9LPPYqa13
         iaZ0SRlBAyUpMZnNN3ziOHq2DjXD9Tbkhs1+kGubmLBwIM3qUd2cTFlFXkopbvJHWG65
         UdBVOohp9KaDWMUJsXhpg1AEuQaLRfeYpxNxcE2Je6uzfIxlMuRqk64bUV/wjpkDmHlV
         Pw3/XEj2r4R2O88Gf/+d1+anZpacU2VXHYmk/NRFMaTmq3LyLnALsmotlHrXoQ5sEv3S
         fqiQ==
X-Gm-Message-State: AFeK/H2EFh+gatyTLdEsu5wsISCggzUW6fHfcYDO6ftfwW1HUwQebuELy7sT3zvMgseL7F7RSTuwRFJaN6aGdw==
X-Received: by 10.36.181.65 with SMTP id j1mr4237414iti.91.1489263716117; Sat,
 11 Mar 2017 12:21:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 11 Mar 2017 12:21:35 -0800 (PST)
In-Reply-To: <CACBZZX5A46-ua9y_HxqrqycQviR0uGnStnaPwH9jukzPVak6ug@mail.gmail.com>
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
 <20170309132949.shyc4gmdrhazykev@sigill.intra.peff.net> <CACBZZX5A46-ua9y_HxqrqycQviR0uGnStnaPwH9jukzPVak6ug@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 11 Mar 2017 21:21:35 +0100
Message-ID: <CACBZZX7M9-4Vn4SWRNNkp4ek-D8GwtLKp3pr11SAr6jrk5fEXA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ref-filter: use separate cache for contains_tag_algo
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 9:01 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Mar 9, 2017 at 2:29 PM, Jeff King <peff@peff.net> wrote:
>> [...]
>> @@ -1874,6 +1886,8 @@ int filter_refs(struct ref_array *array, struct re=
f_filter *filter, unsigned int
>>                 broken =3D 1;
>>         filter->kind =3D type & FILTER_REFS_KIND_MASK;
>>
>> +       init_contains_cache(&ref_cbdata.contains_cache);
>> +
>>         /*  Simple per-ref filtering */
>> [...]
>>
>> +       clear_contains_cache(&ref_cbdata.contains_cache);
>>
>>         /*  Filters that need revision walking */
>>         if (filter->merge_commit)
>
> Shouldn't both of those be guarded by a "if (filter->with_commit)" test?
>
> That init/clear codepath is rather light, but it seems to me that we
> can avoid it entirely if filter->with_commit isn't defined. I've
> tested this locally and it still passes all tests.

Since that seems to work perfectly and we're doing less work I've
incorporated that into the v4 of my series at
<20170311201858.27555-1-avarab@gmail.com>.
