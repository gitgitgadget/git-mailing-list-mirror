Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A6B1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 05:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfDVFHo (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 01:07:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41409 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfDVFHo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 01:07:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so5246162plj.8
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 22:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DPh8e7dGVsmC6NsPKDI2JOO/8WnAIRgcpwu2s66DnCI=;
        b=H+d3CCd0l8sEBEGCEColBpQa3OHDKmb1e7KUshoGM1ntlwdNeer5Ml/ogEFSHNL34j
         mUSlKDrrHR0OkqVCCKEZv7WePmLcOynl/Wt4wC6ggEfnMk8STtrFBX6C1Izhbgzt2Csc
         mwYBZkhKVZlN56HoBIhmB1aT4GM+HzQuBWJSPJ/LE0Q3VR3E6Qfm5yQRvhmsV4MiKum2
         x0ewVsXz+8rAaNL2HMb/u4yiLkpwSOwKYhpqvSfNgQ0w11zY3VemlGHz9WZq9HPkgLK6
         ouF/zRNjqjs0EPd0okLIDOVJfADj51+v9ddpme/MYL42hhCEiLROu4AGg2zSO9s4A9rE
         jRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPh8e7dGVsmC6NsPKDI2JOO/8WnAIRgcpwu2s66DnCI=;
        b=lcTaERMlrhQdDsYLUoT9BRyRCS+H9BUw+QrKPf9KYWHanhD2Tb3yNplMJYsK5CLzEA
         bmS9Xx/zbu7KtOxjzHEDFhF6bgNbwaMgdRi3pVl87yanlcvBDWnXclvqgnffljDnY4ve
         8rEgamb1Re9uEKhDTmD5h+C36ol4F+JrdPanXG5yZb9TYOfWjmgx56DmQv8aHyeIhw00
         54U9IBjKva09wOClVVxeeae8MWXu30TRxHGOcuBOHAdDlCzGtF9DX/VFbkPhSkr+e7xI
         FJifcaiRgV58swieUn8O4QDrFaxYdvQX+5+WLczjQmO9lscfTgtKu7kGiJzfBjRdNCFE
         gKzw==
X-Gm-Message-State: APjAAAXcZ35FnQZa/sJIkfgGvjCtW3qQ++oGzgdP7IHD9M1ymkeMAbQR
        fvulUCD/4j+RkZMPn9VzrqUKvDPQ
X-Google-Smtp-Source: APXvYqxvDzymYj5fkDFzv3J0iL1ElfPAe93/tMCRBHmOH1lVJrcByODvUY2EcO46MOdz+NMGD9VDOw==
X-Received: by 2002:a17:902:b481:: with SMTP id y1mr18437365plr.161.1555909663212;
        Sun, 21 Apr 2019 22:07:43 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id m8sm20680760pgn.59.2019.04.21.22.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 22:07:42 -0700 (PDT)
Date:   Sun, 21 Apr 2019 22:07:41 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/5] t7610: add mergetool --gui tests
Message-ID: <678f9b11fc7df7d3ee2050388574bcaea86af331.1555880168.git.liu.denton@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555880168.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 063f2bdbf7 (mergetool: accept -g/--[no-]gui as arguments,
2018-10-24), mergetool was taught the --gui option but no tests were
added to ensure that it was working properly. Add a test to ensure that
it works.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7610-mergetool.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index a9fb971615..5f37d7a1ff 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -145,6 +145,28 @@ test_expect_success 'custom mergetool' '
 	git commit -m "branch1 resolved with mergetool"
 '
 
+test_expect_success 'gui mergetool' '
+	test_config merge.guitool myguitool &&
+	test_config mergetool.myguitool.cmd "(printf \"gui \" && cat \"\$REMOTE\") >\"\$MERGED\"" &&
+	test_config mergetool.myguitool.trustExitCode true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge master >/dev/null 2>&1 &&
+	( yes "" | git mergetool --gui both >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool -g file1 file1 ) &&
+	( yes "" | git mergetool --gui file2 "spaced name" >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool --gui subdir/file3 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool --gui file11 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool --gui file12 >/dev/null 2>&1 ) &&
+	( yes "l" | git mergetool --gui submod >/dev/null 2>&1 ) &&
+	test "$(cat file1)" = "gui master updated" &&
+	test "$(cat file2)" = "gui master new" &&
+	test "$(cat subdir/file3)" = "gui master new sub" &&
+	test "$(cat submod/bar)" = "branch1 submodule" &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
 test_expect_success 'mergetool crlf' '
 	test_when_finished "git reset --hard" &&
 	# This test_config line must go after the above reset line so that
-- 
2.21.0.967.gf85e14fd49

