Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D1A1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfFYJil (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:38:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54394 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbfFYJil (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:38:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so2079011wme.4
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JT0XZUmwTXRzRCxshc6wtiC+hJML5xYLOOdlRGFCiiY=;
        b=YuKVX9MBFhdnHkx7Cj8Z23p64IH5Tt+7AjwSpfx2RoepEnIf0Y1RzaleUQE1Y+dFx6
         JMjW2sHZ5XQ2vW+yIm03yzjVM8CLCSQ8pw1JO0KSgeplj1kihJZ8IY1UhSoQzKlU0KW4
         7zlVeCSdqdkqz96APXvrn9hQX5t5CQDcFsRMmEBH/HHq6Fi8BFbBH4fekss4OmDlmkoe
         xpDqdto3Uydkn+ifANSR9ESMq18C3mn4l+J9NWzG9yABDZZmXRLqAILdjkCl5uuneAYg
         dEJzQbywSWPwC3JWg0qW+p+OY9EHLjQvfzpLk6vA67zJ549SlMie9MjId/t/XRxVR5hB
         iQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JT0XZUmwTXRzRCxshc6wtiC+hJML5xYLOOdlRGFCiiY=;
        b=XWs+4QIU1iEsk2+ktLDa04g2ivmDxIV2GrCX1Rvmag7GJ1VUQZkoG8yey5Wnt5WKtm
         Y/xdEaStjnsWQAAZZuCDU8/JLq1L6nNgXMVzoh81nKa/cuQPZ7VukQRwVawAOJlx+nWv
         ULe4kDXM2woJE7hmRqRVzBwsNtxZ2Kz2mBqISxiS5MYGmEgReduZKtdDByhJBk3FC3FC
         MdVgB9vY2StaB2K4DM+Rsz0mv8UxCvL2Ae/R7bN6ZBq8/uuv/Z4K7zCwC9HgrV4WXXol
         4MIrdeiXNc3NN0Be4wkXHCcow7tY6S6QrWVk9fJ3ouTYcSMq7aFpdADwOlPq84lehKg/
         uN8g==
X-Gm-Message-State: APjAAAX4cA6SA7Go4dENtuxi6kLbg4yyMzIrSZlXtOCxDMTSGS9XwXnC
        pKidHmrkIo8ZcgswB1M19w0=
X-Google-Smtp-Source: APXvYqxJ5crAkbHbv65bV/qzCVPr9OIUo/dMq3C5nBHN71kHxPsCcrAnQRiL0t5WR/d/pgZlMX5YBA==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr1879068wmf.139.1561455519263;
        Tue, 25 Jun 2019 02:38:39 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id 18sm1445576wmg.43.2019.06.25.02.38.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:38:38 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:38:37 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index
 in json
Message-ID: <20190625093837.GC21407@hank.intra.tgummerer.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet>
 <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/25, Duy Nguyen wrote:
> On Tue, Jun 25, 2019 at 1:00 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > especially when we offer this as a better way
> > for 3rd-party applications to interact with Git (which I think will be the
> > use case for this feature that will be _far_ more common than using it for
> > debugging).
> 
> We may have conflicting goals. For me, first priority is the debug
> tool for Git developers. 3rd-party support is a stretch. I could move
> all this back to test-tool, then you can provide a 3rd-party API if
> you want. Or I'll withdraw this series and go back to my original
> plan.

FWIW, I am very much in favor of this series, and would have found
something like this very useful many times in the past when I was
digging into the index code.  So I'd be more than happy to just have
this as debug tool, rather than as 3rd-party API.

I'd also be fine with this living in test-tool, as long as it's
somewhere in git.git where it's easily usable, I'd find it helpful.

Thanks for working on this!
