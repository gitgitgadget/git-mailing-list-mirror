Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD78C20248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfCUUvV (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40606 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfCUUvT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so64762wri.7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMotgBIQHc5fvktRakOlfYc1CeOsRyS7DaFAX2ZQKrM=;
        b=NcVmCpL38neChSRu5bwS4BnIVNWZLMmlOMwBmscEn3HTIRu4CQ2RiSP7Kwyd82eDss
         nflKoN4qzYyMboCzMredtxPzJIBi2urGSfrsZ3CfQHSQYb39Bd+Rt8ImbQj/FddDKO2q
         Bf+O859w90ldNYMwmJ3oAMDhZRXMsTZpt1e9TQlNoxzyv6GrxERCdjna8tUkF2VkKOBC
         Ks4fT3sCZv2J8OmApABK/d+OT+qBSaMCAS76dgKc/tGk+3E21SymNWgW/0fDZdyUiYOk
         vYO4mOoZYUmgWY8k7WOJ8kLPq2w0AvfbXhTgwUHoKkiRzXB1JCiIh1q2MhGBWpNHnEMG
         cnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMotgBIQHc5fvktRakOlfYc1CeOsRyS7DaFAX2ZQKrM=;
        b=c9nd1MEnT5BS68F0N8C7XLeSDHLQlwcESUU8eCPDt/pEqwfWYJGp/SxZgHlwSW3Y91
         bWHebQ1vfQ+BcJr8Vz2BSFX/LS6iR+NtqmfLzJo7QN5t62+2sqtmunnXE/1SY8bdR+mE
         yKJr67cCEvr3PsiWjy9PSApmIZewyhAJLaNzuLlhtOLcNvqEeKlijf7JrXR8opvqhdVv
         tt9lbNOYwd9iWdWoDwoWx/8z+yLdrxD6iQ3pj6g4vzXmUvA8JroBHaE3/vANMJgpjTiA
         Mxf47HTaY7rxKevCBl7AiLQj484XMp4boalnv1aQqZIFQ9JDGPbchRHyoAljLhCW+HNw
         TsDg==
X-Gm-Message-State: APjAAAU29519i7vaW3M7bPctjyKP/1H3XW90CqqMDnet8+wHeUPQhQfs
        sCob7MZeH0rjgMjMaMvayg5dXjQvn6Q=
X-Google-Smtp-Source: APXvYqwPZxAbE7V/BCWVY+zh3iei/Mymu2s6Qo4+vPNxbumkNpwhbQsMX2z97Aw5u5xG3VR9tDK8XA==
X-Received: by 2002:adf:df92:: with SMTP id z18mr4117835wrl.239.1553201476959;
        Thu, 21 Mar 2019 13:51:16 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] gc docs: clarify that "gc" doesn't throw away referenced objects
Date:   Thu, 21 Mar 2019 21:50:53 +0100
Message-Id: <20190321205054.17109-10-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "NOTES" section to fix up wording that's been with us since
3ffb58be0a ("doc/git-gc: add a note about what is collected",
2008-04-23).

I can't remember when/where anymore (I think Freenode #Git), but at
some point I was having a conversation with someone who was convinced
that "gc" would prune things only referenced by e.g. refs/pull/*, and
pointed to this section as proof.

It turned out that they'd read the "branches and tags" wording here
and thought just refs/{heads,tags}/* and refs/remotes/* etc. would be
kept, which is what we enumerate explicitly.

So let's say "other refs", even though just above we say "objects that
are referenced anywhere in your repository".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c50ec30c83..dced7cde09 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -119,8 +119,8 @@ anywhere in your repository. In
 particular, it will keep not only objects referenced by your current set
 of branches and tags, but also objects referenced by the index,
 remote-tracking branches, refs saved by 'git filter-branch' in
-refs/original/, or reflogs (which may reference commits in branches
-that were later amended or rewound).
+refs/original/, reflogs (which may reference commits in branches
+that were later amended or rewound), and anything else in the refs/* namespace.
 If you are expecting some objects to be deleted and they aren't, check
 all of those locations and decide whether it makes sense in your case to
 remove those references.
-- 
2.21.0.360.g471c308f928

