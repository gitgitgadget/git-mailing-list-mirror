Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401C91F991
	for <e@80x24.org>; Mon, 31 Jul 2017 17:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdGaRpB (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 13:45:01 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35177 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdGaRo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 13:44:28 -0400
Received: by mail-pf0-f171.google.com with SMTP id t86so13824726pfe.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+hezaXpRMz1JyNh//ewwWQD9lfFAICsjD1J7PEhLHYI=;
        b=sNue9RxV3g5VkcLCgG8mrM/6SMNRuL1I6/mmYGHtwm3w1ve4LiTT7Ftj0Xz/A88A1P
         oflN640EFseBJn9E4jcfkUKhmwcaJAkmQarQsNJJ+MWHiJ3uOgTy4cx8jeTbJ6WT1kt/
         KQ2H08RhInFT1TA3wbeDOP1cPxB4yQrxfFEwuPxxuKYfxpK9Nh0dUPld1ZE9PFXNTjcV
         NnV39AezU4EIh5fJsTeqriiFDN4tb4gEds5um6jE6qO84wv5qUAyaqiBgGQrvU54MKeI
         l7skTmhwykXACbdrfp8QwEBoqoF0C/LPNw6jUr4F6+qCSfE8xu3kKSY/gvK4ZK62wqjT
         Xqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+hezaXpRMz1JyNh//ewwWQD9lfFAICsjD1J7PEhLHYI=;
        b=XrGfvcPGh5A8HtmF6xEHoPlUQqqvcbuKLZ273ctbRH21xwdY3HilJ8Tqc3fOE1cdeb
         Ef2uvNdjq7e5Rjv0WUyKTf0tL6S2Xg6btkXiOikr314sZFZXf8+4hUF6Cn/rFZmEvu0j
         zwCAQfQq3Xbjwl3mmrwRVPGUkC7CgHfJzmYJDIrzdw9OOTEw3XGBEkSmjIDvk6MWOSf8
         PSn00HDM3LbZpxnsJuPyPfwsbChMHJGiX6fUH0gYwNThSuZbHvXuKFNY0l2Sb2db03LJ
         Mzv+Kri/mvBUIJ2yzfZAwBPC+5a1fpGRdnlTe8i6jGn35SsNUeKaIPv7KlfNRlFLu+Yb
         OFaA==
X-Gm-Message-State: AIVw111iqF09JLHuuK7Nc+f+3fuj0eUpkwmTGoXuaktuJtObpv5w+44s
        V0GgRw6SrspVln4Qo9QkQsFuUSXY4A==
X-Received: by 10.84.231.131 with SMTP id g3mr8859765plk.283.1501523067702;
 Mon, 31 Jul 2017 10:44:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 31 Jul 2017 10:44:27 -0700 (PDT)
In-Reply-To: <20170731034632.r5m3ncgb5scqvltb@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
 <xmqq379qkalj.fsf@gitster.mtv.corp.google.com> <CAN0heSokk9RAYx7pB_qC5dbZ3N1ZJQgKkrmhrPXmyHjFsnJu7Q@mail.gmail.com>
 <20170731034632.r5m3ncgb5scqvltb@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 31 Jul 2017 19:44:27 +0200
Message-ID: <CAN0heSonTXWPf-iTbwRbUc8CpYHoX7GBS5uCFFXn3bEPmWtitA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] tag: only respect `pager.tag` in list-mode
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31 July 2017 at 05:46, Jeff King <peff@peff.net> wrote:
> On Sun, Jul 23, 2017 at 08:17:42PM +0200, Martin =C3=85gren wrote:
>
>> On 21 July 2017 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
>> > I tend to agree with you that 1-3/10 may be better off being a
>> > single patch (or 3/10 dropped, as Brandon is working on losing it
>> > nearby).  I would have expected 7-8/10 to be a single patch, as by
>> > the time a reader reaches 07/10, because of the groundwork laid by
>> > 04-06/10, it is obvious that the general direction is to allow the
>> > caller, i.e. cmd_tag(), to make a call to setup_auto_pager() only in
>> > some but not all circumstances, and 07/10 being faithful to the
>> > original behaviour (only to be updated in 08/10) is somewhat counter
>> > intuitive.  It is not wrong per-se; it was just unexpected.
>>
>> Thanks for your comments. I will be away for a few days, but once I
>> get back, I'll try to produce a v3 based on this and any further
>> feedback.
>
> Overall it looks good to me. I left a few minor comments.
>
> I actually like the split. I found it pretty easy to follow (though
> squashing as Junio suggested would be fine with me, too).

I assume that by "the split" you mean patches 7-8, not 1-3.  Anyway,
I'll squash since you're fine with it and Junio prefers it.

Martin
