Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B740627D
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460662; cv=none; b=BoOd7p+yCjVXvIWgUm0v02oNuMqEwf6URasIiQq5rj26oZ+fGUFJjnvDFrdvqQzKObHU83BiZvgegMCoZCCp4p2iYcoUW7OAjvodz9TvJN1heTxoY7S1yb80Sy6cX5AdIe8rbKm4SjVlgDRfjvc1MwureF70QyPXN/wz8dYOajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460662; c=relaxed/simple;
	bh=y2bBHmq6FsPIVqQ7uGABZXHVBhEmTtw+N73eU43yqPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6wyvJuPUUBreebVDj3DDvqrmWe1sWnn5r3/aV9o+S4GDGINFOlSPajvHHti02VMCSsukB3NC8Nh2Y/jx/7/X+6Fo5ZW9eAG4ZKTpt0y+y4/sN9xuOasMXTekhTOicj6gwbxUl7pnirUoKzgI5iewQuKeIGMoT3ncV8BTYM8zC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLubKC89; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLubKC89"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso1350225e9.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774460659; x=1775065459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzCnM8HYjK1Dd6uK+Rc1OMYCeR4GmPV+2x/77gJmOCI=;
        b=bLubKC892V6Pxm+fdb9YegEJIIIZo2H5N1lGvKepqTG9IWzo8HiST0j/ZdOxklgFJW
         MSBBewddqV4adS5cxpmYNoGMn1jkumcMW7tlRB2cGDFqVUQk6oeItOZ+zLJMmIL+ufBu
         NH7OF3I1IocWdfGY3J0qlOqvsU9spj0tXObb4INVP7IOHhlpBsh7c2HukVOKHSgPwGkJ
         RgJt5Bhl+ex79bsa3EgSfoR6QxJejZbM6I2X9fjEEG5obKCO8D3Vp9b+TZDKvdWqbpE0
         FERkpCobkJ7Ow+642QxGM0uw0Ia3G3YcDMzVOIehnaszaByujI/rwXENMQ9Ld+DzXaOO
         +mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460659; x=1775065459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AzCnM8HYjK1Dd6uK+Rc1OMYCeR4GmPV+2x/77gJmOCI=;
        b=Q54Ac6mSp2D4sURGg+KrwRl20xI9cbyppyj3R4CSY3Y/3Kj+MCkhR+OVJmXftHW/JQ
         xuWKfPRNM9rQ5QDUaUbnmOn/qbhs+kgX1cbYG6sxYECaWMFdk6+ZmoINwZCGS4nWTFn4
         bQDFojgCYfx13nAZIfRVfHyAvurXDSMT8EWy4gcf7PE06Ut8BdfwV35ZiBwtOlBdLjX0
         CPPGcoqPovoVF4JL/gSrtOtoiZn4GNuc6xR0yx+xPZTOxcYATlliFkVSDr1+KxTvzpje
         zGrPv4sGYe1hsPEJAkJQmmzMtDFPtgYBRTXnSp/32r2ofy6Z3SQhJDILM+Ati1XCG5zx
         vPFQ==
X-Gm-Message-State: AOJu0YxVCkcJQfWUTac8SwncF4l+n6S5BkHkHZSMWYsUp3rxAhYEoD5s
	xc0IRMrQTFSIRUnbzh2kfhBZPeys09u3MNqhcFG37OAXzswOAfozLxF5aeh1eCBy3bfs8A==
X-Gm-Gg: ATEYQzz2s85zFRr48cHAX4uddGr9F8P0fkAMer+rY6GnpmHgjJcxkdaHXAbOsWYYfm1
	3BKLb2yl7qyHW54sinMTXIklQHolsf7p6c4pH2qb0Dc2Fl4H3m57SQFHOGYJz1XqLjc4rgpnvZT
	JNkS55YApz+336yyiCs7WvX8pZTzZnFj218ueH3qVJYNT9qJ3tXg8TY+f3vniOZgJ5dSwNhfdMj
	oKW0ikwHBEI/PcrB7wGmeDBfeCCtwavKj6T19d2FNuZUMiwZcPVhkjyGIEvs9o9/MvVPx4X+MgB
	BreAtmE3zMA3WKonvfdiRIJajFxBJTJAY0qdpI2ymJHNjY197M0PAd+6gKSrqWHsXbfdxunvuVz
	B7HBPYY/n8fwnH18d8ZJ0CCf4OfrIHGS7TkdY/AXCC5rNOj/FiVwB5rWrnf5bvTWPhfdAAGvjMk
	aS1EGX8w6s2n9WZPkol4d6VoVvbq15UMS8qJP2svcD06STyTX5rGdce+gv03JSLloLrakVgGWJb
	se5Y1pvbC43Q6dTVUFhM5WM/W4J6ildOBB3KJS9wWQs7cMknkeWYuRSA4wwfloTHBMotA==
X-Received: by 2002:a05:600c:4685:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-48715fc3994mr64724875e9.5.1774460658474;
        Wed, 25 Mar 2026 10:44:18 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716547814sm47106145e9.0.2026.03.25.10.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:44:18 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	szeder.dev@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v5 2/2] graph: add documentation and tests about --graph-lane-limit
Date: Wed, 25 Mar 2026 18:44:01 +0100
Message-ID: <20260325174401.217577-3-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325174401.217577-1-pabloosabaterr@gmail.com>
References: <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <20260325174401.217577-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document --graph-lane-limit option in rev-list-options.adoc with
--graph option.

Add multiple tests in t4215 reusing existing last graph, test
for different scenarios.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/rev-list-options.adoc |   6 ++
 t/t4215-log-skewed-merges.sh        | 144 ++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..56590f4e95 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1259,6 +1259,12 @@ This implies the `--topo-order` option by default, but the
 	in between them in that case. If _<barrier>_ is specified, it
 	is the string that will be shown instead of the default one.
 
+`--graph-lane-limit=<n>`::
+	When `--graph` is used, limit the number of graph lanes to be shown.
+	Lanes over the limit are replaced with a truncation mark '~'. By default
+	it is set to 0 (no limit), zero and negative values are ignored and
+	treated as no limit.
+
 ifdef::git-rev-list[]
 `--count`::
 	Print a number stating how many commits would have been
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..1612f05f1b 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -370,4 +370,148 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
+	check_graph --graph-lane-limit=2 M_7 <<-\EOF
+	*-.   7_M4
+	|\ \
+	| | * 7_G
+	| | * 7_F
+	| * ~ 7_E
+	| * ~ 7_D
+	* | ~ 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=1 truncate mid octopus merge' '
+	check_graph --graph-lane-limit=1 M_7 <<-\EOF
+	*-~  7_M4
+	|\~
+	| ~ 7_G
+	| ~ 7_F
+	| * 7_E
+	| * 7_D
+	* ~ 7_C
+	| ~
+	|/~
+	* ~ 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
+	check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | ~ 7_M3
+	| | | ~ 7_J
+	| | | ~ 7_I
+	| | | ~ 7_M4
+	| |_|_~
+	|/| | ~
+	| | |_~
+	| |/| ~
+	| | | ~
+	| | |/~
+	| | * ~ 7_G
+	| | | ~
+	| | |/~
+	| | * ~ 7_F
+	| * | ~ 7_E
+	| | |/~
+	| |/| ~
+	| * | ~ 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=6 check if it only shows first of 3 parent merge' '
+	check_graph --graph-lane-limit=6 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | | *   7_M3
+	| | | | |\
+	| | | | | * 7_J
+	| | | | * | 7_I
+	| | | | | | * 7_M4
+	| |_|_|_|_|/~
+	|/| | | | |/~
+	| | |_|_|/| ~
+	| |/| | | |/
+	| | | |_|/|
+	| | |/| | |
+	| | * | | | 7_G
+	| | | |_|/
+	| | |/| |
+	| | * | | 7_F
+	| * | | | 7_E
+	| | |/ /
+	| |/| |
+	| * | | 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 parent merge' '
+	check_graph --graph-lane-limit=7 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | | *   7_M3
+	| | | | |\
+	| | | | | * 7_J
+	| | | | * | 7_I
+	| | | | | | *   7_M4
+	| |_|_|_|_|/|\
+	|/| | | | |/ /
+	| | |_|_|/| /
+	| |/| | | |/
+	| | | |_|/|
+	| | |/| | |
+	| | * | | | 7_G
+	| | | |_|/
+	| | |/| |
+	| | * | | 7_F
+	| * | | | 7_E
+	| | |/ /
+	| |/| |
+	| * | | 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
 test_done
-- 
2.43.0

