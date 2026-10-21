Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585722;
	b=i6J5rCnK+Xs8q86LWZZKWo0SR469Fv41lzLpq9ao/b1MpzXtfFhaoZn2SAo+0L+yAN/I
	 w1AqNBxko4evC8se4S9kndRgYh1NDXThGSnQmn8ago7I1EjxXvvdZc/hH2fTLyKIg1ZXY
	 VNz/Q0DlTFyNJQQeNgjbNNxoUVBhQPDW1FXyX47ZxmxRr4d6/rqXwIyhuEwsG+K91Y7Gp
	 i+MZwJu2uyyXdN8HchTMTPH/A47IRMp/0O2lok4WRxdB/6rMulUSPchef2TkFHPOOg/uB
	 vSCFOQO5o7i9vkPrGfc2JQ1wZvo3wmETMhuAYV2TNPuHU4rkG7T4+XM+TZftFGOVqVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=QRFcRxPULqUWnAu6HC1bWaLibSrUBxcKp0LMmu8cKlQ=;
	b=lZh8ZiOkEtJ9QuHdYMJ4Zn99xQpNekKjUqZwkfHOd1be6YgJxbk0K9gZwpYXX1A9tz2j
	 OdoebcqVOeNxkAxkj2dsN1ELSxcPH2sZE1PIZ0F1BrfyWCGaBS80uYF0vsxo+/Px8L4Ho
	 UumU5yTk0n6S56kEhPb/y+CdQ1wIKdu99uAbjCoIVp4aese1WyQYX0PlIkFfuI/m2TUBa
	 s5dRIH1y0soO5njaaZPF0TBqDz5Iu2aL7HeCMCnZZrAVYlzD5fujuCI3mCQ/3frr/qbl6
	 J745tJ/84s5k2YqG9XM9md3BVN2FCP7Y95PovwJfY3pr/njIZbK8NR0re+joNyTcS0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MGgzRElr;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDA606A31E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEBDA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MGgzRElr
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53664b4860bso7033561cf.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585721; x=1793190521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QRFcRxPULqUWnAu6HC1bWaLibSrUBxcKp0LMmu8cKlQ=;
        b=MGgzRElrgNTuh5e7TWUxK+f10qMDwHg4MTUqKdIKSRouvg5uG/HKeQThiQLLWij0Ub
         PpfP2BX6lC3pPoURka548gThWDSjxPWnUbpA5/BBA4g/ms2/VUUvCH/imhTpaPZ1QAQF
         hPbHIg4GS0qdOIgHkdf1y2SiLzjbM29Fl14OKvkK+OgaaC+8VGnhZmlio8u/LOztEaK0
         txUSuEshU8zufva8JtgxyUILE0DuIGGn62MPiVvMy4rQKGnatChHBjgew0bhpldNEwzi
         a511BFvcINvj62NiPw84hwLPY8BDcbZymbQCu8EsZMDPG8nElveaAfrxrN6tiMC8ruOL
         eV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585721; x=1793190521;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRFcRxPULqUWnAu6HC1bWaLibSrUBxcKp0LMmu8cKlQ=;
        b=yxZvbRfcPbFXFyFpdp5XADCsZnmDIqH3doeambKJCnH/NSX+2vxkizLTjmhFDj6hjE
         AeSYibDree8Nvksoh/7mxo8efkizbPEi20pHaiuDaxLlOB0wcFus6tHRCDS110kq8nQA
         aXqHFC9EJlzdgVG5AJSbVN+FMTidUPpjdKSQy+4Yt1wyeIOlKDlLwfu0By6m7IY2diA5
         oc/MwHgPNfWokgloXO6YyMHSOCrRX38JrV3Us9FvWqJRUJsdbWbk2yPqIvnajwvgQLeg
         O6vwsnWSa02M5S6tbLgWN44jqzwKzJ8H7no036Ly/2bdSXqNNyfdMAgkKH/ptzSLKqEt
         qlLA==
X-Gm-Message-State: AFq9FYKJxZs+0GVkfiys0c6I4tAWYF1lhdM8tqqjgDoPhwRc7VnSKI6d
	DUtlM6ZrUiFPtUat/r3n0GAx9gcJnG7JGZZnho4HuGuIHvmRIzvqgWVkThmv98Aw
X-Gm-Gg: AYBFou0hPQtfESHVGKTnHyzlkKqCpQzgJKheQtrQSFG+M2LabPRY/YSPKf/QcigDGpL
	pPle6dkS8wZPat7H8yXnly2Pcjh2ubW8fnrSxTmDadNM30w+CrGWMWwn6ZIj+68BueaGjfoYF0n
	6rZlbRzwHseVHAGUqxAL/vtq98HknClB/ozy7jC7Ih5n+KHFsYy3SVWJr/O3egMeq7DVKQPS0Ri
	ZMku3MSfF2x6Rquinxo2ZpHszP544VMTL293WkEg2EZejvFT3KNXSo6n2VteIRHt1KTlbHIsSlY
	SBvP7WsxFLtofMvIBUEzxdfLsvTPQonB6AyhAtxXoT0p+qMF4Z3/WOgrwudX5Cg/ffOhxbsNOPp
	F0OeM5EKK0eeE9e3fWzba0XpACgQYDHWoyWFD/AokFfoHryUCL7AcO/qGNV43VBLbpK+GdG4IuS
	D3BJeaYQFKdK45glFqLa0Uz7h6tOPcbIiIdIguu+nCqUjVaGf4d3t1DID+tJJRJNZRYkM3Un+eH
	5lp18UaBm3lojGO4nPPPbDrd0YZDi+jgobG2/DvFt4JJRnvTtUKnLn2An4=
X-Received: by 2002:a05:622a:1482:b0:536:55c7:a1d7 with SMTP id d75a77b69052e-5369b7ceb9fmr28957521cf.54.1792585720668;
        Wed, 21 Oct 2026 05:28:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.95.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698bd5b4fsm18427841cf.26.2026.10.21.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:28:40 -0700 (PDT)
Message-Id: <82413e5cd762f342358525cd7891ef3c5fa1a8e0.1792585717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 12:28:35 +0000
Subject: [PATCH v3 1/3] branch: move the deleteMerged opt-out check into a
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

The next commit lets "git branch --delete-merged" delete branches whose
tips are not reachable from their upstream, and those must honor
branch.<name>.deleteMerged=false as well. Move the check into a helper
so it can be used in both places.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..171b13b081 100644
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

