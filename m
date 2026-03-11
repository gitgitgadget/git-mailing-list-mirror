Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59D31714A
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235264; cv=none; b=cu0uMx/TUJM0aAmp7MRwTqWk0qshsm8udu7BgLOkDx8kUnK0zOeq+ks4LumCZkjyRjUu2jx4MxVnU7GuHAL+Mpm/xVOu6fjg/4+ZQrtPYYvosGsBPs9K6Rg2B1CJOmescnbVCoVO2fRu2m6LJaLQtlOffkUWrTpLO9k6fyzSCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235264; c=relaxed/simple;
	bh=YzVTJ2qkcCW798ReYCEl9C9Fd57XGz3b/lXKD2tfyEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpZYNQSdiV5JY1TqN7kWOf78SxijOkxQkpFLgxtmx2T+sLKQ+CO5h52zfeud/SHPLKqTPGB+KbvYTVMcGorFZa0ypBwqPeawEMUBh2LGQGPW6dNQBzWjxBDP/w0gzLuWc/RtlPs/GBhI0jCYIMfPK0ss6SyZxvacyEAkh2CX6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsnCijWu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsnCijWu"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-359832fc558so8585721a91.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773235262; x=1773840062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5neS2mcZvrJJHC0KDRAwEQKsGZqQQvTZLtkKC4DzYn4=;
        b=YsnCijWu6fMpFiqj+0wYDf+bQEy4J84WfvLhNkvDFzp8Z+OXDKX7Bg1NC4enX75024
         4rrf8EvC8OUHhfFJOeoJyXiYaxhACkBM58ksqQAl1INaumnYXSDsqAClnfUE87eOgD8a
         vg8pEFQYU+Ov3tdHQj922c9FaUPVo+CP7mkNPFQB4nIeu2/7yOn+CogzkSD7F6BORaXU
         cYqo/jWFVAKc0oWU6ybZ3jsFQiGRC+y//OjltzreLZ6bZzMusL0ZxOoLNkDnoc+zNG75
         j5onIErXFqEZ7lZ9sOX4eLgjfoZguZP68g0/+3G2Y1r9P4UYT8sWVNI8SLw+q2Ib/ODP
         BY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235262; x=1773840062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5neS2mcZvrJJHC0KDRAwEQKsGZqQQvTZLtkKC4DzYn4=;
        b=pYuR0VTg9MYlWoz3Nhpn6ZI/3x4bn1GG3tKAQgpax1S6CTp6MLimsWxqtldYsvgUKP
         eFR6EMgWdJ0fL4lqdGgs/ZAC2hvMfKrlwE6UXdddITRUMcltnO2WcJVpIEFEzOlTW7/g
         mFlXefl1nm8llUUGRtGg5YnYlg5pRD54kSskMB45Hh32y6N/vmuDVzElysuohB9QUNUS
         Xpvlcr6gMVOBu56+R4NMAVW/mMeWW+owd2f3GhzhcoRTD41KBjrTLhkTan9EEA218liK
         N43FaCqL8iJC5FlaAoEgeiUlVj9VVJgfRUBHvPw8yyrSAVEYL13G2Sf7FBd6wCqNdtaE
         ZLYQ==
X-Gm-Message-State: AOJu0YzczwZGrfWMMrMx3KC/em9FadNwuQ/vt3MjUI15+2B1j/B3z+jr
	jaH4/RzNC97t+JdZlYPf8eph11N53F8dVtVpXSLf7+vMb/G7yIeByu4MI34Xxg==
X-Gm-Gg: ATEYQzygWygERdc0Qdok5TOVL8QFPJoAFNUXENDwKbEbtwmjl1XyN5hI1r5gCd6gvNF
	2H4vfnu2XX2TYlLZOCGiaCmymaVnEEIbHePiOpb6wfS2YAPbcR4qc8SHBdElwXtZ8GU31FyEuNc
	l9ZunCLlgb5ZnnoCHQfm36ZHcrwz/q9M80UnSnVRF3UQl1R3D+/sAhpHPI2dwFD9pdZLCqUI1+N
	/gbzkhx7L/dN3BaxKxBzbToT239OCXFXAjr+hPkGABYK4WRy6oqqnISvF0rEqQTpJ5e3A1T0vNr
	eK4BWASXbG1lclDB1G7UtJ5IMe1dHH9vSrlFIsHIz87DBzt23jSJvkawrY7tlpMuf67MRWfWmTp
	nEcbRUc8R7fqbVjbFf0oBaxtlBVYCePDs+scs+gCH7KQ52d+pif+0LUDK6nTRB923ajbYNkPHlU
	3mbwdWSpGWYVv8QDLQs0Mz4PhMX5JflgulSptx+4UI9T5BAb55+rsgo83thOx/VJwACg==
X-Received: by 2002:a17:90b:4f4a:b0:359:8411:a40 with SMTP id 98e67ed59e1d1-35a00f23012mr2693929a91.0.1773235262491;
        Wed, 11 Mar 2026 06:21:02 -0700 (PDT)
Received: from d.iiitdmj.ac.in ([14.139.241.214])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf92fe7sm2281441a12.21.2026.03.11.06.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:21:02 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v2 2/2] list-objects-filter-options: avoid strbuf_split_str()
Date: Wed, 11 Mar 2026 13:20:41 +0000
Message-ID: <20260311132041.12044-3-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260311132041.12044-1-deveshigurgaon@gmail.com>
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_combine_filter() splits a combine: filter spec at '+' using
strbuf_split_str(), which yields an array of strbufs with the
delimiter left at the end of each non-final piece.  The code then
mutates each non-final piece to strip the trailing '+' before parsing.

Allocating an array of strbufs is unnecessary.  The function processes
one sub-spec at a time and does not use strbuf editing on the pieces.
The two helpers it calls, has_reserved_character() and
parse_combine_subfilter(), only read the string content of the strbuf
they receive.

Walk the input string directly with strchrnul() to find each '+'.
strchrnul() returns a pointer to the terminating '\0' when the
delimiter is not found, so no separate "found separator?" branch is
needed.  Copy each sub-spec into a temporary buffer using end - p,
which naturally excludes the '+', so the separator is always stripped
cleanly.  A trailing '+' causes the outer while (*p) test to fail on
the next iteration rather than passing an empty string to the parser.
Change the helpers to take const char * instead of struct strbuf *.

The test that expected an error on a trailing '+' is removed, since
that behavior was incorrect.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 list-objects-filter-options.c       | 35 +++++++++++++----------------
 t/t6112-rev-list-filters-objects.sh |  4 ----
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 7f3e7b8f50..616c6c7faa 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -125,9 +125,9 @@ int gently_parse_list_objects_filter(
 static const char *RESERVED_NON_WS = "~`!@#$^&*()[]{}\\;'\",<>?";
 
 static int has_reserved_character(
-	struct strbuf *sub_spec, struct strbuf *errbuf)
+	const char *sub_spec, struct strbuf *errbuf)
 {
-	const char *c = sub_spec->buf;
+	const char *c = sub_spec;
 	while (*c) {
 		if (*c <= ' ' || strchr(RESERVED_NON_WS, *c)) {
 			strbuf_addf(
@@ -144,7 +144,7 @@ static int has_reserved_character(
 
 static int parse_combine_subfilter(
 	struct list_objects_filter_options *filter_options,
-	struct strbuf *subspec,
+	const char *subspec,
 	struct strbuf *errbuf)
 {
 	size_t new_index = filter_options->sub_nr;
@@ -155,7 +155,7 @@ static int parse_combine_subfilter(
 		      filter_options->sub_alloc);
 	list_objects_filter_init(&filter_options->sub[new_index]);
 
-	decoded = url_percent_decode(subspec->buf);
+	decoded = url_percent_decode(subspec);
 
 	result = has_reserved_character(subspec, errbuf);
 	if (result)
@@ -182,34 +182,29 @@ static int parse_combine_filter(
 	const char *arg,
 	struct strbuf *errbuf)
 {
-	struct strbuf **subspecs = strbuf_split_str(arg, '+', 0);
-	size_t sub;
+	const char *p = arg;
 	int result = 0;
 
-	if (!subspecs[0]) {
+	if (!*p) {
 		strbuf_addstr(errbuf, _("expected something after combine:"));
 		result = 1;
 		goto cleanup;
 	}
 
-	for (sub = 0; subspecs[sub] && !result; sub++) {
-		if (subspecs[sub + 1]) {
-			/*
-			 * This is not the last subspec. Remove trailing "+" so
-			 * we can parse it.
-			 */
-			size_t last = subspecs[sub]->len - 1;
-			assert(subspecs[sub]->buf[last] == '+');
-			strbuf_remove(subspecs[sub], last, 1);
-		}
-		result = parse_combine_subfilter(
-			filter_options, subspecs[sub], errbuf);
+	while (*p && !result) {
+		const char *end = strchrnul(p, '+');
+		char *sub = xmemdupz(p, end - p);
+
+		result = parse_combine_subfilter(filter_options, sub, errbuf);
+		free(sub);
+		if (!*end)
+			break;
+		p = end + 1;
 	}
 
 	filter_options->choice = LOFC_COMBINE;
 
 cleanup:
-	strbuf_list_free(subspecs);
 	if (result)
 		list_objects_filter_release(filter_options);
 	return result;
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 0387f35a32..39211ef989 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -483,10 +483,6 @@ test_expect_success 'combine:... with non-encoded reserved chars' '
 		"must escape char in sub-filter-spec: .\~."
 '
 
-test_expect_success 'validate err msg for "combine:<valid-filter>+"' '
-	expect_invalid_filter_spec combine:tree:2+ "expected .tree:<depth>."
-'
-
 test_expect_success 'combine:... with edge-case hex digits: Ff Aa 0 9' '
 	git -C r3 rev-list --objects --filter="combine:tree:2+bl%6Fb:n%6fne" \
 		HEAD >actual &&
-- 
2.52.0.230.gd8af7cadaa

