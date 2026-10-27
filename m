Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103889;
	b=o8IX+XKYkd5Jl9wm+yWPUI4LGFa3kmUhN6yTSqOFlWi8WECP7l5mJGTQiOBrtx1v6YKb
	 5GmVoBr8K/OuLnL76oFze9s+yFWp+vyCXVpMlYQ8Mk99KGyWoJ2Dz1W7JUH2Tc8yW7Zy5
	 Wi52wL4OZZDgY4JJ0RXFpEm7QWX1a1VJOCw5BGAEg+kPiZ2W+G11PugPamevUkOFnFUKu
	 BTzW6hjBWLQyA9DrLMG9RXgeVLiw6FhKyapKSagEZwHPUEzVklY+UWn8tGIG02F03bDvB
	 Rjkre5UFbWKpsvRShiG+KQSJaTOlU3iZJeLpQX+DmWadTa/b9h4HR1M3FQfMD8RPwQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ZfOl7lSdEUe06sZ8WdQPSqoSHVaBnqkrMQ40l2AZp1o=;
	b=sD2UupiKdIQvUCpZExJV7WDFj7TnIOmgdpZum6AvkaVHIlsbCklJzJM0w0g6LbIMgnZt
	 6l2xKU8DRnmh8NjYW4jmENERp9I3yx0618jjRb2YiW3jtim8RUtmhUzdlgLWetIT89tmW
	 IzABLAt3znlCCLHUVbSlt61Ps7THaVAGLs2lAYlKsidwbTDxd+jPvW/zvkOfctE0XIk6f
	 XH2MLNKVmiMna7TRhhk+zfkExu07XhfLUMk6W32vfux9vhEvHiyXfuCh4ckm2Gnz12hBv
	 J+IcUhZq852L6yC0Hwzqi+/UBV23c0A4rkCeJJibilIIvs7Fih7SfnTo+TPee/rVXBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eFtdBUrn;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047B60A2616
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A047B60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eFtdBUrn
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-677bc4704cbso3978156d50.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103887; x=1793708687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZfOl7lSdEUe06sZ8WdQPSqoSHVaBnqkrMQ40l2AZp1o=;
        b=eFtdBUrnOoKGbdppLUG+kbgZmCgbE7dnktPqzivCf+HDeOwUtPiDGaZyGdLr6U+JmG
         rdxjnLB/7ms/J3/n89b+oPNhxEtIxSl8SGlsd4Et5lzFy6G+a6Nky1/2Ez/YBU0wI3TZ
         koiWv3q0hRDEF9lFvAbX4+oH9ic2Pq8C/rfEpP5fPMGDgsbAhFC9TPv3Wy39JxFi+dJ5
         9SBlXJtFVJOqERXKtTrCFkyBvaK46RG6G8HvYDeVw6EW1yUddOV2VSU0cBhLuFU6OLo9
         hcc1ZyEMmetdxnyus3eJlIPJAB5NAlVbhttcJfgLkpI6b8UCVFNcat3pdmec88pXQIQ0
         N/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103887; x=1793708687;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfOl7lSdEUe06sZ8WdQPSqoSHVaBnqkrMQ40l2AZp1o=;
        b=lo3Vh9lRbjdg1y1iSjff6rOh4QZDgk30Y7h/pxgcMoURQBwBpb/RggoNBcUo1G3X7X
         G84Ms5zWNXUhbu5sml4RR8jEg/m3+wQZ3H7xYGU+eBq+pjpgtCQhpms1smOHuCKyKTwO
         cn3X/utxVPyGXRVgjca9V6m7vZI0gp+6bUWad/OBjRSnnTOnXuXhp6L/xWcrZfiAK1bk
         q/eZbuunhf18dY5xnksIsH3//6btJ+mpKL8smcbuWZB3+55uA/XTRBvNXEWyeR/N6yxP
         GrqUdcPxfhzbnotp7nwtwdjSyLjzWLC860ARFu4nuGI5AE5WyUPqRXT6Oq07x/mMBKLQ
         jqRQ==
X-Gm-Message-State: AFq9FYJOYY6xXkIuWyA2YWwVDMi6F5rTFdFviaFzHR0Bvi12IZPF5DA6
	gmYjbp3tq4wVl0LWHm/um+VHkvNutEAO0bAFQxJiWspv/hHlk/xUESr0S91m+3w7
X-Gm-Gg: AYBFou3khRqNPxWFPkSWx1ywFRt/YPqOPb2c/5uLKKt5f2FxRDbptFBsvNnKZJhRQQi
	q2Hi5PhUd5H1mWKXUgkUPhcNQQzaXcvGxSQy01e1+sAjYbAdRgLXOvd7RGvxa47au+171uoU11I
	aZYTjpgjV3Jj+3FCOpjzddg7w8gv7lF5aVqlW8wAKDBaod7VuXZv8vC3biyronPpgpkURNb+TeR
	dl7QV52ldmWkBdD8H9qFypUL0k3Ga1H1GberJLvE+IOHkE+6kRv6Vrf+8mQP09YxiiSsKf1S+OT
	YItpq5aysaNVxc45SNIlB9NYwiBKLQ7DckTmurvlJAN/xneWxu63TenrMsKsFKWPvwj9YeLbm2o
	G/jSsiuAKcI3vX9u4HMZd32ftqZ7quPattsGtlzvoG3IqezAecCtgUFTZ1/KrXP/2WTtpPmb6lL
	c3gJdi0Q3pn/nuntskyu2yu33YpUYOj4VS1z7z4fUDIO8wRagvKDFJeOkPuuwoQ5ZY3x8R17MPo
	4d4er5VBG1bjvFmSY4IGttmDLG39Lo2qaGSBgCRSMa10M23piQt9JG8vP0WiA==
X-Received: by 2002:a05:690e:1301:b0:679:8f96:ee34 with SMTP id 956f58d0204a3-67a4525bafcmr5049058d50.22.1793103887625;
        Tue, 27 Oct 2026 05:24:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.147.118])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a462a2e74sm4725435d50.18.2026.10.27.05.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:24:47 -0700 (PDT)
Message-Id: <e8af5bc76bcdbc393b2bb97e153db5446d1c88e9.1793103884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v12.git.git.1793103884.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v12.git.git.1793103884.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 12:24:41 +0000
Subject: [PATCH v12 2/5] fetch: extract collect_upstream_from_remote() helper
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
index 305934f5f4..31ec963db7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1985,8 +1985,6 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		struct branch *branch = branch_get(NULL);
-
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
@@ -2001,14 +1999,14 @@ static int do_fetch(struct transport *transport,
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
index 9acab2e01a..d4259fe7f3 100644
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

