Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F34253958
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588304; cv=none; b=kcYfMHjZ86dT7S4N3dgA5Z2myl/Vq8a1MCjBde/wy5USltXCLLZmyYMuF3CU/+cvxBJway7IS+RoRkFqgrAd+VkbYaIP6Eh94he2Jp46yh58gh/q2a0PVuW6VAwbU132Zp69J2/KWlQfSol36ibdxo1pdJo37hFZ8QKpIikNBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588304; c=relaxed/simple;
	bh=RU6/HIMh4Crog22OjQIu1kGGiK8pY+GzUzXKWZ3xmR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=C1nEARXwN7Oe769y55pUfoAD1BZr/phMneBTlualRNxDMXULOs2vUCC+PnKFjO2Ux8tRjN95pDny9pSHcbMcCjdR681IzDrCa6e+R2YzjxAmdMwaN9m4lrR7c60pKUabX4i0OFss9s3nauiTB93Uol3AhX/atqANaXfiX4fJcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epMaR/KI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epMaR/KI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2e239ec0so994141f8f.0
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764588300; x=1765193100; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGYVnNwcQy8oS+15e8cdqrunOoMR8wqjuvUy7yLX+/A=;
        b=epMaR/KI9W0RKOf66zVfJYPDTSWyjaGqDdyZsvzX2SZ7+1h2isLzxDpurWSKfhnL2z
         jICFNN9KWJA4rcQy+QIMC636zYJXGKdcaAEpuD12JyzbWTfaRVSlPJwCsFlKTCUkFdr8
         DVIZSur0XM4EypjSDYYcp60Ci4JwrKFdkJKkpGuvViAD6GOJovX4g630nssvU+EepO5R
         StPJe4o20QnyodA+05lzwTmVUDBgcSLuxJ0c5i7coNorGnkPUWkD0kb/yMPY0bZNwTna
         OWzDsnge2uTa4yqbmmUrX/9xyN/SZXrTp8Sb9ZLVdcmBVXZ/ZJL4yp7sc7Wp3FxUX8bZ
         XbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764588300; x=1765193100;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGYVnNwcQy8oS+15e8cdqrunOoMR8wqjuvUy7yLX+/A=;
        b=nHjDiIaVATs0wxmPpw/RLnwrAL52Z2l3naGA+xBj8DNfUa2q4nCcG2EZXFeowMIkl8
         bDbqwZiKhOB0pYT7jEg/C3b4oXpNzcRQX3JXHGqpu/MnWiTWu3UeiR1dlQB9hw6JCWrm
         /ej9ptkdzz8etS2v6w1B8aqJmCbV1Bz48IH5DFsw3Uzjtb55LTDYjAY2Dxk66fowYzEL
         wZ1gbCv9tY9GOdg0jrPXy3a/Ucu2rxVA0JUReZLNaP5UUjDVD7z+4u/cDxQn62NQydmP
         E+xdyjiutrWEfkj2CEGMD5JNIWoV4B1HcJBmIe8EuT8jecrpfNDZMliK5G9XY2Fl3rvF
         hkOg==
X-Gm-Message-State: AOJu0Ywp8DLeGG/Ou54Qht6sf51/3SLxh5W9850D3Keoc+kiyC5gOLFo
	IHl/WnNiRauGY18TQW6mnDFLLlTv307iIBmAm9vHJTIyhuqHlyOzoQ+6
X-Gm-Gg: ASbGncuhySNtBMcbxA3xQo2LDU0sXuBprUbb+r2U/bUlauN1VBd6WChV+FXOBhuqc/e
	90x2QByzB6s9sQIHvA5qBsQYEJus/ybmxACRio9uC3KhxNzmBVliPGBFmcxECvDjDz3Q6ldpXr6
	OAYYuHHwelmzAPP0dU5sg6dCWfqv7kpyRnFEaaQ+IGAp7XXaEDPC+kNBilebjQOoHKVTx0XrIki
	/7zjrD+ZlLVQptOtE2iMiBfrH+ChttwXODTZM32Rscg8ousv++N9amMJmm9TUIGz8kKSqu1xIhA
	cZ7MkhX+CeJs2OlRwX1ZaxCrqSJvkzsVA92JYc46Eqje9odJUWn7y9dMX+K0rEG8gS1KukT44RP
	+tP7ZZmOkTaIyPPBWesyinwujOS9C5VZC9CZH/W6HoNz3UAzP95FlsdUgClbafBWHnV+MWXOmRh
	RQxAHb/zOO9tM=
X-Google-Smtp-Source: AGHT+IHncp4VRdK2O47eTUROlPeo9m6a3ZJntgQI7UPrHKKLFBzp2NN49HcSoMc3fRp8oW+W/1jrTg==
X-Received: by 2002:a05:6000:310d:b0:42b:2e39:6d58 with SMTP id ffacd0b85a97d-42cc1d51a80mr38676684f8f.51.1764588300238;
        Mon, 01 Dec 2025 03:25:00 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca40945sm26395595f8f.30.2025.12.01.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 03:24:59 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/2] refs: allow setting the reference directory
Date: Mon, 01 Dec 2025 12:24:57 +0100
Message-Id: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAl7LWkC/3XNwQ7CIAyA4VcxnMUAG5N58j2MBwZla9yYgYVol
 r27bPGwgx7/Nv06kwgBIZLLYSYBEkYcfY7ieCCm074FijY3EUxIzpmkD091P0HwegIawFGLgRY
 gzwKUsQwcyafPvMDXxt7uuTuM0xje25fE1+kX5PVvMHHKaGlcqevSqAbstR009iczDmQFk9gho
 vqDiIyopnaV48pVhdwjy7J8AAMMzDb9AAAA
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, gitster@pobox.com, toon@iotcl.com, 
 sunshine@sunshineco.com, Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5992; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=RU6/HIMh4Crog22OjQIu1kGGiK8pY+GzUzXKWZ3xmR4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGktewumXbqyqfph8Fvpum35JHaeGKw2NIIdH
 x1WLPPKGVp464kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpLXsLAAoJED7VnySO
 Rox/k5kL/3pFyeLaGZQ/64x/7N57JNkwWebE/fBbmEDv1+4ESWMgpqRdQxLoDtSFtIVQEab9VoH
 /aKt4Kjt+6hVTfz/+qGFGQLW3B93gmi4l80jSon3kaEhjaVIzCfQxpbYD/XRxBhLN4K38z1Bdbv
 F2gvx6gT/5MAJjhpaXYwc7Gh/4YGAiEQjc3Zlo1fxWkSGz0+a9Dpy2o5bRgobl9aALbl9GQMj94
 l6JXVH3zuO9zgOXJXVQRCaE6F0wggcVfrJujmr1RUf/CWgL7v7Ihpq6hOrOwTN8xUxXakIlqoyI
 SDwHPDDyKJgYOM3YG6e1l7eVpEZakQ9mXfhuB9lQJePqeevSAVTmzucJ1JkI+a1OHaRe/LoxOBj
 3FLj6QIe4JpYpWSXArNGRBKBtq6K0UaaWGxOeocz6mFvFYdB/SK1Oour72Hk1BnzPwVIq1zfeO4
 C/ax4PvdhjgG50SuUz4mcChA10LXP5HePtVAXU9Ybs+UPxyGFln2cSYJwzDRisUq//M565Emzj7
 HM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While Git allows users to select different reference backends, unlike
with objects, there is no flexibility in selecting the reference
directory. Currently, the reference format is obtained from the config
of the repository and the reference directory is set to the $GIT_DIR.

This patch series adds a new ENV variable 'GIT_REF_URI' which takes the
reference backend and path in a URI form:

    <reference_backend>://<URI-for-resource>

For e.g. 'reftable:///foo' or 'files://$GIT_DIR/ref_migration.0xBsa0'.

One use case for this is migration between different backends. On the
server side, migrating from the files backend to the newly introduced
reftable backend can be achieved by running 'git refs migrate'. However,
for large repositories with millions of references, this migration can
take from seconds to minutes.

For some background, at GitLab, the criteria for our migration was to
reduce the downtime of the migrate ideally to zero. So running 'git refs
migrate --ref-format=reftable' by itself wouldn't work, since it scales
with the number of references and we have repos with millions of
references, so we need to migrate without loosing any information. We
came up with the following plan:

  1. Run git-pack-refs(1) and note timestamp of the generated packed-refs
     file.
  2. Run git refs migrate –dry-run.
  3. If there are no ongoing reference requests (read/write)
     a. Lock the repository by blocking incoming requests (done on a
        layer above git, in Gitaly [1]).
     b. If the timestamp of the packed-refs file has changed, unlock
        the repo and repeat from step 1.
     c. Apply all the loose refs to the dry-run reftable folder (this
        requires support in Git to write refs to arbitrary folder).
     d. Move the reftable dry-run folder into the GIT_DIR.
     e. Swap the repo config
     f. Unlock repo access

Using such a route, scales much better since we only have to worry about
blocking the repository by O(ref written between #1 and #3a) and not
O(refs in repo). But for doing so, we need to be able to write to a
arbitrary reference backend + path. This is to add the missing
references to the dry-run reftable folder. This series, achieves that.

The first commit adds the required changes to create a 'ref_store' for a
given path. The second commit parses the URI if available when creating
the main ref store.

This is based on top of 9a2fb147f2 (Git 2.52, 2025-11-17).

[1]: https://gitlab.com/gitlab-org/gitaly

---
Changes in v3:
- Cleanup some stale code which wasn't removed.
- Localize strings which will be output to the user.
- Remove additional defensive checks which are not needed.
- Link to v2: https://patch.msgid.link/20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com

Changes in v2:
- Added more clarification and proper intent in the cover message.
- Changed the format from '<ref_backend>://<path>' to
  `<ref_backend>://<URI-for-resource>` as it much clearer.
- Added logic to check for the '//' in the provided URI and a test for
  the same.
- In the tests:
  - Use test_must_fail() instead of ! git
  - Fix looped tests not using the variables correctly and ensure that
    the test description is correct.
- Link to v1: https://patch.msgid.link/20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com

---
 Documentation/git.adoc |   8 ++++
 environment.h          |   1 +
 refs.c                 |  68 +++++++++++++++++++++++++--
 t/meson.build          |   1 +
 t/t1423-ref-backend.sh | 121 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 196 insertions(+), 3 deletions(-)

Karthik Nayak (2):
      refs: support obtaining ref_store for given dir
      refs: add GIT_REF_URI to specify reference backend and directory

Range-diff versus v2:

1:  5d37b2f0be = 1:  2b65f93e56 refs: support obtaining ref_store for given dir
2:  493c7ca098 ! 2:  d5dbb2f112 refs: add GIT_REF_URI to specify reference backend and directory
    @@ refs.c: static struct ref_store *get_ref_store_for_dir(struct repository *r,
     +	char *format_string;
     +	char *dir;
     +
    -+	if (!uri || !uri[0]) {
    -+		error("reference backend uri is empty");
    ++	if (!uri) {
    ++		error(_("reference backend uri is not provided"));
     +		goto cleanup;
     +	}
     +
     +	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
    -+		error("invalid reference backend uri format '%s'", uri);
    ++		error(_("invalid reference backend uri format '%s'"), uri);
     +		goto cleanup;
     +	}
     +
     +	format_string = ref_backend_info.items[0].string;
     +	if (!starts_with(ref_backend_info.items[1].string, "//")) {
    -+		error("invalid reference backend uri format '%s'", uri);
    ++		error(_("invalid reference backend uri format '%s'"), uri);
     +		goto cleanup;
     +	}
     +	dir = ref_backend_info.items[1].string + 2;
     +
    -+	format_string = ref_backend_info.items[0].string;
    -+	dir = ref_backend_info.items[1].string + 2;
    -+
    -+	if (!dir || !dir[0]) {
    -+		error("invalid path in uri '%s'", uri);
    ++	if (!dir[0]) {
    ++		error(_("invalid path in uri '%s'"), uri);
     +		goto cleanup;
     +	}
     +
     +	format = ref_storage_format_by_name(format_string);
     +	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
    -+		error("unknown reference backend '%s'", format_string);
    ++		error(_("unknown reference backend '%s'"), format_string);
     +		goto cleanup;
     +	}
     +
    @@ t/t1423-ref-backend.sh (new)
     +		GIT_REF_URI="" &&
     +		export GIT_REF_URI &&
     +		test_must_fail git refs list 2>err &&
    -+		test_grep "reference backend uri is empty" err
    ++		test_grep "invalid reference backend uri format" err
     +	)
     +'
     +


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik

