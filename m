Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9171F5A2
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKOBAk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42735 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOBAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id q17so4880299pgt.9
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8PgldK2X+AFBEMRzZbMBf6HT7UkXJQqOdunZdbHKwXI=;
        b=oyVre4KK9P2hI/6KCgeqyexVza0doxZhIEV+lLv8qaNHiOnTVL9IYykcj1GG+ahqrQ
         m5xrHyrgVQf91ZMnrNSS/hL6rxY2qh8zZ7gDWwEXmj7DchJPAjTkSWpqSAg0kVyE8abX
         PpxMO9SZoTQDabWmERgoppcc5ZMfQe6lGS41S7nlah1yWpWiu0mIXmz+O9yjwy9oFW6q
         VaxNEhlYInWBTMCcdarJ8mN8hWEms0dDpxb29yw+n3jH2isUHNOwi/yh0isKDtUohRj8
         l1ygjQlGzCQzh3wndPhHtZ4Qv3jn+i5p7OkIg+eWIg77u12bXUnEeBPTR+vEH+Q9RxM1
         d2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8PgldK2X+AFBEMRzZbMBf6HT7UkXJQqOdunZdbHKwXI=;
        b=ItKtAKfWG18ViHqP9XGcRfUJzoO3ekaU0mmKb0qu6sUMo2nWdJiMQMTKF9h/vuUrQg
         l8EEGXnOoWFu7dm8VPkB021g64AP/+58uo5ZrMuBmTHnjHvp8FWqNYFIySOSnCBNbPNo
         zRXSgViDQ2dX7Ko6evpo+uuwhCRZfr9+JZnjrqspoNu+5UDSS6iA2BSX1Np/WxIOBohs
         qsA0OiRZw0DCi7sCGOaoRLwPuS56kc/eBwHnPp+5dTfLBcOvb9/lB0a1d28N5xBfwoOF
         QQ/ToBn/AJ1p4SbtRUoUa3hDnMAWGYkIDT5yMRKGuZ0wQr7Ler1TqCeFyvVPvDEIgjsR
         Afdg==
X-Gm-Message-State: APjAAAX8O52N8L5esKxXXZwWHTYfSnnHw2Mk+4HYJCv6jCQU3IqoQq9W
        0myhq5QbwrW3603KXTN/VCg1YLus
X-Google-Smtp-Source: APXvYqygQ1bTmk4WR3BXBsV1Tp6knO1pb25mVXnfi784InMWigj2PZVZW2AflGjzrU67tii4HKc3ng==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr13317585pgj.284.1573779637450;
        Thu, 14 Nov 2019 17:00:37 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id f7sm9585003pfa.150.2019.11.14.17.00.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:37 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:35 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 02/27] t0014: remove git command upstream of pipe
Message-ID: <b60687989d1c55782d1c589bb7aae1c971fa1e77.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the `git frotz` command would fail but its return code was
hidden since it was in the upstream of a pipe. Break the pipeline into
two commands so that the return code is no longer lost. Also, mark
`git frotz` with test_must_fail since it's supposed to fail.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0014-alias.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 2694c81afd..8d3d9144c0 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -38,8 +38,8 @@ test_expect_success 'looping aliases - internal execution' '
 #'
 
 test_expect_success 'run-command formats empty args properly' '
-    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
-    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
+    test_must_fail env GIT_TRACE=1 git frotz a "" b " " c 2>actual.raw &&
+    sed -ne "/run_command:/s/.*trace: run_command: //p" actual.raw >actual &&
     echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
     test_cmp expect actual
 '
-- 
2.24.0.399.gf8350c9437

