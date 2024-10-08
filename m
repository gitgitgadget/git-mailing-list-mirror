Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD9F3BBCB
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358708; cv=none; b=lpntrzjJwQUTU7cYAkw8OY91RLH3GoDLfyOVyIKWM+/ENEaNwSjddmoZSQZ698J3/KqkVtbbkIfzp8+3cxX5/vUT9Hzp/tYNns+3W3D4yVYd2Hq9TFZBjX/ZxTxoaJUN2moe9yLgccW7AhLaT6VyUqBC4HV4iDcUwBIzLCaNp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358708; c=relaxed/simple;
	bh=0i4D2ky7K6NAdFW7WLJyKBt7Tg1oJzP1VJjWMv8FilA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e3gtaVGhvxsBR77H70nRGu59Fupcg720UXEYh8nm/W88fph5bPWpAEhhRtKc+NPQ/asqjUXHAisa4z7+c8n6c+T+xGqJWeYHxUOsGr54E/HOemDMBFc/lP6Bb+xHYIN1iYuYAhvdOuuMWaAuoT3c+jmyCciASPA0qEk2sOkKIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwNd+q07; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwNd+q07"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9950d27234so260524166b.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358704; x=1728963504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlhgsQx78rD6f+aYzBgx7emNaNYzGQVcasbxIdhx1V4=;
        b=CwNd+q07TYRuBTQx9b37iD5mTXcewjG6AdJEcHviUDc6hcPSZ70LRPMrR9SNiQDoHy
         VUChQgGXv56DRCfcl9HFLVD8wwlvorETb+igdhxhXijbyzqCCeKEtiSmo7bKxRzenck1
         mXl9rfjweVgoGaQDUo2n+w4ODYnGsVr3LOi7ED/uSk2LlZWqMIx5vhXpJ764LZxURXyn
         KIAZUrjhK9xJ8zGcg75wQ/5Hzsv3wOmen6t+Tc3cIzCy0YOv075YDZqS2SlR/xJAKJT5
         iavXcszK6q7lRg7IjAYO7rxC/IOrDTZm5HEm1IxUdWc1L7wVXpu03doCriQyyOWQAufq
         E/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358704; x=1728963504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlhgsQx78rD6f+aYzBgx7emNaNYzGQVcasbxIdhx1V4=;
        b=Yb2DqrrsM5ZzPD7BIF2WVRcHkR484WOTysUJy/EfFSZ3jcLSz6lptJFPg3s7vks/0x
         LuYUMIQs253z53uIPE5X4Akvc1nMYjsbrJbOCHzMWII4eGt2CMyIcImJdN3xqFc0tGt6
         /FTHGLwQLNIpmVPPxArETS4jXmpmLUrEwI6hSAdOZ776sf8eG1nvpmF6Sdj+1gTlx21D
         wSSIbJ//r75Sh9dO+BLNsBuQiv+TLM8xX1xL2s5ekWg3iAFOrbi+V7kUCTH+fCmNJYyW
         NCnABl5uxQMjSE5obRW3BXXl2euWKg8OaE/cWDgj31+NkR8a7weiDEZiA8XdFk/Sl4Rn
         XxhA==
X-Gm-Message-State: AOJu0Yzw+wfnrfIoWQRE5XTyQBY0NtWZVLsvONmIdr8rZ4jtJILVuMWB
	38Uo6yHlj6vpT7183fRE0U2nZz1CVBgJX2TvvnlOoxslSZ8vSclNNvuFMQ==
X-Google-Smtp-Source: AGHT+IHhF9YmGeQir1dq2YwYCHEa35GlG9/D4VmB55dRxzgovzZ2jQH/NSQEE+ESC6D8gwxr5VdGTg==
X-Received: by 2002:a17:906:fe4d:b0:a90:1300:e613 with SMTP id a640c23a62f3a-a991c077ddbmr1474027066b.55.1728358704430;
        Mon, 07 Oct 2024 20:38:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994d5fbef4sm274524866b.166.2024.10.07.20.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:38:24 -0700 (PDT)
Message-Id: <420b15d9f37d2510d0e4f5390a4b93a5ead7c966.1728358699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
	<pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 03:38:18 +0000
Subject: [PATCH v3 4/5] fetch: respect --server-option when fetching multiple
 remotes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Liu Zhongbo <liuzhongbo.6666@bytedance.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Fix an issue where server options specified via the command line
(`--server-option` or `-o`) were not sent when fetching from multiple
remotes using Git protocol v2.

To reproduce the issue with a repository containing multiple remotes:

  GIT_TRACE_PACKET=1 git -c protocol.version=2 fetch --server-option=demo --all

Observe that no server options are sent to any remote.

The root cause was identified in `builtin/fetch.c:fetch_multiple`, which
is invoked when fetching from more than one remote. This function forks
a `git-fetch` subprocess for each remote but did not include the
specified server options in the subprocess arguments.

This commit ensures that command-line specified server options are
properly passed to each subprocess. Relevant tests have been added.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 builtin/fetch.c        |  2 ++
 t/t5702-protocol-v2.sh | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c900f577219..54be2e7ca9f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1980,6 +1980,8 @@ static int fetch_multiple(struct string_list *list, int max_children,
 	strvec_pushl(&argv, "-c", "fetch.bundleURI=",
 		     "fetch", "--append", "--no-auto-gc",
 		     "--no-write-commit-graph", NULL);
+	for (i = 0; i < server_options.nr; i++)
+		strvec_pushf(&argv, "--server-option=%s", server_options.items[i].string);
 	add_options_to_argv(&argv, config);
 
 	if (max_children != 1 && list->nr != 1) {
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5cec2061d28..d3df81e7852 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -418,6 +418,16 @@ test_expect_success 'server-options are sent when fetching' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'server-options are sent when fetch multiple remotes' '
+	test_when_finished "rm -f log server_options_sent" &&
+	git clone "file://$(pwd)/file_parent" child_multi_remotes &&
+	git -C child_multi_remotes remote add another "file://$(pwd)/file_parent" &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C child_multi_remotes -c protocol.version=2 \
+		fetch -o hello --all &&
+	grep "fetch> server-option=hello" log >server_options_sent &&
+	test_line_count = 2 server_options_sent
+'
+
 test_expect_success 'server-options from configuration are used by git-fetch' '
 	test_when_finished "rm -rf log myclone" &&
 	git clone "file://$(pwd)/file_parent" myclone &&
-- 
gitgitgadget

