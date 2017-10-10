Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AE2A20404
	for <e@80x24.org>; Tue, 10 Oct 2017 17:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756404AbdJJRCD (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 13:02:03 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:56838 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756392AbdJJRCB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 13:02:01 -0400
Received: by mail-pf0-f174.google.com with SMTP id b85so6695730pfj.13
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eJPF/5shYYP7ZVtVXX5RR3Wx8idj+wOhmTGs/XAIFNI=;
        b=JHhYptgo81bqpy4xJX88ih7TogC6kHy19Q8UEWHx/FzVp3336XPW5wN9/9WrAbJvo0
         atilU2zwl7GqMWsmpkctMHKccLiqfIZ4yIQpkjHNrVNMrj/jLcM1Af0n8tCB5aDY3nrf
         LWeBjI8/zdIvK7Oq2Rgw48HOwAHJpeyB7F1PrLV2Mq0ZA9n6h5aweaqkXqPfhBgmGeW8
         CYZ5eraOQZ8AQUpxPGtxgm0Rf272r1JHTBMX9asl5yRCEeTxzSwWxx+IPdHFCS2c4Mfh
         DBjewGBkvtzOPTLEPYTdbH7VwFWW+37iGDaMI2B/FNJtCBwFCOZBCEJtFCdnxvKvTRtp
         SkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eJPF/5shYYP7ZVtVXX5RR3Wx8idj+wOhmTGs/XAIFNI=;
        b=kHZGocEJ4bV0IYxPT7l4CtiFH1sX5wGfBWGfon1+w8g03UPopH6kNkAft9XAWgGr14
         hCQEai4I8g8bRKuJjMvK6RfegmAbHcbnc6TD4s+UYxNbSKDZspRKGveZr5AGl5YEZwbg
         t46a2a4eXVPPKJu1NyNq6qj140Oc3M/QwnOkA32cx5H73B9phFtII3mgKteg6QYZmoOt
         J50zkQGOnqasVhyfmXurSsw6cjpfAQMvNyLSalQDXDuXY13w4OgN2sUy80XojLr2GRdi
         2lkQ9FmV1RMGyOga66Su1Rhl3JCetvYT2q0O5fYSmSBSPBGuypApqrQk0Xpsjkbm+x8g
         4iEA==
X-Gm-Message-State: AMCzsaVqlfJDnfM1tuXXGvIANlMjUmIF//7aCUWuT+H6Q1I/R6sd2V4m
        x99AwPB5i3uuzNz9Q07STQ7ys345Zrwj4dmmP2A=
X-Google-Smtp-Source: AOwi7QCvsT/tjIhG3uZRILIvyQpYoKUdBC3oa4abxje00tMwxiCdHpk+ospoN2rXe9GW908CYfiHNcuU4B7wBrVtA4w=
X-Received: by 10.101.73.79 with SMTP id q15mr13203976pgs.236.1507654921282;
 Tue, 10 Oct 2017 10:02:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Tue, 10 Oct 2017 10:02:00 -0700 (PDT)
In-Reply-To: <20171010140118.quyesljvz44wvfx6@sigill.intra.peff.net>
References: <20171009214543.12986-1-me@ikke.info> <CAN0heSoWTpVZXmJkoEQtc_rjFj3PdPWV_37B9LukxxsYy5ox1w@mail.gmail.com>
 <20171010140118.quyesljvz44wvfx6@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Oct 2017 19:02:00 +0200
Message-ID: <CAN0heSqZn1pqskK-KP=DEW1-Kz=-avX0TUON38Dk_TVKAsBAiQ@mail.gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 October 2017 at 16:01, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 10, 2017 at 12:30:49PM +0200, Martin =C3=85gren wrote:
>> On 9 October 2017 at 23:45, Kevin Daudt <me@ikke.info> wrote:
>> > Since ff1e72483 (tag: change default of `pager.tag` to "on",
>> > 2017-08-02), the pager has been enabled by default, exposing this
>> > problem to more people.
>>
>> Oh. :( I didn't know about "column" to be honest.
>
> Yeah, I didn't think of that with respect to the pager. This is a
> regression in v2.14.2, I think.

Yes.

>> In any case, it might make sense to test an
>> actual use-case also. Of course, the code should be largely the same,
>> but in builtin/tag.c, it's quite important that `setup_auto_pager()`
>> and `finalize_colopts()` are called in the right order.
>
> I think it might work out either way. If we have started the pager when
> we finalize_colopts(), then the pager_in_use() bit will kick in. If we
> haven't, then either:
>
>   1. stdout is a tty, and we'll kick in the auto behavior for columns,
>      and then later for the pager.
>
>   2. stdout isn't a tty, in which case we also won't kick in the pager.

Right you are.
