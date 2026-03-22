Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C2257827
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774157864; cv=none; b=h6/T5aBYiSHVJZXtYfV0KJ6A3mLGZJnf3S/hbTlg71HxTttx36GDi6nVZk9QLS0Up/4H6qGnkhmGe6yXuyoM9JqpkmmR89IuXzfoky2Ea0O3oU4H2YM6F5WWSCFrDy8v0K+0P7PX0K3ab2ZufHH4G4BQ12dL8sVmMK7L6RLfYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774157864; c=relaxed/simple;
	bh=TkEBjSeLmA9D4/jvjZ6fZby109ZQfQnGKggYmyCdpJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKWBwotnP9tGzeNTsj3uXrrLRATchWtAF70h2KhEKLBOQdhac65nPZbjE5ZWShJlADnRRzjDwTb3yzBAJlsFMRBOLp/s6VvsajvBwB7+jtYNKd1yvzx5Jq8vN5ggGcaOu6f4R1Tk1OCm1Jo9XoiwyUi+PWj168Y3mjhSoFGmUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUgDJSWq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUgDJSWq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b04d051664so27353995ad.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 22:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774157862; x=1774762662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5edKGnxBUhSBlPXlz7XFNeXXIB6TlES/8sCJFMMjR68=;
        b=BUgDJSWqy0JdvjEFi/2XrM0LAx6wesPlkGF7TdrUZQ7VXixbMGq2jJRXG2l0tTaXyM
         D8ZFZdTryZeJ3T2g3d20K9Fy3GfMfBimVdcnB0Dip8iX6gs4PdAbXSWiy0kZm1WKvdwO
         r2En3BhCxdH9LMmvmXyk5gt+d7eBp3m9UAvLPgPu7B5gGKEmzmqfFXvREGI4GynUx9+k
         wNzI3HPfcV9c0dgnZKFO5k0+9Eyw+QASDifvA1uzOovCY0tENt2blG+O9lI+AVRr2XA0
         g0H/zppiQWGOS18MGow3SxaxlJj7/X2LOFuVAQjbZKkRyT+yLNWUb/Kcbkoh3ehS6k5f
         +Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774157862; x=1774762662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5edKGnxBUhSBlPXlz7XFNeXXIB6TlES/8sCJFMMjR68=;
        b=fbmbm+NR7Z+dcuTgSMKVJst5sNiJcpdJUFAZH+ZO2xDQLWSESNHZryqsmRiqYf3avg
         GsTXQOqTErUOstGszNVCtcYMRH98MhLKIq/+CbD4iG3hbFTsXtTjycxR0QBONszZgJog
         S4wCjGc2VWil0meLEbQJ1sW/QshvdOoV4PvBfY1weWg6sbRJnAqzt7ytF+mGpf56+e6e
         +1pcU6YpDMt5jYKUAQzSGyEW3lC9M3d7g/f37dsJtzn8Y5wgvTUeamRCOtj77wDVE6rx
         0S0TY3TU5Il13ri0OEDbZj0/43V9714F5GD7sRCy9v0fdEBA0uvYlQF6tPdIILd8EU0+
         E92Q==
X-Gm-Message-State: AOJu0YytrNXFV6hs2cwvkxPo27yENzhtIG6JRhiR9JqiTEbejaNBtGZE
	07Epsw/H5U0wpcb6ngcZPXrA2qlbK8aCoJDxpoTyI7P1o3XGwOuUcHvYFK2jMQ==
X-Gm-Gg: ATEYQzw8rSOzpDVJoTn16i+R1R1pynE0NjdnHryw0ui0mleG2Xa5dNK0DFpEffGq8ru
	F4PnknfnfujmeTEXI7d2EQCyFubEvsRFe3hmOh/jjo8uphGSqKiLdstG7qUamA1rp4cUW6QPYPh
	l+l1yJc9pbjEF3wuHZrQzVMiNAZLY9k0Cp0XAuAAO40bvM8mY854ePe+vhuTsI9azT4s8hwD3bk
	5Ydeo9WB+Hr5z5n0TtF+WVy7kaidslUEK++0rhu2aXZ2GR4t/FUrw0wpAVm1ZDQ+nRM7piWeBGI
	4aiZPHgUF2lTQ5pHR4mG30jobSadsVrGBkN4KeLuH4GWXsGmaUt9GTQVz6DI2LKN/vKcAAin8Hq
	JjzJ+O2ZAy+fBt1DZR5bZVscdM4e7eKA37kaDoZWu+RI3CxfF2+R3snB8jPfz1D+9vkRjk+mMNv
	qwh7Hsf0Czs3rl+qeYx50fE4Iaj009U+VkFRwn/hRkDTIY89w+gRRY2ts9K1eqrxd3MQcR62hBY
	NuD/v2c6Qo3AOHqj6fTbmsdyg/pUNMKIQ==
X-Received: by 2002:a17:902:dace:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b08271a32emr81746015ad.17.1774157862258;
        Sat, 21 Mar 2026 22:37:42 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516194sm67928745ad.4.2026.03.21.22.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 22:37:41 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	joliss42@gmail.com,
	joliss@gmail.com,
	peff@peff.net
Subject: [PATCH v3 1/2] refspec: safely parse refspecs outside a repository
Date: Sun, 22 Mar 2026 11:06:16 +0530
Message-ID: <20260322053617.38951-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
References: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-remote-http is invoked outside of a repository (for example,
by running `git ls-remote` in a non-git directory with a globally
configured fetch refspec), `the_hash_algo` is left as NULL by
setup_git_directory_gently().

parse_refspec() checks whether the LHS of a refspec is an exact OID by
evaluating `llen == the_hash_algo->hexsz`. With `the_hash_algo` being
NULL, this results in a segmentation fault. The same NULL dereference
exists in the negative refspec path.

Note that builtin/ls-remote already works around a related issue by
setting a fallback hash algorithm before calling into the transport
layer (see 9e89dcb66a). However, since remote-curl runs as a separate
process, that fix does not help here.

Guard both dereferences with a NULL check on `the_hash_algo`. When
operating outside a repository, fetching and pushing are impossible
anyway, so skipping the exact OID check is safe: the exact_sha1 flag
only influences ref prefixes sent to a remote v2 upload-pack during
fetch, and we will never reach that point without a local repository.

Reported-by: Jo Liss <joliss@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 refspec.c                   | 4 ++--
 t/t5551-http-fetch-smart.sh | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/refspec.c b/refspec.c
index 0775358d96..a864a0bac2 100644
--- a/refspec.c
+++ b/refspec.c
@@ -84,7 +84,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		 */
 		if (!*item->src)
 			return 0; /* negative refspecs must not be empty */
-		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
+		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
 			return 0; /* negative refpsecs cannot be exact sha1 */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
@@ -101,7 +101,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		/* LHS */
 		if (!*item->src)
 			; /* empty is ok; it means "HEAD" */
-		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
+		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
 			item->exact_sha1 = 1; /* ok */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 73cf531580..a26b6c2844 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -782,4 +782,11 @@ test_expect_success 'tag following always works over v0 http' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-remote outside repo does not segfault with fetch refspec' '
+	nongit git \
+		-c remote.origin.url="$HTTPD_URL/smart/repo.git" \
+		-c remote.origin.fetch=anything \
+		ls-remote origin
+'
+
 test_done
-- 
2.53.0

