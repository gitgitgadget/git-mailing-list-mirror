Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB8B1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeG1E3n (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:43 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:51817 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeG1E3m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:42 -0400
Received: by mail-it0-f74.google.com with SMTP id b83-v6so6855646itg.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OgTY6mm9cUM/UfToJ4NCF7djUzbH6vvp4o8P6SgiXZc=;
        b=XZmNP47K/+6TSgoDmTvxsZaaSUM61sMbGJootxWNpYQo3TCITqRmukdYMqDkKu+x9q
         IXGmMOF3d3TgTZ2uXUnji1dQMF6C/n6TqqQXof3HoemH4mEJaxY5CBc8SKszpGI+0KWV
         VZhzvVMQLHybMJgzZKe1MonPBHuQsy/55X4BW6xLHa9auuJxlRQerRToEM64apMoBkVf
         hanXrkQGgPqkMCB0o35eK+62MElDyZzeX46boRuwqF3YDdQR1HX4qf6YmMj5PsZ8n57K
         E3QxkukR+WxTxATUd5JVzfnQQqilLzEEPxNG8TWUr6qsLLWhm73n1Vlf/9ddXs9NOJ7m
         AUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OgTY6mm9cUM/UfToJ4NCF7djUzbH6vvp4o8P6SgiXZc=;
        b=Qz4egSWFJKVz5u7WaZdw0XI/5NrhT6vHTkEGjdMoZg9md9JuoQAKg6QOWN8PId1YZh
         maw8eZlr5UzwB9HW1pZXblESG6MKCu5WKeuZt/gzNztlEPzfEQAQwj8ZuVD9B6zskf0c
         7i54QUF9h/CwbTBGEgsGsKWWUSyp82xHJeRXLz1h02Fq00q7OTmbeH94XOmwqg8Up1Jg
         mHezVN3D6/wNGzB2xr+BKPSZ6AcJyuTf6gu/5Xy60VTKgfFdw341UrZ+mgDdhv5XXK0A
         afQhlxH5DXTdGDEIGEDiB3Aqf+Lz0jPOqg7/b1c6k06ENpECwkU35CvoNCGphfFU9HZf
         oruA==
X-Gm-Message-State: AOUpUlHKpwtnSmmyRgvmvlmG87p0n5+K7XorLo6/2iWTF/nn132OBMU2
        /UJOI6CaOQ6fH4+ckPS8+WQcgXvAlxno0HHKzkjyAezAsAiTMxOuYvQWkJXvy2bH3CEtnR2GGKn
        So+r8PL6ti7mTPeljHD7uAzrXJXLC13yX+FozKSHsmQ/11kGBTdK08cTNbqce
X-Google-Smtp-Source: AAOMgpf34fTQJzltf8iEBayd7NWJWBFgECIDscI12shDbe0kUYhWK/z/gAhKYDkpLCMrkSHPIGncOv4JTkLT
X-Received: by 2002:a6b:8b05:: with SMTP id n5-v6mr3153918iod.13.1532747097527;
 Fri, 27 Jul 2018 20:04:57 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:42 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180728030448.192177-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 2/8] t3206: add color test for range-diff --dual-color
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'expect'ed outcome is taken by running the 'range-diff |decode';
it is not meant as guidance, rather as a documentation of the current
situation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t3206-range-diff.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af9..ef652865cd7 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,43 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'simple coloring' '
+	q_to_tab >expect <<-EOF &&
+	<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
+	<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
+	    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
+	     <RESET>
+	         s/4/A/<RESET>
+	     <RESET>
+	    <REVERSE><GREEN>+<RESET> <BOLD>   Also a silly comment here!<RESET>
+	    <REVERSE><GREEN>+<RESET>
+	     diff --git a/file b/file<RESET>
+	    <RED> --- a/file<RESET>
+	    <GREEN> +++ b/file<RESET>
+	<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
+	    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
+	      9<RESET>
+	      10<RESET>
+	    <RED> -11<RESET>
+	    <REVERSE><RED>-<RESET><FAINT;GREEN>+BB<RESET>
+	    <REVERSE><GREEN>+<RESET><BOLD;GREEN>+B<RESET>
+	      12<RESET>
+	      13<RESET>
+	      14<RESET>
+	<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
+	    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
+	    <CYAN> @@<RESET>
+	      9<RESET>
+	      10<RESET>
+	    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
+	    <REVERSE><GREEN>+<RESET> <BOLD>B<RESET>
+	    <RED> -12<RESET>
+	    <GREEN> +B<RESET>
+	      13<RESET>
+	EOF
+	git range-diff changed...changed-message --color --dual-color >actual.raw &&
+	test_decode_color >actual <actual.raw &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.345.g5c9ce644c3-goog

