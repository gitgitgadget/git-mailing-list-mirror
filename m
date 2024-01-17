Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16782D510
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479260; cv=none; b=bC8DQXxHr5kKPkTvfByR7HhgXzNz6kiCMI5p0upEcqIQhNlBvOTnAwJLOqVpzX0klMQ+Ix2AEWbqyLdR08Fmw847CmofYXFabu6HJ9RJBTBhST0j/KAs3R94tMnjjC8kc8vaf+jrZsFvTft6OEgU0i4N4bHBlbdO7oXHax414eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479260; c=relaxed/simple;
	bh=aLePuuptoe1N4F0QBY5Lb1B38BO7eHBU9bGuxL4u8LE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=P5/kHAJsPlzhWDXIqivzRjtedRnLGNNL/X8mxBTESGNgnph4zLtmZ055FeY7EG5QA0Msre7cE6vvcZrMvOpqr5yRs+Ug30HCV7MkrOqTxoteuGr8mxDAbeDcDmbOWix8hHu97zp5i6lmhwQINsqWExki4PUdemXh29QlvEhw0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikN4AVbb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikN4AVbb"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e80d40a41so13682634e87.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705479257; x=1706084057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY/854c17wU6Wk1QuYiDzlOdSnPez8PthpA+EukTAcg=;
        b=ikN4AVbbmuLzfqgCVuypimG6LEcr0+tumrmXS0rxucUdcFpuUr/aVphbX2IEseaG+e
         q4GrDw7WyPymSAxzq5ktqRpx4Q+FeRR0+eTcaHRzhZ8YlGP9ADiOVEa3NdsLHwO4Nm0y
         C5LLQLcWPkNA5DOGv3LhBmGGer/cIQO9Ofa0He0d9MhjWICGoCUNGSbVEMc0mUx+/+NQ
         cqnMU5B1/JXZNQSuXyjOxn7tL385wExEQV9vkFzxtojVbCPXhjexPOJU136uv+bzyedg
         clefjWWYBXATAQbdQoBvbBmLxD4azZeGWnaw+Yk+O+3y+wthTP6kDf1b5tj/3EeLIzLD
         1Z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705479257; x=1706084057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PY/854c17wU6Wk1QuYiDzlOdSnPez8PthpA+EukTAcg=;
        b=rUz4cZlIVaO7/duGsv1wn9iYOPlHXvHLr058Uixqm9EicMAzILfJX3S5TizT4oG1Ab
         G4CROFx8pPla0+F+XboM/SdN7R4tAMfzOADQHD0rELjTInWXccO6DQNeh/9e+S3wyIyX
         PayEnNIl5TixYwQLGGOYEbjmESHIQRojiR2fxu3sftzu9qT5RAOK+c56Ze8a5x+KH//x
         2cS+81Ewrxq/C8A7eqeddEbHRf6asFmMxXIQ4iBzgYQv/HGgIBl3CjQDHfX2eNwpAcGO
         2HLwmPm9IeA40ns0zoqpe/GB3lif7fvQwByPMNtx2w2l9ARuQN8jncNY0j/Pbarb9Utq
         Hucw==
X-Gm-Message-State: AOJu0YyrODC6v3Xd8uPFSo0wPI1SkdPv4BXS+tH4QS2iMnelFnh01snK
	zaTZiFjhAJTH0bJ422vG/qY=
X-Google-Smtp-Source: AGHT+IGULeKT4h6wf0kJYQqJltYSbqgCqt4KaakxphN8cCVFSle/6bovgLwWAVsioPdXOz4GB5pOgg==
X-Received: by 2002:a05:6512:3a95:b0:50e:7bd0:1c3d with SMTP id q21-20020a0565123a9500b0050e7bd01c3dmr5507368lfu.97.1705479256688;
        Wed, 17 Jan 2024 00:14:16 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-dfc5-0-e407-3f73-62bc-9c57.ipv6dyn.netcologne.de. [2001:4dd4:dfc5:0:e407:3f73:62bc:9c57])
        by smtp.gmail.com with ESMTPSA id 7-20020a0564021f4700b00557de30e1f1sm7671803edz.74.2024.01.17.00.14.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jan 2024 00:14:16 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	newren@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 1/2] revision: ensure MERGE_HEAD is a ref in prepare_show_merge
Date: Wed, 17 Jan 2024 09:14:04 +0100
Message-Id: <20240117081405.14012-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <xmqqzfxa9usx.fsf@gitster.g>
References: <xmqqzfxa9usx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is done to
(1) ensure MERGE_HEAD is a ref,
(2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
(3) error out when MERGE_HEAD is a symref.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---

Changes with respect to v2:
- use read_ref_full instead of refs_resolve_ref_unsafe
- don't use "other_head" variable to store MERGE_HEAD
- check for symbolic ref

 revision.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..aa4c4dc778 100644
--- a/revision.c
+++ b/revision.c
@@ -1973,8 +1973,12 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
+	if (read_ref_full("MERGE_HEAD",
+			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			&oid, NULL))
 		die("--merge without MERGE_HEAD?");
+	if (is_null_oid(&oid))
+		die("MERGE_HEAD is a symbolic ref???");
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
-- 
2.39.3 (Apple Git-145)

