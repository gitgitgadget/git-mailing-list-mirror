Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458B27E1A1
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553189; cv=none; b=FkHiSB3FAf0jwYeaOVrBl6SdjdqlXQewaC4n5Cxpy7PXXoWIBe3QFIm9tl2OExv4/XDDRnG2FbweoM61GUKU0+gQOJVaPJSq7miH7N6KgwTaePW1C1wS+9PWeAFwBLcflVQ/NB8tXr3jctRG2jXtYCdCL+VljUR5YbYqx/CCC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553189; c=relaxed/simple;
	bh=anxVHynck6O+SuJoutVAzqb+WiF2IKN3LJBXQ9mB0fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYYGzTPsliBfGqTX4SE01WKrduksKoDL1cl7AsvkxyX4pgvgLM2oZ8i06gIifHU1AprfNsYbRKyALuPjd7L71t9IZ3t/vJ1aM1/BqROoXbcvqAdFnpyEz2q0YofpMs7LOGvrsIb/FV4EVxcxE+jzzB3vNNscZINeuT/0Dq7Hms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+O9EhWv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+O9EhWv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso14185945e9.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774553186; x=1775157986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40rL/yUfJpr1M3c6XAF7OuKiJoVYlvUse/i2IhdQG1Y=;
        b=f+O9EhWvHozBaM4rkMu7kQu+wEmOar3nXMp/rhfFx9GFBJipTlZYkxk3Yu2DvBNgLT
         m6Mnw1JyaInTTW1esQRbAP98M+I53avOk1jwk8oouOICdvcVQrSVcAGL2CEAI9yUdnpv
         stsxw52FKHWXpuVtJkQMaTZ0Zq6jXFxL9nyNrolgCfZDigFVvzhoNCFt8XqOULlfYTbB
         gR1giBEmfSeud2ybQ111rZOVH8Wr5+eKA62xpVclpkgm+8ZZT7QLF0aYiTEQqfF14/sF
         ZvPLeEAVnF5Pku6rN/ygL5nNztH8TffV1Kn4DPMnS6eDYqm9MJIXfOhn6Ck+D94U31FD
         Ctcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774553186; x=1775157986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40rL/yUfJpr1M3c6XAF7OuKiJoVYlvUse/i2IhdQG1Y=;
        b=jNIg49XYriVZCmx/gRWcv2tDpcbdhXNv5cf98nx6U6Bipx102+84A8lPnJ2/fATIQu
         4xyBRClxcuA3qywPhcYv39mFny3FGhLtDFtW4FRDHa0ndK9ok7y4jlqVDmeZDgitXVgz
         f7DeKfWPH18ykpZV5MWv+7UkyPB080Xf4KUrsHWj4eWSLsX9YuJKcE2JOYPCUS1TsWkm
         K/Zbz6KQHQOyiQFM3dGrZTibvMVlW6AfEZGAYzwWPSDT7KdKyItyRKbY0tfx1nny/F5B
         LfFKxriG3SAD4gvV3h/Q8IkSikkCyfULWWQhOK69VmzNaxwylYEyi/W/E7T+SFFWBfD/
         YKsw==
X-Gm-Message-State: AOJu0YxB8fYepIYem0kP6sFv5Pxrd31/7wcQcrpCOuHyohI9URFHwCl1
	e1rAdQ2ygX5dwnOoFnmhTTl9o6W6PkCReDQ33QWkuLYlX4YqP0UoZOVNYXTYWgYCObQ=
X-Gm-Gg: ATEYQzxrKelT+cPxl0CO+UVdsIS18cklRf4qmzZHPloM3bqEncaKm3OudRQtDHK+QlR
	qTh21LJdvPx1+/VsOV+u/dPJC1PEkXjBkvJxgLw1AEUxoc4eSddUah5l2ATO81LOrXFqHNCCaVh
	suCIEChvZ1ePV7/2xqSsdHk1C84j2ixpaUGIUe1nS6YTTnovVjGVDg1+gfq8vBiluQDiulOOEdh
	+ggwVwTNjuZORLJ982nS25SWzb3qXgZofIbf2EPbjVGkkA/764pdquq7zb3BkDWb1oATWqNWNNI
	nkBxmF3AX0SeGgc7Xfrxp5U/KNq6P47wK/8O+LAOWvq/FnylWcj59CVE8OwoHvg2uhkZ1yODx9T
	vV8+jXsaXaC1iyiwofYXRrsokSA+rmBDcktuXsDV+enGyULIptzleSCRhY/ABX/uDNMeIqVy7pl
	xb859SooSELYM6cPxB98Jy54xHeKZLIN1TXcDyijercZ8oT4axVOnJEDV3c3ZseWuBFNBlY+ZLJ
	BPHGXFr/9++0qg5/A==
X-Received: by 2002:a05:600c:1d0e:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-48715fef7bbmr133143675e9.10.1774553185295;
        Thu, 26 Mar 2026 12:26:25 -0700 (PDT)
Received: from alibaba.. ([98.97.76.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d23679sm104254045e9.9.2026.03.26.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:26:24 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org
Cc: ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com,
	Zakariyah Ali <zakariyahali100@gmail.com>
Subject: [GSoC PATCH v2] t2000: modernize path checks with test_path_is_* helpers
Date: Thu, 26 Mar 2026 20:26:03 +0100
Message-ID: <20260326192603.23961-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPAKoce5BeXMPtok+dni+WDTkokCAq0o4uMHGg1KZto9-UniXQ@mail.gmail.com>
References: <CAPAKoce5BeXMPtok+dni+WDTkokCAq0o4uMHGg1KZto9-UniXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bare 'test -f/-d' and 'test ! -h' assertions with dedicated
helpers. These helpers report loudly what expectation wasn't met,
therefore making debugging easier.

Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
 t/t2000-conflict-when-checking-files-out.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index f18616ad2b..96bae6c53d 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -58,7 +58,9 @@ test_expect_success \
 
 test_expect_success \
     'git checkout-index conflicting paths.' \
-    'test -f path0 && test -d path1 && test -f path1/file1'
+    'test_path_is_file path0 &&
+     test_path_is_dir path1 &&
+     test_path_is_file path1/file1'
 
 test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	mkdir -p tar/get &&
@@ -127,9 +129,9 @@ test_debug 'show_files $tree2'
 
 test_expect_success \
     'checking out conflicting path with -f' \
-    'test ! -h path2 && test -d path2 &&
-     test ! -h path3 && test -d path3 &&
-     test ! -h path2/file0 && test -f path2/file0 &&
-     test ! -h path3/file1 && test -f path3/file1'
+    'test_path_is_dir_not_symlink path2 &&
+     test_path_is_dir_not_symlink path3 &&
+     test_path_is_file_not_symlink path2/file0 &&
+     test_path_is_file_not_symlink path3/file1'
 
 test_done
-- 
2.43.0

