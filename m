Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146036D51A
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764558646; cv=none; b=TYT1TrePvzDdtcVpuuuHb6ik5wRvmu9c+0CUh66hogTVWyL2vPPlRvxYnTgTjDH52b8rkYNAJwEKNPMp5PgE92B/5FRukAdmbTj/AoR4HabFyJn8ZoCxsy4DbklZxe0B1rm/NIWIjQoUsqDhb1NzLrphF413iFSLpQTO6W6MZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764558646; c=relaxed/simple;
	bh=o1d3+GFUv6AmxyySz+5bWR/SwgWzdGIG1diZtW92J7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwaQP5yhvEj7LOnMlhvNSCJsOKnErFaRghpzZHkk1RjSahqLu2SshD3XE6Wv5XynlKz4hl2jUjeVtnjc2+pysjmbB5koBk13XF63BCtBdjewAaqBpDmticrLoT7cKymv+Z9+LIyvX8zKkwMikC2SF7rFHlwF/uNuEvRZiLfqzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7QMXi3z; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7QMXi3z"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640c857ce02so3195324d50.0
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 19:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764558643; x=1765163443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TT/icGep+FPRR5Xqu05pcKxnSSVB2lfkGI7BmS9enw0=;
        b=E7QMXi3z2fXvUJZ7DfWMvQ42zt9HLvqAPVlgCmQC1+iATIJZV6KelgmM+NszAdi2tT
         dKC+5hRNVdnIjoUTaloQ4Lm6ViPv1yJz7KH0+YKfYzIxxT7x2mpVpzosayQhZfYJfzCl
         8n6kpjMRSvkcBE+3d47w7xLouDBIpaZKSnWrOodwLxCpfVbvkBj86tkzCsVPaIbMA0al
         WOAtEjE10Qox7uvW7pXi3gfM5IbVnCCoB8nyUm56kW/+3BM9bFnQXWitS5lOriAwwSyV
         R4Suxqa7WnDt8Xy95NjQo4yqkdPrt93wxg5MYRe1kmMITyLd2N8Dve3BX8P2BzMsItyE
         IIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764558643; x=1765163443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT/icGep+FPRR5Xqu05pcKxnSSVB2lfkGI7BmS9enw0=;
        b=PGyNJF7qpWuluAdKOTHvlGCwVXHYN/y2cS+myDV2IYMx5y2JBdn+c4PeS2zJKqJWdx
         5n9Z4ZSZm0aFPgp2qBubCX1Zo2EK7GajO31xAN3f+POdi/AqYYDVIUmbOK9if07EXYCF
         YYruVsQXPhs76NDc/feAPKteXA6OqeElAZrLkuFFtmrmt7VZzgGy03clRkTKbE7ON/bj
         FeTDx5sX8txPgvKpoi2Wq49k7WEK/9lLjPA8stx1owRk3Kzuj93QnWiqq5cE1xnjeLot
         Z5dOSaigbMqnWrSPwROHq8PtPGJpZ6T/zumkYkHvC0SIa4/FwCXruSFE4lPy+HjCOU3U
         4NAA==
X-Gm-Message-State: AOJu0YxPhFHyNYtgcWLJFYq5xX9jRTScFvSi1evpEOmbgLeipkyJsQml
	vBPdKM8u6EgWNgGQgys/2y8kNDjtG9cFOkHa2nTZieI5Mez2rab5hxFZ8Vf1Rg==
X-Gm-Gg: ASbGncuQ6Jg2rx00EuiICwozUOwRBLeVhbP33XPPwa5b90wGnRKtX4X2SlYkNwxm0em
	IRYzKYltvIKYLDILZb0WA6yv7C2LZcFscqpxU7krVfVOPW5nH4qKOE3c8ul5tJwL0n2yVEFa66T
	KjCo1rMIF+nztiFDQXQVJiVdFVlJBM96djbmmPC0IpGmllVrqWiaRZhBzywnau2b1ylYsBPmKpZ
	0JN4hsTfXZgzCIPMNcHbadr6uBU82lJpQut9GtkUKSPT6KFJCKl3ULqZMhCyx/t5GT0+xO2V56w
	mzwEiTwQtjufzsCB0zJyCXBHBgcDMsnlUK96kSZQOIcazdpioNIjjpMvG4xBLyoceYAgnAsDCVe
	DdxSLIsQnfdpE6zUz60eOysC8CVQxcE26BTQrhyI49kJEnu8Ninq4ixFCImtuU8givd359C0EsQ
	/zMwjkta0HkQqjb9hCqucHsVLxhlJ7SQ==
X-Google-Smtp-Source: AGHT+IHRSPPL+LrPRWxFoHcRi05ZSfonUWuUpnuUV4MBfkkvchGALSbIaqKpVSArkS4tix52OlXFlw==
X-Received: by 2002:a05:690c:6ac5:b0:786:5789:57dc with SMTP id 00721157ae682-78a8b50c37dmr303315827b3.41.1764558643330;
        Sun, 30 Nov 2025 19:10:43 -0800 (PST)
Received: from zivzoom.attlocal.net ([2600:1702:2ba0:4270:36ca:1d09:208d:215f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d5fe74sm43362357b3.16.2025.11.30.19.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:10:42 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	adam@dinwoodie.org,
	hvoigt@hvoigt.net
Subject: [PATCH] t/t1517: indicate that `gui--askyesno` fails with GIT_TEST_INSTALLED
Date: Sun, 30 Nov 2025 21:10:35 -0600
Message-ID: <20251201031040.1120091-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e749c87e75 (git-gui: provide question helper for retry fallback
on Windows, 2025-08-28) causes `git-gui--askyesno` to be installed when
running `make install`. This triggers a new occurrence of the issue
noted in commit c4cf8caadd (t/t1517: mark tests that fail with
GIT_TEST_INSTALLED, 2025-08-19), which prevents Git v2.52.0 from
building in nixpkgs [1]. Indicate that this is an expected failure.

[1]: https://github.com/NixOS/nixpkgs/issues/465178#issuecomment-3580790826

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Note that while this does allow nixpkgs to build v2.52.0, I suspect that
this sort of issue is likely to crop up again in the future. I wonder if
it may be beneficial to make some more fundamental change to this test
to avoid future occurrences. If that is preferred (and something that
someone has time to tackle in the near future), I am happy to allow this
patch to be obviated by such a change.

 t/t1517-outside-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index c824c1a25c..13540388f9 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -115,7 +115,7 @@ do
 	credential-osxkeychain | cvsexportcommit | cvsimport | cvsserver | \
 	daemon | \
 	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
-	gui | gui--askpass | \
+	gui | gui--askpass | gui--askyesno | \
 	http-backend | http-fetch | http-push | init-db | \
 	merge-octopus | merge-one-file | merge-resolve | mergetool | \
 	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
--
2.51.2
