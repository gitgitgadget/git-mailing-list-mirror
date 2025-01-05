Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792129422
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736085026; cv=none; b=eu7O6tJX2lCDa3p/OqxTJkEMYei2s/4dnhC20AwUPXLrSWRLUdndxyhnK6Lf5ryieBB9mCQ/W5TfG+zlDVsiHMRPZV7KEdh3cPrPaL88qrwBECMK+WH20jlM1nkTFMsGt7TVKcL9+NflGB6DvqvlaDGC0mfLX907CbrkyUkQKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736085026; c=relaxed/simple;
	bh=MGBAbfPXQMkaj71bQvQb3M2OJdVad7Sve0TmRZ99xQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZNrxS9gKxSkeat/S2YAhlqamPmBYx8sLp9yqfjAoLAfTCTzu9k5OhuJOS1NoMHcoB3QJ5bc940PSmBndgohvLGnFG2Y6ORRTOixd32SBUUx3vU0c42vOSmW5emY0GhmdiBDLlAl0Gf4bwb0+7ch4BzQGpKpkHp6TW40mJcc4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYbZhVhz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYbZhVhz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166f1e589cso234091315ad.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736085023; x=1736689823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0olQPNWODyaICpwvuNCYPEwqsltI4AxpVg6U27nxNg=;
        b=hYbZhVhzpmO2l1T1epdMPA7dWkEayZE7kZjd2gOc0Q+OJPatmB8FLsmPpPaWQPT1x3
         L51dYe2Ic8Lvef959gT8uuLnMsiJI1fBK6eT6bWvPNbtg2qGynJCBVsMAb24lY9oLYeS
         HOTXbA5ciM74NCTCSLYR/aiE17SpPPvIH6u9fHJo5mz1qD19PwR6nnJ2McUK1kp6v7VZ
         6G0i6/3DbLvrrBiaMHrOTU4ZrLSb4NgtQz/DrWBpE3yEuovLNYaJ3y2WyRw8/oJ1WkbX
         1qciJeX8gbMj8/d44Oz3MdiPABazglBT3r4C2rNHTP6Ou6K5cDy+PqPT24kYHp3Nim8e
         5n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736085023; x=1736689823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0olQPNWODyaICpwvuNCYPEwqsltI4AxpVg6U27nxNg=;
        b=dRE0wUjXRNs5WQ/omGWMnyhygcyW0trZFB2QW1539bKE4CGMjiUb40hOfTpWc+fGbX
         +7esmO7gasnx3eH4AncuGQ2S4D0msoWP2r9r+5EnG2B9uhy5LKHiPh0UXGtO8rwcnie2
         anuAHRal+6fvPspGkB6gPsYhJNB06ueUCmp4vJsBbbAOhP3pBR5K2qsMblbqU6Jhmes1
         RIoDO3BcFm7q5VRUkhUsU55v1FaQO4rcD2HtplgXHNzxXUKXp7fDjprW+TO0I/gT24mX
         iQWK9l8miNyrTjN5PwU96qLQDnXuVyqBhLeyKRb3zu++1S5CtBug3wOlDqV34YpeUw5X
         vLMw==
X-Gm-Message-State: AOJu0Yy2UUyI5YSB5Kd6Kjmm+ClQEWQUAzY0fKV43w68rg00f8POAPMV
	3c0zB/mcOt55mW0vDb907/z8K3yx+vgMewXwzrZS1cnmAxDlL/p6sV3iZw==
X-Gm-Gg: ASbGnct3NFPAxTdpiWjCVH9FmXRJq1m5w1DuTWDECFWYVQtTuVpgR8ZXJv0KfaKEH0g
	XZmV9Ih5Vv+PAzmCql8rlEYvihO+gTi9D32yWKRJh1N4PDOy4Y583JKcdsZFE0P7/JgDdg9/2ln
	TQRROrZCgqHQXvThoAUEBRcI0WIe0mnr57BgxNIlpdq/s1DSZBerp2HDTGqrVDPwI/F2R2fFyWb
	p8i3K7VYlulgDSq1i8UlCtM++cnofwRyeU=
X-Google-Smtp-Source: AGHT+IGWjISzYlfGG1eHwSWX5IcVXZ3t6R1eZHbsr/Vws2RPhuwLBWJx46vsvyPYbN6bgP+xw+kM6A==
X-Received: by 2002:a05:6a21:3a82:b0:1e1:9f77:da92 with SMTP id adf61e73a8af0-1e5e07f0057mr77917194637.33.1736085023261;
        Sun, 05 Jan 2025 05:50:23 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb09sm30406177b3a.121.2025.01.05.05.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:50:22 -0800 (PST)
Date: Sun, 5 Jan 2025 21:50:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/10] packed-backend: add check for object consistency
Message-ID: <Z3qOGzfncHlnZOGY@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

If there is nothing wrong when parsing the raw file "packed-refs", we
could then iterate the "entries" to check the object consistency. There
are two kinds of ref entry: one is the normal and another is peeled. For
both situations, we need to use "parse_object" function to parse the
object id to get the object. If the object does not exist, we will
report an error to the user.

Create a new function "packed_fsck_ref_oid" to do above then update the
unit test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    | 50 +++++++++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh | 35 ++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7386e6bfce..d83ce2838f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -13,6 +13,7 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
+#include "../packfile.h"
 #include "../statinfo.h"
 #include "../worktree.h"
 #include "../wrapper.h"
@@ -1933,6 +1934,52 @@ static int packed_fsck_ref_main_line(struct fsck_options *o,
 	return ret;
 }
 
+static int packed_fsck_ref_oid(struct fsck_options *o, struct ref_store *ref_store,
+			       struct fsck_packed_ref_entry **entries, int nr)
+{
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct object *obj;
+	int ret = 0;
+
+	for (int i = 0; i < nr; i++) {
+		struct fsck_packed_ref_entry *entry = entries[i];
+
+		strbuf_release(&packed_entry);
+		strbuf_addf(&packed_entry, "packed-refs line %d", entry->line_number);
+		report.path = packed_entry.buf;
+
+		if (is_promisor_object(ref_store->repo, &entry->oid))
+			continue;
+
+		obj = parse_object(ref_store->repo, &entry->oid);
+		if (!obj) {
+			ret |= fsck_report_ref(o, &report,
+					       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+					       "'%s' is not a valid object",
+					       oid_to_hex(&entry->oid));
+		}
+		if (entry->has_peeled) {
+			strbuf_reset(&packed_entry);
+			strbuf_addf(&packed_entry, "packed-refs line %d",
+				    entry->line_number + 1);
+			report.path = packed_entry.buf;
+
+			obj = parse_object(ref_store->repo, &entry->peeled);
+			if (!obj) {
+				ret |= fsck_report_ref(o, &report,
+						       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+						       "'%s' is not a valid object",
+						       oid_to_hex(&entry->peeled));
+			}
+		}
+
+	}
+
+	strbuf_release(&packed_entry);
+	return ret;
+}
+
 static int packed_fsck_ref_content(struct fsck_options *o,
 				   struct ref_store *ref_store,
 				   const char *start, const char *eof)
@@ -1986,7 +2033,8 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 	 */
 	if (ret)
 		o->safe_object_check = 0;
-
+	else
+		ret |= packed_fsck_ref_oid(o, ref_store, entries, entry_nr);
 
 	free_fsck_packed_ref_entries(entries, entry_nr);
 	return ret;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 7e8b329425..faa7c80356 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -730,4 +730,39 @@ test_expect_success 'packed-refs content should be checked' '
 	test_cmp expect err
 '
 
+test_expect_success 'packed-refs objects should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git tag -a annotated-tag-1 -m tag-1 &&
+
+	tag_1_oid=$(git rev-parse annotated-tag-1) &&
+
+	for non_existing_oid in "$(test_oid 001)" "$(test_oid 002)"
+	do
+		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
+		printf "%s refs/heads/foo\n" "$non_existing_oid" >>.git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 2: badPackedRefEntry: '\''$non_existing_oid'\'' is not a valid object
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err || return 1
+	done &&
+
+	for non_existing_oid in "$(test_oid 001)" "$(test_oid 002)"
+	do
+		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
+		printf "%s refs/tags/foo\n" "$tag_1_oid" >>.git/packed-refs &&
+		printf "^$non_existing_oid\n" >>.git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 3: badPackedRefEntry: '\''$non_existing_oid'\'' is not a valid object
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err || return 1
+	done
+'
+
 test_done
-- 
2.47.1

