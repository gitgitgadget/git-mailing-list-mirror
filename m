Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189441F597
	for <e@80x24.org>; Tue, 24 Jul 2018 19:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbeGXVEn (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 17:04:43 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34180 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388466AbeGXVEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 17:04:43 -0400
Received: by mail-yw0-f194.google.com with SMTP id j68-v6so2005221ywg.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wHe/b1YrBw0FFPE4PPB7G2x8gb6v7NvKsExFfxclXM4=;
        b=hiIeOH5Rm+joD3ItHdD1wDrWx53ujyJ/TlG3ve9Bl0dX0fa8Z8g26XNBXkIrTkmaY9
         xeAabeI0NBvv3lnOKOO3LTXuGXaa1K487yKIBaZaBxsdvpY77LrEl5s7R4mMVpZ9MJjE
         ACx3vIjd0ZmPybjh0PnIz5Xe1D/K332+sE8RIdAjV2wClUKeUi/1jot77vgHbbl9PoW0
         rTSHrtQ7I2IUDAoWQyQPnWbDml2XSFD2g4lm9GNFS4dvGNuvs9pfEVY887+0k8OOaNeW
         T5U1F8n1w27TfRsDtDjTMpemaZ8JJoSLfx7yD1PkfP5hAPDQbdpBmZvyrwMrH6GBiMmA
         vlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wHe/b1YrBw0FFPE4PPB7G2x8gb6v7NvKsExFfxclXM4=;
        b=QPssTXJEBtny/J4AJ8tCVi4TilmRzNB8OAT/Rq45907DPQqhFpinumAxq++Kq/jDop
         nINBhBmTS21K9PdPZ/mTlatcE+e5m7jrcCd5MGDKEE1L/g0jlpbVRblwqixak3dtCrv2
         OZfQBxq/hbQ6GtebgWhzBNgFQPYyFcqm58gwFO2Vra/7AfRfRA95kdXqMx+bQDxbcUlZ
         eT7pmB0vgRLI3FEKYL3x/aZt9rfhWXjUyuneRe4yVFAjNYG5gcG7isA/nkCx6JLmYMeK
         xdGuryhgxwstBGvLNWKRhdNEc59/NdsN/2lIn9uhsz/0WgodJBIXOEss+qSpWC8R4cVk
         CrlA==
X-Gm-Message-State: AOUpUlFFH8HI4Zq5J2lgk7lq90Wn736xi971DUIVwU23ExtwtwMVli2w
        mPeZTZyMjSATPZHaa+9cQrAXFQ==
X-Google-Smtp-Source: AAOMgpcqECfbOZllHQoF2HuZ4DMPMlHE1zQzPL3K6zFyEgpZW2Cj1xP3Tqv5WsxBBxjNu/K/Gnh4MA==
X-Received: by 2002:a81:2ec8:: with SMTP id u191-v6mr9651834ywu.430.1532462199743;
        Tue, 24 Jul 2018 12:56:39 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id i125-v6sm5500450ywd.92.2018.07.24.12.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 12:56:38 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 24 Jul 2018 14:56:37 -0500
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] config.c: fix msvc compile error
Message-ID: <20180724195637.GA97109@syl.attlocal.net>
References: <20180724153010.6693-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724153010.6693-1-git@jeffhostetler.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 03:30:10PM +0000, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> In commit fb0dc3bac135e9f6243bd6d293e8c9293c73b9cd code was added
> to builtin/config.c to define a new function and a forward declaration
> for an array of unknown size.  This causes a compile error under MSVC.

Thanks for spending time fixing that. fb0dc3bac1 (builtin/config.c:
support `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)
is from me, so I owe you an extra thanks for patching up mistakes :-).

As others have noted in this thread, another patch was sent into similar
effect, which has already been queued, and I agree that we should prefer
that, since it's further along.


Thanks,
Taylor
