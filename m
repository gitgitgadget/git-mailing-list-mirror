Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C102C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 10:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BF320731
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 10:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhA0KfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 05:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S314148AbhAZW7q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 17:59:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703AFC061574
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 14:59:06 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id g3so3550ejb.6
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jUPuVeKv/3Wt9uj4/JlayObiB2JO2Epc3aeW4CX+IPI=;
        b=thHJKPrk8YfAJ8SD0WvZAeCnPgoekeKeYNibTBtkIASv/lZyqy0uMdOzzKQX/dWyNE
         j6BPhxoth/foACPnOtGO0VrRqMt2pGIYFFHrw7md8ImPXPPTKv8ND0MLsT1XDI0mBSmt
         wvuOG4RqsljC8SeQ40Pai2JMyjROsmhdHqCiraaUvua19a8B9C2PwZcW6ISWUeL3sE3K
         UcIx9ZHf6QiwZD3K0qfMsb/JZyFzDMkcnmqKYz0sPXulkHPcX1UfQo6WujyMF80wRrw7
         zy93PuTdxoWLCFeWwbEgkOO6+XAHNwg/MR8/t/wYkw3foVwEz1dd7Lz+GLlsS+b+PTZC
         YYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jUPuVeKv/3Wt9uj4/JlayObiB2JO2Epc3aeW4CX+IPI=;
        b=jUrJYXcK5JWDVUoY3fQ9t82x33LW3aP+p7bDQ8XAfZsPLosOPlxc/Ybo3YDOfIsoVG
         r6Z0rjxS3DEAdvLew1BZ2mi7kSGSfBKyRK7J14yUqbhXhfIpc3B/YPdqXJ9X8j4Vzey3
         GvcJl9Aen7ov2hJP5A/zR9pfBEG4GS6zzngqb1pT+dd90vGuOEW7ocashzSxNUZ7znV6
         R2V4MkjMZVyVgP2ay8knJNvrz5o6cdGwQvsHITDX9rehwmAr+W7M8ABLEV4z2Oi+33gZ
         oYukWhbKhTw1zFP0mygFWCTMnNltNo3ofQ+z2ewfd3hp7mhm57fxubt+Q6MCFI1iqWZB
         SdMA==
X-Gm-Message-State: AOAM5330gZiinYyii8zYOC0U7LV08WMJ16L0AnjQnLBlNlinOq6cGetU
        Pstk7M28fMCgvn3uRJUbsVTeIQegVDm+3OKDMsEsF35aF+pDCA==
X-Google-Smtp-Source: ABdhPJy3VVDUY39Psh6O0C2DT5svMtlPriGZ6q7ParDUO9XqcSQkl8oYsJOGfQOcKmSK1VkYicPwv32an6DJR0RUy8o=
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr4780040ejd.160.1611701945001;
 Tue, 26 Jan 2021 14:59:05 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Jan 2021 23:58:54 +0100
Message-ID: <CAP8UFD2H+MmR6MHgmHFR5o-6BOti-QhHHtX5Gq90T_bbvFSKbQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 71
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-71.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/475

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Thursday
January 28th.

Thanks,
Christian.
