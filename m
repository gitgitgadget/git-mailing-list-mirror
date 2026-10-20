Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486517;
	b=KRO8Ykv6aVRwx4s+72kYJ6hE3zjTjQyoa/Cw3PrIcZ9ICjJQS84c4UwJB81hKml7hnv7
	 mR6K1NnGkRpUK+32dh8EdFVvhGcDE3tjUS1nVc0qdht+VX7qG7Ti57fjrDsJcUzqBk57/
	 veJShg9qt8j9N5qnSGV/Z6afgEwymapW4q4Nn54Cu52zVsJ7BrAOa7r0Utt/RiJ6A9T+4
	 jjPeU3FlSepieERLC0J5BtMxgclh9oM3zxql9E9uR9DG6hhJxfbyIOodtD7oUjWN3GWnz
	 M5yHzOUn0YboQvjKHeaYgz9yXSopMhJ1TNujZ2A7XTufhgOQlyeJSc0A6yXjW3OtMew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486517;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=sLeMSmWt7sagUFn+lVniXhs4kqqvHUOLbWroj1jkaAo=;
	b=ynX1iEH+mgLp3K1+zMaf2hDIU9/SnTW+DhY2Trz2nHndLlPwL0QuEx1YeZkYolAVV9pD
	 9THpLe5kUT/rt/UifcNM8/B0N9wkRDUN/akzO2b9jtgQ355pOY7hk2lhw0BHAqUV7yuYr
	 B5hBdV4RNMdZmHDa1nHWwjXFDM3UuB4FZVUXlUTIGjmm4s936xZFXYCRtaGUmGMgtQwSw
	 7nHfJoU0IV680NJg4y9ClupjkfNJ366G8/H5yPujqolo57TvaB2z7bRmYcG4iHA8Uy2wb
	 AlIMXFl4HDfeP5OxGSb/9fUFIxltYwvHTieOAhPPHuOxPBCZkWaBkCLjBgJSl+Hs5wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JB2yCQXu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yLHzAtx4;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC1606A325
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFC1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JB2yCQXu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yLHzAtx4
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B7EE14000F4
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 04:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792486511;
	 x=1792572911; bh=sLeMSmWt7sagUFn+lVniXhs4kqqvHUOLbWroj1jkaAo=; b=
	JB2yCQXuy37XEaSYWM28YiCtxvNViLXHqvabWqg6tbLrBUCnXdmolnn1KQ7bX1Gx
	WoAmMklNgzHUlWbzXbUBAvDWw5U9x0cm3EoBOuOuN9u6DWWFkDLtOOg+dyCvgZyz
	2JZX0WK15Q/CtJWlxN6ydOAAyMY0ucMCt/R1O1t2csvj+a3XckX8tESDOn0jcgUt
	jIYGpBRFHAV2tpgVocUkTA5kAvnnQ7dWFZE6gk+mMG74kupD+Pt9v9Todudkz5aK
	/QdbVGhg+fz2vC+SsMLilmJeXANroMWU3k+ti+9YX9QGhlh9G4sVEtvh4LL1Yi1I
	qsBjdsv3TMROE6qKuk2YLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792486511; x=
	1792572911; bh=sLeMSmWt7sagUFn+lVniXhs4kqqvHUOLbWroj1jkaAo=; b=y
	LHzAtx4yUmwhVDsIH+TZDSzJ3Z5k0shIFsVaD3VjQfDA7KvHobMP3ROfeEkzE6Gj
	TemqCURMl+BTDr4D7kFmak4igxIGnt1DzBn+gf2hrBQpajnaURZvKBn+aa6neWBl
	Rlkb5MYrDJOt2lniOrmTEvigwl/C6Yk1v8Fi2k5KhZOFQI0VY7GV9gn6JQjppubw
	H1vg6TbQBNpydjevvMU9EuxyZI4uwlMtllgWk5aCGaNKfKIpU/vaK7hBkA6hK/ZP
	d0KzGvSZbwiy/+MWRmRhgTAXP6CTetm4oac2sGVCx37NoNMcociyVQtEgTp+NwYr
	l/UUdO7LpOsvhaXjpGLKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486511; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AdpudI63tGke4DJVEsPb8tRsYf1nRoyArY6vfC7Q5Ph26GY
	1rEeGTQhWc0biZwJkRKWKLXrgtoDCF0V+YNQEpMt3Oi+MqKkhbpHSLAnZlBAdOna
	0LV92J1TZFZyjwrS4jhWu9ZYiW+X7Ucfx1WIoUUJaHjt/fnr/+y7CkFsgmILfr16
	v02thWz4n6cEOHjySBITf6SRYXppaV0X/kvIxMGq5E6CPu7F4KKu5Y9Oj/wgMwg8
	zMjcz3D0JWsYmt58gwCEC/GyGGRMRlqyiZLwilUpIeM9iCqX/b+jeB9MW2T5/5+T
	cYMsU0nemBWa5TC/ziOI0PqAJ3RizhoTD4Teo/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fQXS0UaA3KrCSPcU0AWGMq4s30aDCsp5UCIWVJtf14o=:5lmE24YU4oICLYg9mBAlqqFMCJoiyyBKCkMKkN8xmno=;
X-ME-Sender: <xms:byzXalrXEHD4jSPxK8XBMSvN1YJEshaukweMOkcwcFQdmF_u_d2FzQ>
    <xme:byzXaumhPhIsd4ItCoe92uEn685vrtEemkkx1gG94VE52nvaeqYqb2wadLonJt6pW
    q79lzPW0SJCu4LjG7QC2GgaDV2gzBbLy_IGBBb8jBCC6Vqiu5kbfVs>
X-ME-Received: <xmr:byzXan2xENfDCBA55NnxTlmCAtbRvghANT_LSWAkwJemLK1SYuCov4FIUo9PnDQ55otnpw>
X-ME-Proxy-Cause: dmFkZTFoIFHJYi/8mEifncP/99CaGIEh+CZ4oboDBzvwxeYIgdlZReIZN7sURLGY5ZTkQ1
    +zXt7kItoZHRIG+VznBXAfQS2EUcdfFpnrvBn8MGcidC3YXyF+gb81EQPjOiogV8gt8Rgi
    m32y3kJvoapWe0JmZe6PenTJEDOAGd3HZgCChmx9KB1Yg5ZvD3pmkPPikLl0WrcBW6sP0n
    AX4swUUpnFaiPBDQJvX3ESkEm8PjR0SuEFuX7uuj1wHP8nNJPaxvnwv4y/l+154Z/6fOGa
    xSncmhxRE4m7RevGNNz7N6uBBFQ/YFLDyEK9/VEG6gins17s0NOqLMEKU1sPzGOzdBCZdN
    NB0LwxDJtAYdFGUG3HGStABVDthQqFxkbb3RzfhFTgWOVizriteIP8Qk6BYzy58Q5hEALW
    EkTy/jPRnIV896wobFUpxm6GjHX7X69kT6BOuhrnAW7AMC9n6mgtApTb96l5fyaXmoFiHg
    BWvSujQjh2n2RwhAIOYkoKsdRDhdc998Na+LRdQ/K0i/5kU1lVLLGcVnK0WL/kE/0p9Zs3
    O647iZWYtGoPB70wmgNRMmukrgkhug9tGhRK4HxPn6t6LAf4Zmi5u4vxKfDWPWl9FsRkJI
    WwBP70c/KWD6SsIUOwlXA10W6rUzc8cl/rYEuDLNyNSC7COr1KYIaOA4+WZw
X-ME-Proxy: <xmx:byzXamBhQ__qcYVk1Z0zfQEn4L5mporQLd9-bl-Fsm0xIRkOtNjIQQ>
    <xmx:byzXakyr0d6vTTO_uLxRJVCkyuFC-FJXd_jJ6mfSzNXnPDs6cCCiDA>
    <xmx:byzXakkk59KL_R4RiY6Kx-5VSKx4ICNzzpu_RO6TuBo-oKb6ghVhUA>
    <xmx:byzXapEST0fovseVqBche7myYve9mbpJcHVBzCZoZdaY7ao0sUdeSQ>
    <xmx:byzXatLIUthm2dHY5y-IM05jl9g9w4WuIePHhyta4s3Vm_qk0Ux6xrah>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d6f38eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Oct 2026 08:55:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Oct 2026 10:54:52 +0200
Subject: [PATCH 1/4] odb/source-files: rename alternates-related functions
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
Message-Id: <20261020-pks-odb-files-reload-alternates-v1-1-d9e156323836@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
In-Reply-To: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The functions that prepare and add alternates in the "files" backend
were originally part of the object database layer, which explains why
they still have an "odb_" prefix. That prefix does not make much sense
anymore now that those are part of the "files" backend.

Drop the prefix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 5b4277fbfd..d31da6e5d9 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -348,9 +348,9 @@ static int read_alternates(const char *object_dir, struct strvec *out)
 	return 0;
 }
 
-static void odb_add_alternate_recursively(struct odb_source_files *files,
-					  const char *path,
-					  int depth)
+static void add_alternate_recursively(struct odb_source_files *files,
+				      const char *path,
+				      int depth)
 {
 	struct odb_files_dir *alternate;
 	struct strvec alternates = STRVEC_INIT;
@@ -377,15 +377,15 @@ static void odb_add_alternate_recursively(struct odb_source_files *files,
 		      path);
 	} else {
 		for (size_t i = 0; i < alternates.nr; i++)
-			odb_add_alternate_recursively(files, alternates.v[i], depth + 1);
+			add_alternate_recursively(files, alternates.v[i], depth + 1);
 	}
 
  out:
 	strvec_clear(&alternates);
 }
 
-static void odb_prepare_alternates(struct odb_source_files *files,
-				   const char *alternate_db)
+static void prepare_alternates(struct odb_source_files *files,
+			       const char *alternate_db)
 {
 	struct strvec alternates = STRVEC_INIT;
 
@@ -393,7 +393,7 @@ static void odb_prepare_alternates(struct odb_source_files *files,
 	read_alternates(files->dirs->abspath, &alternates);
 
 	for (size_t i = 0; i < alternates.nr; i++)
-		odb_add_alternate_recursively(files, alternates.v[i], 0);
+		add_alternate_recursively(files, alternates.v[i], 0);
 
 	strvec_clear(&alternates);
 }
@@ -410,7 +410,7 @@ static void odb_source_files_prepare(struct odb_source *source,
 	 * for the lifetime of the process.
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES)
-		odb_prepare_alternates(files, NULL);
+		prepare_alternates(files, NULL);
 
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
 		odb_source_prepare(&dir->loose->base, flags);
@@ -1299,7 +1299,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	if (!is_absolute_path(object_dir))
 		chdir_notify_register(odb_source_files_reparent, files);
 
-	odb_prepare_alternates(files, alternates);
+	prepare_alternates(files, alternates);
 
 	free(object_dir);
 	free(alternates);

-- 
2.56.0.269.g68944adf51.dirty

