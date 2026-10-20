Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503798;
	b=WqYopgVlMmeQ58pE1SPEc8quZXeRiwwPY5EqaPoivsn+OY8BaiRw7rft3K+aFyq8RKa1
	 DM1Hiz/SvCd7TUOEidDKmRdmaGktJrdgtJea3uLGj08rApXNYG7G7rHlwUdkbwmXlQUja
	 OtsEtC0maf+8Y0cwpFGuOxy0os/SU4yT6VAhcwC3832Ih3k17YV0jmA2uWB+KVnVgu8fl
	 XSCYuMn4WmEQnyeKP/MudpD+6oCWD0SBY2PvGo0V1xSizaGsDWDrFdXX2XIj+ydm39fNE
	 8TsHGnjkFwu/TUJQ8IXLj92Sb8nFEJPO3zXEic5AuzyLpBWdOZjlI8h6CK5p4gve1RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Zc/xoqThglmgye3y964OcBIwAeRBrcc2wQMSaMr9Ucs=;
	b=TKwoOYJM+20cR+ekQXNwYbzFrDvg4Uf05tOblxIkBNlgV9yosYPlWVd2X/hxkp7jeWEu
	 j5ubzWiURlw5w6t2L2CW8wVpTT38t19wwBDp6PjcDs5QQA9bY+JnG2qWGQTpRL04kDWQs
	 IptrWbOXBNNYNe2RHiPFq9YneIxXs+DC6kV0CJlTZV7AxBB1Ik42AiFzA6OueSQSx7ege
	 vXBYji7GRklp2RxlKP74RiBOXKQ+MCAXPyLfNP6vsM1fEZqhboxeWoHI9cXsMyOpOcgG6
	 5Zu1lwLbpdCU+su4Wh5m/23s1IEsP6vdhU52BBF5s6i2JJOnk465xHBPJoH6ezC+9rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQi3d55K;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E840606A325
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E840606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQi3d55K
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so8657333eec.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792503797; x=1793108597; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zc/xoqThglmgye3y964OcBIwAeRBrcc2wQMSaMr9Ucs=;
        b=JQi3d55KJBP85NyK4cpCQtBoetG2ksy60PHSSNcy+bqxNm+Uyiz8qWABNAbzZ9KqSO
         LYGcN0bb93odRwvt9uu1W9pN0Fc/ECLYoRUEplIJIDxztPB9qnYgqo44ka5/NgY0AoEb
         ps9FHGi9jjiMBlnPP9f9qozaDDndz1W5jb9cklEiVBcToz0N4Z/+Pu5rsAgnK8GNHjyK
         6rScZ3pjflQoMmengkvM1b3iQoLo5ymprT73f4BrOphWFJ04s5r/SEuckg6B2GNCGe5I
         aFo+c7mBcH7tgwy8ee3WrJLOr/1DipHoEIOZHKcBNINikwMYNbNL4LbfYf3sNLozcv2g
         fcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503797; x=1793108597;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zc/xoqThglmgye3y964OcBIwAeRBrcc2wQMSaMr9Ucs=;
        b=xoo4kucQND59CTEe1bjEuBcingFQpPPxJ0xPzWBVFvPIynIwdYhBnfGdaadsmYoj0L
         g1mk3fOwJhkCJt9/q5I4fH2YlD4KeUIbkrmjkrjiiYTp1fcZyfX73n+vdx3omenuyN0D
         ZrD0UrLB3D1jIfI7a0zZALoHW+nQlW9kczeW81A5EKd8EAcJphYyd+W1M3yyH4KhNp1I
         /uWNcQXwzq5yNY7SI9Ddb9d5RU6KlzT6VsuBr4zDIFiZyAkfuxuHM6hNscwy4RwbcsaS
         rCWeTYoh4WGIc4HHGxpCK5v+VJzO9dN2sL/1+gzWGss7qy1X8iqdAW3hzkcgnV1IpKDC
         12Wg==
X-Gm-Message-State: AFq9FYLscmXA03YI2qReWHW9rRymgLIheiGLLjwpLwTFCbTGMd3kGQ0j
	JiOJYfnBqh1OeGhzUbJFrCW2ybuTPBdd8KVrIpX63Satq/Pb6yIhrz2TOHPutVDK
X-Gm-Gg: AYBFou2y1HTFiQOsmmHF4K4a42ThUPRRor76s1c9HTUg/aJLieYb9fm88iKup787GuM
	wpmO1T0Z3P9vbhOHUHiDd6HBv9Dh39E4gsbyTETlOq3L5Zzya8u5BisjtvETKfVVbLoggn70dhg
	AB2pPAUa0i32FZ7+ux+6SDFh9WtkeyBEHvIgw+LQ+R8lzg99N4ZLkM1mA24XwnmDCN5AAmHJuCc
	BwLWI14ZPmT1BThOlf5lczYkcdGub/Xo7wwCuVKUJmvIHbcxNNGyJaUqz5Ygc67HpANMPOQZ33d
	Nc8pTeO0aVCh3TlILHXykMU7zOiV8rz0dz487o///cUMXwOGLAGltLCJmx4pVjzy+xrXVltHgR1
	UErW66uoEtpT+aohQ6acX8sSCYADxCtZTRQAlVYfO714yhud7/SMrOlT38zqQsU8sw2jbdpXaR2
	+yLnvfGRbpCdWP1t0/8fReephraRy22p5LtAYaj0ADTCi6jJ0wvmbYZrSwJTj0rWtoyOgTgxo=
X-Received: by 2002:a05:693c:864c:20b0:366:ae22:a562 with SMTP id 5a478bee46e88-366ae22a7ffmr1330082eec.19.1792503796683;
        Tue, 20 Oct 2026 06:43:16 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.77.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm51562615eec.20.2026.10.20.06.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:43:15 -0700 (PDT)
Message-Id: <aa20604144efdcc5ada00d65d538fdb42c2e31d3.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 13:42:55 +0000
Subject: [PATCH v10 2/5] fetch: extract collect_upstream_from_remote() helper
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

When a fetch has no refspec to work from, we fall back to guessing
what to fetch: the remote's configured fetch refspec if there is one,
and separately, whether the current branch's upstream lives on this
remote. The latter is independent of the former on purpose: a narrow
refspec (for example from "git remote add -t") can leave the current
branch's own upstream uncovered, and we still need to be able to fetch
it.

That "does this branch build on this remote" check was inlined for
just the current branch. Move it into its own function,
collect_upstream_from_remote(), so the same logic can be reused for
branches other than just the current one.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/fetch.c | 23 ++++++++++++++---------
 remote.c        | 15 +++++++++++++++
 remote.h        |  9 +++++++++
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ffcb5ba29a..136a59154a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1979,7 +1979,8 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		struct branch *branch = branch_get(NULL);
+		struct string_list tracked = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
 
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
@@ -1995,14 +1996,18 @@ static int do_fetch(struct transport *transport,
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
+		collect_upstream_from_remote(the_repository, &tracked,
+					      transport->remote, NULL);
+		for_each_string_list_item(item, &tracked)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    item->string);
+		string_list_clear(&tracked, 0);
 
 		/*
 		 * If there are no refs specified to fetch, then we just
diff --git a/remote.c b/remote.c
index c9252a90f4..965e42ff52 100644
--- a/remote.c
+++ b/remote.c
@@ -1891,6 +1891,21 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+void collect_upstream_from_remote(struct repository *repo,
+				   struct string_list *tracked,
+				   struct remote *remote,
+				   const char *refname)
+{
+	struct branch *branch = repo_branch_get(repo, refname);
+
+	if (!branch_has_merge_config(branch) ||
+	    strcmp(branch->remote_name, remote->name))
+		return;
+
+	for (int i = 0; i < branch->merge_nr; i++)
+		string_list_insert(tracked, branch->merge[i]->src);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
diff --git a/remote.h b/remote.h
index ac485a584d..7c86c529b6 100644
--- a/remote.h
+++ b/remote.h
@@ -359,6 +359,15 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/*
+ * If refname's branch builds on remote, add its upstream on remote to
+ * tracked. A NULL refname means the current branch.
+ */
+void collect_upstream_from_remote(struct repository *repo,
+				   struct string_list *tracked,
+				   struct remote *remote,
+				   const char *refname);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
-- 
gitgitgadget

