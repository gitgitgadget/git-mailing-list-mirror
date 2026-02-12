Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88E2DAFD5
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890950; cv=none; b=QrGuqNkdrhvm2E0ImNr0kT1QdEuInZSas30uCXhvWvOMAP9pIcsfzNYtI3ScAyBfRrhS+aar9VHvgD2TeNRXZlET5obPcCrGYHn8J0zKUhSh6BwZkKkDLg8sdM3nb7dodboGL9hX0ajsNwtifyMYlAEH6J4Hv+o8yPsss6taAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890950; c=relaxed/simple;
	bh=T3SjXAIkIFeOZYpgSpArR1gWODtBp9c5g5AcLC7WVxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDar/xDJTBaNjyQVyv/yc62zNVimF0r1jfcIs1BKJ4whX7lTfV+RZ8eMljQNDkfzRmOm6mlhSIBsxoL0h+PwJ45d0SxPjfmYhFj1F5i+fSBn0vqBLlTZutk+7s2qnuzFd8qnUAFhUG83CYz08TzjMOaC/M8qrWJu/aB+MIVv0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU+cAfJl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU+cAfJl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so2175990f8f.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890947; x=1771495747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZygoiiD9/8pd8EE8ituW4a56W9Oj2fDUwK1t1ihqMs=;
        b=IU+cAfJlJQlnVcJ2yZyCkHHftwS8kOPex2Zko/EnaGTglVsPC6SHTTGKqLWc1oQR/u
         9qfcQ5yt1BYZacKjxRrVoR2KLWFGnPzO3cPnCxS8bfY7YNA2suasSwtdn6nqpLvw5Qqj
         TM2APKLW+odYEu16+JC2XzJlA1h0M1JD2OLUKtvwmkd6OhsajbrhwgpK6VLWomfJzqzu
         +glYS1EeZ7mrpr4oOM/GB0HgtNnaAb0YieanjXNMhGrhRvVQXP9XET6yE7HED4GKP46M
         sF72eDSjfEYxmK9Ys2UUq4ZwK2on1e6iOZNUzu88N3hRIVIwLWyd/zHHtjm3ruBYbywt
         kTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890947; x=1771495747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZygoiiD9/8pd8EE8ituW4a56W9Oj2fDUwK1t1ihqMs=;
        b=WhyffIVUmjyfISQCqSGzl0x2EuScNP+mESlWn/7sK94WGt1aw4wu+wZsasziyazyYn
         B/gc6a9ZcCZ1hxzjDlUlfZJdeFBg816G8jOfytANnAUFH4ffxSbGtQgDJ6N6HyO3WYnP
         hYmev3vYjtj40mpGYyyswAhofvIKGPISlIQ6uwYOGvNxK6MrKloZil0qAfc676/hGCAj
         ZNibmmFqvvS2Hh6Vy8gWFtpNccSNGiUkMcFfk3yXRuEtR8GtoyE436rrDbyCW3yA2BfY
         cc/L0j3DmMaRKsaK0Lfg4f7xQ4DQazgqkfjZtkPvu+ZdALBvj1tvqCy3JCia67Fgawm7
         gOwQ==
X-Gm-Message-State: AOJu0Yy1gtgtQ7wEIvUv5xgD2btJCw98a3hUcf+JWYp7LI8NMe+ubYAk
	Y7NfWXb6XRizys+SU1tE5v3bKXbzp0QL9T6zK9ag/UD4886wGTjlaZKRrdc+rA==
X-Gm-Gg: AZuq6aJUad7GUhpMS67g8y1o9mla3xJdfPjoX+LPxRfNwfAluk2reTTYUmluQvQ22z0
	QuAh7+zd+1UB/aq6j1QFriauXa55VarVXORO+Ki9iERB0tPEVKYCaxb1qWHHYmei2K5vFkL9rbe
	81lqgNKNE+XxAGISnuWilBNVs8dRuFpVXdR2CdiKbiFUun1pRjjMaPBdTSpBP1DQAXRYjgJZ5Vo
	KvNhexkB1lbPI9kWbI16Z72AAXOKhnNr458cmj1fzm0jrXoOOHxdcUIdDuywC5yE3owi40eWHxG
	3oSaZ9MmY+DrQlJ4tUQZ4rShrKKwxwCoUAkMmVKymwF/D/GtX/Xkpb89LRQ37ieMP34WFHgL+sC
	2JhfH0+RCvBM0xRphVJ7CVPkhj1R38EBLV3ORkMQ/qT+qrrUCObGDnfD3hkqGXJQnt7pi/cjM9V
	2OChSB6EqtcHfRykItqZ+dmHd7tMf0Dco7LEqN0Z9oJPwHZqsBD09c7pBawYOQTYhVSq+plK1or
	yeGWSBBMH/HnzW+DoXrlJWrQz39iB24sf8C+hS4JwdKDcaPGw==
X-Received: by 2002:a05:6000:2913:b0:437:69c0:9619 with SMTP id ffacd0b85a97d-4378f165b68mr3102188f8f.29.1770890947091;
        Thu, 12 Feb 2026 02:09:07 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm12701151f8f.5.2026.02.12.02.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:09:06 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/9] clone: make filter_options local to cmd_clone()
Date: Thu, 12 Feb 2026 11:08:34 +0100
Message-ID: <20260212100843.883623-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.70.g3d1fd9d397.dirty
In-Reply-To: <20260212100843.883623-1-christian.couder@gmail.com>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `struct list_objects_filter_options filter_options` variable used
in "builtin/clone.c" to store the parsed filters specified by
`--filter=<filterspec>` is currently a static variable global to the
file.

As we are going to use it more in a following commit, it could become
a bit less easy to understand how it's managed.

To avoid that, let's make it clear that it's owned by cmd_clone() by
moving its definition into that function and making it non-static.

The only additional change to make this work is to pass it as an
argument to checkout(). So it's a small quite cheap cleanup anyway.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b14a39a687..bb27472020 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -77,7 +77,6 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
-static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static int config_filter_submodules = -1;    /* unspecified */
 static int option_remote_submodules;
 
@@ -634,7 +633,9 @@ static int git_sparse_checkout_init(const char *repo)
 	return result;
 }
 
-static int checkout(int submodule_progress, int filter_submodules,
+static int checkout(int submodule_progress,
+		    struct list_objects_filter_options *filter_options,
+		    int filter_submodules,
 		    enum ref_storage_format ref_storage_format)
 {
 	struct object_id oid;
@@ -723,9 +724,9 @@ static int checkout(int submodule_progress, int filter_submodules,
 			strvec_pushf(&cmd.args, "--ref-format=%s",
 				     ref_storage_format_to_name(ref_storage_format));
 
-		if (filter_submodules && filter_options.choice)
+		if (filter_submodules && filter_options->choice)
 			strvec_pushf(&cmd.args, "--filter=%s",
-				     expand_list_objects_filter_spec(&filter_options));
+				     expand_list_objects_filter_spec(filter_options));
 
 		if (option_single_branch >= 0)
 			strvec_push(&cmd.args, option_single_branch ?
@@ -903,6 +904,7 @@ int cmd_clone(int argc,
 	enum transport_family family = TRANSPORT_FAMILY_ALL;
 	struct string_list option_config = STRING_LIST_INIT_DUP;
 	int option_dissociate = 0;
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 	int option_filter_submodules = -1; /* unspecified */
 	struct string_list server_options = STRING_LIST_INIT_NODUP;
 	const char *bundle_uri = NULL;
@@ -1624,9 +1626,13 @@ int cmd_clone(int argc,
 		return 1;
 
 	junk_mode = JUNK_LEAVE_REPO;
-	err = checkout(submodule_progress, filter_submodules,
+	err = checkout(submodule_progress,
+		       &filter_options,
+		       filter_submodules,
 		       ref_storage_format);
 
+	list_objects_filter_release(&filter_options);
+
 	string_list_clear(&option_not, 0);
 	string_list_clear(&option_config, 0);
 	string_list_clear(&server_options, 0);
-- 
2.53.0.70.g3d1fd9d397.dirty

