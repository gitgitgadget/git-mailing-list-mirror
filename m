Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CE3207
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754184401; cv=none; b=JUl9srGZz4KbPzwmO7uiSNjrqXBruaHHAv/eU/wjCTiGJi5AaWKbN/MXtmw/sVjubHDBSYNWsF5jJCfCj5QWXpP6CKriNdGxAo2Xu6OCKL4BzLYxuCARtlytmOBsz6d5BTGvl0GLBV4t16ggfWcTAD8cVQtZg8V+Uw9IXG8lL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754184401; c=relaxed/simple;
	bh=BmYguEVHboEab2+Ayzsv1/mmZLb2SfLGT6Z2tB+hS6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLqvn4tHTWpC4JgzCG9lpXOOpWFWa8U355pByGiMq2htwGkjcqILOX8fYHHAiiaeTBQgJpLzKhrIzxtwTOpoxdr6SKNq6DEJbDMnCmzyrXPtkLGHbdTXpW2Pcbw7dmOsM6DZgrImv3zdPk/2vHxYznFfCtinMo4hAN5+/qxV+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoaJRHk8; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoaJRHk8"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8fd38cb3a1so2146408276.3
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 18:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754184396; x=1754789196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nf1IaOtlYlK2k2JNYpT7P5mKJ2tERwoKrgkEDM40to=;
        b=QoaJRHk8KQE+wlh1H+31r0MFpZhhVqyKBnUIo64mTmdmrKFeQYlBj0Mus16OXr16kB
         IwcpITY18W7S5M8s1aQ7BLZpBybzKQ6XtFnjBnyGpdBL1R9CUOdbLV9oORFw9dKe1Q9F
         LmhyIcrdacaXI7v3+fXt7WLYgcn+QSb6wimAF9xHVvgFUX1BSmqfQoBgC+TiRtz5oGVY
         kq85+6OTnuhaXtUzJqrSkaSbbWFbNUug8dNcJPx9bP8JMayiwAp7RfwtalpwFL7PxFMq
         DKaNIeFfyXLRrYdHkGHmtuBdHvFsQkJ0AuwfmyPpYvRL40EBG+f90au5ZewoiLnaCUrG
         wP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754184396; x=1754789196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Nf1IaOtlYlK2k2JNYpT7P5mKJ2tERwoKrgkEDM40to=;
        b=d/W47KojHegBwIT26OZQlENm2qg+rY+Vb6ACii/nfR81k93I8gEKstH38Wbd3MC0Fh
         RplamR4kth0s8xH9aJYnNYQAsSnv9WJFM3j1xeMyGlJqzyokMTUC9HLrC6+S5caB8vLD
         BFdpWhqZJhk3AxRa4mHjn24x4aOzbBjdqPQHACqkkfGQ9UQr57d0ok1l/2f/bMlRGZ04
         zyVXNe3GdUhiQzgBfPuKTFze1L1ZznbrPictgCReGWvipyqHFVqLmoIzS7oH/aJ3N7sM
         juMghFXuOAScPpKw1mflF9vIDDbpZuEmEB//eZHmbS2IlPp/FcEJGzYKFzfwUkXba9C9
         ln3Q==
X-Gm-Message-State: AOJu0Yzo6T2AQfpcDskVHWzmmlbZsM//4bJot3+3O0mdSUd/19Tfltde
	OvR9QsraaUh2k/pmHwyh45xfNHLhikH4UNEW807HZcZqwls4yOez33ftZjPHhRn4
X-Gm-Gg: ASbGncvgcdTLjcl15hREXftIiI3lxiDtyMbNiN0Uv1/71CSALbUuvyCE00MYHbCZlbJ
	x1diWUopi9DBuZ3XilOjpygraIh6KTfucR/YK30buoPAeZtbRCy7uEcCQ3RuNDpixJe6XIrvcz5
	+Q0j8wssM9NThTNTBs4gIFAQt+FHnD5IpMQGouMwZI9JeGH6QgFN54F9CNyzIKQ5X+BTu4tH2sP
	W+7L74DnfejOFrGr8LmZ0oAefEMulgZbMMienLcXs/gPDyWGyO3fL52tN0UdAOOqJL3XSEBkftL
	g+BgY3I4ZUROaHZmfwUdZRttAyNrvqQ396tnknEvWTWutdpr3uJXpsuHNS40u824Ky1gmtmvsCz
	yMzY/DmnLOaxlCb4YS2Z6VxENVesqnAdgScxgTDc1nU/kVbyM/jrVxwfgeBttMFiTWY8=
X-Google-Smtp-Source: AGHT+IHewi3SfOTmB29B5W46TuC3EGRNzAqp4yrx2QFii7g1v9zqiSPcOcIOOghNZQJmVxkCwPsikQ==
X-Received: by 2002:a05:6902:6317:b0:e8e:1e32:c2ac with SMTP id 3f1490d57ef6-e8fee13a6dcmr5262731276.16.1754184396156;
        Sat, 02 Aug 2025 18:26:36 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:88ae:3d99:b445:935b])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd38ba780sm2673602276.43.2025.08.02.18.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 18:26:35 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/3] t1517: fixup for ua/t1517-short-help-tests
Date: Sat,  2 Aug 2025 21:26:02 -0400
Message-ID: <20250803012613.54086-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726165320.4039-1-ben.knoble+github@gmail.com>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- drop spurious message during test
- fix known breakages that actually work
- fix instaweb marker for known failure: it is not a failure, but should not
  have .sh suffix
- fix new t5200 test

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes:
    I expect this and other fixes to get squashed into the upstream branch,
    but I'm including it here so it's easy to create a clean build.

 t/t1517-outside-repo.sh       | 7 +++----
 t/t5200-update-server-info.sh | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 9443c0284f..deb72da66e 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -113,10 +113,10 @@
 	case "$cmd" in
 	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
 	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
-	http-backend | http-fetch | http-push | init-db | instaweb.sh | \
+	http-backend | http-fetch | http-push | init-db | \
 	merge-octopus | merge-one-file | merge-resolve | mergetool | \
-	mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
-	remote-http | remote-https | replay | request-pull | send-email | \
+	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
+	remote-http | remote-https | replay | send-email | \
 	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
 	upload-archive--writer | upload-pack | web--browse | whatchanged)
 		expect_outcome=expect_failure ;;
@@ -125,7 +125,6 @@
 	esac
 	test_$expect_outcome "'git $cmd -h' outside a repository" '
 		test_expect_code 129 nongit git $cmd -h >usage &&
-		echo "Hello" &&
 		test_grep "[Uu]sage: git $cmd " usage
 	'
 done
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index a1f129db4e..a551e955b5 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -48,7 +48,7 @@
 
 test_expect_success 'update-server-info does not crash with -h' '
 	test_expect_code 129 git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage &&
+	test_grep "[Uu]sage: git update-server-info " usage
 '
 
 test_done
-- 
2.48.1

