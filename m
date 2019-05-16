Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669131F461
	for <e@80x24.org>; Thu, 16 May 2019 18:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfEPS57 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 14:57:59 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:35959 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfEPS56 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 14:57:58 -0400
Received: by mail-yb1-f201.google.com with SMTP id a62so2960346ybg.3
        for <git@vger.kernel.org>; Thu, 16 May 2019 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Le9FMCTJI6pXCdFlqVPhGri1nKiAp54cd08micw8HzI=;
        b=XDxT98RnlCvq9+cCOTmW2cZV12DVwiLbDfqykmr7TPVGOZF1tT+phTN9qeyrC4MlG5
         kefuLXY1No0Z8zlA/d3JnwIcUj38rr05daTXnj9JCc3WvblitINOsXj/7+TKVVUAOH7X
         jd7+9nFZ2rpFa5MaIVCe/nNNmjm34Ugtc9wUh8s6ZJnd5716eVUVuodQOLWQquule8rb
         iR78uwdEvYR/LNlCwzym/rAGJ2HBKUCziFa2fP+7ny2pOCm/HElJJOW0F8xOrC1TTOi9
         mKoalwa+bA03xYaWQm+fw0bure6S+n/MAtZKszeU9LzgazGGpOZ29/H9YitQqe0WaFVf
         gsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Le9FMCTJI6pXCdFlqVPhGri1nKiAp54cd08micw8HzI=;
        b=CsLkgZAbOOlfJb7LaD+41eRfWS/dJeBYaGZ4+BF8zcBeJ94BxP2QDYI+L5lq20m3io
         SwGw1sNjpJkL+JMDw/hY3u6Q/T7HBkeqSwumndE+LRz8/AHuXaA0FI8KIsjNyH2EKyjC
         UEO2lxef3aQhk6SVNy9S4m/hmKKx5qGDGWAAKklCeIZRi8iiLJnsTqCTeqocgEVn/m6l
         o48lkQSp4nU501uXnCzdL/0dL6ljhmugbu5tydiwBfkLsDSw2fF28NCcXFmlO6REQ+wG
         8MUE8csgQAD1xu7OsJXZZiYuz5dIIWQN7KMeSEmmaV6n8U88DHrWELbTF1ZbvwEe6ay7
         CjGw==
X-Gm-Message-State: APjAAAXEw0Z3WsH7r42Qb7qdGiKvy/OwWL0rTS4m4PQ05bAVYqnb1O49
        ovG/Ivf462noYjgNgdFt8CfMJYSHJVQ=
X-Google-Smtp-Source: APXvYqzSiXgLRRP/afQOPYGlZ2hEmrX6CMIoUdgj8+JcSiz5pJoIS/1KWlfaTJEwoq44PCjL7B4lc/ZcLTqh
X-Received: by 2002:a81:3d8:: with SMTP id 207mr26043855ywd.337.1558033077562;
 Thu, 16 May 2019 11:57:57 -0700 (PDT)
Date:   Thu, 16 May 2019 11:56:50 -0700
In-Reply-To: <cover.1558030802.git.matvore@google.com>
Message-Id: <6f4da02d494323e3ca946b4b20bf78d9dee419e4.1558030802.git.matvore@google.com>
Mime-Version: 1.0
References: <20190514001610.GA136746@google.com> <cover.1558030802.git.matvore@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH 2/3] list-objects-filter-options: error is localizeable
From:   Matthew DeVore <matvore@google.com>
To:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "invalid filter-spec" message is user-facing and not a BUG, so make
it localizeable.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0036f7378..e46ea467bc 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -81,21 +81,21 @@ static int gently_parse_list_objects_filter(
 		filter_options->choice = LOFC_SPARSE_PATH;
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
 	if (errbuf)
-		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
+		strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
-- 
2.21.0

