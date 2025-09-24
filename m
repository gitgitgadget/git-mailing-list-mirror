Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870126A0AF
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700575; cv=none; b=kx8mHqtsb+PxkCJP5O9pOU839XLki1u6PxP2L8pGPLN1iPnTlUsrkh6DJ+HSf3IvvFcuQ1+xXEv3quIGBoCbxhHjpuLoqpiw34HR7DcNjG1Gqj6YO2TgQ7V4rNMQoGmfQwfiPEo4eoJ9HnQn9t5ndfc/d7m3AASfBpg30C1oSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700575; c=relaxed/simple;
	bh=cvRh9J0EgW5r5/dtIRki35hDMIRsNaKOtAgHK00aZg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rOy8DAN7Rq0OzGVtJvRSyenr44ROWTx9QL0FExz8RGXzniUT7Uauf8PfobzjOt6Pksmu4V0MuD0gzpTHmbcWW8Nm8j19JpnZvkC/uFGzDCmXvtWmc3LseSuijx7pu0OUBXeREu2o6W/BqDpdtmNQ5xZ1D7GOKA42AAsay0bZaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZg52bzI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZg52bzI"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b2ee3c13aa4so362889066b.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758700571; x=1759305371; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HwETecpLv7o4xwvUUi0qGTSgiBNB3rBDpo8Y6JhJnGQ=;
        b=GZg52bzIfzmVu+7W8cIA4FWSwrgZVXUSuztO+0c9QE6i3Id+Y5Vza9zOuV6Db6KnP6
         KKcp0jKntMMPfUT/TBtUjKTx3gt4jSsJF4w3Nok2Vhza2KoGkZecvNfWxE8ZfqlTQY9o
         P2AQZjcyZLVhL9QOpZZfcddyQ45Ku74cad5PLaAjbj7bscm4ac2MP387YXixULBb4rU/
         XzUcUjpK2v6TWoYcCuRhRFgklMpJlLUBjTYitsOx9bqJGrYdW0SCRxq/ymjacVz98DTa
         9de9HMwzBIxDXqcsR9qhjOYaIJiL0Dzl/+R4o5+ulRNzbk28UYBu82j7z5I3L1qvqZzT
         vDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700571; x=1759305371;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwETecpLv7o4xwvUUi0qGTSgiBNB3rBDpo8Y6JhJnGQ=;
        b=ATUT+yK+ksAPfLG9HQw6h+R3XipzVc3eC0KBUgJwckpLE1eoQ2jza1UZTlyWlzTggk
         xMTysHd5xC70m1uJH1829lxMzslCyK3XmtigcvHG6XgL5jfbiAvJFWmnepy0FFS8P7m+
         CufrgFy0pj3/v38xFtfaHu/LoFe9HUi5NlpyP79XtpANkr6V0GApxz6+rBX/VYUq8VuH
         4tipr7WhEk3RFaVuetV+2xDvvsDnw28YlRsigSepUKAl6TUvaBsJ8qa3VG4ispfB178h
         gpErGk8m1oGwew1vddKzx80Zzd+KTHqDQqpRmUtYOwB9+FnlKExsE0NoRhqWsLdfqj0P
         cxiA==
X-Gm-Message-State: AOJu0YxdC20myQcffzCixGBZJFAJAGEEjXki8ETCHU3dVmwac0ykx6YY
	YNcAZOJHA9b/zA4NoxgWBwdITaSjvG6JHFJaqL4Nb8uPLcmeH/HKUlYDmc1lQTCt
X-Gm-Gg: ASbGncu3Y49cjIQFSJyd6Q4mxgY+hsobdBFJ+VGvKl1mc2AgT78TLJG3v8pfKbIBH/v
	8nsfqxqLSWGGW+Qy7EJZkPEPztRflOBBBS9eZ2Yl0R1R/4+7+54eCwWPVOTJuXKwm4RTP2/HeAu
	BUZPyhlRRGsQEWoe2pFzy/kyGnde2E/NVJJzdbIBXnyXQ/sNbaoo4o8B5s1s/xXX8Uo7UTVhkWf
	QSk5IXiLM8DxGnnmkoX0rbqJj23MEGz+PRQADxX1xz7eJGFyqyYYcLr6RevAXFAhkDIDJfuEQm6
	iQ30cji05WqFTaRwcAp/IQdT+9vh+Ixi4Y4qCwj0EY06Rqnx/WtgxwntQrlmOjJaxXZEsdn4ER7
	G2y05ICHy2UILXThkUPGRajV2O+4=
X-Google-Smtp-Source: AGHT+IFLLkPgxT9NYLc/fPXCXHpjuiSAaXIDZ9lrnPZTiaIbl/UicMb7fOeTcJshe2ke9SjIz7UizA==
X-Received: by 2002:a17:907:3f12:b0:b14:f921:5b23 with SMTP id a640c23a62f3a-b302b9f8e55mr561981766b.46.1758700571078;
        Wed, 24 Sep 2025 00:56:11 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5892:d1d1:ccc:7ff2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b26684bd74csm1164969766b.40.2025.09.24.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:56:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 24 Sep 2025 09:55:51 +0200
Subject: [PATCH] refs/ref-cache: stop seeking into empty directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAak02gC/x2NwQqDMBAFf0X23AeaEkz6K6WHVXd1L1o2oRTEf
 2/ocWCYOamImxR6dCe5fKzYsTcYbh3NG++rwJbGFPoQ+zwkxHTHahV6OITnDS6KUtkrWKs4dOJ
 xyhpzSoFa5t0E+/4Xz9d1/QBirT6BcgAAAA==
X-Change-ID: 20250918-583-git-for-each-ref-start-after-fba7b9f59882
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3137; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=cvRh9J0EgW5r5/dtIRki35hDMIRsNaKOtAgHK00aZg8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjTpBqw03QI2AtNokg1BcYul+Wq/0qzEznt4
 P4TgT0YVXqdP4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo06QaAAoJED7VnySO
 Rox/nmAL/ROu+LbImxs7acrcmW090zMd6NuywDt3ay/7t9s5JOsKWuF67vlz3z5WuYXJOWlCwbP
 v/pvSYplSUYO7CjyeUhK2vnyKgG9z+xo3eOrdIr0sclgV+W7MR7XeU98G7t28lh/JH0qZUUKyrP
 yMqFNVK0CQZk+jnEUblc6AAFqEKrMlZESzTB3tdiYi6gUaXUd2m9z6Gs6ilfHJ9NQO1mhL1Cu+t
 JqVHLWepQ90v3vbS57GaVR8Pe8bs1yEm91qN+vwF3b5U2j8sCeym8ry2KrxvpnsSgMtvh1dSxf8
 WQHVg6tyS4oVkUO+ouy6ussFEo1vZJgB3bFi21qv2hl4g3j8f2q8fYNiPLluzY9L4tGJh8LwZSH
 tz8zEHvKETUWSr7XapsTcEXjthUOYvmMbxCvs2oU0DT3r3lrB44OugcOR0JfD1j6/PcdMOkZuGc
 K2HOCqhFpaBDhHeaD+jE92ti9EfnoegVYKFSqzv/JGFSSPSsm3pfsU7oLKi+3jKA3+h1OR0jPL8
 qM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'cache_ref_iterator_seek()' function is used to seek the
`ref_iterator` to the desired reference in the ref-cache mechanism. We
use the seeking functionality to implement the '--start-after' flag in
'git-for-each-ref(1)'.

When using the files-backend with packed-refs, it is possible that some
of the refs directories are empty. For e.g. just after repacking, the
'refs/heads' directory would be empty. The ref-cache seek mechanism
doesn't take this into consideration, causing SEGFAULT as we try to
access entries within the directory. Fix this by breaking out of the
loop when we enter an empty directory.

Add tests which simulate this behavior and also provide coverage over
using the feature over packed-refs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/ref-cache.c               |  3 ++
 t/t6302-for-each-ref-filter.sh | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index c180e0aad7..8a260028ec 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -507,6 +507,9 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 			slash = strchr(slash, '/');
 			len = slash ? (size_t)(slash - refname) : strlen(refname);
 
+			if (dir->nr == 0)
+				break;
+
 			for (idx = 0; idx < dir->nr; idx++) {
 				cmp = strncmp(refname, dir->entries[idx]->name, len);
 				if (cmp <= 0)
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 9b80ea1e3b..d14567cb62 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -754,4 +754,69 @@ test_expect_success 'start after used with custom sort order' '
 	test_cmp expect actual
 '
 
+test_expect_success 'start after with packed refs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		git update-ref --stdin <<-EOF &&
+		create refs/heads/branch @
+		create refs/heads/side @
+		create refs/odd/spot @
+		create refs/tags/one @
+		create refs/tags/two @
+		commit
+		EOF
+
+		cat >expect <<-\EOF &&
+		refs/tags/default
+		refs/tags/one
+		refs/tags/two
+		EOF
+
+		git pack-refs --all &&
+		git for-each-ref --format="%(refname)" --start-after=refs/odd/spot >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'start after with packed refs and some loose refs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		git update-ref --stdin <<-EOF &&
+		create refs/heads/branch @
+		create refs/heads/side @
+		create refs/odd/spot @
+		create refs/tags/one @
+		create refs/tags/two @
+		commit
+		EOF
+
+		git pack-refs --all &&
+
+		git update-ref --stdin <<-EOF &&
+		create refs/heads/foo @
+		create refs/odd/tee @
+		commit
+		EOF
+
+		cat >expect <<-\EOF &&
+		refs/odd/tee
+		refs/tags/default
+		refs/tags/one
+		refs/tags/two
+		EOF
+
+
+		git for-each-ref --format="%(refname)" --start-after=refs/odd/spot >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done



