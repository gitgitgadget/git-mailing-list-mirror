Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8E154BE0
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571462; cv=none; b=VfGH3e6aIIEd3mRDnGCELV5Ez0DJBRQV0cyF3eV5P+dWNJWY70iqSyRNCwgw9Yrqp+j7UyoJEp5lemhRPo7TpJelLm3DqwQmcxQ7MGR1T1m2zOKrKBgDB+lPIbAJybMI5hPggrahrLMPmIRdmMe/LGkldodUVMf+7+COpGxVszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571462; c=relaxed/simple;
	bh=Ia3VdCJAl+tvsZFoGc4a2cv+8lT9g1tLaWpQvrNoiRU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A1+JHAw7ApOBR+ekfTLPkb3HRsETCVoJocLWS4u2Y9GwXwox1ccKX58W7lfvmyoppWSsnUHWMRWzps82Xk41PQm3V3MwmBJS5tuThDvddI3OM7Mb3zME0kaTnJKl5WOJFzBH13sa9ODSsnaJUhTvU9+jtznscG42qTHjs86p/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejzRv6QM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejzRv6QM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaecf50578eso661847166b.2
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571459; x=1742176259; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKqA8K5adWm7NBQOKNe2jOymMNywGXQ3UlVChD6gO60=;
        b=ejzRv6QMybxaPq2it8PiT981Pdgmah0WZMl/fRelo5xbHNOIgDj5K8EDnP+9JXLymf
         qTn96f99zk+oIqglT1KW+THrvPzhDwMl684KNbF4iXnu8DXwus2y76Ld0JQYidoo/any
         WAoBxW47dCMkN5XSCr/5s+E84fXcKQaemn7Ivkiw61LzQpD5BZMiBco/9cgmecagVBav
         bpTZKYfFfXxko1w8Y7wg8IWJhQ6J0pQkvDlpJxt25fVlF9XFhifAj5n2g3R+NSOP5x6/
         q6qFqPnDkxMKegI51sFVilkcoD7QT7TB31nP6wKlMEfxw8ChXc1gwitz3EDBdf454AZT
         /cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571459; x=1742176259;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKqA8K5adWm7NBQOKNe2jOymMNywGXQ3UlVChD6gO60=;
        b=h4F0NC87/G1gELYMWnUQLs9zSaU4lk9sJgKsNi64DnSC4mDuoLj9pItwGiPQUG66X4
         wsuROhJR4g038dMUjkkW/4HQ6ZNFA1x0tgVYYZMqfMmvUFKQ84LPR1WU5JaA+j3NE74D
         0eWjnybOm7ndbPkK0JgFqXz0rPeZjpLtdUCORVaLhPkjQ53DOWxn4CYEwsSE37zarKd8
         JsED9k0+Qo3QE4GhgBfCk+h663IwiuzOfcfjDeElok+3eTvs5msUjQmjb7IwpXOOM091
         e1MjLOWUUCDVJG+oCwB4qc2dxLwam9aXmj3W3PoTUwRbRkQxSg0gwXqDRVsxssh6OasU
         D24Q==
X-Gm-Message-State: AOJu0YwE223Py/VGx4ZXPXA04h5cQaTQ3ByFOBeVE1KazlUwHPOeY4Pb
	+/NEo4Bq3kwn5RjbvWsyr1a/+tH7q4J1IQHpSIJyzpURgTfguiP7yRirIg==
X-Gm-Gg: ASbGncskwrt/o4xpf4dY2Od5+YEy+MEUzCVTbnkQrDjtX5gF540geT2Rjk8cXeoFSBl
	KAYPbXzXjn/8CZNy+lbs8RT4u90fCiZ5g3D8zmLo5wCFKKaYA+btbb4tEe+p93ntUADoA7KlFkS
	0OKpoQeqFyNN1WWc3iGyctuNZr5RD/Lh6VQtKVI31fLfjuPoBaIbqtjwC+bLmQbG5WXu4r1aun1
	k55o1jbzyDlm0Q3MBHkBMnMRJvEZG6C6Onck4OBS+qecJ03/vmUgix7zaIkrWXFR2f8OGiwUheq
	1xDbuFDiJTtvM8ROtPzcdHTaFFJ933huntiRXpc5Bhmmkw==
X-Google-Smtp-Source: AGHT+IGchWy2JLtJPvDTo/emUplrN2LCbhhXA24fpAqXNOIQV+xMFZ4vgOfzlqKQiaedsRG2uBd0iQ==
X-Received: by 2002:a17:907:1586:b0:ac2:7cd1:3aa0 with SMTP id a640c23a62f3a-ac27cd1416dmr573286266b.57.1741571458827;
        Sun, 09 Mar 2025 18:50:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac297b723ecsm152707166b.77.2025.03.09.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:50:58 -0700 (PDT)
Message-Id: <bc678acb109c34ac96c641c5e6fbfb418e447010.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:45 +0000
Subject: [PATCH 03/13] pack-objects: update usage to match docs
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The t0450 test script verifies that builtin usage matches the synopsis
in the documentation. Adjust the builtin to match and then remove 'git
pack-objects' from the exception list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc | 14 +++++++-------
 builtin/pack-objects.c              | 10 ++++++++--
 t/t0450/adoc-help-mismatches        |  1 -
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 7dbbe6d54d2..ad765334729 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -10,13 +10,13 @@ SYNOPSIS
 --------
 [verse]
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
-	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
-	[--cruft] [--cruft-expiration=<time>]
-	[--stdout [--filter=<filter-spec>] | <base-name>]
-	[--shallow] [--keep-true-parents] [--[no-]sparse]
-	[--name-hash-version=<n>] [--path-walk] < <object-list>
+		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
+		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
+		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
+		   [--cruft] [--cruft-expiration=<time>]
+		   [--stdout [--filter=<filter-spec>] | <base-name>]
+		   [--shallow] [--keep-true-parents] [--[no-]sparse]
+		   [--name-hash-version=<n>] [--path-walk] < <object-list>
 
 
 DESCRIPTION
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5596c409927..fe23db3c5d8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -187,8 +187,14 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [-q | --progress | --all-progress] [--all-progress-implied]\n"
+	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
+	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
+	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
+	   "                 [--cruft] [--cruft-expiration=<time>]\n"
+	   "                 [--stdout [--filter=<filter-spec>] | <base-name>]\n"
+	   "                 [--shallow] [--keep-true-parents] [--[no-]sparse]\n"
+	   "                 [--name-hash-version=<n>] [--path-walk] < <object-list>"),
 	NULL
 };
 
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index c4a15fd0cb8..06b469bdee2 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -38,7 +38,6 @@ merge-one-file
 multi-pack-index
 name-rev
 notes
-pack-objects
 push
 range-diff
 rebase
-- 
gitgitgadget

