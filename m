Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184670;
	b=DgoWL1gH6dUB18xSmXwF5G6f2++tVO/S8Eaa1PjUGJt7RGW5mM75WHJE5OrBrHKE3TEp
	 Krio4ph1zy6MOCrp2zZrYEgxvFQkQ1Ebr9OuFqjUsj312w4GvWLs1P9TTbepBaDcjU8AO
	 gpfKZcEmOsk8IkX4dVVT/RhRxvs1SWqKeRzE+Q1LniHDa2di/f3l4SAIlti2Rj0+C6gbb
	 XzQHnKSB8lqShrHlxeNGe/LNR9b70TljVV2IEeGijB7YwEULQF9N4mPKh4NVQPwvKfEhs
	 sbSWwe45/VQbVldndn/GLF+8kE6DWod/KgAQlz4FEptzfRiByHs2q3ewmBxloHNuWYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
	b=QgfOn49Q69OeXJBYm/Xtr0YPxZUC4hW+CiK/927hDUY7ncZM3HqcHcEafbXxiF910EpZ
	 vcyRPP4JjUSUtgYwlrflIs+IduoEYK48UzOivmti4RvafJMHpdUn2AWCtSWmY5h/5dSne
	 cKPh3vAPsHQX16BFuAAhuFsWYAobL0/cBCHH8pBoyUb4sLfciP8D2+88bT8Q5xD8Ker/L
	 jXCMQp9jjsieZPNqxH4kQLfkq+82XNeNFnkrEqSS33ClQAMG8HtPPj6tcFVSBYHdl4+SS
	 uQ7wa+UhlgpdmDqXYyyDk38UvFGmuzo/kEuH+fC3SOpUSThbYJ9RV4Ee0i/FrUCoP8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fd6gLdj9;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD4606A336
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBD4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fd6gLdj9
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15dd124bbe7so2045500c88.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795184669; x=1795789469; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
        b=fd6gLdj9SEyGYURxw23diigzOgQ8hxQMF5hGh0yTA525oq2xTxjdfgmVG7r7djJPvo
         Xmih5C76+aLugJ2pOTfcmd2ZjroMWLlyR9gYlklGN/hMdkdNIHA0cOWT0ehoVYf2+Jxj
         crnW+Rent3cMH64L5DB774SvINTKEa1+YL4Clmu9AQ2ghTn7AKiFOV09HA3oLErev+qI
         ccnXN6JuCfFqCdlXQxh4dDcEVBqfky36BrBMUbnzpAv40lzpY9icwLPgWXrC/NaePruj
         QqlgWiogagDd18RfjL2zlmMKtCDNoujL/qsz6vdtVxOBzlVSEk0+GLj41ZVgkhOgk2Sb
         YjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184669; x=1795789469;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
        b=O+xkzcJ0PrtsNXE0/Ya9VbtGxP0TH4AFh+VDJBld0Ztr7nGHxv9Op3XxDuYavn7v0z
         L5MDYvdZOwEpxGBNq1UiE9TVxpqCR/cYmltzPni95/2hivRF/G3nL9WPOnRzskwMXyK+
         2RjgDa4VGqHHshCpXfpfPIceN9/KX1ElI2eVUcGfdMZ+xvkxBS/dWWQtpVlrqQl7AV9Q
         a/q+EZVXRG2WDP++P+KgOm9bq40a6uadBQ+c0trGcUKsVhZ9qcRkWCktRZvmP+ZK7P+s
         C+dLyqFf9bey/JfZkQSQqiftzF+TEMmBjcTG7pNNO+mbq5bipQIQIvP0XVHi5B0vFwe2
         DCEQ==
X-Gm-Message-State: APuU4Z88O8xmcdwFR2MkaReKG+ETA0PEiEbmoTm/MQuK8WJKVw2cjFhE
	gqrBRq8vaRkqoKceVHyymmZxyfR+SK1SxlaO/IE1KuAhc1y0Qw1XLLLJhn/mcD3w
X-Gm-Gg: AYBFou0/p63hmHfEFd+nOc2xEuUQ7osePm1hrwxUKe+hOm/4xT3+5UqRhKVkk8PHnZv
	tzIXxnw3F6HKad2Hh0qPV0NAb00G3ZdyS8yoF+Ramv5KHw5RxEyTH+BDnFrHzNcALX7SmF40zAd
	nefzxS6jSFbioVvBrsCLfZfXhDlxRd2WqjzAlLK/rq9xJn89lhm+K2g8hgdvMMTJk+XWtoLB8l+
	/LtkqySabxbgexVU53RrthF+aJKBc4ndwymttf/VV1/WFe4M24WDZE/vDQ0KmqlJSyKBdOqRyyx
	RgDaeIOqd88Yzju2L2/t9EPSLurOBoafEe3k0qG8wfROL9+btCYOr40N57Y7rswYQv+TCd1AfBO
	HPOpXk6407jCq3FLiqdmg48wQwmw8t/0P7KWfbrTvaNtWCQuJVSp0Eh4V4jU4V9h/K061orOLx2
	jrCfjn+/pv4H1WaD1oBf2gKg/OgqyDook5qUH4Krz1JQT85uIpsgUbJ5hJP2wmdJi2f9RXNZYuY
	5IzElbHWJ54BIViN1XjrKUFG6CE2yXHICMavnLPw9NP4M/v3Jw3pAF72Iq2n5QKHyH2AxWEOLh9
	l8Omu+GFHiA90kLMMzbBImT2o+IMZQ==
X-Received: by 2002:a05:7022:e80e:b0:1ab:de8b:5f0f with SMTP id a92af1059eb24-1b556924b07mr3332404c88.40.1795184668974;
        Fri, 20 Nov 2026 06:24:28 -0800 (PST)
Received: from [127.0.0.1] ([20.171.3.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e495bsm10512974c88.4.2026.11.20.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:24:28 -0800 (PST)
Message-Id: <37ef7636e069ce528728c43cd79f678293e0d035.1795184664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 14:24:21 +0000
Subject: [PATCH v9 1/4] branch: move the deleteMerged opt-out check into a
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
    Tuomas Ahola <taahol@utu.fi>,
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

