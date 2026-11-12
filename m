Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521203;
	b=Ys/iPtlJ2XErpOhKXcTjVxIc8r9aA7rRad6PRj8o2wrAUuO2QABORIejjrCvTKPoprlL
	 6qdfTUbZpQEDrYePUdBJWMLWU+vo4x/UgHnfIfjtENiTCUO67NA0XAbXlAvdH8ctxNGWl
	 qHspahs43KojJQ2PGlpaQsUHrUIAdLT8uu4IbuB/Qp0nx4BfaFTOJCXcBAVdy+95+sT2C
	 +aQJDCnKNVZMA/pT4XxGl6WST/YZuNhb0ARDl4Z3EOxPzWpOkDq8DbOhRIrFRPnrbYLnE
	 OFyuad8FL78yOSh+sFNYCZUaLzo7YlUBA+SFeNdEBQarOPFG1uKLhUPFGZbjf763CJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v7K0SW/KhwgAMoQ/6x5WlY0jm3iLK9eJ1NzF/5jQEx0=;
	b=a7bt6dcWtn4yqLLjlW/WClA/WSAlPxVqKJdVAxF7A+FYFmXMU3U64ZqGb29M+WFlVHf2
	 EWfc1TM/v0n0UV9e/+F7nus+mr37A5ATqSlSS/AFyideeOBikDKvZk+VK0Srip2CRV/6q
	 xdeI3H3fl5o9b/Ri+TVut0OHyp8LMd7KVQfC/OMMly76zK9uD7y/QmCfrCPElz+02ADTC
	 xVHdeU3f+mCZb8YnfAQW/sgdA7TR8IUsWDXIx2dsWPAduAptrr1c0a5JOcybaqJmSxJRC
	 3gTyrIy7GF5gSXnxAVcN32HYef/Jc0F1u1+pgG5siQ/F8TRO4npXYLbweXCdsJAcjmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=og1lKQWf;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD7606A32A
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CD7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=og1lKQWf
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so688355e9.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794521202; x=1795126002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7K0SW/KhwgAMoQ/6x5WlY0jm3iLK9eJ1NzF/5jQEx0=;
        b=og1lKQWfmof5vo0AogFRoDwXXokqlRbvrBuaoS5LoI/LwoaDsAkdtc1MwrQxex2MIm
         3JSXj4f9Q09aOTSYwy4AZkRjqRgsRuxNHRxqfjWcqjivVi/dmkNsVw6FGRAwA/533yZT
         gIC/a9rOg4YeWXiosKl2R8CV7wXLCrcGT1GFFwH5mckDtUC33QmnrqeCjOExI4kchntg
         ET0rr11rkWySr7FuDUeifJG963EMOkKWFncwVRO/NodYmyJoxnJr+sT9u3+SOVlv2lMT
         FVmPYQBAQFVrRo1UJANd5wuUq3mgezLHRe/5snF4sOSTDNTVAo7ITBzMhN36ilCj5ySo
         gV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521202; x=1795126002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7K0SW/KhwgAMoQ/6x5WlY0jm3iLK9eJ1NzF/5jQEx0=;
        b=1FXtRjVxBvWoAh8YxDJ8KAvlqPsgGLG7O/1KwkoEtS6uTNcqlR9cf7aCl9w81ZCKMG
         QAOKjwxvwkDoREkUeTD6/YILb1LdFoLC9tMAKpfa2m1iOqVMtgiZFfJ+mPvnWg2oMmnz
         qF7G7sqzbnDylD0Sea/oa5STnPNdiGLMcenW62bT12uwYEppm2W3I137wGt+OBoG5GX1
         VPdGHe9oPMYyqLlNdw7u/KunMkK1MlElBYeO+VyxQMMsCOKJeSDT0jBFvaBU3rQrN2kH
         2QvEr6ee1wA0WhDijBuCveTCru2U0cARrqA7FA3v2Vy/0BR2U3PSXeC2R45hfUNywXtL
         m0BA==
X-Gm-Message-State: APuU4Z9clAIU+KBR0RztiYLoTYAU1ONiwZFgtknnPCFSqg6f5xl17Fiz
	pZ3m2rX3y9ytUS+iEFgNekZZWsHDdVGUe2Ia7QL6w1FZWkmuzuz+9nnK/W5bm0+2
X-Gm-Gg: AYBFou0YozPR7vByvDHS5gyY8hd7U8aVjYzPP4qGAXPDNYPDi601rzReApwRVI3AdYR
	v2qey2j0vqD6No7FbpNZH1OiPZ0omjofOs909yHY9ZDdZZk0RBMSqPCxsgW5g9oC0WquARsBup7
	ImtgYfkv29JJjpG9ZPJOREXm5xsK36uhZNd1Q874B+S7RhMkIIJRFi4INU4+xTlpdQVnvhaRHJs
	rKvPW0q0c9k2Ej3nw5cqAT1QT9bex4uE73K5k7zsWhkmWMGPtP9PCIoX6ccBhS+OUcE3DX9lcxz
	L0yrkhcOA1ZvJ29l+0KY08HWhjYCodYsAwTNPK9FOQnibO9HhSnR/XXllkuIg4unS1PYSyU4Dt7
	F/6VsEzPJANy3La3ciE7ZRYqu67jJ+JV91WrMuG5TYrtvVFFFDqD2qsSSiaDTXJIqYA4Ohuf6US
	YfNlOeF1vn/jZtPVEd6RMslafW9jkrLABOC48RXpTbqO7zusRJ/1JVa+uRSvr4RWBA1vvDlMr/j
	1OIqNMALpqVSLW0cNhq+AmfDfp5keDlHza6Ai/nH7kPxOUpxnvIXo0q2Bcaq3223KRX6VsIm6Nq
	LN4ZNKpz65svkN85ENczm0wW/fsEkXUJ9rn6Ii5a1rTWZcTM5DfPbgMtADLRMRK3OIg7UaXX3Y2
	r+kcFRJESZ+zCCr56O5IoBA==
X-Received: by 2002:a05:600c:1906:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4bb55ac2a34mr12317725e9.17.1794521201868;
        Thu, 12 Nov 2026 14:06:41 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29daa5sm106098995e9.12.2026.11.12.14.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:06:41 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v4 1/5] doc: glossary: add root ref and clarify pseudorefs
Date: Thu, 12 Nov 2026 22:05:37 +0000
Message-ID: <e3f2ee816f264659bb6695a442a47758778e9b48.1794520948.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794520948.git.andy.koppe@gmail.com>
References: <cover.1794000450.git.andy.koppe@gmail.com> <cover.1794520948.git.andy.koppe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The glossary describes refs in the root of the ref hierarchy, but does
not actually name them "root refs", even though the term is used
elsewhere, for example by "git for-each-ref --include-root-refs". It
also defines pseudorefs as refs, yet is_root_ref() deliberately excludes
them, as they are not stored or handled by the ref backend.

Add a "root ref" entry, moving the naming rules and the list of
irregular root refs there from the "ref" entry, and refer to
gitrevisions(7) for descriptions of commonly used root refs. In the
"ref" entry, mention remote-tracking branches alongside local branches
and tags.

Reword the "pseudoref" entry so that it no longer calls them refs, and
explain how their additional semantics set them apart. Clarify what
FETCH_HEAD records and what its "fetch status" annotation means, and
that MERGE_HEAD is also written by git-pull(1) and not only for merge
conflicts.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/glossary-content.adoc | 81 +++++++++++++++++------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 52301a56dd..1d737cae1d 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -500,18 +500,25 @@ exclude;;
 	unusual refs.
 
 [[def_pseudoref]]pseudoref::
-	A ref that has different semantics than normal refs. These refs can be
-	read via normal Git commands, but cannot be written to by commands like
-	linkgit:git-update-ref[1].
+	A name that can be used like a <<def_ref,ref>> to refer to an
+	<<def_object,object>>, but that has additional semantics: it can
+	record more than one object ID and may carry extra metadata.
+	Therefore, pseudorefs are not stored or handled by the ref backend.
++
+Pseudorefs can be passed to commands such as linkgit:git-log[1] or
+linkgit:git-diff[1], but cannot be written by linkgit:git-update-ref[1]
+or listed by linkgit:git-for-each-ref[1]. When a pseudoref contains more
+than one object ID, using it to refer to an object yields the first one.
 +
 The following pseudorefs are known to Git:
++
+ - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pull[1]
+   to record the objects that have been fetched. Each object is annotated
+   with the ref and repository it was fetched from and whether it is to be
+   merged when pulling.
 
- - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pull[1]. It
-   may refer to multiple object IDs. Each object ID is annotated with metadata
-   indicating where it was fetched from and its fetch status.
-
- - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
-   conflicts. It contains all commit IDs which are being merged.
+ - `MERGE_HEAD` is written by linkgit:git-merge[1] or linkgit:git-pull[1]
+   to record the commits being merged while a merge is in progress.
 
 [[def_pull]]pull::
 	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
@@ -562,33 +569,12 @@ The following pseudorefs are known to Git:
 +
 The ref namespace is hierarchical.
 Ref names must either start with `refs/` or be located in the root of
-the hierarchy. For the latter, their name must follow these rules:
-+
---
- - The name consists of only upper-case characters or underscores.
-
- - The name ends with "`_HEAD`" or is equal to "`HEAD`".
---
-+
-There are some irregular refs in the root of the hierarchy that do not
-match these rules. The following list is exhaustive and shall not be
-extended in the future:
-+
---
- - `AUTO_MERGE`
-
- - `BISECT_EXPECTED_REV`
-
- - `NOTES_MERGE_PARTIAL`
-
- - `NOTES_MERGE_REF`
-
- - `MERGE_AUTOSTASH`
---
+the hierarchy, in which case they must follow the naming rules for
+<<def_root_ref,root refs>>.
 +
 Different subhierarchies are used for different purposes. For example,
-the `refs/heads/` hierarchy is used to represent local branches whereas
-the `refs/tags/` hierarchy is used to represent local tags..
+local branches are stored under `refs/heads/`, remote-tracking branches
+under `refs/remotes/`, and tags under `refs/tags/`.
 +
 See also "REFERENCES" in linkgit:gitdatamodel[7].
 
@@ -640,6 +626,33 @@ format. See linkgit:git-reflog[1] for details.
 	To throw away part of the development, i.e. to assign the
 	<<def_head,head>> to an earlier <<def_revision,revision>>.
 
+[[def_root_ref]]root ref::
+	A <<def_ref,ref>> located in the root of the ref hierarchy, outside
+	`refs/`. Root ref names must follow these rules:
++
+--
+ - The name consists of only upper-case characters or underscores.
+
+ - The name ends with "`_HEAD`" or is equal to "`HEAD`".
+--
++
+The following irregular root refs are exceptions to these rules. This
+list is exhaustive and shall not be extended in future:
++
+--
+ - `AUTO_MERGE`
+
+ - `BISECT_EXPECTED_REV`
+
+ - `NOTES_MERGE_PARTIAL`
+
+ - `NOTES_MERGE_REF`
+
+ - `MERGE_AUTOSTASH`
+--
++
+See linkgit:gitrevisions[7] for descriptions of commonly used root refs.
+
 [[def_SCM]]SCM::
 	Source code management (tool).
 
-- 
2.56.0

