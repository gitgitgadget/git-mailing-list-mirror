Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6802C1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 11:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeLSLa2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 06:30:28 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:36654 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeLSLa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 06:30:27 -0500
Received: by mail-io1-f42.google.com with SMTP id m19so15372403ioh.3
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 03:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pBDpfPBETNSbIfvSCmPW37jTRTTea0RpBNrmWDrAKo=;
        b=WOIf5mqDwuAQc13ZMHvVxOG5zNBv4Pw2J+vyJ5ltAjYiXSrZRd0iJpIPd5T3foXZUY
         oAcNfdbCZsgmgCzEEPl5TWi6usmObkvvuEK2zpQry7CcUTufRgGOfKxYT2V0xYuSLnnw
         21qNs2/yW2IsLE243eyZ9UXAPoV3m08nHdTRLh4OSvC8ac6VxK5etiNtlyNywg/oBnnt
         8L2vyclHL84zUyT771LEK+qW4YM8lBXNJOa4HIgU9AOgNPem/K4QvEAu7SHLarDTXJSm
         Rzp8XVkpRF4VZrS3Ugopl/o4isIfMQTxEmLsk42jbLBi5FymKVqrYpw5yOBOXaigPeP3
         +pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pBDpfPBETNSbIfvSCmPW37jTRTTea0RpBNrmWDrAKo=;
        b=UbOV7MWLuoub7wzLfWZ/ODAcOV9uojsgmILc/SIwinX09aHFpYBQGwUOlOuiqFoEGY
         I0G6wN6MHLBKPFzP0z66Gvbi0G5Jwg+uiXp22K17jx8ByosBW6cSKIieXunM+veEgEWK
         vyUVtKCKXkylkm/PSvw/PF1sHkvKYZCfVphu7/T82ZX9N3n65H1Kmn28hxfkKvSGg8Z7
         Nfbe8gzxn9GNPRhH6Vo7KRfPcp1SdTudsPltVqAvNwY78pTtxZlki2043NSiN7tKH3/E
         al+ZXzvpUP8CwDwKVEyKrRTo23eeX9oGGaOWShp28QjxTxzsZpf09pK7soqGoN/AQk8K
         o9uQ==
X-Gm-Message-State: AJcUukf/WcVdiTqstAb4jtUB+KCKZEKZcngDfFCSbjoGiYC92TvWEm2D
        0xwpGgqPwho5yOTNhyhirhDYEjhRs8tAlAIYbJ0=
X-Google-Smtp-Source: ALg8bN6AEYnv15039Z8JCAf+0fvEcS2WeuBivxwQ5Cc93lUTv/bf3kjWBh5UMA6Ig5TUCsz06Xhc8AssjTUhInVBoxg=
X-Received: by 2002:a6b:6f05:: with SMTP id k5mr84152ioc.282.1545219026980;
 Wed, 19 Dec 2018 03:30:26 -0800 (PST)
MIME-Version: 1.0
References: <robbat2-20181218T203023-954479960Z@orbis-terrarum.net>
In-Reply-To: <robbat2-20181218T203023-954479960Z@orbis-terrarum.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Dec 2018 12:30:00 +0100
Message-ID: <CACsJy8Aj1yVADiPf_sgwwyNRfGWV+5x7ysG-OXDtXu9UJMt9yw@mail.gmail.com>
Subject: Re: Skipping history and save bandwidth: how can I jump between
 shallow clones, without sending unused blobs
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 12:15 AM Robin H. Johnson <robbat2@gentoo.org> wrote:
>
> I think this is encapsulated in the v2/promisor work, but wanted to
> check how close that was to fruition, and that it would indeed be
> possible.
>
> This would enable replacement of any workflow that presently uses rsync
> to update.
>
> If I have a clone (ideally shallow already) at A, I'd like to update it
> to the latest remote tip at F, ALSO at depth 1, without fetching the
> intermediate history (B..E), or blobs unique to the intermediate history
> [and no longer referenced from any tree at F].
>
> I critically want to ensure:
> - that the remote does NOT send any blobs that I already have.
> - that the remote does NOT send any blobs that are not reachable from
>   the new tip (e.g. blobs that existed between the old state and the new
>   state, but aren't needed anymore).

This is what we do now (I've created a small repo to test it again).
Are you seeing that we transfer more than needed?

>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136



-- 
Duy
