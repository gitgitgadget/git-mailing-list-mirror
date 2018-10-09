Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FDE1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 11:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJITP5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 15:15:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42348 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJITP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 15:15:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id b7-v6so1411241edd.9
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXGHWts2tzbQBWlUDVia1WYR/2XPpluy62HqaMTtBCs=;
        b=aMpW1f4r4RzXy0QcD1oHfqwsEq/RVwh5bj4nZ8O7PmqcfJZjfRO3aZ5YW4DrhvfE3p
         xem81R1Ur9VrM7raIsqSZqNUJ0Q3dOb5VmlU40krwOPaFqTR+XVNKwCKzau2FNamQ516
         4pf89QRFRqA0/Hxe+hTktm/A8ItK74pvWYziI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXGHWts2tzbQBWlUDVia1WYR/2XPpluy62HqaMTtBCs=;
        b=ZS8jWy54Y+ar0+wZ1LljtlrcuNn9JCouW+Xe1DAiKv4DBvErRowsW4fglbFeQWJMfD
         LIIVqAV6JX8ib7okhP7ckW8DeVHQJIj27Ki33PyVMBQkmHmc5Y7bsfPrm4k5pUTHX6cd
         Fbl+7FhUtYMksvcoqn0yL/wHid5Y0E7/rYGyE6CCI76bLgfgyKbYNKi+PcoxJm3jBnrz
         w4lf2e57YEsslaQ5G/lq8wQ6k7bjmpnbsd+GLoISL9E4NCdbqsTBdoqC42TmXJzN0MsU
         800fcqyjO12L0plYx/fFbcB9+ePsoiFeuRyTlbEbru1BPm5uu3aiaM21JFMUVMx7ccPa
         Ybuw==
X-Gm-Message-State: ABuFfoi9NKFarl8krkLwxvlWSC/IB1vdg8A/UktrHzlSkOAZQ/aus/UN
        udcXE+up+Pe0vGYUYpRz29UpOmoJynM=
X-Google-Smtp-Source: ACcGV60dfI6P1QxK+hrvX88xzxJ6kSlFgJ72ToLXuTZOuUed4Pn3FIj5Cuw5rwA1VxJ3f6ng/7KOfg==
X-Received: by 2002:a17:906:6b88:: with SMTP id l8-v6mr27095057ejr.154.1539086357709;
        Tue, 09 Oct 2018 04:59:17 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id o4-v6sm3522556ejx.30.2018.10.09.04.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:59:17 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v4 3/3] git-help.txt: document "git help cmd" vs "git cmd --help" for aliases
Date:   Tue,  9 Oct 2018 13:59:09 +0200
Message-Id: <20181009115909.16648-4-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009115909.16648-1-rv@rasmusvillemoes.dk>
References: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
 <20181009115909.16648-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This documents the existing behaviour of "git help cmd" when cmd is an
alias, as well as providing a hint to use the "git cmd --help" form to
be taken directly to the man page for the aliased command.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 Documentation/git-help.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 83d25d825a..86a6b42345 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -29,6 +29,10 @@ guide is brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
+If an alias is given, git shows the definition of the alias on
+standard output. To get the manual page for the aliased command, use
+`git COMMAND --help`.
+
 Note that `git --help ...` is identical to `git help ...` because the
 former is internally converted into the latter.
 
-- 
2.19.1.4.g721af0fda3

