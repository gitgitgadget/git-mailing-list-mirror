Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704575;
	b=GnlXgU/PiuqLswVD8pdSGNBB5E8Iz8eWD9rUj+5kFqi2k80xMky/dy9pWROzYulz3bRT
	 tcf9Og9j6zOFugK4TcCkmCdGKltK3b/yrykI6OWGMHhC1Upd+fYQMsAPllv/BU4TfmL2f
	 yah0M5dwCJI9HvBX82hM19CaOCBW3eu9kcUdVQ9+KRGU+WTy1zWcyxDU8nXwEc91Iix7y
	 spOBqyQzBLXltM7z7sXqpwhv7erITmHB6HXAXCojvPW/bBgK+PToWBCVCcP9L+8dAsDUA
	 rPlLbeKhoKWkxsePiBHmlSRU9vyh5zG0+bLi5oOD3TE5C+sDNjwXPhK/Ca2TN0bfcOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kl3GVBtaLHcipTM1lmRypkANn8+glxtyxmfD5YqSP+E=;
	b=bqedr+IyGjLqqhXlc6tEvx9U2gUnA7oKoLkoqxYN90VL9HsWZQqIgdWvD+coTFkiICxS
	 vx+x+/t/VVXUtjVsgBvA6z6Nxda10Mrmnnp4O49kWI2gxlsyuj+tbNmgGOQrpsy8IjvPZ
	 YKeK3Xmt2hnTpvSwWZl6KZ3bh2ZVxuE/nUWlaMSFEz5brrPr1bPT9JtMocJeQfHASrF6m
	 8vIKJx8+BYE3HHb7a9p8D4JuvDQGpnyX0aHKCkyn91FS4ob9BUZ3g9JgNydr0vVyw05rp
	 xRDky0Ysn3CY7APpCmuCNLriPTcQhqR81M+NYu8Bl8fAvcjs2AFAnR8vhGzm0L+4j7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHkIRspP;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA76606A31D
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA76606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHkIRspP
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afbd2c386so113248f8f.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792704574; x=1793309374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kl3GVBtaLHcipTM1lmRypkANn8+glxtyxmfD5YqSP+E=;
        b=eHkIRspP1Tyyggz65g7nKdRZWsGl19Re2nisx9Er2vvheiwQjPdgEy5NIDjpxKDRHT
         j+CriS9u0aaBp+kPKMvMPG0W62af5QXxQ7UgBb6tJ7g8er9izP7Dy+89lmHlCeac8eib
         QCPRox34cmOL01tXq9WKjkjmffFKu3ljkf5Gx3JK61oKBEmenMgnLqfXq0U08/HPGTqf
         AGaxmfGgvRb12JMKACQSygUEtlqI20NxUYYLBrNaeP1usZHGtsqVq/Xq1hZE5HH2zYG8
         4WdvcnEQTxWfsw7MLTv9WTkcx8CmJEVcZ9BwwIOIPdJNNf5Uj9d2ITGJu2JVqMVIZ7VI
         prug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792704574; x=1793309374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kl3GVBtaLHcipTM1lmRypkANn8+glxtyxmfD5YqSP+E=;
        b=tk9q1cRPRcBvqN2+XtXvjxBcyoMUlXgNZtI70mAlyTdeTTSnPttIOdKYesDffET731
         Syn4n2Ol5pYRsTtOksrtjklpbVA2GbYxz7ShL4jOcgQaxxQzh+XSPjCj/uV45qR36LMS
         fLrnw+24TXLjHtdXkrNFxyluLzd8A0diP4VvZiF8fNUfLzA5srIPIa7ji8Z+ExcAreCT
         FQoMkxcdDMGLyocq8AOBdcbd42HeM+CphffHjzNUnH1uJNs6IZBGG6pmgTolzE0UHa+1
         EFZoRTHZRym1Ou0vr7TNZNrWM9+ttSnRN4KM8GufGxcqJyScwoy2TiPM3Ljs8OGaILXd
         dy8Q==
X-Gm-Message-State: AFq9FYJIJICiQwC/1xLDElHKkC8PTOMi3o8PbL2VMFETUqBpFomRnHFP
	x1B2cN34SXt5LYuozUyLzufx+49bux7xcMoDJ/5ASZ8GHhC/V+b6M4MWPIvprctw
X-Gm-Gg: AYBFou317tkhTQjphbgz0BFinXfb3Iif5id5z89Yy2IukvxRyvTJxMl+9HGEzRbwYk0
	8RGlW3JyNvvYsdeNOUQpEIhiM8M4G5h7NdzqFRtzUHIQhmrX0bcGQUSAWHSDqI+Kcmnpe1bx8wc
	CX2cGVocCZCc/IcCofW/xSVtk38Be7h+LRml5+jY8Ou66E/Z1+Qk2uD1UDxxkQw+nEMrVuFmf0u
	161M8XBgbc14F7LJglqyf4lfzHGzGbIEldANwucr/MU/zg9F7B2NQv7NKrvp5/xNocRWceNuT2h
	w1oEGV/oed+UpJ/0lMBAWZpnB0fqVRk4TDm0bA2YpUFRpOekz9lvBFkNEYek/X1pVgJ8dWE2p+F
	9ek3rQkVzc7+6xJWopnXeugM1UufayGrwTSsMgPnwoI+PdfwjdZI0ESEmBXWXdaV6MO9zSazdmB
	Sr9LCTGY5rqbTVBOMxK14idC7cKNiiCF60VL56g1I8oeRxOzk9qEAZrfVm1iQ//lLGPnP54rfKl
	2Qv2Nj4ESrOtKhA4R5oKsqX1HLnsVI6bd31uzs2GvOgInJsMNFOm4E8bFis0pen+1VRTTDaiHFD
	aZR72auOVWn3ISsf8aZ7eRwjNGZ4w6XPIVTngMkSWpCotrFu
X-Received: by 2002:a5d:5d86:0:b0:48c:7037:aee9 with SMTP id ffacd0b85a97d-48e385a7452mr156824f8f.50.1792704573388;
        Thu, 22 Oct 2026 14:29:33 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38044e8fsm739355f8f.31.2026.10.22.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:29:32 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 1/5] doc: glossary: add root ref and clarify pseudorefs
Date: Thu, 22 Oct 2026 22:28:49 +0100
Message-ID: <20261022212903.177261-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
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
them, as they are not stored or handled by the ref backends.

Add a "root ref" entry, moving the naming rules and the list of
irregular root refs there from the "ref" entry. State that pseudorefs
are not root refs, and refer to gitrevisions(7) for descriptions of
commonly used root refs and pseudorefs.

Reword the "pseudoref" entry so that it no longer calls them refs, add
git-for-each-ref(1) as another example of how they are not proper refs,
and explain that using a pseudoref containing multiple object IDs yields
the first one.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/glossary-content.adoc | 68 +++++++++++++++++------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 52301a56dd..b2c582254b 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -500,9 +500,10 @@ exclude;;
 	unusual refs.
 
 [[def_pseudoref]]pseudoref::
-	A ref that has different semantics than normal refs. These refs can be
-	read via normal Git commands, but cannot be written to by commands like
-	linkgit:git-update-ref[1].
+	A name that can be used like a <<def_ref,ref>> to refer to
+	<<def_object,objects>>, but that is not stored in the same way as refs.
+	For example, pseudorefs cannot be written by linkgit:git-update-ref[1]
+	or listed by linkgit:git-for-each-ref[1].
 +
 The following pseudorefs are known to Git:
 
@@ -512,6 +513,9 @@ The following pseudorefs are known to Git:
 
  - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
    conflicts. It contains all commit IDs which are being merged.
++
+When a pseudoref contains more than one object ID, using it to refer to an
+object yields the first one.
 
 [[def_pull]]pull::
 	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
@@ -562,33 +566,12 @@ The following pseudorefs are known to Git:
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
 
@@ -640,6 +623,37 @@ format. See linkgit:git-reflog[1] for details.
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

