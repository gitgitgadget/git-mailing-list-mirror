Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611182;
	b=fJOCnI76p/djTcd2G/g+qR9N4pr69cg3d7S1d7Uwi2dEm2NquDwAcRcMSrEOqWhqBBKZ
	 rRu7UNd0Jl9vSEmmXH6x2kJVn3HDtYcSUF6nhvlqnrWaXLW3s/NhLUPZqbUdHfIj7g01Z
	 QrFmoxs8cwCxdJEoUbvE/3Hy96wJD5Hou8huOvib/TZ5bX7l1eGkENoT+8vX7V8WEViQZ
	 R2NG1t4wm+9iMCc9xIV7AsCFRIz6KS1hs85YOZtZ0thhW2ez3OjQoYi3DzuiYb/jKfHVK
	 cqpFSX/TmTb1tLepO21TbjrKN2mTeA6w4RrbjYgqcVwiUj6VaFjOj+IX8oMuAEbDKnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=S1NqqudNc1TCCy1dwCoji4Zrm8Ip1rWgvr4b8nN2ktg=;
	b=CGa2wp3H6awC+zq84Up32IZXPs5mHVZBFqoSci3NriIgBIuWJi9e2rgDPiiuI7Uz9jid
	 BuuG+coq5oapcDIItiTVL7hMd4gn4HRAySHVZEf5yN3DVYU/zKIFlVOyyFJTq3qV7UXFj
	 wqKNd3+dSeVIMW7vvFc6qzuHJUeo799Cd85h/xSW4yl3jSOafHQbLPG7CTxjrAlSfoZyj
	 nbTWezzGSiiW3hhTxYr+Aji4CDCPA/mESrwldHm+gflG9dBkc8YbBFjG6Qk7XShCI30Ro
	 gdUyhsJIO9c4heAOQ0iAJe/gZ3K3FuzpHenxHWYd9g7R9gVm58gy535FoJcGTxnYwoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="advvPPN/";
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6B606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E6B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=advvPPN/
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4911df1e196so3164752fac.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 04:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795611180; x=1796215980; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S1NqqudNc1TCCy1dwCoji4Zrm8Ip1rWgvr4b8nN2ktg=;
        b=advvPPN/gtKx8K4jwsvgCtYIGRD+YWZP/J1xiR3wmEw4gfy3onw3s3g+cbRH6FoagF
         BV42WUCgm5s4PG4682b909i6URx5CH9ZgMCZcFVaC/adLilrIPyDEaEOBXW2OvSB6cXW
         ALiOWkdCkp9jUxTVrSby4Wu0kPPNn6mhBNtsFx03DvvOkUNgcMvOI8Fnp5W0mBQVhWvX
         2Lt/Wi8xRW0GrCZnM/WuyTNNYXwiDBE8yZYSLibDWIp/mqETwxP7TCefz1WgZ8UrwZ5o
         5/BzEugt72qtPtir2xq/DfZw3ZH0u2alM9ryfzPHrexLh/dopgHVT42f5+W4/1+QtbR0
         +osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611180; x=1796215980;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1NqqudNc1TCCy1dwCoji4Zrm8Ip1rWgvr4b8nN2ktg=;
        b=SbgoxvoTGh4EpkEHtONfKHgX1Kj46kUGYrVoUozhjbBcruJZ/6v6UOqJMzaGyiLkBE
         fhOTrwaUE5shNZSzQ9PfPQEVSrT4PyZQ+kKa+8nZ1+yti7PAb9cyWQbgtmYEuzEu3GQ/
         2XIeOBqh5DSC79IdMLzG+mD6jSVIKKTg5WEpHREK/6zeytphxGbzo5PUpLatg4iGgvfT
         3UP3TarRWSwApHhaNWMlJqJU6x+8A73R/XeTGsgfBMlB3PIwu5xZ8R0V7zSW3prD1ymk
         Vaukh8vXfwEt/CIinzKWM8nrtpaNEiP1Ui+lLyPpYd9S8GAYw50JRFa/yNlah7i3Mbod
         0Onw==
X-Gm-Message-State: APuU4Z8R6cSvwrHKoG6VTnMOGLsmKWWTdLuIrHVNd2y+Qixi19MzZVZR
	gTNgn6Cl5cXOLpLVKUkAoLZ5XNC8jnbXRNJx+rveei9zoDAGMmQEk4CKzLoM74vG
X-Gm-Gg: AZFdTZeggsLIVWsK01CdtpxPc5cNAVT9JmHJqCuvBr46aBEUgTEGbeO1sZO51c/JQ/U
	44Lzyg0pbO6TNsg8Dy1UuDqYBVhWw5W17zVHtzRu6RuHDUM3wxUGkn1EaovpzeZ9T/3GjuEGyXD
	4/HdmYs7HnNiyWNEA2nxkPfm0sfHOvcjf9IjGjxm+nuZyw5TChCfkAZLLYxHn65tGQ8/KGSAdHg
	PrDGexiGdOho4s6FCmlz1nsc0TUKLE/BaALz3ETk5HVn0aqk2p/jzmskN6CpO2koXy5ZxHgFbHa
	elT1gxQ1FMgNbkqNp/BsVUgtFtJXeWcQWhoEd6etNeOgPNtlE5sHvDDWegJguxWxR0t+pv61fzR
	ZQR3NRJeOy2FCPqxB6OQy1iAQsy6fHG24dbKX11Tqs+ivAVhpf3+NsV8dTPNeB0VSyIu22GUHRm
	qWB0eG54yAQ1Qho2nu+rTjkOlPDKTxXx9wrcLygqF2ZxHkZhK9qYcrqf/jAfITeR/FH3xP3dk+W
	Y1taWGeRJ3hk7sXfj7cjdVQiN2Bt4Ge+MHQPSsRS1RKhdgqIV5jNLicBWZvZbhlnQmx+Kq5AxlT
	Au5Cn5qCfLgksmgye7WjMnSbuEg3xyas
X-Received: by 2002:a05:6870:c295:b0:4b3:882a:b25a with SMTP id 586e51a60fabf-4bc7beaeb80mr15493512fac.8.1795611180493;
        Wed, 25 Nov 2026 04:53:00 -0800 (PST)
Received: from [127.0.0.1] ([20.12.245.213])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5fc97bb2sm16203358fac.9.2026.11.25.04.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:52:59 -0800 (PST)
Message-Id: <ea62fc8787a2e5c407b1558d293e914688ff3a68.1795611175.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 12:52:51 +0000
Subject: [PATCH v11 1/5] branch: move the deleteMerged opt-out check into a
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A later commit adds "git branch --delete-integrated", which deletes
branches whose tips are not reachable from their upstream. Those must
honor branch.<name>.deleteMerged=false as well. Move the check into a
helper so it can be used in both places.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b536b619bb..7ccb36364a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -824,6 +824,24 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+static bool opted_out_of_delete_merged(struct strbuf *key,
+				       const char *branch_name,
+				       unsigned int flags)
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
@@ -852,7 +870,6 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
-		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -870,18 +887,8 @@ static int delete_merged_branches(const struct strvec *upstreams,
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
+		if (!opted_out_of_delete_merged(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
 	}
 
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
-- 
gitgitgadget

