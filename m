Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F88A201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdBWI1i (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:27:38 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36525 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBWI1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:27:35 -0500
Received: by mail-it0-f65.google.com with SMTP id w185so1563342ita.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 00:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YFoWNAt7uyG+qTii1mDTSEwJCGPXW/98pe//ZaFuHNk=;
        b=OouwZx83TICVGFzOotjcO+BxXPYcRT6hb/RjPXtl9rEzgJ1QMKorld4uTu9w0svjdP
         WTGQzrRnxYy7saGSQhwOcALCe4Wv5VYb4buyDT4gv+7584qV+meptw3RhhswBLsCF+9M
         vYnwMSDw5I9Ew8APg09RfXnqv6A2m55TYrCvKA4RjPfWrfIh13vV1jwyOoYUS24X47Pc
         BWzWvWTWZpvNTDY0jLxBpUcPR+U3RJdoImF5Y6gBDkOOkShH88sZ5M/C6++EVSNAaHlR
         YKQzLtQbQrffxIqeS4zrZ8ODAhUp/UAhsk1s15nBDO8PSvj63Jvg//FvRhxTxdWTo3O4
         rxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YFoWNAt7uyG+qTii1mDTSEwJCGPXW/98pe//ZaFuHNk=;
        b=umio0RVSRxDJOIUSUJvGelR0I+NNDc1397xa0jbX/UD4899LjxgmEb6SPugH3R3h6O
         f9V457NXd/ANk93Bm5zLltCHT1ZozytBhTxQ6lgD/Q0A96012cVeDi6xiVvOhBcWnJRM
         BbjfHJoA6fqhVw4y9n5/tma1jQHvLqofCg2rpYNFEB32PdJVkGZJLfmucrSDxx+iPqOK
         HxPXY2eA99RfJFFH+RWec6NixW03Zq/ygvPlK5aBUk5+82RRZLHpN8ZK5wayRNeqONUS
         BnugmKJPSTfbbB7EOiEed+HllP7B+HBIljFpzSOvFOUa9qFc4F5YkpLZU+b0GHnQ9cwe
         E5qw==
X-Gm-Message-State: AMke39m6tLigUnK/OL8GuYVi9pYn7ZTNhtZ4nmXjuMXJzAON1DJNNCrxaz3QevS9oTrctw==
X-Received: by 10.107.130.74 with SMTP id e71mr25919038iod.27.1487838454550;
        Thu, 23 Feb 2017 00:27:34 -0800 (PST)
Received: from prospect.wheaton.edu (wcnat-96-27.wheaton.edu. [209.147.96.27])
        by smtp.gmail.com with ESMTPSA id e126sm1779353itb.18.2017.02.23.00.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 00:27:34 -0800 (PST)
From:   "Devin J. Pohly" <djpohly@gmail.com>
To:     git@vger.kernel.org
Cc:     "Devin J. Pohly" <djpohly@gmail.com>
Subject: [PATCH 4/4] p7000: add test for filter-branch with --prune-empty
Date:   Thu, 23 Feb 2017 02:27:36 -0600
Message-Id: <20170223082736.31283-4-djpohly@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170223082736.31283-1-djpohly@gmail.com>
References: <20170223082736.31283-1-djpohly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Devin J. Pohly <djpohly@gmail.com>
---
 t/perf/p7000-filter-branch.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/perf/p7000-filter-branch.sh b/t/perf/p7000-filter-branch.sh
index 15ee5d1d5..b029586cc 100755
--- a/t/perf/p7000-filter-branch.sh
+++ b/t/perf/p7000-filter-branch.sh
@@ -16,4 +16,9 @@ test_perf 'noop filter' '
 	git filter-branch -f base..HEAD
 '
 
+test_perf 'noop prune-empty' '
+	git checkout --detach tip &&
+	git filter-branch -f --prune-empty base..HEAD
+'
+
 test_done
-- 
2.11.1

