Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE11D416C
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425062; cv=none; b=Q1poGzlJKaicKvYoFB6AHk8x0VlJ1fo3LPYYbrFkw3dHBwAhQWCQSMyOT9gooAz8tGEILI28cnvwVv2kYI3PeNkzHYoGnmWvRHjqDt43bVNKQGKSMbscqKnM/juHxEsNeMc/v8FvgWFEpelcVIIbaxQdHcynRczjxyJE+arnWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425062; c=relaxed/simple;
	bh=R9i3+wGhx2tKJgfSZUaucUDvytSctgasWL2yiaJBssI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbOJAaFCnEiHp3LJ9AAThXsHB8aK6P691aaMVKV6eXSosB/zsdif7cgxR1M4Ri+NHDqw6/GwfujLjNcSO4vzCdineEd7SXzvMQrHO0q95HTtaini72xPKYw1nfcfP6AUMyUJlYeZ1WqCGQordQ9aUfZPY/vvhy18GuJy7j0Mf0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lyu/AgBH; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyu/AgBH"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a88d23a5a4so12340277b3.1
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790425060; x=1791029860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noZwRHcnxupKWEkZvaXGbX7szDAPwevPxhrZ+PmfnRM=;
        b=Lyu/AgBHY3ky9AxrNIaAxQ2ey+CUZiZyQWH9A+vlNnDfQN/0PEoqKJxKqwbUkoHIXN
         4oSI2TKQgD2viafba8ZG8EEjPp4/JERGRbtRCpJnuEfCP4upJziFn3YqHQCqM6ZBflPU
         o50mCLfPK/UI1NXGM0p+xWgKZoWqz7+gQtbhkCkZwUagcQ5b5D73CAQjMpyaDolsEGmz
         Hf8XJ+0Nar2b84fOTR1CcIDlOxLTWjwuwacgKFtMVtvNAkLTvALm3WGh9BW9i6rgSPuP
         NR1HnhS8BFWKZXQ5h2CUFxyTUJabj2WdWA2kMY3Zy4J/WyDJD+y9qvltaf4lp6ShQgQG
         QVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790425060; x=1791029860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=noZwRHcnxupKWEkZvaXGbX7szDAPwevPxhrZ+PmfnRM=;
        b=BHT8IIAKofpNn63bn0CnJuebE7KNuPMsf2gp+cxaGlFrGnqlIZAnUEh7y4Mmm/uxId
         ofBY7FKzlnebTzog6EcYNVgNwPOxiDs1mzE8Fv+vViFEYYqslwVmzSiKYbCXZs6t8W7+
         nDIYRvZnRHYVTx3Go5X+JWkoI9/tVYq7ehBX9e+lkFZItKEmlcMG3T+8IvrspzmewGSj
         D1bjuypprEprtA/pvmtdA7/F1eJzw1ZjH5Ogc993HXW5H5Hw6deDwoS4a9ZUfi26q/RQ
         C6V71c3hS5r+pEt7IJ0nGDNACGKE09/kwZL6oOFYagJGFr+pA+RTQAFrHMl7/iSm+XTB
         zYlg==
X-Gm-Message-State: AFq9FYKWkfgzpVixSOsmn9f9PqX1Afp3s9UvIwbrXWrPgpzm4gdp6Icl
	3eDDHbGeCj5Ka4OdpHN8otwovUJ+vz9OhblJeprNHvKlngEdfZLZmLAsXiZFzjGb
X-Gm-Gg: AYBFou32Yis4OZx/TaOisGyEwWmiCaA5vD2WbgcoQ8kjHgHcJxwiOsxNhA2FD3Lmeod
	eVMuDPY9o71CONXVE9Nj+RcQhTj5PHe1qIEeUQEN7monOZaeqajq4LQLI2F5ADdrZS0KeSEFRvC
	ZDJs8f4lTfmNuhC8iVOpx1Otn1l2TAGTQS89vRqxxNWeq149rDoh6U9Jdtm6Sw6R5AxB+ZRjnW3
	sOLSP4JKVXbxVfVQRgKSPPwEoqgcQtGlSq0JOdHoycHnyit+z1jKwgKxsRvUTg2E7iSYuidsRzv
	1hBjEZwK6cBvywjx32WkTRJ8G6GjBNmYOCCzs2lihqQf3X/1GN3zWBwaHsq+ytAJsiaYuu73kMe
	p4JaphyFi4bXgO+ewusVFUVrkVaX3m9t6TUs8MjkC6kPTYXyp0N5CrvyduPIIfD/R0nma85FPxk
	Ptn/Djy0DXlG2ced9Sbfs8tF6d8w1HUxDcnLfX7PdV/Vvody/eNHL0wPQXGx4sMXyEJFQo/jc3x
	jDV5JkkeUWP0sZaP1c0HRn7Y4kjd5x/YxUJGcTs6JsqdS5BAtzIZIEKmGu9cqZL9202a30ZyM1k
	6y+eDdoyh9cgPySB1SMaOJTT+ah+F7vr
X-Received: by 2002:a05:690e:144f:b0:674:167d:4c86 with SMTP id 956f58d0204a3-674167d50e0mr1301164d50.56.1790425060068;
        Sat, 26 Sep 2026 05:17:40 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ee9d17csm2179151d50.5.2026.09.26.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:17:37 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v3 3/5] t3903: test stash --index merges
Date: Sat, 26 Sep 2026 08:16:46 -0400
Message-ID: <8b5ea5e6f47ee9a57df3a4d97a457d024b3dec00.1790425008.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790425008.git.ben.knoble@gmail.com>
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A future commit will refactor index handling for applied stashes, and we
need to take care to get the order of trees right when merging. Add a
test that covers this case.

Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 t/t3903-stash.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 721158606f..9bc99fa252 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -374,6 +374,27 @@ setup_stash() {
 	test_cmp expect actual
 '
 
+# the later "stash -k" test is not expecting us to muck with file so much, so
+# reset when finished
+test_expect_success 'stash apply --index merges the correct trees' '
+	head=$(git rev-parse HEAD) &&
+	test_when_finished "git reset --hard $head" &&
+	test_write_lines A B C >file &&
+	git commit -m setup file &&
+	test_write_lines A B staged >file &&
+	git add file &&
+	test_write_lines A B unstaged >file &&
+	git stash &&
+	test_write_lines committed B C >file &&
+	git commit -m to-be-merged file &&
+	git stash pop --index &&
+	git show :file >actual &&
+	test_write_lines committed B staged >expect &&
+	test_cmp expect actual &&
+	test_write_lines committed B unstaged >expect &&
+	test_cmp expect file
+'
+
 test_expect_success 'stash -k' '
 	echo bar3 >file &&
 	echo bar4 >file2 &&
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

