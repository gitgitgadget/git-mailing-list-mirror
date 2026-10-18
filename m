Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123C4AA3F4
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333321; cv=none; b=hi1QVfLnXdOXkqIGsjP6pBCLLx8gfaaakUUcH4I3mlC3x9QkCz+W3hUdGHXBralOX4fnQr6r4iIHLZ4zlZ8rKpZlI2BXgmFZx2JoFVuXvZ9n52J6wwK9qSJH5EkK55xrFlt37Rsv9c6l2+fcsg+thX2xHSvQ+MOIEgbK4ps59rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333321; c=relaxed/simple;
	bh=t75sAxx4gvHgZP7KePUU+JxD/NVBc5fZf9Z/HLoQ8ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ayvNmGlR3KtILwlS5OGzrFjl6LduSRE8W5gNKHhDvFnwUxgHR7i7R98LUNICYtSeDIlyNHS/fRoA0CqwLugrpRoLO57TLdp1LdIlWsR3hj0EF248JY7mvNmoyj4ByFo7iM0CPOkZWjpPULZiEodj/VeXY+VyfGt4f82F4XtvfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZYNIx8Z; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZYNIx8Z"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab1a37faaeso1926611fa.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792333318; x=1792938118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZQ9xnMTz4kun81RdNa7EwX8PvSB9xE7mablqu8/94U=;
        b=sZYNIx8Z0WO/+1dCt3BdbkazWG86+PxdWGkdo3UCxduMN89pNkY/GwpSTQdTdbsfsc
         i/ZOjoUm9LZ3nhFvOy+qKQXyj/T02vMnd4XfHAH3uMGpC6VQLlq7oasXeK+9yZC9FHrv
         E+6crhuGjze4k5qnJ3kh5PO1shxBD10nOytrOJeXPVa0Mx7QWbeGJ3WPbDb9pb8NqTMh
         RtlhpdlZg7MEIObnp00lY9Ujb+RXUN4dJG6bHQrr2dQfmBV5XFrX4sioFgwsfncEJLoK
         jk0wt700KCzm7J2v3m5A18pth6ZERPXukeFjyiLC5fONi2xScesHYRa55IGd5l41foDi
         RC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792333318; x=1792938118;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZQ9xnMTz4kun81RdNa7EwX8PvSB9xE7mablqu8/94U=;
        b=oMtfK1O+PXoEF5eIW28KGN/TORUIUdSWoiuijhbK2QCZcdV5o2M152IQnSae6PdQn/
         f3SzvLaPpLtqX3HfS7ny8dmxdALNbZ4q/aSVop9UOQaETyCwAwERJwmphkEERQXhWbnn
         ne6Csz7/1RwAl778k3nkCZrbBl3LAow7aoyBN4OMzbXlEfTXrinKHc5guY5Mu3ntWQ4m
         7aY4Jl1eNDAzrpWSaUSoAIea9qXgPilDqcQ6x3fl9MLHc/14MU97c3UHyidn58ezvgPH
         XiSfZOQcWSMkpFirRfjlXPnVoggGq85i93iVkd3lFwEmD0MZBTFgGom9A9zDNkgKu+OV
         b2Kg==
X-Gm-Message-State: AFq9FYLBlCvW0yWQy5fd386wzldfskUNPlF77UHmZcLrfB/6O1WJH9Y8
	kKjMgI/bq+Xa6bNGiVOApuyfBOEjsHVnFoLEFfddyAcj53wHThyoauwGdrtCW+/96wY=
X-Gm-Gg: AYBFou0eXGX+u5lMpPUB0wUnkZBp8V1L0T/W7oKP7Mgmc05/7uBj7SQNZfC+jSXMUiC
	/y+BkcMdMDLayGpu1ZUeRUvvJhpdAWSlvuR82ACEyinhcvPvy1QOGJoQqtNaYjGqNDk6Q7b4amA
	+YTlXI/ZS4WBBOzroi0nqm8OSr1hRTowdjNcE0AlrCBJmaLggYEkfQrXNFdpko5SAWOWa8vfVlC
	kSxe17D9XX0VxbzR0bGB4LOkoMz6GBXRcU48ZqQDgw9Hl3zrzr18ayaT6oi3vUBd9S09VGmTXi8
	wvpG1V60b0sQPkNt1cdUyhljdLII7k06GstYzzg5CXXpr48yjFDrHkfSYJiXYlmJK3I1T8EnniR
	nWll7DlZhDlcyYmhEH+d1+i90lFtqORU5eJ9aCnuAadJP9edzU9hkWBLQr6pt/a+D99MoU4Lkyk
	sM7C6QVRpEheSJDz4HRY+lPCYIpQxanJskRVF60hgGkA6ZbzYt/8pCBaXgubq/DmEZEw5aWHDNZ
	CPjQdVbOSF6DqQWRMAhs1N6qfxUlkY=
X-Received: by 2002:a05:6512:33c9:b0:5be:4d62:4e65 with SMTP id 2adb3069b0e04-5be50a96ab4mr1910830e87.6.1792333318239;
        Sun, 18 Oct 2026 07:21:58 -0700 (PDT)
Received: from Iris-HRQ6HW3.. (78-71-217-218-no600.tbcn.telia.com. [78.71.217.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a63eea5sm1478484e87.77.2026.10.18.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:21:56 -0700 (PDT)
From: Olof Fairbrook <olof.fairbrook@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Olof Fairbrook <olof.fairbrook@gmail.com>
Subject: [PATCH] bundle: do not free uninitialized memory on bad arguments
Date: Sun, 18 Oct 2026 16:21:29 +0200
Message-ID: <20261018142130.2701449-1-olof.fairbrook@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"git bundle create" gives up with an error when setup_revisions()
leaves an argument it does not understand, as in

  $ git bundle create private.bundle main --no-such-option
  error: unrecognized argument: --no-such-option

Since 11ee9a75e7 (bundle: plug leaks in `create_bundle()`,
2024-06-11), that error jumps to the cleanup at the end of
create_bundle(), which clears "revs_copy.pending".  But "revs_copy"
is only filled from "revs" further down, so the cleanup reads
uninitialized stack memory and may free a garbage pointer.  valgrind
reports "Conditional jump or move depends on uninitialised value(s)"
in object_array_clear() and in free(); whether the command crashes
depends on what happens to be on the stack.

Give “revs_copy” its value where it is declared, and add a test that
fails under valgrind without this fix.

Signed-off-by: Olof Fairbrook <olof.fairbrook@gmail.com>
---
 bundle.c                | 2 +-
 t/t5607-clone-bundle.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index f55a521b2a..aad5f251ca 100644
--- a/bundle.c
+++ b/bundle.c
@@ -492,7 +492,7 @@ int create_bundle(struct repository *r, const char *path,
 	int bundle_fd = -1;
 	int bundle_to_stdout;
 	int ref_count = 0;
-	struct rev_info revs, revs_copy;
+	struct rev_info revs, revs_copy = { 0 };
 	int min_version = 2;
 	struct bundle_prerequisites_info bpi;
 	int ret;
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index d709bea753..c39db5a955 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -127,6 +127,13 @@ test_expect_success 'failed bundle creation does not leave cruft' '
 	test_path_is_missing fail.bundle.lock
 '
 
+test_expect_success 'an unknown argument after the revisions is an error' '
+	test_must_fail git bundle create unknown.bundle main --no-such-option \
+		2>err &&
+	test_grep "unrecognized argument: --no-such-option" err &&
+	test_path_is_missing unknown.bundle
+'
+
 test_expect_success 'fetch SHA-1 from bundle' '
 	test_create_repo foo &&
 	test_commit -C foo x &&

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.43.0

