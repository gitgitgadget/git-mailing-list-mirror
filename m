Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F9F1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 18:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbfFKS2d (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 14:28:33 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:36364 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389490AbfFKS2d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 14:28:33 -0400
Received: by mail-oi1-f201.google.com with SMTP id l5so3939116oih.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XySu9+jUoRBp0BB5oBr0YeybWXuhMQ/ZA0Zr/f5hxOA=;
        b=e2UCjPamtRivM+p5V/JdpFCXQGezjxmoT8kUnVXtgz2BJQeEtg7sWIQ/ZKA4poX832
         wzz2wkiBSIcB4fM4beBMAX4v/fSuiCivNhNTpkKfb4R+wV++LHknS6j3fVzN3xuPwjTw
         PibLcRnwru71gmxyAGjzut88sWsrwFSmijrpFe5DDeZ/cHqkSUZ94PklRlaQvWmPPMxB
         xs2DrBSv809z/8I3/9rSKJswdTRD1Bk/YRtey/1SMtQStHpYTLEnRU85rYeb276FKouU
         09Y/7Bzlf+PEa58S7Jp5mP9lYo0GCYctgIFcLeKDJs6Geo6PTk+ZhHX9SATHsTDuPHTL
         5H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XySu9+jUoRBp0BB5oBr0YeybWXuhMQ/ZA0Zr/f5hxOA=;
        b=p+NYFI0ToD/1s+ETuIpxEb3hlAjfvRsK9CS6B/XZu+nxu2hRpyTr9nciNext8FLJfH
         aQOuow66AijZ98rFDEhYMoRzmaFIbvwes1azutXKvnYELqgBWqKSWgeSK+kn8m3pL/EN
         JZEvEfileSGPL5OA8zTjVWBrERJTRsxTFqmugDvgtBXH/Q7u7eWxLajUfLK5roq074BV
         8cmqRMGZMbL1AOjEcu/kt1c1j4dTZljnMGHqhUXrxJ+vJ0JxzdOTcW0xXhtt8wCDsod3
         I2LF3JTRS9m38y08yu099IJ7g61B3AfNB7Wk9hMnnli/QclAWZZDFJ3FY07NHmMIFIA8
         heHw==
X-Gm-Message-State: APjAAAVuQkobO+zln+dTnZiuwBuIVoc1i+9BML0yTg4Wm1jz+LnAAD7F
        gwVddYGewPzTp2I41pJ97v17ffpSiW9Xv/kW0mMIsv/RkeNAJ2+4Tfy8gDixL7pjxGENNarqXBx
        XkKZalcOG3Be2omlh7JpI9YKMZRJty1Cyuc7ForvgfLWnN35YV2k+eFzyQ1s=
X-Google-Smtp-Source: APXvYqzvnjAH0GvHofYWr0La7h9HPPDtIVriRRZM37ZKnYM6I3BhIS472W+lSRfoLgy99nwjuUbkTubSMSDe
X-Received: by 2002:aca:3c0a:: with SMTP id j10mr16187015oia.44.1560277712165;
 Tue, 11 Jun 2019 11:28:32 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:28:17 -0700
In-Reply-To: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
Message-Id: <cover.1560277373.git.matvore@google.com>
Mime-Version: 1.0
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 0/1] Sort detached HEAD lines firstly
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, avarab@gmail.com,
        git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version improves upon the previous:

 - fixes a bug where reverse-sorting didn't work with (HEAD detached) lines, and
   adds a test
 - makes implementation code a little DRYer
 - uses test_when_finished where applicable
 - makes zh_CN locale detection look more like the is_IS locale detection

Thanks,

Matthew DeVore (1):
  ref-filter: sort detached HEAD lines firstly

 ref-filter.c           | 20 ++++++++++++++++----
 t/lib-gettext.sh       | 22 +++++++++++++++++++---
 t/t3207-branch-intl.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100755 t/t3207-branch-intl.sh

-- 
2.21.0

