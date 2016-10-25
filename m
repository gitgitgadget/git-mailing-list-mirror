Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D962022A
	for <e@80x24.org>; Tue, 25 Oct 2016 09:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934155AbcJYJ6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 05:58:37 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33517 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933920AbcJYJ6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 05:58:36 -0400
Received: by mail-yw0-f176.google.com with SMTP id t192so34783525ywf.0
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t42gjzCZU2q5xSgehtJhBpV9ES9WhOdTqCtRwqgtYh0=;
        b=H3JzPNvsvF+nhB02yQcY4vz1nHHU49tC/ycBeK+aqvMUmsPpR6JJr38KZBkG33UKC2
         DekmpRAlqmSo2R8skuVr0U0QvRfy0dSq8KPvIEZCMCvlLT5KSRXSdhdgBBStCxPtFuCb
         7sghMwxHJABEku2nqZETFid2egwQlLTaW7MZ1R/cP1w3tJCFgXXBLcIg2iKpkBhV4qwd
         TwmEPge2bO7BAgHB9d3tRzMd4wv6pEpPTJLup4tKa7rGjDs3OPYoLemRPAN/RdhCVxHJ
         c2wpS4WikbDCaTzWqGobrY43R1KpdwaIv5JwI2pvjc+ljGMpnT1yoUxufmvKsUidEX6z
         ygHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t42gjzCZU2q5xSgehtJhBpV9ES9WhOdTqCtRwqgtYh0=;
        b=XUZVCYpiQp5PhEAbOTSiKzGfeIJbgmsdfAMN6eJiasD9/0d4AuLi1vNA17LiMAISfK
         UDWxrOaQR8/bFX6BHKrONvKmc3dB19vlrJfLmPm4dHtPJj5pk29a7TNEDBwp8lmOfAcC
         hsUEyYkXoc/0Yqb+qwSFXc0pZxNBlDwmIItVdXNH8EqV05DUwenIfFD7XGob9KitGWao
         Woylu0Qp6uR13+BDa78cI7A6rwdg0Uj+6VyYujCme1AEy1fORgxNOCvafaS0HMAsxZN2
         lYKOVRkz1vGFYacOGq7LlgFguxAOedSYF12D1+Lx+iy8dIXLqYG7h2X98Fl9ALjGOR+j
         ox6w==
X-Gm-Message-State: ABUngvclXMb8pA6dnO2QAS2nq1iEZf1u02/HXAviDjRMN0AZoMHrdKBZvblhQk2Auyb8ZSOmvlY5jbul2g7VUA==
X-Received: by 10.36.67.8 with SMTP id s8mr983547itb.50.1477389515665; Tue, 25
 Oct 2016 02:58:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 02:58:05 -0700 (PDT)
In-Reply-To: <20161023092648.12086-4-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org> <20161023092648.12086-4-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 16:58:05 +0700
Message-ID: <CACsJy8DPt3EJoSTVEZFbH6xXbh78MbLZ4h+50K4eoFxPYSaN=Q@mail.gmail.com>
Subject: Re: [PATCH v1 03/19] split-index: add {add,remove}_split_index() functions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> +void remove_split_index(struct index_state *istate)
> +{
> +       if (istate->split_index) {
> +               /*
> +                * can't discard_split_index(&the_index); because that
> +                * will destroy split_index->base->cache[], which may
> +                * be shared with the_index.cache[]. So yeah we're
> +                * leaking a bit here.

In the context of update-index, this is a one-time thing and leaking
is tolerable. But because it becomes a library function now, this leak
can become more serious, I think.

The only other (indirect) caller is read_index_from() so probably not
bad most of the time (we read at the beginning of a command only).
sequencer.c may discard and re-read the index many times though,
leaking could be visible there.

> +                */
> +               istate->split_index = NULL;
> +               istate->cache_changed |= SOMETHING_CHANGED;
> +       }
> +}
-- 
Duy
