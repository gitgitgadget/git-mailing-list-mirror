Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574278;
	b=ROc3RzJOR+kepoCwsMp7v0gYYxJmVfmbgFzjyGSydL+oTFNXxMZTkeNoqDA6nDWGvUS6
	 pTGEZ4jQFR9yXavrMwZb60/Tku8yyIibZJqNGIN0UJEe0DfkfGZS3+68xDbmLQTdvSCj2
	 ojbkiut0WS0kQsBMTjmu32SUGhtNBsw3keeVldG1Mt/LcLTTPOABOAqL9QsrR0Ae3rxp1
	 GiwKsOroeownTaSDDIumnIWdWo9vzHxQBqH7JIU+guj8FD494THhteIPjjUR99gUzjhp6
	 Pe0aJR7puCA/KCABR+dBahUSfElnl+OXTyoqvRaieEepKL394TEXNqCqSVIhYmPNTrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zTgpbvlJe1OrcEL4Cu10UC2X1Z6jebYSpQWyl7SwO+g=;
	b=z+pbBS1cCFl4Zi/P0/DzKX7SreJbxuh6biZijMvYNZ+HLTvyDmfNHidmy+lbi7Fyyuqx
	 cLMjTsmqS6EeegkiZ6NgY/4SZDpjTH+bugjzQ7b7MfvJc1rQOvEE7uc79CGfoOqCy0yat
	 r25vKrf0qwQ5kcd+imw4K9jP9LNlVkZvwOiungRlysZ4yGTvEvnwwPG81scDJIepJIKLa
	 H4rqpCfZbLbSZ+Y83St2+/RGlk7N8QHiGg7/l88bOAcxD4It0s9jrGRH1KLl5iaaA0TvE
	 fYO6LwG0TtNm5Dq0ljkdfac5jO6EiMhyWblDJXVEq6ElHpgEy4pW+BTD7pttCx7zsYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IDj2/22N";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D162606A326
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D162606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDj2/22N
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so14099705e9.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793574276; x=1794179076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTgpbvlJe1OrcEL4Cu10UC2X1Z6jebYSpQWyl7SwO+g=;
        b=IDj2/22NLK5KOKRR1nKvmNiVDxyXytKF6ivO3ssWotC85qtO75wCmSFoFGwbMUykKz
         BEI6WHiugMBNFixsW9hIvTVvr7JChaZM+e5Jlt9m0cbGvSHky22M6tknKopXQyxsMMzf
         GjNVG0m+bOVsaMzkHle7VhLZ0KWy/mtrR5GAvvnxH812TK0SKuJdNVerunWhuaMCFWOW
         xF59mQpUjEhRXOQsg3ka0UTtaG0p+MNY+VMozNrZzi2QWFUH2WQ6OgMhRFoLqijq/RK7
         RuRxfX7Fofop8tUBio9Rss8ZU/IYSi2gwAUdccueMAOGhTnbYYkKyYhNBAvRiIqqRPTG
         w6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574276; x=1794179076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTgpbvlJe1OrcEL4Cu10UC2X1Z6jebYSpQWyl7SwO+g=;
        b=ASBm66DzW2sF2/gnqtZYSpPEvyclyFCWKh1Mcs2ImqbpwIhgCW2VCD4X+IpQeqIV21
         xUPRUIv8OHr+HUulGVzM8D2N8EQGAgXTNL/p3rKa9z7CdtMqCHWsZS07MTLqsK5F1Xcf
         tOzng0VzKNj5wJBuVXQXaZC1httQsk3phbBVbl8PtJhfCX4fG7mmzPGVwtGRCBW1vQQQ
         W9dbIE8eTyx3Xp0CDYHm1TOyFxrDWE6JFYx/9oaFHE2pGNz4898UsMhAuBBQUjXkqc3B
         DdtxYLknJati0yC3QDlCwEoNbUgwWHgRXOTbw/rXb6CAVFKZg4YWF0p1Fq5xZ3pXr3IE
         o1uw==
X-Gm-Message-State: AFq9FYKgqFHyevJuzT3UCWOlt3j+YM64riS6o/FVryYsLxcFlRbxh2e2
	o6fkPGdV1WqhcJbGTNR7JnkqKQcoQ6Xge0XxigKthKUQ9KROr1Zh79kfvN/7jhuw
X-Gm-Gg: AYBFou17Pj7dzb6lnbWc7IQSnQaDgVsUbicaq33kbs77MM95sYXkeq5lI/U99BCKHD9
	mtXXdNcW2bbNDLeJU+D7ZYKfoMBjniY1+SetWybzy+C2KvxMYOmnRanDu10OvzRwpAYTCAZ3y9S
	YNdmg9yZQxGcgpY7+Fyz50+O7cd9m6n1Ehw1uJBKq0fWlww80j3JtpRxkCSfLFi0Jm2fQ2U9Ebb
	hZahqgPrfk2UMLai8jOMo6vDDkPM09yhArQsJrmNZU2Ucps4/ZJJqgXQSnCwkbT1Us/jtbk10Xf
	iOHl1Qep8WjaT2t2vOnjZfvyNntIgaXgEy5pEa/AnxAYIAW9nzaz8qjcgg+bs4Cgb4ytTwDqQcT
	8b0HatnGgJ+2RpllGLTw7wnT1VZhUE1wVzCLvRWKUcGJ6FRgxDdP6OaSnRkAyRykM9LKT+TnExZ
	riypT+hONP/9gGWUjjIQxNnCtQTJ1qTCYST3YITmxouenDXopED4zB1x1vuGIRYqTTr9zx6nZUl
	fj6y/3ND7OebqeDKUGrnE+UsJPmI3kOKlRxegLFQ7Qsgpo+LYtzZcY4RheXMbGvraLGDkJW1Iqw
	TG8ko1+gN6TCO2gg46/CS3lYZBgH8x6VOBxy3pWnHiznJVGZOtkSvD4U8vmr7haZ+rJSJYTqIz6
	fQaBEjkvWdhPmaGUG+gFyaw==
X-Received: by 2002:a05:600c:8b61:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4ac17752ee4mr181585855e9.16.1793574276419;
        Sun, 01 Nov 2026 15:04:36 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm135151125e9.4.2026.11.01.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:04:35 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 1/5] doc: glossary: add root ref and clarify pseudorefs
Date: Sun,  1 Nov 2026 23:03:19 +0000
Message-ID: <20261101230326.3675597-2-andy.koppe@gmail.com>
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
 Documentation/glossary-content.adoc | 73 ++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 52301a56dd..f905b4467b 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -500,18 +500,25 @@ exclude;;
 	unusual refs.
 
 [[def_pseudoref]]pseudoref::
-	A ref that has different semantics than normal refs. These refs can be
-	read via normal Git commands, but cannot be written to by commands like
-	linkgit:git-update-ref[1].
+	A name that can be used like a <<def_ref,ref>> to refer to an
+	<<def_object,object>>, but that is not stored in the same way as refs.
+	For example, pseudorefs can be passed to linkgit:git-log[1] or
+	linkgit:git-diff[1], but they cannot be written by
+	linkgit:git-update-ref[1] or listed by linkgit:git-for-each-ref[1].
 +
 The following pseudorefs are known to Git:
-
++
+--
  - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pull[1]. It
    may refer to multiple object IDs. Each object ID is annotated with metadata
    indicating where it was fetched from and its fetch status.
 
  - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
    conflicts. It contains all commit IDs which are being merged.
+--
++
+When a pseudoref contains more than one object ID, using it to refer to an
+object yields the first one.
 
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
 the `refs/heads/` hierarchy is used to represent local branches whereas
-the `refs/tags/` hierarchy is used to represent local tags..
+the `refs/tags/` hierarchy is used to represent local tags.
 +
 See also "REFERENCES" in linkgit:gitdatamodel[7].
 
@@ -640,6 +626,37 @@ format. See linkgit:git-reflog[1] for details.
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

