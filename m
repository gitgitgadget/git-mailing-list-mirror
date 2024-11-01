Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BB1CEAAC
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491919; cv=none; b=okH02HIuyRYSnym0jbJM2e8xqfon8MLvnb7+4gptOJpToob2SFdvwZkZ3yShTg/d4wy9Wk0UDeW+Tovr63lKP5+q63BztwW5EAfDuRH2vzlHA6vZt8bG/9lN8kwJIQWBrzTndgJGbb86p3UwVIUKNJPprnCIY0YBbuRLpqfL6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491919; c=relaxed/simple;
	bh=MT35PItDqDIxgCQxfKH+QfFAmPdf1PeByGLje6WRoWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdJJ4G0j+mQy3i9avMBpk6n9wbHeF8TD2RbEv4sxLqScmSprr9jXwqZGfcoLqQBKmFFEkvdk3kQjAq9d32xAUc3lGIKA7DBkJA3lp6j4gF/Lq7OSIY5IVAzGpBHXxzKNfks2CQCbgOEaaf120WL20o4AbYVTu/LD6LZheQw9JmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0sgFMLt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0sgFMLt"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3705b2883so51831637b3.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730491917; x=1731096717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsd80GHaUtupo/563Ne78tyyAJqH7sbFStokHjf9UPw=;
        b=E0sgFMLt8CR+NR5DDhoPVqkchON1N2cdBLoUKh9ignO14Ut/leITioQlrMyVp7N10z
         4t6vNXFL+iXlCcQz+0MkkljKWCBZ8DJzykE42pjdZafeUXt6PwyZn4HHKsXzvGtmBZSP
         OstREu7xRwScEY3nCznjOioRIolcQp17cQTJcMZ91dXq9xwNstacid+Ofyq+hkV02dyS
         QqrCyQ5sknasveVzVnoORaErqEQmGyYVcyAX5loX+5tYZ7picWRIZjmgiJgpc0ElUZIo
         41DoLH14FkE6Wkc2L1hKRWxtraGCPbreOFy/Jj51QBjL24+IgJR2hgK7LJ8ViKgJI1KG
         EYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491917; x=1731096717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsd80GHaUtupo/563Ne78tyyAJqH7sbFStokHjf9UPw=;
        b=Q1ixMPseconZggbsmfF+cpsoCovfji3iobX0D+CUNfzGdGeMQW6HTD0gcBCqarqlEN
         KisnWPPUY8Iw5cNncA2pcJqgxsf3njKGnkETMNnAkBDHvkKyjwvzuoEk0cRlwaxsXeTX
         zWEaBf8giJs8387aZMLL454Q4xTEB0fnoFRwjwcVOEB0N+mntOQ7FzTtHPmORxRM931f
         xpkOqjIc29fLHceFFcjI7lnJHpFi8Ruq6bw+6TGHf7WKTRZP30XSxUpQ1kpjaiGhlyFV
         aN6fWTtfg2wS1Z3e5gw7PWSrtaOyyyukfHo8t5zxpx7nesHGCjpyisU6+8P6qYFUxA2X
         y3/w==
X-Gm-Message-State: AOJu0YxWTRuhbvVYLDcp2EUrLCh2pB9cqJiGOCknIn1VQm9D5u9Lt8w5
	t8qNicjo5yXY5IiLZf9WFTiVYptM15ZAzDSK5Z7cRXAtY2U6mEK/cbdUHPkWiyzL355KeHtyy3p
	irxX8wkrpNAgFdO6a1nXEJu2jqHUtOk1EBO6T80p4FCucNzZN6KxRH1l14nUf8kIpxjIWNwhErD
	y5MsngBmgHNw3hdeHKdQRn0xoelDvF8kBhW+QAt2MB6Z3u4olbSPe4CEXkap4A16tIpQ==
X-Google-Smtp-Source: AGHT+IG1RQ89gfSR7gm13RRTbxiOUwUNkYLSDur1YDckV3IDIvDI0Elwlq+u18ICnPBNv4/+FsaOdGNgzTlaA2FvwVYX
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:2e8f:b0:6ea:fa4:a365 with
 SMTP id 00721157ae682-6ea64c11f97mr172757b3.8.1730491917143; Fri, 01 Nov 2024
 13:11:57 -0700 (PDT)
Date: Fri,  1 Nov 2024 13:11:47 -0700
In-Reply-To: <cover.1730491845.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com> <cover.1730491845.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <1526a59e2d4ace2761fd8935c63350f0a41985c6.1730491845.git.jonathantanmy@google.com>
Subject: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com, 
	hanyang.tony@bytedance.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

A subsequent commit will change the behavior of "git index-pack
--promisor", which is exercised in "build pack index for an existing
pack", causing the unclamped and clamped versions of the --window
test to exhibit different behavior. Move the clamp test closer to the
unclamped test that it references.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5300-pack-object.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a..aff164ddf8 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -156,6 +156,11 @@ test_expect_success 'pack without delta' '
 	check_deltas stderr = 0
 '
 
+test_expect_success 'negative window clamps to 0' '
+	git pack-objects --progress --window=-1 neg-window <obj-list 2>stderr &&
+	check_deltas stderr = 0
+'
+
 test_expect_success 'pack-objects with bogus arguments' '
 	test_must_fail git pack-objects --window=0 test-1 blah blah <obj-list
 '
@@ -630,11 +635,6 @@ test_expect_success 'prefetch objects' '
 	test_line_count = 1 donelines
 '
 
-test_expect_success 'negative window clamps to 0' '
-	git pack-objects --progress --window=-1 neg-window <obj-list 2>stderr &&
-	check_deltas stderr = 0
-'
-
 for hash in sha1 sha256
 do
 	test_expect_success "verify-pack with $hash packfile" '
-- 
2.47.0.163.g1226f6d8fa-goog

