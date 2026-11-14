Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681506;
	b=kVzo2V2/Qvsa2jdZ5JUxAbnYqHYNKnPcBkS1HFBDAORwgZR0njEtSr3YwC0BVc5TpL1y
	 /J2wa08b0A33T4pVBvCKwvR0lSPtP8Bf7zbt+uk5W0O/wW42XCB7KnXp1A3aaYTK3R6tx
	 QD9tipL9nzpNoP89cfCOeDNvWHwXXaYwZu/zqFqQa/VQiCrG1A8N2TydZMVwFn3GXAC+a
	 pKOpmhUvmgOo3EbqJqWPKvmAEn8DfLtpsuscLxahCeHuK17Ip6nNV2BGez9lF8Nc8EHMM
	 M+Czpt9OR6dnJZzi/HrRoHWRxM+hTrvuPupLP8hVskzMMlwW9HiJIo8igKQasVr7lrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=6h3VH6t8Ozp1H/yEgZjvdctdQEHZyV1HMm0rZ1vVfns=;
	b=KtATPcA53YjUsV3t1AklY2nic0deh0RMklLMHSrcgWOsChOdK5wT50X+JjCUeLL8nPvg
	 0+woAnU9gvkJgWZ/Vpgx+VGDDx2lh6GwJ9Nm4/uqWW7aQzAGpIusKgX78QVPRvZ8TNzDp
	 Ux+86vEoYF2lbSq+5iwnu+lUGtNw/L5S/DeGS57kMXx45s21odvse45yCdDEm/EnGCSmE
	 7/9nE4FX5+A1ajfetUywzeL1r8HOonpUyZBOXkoW9Qjegp26pu9cmEDStCzyu/gMfR9Rj
	 ieyTCVCOdKXziQTAJN48EUIIPB3xVJVjBn1vwEG8tc/JpS0qUDM6bPy3izf+HuXLe/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NItAndJN;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0B606A333
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E0B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NItAndJN
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb9f760337so1531123a12.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681505; x=1795286305; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6h3VH6t8Ozp1H/yEgZjvdctdQEHZyV1HMm0rZ1vVfns=;
        b=NItAndJNG27Gmsg8HHoJpopYOsAX/XyxcSconz/EXMhPGDNxJiLd+CetSvVANHWfYr
         wduFGj1VfqqtM+LBe3jK7PmQulEmRcjDZDKrL6pZ9sTjRNIfyfoWTbSuTAiiM7fWgouJ
         VT8iEBdxI2/Oed69Q1Sy78B4fvuKEx+vwUsrhv8CbowTZKrfqWPLxMQvOd3ztoyorsEz
         Lanpg1XAocvkYi7Gx8qJV3pr/RMUUwD/wXINmVL8leOAdw2T4VJJJ+YNJ4/cTJEh3kwu
         uTY3tOUUvfY5gIdd0APwpCFQzCljJEWit0VPwLqEzm6d4/Zzf5lxPJCcBsdfUDrUZhy5
         EHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681505; x=1795286305;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6h3VH6t8Ozp1H/yEgZjvdctdQEHZyV1HMm0rZ1vVfns=;
        b=rV7lRUSaBnyoSYfFgzr/e1+3Ob9WSU4/rB04M6UGnlJvww97v19E1S8bTK/cdsBUaB
         PwUIM6k5oRoylLv9Rkxr2pxKWDU6CKyz/+4BxvIbA4+IQV8tvgsSyyEHXY0l3NDhj6xJ
         qkPHYizcCcLmmSUwfzPJLILfDFxqzQd5OvLurEQJfm8PLIEmRK4BexejJzfwrXZsR7ga
         i2kbpMIG4xUxmQKb3Oixy1Rrudd20GXEv6cOurqwLiq6JOxKxILfuisXJcrriMSOSSVm
         Ucb/pzxHWfKIWOVLyoXqkIYEAf6jBKpARCBRb2ldfFGZEVLqDjbY4Fqq+p2fyYW4GLFj
         xxdg==
X-Gm-Message-State: APuU4Z/b/h717qunQ3o0205CpP9a6uT/Rw7PqzhsPyYn8GaXOtbF59om
	PGAol9anOnK3S2+u+AhZaCsONFFssh/3J37h9P9169jts4lzcNG+hl5U948lgA==
X-Gm-Gg: AYBFou1MCTBchT/Xd6IMKfHYa5Z1CxNcb+ekz9Oq+1ImTUABGtWH9nbhhX+/E3TXyZ8
	hFNs1RGUt/C2RC9cDv6pyPs9ksLsqdj3fEZcycFgtNFfpeGamhhWHFeDJVEeUyaTmgtdzr6xV0u
	PSz3qEvLH5IK5NTVufdsq/uhgYSQgYLlCzr9keBgLDXxgh35414K5FQR/JHIBeKEU66EpTAjmZA
	QV36vFVc3yq4QR2+1BWmFZYkUOnVOVMuscl7ASaxmJwX5dkZeow9WPLHop8yAr73OQ92nsOVgfj
	objqT2z3O+FXAeg9bCZpl5gIqV0PfNepYm5TkR8+3qIiVLj8EQy88g2z2/K2PcTO9vMArBEkGAi
	aer5hosJ6HV6dw+1BVe9bLTIO6Lyqg5vdCuY7v+Dek1eNXsMsDZMBYmy40OaWhRMbJ8iIAqAgpY
	Q4mvUv4e3z0fBN8BXNqdE/pFgm6CrRZulV5UGcTEhNssga6ZbiDGtSWW6VHufPCde0Gzt3Be90z
	pG1ioORdUArPhgu+c9d5fe5sypCRoCaFd9HGW9sBJ+zbAQQlX3cnNlo3NUWx3+mGagt6O+2Yw0M
	OqZQfas8xC1LbcJXa7oLz8eQe2mjYHz4cnM3n5fy1kY/1OsSv+o55RwdYN0ge34igZts5hlmeV4
	prxWICH9V
X-Received: by 2002:a17:90b:35c6:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3b1b0b9b78dmr4258051a91.22.1794681504835;
        Sat, 14 Nov 2026 10:38:24 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-139.us-west-2.compute.amazonaws.com. [3.42.157.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm14461279a91.13.2026.11.14.10.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:38:23 -0800 (PST)
Message-Id: <4ad94eefe97a2b92333c5675346d50756d0ff7b6.1794681496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 18:38:13 +0000
Subject: [PATCH v14 2/5] fetch: extract collect_upstream_from_remote() helper
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a fetch has no refspec to work from, we decide what to fetch from
two sources: the remote's configured fetch refspec, and the current
branch's upstream, if it lives on that remote. For example, after

    git clone --single-branch <url>
    git switch -c work
    git push -u origin work

the remote's refspec only covers "main", but a refspec-less "git fetch
origin" still fetches "work" into FETCH_HEAD, so that a plain "git
pull" finds the branch to merge. See 49ca2fba39 (fetch: add
branch.*.merge to default ref-prefix extension, 2022-09-08).

That "does this branch build on this remote" check was inlined for
just the current branch. Move it into its own function,
collect_upstream_from_remote(), so the same logic can be reused for
branches other than just the current one.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/fetch.c | 18 ++++++++----------
 remote.c        | 15 +++++++++++++++
 remote.h        |  9 +++++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e54bf52d86..3614d576dc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2002,8 +2002,6 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		struct branch *branch = branch_get(NULL);
-
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
@@ -2018,14 +2016,14 @@ static int do_fetch(struct transport *transport,
 			else
 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		}
-		if (branch && branch_has_merge_config(branch) &&
-		    !strcmp(branch->remote_name, transport->remote->name)) {
-			int i;
-			for (i = 0; i < branch->merge_nr; i++) {
-				strvec_push(&transport_ls_refs_options.ref_prefixes,
-					    branch->merge[i]->src);
-			}
-		}
+
+		/*
+		 * The configured refspec may not cover the current
+		 * branch's upstream (e.g. a narrowed -t refspec), so
+		 * make sure we can still fetch it regardless.
+		 */
+		collect_upstream_from_remote(the_repository, transport->remote,
+					      NULL, &transport_ls_refs_options.ref_prefixes);
 
 		/*
 		 * If there are no refs specified to fetch, then we just
diff --git a/remote.c b/remote.c
index 26f42fb6d1..4e250ba393 100644
--- a/remote.c
+++ b/remote.c
@@ -1899,6 +1899,21 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+void collect_upstream_from_remote(struct repository *repo,
+				   const struct remote *remote,
+				   const char *refname,
+				   struct strvec *tracked)
+{
+	struct branch *branch = repo_branch_get(repo, refname);
+
+	if (!branch_has_merge_config(branch) ||
+	    strcmp(branch->remote_name, remote->name))
+		return;
+
+	for (int i = 0; i < branch->merge_nr; i++)
+		strvec_push(tracked, branch->merge[i]->src);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
diff --git a/remote.h b/remote.h
index ac485a584d..003c8fd180 100644
--- a/remote.h
+++ b/remote.h
@@ -359,6 +359,15 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/*
+ * If refname's branch builds on remote, add its upstream on remote to
+ * tracked. A NULL refname means the current branch.
+ */
+void collect_upstream_from_remote(struct repository *repo,
+				   const struct remote *remote,
+				   const char *refname,
+				   struct strvec *tracked);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
-- 
gitgitgadget

