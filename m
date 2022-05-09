Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57779C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 11:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiEILgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 07:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiEILgq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 07:36:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143421E3888
        for <git@vger.kernel.org>; Mon,  9 May 2022 04:32:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so8086320wme.3
        for <git@vger.kernel.org>; Mon, 09 May 2022 04:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hoLVLB+xgZpsm2Kj3ALFwU5E9uOOav+kraU+eO04N2I=;
        b=gsZ4UiiwwLmm1m8ry4Tvs5LYwPI4pAzVN5KLqY7SVbEOM42OUFhJvqSxWvTpZehznA
         DN5MOcC7Sdf32FMkvWzZ5up1oZ6nDxLUPyqFFls6lWiyVQUgvJFJB2Xf2loPN+a9ENSQ
         mNDYinBP21gGgou9WE82gzw2C3GyOp9VF8/CduJQbeyW3i+RAnVrpDaqD4NnIg0ZUm++
         BZRnIshLpl0R5plPhLi4wutSQWOJ4MvwjzQyEn/CDDGrcvygEd3NijGY4CwgSziqjX5J
         BBO1YqUEZDlD2DFLN9jQu4t6kUVCkC75ZP0XCHGe7Pg/GZhgIf45TjvdoxwYbw2e4B4o
         zdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hoLVLB+xgZpsm2Kj3ALFwU5E9uOOav+kraU+eO04N2I=;
        b=B+eXOGkbObAMKUGxmncCEqDdDKeD/meZ9C/ADjI0XBCf3CiLXwcypZCL2dCOMLHHdi
         j5kOK2Pxq477u3pDnWtURlyXitc2Q/ksIFGwYKHIK4YtTdIvLvMOvS6cNgoGrM8UncWZ
         DYn+qAOnVI4fJCyDdcMiXalTN6BUaEBU2B+o2X87RqOgNpqk8Z5OYsZClpEE9OI+fLEp
         FpBo3DrogW0paE+xYb2NiZBHrxnWET8SQ6i9ByVu1fojwJrCgkHfi6rbw6YXug2jptkG
         0wuWLVn25Gp/ZsRG7PXtiSS9HWOYH6X5+WFVhNbfQLk4y9lSMuTsctXRhfYH36m6UyyT
         4TKg==
X-Gm-Message-State: AOAM5317FqSspBB+HRMqg0bGazbmwzXJrjhJ/OJ+3wU2MCU9XurPqmVg
        xdO5/EHbXy08x9o/vz8ObD/G2v/Wza8=
X-Google-Smtp-Source: ABdhPJyhVbHl5jNmHKuPLOWvlIjZcs8zwS7Wjras729ToXSvWFMBzrMs/rQtdJk8mPBetslypgHLxw==
X-Received: by 2002:a7b:c3cb:0:b0:394:3533:c712 with SMTP id t11-20020a7bc3cb000000b003943533c712mr15709234wmj.141.1652095970240;
        Mon, 09 May 2022 04:32:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c410f00b00394867d66ddsm6186720wmi.35.2022.05.09.04.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:32:49 -0700 (PDT)
Message-Id: <pull.1227.v4.git.1652095969026.gitgitgadget@gmail.com>
In-Reply-To: <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
References: <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 May 2022 11:32:48 +0000
Subject: [PATCH v4] builtin/remote.c: teach `-v` to list filters for promisor
 remotes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

`git remote -v` (`--verbose`) lists down the names of remotes along with
their URLs. It would be beneficial for users to also specify the filter
types for promisor remotes. Something like this -

	origin	remote-url (fetch) [blob:none]
	origin	remote-url (push)

Teach `git remote -v` to also specify the filters for promisor remotes.

Closes: https://github.com/gitgitgadget/git/issues/1211
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    builtin/remote.c: teach -v to list filters for promisor remotes
    
    Fixes #1211 [1]
    
    Changes since v3:
    
     * tests are moved to t5505-remote.sh
     * Documentation improved
     * Added Closes trailer in the commit message
    
    Changes since v2:
    
     * added more test cases
     * fixed broken indentations
    
    Changes since v1:
    
     * updated documentation
     * renamed url_buf into remote_info_buf
    
    [1] https://github.com/gitgitgadget/git/issues/1211

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1227%2FAbhra303%2Fpromisor_remote-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1227/Abhra303/promisor_remote-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1227

Range-diff vs v3:

 1:  9ac6ca9a08e ! 1:  a067435285b builtin/remote.c: teach `-v` to list filters for promisor remotes
     @@ Commit message
          builtin/remote.c: teach `-v` to list filters for promisor remotes
      
          `git remote -v` (`--verbose`) lists down the names of remotes along with
     -    their urls. It would be beneficial for users to also specify the filter
     +    their URLs. It would be beneficial for users to also specify the filter
          types for promisor remotes. Something like this -
      
                  origin  remote-url (fetch) [blob:none]
     @@ Commit message
      
          Teach `git remote -v` to also specify the filters for promisor remotes.
      
     +    Closes: https://github.com/gitgitgadget/git/issues/1211
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Documentation/git-remote.txt ##
     @@ Documentation/git-remote.txt: OPTIONS
       -v::
       --verbose::
       	Be a little more verbose and show remote url after name.
     -+	For promisor remotes it will show an extra information
     -+	(wrapped in square brackets) describing which filter
     -+	(`blob:none` etc.) that promisor remote use.
     ++	For promisor remotes, also show which filter (`blob:none` etc.)
     ++	are configured.
       	NOTE: This must be placed between `remote` and subcommand.
       
       
     @@ builtin/remote.c: static int get_one_entry(struct remote *remote, void *priv)
       
       	return 0;
      
     - ## t/t5616-partial-clone.sh ##
     -@@ t/t5616-partial-clone.sh: test_expect_success 'do partial clone 1' '
     - 	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
     + ## t/t5505-remote.sh ##
     +@@ t/t5505-remote.sh: test_expect_success 'add another remote' '
     + 	)
       '
       
     ++test_expect_success 'setup bare clone for server' '
     ++	git clone --bare "file://$(pwd)/one" srv.bare &&
     ++	git -C srv.bare config --local uploadpack.allowfilter 1 &&
     ++	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
     ++'
     ++
      +test_expect_success 'filters for promisor remotes are listed by git remote -v' '
     -+	test_when_finished "rm -rf pc2" &&
     -+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
     -+	git -C pc2 remote -v >out &&
     ++	test_when_finished "rm -rf pc" &&
     ++	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc &&
     ++	git -C pc remote -v >out &&
      +	grep "srv.bare (fetch) \[blob:none\]" out &&
      +
     -+	git -C pc2 config remote.origin.partialCloneFilter object:type=commit &&
     -+	git -C pc2 remote -v >out &&
     ++	git -C pc config remote.origin.partialCloneFilter object:type=commit &&
     ++	git -C pc remote -v >out &&
      +	grep "srv.bare (fetch) \[object:type=commit\]" out
      +'
      +
      +test_expect_success 'filters should not be listed for non promisor remotes (remote -v)' '
     -+	test_when_finished "rm -rf pc2" &&
     -+	git clone "file://$(pwd)/srv.bare" pc2 &&
     -+	git -C pc2 remote -v >out &&
     ++	test_when_finished "rm -rf pc" &&
     ++	git clone one pc &&
     ++	git -C pc remote -v >out &&
      +	! grep "(fetch) \[.*\]" out
      +'
      +
      +test_expect_success 'filters are listed by git remote -v only' '
     -+	test_when_finished "rm -rf pc2" &&
     -+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
     -+	git -C pc2 remote >out &&
     ++	test_when_finished "rm -rf pc" &&
     ++	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc &&
     ++	git -C pc remote >out &&
      +	! grep "\[blob:none\]" out &&
      +
     -+	git -C pc2 remote show >out &&
     ++	git -C pc remote show >out &&
      +	! grep "\[blob:none\]" out
      +'
      +
     - test_expect_success 'verify that .promisor file contains refs fetched' '
     - 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
     - 	test_line_count = 1 promisorlist &&
     + test_expect_success 'check remote-tracking' '
     + 	(
     + 		cd test &&


 Documentation/git-remote.txt |  2 ++
 builtin/remote.c             | 18 +++++++++++++-----
 t/t5505-remote.sh            | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index cde9614e362..1dec3148348 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -35,6 +35,8 @@ OPTIONS
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
+	For promisor remotes, also show which filter (`blob:none` etc.)
+	are configured.
 	NOTE: This must be placed between `remote` and subcommand.
 
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 5f4cde9d784..d4b69fe7789 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1185,14 +1185,22 @@ static int show_push_info_item(struct string_list_item *item, void *cb_data)
 static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
-	struct strbuf url_buf = STRBUF_INIT;
+	struct strbuf remote_info_buf = STRBUF_INIT;
 	const char **url;
 	int i, url_nr;
 
 	if (remote->url_nr > 0) {
-		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
+		struct strbuf promisor_config = STRBUF_INIT;
+		const char *partial_clone_filter = NULL;
+
+		strbuf_addf(&promisor_config, "remote.%s.partialclonefilter", remote->name);
+		strbuf_addf(&remote_info_buf, "%s (fetch)", remote->url[0]);
+		if (!git_config_get_string_tmp(promisor_config.buf, &partial_clone_filter))
+			strbuf_addf(&remote_info_buf, " [%s]", partial_clone_filter);
+
+		strbuf_release(&promisor_config);
 		string_list_append(list, remote->name)->util =
-				strbuf_detach(&url_buf, NULL);
+				strbuf_detach(&remote_info_buf, NULL);
 	} else
 		string_list_append(list, remote->name)->util = NULL;
 	if (remote->pushurl_nr) {
@@ -1204,9 +1212,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 	}
 	for (i = 0; i < url_nr; i++)
 	{
-		strbuf_addf(&url_buf, "%s (push)", url[i]);
+		strbuf_addf(&remote_info_buf, "%s (push)", url[i]);
 		string_list_append(list, remote->name)->util =
-				strbuf_detach(&url_buf, NULL);
+				strbuf_detach(&remote_info_buf, NULL);
 	}
 
 	return 0;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c90cf47acdb..fff14e13ed4 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -78,6 +78,40 @@ test_expect_success 'add another remote' '
 	)
 '
 
+test_expect_success 'setup bare clone for server' '
+	git clone --bare "file://$(pwd)/one" srv.bare &&
+	git -C srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
+test_expect_success 'filters for promisor remotes are listed by git remote -v' '
+	test_when_finished "rm -rf pc" &&
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc &&
+	git -C pc remote -v >out &&
+	grep "srv.bare (fetch) \[blob:none\]" out &&
+
+	git -C pc config remote.origin.partialCloneFilter object:type=commit &&
+	git -C pc remote -v >out &&
+	grep "srv.bare (fetch) \[object:type=commit\]" out
+'
+
+test_expect_success 'filters should not be listed for non promisor remotes (remote -v)' '
+	test_when_finished "rm -rf pc" &&
+	git clone one pc &&
+	git -C pc remote -v >out &&
+	! grep "(fetch) \[.*\]" out
+'
+
+test_expect_success 'filters are listed by git remote -v only' '
+	test_when_finished "rm -rf pc" &&
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc &&
+	git -C pc remote >out &&
+	! grep "\[blob:none\]" out &&
+
+	git -C pc remote show >out &&
+	! grep "\[blob:none\]" out
+'
+
 test_expect_success 'check remote-tracking' '
 	(
 		cd test &&

base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
-- 
gitgitgadget
