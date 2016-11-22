Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2943F1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 13:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755507AbcKVNUk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 08:20:40 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33688 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755480AbcKVNUj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 08:20:39 -0500
Received: by mail-yw0-f173.google.com with SMTP id r204so14048505ywb.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vZjlh0b2NY0AX9VkEDu+W9IVyjRz5YYznwzzIjbjahM=;
        b=JI45vvxvpgS/nWN98SYOkPxCBQe7444FVwuypyHQUe9bRv3nPwIvNV39AJ1TqullDm
         UODdrDHLDqJz1AB4YRCpyMCZDnNqn4IYtNloTG95vagnOSbTOddgENTia+9FKDuhvc3p
         Kw2aKuQTr7kCuDLcbgCfTmPaG5ak9mXpFSzXvbnPO4bjm50dTJRBkwZBI76ipLubFE3n
         sAFdHPCcKKJ6G6JnNUHiEKZAM1yOI33j4bisrY1VHL3+f6LUuXH9fVXLJEcrwQZSdv/E
         WUbu1X5XmhKlyJ3PdHFwnvzBM+jwxM47Eajr42HbmUpH8oeRSpEDKNuCyVGbmO5gup4R
         XfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vZjlh0b2NY0AX9VkEDu+W9IVyjRz5YYznwzzIjbjahM=;
        b=W/7zOMpQXHeAwgh1WeKZXzk91Wguz2ndzto8obXWJCUwXcaPx1ncIrAdWql0E7PW2r
         0gq8YhWF9k/gE4v6Q59xYJEnf++uyNpAA3eQdla2BPyj9zybbSqPVf//FfW6Pozhd0wx
         VW/lOQ8QWmWLTLNWgZMS3bajwdpcuVyB9s95zI048wVO7ag+23Cnf+sWCS7rnft7mkgJ
         8u29/SZ4vmcRZGDZOQ+j2La4aBH9Z8aK43ms7FuQ5MuShoADrPd2ShuP6bDm4APs8S4K
         A8BCHo7TMhXucG0IyU64glRxg/A/nN7hZqt6njdcubvnE1sb3Mno7ErE+yZPENUP20jy
         DNfg==
X-Gm-Message-State: AKaTC00dnc5MrUlofWIH0SKkD4mb/Kt+t+8EGCz9120PlH9O66Zy7fE59XTW67D3ufgADPItJpAtq0/iXtNaDQ==
X-Received: by 10.13.240.7 with SMTP id z7mr19602970ywe.37.1479820838267; Tue,
 22 Nov 2016 05:20:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Tue, 22 Nov 2016 05:20:07 -0800 (PST)
In-Reply-To: <CAP8UFD2VFQs2X14omWEy-iJzEeTEeEOa+fxMEq3HTQK3rFyuCg@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-13-chriscool@tuxfamily.org> <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2H6rZNQqg1VGNkes65KAk-4P160rjQSjFY3NjgZydZmA@mail.gmail.com>
 <xmqqoa1scyuy.fsf@gitster.mtv.corp.google.com> <CAP8UFD1YL+RgdqbV0V1OnC=sJHJFc_an02Q9JeDNapW+u1CZcA@mail.gmail.com>
 <CACsJy8BZNfESmFv=V89Cq-b+aMJWLH=qhXHNE8inZZRjvXB33Q@mail.gmail.com>
 <CAP8UFD1mun7wz2WqV8GCj6MODVjP2mPEBRGbJTf_ypiGCgtb9Q@mail.gmail.com>
 <CACsJy8BazeR=4tz3q2f35x=fCfp-Ld9LJz0mQh_CZoR_iXKEEQ@mail.gmail.com> <CAP8UFD2VFQs2X14omWEy-iJzEeTEeEOa+fxMEq3HTQK3rFyuCg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Nov 2016 20:20:07 +0700
Message-ID: <CACsJy8AV7mYDsod=BedAsy9W=tNpZg2kpzQ5HBTAmE-WcdroDA@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 8:13 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> So if we now mix things up just to avoid one more configuration
> option, we could very well make things harder to develop, to
> configure, to parse and to understand later, so it is not a trade off
> worth making.

OK since we're still in the early phase of determining how to
re-split, I guess going with elaborate, precise configuration is
better, even if it's more config options. Once we know better, maybe
we can decide a good default cover-all "auto" then (or maybe not
because we find out no shoe fits all).
-- 
Duy
