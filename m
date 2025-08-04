Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB824469B
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299413; cv=none; b=e8M0/o7PA+ogncVR8Mjem/UlJzchdIxpNsyD4mwfaCnq4rzlpU0Y//WMyZG7hlMhbcgseqhLlhu6TkRkmTBq5De1vTkWPWINIDCNZRagYm1YuoMuJVMqWQY5fqgeSwPXb5TIISn/FPg4xjyFw6+4o15Bf5OSphUNHOIrYUWMJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299413; c=relaxed/simple;
	bh=lFl2KtcB3SJg8wnP6TsHSp6qGw2xiaDl0QlFbsSexjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRyTpS9vvabOXKa4jiSUxqcBHScQKlnOHvEPO56KOqmDbvtKRSwW0EO4Dvk7Vm0irW2DMi/YYDoHmmCahJz7eS8cp1aDaVbO4mbFTuQpv9AU/xybwodCIkiXWaZVvjrZ+qVQB3ICsZaq6LjymGsENw+pZR9gIV4/ZU5VvK5qeuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLkM+BBs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLkM+BBs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-240b3335c20so24452015ad.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754299411; x=1754904211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fbJEeo3NIyMvlrDr61nAJdjqra5U08pCLnGL9rj8tY=;
        b=gLkM+BBs3Pju/ZNv4FgizpNbYF5r2gzJU1sNN4vF/TNNGCbZo+lhdFLp0NPwwwQSKG
         GS8OxzRQxAtpEDWeFUdagHIbIxovno6XSErajswAPAwJoLby+bYMoGvIpq+IgI4NWSKn
         dOao4igtUpLDxXELus2PfMDPn/QCicvZdEubTCVYqGb4AVLOQwLNlHzYBOAmE79R13qK
         VOOF6crTXOuAXORDFb1Na/TOt8+VkHsUGGIZkH8Egl9tkohVZN7XKuqo4BsbvC/EhNdv
         b+MyJQrrIKrG03YdPJE6cFbQXgFU6pmhgo3PxjefAFKaesOTxvcrth7gyORy/+oa5R8Q
         bnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299411; x=1754904211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fbJEeo3NIyMvlrDr61nAJdjqra5U08pCLnGL9rj8tY=;
        b=srAbv3CKMQYklygVy2/rITlTIoo33YmfD6gDcZHzOXV09Xa/puI3vnCH77DazTebsv
         A3MiMb5nLKcC3T6Xf/FT7RG9+fyM5UvYQACE/QSAE6E9l5/68ysC7cWynz3yUeHMs2DN
         TSb/lDAqonocme7pQ7LesX4KbOEXofFz/FesfN5eBoffpVNtdfavIhQ+StpDOUkS40a1
         MwjOjYyzoNIohH3UM/alGfRLqpB5b82SbSauoI7f/Joa5NDiGsfpvBYM04WwfgLH591b
         FQULjEEJy+uT/0cduZLlfnRnIlQOgVVfuM4PdlRPYClI78Z40rFbNJ1JHjNnSrkWENUd
         6QPQ==
X-Gm-Message-State: AOJu0YzXrrN2ji2FAB63uvlhfh9YNPxT335lZB6gpCB7OYQEEcZoe4wT
	dzGYtIKMiUowWPAZcfqYHqD/ja3tgjbVhMHwuUgH5w7FHfak6Ebu7me610nwemFs
X-Gm-Gg: ASbGnctQvuihqyXHpavFB6Y8tOmupMW31ex5eAimNODN8iJJjX5picavLfgnJZfGrWY
	D5j71m4gcWnc7b55Jkm0eLbO9IYX0nKhzRhJZqYsSC7oSxlXBUzsszC/6/sX/hHiU9kdQf1DdrV
	8TkqxGDVIjNoycFErwFBxYH5sj24pYgrQoP1GpNd4g/SaGEv5MX2YG9mD5c1hkfTujXdc0Z9HXZ
	fIY9ewbRm2aE0ehFBDG1h1mtJVdB8MEXy+P1Wdx5HWfuQRfmM/ahJczMMFNOEIOzlNgx3gHCdrz
	23cfXT+5rUkFgfr0QuLfk9sLu1vtRckNSs3BkYAlvcj10VFbdXIOLM234fgB5ANlQxL8/dwM8g/
	LsDqx9MQO6iryGFZbIt4=
X-Google-Smtp-Source: AGHT+IEDdqbrOdocGa4x49JqSdsBD+XvMWOvkTNQndyDVncyQVWKQI/ez/SA52zKq3WfMhq5CmXaSg==
X-Received: by 2002:a17:902:e0d2:b0:240:49e8:1d3c with SMTP id d9443c01a7336-24246fef44cmr67868905ad.35.1754299410669;
        Mon, 04 Aug 2025 02:23:30 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm106205565ad.4.2025.08.04.02.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:23:30 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH v5 6/6] t: add test for git refs list subcommand
Date: Mon,  4 Aug 2025 14:52:55 +0530
Message-Id: <20250804092255.1092973-7-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804092255.1092973-1-meetsoni3017@gmail.com>
References: <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250804092255.1092973-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1461-refs-list.sh`, for the new `git refs list`
command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$git_for_each_ref` variable to "git refs list" and then sourcing the
shared library (`t/for-each-ref-tests.sh`).

This approach ensures that `git refs list` is tested against the
entire comprehensive test suite of `git for-each-ref`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build        | 1 +
 t/t1461-refs-list.sh | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100755 t/t1461-refs-list.sh

diff --git a/t/meson.build b/t/meson.build
index 50e89e764a..c959c039d0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -224,6 +224,7 @@ integration_tests = [
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
+  't1461-refs-list.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1461-refs-list.sh b/t/t1461-refs-list.sh
new file mode 100755
index 0000000000..36e3d81e59
--- /dev/null
+++ b/t/t1461-refs-list.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+test_description='git refs list tests'
+
+. ./test-lib.sh
+
+git_for_each_ref='git refs list'
+. "$TEST_DIRECTORY"/for-each-ref-tests.sh
-- 
2.34.1

