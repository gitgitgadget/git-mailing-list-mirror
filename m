Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020002;
	b=Hm98coav0U2Fc4DKIj/MuOXTOvcgHsfhgeQp5hN03agOVzHWvaswHBrUaX9pW2PkuQnn
	 6S4xAnKPrzRy7TceQBWRkzt1Tj0nYM0v03WKDv8j17ql8DiWNDSd6sXQb0561vhsnnM9I
	 dnbLW1T5MAxWCHD3iI+OTUtu3ABSxqyFzvX6MEPdwwvXX6SaPqUJyx3RPVUj2T0Z1C+eH
	 WwBM+Bg8McEFdDpwv37scIOv+tSKIu328u4UDXLSWusp06tiwQoifRuCtXM4OQSPNIdCe
	 HV5WAcGYHisZ1PERb4MTmGPQOR1wVhPDxHtZqdow9BPPJLp1OXMtFbZFQGGdK0xKh1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=uqY+sgVTgZv0X6ZJDV577N3m+pIR73VcmEUw821qeqw=;
	b=BqUe5P+P5uZB5M4C9LocTJEm+/zd5EoWzobfKS6eJqwWc2WmRMji7zvIEbglG+Oovzv/
	 ItT3ln1UUjSFxNKZ9E9zGgweYizUSszp8Bcri82oEe/axSypDqSoeO/D/cYWpQw3vsIas
	 bIRtQCswPc6ApXXBlhUmyq1YZgC8YRTI8I+LgKdSogeHExb1Q2Z20UV9nrOn7mQdnp1bT
	 Mmj0xrieY6RAHpY7qaGUcyoAQx2QSL2BXC72hzSpMO4rJ6rtzzlqKQwr7Nj2twtpDAhgx
	 JZN/XewkqOqtVPtp3gdp/FetzwyOwL3DITpzLLQFGv/h4nb7sQPWZosY50iqvCF6qKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=USwgv7O8;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B4606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 206B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=USwgv7O8
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53665358476so32124381cf.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793020001; x=1793624801; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uqY+sgVTgZv0X6ZJDV577N3m+pIR73VcmEUw821qeqw=;
        b=USwgv7O8Wo/0W1pMVd7zj9i4BaM0lcaC9J5PTni13PimzBw3lmxZ9POmmp1+POodJd
         ePU2fJXDHlhK7RCej/xPPi1tnNz/7Qo+gT4vOtUw0sf/nYZZxhfGkQuQwStauT6Nfmg3
         fzMbzbLXqi7BM9JFbqcizQHeOJYWo4abuvaAv+7BnALJzd/7Tu0KMQFHbh1zqF7W9GmE
         bHrThNegm0ouqoJm0x+eUy7eguzaQKsAlGO714D7+ZpYF5RcFc7G1cb+QKLY4izdXywB
         wP5RwRcChYfIv0j5WUCyGHc7WBxU18z5DHDX7yViU1zG1N8fzwjm/Ri5EAqtQ9r1ty/U
         8YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793020001; x=1793624801;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uqY+sgVTgZv0X6ZJDV577N3m+pIR73VcmEUw821qeqw=;
        b=T9ZP9LjQbtCPzXF2NWzGwdzWwylJF+spxQmOdzlsvTWkqiCvObRX99OtNU7jbGbfl6
         uKUxeeJE0FGctVIHmMoZRVgPkjX/emkVE6i54KTZznJHNbtV8PRyec/1S5ROjXO+25iM
         04tdpkGqelyZOekV6Sr94psOQk7drZVjMoAzQcYgfSHcjd7PaN6m2+fR0Ycru39aFbHP
         kePDDxEKybGoBeObcB9TzYkknqfpiR37NQI+CaPrFFie2klcGGvnyNIitnjanjO9Oa1o
         Vjn7iECOgM2i+mz3ISSMi9StBFG1NNHVveRPniUJtX2z9ccdyTCOXvbJl1JSZ/swUpOY
         HGKQ==
X-Gm-Message-State: AFq9FYKgzYsyprWuXfkKvqP+2XixLIbNv7wUWX/krzpXjJ1BDRB72Rv4
	mvDGgmmFi4Be8BVHMfntkAn5VBA3FS7cit335TVlJ23JhH6Ny5sWaaubQB2hmi+I
X-Gm-Gg: AYBFou2OMx4W1erWM/X1P6jpgLNNDuU1w+X5y3tHer4Cyz/o+TL5DyzyXPb1DVrnvTv
	uQakH/sclDmPKeGTN+ZepqEQXRlxb3sOTbs9v/Vsnf17Lj4ZynHhszkNHgk72x+A+A2tlT9WZte
	q/JbOH6ZE4biFXtfk7fE/sEHmx51A87V72//ypwORZaMg3NwHAiS7v+RGe0I0Ej9tF1NrFI8P6E
	qWx5i9sxAMWDUb8T8G0P80s4iU9LMrxHRGWI1aSEdWY2x9kUF7Us2dXPOd7Oc6i21+E71zVx6V5
	tGnsW8iIGUyCwe79fKKZ1Hy6AZ8SgfB1eg++zQauBlbIlCqWS5S+Jz6vpKS/hoOT4FLE3eTC8L9
	6kFDYPaMaNieKxBpmLcaRFDu2iVbJNbIskAUC+XH4gOG3xIwVEGZJo88BG2edit5y/RJRcsCTH6
	Xz1wfUXzsLQVehrsDbFc8kxmMUTn1ttztqFG1fYQ3IdnuGU9TBA2WgktyHlJxROb6vfqv8hBQk3
	bY/+yXtx5IAPvwU9YFlq4yoOMlkoIRWVwDRh7sezJRCBVplaiwU00qhTfuX
X-Received: by 2002:ac8:5d4f:0:b0:533:33c6:e635 with SMTP id d75a77b69052e-5383b35280emr99400101cf.8.1793020000874;
        Mon, 26 Oct 2026 06:06:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.119.38])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53839709ed6sm54114151cf.16.2026.10.26.06.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:06:40 -0700 (PDT)
Message-Id: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 13:06:39 +0000
Subject: [PATCH] glossary: use "object ID" as the canonical term
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
Cc: Jeff King <peff@peff.net>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Currently in the glossary "object name" is used as the canonical term to
refer to an object's SHA-1 (or SHA-256) identifier. However, in several
places in the documentation, "object name" is used with a different
meaning, for example:

from git-rev-parse.adoc:
    Usually the object names are output in SHA-1 form (with possible
    ^ prefix); this option makes them output in a form as close to the
    original input as possible.

from gitrevisions.adoc:
    Here are various ways to spell object names.
    (lists <refname>, HEAD, etc)

from git-describe.adoc:
    `<commit-ish>...`::
      Commit-ish object names to describe. Defaults to `HEAD`
      if omitted.

Especially in the `git-rev-parse.adoc` usage, it's clear that "master"
is considered to be an object name, which is not what the glossary entry
says.

It's important for the documentation to be precise, and it's useful to
have a way to unambiguously refer to an object's SHA-1 identifier.
For example, the term "object ID" is used many places in the
documentation already, and there are places which say "object name" and
mean "object ID", for example:

from diff-generate-patch.adoc:
    The index line includes the blob object names before and
    after the change.

from gitformat-pack.adoc:
    The base object name or offset is not included in the size
    computation.

Update the glossary to use "object ID" to refer to the ID, and warn
readers that "object name" does not always have the same meaning. If we
ever reach a point where the term is used consistently, we can remove
the warning.

This leaves us without an obvious term to use to refer to "a name for
an object", but since that's already the case it's better to at least
clearly acknowledge the issue.

As a bonus, this aligns Git's documentation better with how the terms
"ID" and "name" are normally used in the broader industry, where an "ID"
is normally understood to be something that's interpreted by computers,
and a "name" is for humans.

This is similar to a patch Junio suggested in 2020:
https://lore.kernel.org/git/xmqqft4zn2f7.fsf@gitster.c.googlers.com/

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    glossary: use "object ID" as the canonical term
    
    If folks have a different preference for how to word the definition of
    "object name" I'm happy to change it.
    
    The only really important thing IMO is that we make it clear to readers
    that "object name" doesn't always have the same meaning.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2282%2Fjvns%2Fobject-name-id-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2282/jvns/object-name-id-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2282

 Documentation/glossary-content.adoc | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 52301a56dd..b1c216893a 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -217,7 +217,7 @@ transferring objects between repositories; see linkgit:git-replace[1]
 for a more flexible and robust system to do the same thing.
 
 [[def_hash]]hash::
-	In Git's context, synonym for <<def_object_name,object name>>.
+	In Git's context, synonym for <<def_object_identifier,object ID>>.
 
 [[def_head]]head::
 	A <<def_ref,named reference>> to the <<def_commit,commit>> at the tip of a
@@ -296,17 +296,20 @@ This commit is referred to as a "merge commit", or sometimes just a
 
 [[def_object_database]]object database::
 	Stores a set of "objects", and an individual <<def_object,object>> is
-	identified by its <<def_object_name,object name>>. The objects usually
+	identified by its <<def_object_identifier,object ID>>. The objects usually
 	live in `$GIT_DIR/objects/`.
 
 [[def_object_identifier]]object identifier, object ID, oid::
-	Synonyms for <<def_object_name,object name>>.
-
-[[def_object_name]]object name::
 	The unique identifier of an <<def_object,object>>.  The
 	object name is usually represented by a 40 character
 	hexadecimal string.  Also colloquially called <<def_SHA1,SHA-1>>.
 
+[[def_object_name]]object name::
+	Depending on the context, either an <<def_object_identifier,object ID>>,
+	or a name used to refer to an object, like a branch name or other reference.
+	The meaning of this term has changed over time so it's not always used
+	in a consistent way.
+
 [[def_object_type]]object type::
 	One of the identifiers "<<def_commit_object,commit>>",
 	"<<def_tree_object,tree>>", "<<def_tag_object,tag>>" or
@@ -553,7 +556,7 @@ The following pseudorefs are known to Git:
 	to the result.
 
 [[def_ref]]ref::
-	A name that points to an <<def_object_name,object name>> or
+	A name that points to an <<def_object_identifier,object ID>> or
 	another ref (the latter is called a <<def_symref,symbolic ref>>).
 	For convenience, a ref can sometimes be abbreviated when used
 	as an argument to a Git command; see linkgit:gitrevisions[7]
@@ -645,7 +648,8 @@ format. See linkgit:git-reflog[1] for details.
 
 [[def_SHA1]]SHA-1::
 	"Secure Hash Algorithm 1"; a cryptographic hash function.
-	In the context of Git used as a synonym for <<def_object_name,object name>>.
+	In the context of Git used as a synonym for
+	<<def_object_identifier,object ID>>.
 
 [[def_shallow_clone]]shallow clone::
 	Mostly a synonym to <<def_shallow_repository,shallow repository>>

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
