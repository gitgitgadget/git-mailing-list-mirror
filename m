Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385FD1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 09:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFCJf3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 05:35:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39697 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfFCJf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 05:35:28 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so13741015iod.6
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/Q6iSNN+IgPJMG6L1olsMdECnhLRrD8est07Bc/xXI=;
        b=qxEwYl+O403hcOU2DS2uC/ZyoJsyTcLmmUE9FC9FrZGeBPf+TQHkgu8gSj1gJXBzux
         HlF2TOAzfZb/d90eQUObAMzLis8QBG44/cfPkEjNImoNuAuxtJjkUWUUm1es+sty6hha
         eayjYcKVmWpBl++ydf3E3HbncHG1Phi5i4qRCsKX0i9xlGNY6j79Ttsz+x5q4hbTsHCW
         USZsouy4BxDJ0VSBHl2Hg02z3IFrSr9ECtyPvgDsiR455yndkqu28bQSSGcOwBAgg+UW
         DI1anH21SHjX9IxP8THAgIQaaqI/nifJLe+MKQ+U7sq/THLNmD2djoZ9HyXWeFvQ2z5G
         1X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/Q6iSNN+IgPJMG6L1olsMdECnhLRrD8est07Bc/xXI=;
        b=HGZM26LWKagggvopQuQwyH8N7AfW+XfoHSMc5E8ZOJwiV/zDC7G1AphRBZuCdz8buu
         9x8Du6mwwruNJl7RoBz5cJ9lFhS8LWhnGaMzcKU1rjLCO8RWQjM3wIbXDuvyDsnKpeRN
         c4U/kMD1Bl7ZH+m31RCghax2L45HQ9i3E1xSjlBL9VHGBRR7+7448S7HQIE8IM1vzNvG
         OefJpseJiupLcX9R7MCE7uC2lsKmOnKa89T8/jYlKpFDMWm7fkDaWns9542fIqi+BPBm
         EVITdtkTQ/FaLuO/6947XvuXfjsOcjW7YMGzcNs6OfmPunRTEtZBJwnPTCiZOGisCXJ8
         XdhA==
X-Gm-Message-State: APjAAAUZDUYR/HMTv/zwiS/z9kMSCjZx3gvDjmdmCvXBNY2jRhMdW2Dl
        ntfWwNTyCcotaVN6yofFskFC4DX8A+rFzBGz4kU=
X-Google-Smtp-Source: APXvYqyPomCJACRyz3stpw4pBg3zlMgYSPb/s0w3yREWfvX2EpQkEFCIbmm8yaxiBc/ukkBLh4ENDZmhdbzz3Tx78cQ=
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr14704749ioq.282.1559554528020;
 Mon, 03 Jun 2019 02:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <BUJFK0ZEKP5I.16DDFWUTXGJTE@homura> <CAP8UFD1W_tB34N-uAA85+QkHY6kmGWYYM47zceP3=5aTwxwvnQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1W_tB34N-uAA85+QkHY6kmGWYYM47zceP3=5aTwxwvnQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Jun 2019 16:35:01 +0700
Message-ID: <CACsJy8CUGfUwi15+ggOgRT4xotCkJVhGtCrjMa=4pdnDq25f4A@mail.gmail.com>
Subject: Re: [Proposal] git am --check
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 3, 2019 at 4:29 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sun, Jun 2, 2019 at 7:38 PM Drew DeVault <sir@cmpwn.com> wrote:
> >
> > This flag would behave similarly to git apply --check, or in other words
> > would exit with a nonzero status if the patch is not applicable without
> > actually applying the patch otherwise.
>
> `git am` uses the same code as `git apply` to apply patches, so there
> should be no difference between `git am --check` and `git apply
> --check`.

One difference (that still annoys me) is "git apply" must be run at
topdir. "git am" can be run anywhere and it will automatically find
topdir.

"git am" can also consume multiple patches, so it's some extra work if
we just use "git apply" directly, although I don't think that's a very
good argument for "am --check".
-- 
Duy
