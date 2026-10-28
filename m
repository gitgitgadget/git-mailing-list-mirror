Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171509;
	b=dYS46GgBLgz4B3OY9d8Zmds6aqxGKoUIZLJwGkSJAcqkPmBJ6rjlLqOhgxRx1gIgSi2f
	 Du/3LhgYlF4UsTwMXB0Q9uiSH7P0EIpwABIEobslu+3UtQ+M4ZvNc5ddmfGBtACOJjAqX
	 opMONosE5zv9Poah2KPLwyyCWwt8ZNHYw2wQ0+qiaWI19T5Am/B5cbGUqBa9Kx+AAjRbD
	 L7Ql2RntGOc9AtpMhKO0HKDdvvFtvZ2Os3H9UMVbAyGQ9Ar0hySwyazuwBVeeD6qSvrDU
	 3rizU2OX1CrIkZOXpg+Djp1nZ+K32oYaHzvzaiht9iXokXj3xB4tIInAqlyuQomwecA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171509;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=CF7tw+1jNupSsy49qf4CNRDSyCE0E6vsFd1TXDK9/6E=;
	b=E0UkaF+Q+Vmc3XlDEmqEPdPsrW1e0uyjsToT9ah6Gb6NscGnTzcHE1Mbtzi3T3CiuVZs
	 e/eM9usl9FSOz7k+mOfsoDLD8s2BIiTyCbEBXeUd2WJEkMmlQ733QLGdceT/Av1LnHdOr
	 X6wOMI9WUNYgcS4G7+78jGXW5IBgshzsk2GpF8Nejvp2cSaUff4S03rKdkaPwXuFsey/1
	 X/p9rR38Y7fPsh+5n6E3F+N+lOheQhmJ3PGouOJn1dgGd+oArkiUb8pT4UhPXWv5ZPefA
	 Vfe5aSVrUs7bY4lM3SU5KTUxXb7IkyIu3ptPdwR4GKbN2C6xYXSjRk9ZhmERyKhIbrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Jyuep3mt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="tV/OETOn";
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554F606A324
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7554F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Jyuep3mt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tV/OETOn
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AFBAC7A0176
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:11:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 03:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793171507;
	 x=1793257907; bh=CF7tw+1jNupSsy49qf4CNRDSyCE0E6vsFd1TXDK9/6E=; b=
	Jyuep3mt6mPRQc7X9vht84PYtozWCflsQn/moeORAtejffgqCMBr14lUW4yWZgFg
	r0la2QGHYWlEYmzwA+cUoLUHJEgHfwmI7KsGEAfWs6eVN8SPe8KnVUlMMCzBldGx
	c7iXa5tqg4hk4BMEZE34WpMTGx4slxRFJ+Q/SGsnUnvpPTY+8/B+IbNWhbKX/zHx
	HHuoo9y2828a9CuFatSye2swQQNlyk9W5KzNQvCvL63qYGI85SyHMw8e+maWoRtN
	RhYuv1ZaLz72n+QZhbAR82YsaZ23Otgxrn6RgOVdXvwdNCriHKx2CUtDQ+llhnYD
	ctBTZX6yPqr1hjMoSWXcxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793171507; x=
	1793257907; bh=CF7tw+1jNupSsy49qf4CNRDSyCE0E6vsFd1TXDK9/6E=; b=t
	V/OETOnWTrXGW5ohqJWNjanZB47hjrEDcMp/1YWnMUsQH+MHI32Lz+41Ijwyluye
	YJ+Stm2s92xI/RKpwCmg3LXjRHFL9qlgD4AoFolrF7JmiykXf3rQ3qkOneULxZ9/
	OA40oQyIDZLH7t9nW+qiiQznX/MDgo0UFNIermxzQm2DQRj1GitOcQ6zzMiT6JbH
	E+8Id4TL9A/XSveWeDgq46JJGkjhQL3iLlFHq9goG6pKZ+NuDDv8FkoJv3FPu+gz
	rb1Rc/iYherUxsDlIha0QrcPALp1qmfh2jshkxAb3+2EBJInCJ9lRiInxzChwCqK
	3yQUx9rOgm1/32btnhMnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171507; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NvcQWbZ6xp3dWEam1eui/XlzlgK8smbfs8TIj/u8RbbaOXD
	3+15641CByGOOHo0WAR/5aOl/+paclrFZ7c358BLhivZrVIhprrPKVZqzYmYlpYb
	RPJy2W3xk0UYGae4EqnaP98NEfsCJYbvIwAie5kIWmYVbhm4oVsqQcEq18f8lXW9
	0UP1pahXbrUUOhsEWApu65rTaBBFZIVeWHp1H5yvLHZKvJrXay5PTKsIQRsdE9IG
	WjECM3OR6tRDHqsQN2sRONlVmkH+hpHRFJJg96xo8W6gTq6NrPOG0m+jMGKS5ZuP
	ZePspzeUJ5G9kN1FoOfQrFJzeNr+PjHsA4C8CJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:z0lB9YoZYud+xY5ygWvFfxzm3QTI+gNrW6yRJxHhSeI=:U5I5QBNKehukSIHNqV9tTpGZZwAqjCB6BDJ5HlQsMNo=;
X-ME-Sender: <xms:M6DhahshfNKwroT5biz2MsZxb5PWEVLy6QoESqI40qVbi7C0kgyXZw>
    <xme:M6Dhagf6D-xTT9Wx7EeXpO_udKsXhO-TyHg2hJCTDZo57bVThuz-mLOBL0Tiq7iQY
    gzjF3RQplUKIp3VrsVYl0QO_BzqAFBBmWJPk5AX0yDB-jiC9c757NU>
X-ME-Received: <xmr:M6Dhaia1LKIPIy5nFgGaWlFUQ0hJa0uW6FsQu7T-b6ock-yEmme79w>
X-ME-Proxy-Cause: dmFkZTGqwVb9Zx2a9Ezp4WSxT2i606UnuKLCIcx+aIpsTli2+PROVFaiaVmqRAwYTEUnMa
    7nXuRmwpJH244os2MYpz5V7sI8Zzn/p1xSVYrNge/wTGXF0GxVFLCS+u5eYAYn7nW7WgDG
    3asJ8Sm08YHb/1SnbEhq4Qd1ZvG/H7nxV1HihPgkcAVXPn+cti7ezW/bEMOiHzvLFwwNwf
    jDYbtuocEHXa/QyVHgIZOv3BtvQvpuSD/VgMb/AXh4KXyg1/0fxUWqJsvM4XcGhpLAmYKi
    74gsWhbknwQ7jFDsc6SBJ99KuhVXpJ6aeaiLW7/9uq1jyD7d5AtdrxiHW/V8f58i5s2UC2
    WM4KiF0igLkuCguX62PCY2UNlMTnLWOtFlCS0QQ78t9ReZ6k1PtRPLex3Gane1aK4yAx2U
    +IplngYgmjh7stzg823MTxyAlVMzjXDteum6tfaTDxV2p5+FwioDxgA6as+89W6oUySaYd
    LlWbNmpplIrLyZh7EVJyHxXtH7YKKndnaGr/BX5gbxl3k3+oLfq1NUQmvoI1Edjw0uilnU
    t51D3Lm6J+q5Larc7VT4r8vX0HKRpkSV/EPed+HRpexUY+2hiUnsNMFfZu/N7YAui/ERlC
    xRP7GiQ0sVrFoUcta9nW9nolyTVbQBBuYLeKazdKzrl9DZHK7l+9RvHVd8UQ
X-ME-Proxy: <xmx:M6DhajWOq1LztGjxrCZdsXp_-MXwibSUtCUhxM9DDQSXhnbIPtI7TQ>
    <xmx:M6DhakiocU2v-J6j5Pf4LgXcTI1XereHG7RMfv5Wa68sK0cNchgDsw>
    <xmx:M6DhahVCjUaj6TSk7kJd3FgEBtBXZUn0q7A63SaWeTCJ-aKYhoVgmQ>
    <xmx:M6DharOzdPDn-HOEExQuy9FztIvUfhUessmxppJq8CxM0qOe1UUrHQ>
    <xmx:M6Dhasd1DocaZ6hqBc5WZVGKfLrUSzCH4woCIAFg34jz3dN8TNIdfYyH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:11:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d3c603c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:11:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 08:11:39 +0100
Subject: [PATCH v3 1/6] odb/source-files: rename alternates-related
 functions
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
Message-Id: <20261028-pks-odb-files-reload-alternates-v3-1-011ddb64b626@pks.im>
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
In-Reply-To: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
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
index 5b4277fbfd3..d31da6e5d90 100644
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
2.56.0.341.g393f52fd96.dirty

