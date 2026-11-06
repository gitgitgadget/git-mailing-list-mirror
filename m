Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000873;
	b=0hljj9PCEperk3Ie/eTO5C89ElOXNhq9HO0N6bn/GV0uEbMvIp0QENasUJ9gGkgQXC1K
	 xxE+CEDHOqulaf0O9v2EvPjczG3JYYCJDMxum67yteOlJ5rBc9EhwzoFCtIVBLqxlSEbY
	 gnii2IO/j7hHoA4VvcnX+ajyaUxJMOR0pnwvWjWfwIG6gIn0Jji0KnOUsUQjDnOVnh7y5
	 IWxyV/wrYWwHzflbzOMyNMzig3wMSidBjOzLgm3xs6JpnVewTBfq5ZMi3pL70qw6tGpdj
	 R4VmTfM1oJJAzERJDXFMd8BOtcGKF7hL7QX9mI/xyOZUECrP5tQGvE+1+rHji1AO7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EpzZJpS3GExQ3o95v+uCgkRQsOfCc384Ku1E4IkbAx8=;
	b=KeY9JE7ArEVTAeEyw/X1yB6fShpWw2EF0b4JnWWZp7x0HQ2LMah/M6q0TScgdhfzIbDQ
	 V17UrcaguiPbgphqkrUQS5sg69plgx4nLymf7LOgRdDjQvKJVQwYTjLRXBPoPLm9VC9Ab
	 SQHUaj/QTVyV43ukrgpktkWTLXl6EEGla+CmNbCHWOzQs2Td9crendEwVh66OMPv80jdF
	 kIocImZwADgT9EOSaYqMCpe/gwNRtzpac0V7meQxbVQ8nkDZ4kbITygzXrz1ePWwHO4lf
	 Ab6S2zo5aQWyxbK0faCQ1Pi0MdmyrXKu2BlRfD6xuhrQ0EmHaWvmjLTOFr/kTiG94ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIv4wOiZ;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12106606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12106606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIv4wOiZ
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a215e64962so12736265e9.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 13:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000871; x=1794605671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EpzZJpS3GExQ3o95v+uCgkRQsOfCc384Ku1E4IkbAx8=;
        b=bIv4wOiZaGlWlGYS3v/qDz3dn2tCaoJEXiCEJKO0/QbLkY9QzKSd91lUWilBhHFilu
         1mnAsZE51xdwDcm1HEGHBXCiXpoSEXvn/qHyMb++8vdYEd7Fts8cTKb070a4xAA2IH9d
         F1eQr4pN8z7yUG24D0acBOEMDy3kXvYyZwNXSUfd6Vd0O0nj0wuysywpqCCWnfxIMXLn
         c9akmBbd53CvGwoB7sIFgbTVcghL7nEN6EhDGkh8040N8KVOOpS9Y/BO7xAV9vPGS9hl
         03vdpzKCfek/Eydz95b4LEb97F0rkSRbicTNTPrcKGdbMfGVAFphjvek5BAz0eiNxOfz
         wLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000871; x=1794605671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EpzZJpS3GExQ3o95v+uCgkRQsOfCc384Ku1E4IkbAx8=;
        b=jc/Ezd9Udi+C92ZZrmlBRTtL/j5z6KR5DmIThkj7/8qenO/sXxfvhn7eSeFL4+Oerz
         8t8Vwj2uQTbBTcAskN4pRvcuLgB0f0n2KMzdfralJp9k0W6+DGkLhKWVwtVR36FElH39
         aQ8vS6dzfbIMEl6LMA0jLO9it9jbSqSsmhiSPsPE2lsZZWlnwOH2ruSf+tR5ssM0p/W8
         W4T7o4rNC4uP2zWqG5+DX3xzppPgB5MaPCw+TSVOUg8Av0bD8x1GOSC6rFHmm4oKUagL
         BEsWxkRk7W5ifO0lP4V5JfVto7DgzBYZGodsp80Z9Awh001JK2mG8qYjDHOjqdYopM7z
         B/kw==
X-Gm-Message-State: APuU4Z8twhMXFH2zRXac751vh+U56FPd1ZSWuBt70EgZnGEOr+QWQHNf
	cF1ioCU6cEZMlpq2ino/PtPQq1KvAurumAUZpFI1cD/lOtDuBsnZAKLkMhLyXBYT
X-Gm-Gg: AYBFou06aKU5QK/Mb6IGoMsyVeCGEaIGg6grE0QCTfovZdT3pHq2jgEs9uC6lW4TKxL
	0Dyx0e60Yu+kqEwnabE7BFBOh1s1TLIzAPxAiHa3WkTQBYbDtbSRZ21/V4B7V4DEeLMgL9UfFjm
	2JOFzdFq4AeiGsZ2doPJSalm244vd4NXym5M0eQe9qHVLsuroSqpwxEf6L+Lnz3513KLgwkvZzW
	fVI0N7FhC8lZ1trj4gm/oKQqGEuTJaGjt7Vh1d0+gc5wWz77efX6xWCls3J0ds5CvqgBcHrMhn9
	ajuyl5S1X4PG53n52M00DSPmcArOolNAHOdvt5FO9I5bDx5ZK7butD/mBhVQmyVul0GZaaMV/tI
	XmFWgCCKhs8M6zARkwMtu1HN9vDsXFWWWdkpoasCbYqlsE66uK/8ZlhzbxrbD/6oFHO1yo/cFV+
	ZGRlhz3es1haduPsLfhXYTLGxfr/iQldLkfv3+flIS1UgqQF1eXK9g68m5rmkSxTeGTsisWilyO
	MLnj2GjYfMOWd5zeLooN1yzE+woK7HDIXVMByqvQ79wuCfPm3jmjDZL/QDYNDg7JIE0DU6AbXfK
	14Ijf9JUg0ocLCrqzE0SsgPbAeBeuuISPkK5gjna5kQgFGWS3l1X2Eh110Kenn3C6hNoTubE5jt
	yVKoC+Gr3i9tqk87C6AO5PA==
X-Received: by 2002:a05:600c:3509:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4b6e0172854mr72559245e9.31.1794000871337;
        Fri, 06 Nov 2026 13:34:31 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3271867sm9994385e9.6.2026.11.06.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:34:30 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 1/5] doc: glossary: add root ref and clarify pseudorefs
Date: Fri,  6 Nov 2026 21:31:04 +0000
Message-ID: <5630c671dbfc4a017e6698674c4b3f09d45cda54.1794000450.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794000450.git.andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com> <cover.1794000450.git.andy.koppe@gmail.com>
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
irregular root refs there from the "ref" entry. State that pseudorefs
are not root refs, and refer to gitrevisions(7) for descriptions of
commonly used root refs and pseudorefs.

Reword the "pseudoref" entry so that it no longer calls them refs, and
explain how their additional semantics set them apart. Clarify what
FETCH_HEAD records and what its "fetch status" annotation means, and
that MERGE_HEAD is also written by git-pull(1) and not only for merge
conflicts.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/glossary-content.adoc | 84 +++++++++++++++++------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 52301a56dd..668f309a6f 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -500,18 +500,26 @@ exclude;;
 	unusual refs.
 
 [[def_pseudoref]]pseudoref::
-	A ref that has different semantics than normal refs. These refs can be
-	read via normal Git commands, but cannot be written to by commands like
-	linkgit:git-update-ref[1].
+	A name that can be used like a <<def_ref,ref>> to refer to an
+	<<def_object,object>>, but that has additional semantics: it can
+	record more than one object ID and may carry extra metadata. In
+	contrast to <<def_root_ref,root refs>>, pseudorefs are therefore
+	not stored or handled by the ref backend.
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
@@ -562,33 +570,12 @@ The following pseudorefs are known to Git:
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
 the `refs/heads/` hierarchy is used to represent local branches whereas
-the `refs/tags/` hierarchy is used to represent local tags..
+the `refs/tags/` hierarchy is used to represent local tags.
 +
 See also "REFERENCES" in linkgit:gitdatamodel[7].
 
@@ -640,6 +627,37 @@ format. See linkgit:git-reflog[1] for details.
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
+<<def_pseudoref,Pseudorefs>> are not considered root refs, even though
+they follow the naming rules.
++
+See linkgit:gitrevisions[7] for descriptions of commonly used root refs
+and pseudorefs.
+
 [[def_SCM]]SCM::
 	Source code management (tool).
 
-- 
2.56.0

