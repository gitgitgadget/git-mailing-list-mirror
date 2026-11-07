Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040987;
	b=wUjDIiToou3Pl9BEcR0+P0ZRyaK9IkV3DX1v5nPf3Ii9oNjJlwDX+Lfem6yaqTyKC9LB
	 OM9kCt22XNFOAPAcHu0S0dtT9/x8w+SAoV2E4xT0+x9XN/Ep5hgvfnq+oQXYR5WnAMXAx
	 Rww90SgwpF2slm6/KeNTgFojM2sFGwXfb1yxpIpBhth/3iSisIFXdy5wBiFYzg/r4HKzO
	 +joNBW6fKll3gRtTsAH+HjcCFpZtefag0/e1iiKVW2DcdiS98o1+3to7Qv3V0W729117a
	 Ky2C+O95ZHlFfjaYuLa2LxqtjoNSogATZ78nWhHQEQRnbK+v8b9R1w0gWP0gbeu/UQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=vkiRl3sJxf774/N6vtAbZA+jHktl/BZruLVxTRH4om8=;
	b=exeaWj1yq5oPNrMnPg+nz/PeodPAHwRF5VnnuI6PPfn+npsH+er3jqLeUKyYFUdm0Ouj
	 KwNVZkvERi/ipjSXK+vcEXl492VhWW8+IO4xRzQiGVLbJRmparyLZ8R2qF7swnczUx41U
	 pJOfUIOKJWjEE2FJgQw+zF6UVVVsidfLC1LvTCeBnSBunHi6OpeJYjRaO9B1P6dV4uybS
	 QVjB+QkbRATqDRZ40uylSgjZDmG/ACrWxkPwQWLcxzofDlgZEqd4I4/Ta2VLYpZFZsARg
	 tQMwDhCXvTHcEOVHYxAXS8jngfcl44SHER4gJBJqG15Ri5bSUBVEXpeXzRrebHJxflw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UvdQxCWw;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F1606A331
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4F1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UvdQxCWw
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d7791b00so10778645ad.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040987; x=1794645787; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vkiRl3sJxf774/N6vtAbZA+jHktl/BZruLVxTRH4om8=;
        b=UvdQxCWwYUFzIZg1K15c/Kr927o+0lu2gorXmwY8M61uv16pMRaoXiEbzTMCcCRdGF
         VaGvRsEVjP5tzPrTQ/e5rbY5S3UMzCAbhP1jkFCBaSumaK1p9QA4gUR/fPYtd7+lKlVF
         zuH8AkUSxodWKediWriqUUsUDfVzSjIfBDj4xeF4AdVbs2oxGxGvW59r81tfAsR4R7l2
         Z7RSDTsBNy34K4iDl8LaHvNIIRlhRCFlrVaGivKVXuP5LU2Qx9uGhak3lG67P0bitrd9
         N5JD2i2NDzTvIXSaQ1lF9/1NaU2TNs14Chx5UJnNlxYM/Qo+O+ciEFFE9VUTHgTikIFi
         VVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040987; x=1794645787;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkiRl3sJxf774/N6vtAbZA+jHktl/BZruLVxTRH4om8=;
        b=b3WA+UWtKWG0hoaj0JTsCDUzhWv8MLFF48ffC6OtgMjKDBWswjVUkrJ/qSjTFF3LPS
         U8FE3Q2aJTzQMpZpJBM3QZrGUDfTsoH1uXJFd/WvXRzqmn5lD4eUahS8itVi/Wh7hYgj
         ceYqhdrerl5yWI8v1Y8zY33crtQ/Xlf6Vd3y0hPcsoA5kmPmYawr/qaZv2OJdMTVY7UK
         XaA402YG7UlnFf31/PVxOL7X89olUutV4DdvcEc0Pvav9oRImIiep15dzLlh74hvIY9a
         vKDwKdrbcUx6U5IcTAOyekj3SHR5IQ2IUoBmttZzFUnI9Ka0O0QG3z5VdUpDhTdsYGbo
         Jzhw==
X-Gm-Message-State: APuU4Z+j9MBz9i80wPg8O/BUy0svhh+U20jzyEx8wPmM7KaNn84NupmQ
	CfmwNzo9FEOkKFmy71xvXXo0kJssRB25jJguYieT/vxZ7dWzm1tRGTiWWvkdfYtI
X-Gm-Gg: AYBFou2LtIg4jeSjgNs1iDooK41UZzqEZOX5iN3oaxLhoN+4OZjo2BJYxv50zHQsE3z
	XfNPWxax0tf89nyn7XFK5HyDN7DLzcZB2yPu1efQci5ZUP2ZpAHnJNGlh9++cfJ+oYORWh4oOyT
	9PbxPm5c9KSf6Fd2tVTZrjyFcc47eq9ht0cfhNNjhkm/3KiY4mx9ldVoNWFVuC4NXOm7HjqfVJa
	rvC/N7gytdRN8CfdWf42zmmubONvyFRKw8MvJaELRL4FgfiFjS6TjCAMkmZtCPxRMVQ19+ncdYn
	59GeMGBo9Jugfklx9fDP+hTstnMYupTDCyp4vkPW7rYFG93YiBH8rnBcS+lYhA1Mrqn4dvOzjwx
	wSW1gGX5JErv+162lNk2Qj+L8Tdf4RUJaCYrWShLC0rtwh2z2NYvXbf7t6MancBXgPGPVXj3r1K
	paaONF1g2CFFnj6fgbrIrSJngP4dn/h2S9Q7myr6tJQjTdQw/rVNjoLZ7vmqazKylYI0rttvUdM
	i5l51qD+NCECPjUk5u9VuTvIupSucbckbIzPz7CxE9B1tMf6G6IZlD2/4IvMztlLlQYtvca9/iZ
	EsbVVCVWTef4Cp6ktufuFFKO7bdFBhaWeQ==
X-Received: by 2002:a17:90b:2645:b0:3b0:accf:5c66 with SMTP id 98e67ed59e1d1-3b0db721fcemr4407558a91.49.1794040987017;
        Sat, 07 Nov 2026 00:43:07 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105854fa9sm2909188a91.15.2026.11.07.00.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:06 -0800 (PST)
Message-Id: <0faf4e884f09de348439179a86fd2a6de5d5124a.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:41 +0000
Subject: [PATCH 09/15] remote: handle NULL value for remotes.<group>
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A remotes.<group> without a value makes "git fetch <group>" and
"git push <group>" segfault: get_remote_group() dereferences the NULL
value as it splits the list of remotes.

Reject a missing value with config_error_nonbool(), and keep the
whole key for its message by skipping the "remotes." prefix into a
separate variable.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 remote.c                 | 5 ++++-
 t/t5506-remote-groups.sh | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 024cfc547d..4bd23ddac9 100644
--- a/remote.c
+++ b/remote.c
@@ -2191,8 +2191,11 @@ int get_remote_group(const char *key, const char *value,
 			    void *priv)
 {
 	struct remote_group_data *g = priv;
+	const char *group;
 
-	if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
+	if (skip_prefix(key, "remotes.", &group) && !strcmp(group, g->name)) {
+		if (!value)
+			return config_error_nonbool(key);
 		/* split list by white space */
 		while (*value) {
 			size_t wordlen = strcspn(value, " \t\n");
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 16e9a1bc2f..f11eb8511e 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -54,6 +54,11 @@ test_expect_success 'nonexistent group produces error' '
 	! repo_fetched two
 '
 
+test_expect_success 'remotes.<group> without a value is rejected' '
+	test_must_fail git -c remotes.valueless fetch valueless 2>err &&
+	test_grep "missing value for .remotes.valueless." err
+'
+
 test_expect_success 'updating group updates all members (remote update)' '
 	mark group-all &&
 	update_repos &&
-- 
gitgitgadget

