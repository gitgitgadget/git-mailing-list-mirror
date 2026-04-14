Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC013E6DC6
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171593; cv=none; b=Dw+JqYtFc8fYC9Ah4HW+a+0wnMG147w479y3i/U32tCAY7hto2IOoDkd65sqakBBkVy82Y7mlXCBa28GUyLPzDiUXV9FpdWUmR3ajxUqxKYepSl78O0XgkKP8V4Wk4gxvAkRmZZVuS/Jh3sxjiUwoUa+awNTzVuyfvnPVo8pKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171593; c=relaxed/simple;
	bh=A0XD0n4OFokueXWxrNcSEAUBKoYote9MDrPHFewiPj0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AgHTVdqI0REivo6tHHQgkdXeabmvg0kcqeqofk+tFw/0VBha5oAH4xspj3GNvktXQdZ9SGG4brv+Dee3SuYuExEmrPOo98zwMOeQ3zAvGAfKsF6iPgcN6xR8T3Z+clOD0BlCTWkXd75e0ne2s2D/+rL3RILQvO4m26ivPqS4sg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewzyua8X; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewzyua8X"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3bae8d3eso479467885a.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776171590; x=1776776390; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdVPWllyoGBvBeMKXEUIPun5SD499w+Ae9s5uV2R7EU=;
        b=Ewzyua8XiRG2+9s6OvJwCKkBbuSADYW3tI9bozQj9PslY4B81g5j18Ra8MgNnjhVBm
         xa1YCCsMWfwBsWkzR8kF9mSAw4v1pMICPao8OmNJQr6I8mFJ2VDSWVZNAqh3Llims3cV
         HPN9XqK3X9PiG/wbFktqQXrnVV5obiCgDOSdYMnNwwD5dM0w+WUoeK3Uok9uXA0vvMUM
         t1L/bWDFVe6QxdqYWwmAqShdeR6rhHiZkkVIqMhIpb2O/L9pnHlVO46vWwJtulyyNJ0s
         WOevdk94mPhPAmRS/bW6ekc0CUGr6i7/mb1H7A09nnln6ZID78G2V9P1N5HzV5YtpPOO
         vIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171590; x=1776776390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdVPWllyoGBvBeMKXEUIPun5SD499w+Ae9s5uV2R7EU=;
        b=Tfyna1e0eSflasI2RWktvIOZTkSRS4h947xrC+TJtI7NRg71CqANfXoNjV2eJRN85g
         2U7wdV0U54uW+QjOLbfGY0ijs3OG14baRn0KPg2q9xobENR9LL4R0wwAae/FN6l+nDUY
         T8NJhuQIOkc8j8e6EV2DEGY0iMPznjNGnXeW227hQGPn9DeUC6gpt6DqIucoXK0rVjHJ
         9IQEzNEk5IA77UltfRL9pY93uB+YA7shqow1hkyw+ZKPp6tV5tv3Zn5vwM4A1Ll0OCOB
         6IJ/B7f44KlSItUJovZgQtHhXUQfZy54kYT1QfxVGS+flPYhPUiuTZ7JCGh+i5RpMPBU
         siQQ==
X-Gm-Message-State: AOJu0YzdCIvvaxdjZjV59QqjCZ6gPyRaK3CZVuK6xlVGFgGpE+VzkPm0
	TII5WCV+8SXtfgWdbdKiqnXio7h6twF2ulgrfn6A7diTA8YCpy2MpRZZvK8u3w==
X-Gm-Gg: AeBDieuqJ5UrSF70wuMaj2929NhffXPNpPd9269m5sBvt2Ty1oSzZjp4IpSJvKH01Ry
	oPB2EkxOW57P0dnkSJJPR/xVHSQT/M6qP/5WdT2b7j5WIXyeBgS2JyxaoewIqIGkGattE6LNZ7l
	iW1LRJSWcd6sMSyVxqJx39evEUjzs30ltKLaWJkghKzYwtLDVYpt6bQ4f/E1Zjt5F7+wZqQCYmw
	eEGGLSRi0z1yZ6HkIMhgnm2LPemkLGdtrE5SOHoe+N75vS5JnhWODQyoUzFH/UvephccwC5OwMn
	b07VcRytuu/ShPKxMXge9V1rhv8LnVUdroArmz3GhQNCNY2z68nMbdYz4WloPNYE59nVN+gkJGB
	796ctbl86aXCCDFnhiSz2Q6p/NuPBBUDoJO9+8i5mSjdAl+1OHGDWyssmIhf3Qq1zom4LESSMTr
	0jQJv5CosfFT4R91ywSsYKR3vbJiI=
X-Received: by 2002:a05:620a:2685:b0:8cf:d65d:adaf with SMTP id af79cd13be357-8ddcefc12damr2407047285a.30.1776171590352;
        Tue, 14 Apr 2026 05:59:50 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f8886csm1048079285a.6.2026.04.14.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:59:49 -0700 (PDT)
Message-Id: <e11a622bdf4752273dc2de26f3108d329abb04b3.1776171585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
	<pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Apr 2026 12:59:43 +0000
Subject: [PATCH v12 2/4] sequencer: allow create_autostash to run silently
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a silent parameter to create_autostash_internal and introduce
create_autostash_ref_silent so that callers can create an autostash
without printing the "Created autostash" message.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 20 +++++++++++++++-----
 sequencer.h |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..780628aab4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4657,7 +4657,9 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      const char *message,
+				      bool silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4679,7 +4681,8 @@ static void create_autostash_internal(struct repository *r,
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
-			     "stash", "create", "autostash", NULL);
+			     "stash", "create",
+			     message ? message : "autostash", NULL);
 		stash.git_cmd = 1;
 		stash.no_stdin = 1;
 		strbuf_reset(&buf);
@@ -4702,7 +4705,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4714,12 +4718,18 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, NULL, false);
 }
 
 void create_autostash_ref(struct repository *r, const char *refname)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, NULL, false);
+}
+
+void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
+				 const char *message)
+{
+	create_autostash_internal(r, NULL, refname, message, true);
 }
 
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
diff --git a/sequencer.h b/sequencer.h
index a6fa670c7c..5d3bc83314 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -230,6 +230,8 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
+				 const char *message);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
-- 
gitgitgadget

