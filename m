Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C511F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeHNE00 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:26 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:36163 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeHNE00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:26 -0400
Received: by mail-qk0-f202.google.com with SMTP id c27-v6so19018648qkj.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Lhbqr2Rozy4Gd+x0tu+Z/Yi9WgvtgT4IoBizRpIBOoI=;
        b=QiHDAO/uEX6WeuRJRJIMbu3Ud+mFnDnTmPkRQPDNnKuyLPUS/UJTDkPoH7f9KoUt+4
         TvSRTheWoV1zsJM+V93MBHjIbD1LLozzjatSjVO8GV/zD4aXwDbtrNM46rRPqJ45UvRu
         /yvh1xDnbWmlBPAeuH6ClK3YD617OVk+QKcktWHBqfKQCCqE25N4Kof8qfS6Y9DMf0dt
         i4YzCSMVowssgbmaAFMuZvLFj5wBK6Jwd8XAqc4d5qcZtfGNj6WHLLsyhWoVFYyRQZgt
         BEalCUHwrDzAlqibO3z6F1ulO4yEb44Yg1lUYXWxK61ORM3l3lfV+0VkUxn9BbzWNZNJ
         ktlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Lhbqr2Rozy4Gd+x0tu+Z/Yi9WgvtgT4IoBizRpIBOoI=;
        b=hG2pFWAeaOhGQm5v7tu8m8iOi3xxO3Qh7Eo4CkBrdX0Dv2QstrCpWDqEyHSBr5yIcb
         oe+blKjmzGp3zxx2yu1WOTJfnj6u/xmgEXi5GkPFGRJ9C72gygLjTqRBXHo70C+dNpHE
         38dGJNUSam9KRfRoiykOUINMfMFq4+dZJuMfcDkvS+Vim4qGbG3BzeenpwxfdRfOEtiM
         PfGiJtO4EeI28DgRFnOIR8IWEeydTOI9QJQuv7vP+YA+FReC2d33RdKYAe/u91OA5qJq
         Y/Hte88B7ywBsM1kej14NAt92G2XIJvmIb3rk5H5j9iFFnmj0DIaWSNFbv6lTAeTqs6Q
         6EIg==
X-Gm-Message-State: AOUpUlGttP/nZk82Lzl06N1aF9uzESPLZk4pv3lrS1sUfEdnrI/a0bXT
        0bx2cwWM9Xu8fA9c/tlle+piMHbuaD3o
X-Google-Smtp-Source: AA+uWPwrllA0A94RwBbNp/wF6yQWcr2JWqNhIjFBLZgkJA9L53xsG4RrKA6EnrdnQLO7m+hrImIhcPuff6X5
X-Received: by 2002:a37:c858:: with SMTP id c85-v6mr12646924qkj.48.1534210895225;
 Mon, 13 Aug 2018 18:41:35 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:16 -0700
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-Id: <20180814014122.30662-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 2/8] t3206: add color test for range-diff --dual-color
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'expect'ed outcome has been taken by running the 'range-diff | decode'.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3206-range-diff.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af9..31f6458f961 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,43 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'dual-coloring' '
+	sed -e "s|^:||" >expect <<-\EOF &&
+	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
+	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
+	:    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
+	:     <RESET>
+	:         s/4/A/<RESET>
+	:     <RESET>
+	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
+	:    <REVERSE><GREEN>+<RESET><BOLD><RESET>
+	:     diff --git a/file b/file<RESET>
+	:    <RED> --- a/file<RESET>
+	:    <GREEN> +++ b/file<RESET>
+	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
+	:    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
+	:      9<RESET>
+	:      10<RESET>
+	:    <RED> -11<RESET>
+	:    <REVERSE><RED>-<RESET><FAINT;GREEN>+BB<RESET>
+	:    <REVERSE><GREEN>+<RESET><BOLD;GREEN>+B<RESET>
+	:      12<RESET>
+	:      13<RESET>
+	:      14<RESET>
+	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
+	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
+	:    <CYAN> @@<RESET>
+	:      9<RESET>
+	:      10<RESET>
+	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
+	:    <REVERSE><GREEN>+<RESET><BOLD> B<RESET>
+	:    <RED> -12<RESET>
+	:    <GREEN> +B<RESET>
+	:      13<RESET>
+	EOF
+	git range-diff changed...changed-message --color --dual-color >actual.raw &&
+	test_decode_color >actual <actual.raw &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.865.gffc8e1a3cd6-goog

