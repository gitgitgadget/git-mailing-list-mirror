Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662677;
	b=ZOJ7xqX7SQcTUvTkil5dmNA3R/nLiUHBT69pjBJ08IW6+8O1sXxDVJt85ywq9l/hNYB9
	 OVHtxCMSjfwcGz3Xxakpvi5CDU7VBWIBiGp/eGd3qk1OJBLVtHiVsSjActWprmSv+FG52
	 We4/48YfPh30Hn3HRnotD7LOrGVDW7eVdLISRUvY2guOFQ9DWwe2uHPANhCgwLhUjbVLc
	 5tJLc3VnKCX6NCuiUrugFPdn6F30P7yKqiWGe4Lzv9Zw2w2wT9tvwKsRPltYsWoNEV5fT
	 cJdz5SoQpHFDR8XFjdczMoQxbZVeNo0jbhChpHuWvSudrJzUcMC6sTjJ7Di1I8ts4Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
	b=X0KlRXfeJXt26mpCMEOTHXlxHyYcmx0dNiZzPlnIhsoiLa3U0uc5ooYAGrlSfOeqf+RO
	 WYTcVAepg8q3UAhT4WeyVUrqtpy3C0RAVSR+NYgVYCZ+09/U0JJOka5UiKZWFz4Gf42jp
	 PnTKWaCIDEGvMTM+R5w/4BbaFtNe+6Kidsw3SCxu1LlPNGCEHuEjng/fGK4RhQNwT+ZFI
	 j43W1g1AFcjBytMG0FNdakbxQ7C8LiXIQ7D1zZsFQVCcPQyGmPBNc2FhzBCrkn1D/cQ87
	 saQ0+ipK8SqQkgknXmBnQxvm1ZiCp7lW668Vzdb6afQjHIc0HTvSBiID9bswsMTfJiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFMtRLVj;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166A606A329
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 13:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3166A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFMtRLVj
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-48ed0b68895so1936618fac.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 05:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794662676; x=1795267476; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
        b=rFMtRLVjh9yXjUIZoMX9cFrun6quUS1/LsbRYujyHPIG0H3G3RNM0AZ5IbEEL8xeC4
         4breWffqyyjgp0B5V40joydIlT7yr5Yocu7QqxcwvQBdAKgieOgxBAjKL1zTUsLcV4rY
         FPE2sFA2AljNnqUMXADOUwtAFWl3nxAN/jGsMu1LPG/T0aHr+tMckytB6Ft0s1vpiMcJ
         Q6LidE/CNlPHfClMnZUW3JorhImCo3ZsuDIXmnfNeRjiw/ZWbBVwSPUrOCJ6kzIflz5c
         pL97eFKzUkUtBlKUArQm7XpoxqfHsyh6zIrIRiclq7Fppmb2iNone/Iv1iEYhkSrdp7Z
         9bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662676; x=1795267476;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
        b=SB03kNwweDYo2WMBq+RUcmk7zHzayLCGKQu27niZvOQr/0ySkPTFuEcIyDfmdG1So4
         xPe/W4fCUbx/15+KoAuueSvLsepQDze3suWqiGmYEWyZFLTAseqLVmEcMWhf2QSBL+7R
         SvFgh0hwoqWZeQqaW+7ewLdtLpybRNZmOqx6/dKggCYjiU7M0fjCVG+fhFQySH9Eu4K5
         WFrMAfKuupb/8i3kUEssRLa3fE3S3458BC2RkM9T8s/AJHC9yDhiKdAdXaXpW1azk6MO
         VRTobGXiRUbko84QAeYeUbVWMsYHPz9jBzCzfbbf8+IzQxwDCvK+wQ6XvPp/H0ycdw3e
         9fUg==
X-Gm-Message-State: APuU4Z8hO8d0E0EHUAwpl6AXN8Zu/mIIZQrCJHrk5jc9LJqDHPZExZNE
	cysZt22LiHQIK3bvcez7SbgJEh5vfEKj+axJ0BGvXny8QnMmmDWkmYotUbF11Q==
X-Gm-Gg: AYBFou240NdBp5NiyqdpacbLYYlcJiu4z61Dd2MslODNk4TXFByFK4NRQ2MTnvSz8j6
	EgaTUG+4Kg1kPBNFOLAlBKl1d8IuCS2y3AhzAKdSt8WzROoL2mT4O+M41KkfAtjh2TtZjuWhoyT
	jAK8K/po7geAuxFBL/hfvCJnC8quJAyh1n42qcoiSiUsJuANYtl9yfWGk1fvBo18aA4b0sfQV33
	SNV1RSUCWN3GPCHZ1YKqaJarkckUgZVyzybAk9XW3X3EDUmEbDQFJmxrwjkOckvWNLcmGSH/ZOl
	HMNCBoYexC71TpJjzwOfouBJFGNCv382idQw+Hdme4uXVRVO+7lW/+/vOGqrQa84qgKduupJJex
	svgCKgGUpLloZOWrNGnnNTLFWf/mmX90deshnfojU60aRCTrTSgCdZ9OqncocbcW3yt8xpUqIoT
	Y93i7W59aavEXgVnAMDbkogBHjjRdpJxDridAHcg1MqUgamj4eCW67ZnfJBQryvYnW0wyrOvFO4
	1WBU/0k6/eQb8dp4vogzw2Mclrdu+NQ4pbdFEOfxsWjqBvBd/6xdI68Rv5pHM3Km+r/sgSRVVcB
	1XEU+6PiPKgfGdhXo46bssqjE6DEphoZ
X-Received: by 2002:a05:6870:6c14:b0:4a8:d5f:a1f9 with SMTP id 586e51a60fabf-4afdf4edb45mr4478106fac.30.1794662676017;
        Sat, 14 Nov 2026 05:24:36 -0800 (PST)
Received: from [127.0.0.1] ([20.64.107.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2288f59sm3349248fac.9.2026.11.14.05.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:24:34 -0800 (PST)
Message-Id: <25d2441ce75e0794e8df4d2b6d6c4b6d50902174.1794662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v7.git.git.1794662670.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v7.git.git.1794662670.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 13:24:27 +0000
Subject: [PATCH v7 1/4] branch: move the deleteMerged opt-out check into a
 helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A later commit adds "git branch --delete-integrated", which deletes
branches whose tips are not reachable from their upstream. Those must
honor branch.<name>.deleteMerged=false as well. Move the check into a
helper so it can be used in both places.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b536b619bb..2c1a8b8395 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -824,6 +824,23 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+static bool branch_opted_out(struct strbuf *key, const char *branch_name,
+			     unsigned int flags)
+{
+	int opt_out;
+
+	strbuf_reset(key);
+	strbuf_addf(key, "branch.%s.deletemerged", branch_name);
+	if (repo_config_get_bool(the_repository, key->buf, &opt_out) ||
+	    opt_out)
+		return false;
+	if (!(flags & DELETE_BRANCH_QUIET))
+		fprintf(stderr,
+			_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+			branch_name, branch_name);
+	return true;
+}
+
 static int delete_merged_branches(const struct strvec *upstreams,
 				 const char **argv, unsigned int flags)
 {
@@ -852,7 +869,6 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
-		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -870,18 +886,8 @@ static int delete_merged_branches(const struct strvec *upstreams,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
-		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
-		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
-		    !opt_out) {
-			if (!(flags & DELETE_BRANCH_QUIET))
-				fprintf(stderr,
-					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
-					branch_name, branch_name);
-			continue;
-		}
-
-		strset_add(&deletable_branch_names, branch_name);
+		if (!branch_opted_out(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
 	}
 
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
-- 
gitgitgadget

