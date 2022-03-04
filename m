Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1F5C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiCDPF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbiCDPFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:05:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442D15C1B6
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:04:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j17so13184459wrc.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ICsNrHzXd4RZPq+Z7tpWCL81jwFbzmJwcvelPW681Yg=;
        b=VXVU3+YfDofTAqJM1HGITjFSLNvfjraa/xX3wFCNeBZSbvezjPQe0Z7A1IndiZoL35
         MFTAEUNNns3s++O9W5nDNqQuD8TwlHdwKOEdOAL+ZJ1Etc0Mwxbwhwkwzjof126j0Sln
         oQ1YlpGxENWXDbQHXAuuqr7fVjPByPFlrlPAftdbJUQfdUjmzoLfvQZiDfek45xbXEmA
         hD+D88yWz4dLrdsRfRizCkOOCh/yclHB3XphDgAUrfkxdzMy6k36Cce47Dr1b4qDbYVM
         tC98ewdtadBVF6vXKViIzNe5LsjxnsVvM2K8Y0T5KQSZkTQD9zs4gAmDOV3MKvUW/Xx3
         FQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ICsNrHzXd4RZPq+Z7tpWCL81jwFbzmJwcvelPW681Yg=;
        b=Y9884HFqpZPDgT8+mH06YhuO+qE4+MKIuLREN/65qTOSa4J9U1eJAFIO82jRPv+H2O
         QFtLJEQs2hH9VWOgkMg7+JjcQJbRFpMZ+XgxXK1dGBmX3JKZmldotHwqBqUdww/QyTNG
         I4QSwdjh+IGRL8ARA5iB1u6C/QfUh4qX2g+ylT97DJqrXg/CYKqDv5Nrl5KvEqQlzt3W
         g4YY9srDA1Hz5CUMk7wrxhIDrbAascUajt85mqsgxn29+XodmpffdRddD97RtS/6dipl
         5QUmtu5fEdKEFrOWvIGf30DN3VU38qNcMusWznAmGVGVqahOLQZJYvo+M/tZA4kzjPvG
         argg==
X-Gm-Message-State: AOAM530z55Z8VoD/Tu7ssfh7v7Bu3WvPcy2sgbpIRsR9c70iwY1KWz7G
        u6fc0Tc9Kum4TT6A+KiwgE2R3n9qXVA=
X-Google-Smtp-Source: ABdhPJyTtPg9CDxdYqmHHZOzb7o02A1eY9kY8+xSd08cUXbAS0DoHVyXjXu7XjDK2JywVmZnbzlFeQ==
X-Received: by 2002:adf:c792:0:b0:1f0:769:9ef3 with SMTP id l18-20020adfc792000000b001f007699ef3mr13124812wrg.336.1646406282393;
        Fri, 04 Mar 2022 07:04:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm5257147wma.21.2022.03.04.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:04:41 -0800 (PST)
Message-Id: <f923a06aab5c9c6162fc3fafaebb2027675881ec.1646406275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:04:34 +0000
Subject: [PATCH v3 7/7] doc/partial-clone: mention --refetch fetch option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Document it for partial clones as a means to apply a new filter.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/technical/partial-clone.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index a0dd7c66f24..99f0eb30406 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -181,6 +181,9 @@ Fetching Missing Objects
   currently fetches all objects referred to by the requested objects, even
   though they are not necessary.
 
+- Fetching with `--refetch` will request a complete new filtered packfile from
+  the remote, which can be used to change a filter without needing to
+  dynamically fetch missing objects.
 
 Using many promisor remotes
 ---------------------------
-- 
gitgitgadget
