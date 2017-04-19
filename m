Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8051FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 10:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762374AbdDSK7f (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 06:59:35 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34316 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762399AbdDSK7d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 06:59:33 -0400
Received: by mail-io0-f196.google.com with SMTP id h41so2930008ioi.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ESQ9JPcgxlJgb5VcSSbOlqSFR+knBZtswgxZIGYpK5s=;
        b=Fjqhlta5Kd6dSPf2XXwJ+dgZ/6JABGjOOdQUlhsyc7liBQXFAdKEKlGQmSoMqOjVID
         k24VZZKvmsnBT9Suvmw0YveYW5Bc2x5NFPNh6MpEfcYGCDq3MUdRT8Di3LylUStq4gdy
         ptlKJnn/oPBOEwv62uxVK4PSEI/Zz3PWYetjkhEjsl5jNm6suVClB/F/lYY7TxXS6T6v
         HSMfEqD6b2wtOVhRrmqnQZpEnU7iIziwyh+DNMS9et3h8UabL2TB7LKLqqTO1QPf+23X
         y6Y01As6n7siArryPii+9rJlxkdsRfIRmA2FyltFaGVk5/rtpKLXiugq1dszG/NefVKa
         khjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ESQ9JPcgxlJgb5VcSSbOlqSFR+knBZtswgxZIGYpK5s=;
        b=cRz0RQkkdG02qxs8DXsxH+BdOhSTZzksCr5bWtN3M5xIfRXnGlPVfQwWjYffIoPAhc
         1Hw4uOo3LKniedm2oEp2V5nrUvRVRlPi9+JHCEp1mQuQ3dGWyqhKOLpvABsx/lImYvXs
         2gE+t3+ioHpwF9EylvwFoJNLkWL+vORRJtCFC93yFLFk3N4RAvTA8Nno8i15TMsK1sqk
         ME6+zmeTsPU9zx8T8Ut+dvd4cztIEk9hoDBbuwEFbGvyewfgqMKlGFTx1KX/V0/Jt+Z3
         gmtM4kkVWjyXEN29Gx7VQUbwm1GyyzcnGj6JVX9Ww55lb2jJP65TPXZbIVZMx8RhfAuX
         3/hQ==
X-Gm-Message-State: AN3rC/7QnvJ26wbOZ/D2UniJf0DCMwfk3ITH9M/XCBhyEZjXxvmOMNlE
        JIpkGxcJqkqZA+6jEJvCE22jWCiRJA==
X-Received: by 10.107.35.200 with SMTP id j191mr2661462ioj.33.1492599573009;
 Wed, 19 Apr 2017 03:59:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 19 Apr 2017 03:59:12 -0700 (PDT)
In-Reply-To: <xmqqa87fluqd.fsf@gitster.mtv.corp.google.com>
References: <20170409191117.25175-1-avarab@gmail.com> <20170409191117.25175-3-avarab@gmail.com>
 <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
 <20170411003023.ynzc76yzdmomxthp@sigill.intra.peff.net> <20170411003554.2tjnn65vfco376kj@sigill.intra.peff.net>
 <CACBZZX4LxL_ZBnFwkwXSMfBPGcKvOtHe3LeMtG9n2xRqWVZBkA@mail.gmail.com>
 <20170411105408.332krulfrbqqi42k@sigill.intra.peff.net> <CACBZZX5SooaEjLSy-dTRF-Aa2EnH8S2hS+w40mPTUOvonBNPDg@mail.gmail.com>
 <xmqqa87fluqd.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 19 Apr 2017 12:59:12 +0200
Message-ID: <CACBZZX6BefyW3iYHYq8FJ_ZzGDghF_V7mSGpC_RxB-V4NfQnEw@mail.gmail.com>
Subject: Re: [PATCH] connect.c: handle errors from split_cmdline
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Apr 11, 2017 at 12:54 PM, Jeff King <peff@peff.net> wrote:
>>> On Tue, Apr 11, 2017 at 11:27:57AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>>
>>>> Junio: If you're not in some rush to pick this up I'll take this, fix
>>>> up a bunch of other bugs & tests failures on odd --root directories
>>>> and submit this and Jeff's \r patch (after adding tests etc) along
>>>> with it.
>>>
>>> That's fine by me. We may want to pick up the segfault one separately
>>> (though I don't think it's security-interesting).
>
> This one cleanly applied on top of sf/putty-w-args, so I'll queue it
> there without introducing a new "jk/fix-something" topic.  That way,
> even when sf/putty-w-args were to be merged to older maintenance
> track, this fix will also be there as well.

Thanks. That resubmission is going to take me longer than I expected,
so it makes sense to have that branch applied independently.
