Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AD7C209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 19:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdIKTxM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 15:53:12 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33730 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdIKTxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 15:53:09 -0400
Received: by mail-wr0-f176.google.com with SMTP id a43so16778466wrc.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vve4w4MV6Cu/aqizGWCzPuCmEaYxxFXHn1jAxEEjJuY=;
        b=u8NhajdrsrzhDdywTGKIX2dZ2pdKBVUqGyQc6oudn+CqeEj3onZ3N8XIyAumQoT0Le
         mucS6fdWWHH0z4vOW6yVbFvXI2y/90nBsxoMrXlToAnjEnfebf0bSp8qm5pgYYpo/SHc
         ka1CJ4PP7cr2zXAw1Y2RUcITMVmI/VuRk9vgBM1VupzjxfgPlx4tAkf9uTed7o+T3/3l
         6P04Cb+726D3M7iktLA278Vqml2L8/n6gaiFrOkHe9rIABNqzkFY7IKRtg8CE6WP5SjH
         PsbulrU4DlNJHD3oJgQhnYMCSPl5WvRvqpvt9VILl/01nR+EWr+Tzmjo73gpjsRCoiLj
         4OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vve4w4MV6Cu/aqizGWCzPuCmEaYxxFXHn1jAxEEjJuY=;
        b=uZ+vqT6my9sZSk3pvHFxB6VNqSD8E9my3Ol35pnUx5aSC2Q8WITOgiVKpif0nHXJNk
         IyRKb3mWGZlhGTV0640v5K/TcT0/dev5w7RNM+bPxpgkvNZPYhYtcrEpq4nv9BgNw98Y
         B7REO1YXmFUuBOB5y0csk7EDIXOn1lmFR2dr5131LUDnpTJWjkO91HE+3v4RbgYWzQpQ
         ObAIhy2N13yUhmRPDMC1EnIkMonVqz1ZbMMR0lZFFE+amjTySO2/6BW3xbcYh220qw7v
         6zzh9fy3nj3q6SxuA4SBTkjkDg6fBNdr0fAo2pV2Tks+SqQ1pmxdMuEnAHOiOEfuPrGG
         h+ow==
X-Gm-Message-State: AHPjjUjuOUwLoKMpP2XEq4tBbLNAq95Thox2H81F13wY1ADyWiQLCo/O
        9iOpvBqmzp+0Ww==
X-Google-Smtp-Source: ADKCNb5DcwCCJe2WIJG2KNeDMYLS3L/S2O6ZVWMGDKpCga9l4oG2FxbBxYhRmuYbBOenXifqqXIGnw==
X-Received: by 10.223.175.217 with SMTP id y25mr10709700wrd.255.1505159588547;
        Mon, 11 Sep 2017 12:53:08 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id c56sm9134273wrc.1.2017.09.11.12.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Sep 2017 12:53:07 -0700 (PDT)
Date:   Mon, 11 Sep 2017 20:53:40 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2017, #02; Mon, 11)
Message-ID: <20170911195340.GB26081@hank>
References: <xmqqpoay3tgz.fsf@gitster.mtv.corp.google.com>
 <SN1PR21MB0014749CFE6DE449771AF724B7680@SN1PR21MB0014.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN1PR21MB0014749CFE6DE449771AF724B7680@SN1PR21MB0014.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11, Kevin Willford wrote:
> > 
> > * kw/write-index-reduce-alloc (2017-09-08) 2 commits
> >  - read-cache: fix index corruption with index v4
> >  - Add t/helper/test-write-cache to .gitignore
> > 
> >  Expecting a reroll.
> >  cf. <CALgYhfNYgmCJqptNQLKaQpCs9mAgqZHUrDS3BVEqCv_f+WX-
> > qg@mail.gmail.com>
> > 
> I didn't submit these patches so what would you like
> me to do?
> 
> The reroll for read-cache fix was submitted here
> https://public-inbox.org/git/20170907192412.8085-1-t.gummerer@gmail.com/

I noticed that it has already been picked up as well, as
0b90b881e0c1de110c724fe63df6d2c3c9680d6a.  Maybe it's just the What's
cooking that needs to be updated, or is there something else missing?

> - Kevin
> 
