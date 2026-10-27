Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084380;
	b=lIWTvChg/ZzCMtfAtAzIlA1e+VpLoJdnjDUY0dzhbJbleun5IejvQKMra1lUturzqWnB
	 CAFH87as8AjhMZ0Idb6tm4BNAy/XO1HJ3tOmPZDcgessGv6U2YE35UhNvhWrATjqtqCb1
	 MQ3BR1AmZaiK2jI/7ofXzitHUXkHYZVI7843hd8qYnf8lG/qy6nvnCb5fdc5oD9yx+ufE
	 9H/wlPSSYa+DsN2Ne2Bb8UsXiIz125HUWE9RavSXWIIZmHd0JYnXvYtVSF0B6rWkXpm7S
	 AgVzfpQb+ayWuhUAi8TgH2T5QjewCyekembppiKnoDWVdGpNY49/hDtVIrph3Akelow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084380;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=2JkmTosT+aQFs+8Cvhygb7G0r/B7IN5XZ/2+5iwNVzY=;
	b=36n9p9es6O46d9ZPlhqoMTbYzMvmnUGEbKxaK8DRF3HtqayBZsCGb+APg04m3BmCSqW1
	 /Hu5Y6rDtCsuaoqggnLynsbDWAqHAdVRBYCrV5wLDT2N934DJvPC0EHnBbkUwx5pI3+cm
	 /RaHFJDjEre06CHUvUAAxQw/dJDqtnHH7uNcA2fHLQndOvT/cETm0cZoxS+uyMwF59+ES
	 TOiCFpFIiuGVZ7jK1AOLMOpIMnWwm8tFcz9D/lgygbLXyUTVaLbjk+ok1VG5SXyDI2262
	 UFI25A3ucAkqLhTL8Jw7jxmVG+mdgP3ILVaVaj3Gvz3/8O1czYi84WjIalMHN9tVZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=IaSDvsZj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=l5cZ2mho;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFC606A328
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCFC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=IaSDvsZj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=l5cZ2mho
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F2FB41D00109
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:59:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 02:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793084378;
	 x=1793170778; bh=2JkmTosT+aQFs+8Cvhygb7G0r/B7IN5XZ/2+5iwNVzY=; b=
	IaSDvsZjj+JDP6yVnPWt5Ca8nf9CY39BKntzyHipBVWC78azYQMauzWEo4xxV8IZ
	AC8SZedOrn9GFqYeO8dMeR7zIPfSZq5P5hQzCtflB2hx2dRBvak/eHBeeLlbd4Vh
	kOcElPtRItWw6Z97Dj8aX2+/WvoDCwWKuwP+V9hdHnEgLrFZTZRHsU9EAsy52tJa
	egU5j2VSDbJN3oeFt/L3lpM3aP5PvaxSGETGBCMuqOWq6IMb89t2j/1a4GmANz9r
	NvyRrbacM1q87RPQch6RHQUBHai1XfzbrJYZEvk8VS6dGZbmkPcJxN13F2lf+vXH
	1oGe7sZfvs77U/DLhc124A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793084378; x=
	1793170778; bh=2JkmTosT+aQFs+8Cvhygb7G0r/B7IN5XZ/2+5iwNVzY=; b=l
	5cZ2mhowDyZ8Hwxp3dAZl5/BoV+dj6Ik3dbJwwitZklzHQozDlpu9c8ubXxLd6JU
	2jy0rX3haO/xsC+wn4kUlSb/JkzW/ezvQjOtC8O1Ms7TfI9YrKB2mFDRzHPRHAFP
	OqUgwHPDa6Q3kkb0HRBibcpaHNWEq6qEyRv7ugWFzzHoIBhlLXT3BkH4CI/uVfHg
	VJhQ3ovipcMcMlUEZt7iDy1WFmnRntcWnSPuTea6V+AjeyamPUTwmyKRhPash8cK
	d6Rf0pkjn8d/DnjFscVb0kPYxd5B/bzCfTe92DWsL0JLso7PyVy6T7IIOMbpgvDe
	uBZqHGscGu5n7/HZ0cV9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084378; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AdfOkCabUeRJFZYgiLiSvT31blWg+LFHEZMOChlni0aAKwX
	6GJC2xc35F6g8N9eVUXwBKiJj5GJOuBk0wD7lBbtoN7ZlkKLjDIMBquHkXcJ/Ave
	cYUTGwfXHwHtdQM0NT7aLmTkhI6S2DGRFsJKJ/A1jKqPHBn3Y48IH2rcA0Wo7ulx
	U+G6UNXrJbMbNdUeQuz16mwS9QSghFB8zBKK3ZjEx4z+nzgGYlGo6m0Ot7FElb7Q
	AhljbI5/NIeXP9P18i+/uieEKJ+a5MxPF4kEVL9+CGI6lM9W+7Y+UbuLGIFRyLLj
	XrnxscPI9Bg6C0M4SqYiEaeAOgDC+jdfHPiX9RA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:T4ren83L5AhGnKBT9A4m8GGqNJrCSAbHDgmlTkZWHiU=:S/3eDNyNtc6mSg1c3gSLO28MBgv73bA4Jg9O1QnyhSA=;
X-ME-Sender: <xms:2kvgak5jlFZ8gxrNm_ItpQQ6YVz0YINEWCa9qv2oA7z1g6JK67WJSA>
    <xme:2kvgatVTIBDu9YCSp26JelTSiOmpoeoSX1WbZpcZOktsZLW4qi0MQ4O9oqBG9MrO5
    q8dhNS8N_BWv-LeUTw30peVmzFnmNTj52zVrXY-PGnIdPEMcRDS_g>
X-ME-Received: <xmr:2kvgag0Y7xvtuBFlCjkPg0YszxG16nhX6Ij17aejbXrwwihriU7X9g>
X-ME-Proxy-Cause: dmFkZTFiJTMoZfENaBRamlYo6jUwqtatctngIl80GnvY560Z60MghnxUHqRWClEMaPNhjz
    GTSfIyE1WJQoctVHBHcB9oqzxn29/aS/wxltoM3v+Eddp3vW0tFqELsNHqwHObuah6wXaK
    Tv3W/aRFBNzMbwsyJh8klZVQRosY4pcaM90kygnealj6l6R7jKJW7rGBVCVOU7IlyofFzz
    PYAHj6mARsrC4ZeY3KSSkM1y2Ytx8T8H97lr6BJSTinbAhHkAZvYaI2wZD8NLtlhQzoz9x
    R4bAE+ZnGpJDEvL6xN5pIz6CQbk0/nuwRaGJWxk9ubc9HnjcaEiwOb9xwryuT8o9+oUBXE
    CrmIDhEg0XHe8lRt6dHoBDWkleGe4EFnkOiPSh7FEGMN5TiW+ASi8GJw9fuszNbiuddojH
    /C1ECR6ZGNKODsMuvHCz5Y/iTC2Z4o+yrR3uKWMzpdtu62cYuJE9PIPvArkVdUjR/FTDI9
    TFlIknkgubG0X1RjYkakgrKnJKweTTRwQeBq7Z7uKZG9GI+QnGGzv9Evd/8+DeGjiXQurL
    U5ByI30QWcZKJ1Sv0uLtStOzJlqSRASPDEic/Ed6QWAbFWIWfXv7sFKnXeDkCRJTaU4QIr
    IjdrVMFPXciyiyBUw7KKQAp3tYvy4/Hs9cMDuM9l3cSLlcVkH9p0geCG+QyQ
X-ME-Proxy: <xmx:2kvgai1vLw_xp2DcQXXrN029Ixp_hxsc4xs-3PjVPFRNxenzek1oJQ>
    <xmx:2kvgar8_8gK5HwZwSF28A9CbDxf4yrsPyuRmeaxI8x-BKJdBhStIUQ>
    <xmx:2kvgan0_EFeUUPOqT9oYXwsm2NxD5DZUu_yEkT4rKxDw_5NLllJkFg>
    <xmx:2kvgag9gBAbpe3p0EWHpeC4diOn8agKObHW3gMyUYAHOSFNyAWjPhg>
    <xmx:2kvgamyhLt8kiqK54GOtOQ050dkyg_HqikYKZUFb_nPSwXHRLNZ4S2Fj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:59:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53e61c3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:59:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 07:59:25 +0100
Subject: [PATCH v4 1/7] loose: drop unused `repo_write_loose_object_map()`
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-b4-pks-odb-extension-v4-1-5d28ca0ea1dc@pks.im>
References: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
In-Reply-To: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

The function `repo_write_loose_object_map()` was introduced in
23b2c7e95b (loose: add a mapping between SHA-1 and SHA-256 for loose
objects, 2023-10-01), but it never had any callers as loose object maps
are instead written incrementally via `repo_add_loose_object_map()`
whenever a new loose object is created.

Besides being dead code, the function also hardcodes the location of the
"loose-object-idx" file as "$GIT_COMMON_DIR/objects", whereas both the
reader and `repo_add_loose_object_map()` derive the location from the
loose source's path. The function would thus disagree with everyone else
where the loose object map is supposed to be located when the object
directory is using a non-default location.

Remove the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c | 46 ----------------------------------------------
 loose.h |  1 -
 2 files changed, 47 deletions(-)

diff --git a/loose.c b/loose.c
index d6a2bb5ba3c..7e26a04ec08 100644
--- a/loose.c
+++ b/loose.c
@@ -123,52 +123,6 @@ int repo_read_loose_object_map(struct repository *repo)
 	return 0;
 }
 
-int repo_write_loose_object_map(struct repository *repo)
-{
-	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
-	kh_oid_map_t *map = files->dirs->loose->map->to_compat;
-	struct lock_file lock;
-	int fd;
-	khiter_t iter;
-	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
-
-	if (!should_use_loose_object_map(repo))
-		return 0;
-
-	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
-						    LOCK_DIE_ON_ERROR, -1);
-	iter = kh_begin(map);
-	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
-		goto errout;
-
-	for (; iter != kh_end(map); iter++) {
-		if (kh_exist(map, iter)) {
-			if (oideq(&kh_key(map, iter), repo->hash_algo->empty_tree) ||
-			    oideq(&kh_key(map, iter), repo->hash_algo->empty_blob))
-				continue;
-			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
-			if (write_in_full(fd, buf.buf, buf.len) < 0)
-				goto errout;
-			strbuf_reset(&buf);
-		}
-	}
-	strbuf_release(&buf);
-	if (commit_lock_file(&lock) < 0) {
-		error_errno(_("could not write loose object index %s"), path.buf);
-		strbuf_release(&path);
-		return -1;
-	}
-	strbuf_release(&path);
-	return 0;
-errout:
-	rollback_lock_file(&lock);
-	strbuf_release(&buf);
-	error_errno(_("failed to write loose object index %s"), path.buf);
-	strbuf_release(&path);
-	return -1;
-}
-
 static int write_one_object(struct odb_source_loose *loose,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
diff --git a/loose.h b/loose.h
index ed663ac550f..41c4b468182 100644
--- a/loose.h
+++ b/loose.h
@@ -22,6 +22,5 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *oid,
 			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
-int repo_write_loose_object_map(struct repository *repo);
 
 #endif

-- 
2.56.0.341.g393f52fd96.dirty

