Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AF30E829
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918210; cv=none; b=iqUIU7WrQ/YNw0R80RTXUWsK86zUP+D2kFc54nc5hod2N7RxrRa1oLp8qJENiqyo5lEKEcPQA8fhbOXQNkNT0mP6txCHypCHGVLEkR9qkwUsJo9ofO4XVgaMrnhTiYZuexUjyw+IqUPqdvvVU73c6cqnJOMpHJvhi6TMOVGQu6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918210; c=relaxed/simple;
	bh=+WhakYTF6UlyRD8TyJVZ7WpmtmhNnqQ2g0f6h8ue9m0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CwhAgIHaaT3O7ly+4jVWgUwSg6P+g6EP5l32pkyjj25IoQux8KNYNenua/e7pMUMdsncxBWouHUDzgYQmscdB1jdpbWMTs4XX9+xU49CY3vgplCBzRfsAdEM7irTrav7gHmZ6RDXlv5ITeGoymVntlNKV10DRFCljIeDAuwMgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3tMPWh8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3tMPWh8"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-809f849bdd6so16064085a.0
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918207; x=1757523007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM6v0541KAS5movbBoOycIY8HOXJGIz3fEnWaKRykgI=;
        b=O3tMPWh8j9WSOHz36Re35BTrWeAiXbDPDIcJQYzqnBS0MMTIFoia8C44fGVCJLq+VB
         rI2k7gN3nh5dkLiAYuB2m1LHjlTWfJNoQTsx2eWwRxl1/lWB+idMqsmqYWa6K+PGwQsF
         IsgIVdPuknYKpjIR473Ymda/cpT75l1OdOvPLNvXAtg0M46bEVbDq4wvwgMF5NbwLu6H
         k+UWTQJueA0w/acLVRkZF4DaGL+uFdxixNF2BsnhSbDhRaedWajhE6oBc0u7Fk9jPjFl
         W0EPDUX5tobYkL48XYmr47PT/yWzK3vXfbcLNyBwTnNtjXi9TSiZiDe1VC7mfwl8huIp
         XDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918207; x=1757523007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM6v0541KAS5movbBoOycIY8HOXJGIz3fEnWaKRykgI=;
        b=FAJ3Is0fNwv1ulf4HBuPruYg+CQo7umu01ZeTwNw5pqX1afrDhXJgetBMnGQfM34LD
         ALeUyJ57OKktvGYDekbL6job1sVXGQIthhADtjXuZmgCTvKNhyboRBKNKQLKNy4iPOiu
         qQfsO8/IlqplzLtOpax9vqf96CHAeJDAuSWPmDbWBZ4IuQLfal9Y16j/3JpCrpl/n2hc
         SSMEPuKZQSlSgRZSnmlxXYM53WzjnEhfpJ/dYiAmgUyzeXsq59S9kMpTB0FgsNyAolUe
         mYTdNtQVkIm6MaAp/aZtECAsXXzZ0Gky2N4FjrT3npeQaph7Qoe5m1d1MTZJrcdqMsdo
         buwA==
X-Gm-Message-State: AOJu0YyoZZZXham7/GrWiGR9fo8kRuymqm8+91SBohQELCwzTcEimOEW
	Htl6Zo2lHEpn/bD0PYDboDcF+9hsdNb9qq+UleWwkQhZ5fcBJ7rQkSsobBb/eA==
X-Gm-Gg: ASbGncs/+YycNESxmUrl6NR4mdarmdGoqeZfEZxHTb92WECEh++GESrbX29zkPoSjKI
	zURkACnEqEej1disTk5BgjScEX6m7cMLbRL6EDwQfA9AVzQCShxzsMFBQJp9wwdctE4VEjzJWzI
	wSslUucCRLJ4EhBxuJFUqmsSjqwxY5/rvJ9WH/MSSgAcPTgBUxocdU7tbsh6TfN2SwS1f1YFwBG
	wh8b69Qt0gU1GiVGuXfCfCUd+JVLc7Du90/v5ow8Bc465+ev11XKQVqzOYrtVASGn3P3gExtkJa
	CmpSUbh76BZWwYBqmIa/jV6LGGMVDF+qDrXQEd4IEekJGpcab62XiilG84df2wM+JaApz0TlyPA
	dYmSkvUo1lzEY4IRN+xE/JP7r/zdZs1j074U=
X-Google-Smtp-Source: AGHT+IEExyDNZlecFKgzBwRTImCUJie1fDHMUVl8O5V3I3VFbRO2HR+k7Fv5PpwfV5B0B9TJc8LcsA==
X-Received: by 2002:a05:620a:468e:b0:801:f77f:d764 with SMTP id af79cd13be357-801f77fdd67mr1220734185a.78.1756918206969;
        Wed, 03 Sep 2025 09:50:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f756d16sm13697051cf.34.2025.09.03.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:50:06 -0700 (PDT)
Message-Id: <940cd17e7e15684c0ca8c7b2994835f63e1fd02a.1756918202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 16:49:58 +0000
Subject: [PATCH v3 2/6] doc: git-checkout: clarify `git checkout <branch>`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Reduce use of jargon ("index", "HEAD")
- Clarify that only identical files will be left unchanged, and that
  `git checkout` will fail rather than overwrite an unchanged file
- Explain what `git checkout` with no arguments does in a more direct
  way

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 218d3dd13d..50923ff118 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -28,11 +28,12 @@ DESCRIPTION
 See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
 
 `git checkout [<branch>]`::
-	To prepare for working on _<branch>_, switch to it by updating
-	the index and the files in the working tree, and by pointing
-	`HEAD` at the branch. Local modifications to the files in the
-	working tree are kept, so that they can be committed to the
-	_<branch>_.
+	Switch to _<branch>_. This sets the current branch to _<branch>_ and
+	updates the files in your working directory. Files which are
+	identical in _<branch>_ and your current commit are left unchanged
+	so that you can keep your uncommitted changes to those files.
+	This will not overwrite uncommitted changes to a file: instead it
+	will fail without making any changes.
 +
 If _<branch>_ is not found but there does exist a tracking branch in
 exactly one remote (call it _<remote>_) with a matching name and
@@ -42,10 +43,8 @@ exactly one remote (call it _<remote>_) with a matching name and
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
-You could omit _<branch>_, in which case the command degenerates to
-"check out the current branch", which is a glorified no-op with
-rather expensive side-effects to show only the tracking information,
-if it exists, for the current branch.
+Running `git checkout` without specifying a branch has no effect except
+to print out the tracking information for the current branch.
 
 `git checkout (-b|-B) <new-branch> [<start-point>]`::
 
-- 
gitgitgadget

