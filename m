Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2112171A1
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825280; cv=none; b=HOOTMYelneN4DScKPH1yIe7YgDcyBN9/y6vuf4D+sr17tAFRQI0Eakw5FoIlc3x2MhKjOY0FLOf+u+9wq3UbdWj/gIxazYzs4nMb+6rFvAJnvARqgsf5YZd5CpN8O7JfR31meLOgRnqpRWqqOwEdwW6aB22CMdebzhpq2D3GXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825280; c=relaxed/simple;
	bh=gYWd2UysEDCejPSk51VO768ILMZAw/Y2DuAOHQdghqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Whh9Xo9oF2ygqqoLrxc7VliiuuhSKxFTRr6L2fUO/pPjPnID4JBmA2DLeZnZ4ez7d+7O43czi2NVzy/2/hPKW9Ed5ptKCLDdFrfKacvCr8EwGARnK83IQ7or24woUmNYXQba9iUNVZETAXZxY7mLOzhcTmBwKNkxr06DVoAc3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwQJWvJG; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwQJWvJG"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bcc5c887efso308867fac.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741825278; x=1742430078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCocxmumCV6uM+PNn3kbpQHCGZ2ek0wvXPlooZeMPT0=;
        b=iwQJWvJGJWobXJ1lX4z0bFudl0csVIJ+kkpiIjOphUzjFgns7ZuuszuFeCnWDmhpWh
         yPhqhYOVx7P9Q+P/DwMOQFn08oDBLsjoq1zenGBLPXZ3LNtTZk3gAGKsh+uSmt1edfUx
         OvCQID1p2EC4EyfMW4hhgC+QqivQ7GgAfqQS1KwS48LDTuT5fZu7Vm9KO9juQoTk7z5C
         yO4tjtmn66rGv9QqdKIcFMpQAGX9EuHIzDAMWcurSy+bWFvzsaK7R4NmvHeB91RqEyo7
         PFDowEj6LkQgxag7zBO+rcEgNhL/hgOZBxo88gWiXP0FarH14bREFrXUSiANdF/r87FQ
         2cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825278; x=1742430078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCocxmumCV6uM+PNn3kbpQHCGZ2ek0wvXPlooZeMPT0=;
        b=d6Q+nAn9g0FG8Ozfc3SnqkVU4UNOHCzMGo8QmrwMX1+0LpMWkDzrF4Y8C51JoBBfh3
         4eRnh/q9lj9xIShPLIlZN6a850GY5IT7ktc/ng1NiWy6umX+lEGyVfotPfv87xIkQbRj
         cv5bC3zEyzZdWjCCPzf66Ia9ijzD/XD/CLAB1pS6WN7KSZ3ttjsXdRP80OPx3BoD5EWM
         GefUYjuwMtHfevvYoEyzX1Zbyycz833uXFiGLfyTsn/C9DLyxJtWZ2iZrRIJCB8Qq9BB
         YL5g9WXZWeJwHdte1cJI+esy1XLnTPTRgHdfypculQCzl9qblSi9ouOmDJT0KlN26pJ7
         0DkA==
X-Gm-Message-State: AOJu0Yzt7+ui+LPooaBr/FSwZ0hyTQfXeiPd1KRa6wi1TglK0kGD1G+E
	P99AW+VLflpwlZ/gwjAOEyy6ArkLISUraIuoDFdyZkz52nXwqeNBkjeeySku
X-Gm-Gg: ASbGncus9IhapXFgerEZ74CT8S+nxWCwLSKAklEu2olMoqRsGbP5akcXRdv8Fz9uDca
	TsnkwS6lUw8yHXKAMdhx8sewAHOlb/y38t+LvqffwyRXL3ODkGCd7oLgxIiH2GedOvu2EYl2Z7j
	rFkTLii4ASwuh9hnIrmrd/Q5MM9LM+2cmk7JychQjjMbTLPQprlDyNqdQzgdAoYqNR6bYgeq6bJ
	QWCpQvYbr9XAbW5OFtbr00xftwj7pOAj6JCReSBqqaNUEPVJXmlt9St00XGAPhKCKC9gSLe/bY5
	qMhi7oNP+HgPLjz5bAWDAEm2WXF7sqiVTyKapC1WJarn1uNFU5GZ
X-Google-Smtp-Source: AGHT+IGBmmjeK5gIhzbh1B6lk+z2K2hxxgA7GxXU5hhtyT5oX864cf/gMJ4MF62gJx4UPs4xShdBKg==
X-Received: by 2002:a05:6870:aa90:b0:2c1:6949:2ba3 with SMTP id 586e51a60fabf-2c2e89d213bmr5723474fac.33.1741825277703;
        Wed, 12 Mar 2025 17:21:17 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267a8b4sm24028a34.9.2025.03.12.17.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:21:17 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/6] rev-list: support NUL-delimited --boundary option
Date: Wed, 12 Mar 2025 19:17:05 -0500
Message-ID: <20250313001706.3390502-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313001706.3390502-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--boundary` option for git-rev-list(1) prints boundary objects
found while performing the object walk in the form:

        $ git rev-list --boundary <rev>
        -<oid> LF

Add support for printing boundary objects in a NUL-delimited format when
the `-z` option is enabled.

        $ git rev-list -z --boundary <rev>
        <oid> NUL boundary=yes NUL

In this mode, instead of prefixing the boundary OID with '-', a separate
`boundary=yes` token/value pair is appended.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc | 16 +++++++++-------
 builtin/rev-list.c                  |  9 +++++++--
 t/t6000-rev-list-misc.sh            | 16 ++++++++++++++++
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 166d3cd19e..d400d76cf2 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -371,19 +371,21 @@ ifdef::git-rev-list[]
 <OID> NUL [<token>=<value> NUL]...
 -----------------------------------------------------------------------
 +
-Additional object metadata, such as object paths, is printed using the
-`<token>=<value>` form. Token values are printed as-is without any
-encoding/truncation. An OID entry never contains a '=' character and thus
-is used to signal the start of a new object record. Examples:
+Additional object metadata, such as object paths or boundary objects, is
+printed using the `<token>=<value>` form. Token values are printed as-is
+without any encoding/truncation. An OID entry never contains a '=' character
+and thus is used to signal the start of a new object record. Examples:
 +
 -----------------------------------------------------------------------
 <OID> NUL
 <OID> NUL path=<path> NUL
+<OID> NUL boundary=yes NUL
 -----------------------------------------------------------------------
 +
-This mode is only compatible with the `--objects` output option. Also, revision
-and pathspec argument parsing on stdin with the `--stdin` option is NUL byte
-delimited instead of using newlines while in this mode.
+This mode is only compatible with the `--objects` and `--boundary` output
+options. Also, revision and pathspec argument parsing on stdin with the
+`--stdin` option is NUL byte delimited instead of using newlines while in this
+mode.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f048500679..7c6d4b25b0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -240,13 +240,18 @@ static void show_commit(struct commit *commit, void *data)
 		fputs(info->header_prefix, stdout);
 
 	if (revs->include_header) {
-		if (!revs->graph)
+		if (!revs->graph && line_term)
 			fputs(get_revision_mark(revs, commit), stdout);
 		if (revs->abbrev_commit && revs->abbrev)
 			fputs(repo_find_unique_abbrev(the_repository, &commit->object.oid, revs->abbrev),
 			      stdout);
 		else
 			fputs(oid_to_hex(&commit->object.oid), stdout);
+
+		if (!line_term) {
+			if (commit->object.flags & BOUNDARY)
+				printf("%cboundary=yes", info_term);
+		}
 	}
 	if (revs->print_parents) {
 		struct commit_list *parents = commit->parents;
@@ -779,7 +784,7 @@ int cmd_rev_list(int argc,
 		if (revs.graph || revs.verbose_header || show_disk_usage ||
 		    info.show_timestamp || info.header_prefix || bisect_list ||
 		    use_bitmap_index || revs.edge_hint || revs.left_right ||
-		    revs.cherry_mark || arg_missing_action || revs.boundary)
+		    revs.cherry_mark || arg_missing_action)
 			die(_("-z option used with unsupported option"));
 	}
 
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index dfbbc0aee6..349bf5ec3d 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -217,4 +217,20 @@ test_expect_success 'rev-list -z --objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list -z --boundary' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+
+	oid1=$(git -C repo rev-parse HEAD) &&
+	oid2=$(git -C repo rev-parse HEAD~) &&
+
+	printf "%s\0%s\0boundary=yes\0" "$oid1" "$oid2" >expect &&
+	git -C repo rev-list -z --boundary HEAD~.. >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0.rc2

