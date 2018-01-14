Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9221F406
	for <e@80x24.org>; Sun, 14 Jan 2018 10:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeANKnH (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 05:43:07 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:43671 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeANKnG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 05:43:06 -0500
Received: by mail-ua0-f174.google.com with SMTP id l12so6789086uaa.10
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 02:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=92Q/GIm2a55FoSBnMnTWXFXW+lMwSwusNC4aN8aeLcM=;
        b=BF1KVuoVVI4Zri8wfXiQmj/7qeNdcAplWrWkur4ZYTNI6OkJ83ajYFtmZ86CLnjSCy
         NU5/scl/H/hW06pXSlx9OlpEfgy2EHp7D2tv6y3rCd6+RB5/MwrYiJrqcWalOHL3aslY
         yFUBQlYTjf/wFnLWRviEm7YUziQIMKfPkDhVXtUiVhfDEWiil1GBkC1K9c4Vq6pqcXHP
         tOfwxW4rwrm/yt+B7qXxkoUJk4/tqXg3kYA2ZClbCW7ElhBeJtRYkdBlQMOpjMHoB8w4
         ZTAAJ/cm6OkpLPOd/36QgA0vwFrS8jH/X/d4AcfASOccwPsrHdEp3UwtaCs3NqK05mB8
         4yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=92Q/GIm2a55FoSBnMnTWXFXW+lMwSwusNC4aN8aeLcM=;
        b=fL8qc54GKG0XSvZiMdTy1nMaXZy28+L/6QoPpXmswRBQn59dlcFplR9s0vaTrmeylb
         pM1BiUqlMmhGxbnwhE8t2NRBReAwGfWvF1ZlYK/Nl9b7944SMWFpofCnEwA03GbjqUlc
         LXnyz1HvBqCdawDGRqWLexg3+PP8FxeuP0ySF15jEn6eqDq0pXgL54iCZvLOn6b8ADlZ
         U7ytih6Xl36mygKXJVOG8yN51iW9f5gmSeM8UKRZS8YCU81EMhlRVmP71p7WWI5BgMeD
         C6Pj3nAZS9+LIUDSy1WUIM1eK6rjq+Kl1mCa9kkHV0wejwVkN3GrNLCwn1DV14cK820U
         vk+w==
X-Gm-Message-State: AKwxytdfJfz23I+sXbSn67SkFwM0U54DMBYOqInYDUfT9KC0p8x9zW4T
        BppXny/jxvcngZ34YBMWxTIqTgcqRIslsQiAvnc=
X-Google-Smtp-Source: ACJfBovB4RIV1Ham3FDNMKEQaCO2zNAIWCqvJte1fsw06+8Uhn6M7ju0qt3s9lM6FfT/Hwi7bqjOlV+jvHWAfyBHzKM=
X-Received: by 10.176.76.43 with SMTP id l43mr9379625uaf.93.1515926585746;
 Sun, 14 Jan 2018 02:43:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.10.140 with HTTP; Sun, 14 Jan 2018 02:43:05 -0800 (PST)
In-Reply-To: <20180113105407.GA31825@sigill.intra.peff.net>
References: <20180108172214.23615-1-szeder.dev@gmail.com> <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
 <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com> <CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com>
 <20180113103255.GA31117@sigill.intra.peff.net> <20180113105407.GA31825@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sun, 14 Jan 2018 11:43:05 +0100
Message-ID: <CAM0VKjkmEThnM7KdQ=SJFGK1E_zdjsCFnFas7fsRG97aQmS52g@mail.gmail.com>
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 11:54 AM, Jeff King <peff@peff.net> wrote:
> I think there's also a similar feature to include timings for each fold,
> which might be worth pursuing.

If you look for 'travis_time' in the raw log, you'll find lines like
these:

  travis_time:start:01ccbe40
  $ some-command
  ... and its output ...
  travis_time:end:01ccbe40:start=3D1515840453305552968,finish=3D15158404719=
60386859,duration=3D18654833891

So it seems doable, but we'll have to do the timekeeping ourselves.
Running 'time $cmd' is much easier, but that time won't be displayed
next to the folds, of course.
Do we really care that much?


G=C3=A1bor
