Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A391C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 17:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E05208A3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 17:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRHPF2So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfKTRJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:09:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38326 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfKTRJE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 12:09:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id s10so151017edi.5
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aQ8278EoSQnsh6GwiU78k/okBHfLmOeqkQlqu6fnwqE=;
        b=RRHPF2SopeYz0xu6xZJEEQGiClnh91si14/S3L9QnavaNPitdI5nKPkpci/Lj1AQyI
         HQAwo2TArnURpKzZFtii3ITM4q3BbLy43udtHoKZKHDqz3+9kjIA5mU6OW4jB78/IkTQ
         kHynkFk/DKDk189PI4hSN1N+CeCjKRXyJIkVz/dHfgGwsC29Oi0N04oYZuaEKynGD9Ic
         aVAKa3eT/2wwprSu8HUSpuGy7WrmkolVdn+9CkYYDNa4MM9oVDegC+IK66N1UuQoFTOt
         zKOKwGPPAPpQ0GV8y5zPKl4xfNOSqWcBESnFxYSj8qfwzH4EaIXWMEDXX4CMMjIGjjb5
         mMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aQ8278EoSQnsh6GwiU78k/okBHfLmOeqkQlqu6fnwqE=;
        b=GnKJkTNEe2BZrS+wAX/HmZkaVCm/BLez1qW/YhDQHsGFymfjKy89V2eAryuFRVv8ox
         mVH784zAx/A9SN2GO5R+uM0epuKLnRJQDRMiZ4elawwl/nHrFVymhDggE68w6iyj/a2Q
         nYHQM2j+1GfBrCZ/i24zP71zhXiqHhAK+Wld4H7r27+S6W4L1wVHkNHa7Ql3SVABmAtY
         1eKFsKhhgAZ994snM/mUNubZRXgH3IAKYV6BqOnmwk8rNRJcsUwXDgFJ0gdKGh3v52wQ
         qNyrxUUpXnt0F6K5VY5B7+OQstiDP37FaY1Fd6bT0uB730KRTxqMskK3DRaj8M1qL7+O
         TIEg==
X-Gm-Message-State: APjAAAVBSgzMb1wg+FpiP+YzFP9uanG/9UyZKTXFAZApVXNI1oXRVbNp
        71HRU1K/N35nTF9+2kBZ+i8jzttkVODDI8lYZlWafJ1E
X-Google-Smtp-Source: APXvYqylYjg7nUDT5QydV9gXPj/fLs7I8/UKGL5jVoYJv2zoHVT7Sf+ywOf5Kus4Wgl07jhwrpBu6XAHPoFquPFhC+Y=
X-Received: by 2002:a17:907:447b:: with SMTP id oo19mr6395675ejb.81.1574269742382;
 Wed, 20 Nov 2019 09:09:02 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 20 Nov 2019 18:08:51 +0100
Message-ID: <CAP8UFD2CDUJ3XFmGQrc0htBu9R3asOjHaOzrjE3ae7QWCoELrw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 57
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jon Simons <jon@jonsimons.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 57th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/11/20/edition-57/

Thanks a lot to Phillip Wood and Andrew Ardill who contributed this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/408
