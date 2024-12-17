Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6121F8685
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455890; cv=none; b=Br/uUKanb7jWKKsk+9jXnalO2hcMFrvtAY1+Q/mk+AfjmwZz5UKmgqOdXc1tkB3QTb3BL14kKge0LKuD75DA3+MnlvF7Uw85VasMVTp9vb6LPSBLdTDQy8CD9CiPdmjjzrgNVPfNN+G/tSWXu3rmd2SIpFNpxDWHRD0TfiNI5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455890; c=relaxed/simple;
	bh=Bwj6492udxtVldXcDu1rB1ENL9DoQc04rWRPMVUC7gg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hzv9gO9fw4ZEF0NQUpftcMUsdxhObk/vMlNedmqcFmWPWtFaDAcNxT8kz7N18FJr8HFmHPCGZXPkcDLHSwMcaD+F7Vd/7vSjqn+xrWBI1ZgYZVqAsKwce936AUYJxEKVbPRX1vNHAshQgPRW9zL43F75yEiABOiG+xFjh52UKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIBVmpYk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIBVmpYk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so2933943f8f.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 09:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734455886; x=1735060686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3VmscA363PyjakdSSvRTFevZn7uqCeX4yJS+lmpzo0=;
        b=NIBVmpYkc7UhpKw2V+7rGlJLLJACEFSIcBloW6SGCw3WR/YTPRcV9XDtyYhgXMyUbh
         /4yCZ9rWU4elqwDhQufdkSQ5zcMQqnovsPieNVVfpio/uqRBOUG4AiSrrJ3UgbZeZfi1
         td4pMhZ5umyCRjAUE2ZiyrLhgIqKDvdQrtpd+GuYX9tpOJvE53wRJ6MaLi7TBsJiG3Q9
         fygoBNctQw35Knv3Nqd8SqI2PkKYSh9cA25G3eAob2Sq7UfoabbNM/wH23ZqLZ+QNmiu
         Ihdbk7zqvKcjX4p5xn7XJcH/Jx7+9KPcJ8udys7NeKHNwsCV5Ep8ecLO0W9bpRset27g
         Uynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455886; x=1735060686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3VmscA363PyjakdSSvRTFevZn7uqCeX4yJS+lmpzo0=;
        b=NCnbAv8kvyI3jMBuXfO1oxvDyaT32BskngvguYI9xkC2eFww8sMI5rdwtfM1XhpckH
         1g2iHS5N9/e1eWPRsy5rshG8tgqL3mZIjvlXuOrUNuzJweNrjyoJiNsQAO1xwqJXIyLR
         qXa/mtWp7DbbK4j29bR6IpauIW+VguTWKp3lgzZfGwiQZSLltPTcXAuZHmh+6wah1YH8
         rrTJBZ6N9ZM0oPqg+qnUP/ZOSWOO1OUaxd29c/Tu29sU68RK7SQz1QYtPHrvRmVeB13w
         lcOTOPA3mo5QswnUQUyKuLsfHOOaczfNBL3pAV2jHrPatgr8hMQPaoBATfpNqiExoiCf
         08Fw==
X-Gm-Message-State: AOJu0YyPNAwATk775HjaeiImVxksdBS73bKhZLNdaecDh5rf7BLRnOue
	zha4wYqMNNoSPiiH6+ZUssNgnbcH0Oj/HSdTTcBO13E0H2rXmiw13Xd84Q==
X-Gm-Gg: ASbGncspsCEIwJlE5fMe6Dr1b0MzEFwNl6fEpwD7msHhndov5UBVVISKYeQKnE1zGEj
	SW729zav/l0WJMqEGZ8iFoO+1Qa4YARJCUea79FKjZsnnTyUxlW1p5FVk4mvh8K4oIIjlYihJaY
	xBu4TQ5WX/ewn2mVmqaUn/LMBASKeLfbjZzH3iGz/ZE8f3zDDVhfaYxtb5QQd74Y/peq+V8hDh1
	LJgklZF8F9fuYG48KMDE78IP4pR5B9qFCNze1Vt6OTnhwaD2fMSBa/YFA==
X-Google-Smtp-Source: AGHT+IHpYO5F158nmK1OQZwH+DSbDzuNdw2hPW+HWCLlsBaMX1FJMyQ/95ARZ6h2Wx7KEJqWizyVmw==
X-Received: by 2002:a05:6000:1449:b0:386:380d:2cac with SMTP id ffacd0b85a97d-388e4628a17mr60057f8f.26.1734455885915;
        Tue, 17 Dec 2024 09:18:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550563sm178579485e9.4.2024.12.17.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:18:05 -0800 (PST)
Message-Id: <pull.1837.v2.git.1734455884405.gitgitgadget@gmail.com>
In-Reply-To: <pull.1837.git.1734439176360.gitgitgadget@gmail.com>
References: <pull.1837.git.1734439176360.gitgitgadget@gmail.com>
From: "Wang Bing-hua via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:18:04 +0000
Subject: [PATCH v2] remote: align --verbose output with spaces
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
Cc: shejialuo <shejialuo@gmail.com>,
    Wang Bing-hua <louiswpf@gmail.com>,
    Wang Bing-hua <louiswpf@gmail.com>

From: Wang Bing-hua <louiswpf@gmail.com>

Remote names exceeding a tab width could cause misalignment.
Align --verbose output with spaces instead of a tab.

Signed-off-by: Wang Bing-hua <louiswpf@gmail.com>
---
    remote: align --verbose output with spaces
    
    Changes in v2:
    
     * Use for_each_string_list_item() to traverse string lists.
     * Calculate the max width outside of the loop.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1837%2Flouiswpf%2Fremote-align-verbose-output-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1837/louiswpf/remote-align-verbose-output-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1837

Range-diff vs v1:

 1:  960a18efc36 ! 1:  648881dbf0d remote: align --verbose output with spaces
     @@ builtin/remote.c: static int get_one_entry(struct remote *remote, void *priv)
      +static int calc_maxwidth(struct string_list *list)
      +{
      +	int max = 0;
     ++	struct string_list_item *item;
      +
     -+	for (int i = 0; i < list->nr; i++) {
     -+		struct string_list_item *item = list->items + i;
     ++	for_each_string_list_item (item, list) {
      +		int w = utf8_strwidth(item->string);
      +
      +		if (w > max)
     @@ builtin/remote.c: static int get_one_entry(struct remote *remote, void *priv)
       {
       	struct string_list list = STRING_LIST_INIT_DUP;
      @@ builtin/remote.c: static int show_all(void)
     + 	result = for_each_remote(get_one_entry, &list);
     + 
     + 	if (!result) {
     +-		int i;
     ++		int maxwidth = 0;
     ++		struct string_list_item *item;
     + 
     ++		if (verbose)
     ++			maxwidth = calc_maxwidth(&list);
       		string_list_sort(&list);
     - 		for (i = 0; i < list.nr; i++) {
     - 			struct string_list_item *item = list.items + i;
     +-		for (i = 0; i < list.nr; i++) {
     +-			struct string_list_item *item = list.items + i;
      -			if (verbose)
      -				printf("%s\t%s\n", item->string,
      -					item->util ? (const char *)item->util : "");
      -			else {
     +-				if (i && !strcmp((item - 1)->string, item->string))
     ++		for_each_string_list_item (item, &list) {
      +			if (verbose) {
      +				struct strbuf s = STRBUF_INIT;
      +
     -+				strbuf_utf8_align(&s, ALIGN_LEFT,
     -+						  calc_maxwidth(&list) + 1,
     ++				strbuf_utf8_align(&s, ALIGN_LEFT, maxwidth + 1,
      +						  item->string);
      +				if (item->util)
      +					strbuf_addstr(&s, item->util);
      +				printf("%s\n", s.buf);
      +				strbuf_release(&s);
      +			} else {
     - 				if (i && !strcmp((item - 1)->string, item->string))
     ++				if (item != list.items &&
     ++				    !strcmp((item - 1)->string, item->string))
       					continue;
       				printf("%s\n", item->string);
     + 			}
      
       ## t/t5505-remote.sh ##
      @@ t/t5505-remote.sh: test_expect_success 'without subcommand' '


 builtin/remote.c  | 40 ++++++++++++++++++++++++++++++++--------
 t/t5505-remote.sh |  4 ++--
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1ad3e70a6b4..1e9106530c0 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
+#include "utf8.h"
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
@@ -1279,6 +1280,20 @@ static int get_one_entry(struct remote *remote, void *priv)
 	return 0;
 }
 
+static int calc_maxwidth(struct string_list *list)
+{
+	int max = 0;
+	struct string_list_item *item;
+
+	for_each_string_list_item (item, list) {
+		int w = utf8_strwidth(item->string);
+
+		if (w > max)
+			max = w;
+	}
+	return max;
+}
+
 static int show_all(void)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
@@ -1287,16 +1302,25 @@ static int show_all(void)
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
-		int i;
+		int maxwidth = 0;
+		struct string_list_item *item;
 
+		if (verbose)
+			maxwidth = calc_maxwidth(&list);
 		string_list_sort(&list);
-		for (i = 0; i < list.nr; i++) {
-			struct string_list_item *item = list.items + i;
-			if (verbose)
-				printf("%s\t%s\n", item->string,
-					item->util ? (const char *)item->util : "");
-			else {
-				if (i && !strcmp((item - 1)->string, item->string))
+		for_each_string_list_item (item, &list) {
+			if (verbose) {
+				struct strbuf s = STRBUF_INIT;
+
+				strbuf_utf8_align(&s, ALIGN_LEFT, maxwidth + 1,
+						  item->string);
+				if (item->util)
+					strbuf_addstr(&s, item->util);
+				printf("%s\n", s.buf);
+				strbuf_release(&s);
+			} else {
+				if (item != list.items &&
+				    !strcmp((item - 1)->string, item->string))
 					continue;
 				printf("%s\n", item->string);
 			}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 08424e878e1..6586f020f74 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -249,8 +249,8 @@ test_expect_success 'without subcommand' '
 
 test_expect_success 'without subcommand accepts -v' '
 	cat >expect <<-EOF &&
-	origin	$(pwd)/one (fetch)
-	origin	$(pwd)/one (push)
+	origin $(pwd)/one (fetch)
+	origin $(pwd)/one (push)
 	EOF
 	git -C test remote -v >actual &&
 	test_cmp expect actual

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
