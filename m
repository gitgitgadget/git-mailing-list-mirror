Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2EA1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 15:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031138AbeBNO7x (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 09:59:53 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:37801 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030737AbeBNO7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 09:59:49 -0500
Received: by mail-io0-f179.google.com with SMTP id t126so2169145iof.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 06:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vcZS4+lI3EiN69D9Y4mO1HtNAxUGLdnlfTUV4cLNXGM=;
        b=NtHngZoZVHATl6FHKjX2Gzdb1cYdYDbNlO73vWFZ00qwUyATIaWSQGeGedsjX521K5
         2W/mVxlZbzo/Z0hNVz9uDW6x4NVXrDf+x3xhHK1uNSpQ6PB7QrOKA85ibMiFPtLawnoM
         +pJzBh6IjaSTB/TD22cWtYGruo4kZZ9TozU69J578Ymn3F4MR95EOxUsBjKRN0ACBbv/
         zrd/azvMfaW6B+I3lakwxBn1V1X4YZDujSjrfc48t5++Sh+6N8v+McCvUafmdZh7NacC
         mnNJ16DbKwmcojNbCXc5B4vinSZCWai017KL+7kS2DcDcLl4diQaupeNv9eEMJu8kfNy
         C3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vcZS4+lI3EiN69D9Y4mO1HtNAxUGLdnlfTUV4cLNXGM=;
        b=YT+fM+hHaiuNuOYU66Ncjf+2xxnufpNmKS8NK+6Wpq+nStaUz0fXh3KA086xJ6g9RV
         hSH1yzjXXktaz666Z55c5IdUl9TnoxgUR2BYDikF5OmIhHuZaOvEI0A4biLeCxzWdf4Q
         GXYhgUGjlwH1FTmmpHBYmB6hBH2IPgSc0C9ZIA+RyrEvtuJsH1mAw06dvz0Pt04+7wij
         NMn2sZgJdxTefSAjWWhJ4iiFvpIab0gxloXHli10miuEdsPX35n0zD66KuRAtnj/iqFy
         7OSDL2kUaeRIfqhLytmFxyAudimxDaaXxuLvgff1uT+LEOKXoe3i0ononcA1kuixwscC
         OhWw==
X-Gm-Message-State: APf1xPCBRJWuEdXYEIctxwg/nJVwvOUCFhLe9aFv5UqsmmNLEdKJv7RA
        rgvxg+R7muiZEn8EEwESVT2IdN8/sOlPhn8ygis=
X-Google-Smtp-Source: AH8x224fRkgtx0UOkote0QmiSikHC5KiFMo1QmmZAY1/v7Tb+ot6mVcm9kxDGljFdxzUYko2HUbN5GDa40TicQBxGCM=
X-Received: by 10.107.184.10 with SMTP id i10mr5925848iof.283.1518620389095;
 Wed, 14 Feb 2018 06:59:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.47.11 with HTTP; Wed, 14 Feb 2018 06:59:28 -0800 (PST)
In-Reply-To: <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr> <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 14 Feb 2018 15:59:28 +0100
Message-ID: <CACBZZX7xC37W5+MLtYSrBaPawh+QfOSqci_rFOp_ukVi4fp6Gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] send-email: add and use a local copy of Mail::Address
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Thomas Adam <thomas@xteddy.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 7:36 PM, Matthieu Moy <git@matthieu-moy.fr> wrote:

>  create mode 100644 perl/Git/FromCPAN/Mail/Address.pm
>  create mode 100755 perl/Git/Mail/Address.pm

I didn't notice this in my initial review, but just now when it's
landed in master and it's shiny-green in my terminal, this file should
be 644, not 755.
