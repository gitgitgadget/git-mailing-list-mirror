Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51BCF1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 21:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfH0VjK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 17:39:10 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:38653 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0VjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 17:39:10 -0400
Received: by mail-io1-f46.google.com with SMTP id p12so1622727iog.5
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xuAYuuHkM0ZRfbIvok7vi4wFAE1fmhn4TnP3F/aWmpE=;
        b=in1MJzQCoBN7JcdY2bHeUH9gFIrzBmng9q1OvtgY5rX9UbuWyWw7ZfBTNOWGLSrjBX
         45Dhj37kWxRI1KtmUESFDgLfxuVBR+iVf5Moy8tpmnwNmW+2GwIPWtUi2HtoWDdF+fX0
         jjiMmn6V33/5d0NIYr5pqRkhZ+0snhTnMMy0PS+a1a9HBI8doY8Fv7i1kneZTOLq4USF
         RbYuE1wEJZwLBMilkVg3XZewsg0on/AXFnknwKZaJwfbdhN3Q+EyrHr/F1cIDIGBP9el
         +NPrzdbTex7lp6PLfvoc85CJILjMvKuiiAghYbhg9I/dMB/0fWjL/AOVtikfehiIvrdn
         bYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xuAYuuHkM0ZRfbIvok7vi4wFAE1fmhn4TnP3F/aWmpE=;
        b=S2JT6X/T76d5jdOs2MrXBMW6hSfUyEC1DznnplmrD4AC87XvK+NxhqSEK+ig+XuUD8
         W5ir/vQiMdQAbz6VCyRSK9u/qeBQNx9ml46eQhRCklCARzeq7LG5YxyihE4gwmcEJx3A
         2A2yy54Etlt2A8CyEAyZSzQflAV9kywcLW0jsEgzKPrMh2EKxKhLKOmxFgaPHwJX4M2T
         ORqbyPvxdj+ZttmnGa92hYYXjI9JemGsUR2E7Oa3OwwxpGrUvFjRCm9ud/pKljV8D7EJ
         l4O6D1Oqo3w0kGkJbNSCtNG7IoIb+LxHq3mm500O2k4QfBd6yqRiTlopDVkgEALlPppn
         mc8w==
X-Gm-Message-State: APjAAAWpo733I1UZ9xh+B5hazO+C9G5SOTlUVxjANfCWE+DmMRFTTxKF
        RBhsuFZ07NEjMB8ZOW/qRz2OIMJkNhm6gzyz07rZhw==
X-Google-Smtp-Source: APXvYqy5+rh983MjrPRdbSw2c5iSAz2wZmrPanLL8krJHtJhdV3GJVE92mRsAr8/54SfIEegMAHu4uFUUAj4L/vvebs=
X-Received: by 2002:a5d:8253:: with SMTP id n19mr528136ioo.274.1566941949098;
 Tue, 27 Aug 2019 14:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev> <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
 <1566897126.4102.5.camel@pengutronix.de> <20190827094407.GV20404@szeder.dev>
 <20190827100427.u3a5uvmylm5vddn2@pengutronix.de> <20190827185929.GA3150@sigill.intra.peff.net>
 <20190827213248.kzpszutt46ipboq4@pengutronix.de>
In-Reply-To: <20190827213248.kzpszutt46ipboq4@pengutronix.de>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 27 Aug 2019 14:38:57 -0700
Message-ID: <CAGyf7-EaumF+oZFUhNtifrCvqBr1DjcFh8rgQMswcpwip3Bx7w@mail.gmail.com>
Subject: Re: git slow unless piped to cat
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Git Users <git@vger.kernel.org>, entwicklung@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 2:32 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Aug 27, 2019 at 02:59:30PM -0400, Jeff King wrote:
> > On Tue, Aug 27, 2019 at 12:04:27PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> >
> > to see the loose ones. If there are a lot, try:
> >
> >   git pack-refs --prune --all
> >
> > (or just "git gc", which does this).
>
> This is a daily updated mirror that is also incrementally backed up. I
> repack from time to time, but hesitate to do this regularily as each
> time I repack the next backup run is "expensive" and I get many small
> packs. I did this now anyhow.

Just noting that Jeff didn't suggest a repack; he suggested a
pack-refs. This should have little, if any impact on your backup
processing, because all it's going to do is rewrite the "packed-refs"
file and delete loose refs. It doesn't modify any files under objects/
at all.

Bryan
