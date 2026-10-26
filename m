Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018416;
	b=sgg9esdhudq3M/gk/73i52DGnkJQiUqGjBLI4gc2MmQCjHB6eG7SxD95sfLQqj9FYbnR
	 biMTR8kviol4Ai6SUkLVmswQjFcmtHVoRdXzwDq5RBxAb5m8qbUEdtu74l2npGc9wSl+F
	 XwCThVr75nx2T4Im234PUeL2OV7ZTLQFTQHauj8KPKlJRH1wVlW9zZGSnFGx4L+V4IxLi
	 li9tjTSfG0SuahZx+psMIMvTfI5vUo05AJloyUJtyTSkfD1jf6faUSVnYduUWBs6gEF/U
	 sudxurbj9GiniI7+uT+sQwGLMKoIZzgGrbeNZj0rO4xZd3VUkkfd2Yq+haZFbFugrBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=6Bp2MKaX0PpYbdRtDSzznwJnp01PYGb4f7BkjNhVFEg=;
	b=zmfDLqXS8PBRelmYqOArviS9NEOmTGJR3t2f8Ertn6KqVXYgjsbvLOSvWliR5rHg2jS8
	 EbA2HghjUMX9VTJC7yq5NUKFnE1ngjShugH4BxScBFR4zvw+OsgDFY74jDuPfN0l9rQbs
	 KxuHSlKbPdydmjhqdOsP2cR+6ppdNC+83entg+KzKZt9BtwByK7WRMKnmpefyYkqWtisn
	 CqYhnc/FPpvH1jWRyz29uk6rG+OmjXOU6pIr6K04wkctSCxWKImYA7g7v08xLv1oeSGER
	 Poq6/T+PQdo2cIKdlnOuEhf08kxvy1XEt8kIKD+qNwD40tqtWlKKUKaB9O7ybR/u72A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oo03tn9g;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7F60A2613
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C7F60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oo03tn9g
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso1786725f8f.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018414; x=1793623214; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Bp2MKaX0PpYbdRtDSzznwJnp01PYGb4f7BkjNhVFEg=;
        b=oo03tn9gdXr8L9PgR2wm7BfisMnxpxAf067Z6bEfBflwiAIGrsqMIW16cxWy0G7CxO
         2zfxb73XmwhMzCwlNnifxzVKH27TP0Qlp1aDJl+Is2nzb3/fxgWNsbHzzXDjeZp11QZc
         N1Nwv5NPujoIBmEeSTYYLFGw3xMOeJ/6VLzZzCD2wfsxSkgNZgWc+hve9p/DfnKRd0hc
         wHA+FpGF0FHJIsEp1GVG7h6uKSIaddaptWwcEN3IhdEKL4FGsXtmvYdsiLQ7hkeFe1rR
         7X/EvEKzei80vBuT+2al+nK5+xHzy0gYvENApZt4fcv3kUcZrjEC4xC9lLHfEXW2hKlo
         Ee2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018414; x=1793623214;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Bp2MKaX0PpYbdRtDSzznwJnp01PYGb4f7BkjNhVFEg=;
        b=gNZ2swZxLx+ipp5Xnwjn6CFK62sQvsj+kRS5rfc7LELgQVoZbGNScSe1bkFxi17579
         w3sIUY+vKdEmZb4bV3EHp5yaFeq9dPaXW6jnoqiK3LJeBJgh5M1+Zj7YQVsnfEPFtr+1
         nNK20h0NMmpRdyayScVJIxCRf9cGRvoXD5FKcn/wiC8SWMrFm7hWFBKZJduxxZHOWCoG
         viOQSZh7z2ZaBqOCRHC00Us8/bYC97ZEuQ7LaMpve3Pcm57yUQPuuIvOK3fT+4xqJ6zQ
         2fDFel6/syfX7pouceTmGb63UF48pY28fhTG/vFRN5irO2JVUbhEYDHMUs6wBJIzkOKh
         Lzkg==
X-Gm-Message-State: AFq9FYIfyCNojRVhkaCccl3PYyfsI/QH3zlnsT+K3WB7JBsClKnyHv3S
	paRiPx9WTMWW+46khFqVE+Wj6STFSfd3wDTi+/eI05qDwaCfc+XamrsBcXlFfKistYg=
X-Gm-Gg: AYBFou2rus9IbOgVrWsvXMJdAzdpybSE50+9aCMMqiaJMjR9zR8RhyIVv7rWKK1lRrT
	5aYKPy3JdqDSxArZi8nZ42K4DgvDrK12oqwOu2urFRlATkhJ1fBdjN5TTvmkb2d8MZOPPvRns1a
	GiBk9sMAc/JrtAH/YeLndoICfRr0mlSmQAvG0zPMiwWY124y92A8SGZHCMpkwc6puCKI/miPFzZ
	8f2eo4AnftfV7j5CTFfGoou5PZ0Su0YHOJWjlLpJyvweNu9RUQxdNVZRrhRawvLCD3Sh+buM9Vt
	DxcjgXtRv2ctKb2TQ+oAX5w9j+PS+1a+kBvvP140FQhbXYKUu9cjb2kJ8ZFT6w653UriMA2Yn/0
	4z+yBGqFx7paQAsre3iGtJXRTcEyP5MLpoUpUkgcos3OEuHsaJ+uyVurI0laRvM/4pUQkzBY5Rw
	B4iuxPbRL7yCOLkfEi6JkfS1szyoKqnwFmxcj1gA8lP8QzSm9kd8n5z6eGT59mDQsw3EK2QrZlk
	7Jvb9C6/eYBukfwZdJPIbIsPY9d+xE6ooQLdEIEjg0FuT5TEPX8qk8yKPCs
X-Received: by 2002:a05:6000:2408:b0:48d:f5e7:bb77 with SMTP id ffacd0b85a97d-48e3eab5a61mr15448890f8f.0.1793018414125;
        Mon, 26 Oct 2026 05:40:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.191.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8c05sm20621839f8f.49.2026.10.26.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:40:13 -0700 (PDT)
Message-Id: <e1fe1c4aa3e1248e3b9d1bb4bcc8786265468157.1793018405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 12:40:04 +0000
Subject: [PATCH v5 5/6] doc: git-cherry-pick: link to new merge conflicts
 guide
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-cherry-pick.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index f4cd8b9db7..069e434961 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -19,8 +19,7 @@ Given one or more existing commits, apply the change each one
 introduces, recording a new commit for each.  This requires your
 working tree to be clean (no modifications from the HEAD commit).
 
-When it is not obvious how to apply a change, the following
-happens:
+When a merge conflict happens:
 
 1. The current branch and `HEAD` pointer stay at the last commit
    successfully made.
@@ -36,8 +35,8 @@ happens:
    conflict markers `<<<<<<<` and `>>>>>>>`.
 5. No other modifications are made.
 
-See linkgit:git-merge[1] for some hints on resolving such
-conflicts.
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a guide to handling merge conflicts.
 
 OPTIONS
 -------
@@ -259,6 +258,7 @@ $ git cherry-pick -Xpatience topic^  <4>
 SEE ALSO
 --------
 linkgit:git-revert[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

