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
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AFB1F609
	for <e@80x24.org>; Tue, 18 Jun 2019 22:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfFRW3W (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 18:29:22 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:52219 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRW3W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 18:29:22 -0400
Received: by mail-ua1-f73.google.com with SMTP id d5so2079165uaj.18
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3o25wvh/PpJ1qi4KgX5VAThlGYccF81AGjhziSPs5+I=;
        b=XOSdQGP+KYz+suDALLPyzpmgBYPntfsb/DlCWHEGX0nO0fnyUvGUe/0soQaRi2ubX8
         p3mCQzSkwJ9wXkY44r9e5GhylHl/PCzuMX57zH0LUtz/3Ad9sWF6P3O1NyPyWKkvWAqJ
         nnFqOtN5EdlR1E0DqrtrG+s3Kf7ZP0pktXupDWCoN/L51jMJH7kYsKI+aytSAvqiV3jL
         0LmSoPUeV2RxPZhcngi07mdUivLEClZ8WORdHpaMn7eL+PBGoTSzG9G2coreTZrefRr6
         PkAYP9lbBpg36FwTEbz3lKbTKfGqXygRqBM3ebYGeiD+WH7oN3xB0my3coREkQk8NqvG
         +ZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3o25wvh/PpJ1qi4KgX5VAThlGYccF81AGjhziSPs5+I=;
        b=ukMpuOG6u1QqXmU8uuYomUVuGbtGnkvZDBUvq2xu/mvM20cJtvefBuP8ee3BGRC5oC
         9IWgMUm+pWbec2G1SpB1xeowfZVfwU4GUExPUnZtIqJEFPJeb9bKuwkytOqussMNW0tK
         JhTszGsOT30RXWsiigz2pDEEYjXtbKyS05+504v85shu4QjWyb4Ij40kYLnLRxrmk9eC
         dJDTpB6YU1F02qDFwCbFSGtlV+OiEM8QUHSaFzmJI/5Tqv9+h402KqKnFlOe+Z97Jg7R
         RbPJeiKD9AhSRun1pDnzYx809ashoR8vyK8FSQCoFhvN4XaXkRfiwbvU900QgYgrhJqU
         3YlQ==
X-Gm-Message-State: APjAAAWN1wVYB12PhjRnFHAgdW1gQOEhupsG2aD1xAaHGz89ul5JYYJf
        mpg1QxmGm5CT8DVFjTmJfWXyMjTAo2rhW39iBxnT1fk7YPDG9A4X7hcBdngkOp6TWJw46vDMf+1
        841y+ZJWlB+XoqEOoUEA0x+4O1F1bXHYNGNFqhhlt9BKWk7G2HfzaIaiR4lQ=
X-Google-Smtp-Source: APXvYqzeFZhu0snvPyE6tkmnV8J/gXxtPbR20tRKNyqLVr2YNmacVD9/7ZelhNCNE3jws1R0EP0GVDXv/FiH
X-Received: by 2002:a1f:e382:: with SMTP id a124mr402814vkh.62.1560896961176;
 Tue, 18 Jun 2019 15:29:21 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:29:14 -0700
In-Reply-To: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
Message-Id: <cover.1560895672.git.matvore@google.com>
Mime-Version: 1.0
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 0/1] Sort detached heads line firstly
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

In the interest of simplifying the code and the job of translators, I've
decided to simply remove the ( from the translatable strings as suggested by
Junio in a response to v2 of this patchset.

I thought that a regression test would be a bit overkill for a fix of this
nature. Instead, I've added a cautionary comment to not add the ( back to the
translatable string.

Thank you,

Matthew DeVore (1):
  ref-filter: sort detached HEAD lines firstly

 ref-filter.c | 32 ++++++++++++++++----------------
 wt-status.c  |  4 ++--
 wt-status.h  |  3 +++
 3 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.21.0

