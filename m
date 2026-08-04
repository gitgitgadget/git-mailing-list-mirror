Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851C416878
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868994; cv=none; b=oGHy9syXq2FTqljkdwy9hO0qwhqQGrgmL7UmXkrDpLCGN8ul8ughPsMh9p/sWumuGdaQx9Kq6dgk1gRMbodIZ/FP3bz2UWtnZHZDegxKOvERKuJAzYYfCcxWH+BsesLYAprJPB/hSVkoZGWdfeEBIAJzPCLdpKwP1o0dT5fcsro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868994; c=relaxed/simple;
	bh=YF6kd9hmLWVQKjBu0ToIcShnPDbAzRGZ7eJVhKyeTUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pEWoYcbu7Z+nHafqg25vrrPh/ut8tL5DB6ju0Uel7spG2tMot4utP7Kc4xmOjhdYKV4Mt80EE69Nv4LTJH9suC+gzsOD9rMcclXdC5hCAKShquEY2hFk9ETiYY01YSP0+34Tqbk/Z5I1qQnrpFKUjQuJN3oeDiaQx16adw1qtkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkFJ4ksK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkFJ4ksK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so1421865e9.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868990; x=1786473790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6/sjT1kD6rW5fJpUKxpvE85ofDIionXj5ELrodhOLE=;
        b=PkFJ4ksK+lAORDZASBAejZ/k+ffGLtu38KVqO0b+kZ+5KQ7DkK07eOS/hzV9gwjQhM
         YpmU+2M6hapEber3M5SHXv3M2QKnwClcFaK4muTjPi5mzlTy+V8p/izDEPlcVHTdP4IK
         2HUerG7ArGJ/5obDQUyQcCdQZEVonp0Z9GvJ88Jj1Kosgp/f2atTzxNw4xbb6HZMcAS8
         odHwM1GmsjcbuSvDqN74mbjgS75VzTQCvNWT5mtSV015JO4eYyEg5t6PCACNIKhvIYmH
         NuG2j8LVJ5AMLvitMz/masDEfWx9MRepeRhFf9DTFTeqrRXfVy/7bpPKb7UrSnERtUhU
         OWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868990; x=1786473790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6/sjT1kD6rW5fJpUKxpvE85ofDIionXj5ELrodhOLE=;
        b=oYFIEChaI0cciLlxbipAlwfQWw8XR1MENQKHUPC0ZAtly+BUwrfTK9jfAy0kmx+vpH
         DoOZqNmMNGPaSjJijdzvkRxD6lYrIxel1NaFrEMUbMupXFOJADq4DX5ulCqD4kChrZkY
         8Pw4hmt/TqlO5MDruTbOOxhMZ7PZXGiMs8aR7B4otIm2Tin3ksS1aX9nxJiyS80ZCUtM
         xkpwtlqlEwgybvgeVrZUK8AKgy14DRlXNyKATSVc2KRhxzrqfW5WJ2oIqQUPT+jJCjPM
         ZOvsKpH5oZ4nzVN5aZIyhNlPHiNn0kCbOLOmhpBIePj2BltnSvEuZP3FdrOfocac44Pn
         A58g==
X-Gm-Message-State: AOJu0YycX1F/6OPMkpUoFePOWpTbw0cVkOK8wletye0RFtYhT1xnvDsc
	EuKW50+pQ/Faoxoozo8ipcy8jr/Ba7XFdT9EbbHVJzw9LkGvHeUslqMl
X-Gm-Gg: AR+sD10i77eJpgYr5HrrmS3Zc2Up9xSZ0Fb+wiGMZGX0c0vFj/9Poy9enSs/E5B6bAQ
	5Q83tDVCflTtMB7QyuuJSA2BPYPO5Bpgym4D9ZRCoC4S4GBQnTdMHsSuvVXanxYtIPVjZ8lgbFK
	W8eueAqmDLPlGPziQk96lk4Nan4KUm29qbwI1nwtX2x07bFJ0bkxFOgmK/BcQuRs6bI9jQwVgqu
	iuY71vZxS/z+QK4uSWDfkjwrRpzNuLcFLqYAhDz/A33Mbzykw3jixbWYfdYJN7jutcuOH9ck2ea
	ebeAijviiO0qGNKkU8DrjTpqyJEeRRuKFlrUx3h/zMSNqf11PI7p6ama7bfhxiOO0gCFpmD047k
	uP/wcRUGkRWhnLHDD+8/AziXc7Hcs1SFP/dvHn3rb8XMDyp72YaoLswK+kGkjqncFq1CioEX9Qs
	1b2OYTLodvwSzZzmjV/tlnVN1RiIkQk9idr+1kN7FKJz5HbwnpREbq7YxxCopsXNxbE2zALGa6e
	w423LVHtGjM9e43ThB5+lrFDiQEaTpPiY5urdAPLq/wT34FkXQ5husDskBODlrs/y3WIjXP3x5y
	tzbV/3zsf0MFdVOpzYdA2lI04GiyjAdfJi1BRNpkbWjXH7zlWZJ6D+VNkf3VPozXoWVDOUBevmP
	Uc6QzOdKg9QobzKep
X-Received: by 2002:a05:600c:620e:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-4994e70a6f5mr6591625e9.2.1785868990014;
        Tue, 04 Aug 2026 11:43:10 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:08 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:43:02 +0200
Subject: [PATCH GSoC v4 8/9] serve: advertise type capability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-8-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server and the client can handle type requests but the client won't
ask for it until the server advertises it.

Add type to the advertised capabilities so the client knows that it can
request it.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 serve.c                                |  4 ++--
 t/t1017-cat-file-remote-object-info.sh | 26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index 2b07d922b3..2ce513cf2d 100644
--- a/serve.c
+++ b/serve.c
@@ -97,9 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value)
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
-	/* Currently only size is supported */
+	/* Currently only size and type are supported */
 	if (value && advertise_object_info)
-		strbuf_addstr(value, "size");
+		strbuf_addstr(value, "size type");
 	return advertise_object_info;
 }
 
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 116862f9d0..190c45eefc 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -7,6 +7,7 @@ test_description='git cat-file --batch-command with remote-object-info command'
 
 hello_content="Hello World"
 hello_size=$(strlen "$hello_content")
+hello_type="blob"
 hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
 hello_short_oid=$(git rev-parse --short "$hello_oid")
 
@@ -19,6 +20,7 @@ unstored_oid=$(echo_without_newline "$unstored_content" | git hash-object --stdi
 # file name is hello, which is 5 characters
 # a space is 1 character and a null is 1 character
 tree_size=$(($(test_oid rawsz) + 13))
+tree_type="tree"
 
 commit_message="Initial commit"
 
@@ -31,6 +33,7 @@ commit_message="Initial commit"
 # An easier way to calculate is: 1. use `git cat-file commit <commit hash> | wc -c`,
 # to get 177, 2. then deduct 40 hex characters to get 137
 commit_size=$(($(test_oid hexsz) + 137))
+commit_type="commit"
 
 tag_header_without_oid="type blob
 tag hellotag
@@ -44,6 +47,7 @@ $tag_description"
 
 tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
+tag_type="tag"
 
 set_transport_variables () {
 	hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
@@ -256,14 +260,12 @@ test_expect_success 'remote-object-info does not die on missing oid like info' '
 	)
 '
 
-# This tests depends on %(objecttype) not being supported yet, once supported
-# it needs to be updated.
-test_expect_success 'unsupported placeholder on remote returns empty string' '
+test_expect_success 'objecttype is supported by remote-object-info' '
 	(
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		echo "" >expect &&
+		echo "$hello_type" >expect &&
 		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
 		EOF
@@ -271,6 +273,22 @@ test_expect_success 'unsupported placeholder on remote returns empty string' '
 	)
 '
 
+test_expect_success 'unsupported placeholders on remote return empty string' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		fmt="%(objectmode) %(objectsize:disk) %(rest) %(deltabase)" &&
+
+		# The hardcoded SPs between the atoms are respected.
+		echo "   " >expect &&
+		git cat-file --batch-command="$fmt" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'requesting only objectname echoes back' '
 	(
 		set_transport_variables "$daemon_parent" &&

-- 
2.54.0

