Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7061F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeHMVT4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:19:56 -0400
Received: from mail-yw1-f41.google.com ([209.85.161.41]:40614 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbeHMVTz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:19:55 -0400
Received: by mail-yw1-f41.google.com with SMTP id z143-v6so14299006ywa.7
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOJCetu159cVIKUe5f7J/A0z/NO7yeau26jGYRtvHLQ=;
        b=h6G2WmnTutCy/r+1EiTBZnt4FaHqnLzr1q4TwajwA26I+8Y+EIg+kB3fkRvzFbGF8p
         BYJ/oEzYWt2R1i1C8T+JodModGhlx8mjPQz7H1kEV0SaeautW0Am4Uc93ugW7ag9CHqE
         +bWluqfd0RS3kBT1sPVYGlvOLKE8oRSQtMthREArvqr27VBL7IbgpVmyJerS3F/yXu/Z
         GQKxXgqBz9g84/F/MilqbYY/JadgYnLwcESIFGI82v6JBf7rOEDMN6aPgQXGkrzaqdms
         dqUGZoVBdXF64K41DuRnT0zt/kIQVwBdTC1YWamlsA+TapaXf/W5GelKpEyzMBfGA/Gl
         Nicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOJCetu159cVIKUe5f7J/A0z/NO7yeau26jGYRtvHLQ=;
        b=e+VwCfT88YGR88Fqyw+Dm2JCF71DHGwSYkdGSEIpAU8ah+QZwB3DOUEtKzhyCTTqss
         Is46bUV0E7lWI47uNghqpD4x5WUSuKo5bCE5HIoshBnaw9vZvgVmzp2GMJw7NY2dqoH9
         zedodrKrDHk+ttpzErunVqZjaTQ/4qOZIKL2Inca3N0nRG7SMI8vU6baXk3zkGiEwYPw
         I73fnI7dW19exkX0FkWAy4I6CCefwUIQF0VUSdg7BXW6fXuG9Kv7thMciboej3fEU3ae
         +AwnGQ0kXrg5oFwm5so2H93/nEetlsQ/s3Iby9i76blE0Z8o6JpXxTegWp7eGTTix8v8
         2LjA==
X-Gm-Message-State: AOUpUlENG1sTj8m8FFkpP1WAgwkYRBQRKrbA7myrEIeszlGqAdeGErMo
        nlam15C0sXhwvQj0Nib0NqXQaN7qJzkXPgmBvj0ZtA==
X-Google-Smtp-Source: AA+uWPwop5NX3IakPBQlX84ltEKv1+kUOv2TXFUIf7E8ncYqR83C0Bwa6oQMY9gIKKBMxGIBfbZMst8kymXXPCSZYg8=
X-Received: by 2002:a25:874d:: with SMTP id e13-v6mr6955294ybn.515.1534185391718;
 Mon, 13 Aug 2018 11:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-5-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131353280.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808131353280.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 11:36:20 -0700
Message-ID: <CAGZ79kYVw3AXLyB1fx07WojN3dLuxJLDrbWwC_7M=9aoB9YuCg@mail.gmail.com>
Subject: Re: [PATCH 4/4] range-diff: indent special lines as context
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > The later lines that indicate a change to the Makefile will be treated as
> > context both in the outer and inner diff, such that those lines stay
> > regular color.
>
> While I am a fan of having those lines colored correctly, I have to admit
> that I am not exactly enthusiastic about that extra indentation...
>
> Otherwise, this looks good to me.

Can you explain what makes you less enthused about the indentation?

Advantage:
* allows easy coloring (easy implementation)
Disadvantage:
* formats change, but the range diff is still in its early design phase,
  so we're not breaking things, yet?
  (Do we ever plan on sending range-diff patches that can be applied to
   rewrite history? I am very uncertain on such a feature request.
   It sounds cool, though)
