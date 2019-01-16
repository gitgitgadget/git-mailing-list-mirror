Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935EB1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 11:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfAPLNY (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 06:13:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41266 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbfAPLNY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 06:13:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so5074124edc.8
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 03:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijWb9jQN/s+S9Zh8VlszMTwfRql9hBUeu9AAqOeECWc=;
        b=baJuVmEbfAzZcynPmneRyzX134Ko9HPyVs9kvUohqg9ute9ONXnCrYfb+9vHjWH7vt
         YK0oY1sBtwEJ8VikEfNKY72eCJrs+UbIHcFLAUbj29SOaMtQDEvGyX+8zXnrg4a9W48w
         pX75kjVAVXBN2xbkUEC8JWRWrpIHCgqnNq2TfCxOhqmD5jZAuSh1A6Mr9hsWZ9spX4IY
         nHSIs0OSCVycmpxl+yLwy/E5NY+nIOzXW6d/n7CPFk8OIhytqz2RQaBaonCswFcTlpfD
         d9g7A2B1TNMeuP7rzv58RzaCsqKmUvBT/4O6zJfeN6za1Co00LxyAZcuRwnbyyaUUQae
         w5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijWb9jQN/s+S9Zh8VlszMTwfRql9hBUeu9AAqOeECWc=;
        b=iMl5P8mZe/eoAIqldyUGUvgMZNvje1Db5EHgkOkxQq7mTRJpjb8s3Fd/lDYPS5GLIu
         I1EqlySXXbwQ96D4JtEM0zUKQAexNZch2R1Sya/W6Af+Yofwxo52m2mhgtadLmHsWvqY
         8rWYr/pdzpoc/Fowgh2JstpHn4zC1HnfRs67CRgrO22TiqNlAwLyZOTAvcGX27EvZVG7
         thqo+Aqal4ngCsGAA8/aZBqBP3l6x1UjiR0eKX5K9njY2r4N7E3OQYZlPsT/kT7Nuy45
         nTeu9avUvpF8NQ3KzlW6NLy4k3VT2596a+Vnlij1gcNlyZy+f5WCg5bJ0ZwrlA3+TcY0
         i8ig==
X-Gm-Message-State: AJcUukcy0OJ1bNkBDRuz79vkhfgYfhE0ur8mUlJHYZDCpvUn8O/iRRwl
        GdUWPxOaKCXbmQIjS2DT/OLvv0/MFwQcpDtPKIo=
X-Google-Smtp-Source: ALg8bN4ENhw90vGuDPXktQgwdYD+DhOz6dqmny8e2tMvPEdzZnDBd//ue9XKqdC5rEaTTBfKZk79Xq7dnYj3uD3j9E8=
X-Received: by 2002:a50:8f86:: with SMTP id y6mr7220415edy.131.1547637202264;
 Wed, 16 Jan 2019 03:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20190106154637.10815-1-chriscool@tuxfamily.org> <CACsJy8B7ogYEzwDAT7v1z4T-YsTa-e3VPbCfNBmc4v5R=06meA@mail.gmail.com>
In-Reply-To: <CACsJy8B7ogYEzwDAT7v1z4T-YsTa-e3VPbCfNBmc4v5R=06meA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Jan 2019 12:13:10 +0100
Message-ID: <CAP8UFD2vLhn1_hUefKfsE8+3SDZk6qzf8eS-DUoZLhf41QiyAg@mail.gmail.com>
Subject: Re: [PATCH] helper/test-ref-store: fix "new-sha1" vs "old-sha1" typo
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 7, 2019 at 1:53 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sun, Jan 6, 2019 at 10:46 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > It looks like it is a copy-paste error  made in 80f2a6097c
> > (t/helper: add test-ref-store to test ref-store functions,
> > 2017-03-26) to pass "old-sha1" instead of "new-sha1" to
> > notnull() when we get the new sha1 argument from
> > const char **argv.
>
> Ack. Definitely copy-paste error.

Thanks for confirming.

Junio, it looks like the patch has fallen through the cracks.

Or maybe I should rework the commit message?
