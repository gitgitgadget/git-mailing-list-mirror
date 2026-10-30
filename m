Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357565;
	b=P9h+btAS+pdF4V5GSR9fWPGfocYUhOPPGe3eUQwoLKeFx/rrsUTLraycxCvYPDnYAFCR
	 6b6O2m4uDH8RJQyqlcuT0SHwRmhWo3jB7NmhEdxm20DXMVVJyDX36B3WL4Z6qXaI33pQ8
	 g73yRZEQIRoR4JTQo+SdGM1+MLqW9jvQjXnwjzDHNiKJXevz5Nh5RfRyBwX6qxBqsAu+s
	 F33pkhO0Fvegb24k1gisuksg5DOBTobqx2ATaaxSDbnt1hjC9gfAYPIexT9/7w7RJ35kk
	 t0I0GIuR46S8AcatwuFBJFUNVqeLPEI/GOgjMl4NayHv+NM8xAwuoGTGkdRnpV4Ea/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ZfOl7lSdEUe06sZ8WdQPSqoSHVaBnqkrMQ40l2AZp1o=;
	b=11eOHwa3LCrDxPN1f4PS9lLmPtkvn5ZWItU4fDeSvMDMKmki5nR5Fg9/PfcIfUdgohJv
	 aw2dhP0P0tblmOUCITEs0rY0bYWhAZxPZhR3Zl0MOG8hfglWV+QqvpmTR7jCW7OT1OPia
	 Die9Q+2tQV60WiCv7maT/iYKvbBAjgcULRlhICn6KaS2fOxqTcRZKG/HWDtrNo/kz2eiU
	 0DmmXSjPh1SA6Oawa7rW49yfj6EimJn8LdQtYuOIARphKK/95D8cg0oP7mZnHc7miogKN
	 QZHagMWwgtj8thiJnWsT43H7HVsg1mRmvYqdxuL3NCOlkBkHQxA6nouzz1froS/JZkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ho/T4Lwz";
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB3606ED99
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95DB3606ED99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ho/T4Lwz
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-84e513874f8so440734a34.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357563; x=1793962363; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZfOl7lSdEUe06sZ8WdQPSqoSHVaBnqkrMQ40l2AZp1o=;
        b=Ho/T4LwzCRkzmlbnJ8ZvxkfW3ndaSela82953xHXMGTpiuc56GKqLPW9x5AbBrvKh6
         +SbwQtpG/iUMrEbU4sYVuGQ0wWSZVksleiOXodUIaZI/V0Z9H3R31CZ2qAt9UkV6O65C
         PMq7A9Pu31Zhn0upiOOt8p9L9jBglWAPxDa9Bwp1owUWS/jBXuwW9YY741ZYienNr8c1
         S3EMc02r1GPCXuV0cRbECgLUlqebBbDAyPdXZLYIGKKkL1bbpqTjuHNbFFkyz8yMEzTG
         dpQdHS2JR9J22gQvYNtTYvKtuHvG7zlWQKlRTkXa5qmRd7FFtruTh8L19+llkTuCNGgm
         zwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357563; x=1793962363;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfOl7lSdEUe06sZ8WdQPSqoSHVaBnqkrMQ40l2AZp1o=;
        b=btR9PejfxjkmCY1HlKMQsDEGn9Kfxs1CyhkmK/8XJp6qlrG6LcEatTXOdLHygYKvwf
         xQJVHvoPA7olgnJuTPdjr9JDPs/IZkA8aynRIfCKGGh721ebxCnpNCNx5ZyTJk0VVpSJ
         oEe1DxlLEHlW8E4vgvZaK4XDYygVg2U3xMl/r3UU73UA6O9pqJ+ZMm5SeSMpl4qautmv
         Wn58K27cYMYC/BaNkccszFX1R6Iw0K/2gk0Vut/JNpRlzW68porEwY5/ZnenkmJhmIMN
         crBbMOp9wA0uY3BxKDeuX9Fzk3WkwKkbcuqjQytkNqLBpwz4SSm6/GJf0i829q2GUF6k
         R8vg==
X-Gm-Message-State: AFq9FYKUPMCgpKkqD0Y0tWqrEl8896jkWQY+jKCJkPjYN4CgWKaduy8L
	Np3cB56Y52UWxI2+D3o7arYtnkjPn/Pjw6Q+r4tUKEY3nk5pS9o7LrQdokhdQbEEAwQ=
X-Gm-Gg: AYBFou31NvHuHb7rJOk02L+QR5sEvu/9qVn8w2iFWLaoYBW4GUDkif05hW1JvltGx/A
	H8RNCbhTnuInG4D1UAyoKpyd687+i73I3PLoOBbyIwETjsVLNwatzWDo6VDYuNcH4tvNHwib9g0
	ILvgj3F79Z9BbtWFnFJ6Hos7/T7RikmO0k3v/iNYw5aPZ1cg4dvpHuv4OLFuPhuFVTama6o+KYQ
	dGndvlBDJycJoxO0YSetObzDjeX98EAhGvdX8lnHX/YT6a4kWyWug/dsrWV+cw4eDo2yePR7yAM
	br2aIrhsa4CJK644A0frB8JbFUo8kuHH8tRmLQe+hvNUEFguBrWxPm5MQZCMYc6FSsYVTB/S2Nn
	Q0e+frg9zP0LFqzvjXzjnujnVhJ8qWWf8zgWwjpnG/98FcAyROLVIxp169Q+tYFPXNmUZuixUxm
	v0dag1SRi5XFtN6gx5KFAtukE9DqTPh4cTBNiyGxWXyC8LjfH0lNbR3tEgO2rt1dlxK4EXPoUNi
	RwoK6cboklBGjXJ27br0LNy41q6Q8brJl3KxaZFkzdZkQsQXdJEK821iBapJmWBiUShLwO6krhr
	HDhcabVCaC8KRLuRmrhxZ1x/SpEgnA==
X-Received: by 2002:a05:6830:2313:b0:81b:a5f9:3490 with SMTP id 46e09a7af769-85d365eec32mr1337995a34.24.1793357563520;
        Fri, 30 Oct 2026 03:52:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.38.98])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cd9bbsm1663953a34.16.2026.10.30.03.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:52:41 -0700 (PDT)
Message-Id: <3f5808cbf390f48ea41325dbe75ec76b17f6e97d.1793357550.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:26 +0000
Subject: [PATCH v13 2/6] fetch: extract collect_upstream_from_remote() helper
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

