Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921712C0291
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097228; cv=none; b=hcbRQ4pevN+zzwipOzSYjFbx+Qw/4EObF12pu+Eu/u5Meoq0pWSou01zv9Y2SQZIKsi8ZL7KMcjI9U4IjeGNnSZ56MdtTUGFptfGe69RiyNHN7TXlYYve627iamsyYd9iiVC6TjgrofpIsDhiYG50Y1fXxK/R6/AuA1wk+zg/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097228; c=relaxed/simple;
	bh=L34Nn5oCsvrg7dAF7jN9X7JQIYQ83OmIeOfx8R2nOGk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=E9y6PchWX5hY9KlYU17pGbrHC7vBmCCX+PZpsJGtBYvzKr2MweLy6LSztBYEfT2k3I1id2SWxcxB8MGdZSDWVnVGsi9eh1weCzVxCflXvlcK9+bUwqNPRutYiZSaPtvmBSfbQroVTWRAuu5MM7PhkeRC1UakbD6Mq7xoOsEiEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDBw+3xc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDBw+3xc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b25dd7ab33so86071085a.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766097225; x=1766702025; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DKJqkGRdqM53SQ7UJtaJ+ClvzATP0eSqZlcM0OMFVhE=;
        b=LDBw+3xcwUg/mZdp2OSrFEyCpka6j+UvzTq+DoyfLqLpn/ME5lSUscOJsPiwO4uuE+
         ZdIT78CE9n7yUvoRhShPGEbOO8M/AOOelwwo5GOTFyuYSuDjdNwcxKmYEmUHET8g+25g
         IZB4ieTBc9eJs/Fy4KDDawjzR1eIpJkkXbMLpaYA6QP3OtiOvaegYYwup90j+W+lVn0P
         4DDZwVTotP0DVXAF42C2GFpO8bkg1vdHPriEiBmkG/Xee+BRilecAYyiorbJwmJ40fbU
         LZ6zO57Bp8HOaqQ7PxO5p/wGXG6QgVy0pNsTMpzd8USvLtokl985d5/3fAzeFBOpMhYc
         97TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097225; x=1766702025;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKJqkGRdqM53SQ7UJtaJ+ClvzATP0eSqZlcM0OMFVhE=;
        b=gOJvus53vGkEi4I3KUExM5G/iCIPqKR+cfAswLZ53x6AN6cdImT4eDQ2YVbiFdtOJA
         4PGDlUTrcwq0n/EV4e6ZIPnSeJ35XyIjesvFcLU1W1b4kWVYzYx6fxpqGUB42WZQgF4R
         1i6aNpNphoHXFzG4D48ssIrrs5xM/1SYv9KHSMOa7mgBqGLm/09hzLT7+HM7PzSXTe+O
         2OUkz4q0swb7+yaN2FV8ziFZh6QRHDV6mMW9PqOuzI6eyG/41E0bmxVdllIx/4rFta+x
         zSnzv5W66zgKpAfkzQJxG0GHt2x+UV3EHdFXdZsnoqCJoX8DwhEyDXs7ty+H3pviH4U8
         1OMQ==
X-Gm-Message-State: AOJu0YxypoHYEsR7vEmLtHKpZtKPDxzXP60xWMiGjOYa+adgf0+lA3/a
	FMbKYbdVID60XyuLeffZvQACaEBFhrUnTW/j0E8hdyJr6e55T2sLgWNjwqk8vM03
X-Gm-Gg: AY/fxX75ZS7DFAleJFxtl334BX10TRsWJcq3Ijj3dJzgOGePUJ51bVtZ62XBaCc/wT1
	kWp/MqRn5LKg548FINjHUvjWay1iHm2lt7qbS3I+7vOThyVZT/iyVzfQBnh/Rt05Yy6jtKpdcAZ
	lSONdmyCMRWc4inKplAKqjfYgrMZG0W1yFuvd0ySsx5XY/wDk/FPgVYkdV8qM5+70MK7R0nr4fH
	+jmmvikop+BCRaEFWpH7jY/8FfdWa4X2Zo2HaJzOwAyxVu3gc6Mw5LIVumCMRWAbABDVynFHX+4
	Gq/7lI044zgDY8k3tpSXgT8hdv2fegwUY6E5IoZZpv3HVfv/LsurHJ8aO44eHertJjYMNX58+A8
	Tc+sTnqN8kaK98nmbzs9dwroToJhI509mm4vkP72aj2xIro0uawxRWg2XX/BZy4ZTqRyw956szA
	LIcGXHc6Cw6+Ap
X-Google-Smtp-Source: AGHT+IHfX/3Xawvww9KQyzHi/ikCTvAerJOg61G0kLDCJTEDg2o3DFbyZAh8AkT4Fx8t8DYLvzag6A==
X-Received: by 2002:a05:620a:31a1:b0:8b5:9f70:d4e0 with SMTP id af79cd13be357-8c09011e5e3mr186656985a.88.1766097224932;
        Thu, 18 Dec 2025 14:33:44 -0800 (PST)
Received: from [127.0.0.1] ([20.109.86.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0968933d3sm44242485a.22.2025.12.18.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:33:44 -0800 (PST)
Message-Id: <pull.2134.git.git.1766097223647.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 22:33:43 +0000
Subject: [PATCH] bundle-uri: validate that bundle entries have a uri
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Sam Bostock <sam.bostock@shopify.com>,
    Sam Bostock <sam.bostock@shopify.com>

From: Sam Bostock <sam.bostock@shopify.com>

When a bundle list config file has a typo like 'url' instead of 'uri',
or simply omits the uri field, the bundle entry is created but
bundle->uri remains NULL. This causes a segfault when copy_uri_to_file()
passes the NULL to starts_with().

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
    bundle-uri: validate that bundle entries have a uri

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2134%2Fsambostock%2Fvalidate-bundle-uri-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2134/sambostock/validate-bundle-uri-v1
Pull-Request: https://github.com/git/git/pull/2134

 bundle-uri.c                | 22 +++++++++++++++++++++-
 t/t5750-bundle-uri-parse.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 57cccfc6b8..022e2109a6 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -89,7 +89,8 @@ static int summarize_bundle(struct remote_bundle_info *info, void *data)
 {
 	FILE *fp = data;
 	fprintf(fp, "[bundle \"%s\"]\n", info->id);
-	fprintf(fp, "\turi = %s\n", info->uri);
+	if (info->uri)
+		fprintf(fp, "\turi = %s\n", info->uri);
 
 	if (info->creationToken)
 		fprintf(fp, "\tcreationToken = %"PRIu64"\n", info->creationToken);
@@ -267,6 +268,19 @@ int bundle_uri_parse_config_format(const char *uri,
 		result = 1;
 	}
 
+	if (!result) {
+		struct hashmap_iter iter;
+		struct remote_bundle_info *bundle;
+
+		hashmap_for_each_entry(&list->bundles, &iter, bundle, ent) {
+			if (!bundle->uri) {
+				error(_("bundle list at '%s': bundle '%s' has no uri"),
+				      uri, bundle->id ? bundle->id : "<unknown>");
+				result = 1;
+			}
+		}
+	}
+
 	return result;
 }
 
@@ -751,6 +765,12 @@ static int fetch_bundle_uri_internal(struct repository *r,
 		return -1;
 	}
 
+	if (!bundle->uri) {
+		error(_("bundle '%s' has no uri"),
+		      bundle->id ? bundle->id : "<unknown>");
+		return -1;
+	}
+
 	if (!bundle->file &&
 	    !(bundle->file = find_temp_filename())) {
 		result = -1;
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 80a3f83ffb..294f9d9c64 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -286,4 +286,30 @@ test_expect_success 'parse config format edge cases: creationToken heuristic' '
 	grep "could not parse bundle list key creationToken with value '\''bogus'\''" err
 '
 
+test_expect_success 'parse config format: bundle with missing uri' '
+	cat >input <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "missing-uri"]
+		creationToken = 1
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config input 2>err &&
+	grep "bundle '\''missing-uri'\'' has no uri" err
+'
+
+test_expect_success 'parse config format: bundle with url instead of uri' '
+	cat >input <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "typo"]
+		url = https://example.com/bundle.bdl
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config input 2>err &&
+	grep "bundle '\''typo'\'' has no uri" err
+'
+
 test_done

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
