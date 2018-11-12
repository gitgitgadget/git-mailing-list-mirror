Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2152E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeKLXTw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:19:52 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37185 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeKLXTv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:19:51 -0500
Received: by mail-wr1-f45.google.com with SMTP id o15-v6so9330526wrv.4
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2DxZY+ROMl7iM2JGzYcRGSyE4TDD5LHN2rchzesFR0=;
        b=cdxYdWUL13yprN+W6WRuWaug3jj95QITnziGdjQohO/pphkcvnrRdLMDA8DBDA/Hhe
         j1EcXTgc5GyuitZBNDGILhAhMR9SAzxSjaaGk+s6Ep9SdjtpiadZB6mhkX7C5Gz8NOOk
         loRIjrFr5Pu/D4+yt7TinplYhyV6G12PbRP+oSBVzHu8Z7HHGvVqRIC7FpQyZn3oqDSE
         WD3LnmB+/nX5G78PlBCcBIbZFW2hpDsSalYjeD1QC15iEVRlfTVQ1EhGx8iFiqkJCdv2
         SyY5tS1m/hUuN2+4xTrMfENLTlRTyTSYImYHScdoDgvyicV059IHGzpkLAL9JKE/dIeU
         Fq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2DxZY+ROMl7iM2JGzYcRGSyE4TDD5LHN2rchzesFR0=;
        b=NmSunWzjEkHcNj7OHihFXZNGfAzPYTMX90oenc6GwN6AnvC25YmbnpARCEc8E546Ew
         1ulBrsL6JrIk0+IkeFtecFS+7eKoNquZ5HM78+btuosPE2BopqDZBVwe1Uuf4jYDzDUF
         xJbkNeRfOQ+S51ir1HVx+HQVt56zMZCllByRH7MlVveP4EEFXP3O32KPn7zKYKZlJvlL
         k2wh3Vb5O+wfEUZTlLJZ7App7UTsk09YeksdWUJAcVTCZw1mM87lqyQXstnnjh4TpF1B
         dSUAcOgd4XgQ5qPMhXZ7Oj7tzQqyD4q31XeRVCYb/9UI3v7YZ8T3XnfLjztj796aJKT2
         pVwQ==
X-Gm-Message-State: AGRZ1gLmP8bGGuKEqCptd/gPwF2CK2j6Oyf9unwEQmlGe1tIibDAbVhz
        C7Rval0QTf0yhYODi6ctan7Jv0ZnS4s=
X-Google-Smtp-Source: AJdET5fRMa4C7mZWBUeQIJqt4wY9S6NlWl/g5rJcm0LHBlFTAh+J5bkEioZA4DljrLpZ8RpYOkGtQQ==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13-v6mr1016994wru.179.1542029193679;
        Mon, 12 Nov 2018 05:26:33 -0800 (PST)
Received: from localhost.localdomain (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id 74-v6sm12405818wmn.42.2018.11.12.05.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:26:33 -0800 (PST)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Subject: [PATCH 0/2] fix some exclude patterns being ignored
Date:   Mon, 12 Nov 2018 13:25:42 +0000
Message-Id: <20181112132545.31092-1-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to set up some aliases for my own use, I found out that
--exclude with --branches behave differently depending if the latter
uses globs.

I tried to fix it making my 2nd contribution. :)

Cheers,

Rafael Ascensão (2):
  refs: show --exclude failure with --branches/tags/remotes=glob
  refs: fix some exclude patterns being ignored

 refs.c                   |  4 +++
 t/t6018-rev-list-glob.sh | 60 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.19.1

