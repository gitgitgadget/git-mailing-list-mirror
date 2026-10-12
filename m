Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FA495035
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816804; cv=none; b=i67etiA4rfja5T3ByvGh1jJq9a8yv7gQoIxlObIfheOuT0Wq6MNpAG11BJNDOsMvlmE0wkdd3PvUVLsp3+uiYwJrKE0VtF/WiVCZviD9CL8WXFWCo9tP23Zwg2hEW/lKl6/GwYSvVspW/jjkWTXu5aHlLX2Rgcg4uK4RsTTOBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816804; c=relaxed/simple;
	bh=AbvkcuA1vOKjb84e/sSf63w43Eez3tLnVnd0vN1OJx8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QXSpR9TucMiHHXL7K3GU5BBRXAPRJxy7gtlxO2NU3sofYiHIUWKzsdEMVAikqwGckl0DGJ0oTVehnkfXwHa94C65AeDYYlf7RhmDaNbfk23qdJv9PHlRJEBfZWOonuW63vC9GyweMdmRykJpRlwsZkefXl7W2BD+uCFkC3omZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLGtMNc3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLGtMNc3"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533861a59b8so24033281cf.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816802; x=1792421602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=nLGtMNc3bp0Q4Z/zAaA4d23czQsDj2al1T2aPrEHNsHA7Ex/MYrDJvq3KGC6cogFFJ
         LMmylpwegFkyeEkJRe/EX7KpjljiLoifrnsKfDrZjs+mCpAcX9YVDJH6otxnB/F+4j8d
         AwmoYwgC7d/PDdZHD6IONvy3fLuyGsKv4T8FUEBwRxJmnn9f+kNjse1l72rECnOskqsy
         1MVK3xvdqXPW31+zOsuxkJZsfx9QHI8ojW9siwmQUEE84IvLfjWV8wgb3A7QgcxsmG6d
         DFdQGa94ryqgu7Q2ofxUBfAVzpjhQU2ps6APvya7E8+v8skiQCXspJvuhIJXq8qjYFBJ
         /+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816802; x=1792421602;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=RuVmcVuDOeUQfFOGSK+tDH3k499z3lIx18sHJYjoIluzOhj8gfT/tUFpkvzuK0GSbo
         YBzagp7iVH18Pelf1vbSjfb1/wdu0ryoGUDFlPnalia042LKnHHH1hhNh2vDEau5YcXK
         jtl9S9jM85G0OUCZD1l0gXqhV62HDV9eQK2u+wnOefnj6SCOyz24Cmon1MHPyBh2Fss8
         7sL6BHHh1NIdH9xfDLZqe/1wNPFhUjtWTII+qyPOueEGyFDdfgdh1ywo0dryVP/A1z1A
         6eJP408U+l1B+XiAP3sKLsMmPOLwZ/kVaJcgZ8hRgu17r5frVRHyOGETCw2cfuVut97k
         5CuQ==
X-Gm-Message-State: AFq9FYKyFskjNWP3U/AJ8BaB3pBufCgM8QIaCPfNKDr4OVkHnmFHegsb
	utqPZAxMQDPLt6thNK2tDbEtrVsE9f4/7T/4MGQl8xNgDUoX1EcF+MIpOmy6rPuI
X-Gm-Gg: AYBFou1oQEpZPxK3mO00l5VqzmCo9HaYjjdJaQoKjA0Z8JDWJonihv+5RM4J9gpwpcv
	LUfMyrLWzeXEJiMaNkD3NSuAmcC+3l2OWIwS4dJCPiJJiKMiLBsSY2X0hCBc0Mh0E3OZ4DtGvVY
	ek5dD4DmysAzksxxsLa34rujhpk3Mgg/X0tgY9Pr66K+Lk+OxmA4oboBgO8baseDhSKncQ7BSXd
	gcsFHk3XBmDdPqxhD63Brsdgw5Ad0+Y0Ex2JUi1o/JF0B4iQjJvRbIVUROlr/dR+o6lsqoWlStR
	RGN6mKpC7S0MLFrGAJlgSKl2d5yUi38uA/Bw0zSBQPMNcyI5jvISjjxjPikzcYbS6T4j4XEvGXc
	t2oXTw5hg81IYgsAORLUQx5+7E83SjcrldXszjhC7SxDqoe7uLHAN5AiTE0wStLRIw1RLdrNbXi
	YsQBKilFYzsLSIzmo4+6qydQ8mZulY1t0qoKiHvlYsaVz9414CfRdpOeqUcVvEFUu2UpXNLMzN
X-Received: by 2002:a05:622a:1116:b0:530:e89b:519a with SMTP id d75a77b69052e-5359fab1663mr169088391cf.22.1791816802489;
        Mon, 12 Oct 2026 07:53:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.84.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b755c35sm80515631cf.15.2026.10.12.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:53:22 -0700 (PDT)
Message-Id: <7831b77178cebae6bf62e9f48d9e863508686d14.1791816795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 14:53:15 +0000
Subject: [PATCH v3 6/6] doc: git-pull: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 88f4fd3926..73f6d460bb 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -38,7 +38,8 @@ or `pull.ff` with your preferred behaviour.
 
 If there's a merge conflict during the merge or rebase that you don't
 want to handle, you can safely abort it with `git merge --abort` or
-`git rebase --abort`.
+`git rebase --abort`. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
 
 OPTIONS
 -------
-- 
gitgitgadget
