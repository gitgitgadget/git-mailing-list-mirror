Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279623;
	b=LOIx+SysJdNXeFISB8FbWl4OVXCgU3MZPNW9KjdurwooghxYBhHtHjwnxL/ZB8NacEqJ
	 4oKR37MMSYy3JpXIQy0GVhY7U00gRa5m5WzlU8+X4aQrSE1RiqoQrfppfCNSUnRvTw8th
	 QBhtl1d16ePCYwLmuIN5gy/RJjYblW3SjcCF20ZjIY/d4eYYgtQXo4y+rV1TNTkqPpaWW
	 mXXDqSSxu2/Sq3cJPZwPny4b70xo6YtqMZX1ANkIFd9HLd/bhf+Q182IMku7SpiqAJ5GS
	 XL4z4HJchwJxQeiAt6YgFZjA4gs8X+MwbXnpQt0BRkfiSwEmzc33CTksOuiEuvc+tdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ccRXohapoGrF44EK+Pjbx78IG/gDpGV6aZsG7rx2Jw=;
	b=lc7lIkZvH4npBM2cC2TvEpvCil7SJNZE8mOqBJo8fA+iCih5A9En8UhgRPBhopiHBMA8
	 bYicoECd+AY4GboySEI+R6cY0y5Meai6B8imCQ4Q8TZX6bV2+2RHhi4RZFKsSw3e6gP7/
	 0CKFTFdX3u9wUPJ+SyQ4x2fdxcHvxU2hSsKi2HZycz6fInhmJZXLqz6NVPPllPTrtOVPj
	 OMZ9Yd28dbaH8HKIZYbzczgDFfVHbXGH6LNhPXoe+CyGL4obZumzKIt/rpITzj2ZW/XRB
	 If2tpSuQx8zDzqI6zQVS0ItmSGG35cN2iKGsHPbZnksPyLwDWqqYrehHWTUrq07WG3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwQ4wbPz;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54D606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A54D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwQ4wbPz
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so15822735e9.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793279621; x=1793884421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ccRXohapoGrF44EK+Pjbx78IG/gDpGV6aZsG7rx2Jw=;
        b=CwQ4wbPz108mJxF1bx5xS4xw0feafKC9PJ08FicyF/hrKR5mmKw5zZNSKPfMp30Vjt
         i74hxyjNt5Nuu/qOWhbEyHb53LovEMVdFTH7CTdjZAdfl5uKlyX1t8LlF7+48d5swVhB
         MNK3/vMnBJdHzk+yG/wV//UEkMM+yq+ogXkoYFQ7oAS/qM26w3AEW2uJrLNfvJZZt0QZ
         sH22Pmi01R30kF6C17KdTK01MA1DJKS+GsBzzl3+5XPt5hpFGICXDI6v3s68m4v6ZVhl
         3TQNVY1U78xuw0TzFSC+HJoyTijCr0RaSAPYmO1gWAE5hcHNBkn4AaxelcuS/0HCpokS
         cOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279621; x=1793884421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ccRXohapoGrF44EK+Pjbx78IG/gDpGV6aZsG7rx2Jw=;
        b=Xwhp8pxgGoGEIbyRYXP5501tnA7cpkqnt5FiAS+WXNlW8jj7lBsGYZ9BwRnIx48fVQ
         8iFgVsejomnYKQS3e/yQcMiaHr3/nm5dAoT1f5GzmAUfby1RSjqzk6XGmB4GGIpjci5u
         sPpLPWaB5WwSjNeWN8+YNPSRPzaJq+4smsr2FA4PUiJbohpUIYsdrbAaqD0ttjFthZc4
         OsNor8AAopy8d1JO17RSok4XFSFfDvMsSf7m4Aos3JBsOsKVcBPuq4lbXkRihDY8HAw/
         pIF/PCsoyCOMFESPDj86JWfXJ1wdWSPrFtT0r+55N/FoDyXx3YT2UgE7waPPKATiewLX
         hsWg==
X-Gm-Message-State: AFq9FYLkUZAx4VpgKYX+JWAfGc8haWEv9qKEDOZ0yT/2CGxpXUjgO6JR
	ueH4BQYagoL8O4jujnEKmKD1Z87WTRa+Q9vmYgZfe5BsPpUqssyhLwh3ULZ1bUDn37g=
X-Gm-Gg: AYBFou1eTwMchS8f/1GMcRLEnOGmvGG9kCamTfmGvVxPHchgMxBMf3AtvWWOVCAM5j7
	1ust38tzXnx5CRdcYyBbPIX7I6qIdCxKFrAng4ELconf/UJ2I2BEWhTicTff56J5U/EoJO6/90o
	WkTm8QoPNnQm6kbcEIIr2yiUPmP9FxN9k6+WWeQXtEZkXQKSvFTOxZRuCYrxxxv7spgT/JiWi50
	iRLURqBmkgL3ZMFGmbER3zxATZ20vCzEIlYOdAE2xlUbi9m686sb34nDRsEHmv+3HnUBRu5DvE4
	22mcljCxLht3Gr2NKM6Sq+G8806+I8ycD01WCa9I/t6EJzgyECpmPoQELJDvrBKlLphwadQeYct
	Uc8v+bB77aA4PjHjIquzz2+uK5rR3HF0ZOWOTObFvfWBZQL2QELnoRWsh1BU+bTXrJF4dEE6Yu3
	C/ygdoG20F+s/PXpB3i43XI8butQC3fDO49Vg5y3YWGx4iLhTH334rnD1WW5EPTAo8FlbF0nX3W
	y7QuxokbKo+ETllsmSKc6wUsUZNFsVIbalQNvj56FlOwFXDxeNqwTrTYtIN9euG3XZdGBN2d3TB
	3pj/CSvxQNKeKPrNx3rbEMLqjLvyZCxitJEjXXtKk+qCcWwlKJBQHPJ9izNXlFjld/vIrOB6dWr
	Y1cIAKSNf4TTUxsUjCMYorAwdrjvnz0X/aq+bSG657WkLugv0Ytwmjj9ldDhTSs0RjWTnu42uq4
	rV4PV1uhj/PsGPLBVI1oFISAv2nzZ1GT1GxE4FaJxB6yWHfQ==
X-Received: by 2002:a05:600c:3510:b0:4a9:18f4:925e with SMTP id 5b1f17b1804b1-4a966774dc4mr124478275e9.18.1793279621363;
        Thu, 29 Oct 2026 06:13:41 -0700 (PDT)
Received: from localhost.localdomain ([105.113.99.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm72386865e9.5.2026.10.29.06.13.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 06:13:40 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v2] bundle-uri: stop using the_repository
Date: Thu, 29 Oct 2026 14:13:25 +0100
Message-ID: <20261029131325.79176-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <auM3DGcWTL5OdRnD@pks.im>
References: <auM3DGcWTL5OdRnD@pks.im>
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

unbundle_from_file() receives r and unbundles the objects into
it, but reads and writes the refs in the_repository.
fetch_bundle_uri() also has r, but uses the_repository for its
trace2 region. find_temp_filename() and copy_uri_to_file() also
use the_repository, even though their only caller,
fetch_bundle_uri_internal(), has r.

Use r in all of these places, passing it to find_temp_filename()
and copy_uri_to_file(). With that, bundle-uri.c no longer uses
the_repository, so drop USE_THE_REPOSITORY_VARIABLE.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v1:
- Also pass the repository to find_temp_filename() and
  copy_uri_to_file(), and drop USE_THE_REPOSITORY_VARIABLE,
  as suggested by Patrick.

Thanks, Patrick, for the suggestion and the diff, and Karthik
for the review.

unbundle_from_file() still depends on the_repository through
fetch_pack_fsck_objects(), which reads fetch.fsckObjects and
transfer.fsckObjects from the_repository's config.

 bundle-uri.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 2bb2eb99e4..9797eaed9a 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -286,7 +285,7 @@ int bundle_uri_parse_config_format(const char *uri,
 	return result;
 }
 
-static char *find_temp_filename(void)
+static char *find_temp_filename(struct repository *r)
 {
 	int fd;
 	struct strbuf name = STRBUF_INIT;
@@ -294,7 +293,7 @@ static char *find_temp_filename(void)
 	 * Find a temporary filename that is available. This is briefly
 	 * racy, but unlikely to collide.
 	 */
-	fd = odb_mkstemp(the_repository->objects, &name,
+	fd = odb_mkstemp(r->objects, &name,
 			 "bundles/tmp_uri_XXXXXX");
 	if (fd < 0) {
 		warning(_("failed to create temporary file"));
@@ -384,7 +383,8 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 	return result;
 }
 
-static int copy_uri_to_file(const char *filename, const char *uri)
+static int copy_uri_to_file(struct repository *r,
+			    const char *filename, const char *uri)
 {
 	const char *out;
 
@@ -396,7 +396,7 @@ static int copy_uri_to_file(const char *filename, const char *uri)
 		uri = out;
 
 	/* Copy as a file */
-	return copy_file(the_repository, filename, uri, 0);
+	return copy_file(r, filename, uri, 0);
 }
 
 static int unbundle_from_file(struct repository *r, const char *file)
@@ -448,9 +448,9 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		strbuf_setlen(&bundle_ref, bundle_prefix_len);
 		strbuf_addstr(&bundle_ref, branch_name);
 
-		has_old = !refs_read_ref(get_main_ref_store(the_repository),
+		has_old = !refs_read_ref(get_main_ref_store(r),
 					 bundle_ref.buf, &old_oid);
-		refs_update_ref(get_main_ref_store(the_repository),
+		refs_update_ref(get_main_ref_store(r),
 				"fetched bundle", bundle_ref.buf, oid,
 				has_old ? &old_oid : NULL,
 				0, UPDATE_REFS_MSG_ON_ERR);
@@ -774,12 +774,12 @@ static int fetch_bundle_uri_internal(struct repository *r,
 	}
 
 	if (!bundle->file &&
-	    !(bundle->file = find_temp_filename())) {
+	    !(bundle->file = find_temp_filename(r))) {
 		result = -1;
 		goto cleanup;
 	}
 
-	if ((result = copy_uri_to_file(bundle->file, bundle->uri))) {
+	if ((result = copy_uri_to_file(r, bundle->file, bundle->uri))) {
 		warning(_("failed to download bundle from URI '%s'"), bundle->uri);
 		goto cleanup;
 	}
@@ -859,7 +859,7 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
 		.id = xstrdup(""),
 	};
 
-	trace2_region_enter("fetch", "fetch-bundle-uri", the_repository);
+	trace2_region_enter("fetch", "fetch-bundle-uri", r);
 
 	init_bundle_list(&list);
 
@@ -886,7 +886,7 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
 	for_all_bundles_in_list(&list, unlink_bundle, NULL);
 	clear_bundle_list(&list);
 	clear_remote_bundle_info(&bundle, NULL);
-	trace2_region_leave("fetch", "fetch-bundle-uri", the_repository);
+	trace2_region_leave("fetch", "fetch-bundle-uri", r);
 	return result;
 }
 

base-commit: 37b3475fb530c14109211faca33716a173db61ed
-- 
2.56.0

