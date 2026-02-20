Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE7D2E6CCB
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575915; cv=none; b=HVLhAv79gK7lXlmlk0VrAdt8uDi3mYcynlWcfazl/uhyRL/ajBZFBVpZWotaud2NPReajN9W5lp/KKDZBUen8bxyKDWPPSepA2OxpdhrUxj9amSkLxy39JAgzwX1m2LW6HRL4wgyiDNl3XJVRemuBAJXRE5CogWkDkMIldPU11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575915; c=relaxed/simple;
	bh=dyZ32NmmxYlm/efp1Wi8JD3vnOR2aE8tCSe9cmvj1fA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7Ph+rifNvB01726JoQMP4P1dCRYF3wkERVJytAVkY9oUYGtvROYyuZNPD6A70v+G5gFPR+yRHkZBCghTDGLf/HQ73go0m4xDPYzp5XZNMb59302QwWTHUKRPVgAd6VV6TBeP6yJDKPvRVwo7tJEEt4hhq7sEaNhbi/0OoxrtUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tUO4T4PF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hd2JYnWR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tUO4T4PF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hd2JYnWR"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DED6D7A018E;
	Fri, 20 Feb 2026 03:25:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 20 Feb 2026 03:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575913;
	 x=1771662313; bh=oeFg/jQavj3NrsObTihySikFh+lqssPqZyopSfjYbu0=; b=
	tUO4T4PFo/Sq7Mf4DhW0Pfz2Nm9FfS2dkfTcqIhecV5ZgzT6kGZeNtFbvE0oKOqm
	you8Eq+/ue759LAZIVHHLpJ5Fo5SsURguSdBGrpaVB23O4i5UTQ0mBhtq5LAc+nj
	h7BzIU6SY9kfrWvY1ucDF0h8VA3iRdVQxas3G9ZTkQ+4xT7JytBbFR8Psu6an1Ml
	IlaMGsnsHdp4SkjACpW3TmxT8xvVa1qsZyxvOxgWtGQe1sDeYvqIiG5E6D6rhPBl
	y+3MxqQKMXy/AGTwFK61PgZ1w6kfHRQVuu+Lmcdi5Kb4Npe9OVl2/V1T7Punspqy
	GEMRGXmmIfFrzIFurPpXLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575913; x=
	1771662313; bh=oeFg/jQavj3NrsObTihySikFh+lqssPqZyopSfjYbu0=; b=h
	d2JYnWRjKPw+laxKdb7Qg6FCLNt6jnU+vneB1StdE+FRVlB7sPntbvx2fbqbGd6N
	BIILaii+0PwquG93jO+O0b78rCTK4jeU4w3lIRrtu15s/5QhSEi6Q0gD7XXKcZ16
	LWvO6UHijTcxgmC3iJZhBNIYYmdAcEgedSn/A0rv32Efo7nI9QdkguTWiahMjq5c
	Zrdi37joqJxy8HIns2mbCIJMVnA7ynCZYUbxlQ5GFNrVFk2vvZEK/fuA+eKggrkd
	oJsPB4Q5ovCV8CQfALWuYAjS2CvQhdPQhaWb5u0r9KtJ0w3QqYLeCoDyLugSVg2y
	UahRcLGZDIkimke8d2yQw==
X-ME-Sender: <xms:aRqYafARlGbpvEj_T2BS-VNgQ5LdKlZH17qCoPSeWwoXykhviPW9Mw>
    <xme:aRqYabji_DYjStpN3wyc1h3Ec5r8SrIHDZ2NKWXcis3Wn2-KvIL0qJppCzu9c4R6k
    2Av5J3IR8IykdvvKbc-kwbKRipcbwzSAf_qUm2N1reM6HfZl_i6>
X-ME-Received: <xmr:aRqYaYPORmMddcJnNwpoE7cysOM6e424_mYjh46Yhekloqte4qt5216pZgldb-NNh3_6wufYcwaM4I73D18JtV4yIWSBtx7Eg2isAqybaiKj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aRqYac7oTQV2VRHl-NNDgGOmDIFnY2qRxu-KD4p-TKOzZrDsVIj01w>
    <xmx:aRqYaW2xA20rGy6d9smkOhb71yQbdypDkAhykqCpNTo1Wub_IOsufw>
    <xmx:aRqYadZkDnDnYwSRgQDF7dMOu6HbOn1xOzpG3ljyG41yJ7m83yFpPg>
    <xmx:aRqYaeDllQnXh48yl2asmwQuX6vaj8SaecST-VOmZHdMENG_RTREOA>
    <xmx:aRqYaeyrlkhVG2vLg_nG_ucgPj3YVgjfR7_ixWsnhBMfdJMvz1W7K611>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:25:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 063f42ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:25:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:20 +0100
Subject: [PATCH 16/17] refs: replace `refs_for_each_namespaced_ref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-16-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_namespaced_ref()` with the newly
introduced `refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-backend.c |  8 ++++++--
 refs.c         | 11 -----------
 refs.h         |  8 --------
 upload-pack.c  | 11 +++++++----
 4 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 0122146df6..1a171c5c5a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -565,9 +565,13 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 		run_service(argv, 0);
 
 	} else {
+		struct refs_for_each_ref_options opts = {
+			.namespace = get_git_namespace(),
+		};
+
 		select_getanyfile(hdr);
-		refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
-					     NULL, show_text_ref, &buf);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      show_text_ref, &buf, &opts);
 		send_strbuf(hdr, "text/plain", &buf);
 	}
 	strbuf_release(&buf);
diff --git a/refs.c b/refs.c
index e11ee94013..28142fa967 100644
--- a/refs.c
+++ b/refs.c
@@ -1942,17 +1942,6 @@ int refs_for_each_replace_ref(struct ref_store *refs, refs_for_each_cb cb, void
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_namespaced_ref(struct ref_store *refs,
-				 const char **exclude_patterns,
-				 refs_for_each_cb cb, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.exclude_patterns = exclude_patterns,
-		.namespace = get_git_namespace(),
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index f408367b01..eae45ce15a 100644
--- a/refs.h
+++ b/refs.h
@@ -526,14 +526,6 @@ int refs_for_each_ref_in_prefixes(struct ref_store *refs,
 				  const struct refs_for_each_ref_options *opts,
 				  refs_for_each_cb cb, void *cb_data);
 
-/*
- * references matching any pattern in "exclude_patterns" are omitted from the
- * result set on a best-effort basis.
- */
-int refs_for_each_namespaced_ref(struct ref_store *refs,
-				 const char **exclude_patterns,
-				 refs_for_each_cb fn, void *cb_data);
-
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.
diff --git a/upload-pack.c b/upload-pack.c
index 7fe397b0d0..d21f0577f9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -610,7 +610,10 @@ static int allow_hidden_refs(enum allow_uor allow_uor)
 static void for_each_namespaced_ref_1(refs_for_each_cb fn,
 				      struct upload_pack_data *data)
 {
-	const char **excludes = NULL;
+	struct refs_for_each_ref_options opts = {
+		.namespace = get_git_namespace(),
+	};
+
 	/*
 	 * If `data->allow_uor` allows fetching hidden refs, we need to
 	 * mark all references (including hidden ones), to check in
@@ -621,10 +624,10 @@ static void for_each_namespaced_ref_1(refs_for_each_cb fn,
 	 * hidden references.
 	 */
 	if (allow_hidden_refs(data->allow_uor))
-		excludes = hidden_refs_to_excludes(&data->hidden_refs);
+		opts.exclude_patterns = hidden_refs_to_excludes(&data->hidden_refs);
 
-	refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
-				     excludes, fn, data);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      fn, data, &opts);
 }
 
 

-- 
2.53.0.414.gf7e9f6c205.dirty

