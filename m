Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445012;
	b=GvYNCNm7xCuZoaTknfVsO7ovHPE8C/WaWZcn4KxYeX5nSmYqwRdm3CS7TSrxKd0lzuB6
	 xyWB4eoXK+cmef/sUptr9IDYxKmxMFEsXmlXvsGI7MsHZQTtvTolBEECYSYm+a9AusSbr
	 WFEMIpt22FEP8qs57Lz4fw6Fy1LDjdmQfLdGlCbNugszB0K9ugBKPNPj7RvoHgQyRPiTw
	 gMC8MSO3tPaIfZmnX2hIYqiETZlqkPaBJvwKK3H9G7g/8klqYFewiHJ0xK3EvklOBnqrN
	 C/LQ1KON2CHC/wllwqzIJnOAkYBG+6z/qBYFdifVVFc3RAvMCEejKfBkH0I3943JCnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o4iCJALy43hBSErXv66r/FnvhPGELKb1EGXGXWZBIR0=;
	b=aSIlxryx3LD2M2p9zBm+Yl+jTNy2zGIBPNhrIItncrAGo9Pvts2mTKwIeZf+X7p1km75
	 RZj3YXg8oxpygHxvlCtCFFa6KRogwoZXK23g2wtJKCTOJKMeR8S/XOb2V4i6kjSR6XhLu
	 1p0dNKccviKOl5eR7MmiChoTsENmzhFlcjSu64ReJrQJ6aF0ZLc4sVn2naA+8WELyrn/+
	 /BhxZtPP1G+CqYfqg6XUZrYPrR+Wfr25gC1tjjbpAeFEibra79osi/l7aTjfPlhvE90/f
	 +x3NJ5yFuR6p6spDWHeDOVg8gX3vDaZx0rbw7rpFEzKVAnm+UQuhGoE7p3B+AmPdBEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=meC6BJo8;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523D606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0523D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=meC6BJo8
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1629135f8f.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793445010; x=1794049810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o4iCJALy43hBSErXv66r/FnvhPGELKb1EGXGXWZBIR0=;
        b=meC6BJo8VXx/Xi04nDNCcu5e1yqdfWi46y/14pNZMaERKO28AFvq37J5dV92JqHKI+
         itwocDGNYUY7Wc+J6+V31n0hi0SMg3R9xvB2TB/WPKs1UFojLU5nr/254GmQ+nlV7W+D
         0/UR/8QEpJGd9+Xs57/OCUrP1Emv+mV9IN/r6aklXQBayh5HAqunxfxA5SUSPkO9U2Q0
         /fnoHycVa+GfGfNocSJr8/uAWMKlT+arp5IRHTMNcZLAkeXLSV85jWhZ+guvMHPj9ORL
         U3sX3rMntvfB83T82dG7P5RCqjCDVZTrtepiwKhQ61wdXaON/PKqtE4m2W+MiKFEtwS8
         ysGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793445010; x=1794049810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o4iCJALy43hBSErXv66r/FnvhPGELKb1EGXGXWZBIR0=;
        b=jDJ4j3K34+Rb+xsfspNYzDBCUr1qMr8iVUTiofNxWGIFbvNi6tymVPYbrRpcxSrABK
         a7BZkXj2g6Cy8sPPYn+reg91hlE+aUuDmI5tTPTdMQsxR/K+8kckEGQPSLN2LGsQT+QC
         tmhG9kO/olDFEYRktSjYsDhaduiZfULXfyQBuB/zOfj9GZncOxa6GQxJfzmdA4kSXC7D
         96PuyeJVEVfTDqzbnzs63z0CFdLfyEAkkoYWEm0lH1VM9cdOavML5xpeQ3954C3oehMx
         3Ut0wJHuC7UcDHC2G0rADOMDG6GbIjqkOzgwcayBBUuT2kX1GIINgQjgUHDJnMDOO4Nw
         DREg==
X-Gm-Message-State: AFq9FYJrcIhUiENnLVxJHHsa4OpWLp/xAe59OxyvbTtnt7XDva4TrABL
	m1UWv8Huw+CIsHMUibDolEVN3IM8BibaCUMmFLbSqguGhikNzH2qAKUVA9lgmMP+
X-Gm-Gg: AYBFou16uYnP/xMYS7raM0H5gFLD0GOwodFy4zptI+1nl+cBvqRn1AID5izssJtHAoA
	bw/EVIxRITZS5uQ3hmPkZD+zaXJOJeV4YYhJS4seuE3mGE1iom8mvqhfA5awruLb6WpLpbSiSNI
	qq2r2X+T350eOjFRtU8paCqogZqcg8xaVaexxuBWC86OVyDxzRZOAfUvwsFBhcdr30WfGOQxxdv
	S8WVNWqMtcVrpP9lZQbsfTzIE+aZ7Mf1SmAtQqDuA7XXKxl1Kd6i5DX8LpwQyibpFb4zbmWd4Na
	bkJxxLHBbj+R2XRWiXPujl+c9eWryza5jgXnU/RcD2hd0kbaKgSWLFfLUV2K8ojgUmOZW52+KmY
	wyGbzpoXmvCEqoMChVYKYmxS9oX4OR2mnDDspLqC0bRsN0fhnuUDRZ9gDBXiGQYFmO2v3wCS3Qy
	kZiq232iPfuHpleawm7t4LkKYRN7pvkUztxk0wKzBKyHuYmWFixnMeowVznmvo8d6Or2gONgiWV
	s8R/yHmlWbqeX9oDUduYEol0LQOKzHRiB503WnddVEaUSxG/HthlKp5N3/gla1yZ875vN0g2O+N
	n4TU/DQJcOEBITo+RTB92Ae0NO4QInCPZODLGO9IM91K55el1hdoNGRx7ZEtYxI=
X-Received: by 2002:a05:6000:4810:b0:48e:f8d:8cab with SMTP id ffacd0b85a97d-48e6e2bcd79mr12582344f8f.4.1793445010377;
        Sat, 31 Oct 2026 04:10:10 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm8853670f8f.55.2026.10.31.04.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:10:09 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] object-file: use size_t in check_object_signature()
Date: Sat, 31 Oct 2026 12:09:57 +0100
Message-ID: <1f1d1dab569f2d8ad3087d8c877a87747e0b0c6a.1793444420.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793444420.git.gitter.spiros@gmail.com>
References: <cover.1793444420.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_object_signature() takes the object size as an "unsigned long",
while its callers pass a size_t from odb_read_object(), and the internal
function it calls, hash_object_file(), already accepts a size_t. So the
size is narrowed only here, and specifically on Windows where "long"
is 32 bits wide.

On platforms with 32-bit longs, hashing an object of 4GiB or more
truncates the size, causing it to hash only a prefix. This mismatch
results in valid objects being incorrectly flagged as corrupt by
callers like parse_object() or git fsck.

Use size_t for the size parameter, matching what callers
already provide.

Triggering this requires processing 4GiB or more of input on a platform
where "long" is 32 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 object-file.c | 2 +-
 object-file.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index c049bf13f7..3cb8f3fac1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -111,7 +111,7 @@ int format_object_header(char *str, size_t size, enum object_type type,
 }
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size,
+			   void *buf, size_t size,
 			   enum object_type type)
 {
 	const struct git_hash_algo *algo =
diff --git a/object-file.h b/object-file.h
index f44758c4f8..53c0e6df09 100644
--- a/object-file.h
+++ b/object-file.h
@@ -92,7 +92,7 @@ int format_object_header(char *str, size_t size, enum object_type type,
  * what we expected, but it might also indicate another error.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *map, unsigned long size,
+			   void *map, size_t size,
 			   enum object_type type);
 
 /**
-- 
2.53.0

