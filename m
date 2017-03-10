Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE2420311
	for <e@80x24.org>; Fri, 10 Mar 2017 18:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933741AbdCJS7s (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:59:48 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35793 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbdCJS7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:59:15 -0500
Received: by mail-pf0-f179.google.com with SMTP id j5so45016754pfb.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 10:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DOobrFpiuApCjV8LgM6qxJJen7avFDbENCZWXXBHYvs=;
        b=lMscm0qMcpM29m/tbZv9zN4lA9G6wgmsctTG5xcswwbaREpoKeEh3/og4/PpTHu27q
         cvCu7d/A6gmwAlkmkigNsaUkANmrQoC8cxeWuQVA0IwBWL9xNVgDq+nhgMS3oN6xKrTa
         iEV6a6ORo8RmtBsOK7vtiz7gvWBDhVGhMHsQwBU4sbC8wzAEq5E1e+sGOsIw6fL3xiIY
         VHvhgR8hVPhRy4FEityvFG6KEGcimpvTFIIhelsta7Wwr/cWgVx26pc9xDFKtaza8dmb
         I2SEjkQqm9VuOvKKlQtJq/6oKGRvh7HIfZxi3K1FqYhmMCjAs8FPpwgn3csEDe5+GWcP
         XMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DOobrFpiuApCjV8LgM6qxJJen7avFDbENCZWXXBHYvs=;
        b=bcXfQ1XsiEro3TsCXNHydqE/XSTf0fgsgrj/a2jU2KhuRcsb2AnEQ+MBuZrpQQt74Y
         02ksymeSNjgNwGbJJKCTCz8pc7NaXAYTkkZxB3Xl9rYhnmAAWf+a5Z0tQLpBcngAJIxD
         PvxGRd0zuQFq4TRMcjC43tK1oSiUs6MYBv95weVUIRQLdj+li57/5bBxb1WtXPsxAa9P
         bMqkWK/22XokHJzKEsqdJ4wV8Cg0QEEZegp6lxLLmZBYOGyEgt8sPloeI8/LYPUJnPSa
         qesOVt8GZBrnkmm5zCh0XQjHczIA2G1oMRQDrfLnkDHYfz9Ebbxi+o9ro0bOC1IkpV3/
         7MFw==
X-Gm-Message-State: AMke39k3VEU3kym4gjlsKPIMQ7Jj5voLN7iCDZNsHeHusO4luRYPr8TWBWWdVNJeNk85k2ZL
X-Received: by 10.99.223.5 with SMTP id u5mr22163553pgg.58.1489172354487;
        Fri, 10 Mar 2017 10:59:14 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id h3sm20023941pfc.82.2017.03.10.10.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 10:59:13 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, jonathantanmy@google.com
Subject: [PATCH v2 0/2] bringing attributes to pathspecs
Date:   Fri, 10 Mar 2017 10:59:06 -0800
Message-Id: <20170310185908.171589-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309210756.105566-1-bmwill@google.com>
References: <20170309210756.105566-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 addresses the comments made by Jonathan.

Brandon Williams (2):
  pathspec: allow querying for attributes
  pathspec: allow escaped query values

 Documentation/glossary-content.txt |  21 ++++
 attr.c                             |  17 ++++
 attr.h                             |   1 +
 dir.c                              |  43 +++++++-
 pathspec.c                         | 163 ++++++++++++++++++++++++++++--
 pathspec.h                         |  16 ++-
 t/t6135-pathspec-with-attrs.sh     | 200 +++++++++++++++++++++++++++++++++++++
 7 files changed, 451 insertions(+), 10 deletions(-)
 create mode 100755 t/t6135-pathspec-with-attrs.sh

-- 
2.12.0.246.ga2ecc84866-goog

