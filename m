Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6A17A2E8
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743249816; cv=none; b=UqcbQI7bGWwnKO046cUurFRBseuyo6jIkMo91lAnOrc3sTx6+3va57T1qX/FMWiTaeZD2wr2WBGZWm7ZNtAJvHntz+ySXC60vdjMgLQ82KQioZT+J/mjsCLMGjNnM8cIQfzp4HzbhveaFNEcu0vVRdTuejUHJlupiuorlHns3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743249816; c=relaxed/simple;
	bh=KHucLO52dZJ0e9vesGT9pw7XP8G9oerrkKtElAqbDs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SH4bfYqOkew3oydHWb6iXHJr3bG0NH4ttJAL2H8mUSm4mVFxk6brtRT7SzDSK/VWFYQ2fXPiXwzGymlrXA4wBVS+e9CXCZYGreuamWdqcMZAL1r2qSUcKGG/Q7LGrR+4JsYj1JYalcWhPU63TOx6h+8IdUun0x6KbF9x/XeTSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Boy2NxQo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Boy2NxQo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22580c9ee0aso65065925ad.2
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743249814; x=1743854614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn+iCDxs7V7iRKNCYaUqanAOLokx78Ltb4yE3w03UA4=;
        b=Boy2NxQoMRi/UZ5bpP5hOBriF40JyooZNYJ1Ap+gNfylAqVods2FsXVV74JOKem1s3
         +qgKIyY0uGQpOjbNDJSN5fYFjTcXZ6QdyYIEhbcbA5WJZPO4PBPuECe50L+/XTvKeWAP
         fXerlIxSStk3QJRfiBnN4Vgr2+EdFFSNB/5bvbtQ7YeeDrC6+AhXweZE2quvZ5X8rwEP
         jUxNKeAeLuwZryyt/4J/A+1l71JydFYPN6dBYv3EGvTTyW773lF1HrHRM+5sftn8CjiJ
         aYx51Dyqi6HY8RWvkV1IfjeIKANCtI7eNV3eNPDjzJICS/GBDvmeUIkdxjBnnx+O6W0A
         Tkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743249814; x=1743854614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gn+iCDxs7V7iRKNCYaUqanAOLokx78Ltb4yE3w03UA4=;
        b=wFBTrQNqKZJXigq35a1tEajr14XCbc9Hx83fjKyE/d8JeDaZljsEWCuYkVSkefIO2W
         4N4B6UQYeoUh0r+h0J+eAUurribGhkSDvFjPiiVOFJFqEJG2q9FAL+peNzfxNHiVJWhR
         YbmxqU1ikIgXvccUwH49pb8dj1uZVzNWFW5v1L4UPblW6qewm8KWnSPoUC41Aw9e1xfM
         NnQMUm+AqwVJhUKjWZQ2udnENZ/Cuw73tqsO5JOMLElSTbgKCjogZh7lmGyEUWdAXxb5
         srGJLg0QgsRO08yj5P+5Dhhe5v1F2uAHEioVn6+GfrymGOsO/VN1V3kYN14TBkbykYmi
         Qn5A==
X-Gm-Message-State: AOJu0YwUVb8rs3uglxvwxW+p3qy92/CwMTz1olCrtGCWLew1CS4NxXS1
	qgBTcovTbBiEYFQWq6HNe8XzzEqPTNJ7JBn1A9hpuuRO/+U7XsbEDRHPfg==
X-Gm-Gg: ASbGnctn8NiOQx/li+jcxpxpXpbTY8/hey48T+qu4crgU7UMns+71ydvT742jYEPEXf
	noJo8hTTce5abTHYD+CmLJq43IEmPquy4ODCnf8DX4ynb99Nx4cgUAjyXvD4DmEEB/djHxicI3n
	TR8NZ4qiQ7BjOUheL25ALbEoCYOC3Uk2cd6bQnLWgbkm61Pz4fHZM+5V1VgUhwgO1eQC+w12xvL
	VtpUDv047YlPLMxpc8EE/eL9B3VTAfbvL+2oJsaUR4c7yDWWf6gzqOuymKUqcNFgMA08vUF/CFT
	FSPSZy0621uuHnV4Z8pFIdZaVSIi8NgazonbRu5FhcCgZSBNlPXBUkW/TsnAki6pi0eY8A==
X-Google-Smtp-Source: AGHT+IFFXgGzy+uY+I84wfR1eYdnubTyeQmY1sdtvIyWW8c9msvDC26JvKS8E+x5MXTFa6CPXjZXbg==
X-Received: by 2002:a05:6a00:a93:b0:730:95a6:375f with SMTP id d2e1a72fcca58-7398033f039mr4224611b3a.3.1743249813592;
        Sat, 29 Mar 2025 05:03:33 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e290f8sm3560745b3a.59.2025.03.29.05.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 05:03:33 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	philip@example.com
Subject: [PATCH 0/1] remove unnecessary if statement
Date: Sat, 29 Mar 2025 17:29:24 +0530
Message-ID: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an earlier patch[1] which has been merged to the master,
We checked `repo` is not NULL before making call to `repo_config()`.
Later, in another patch series[2] which has been merged to master,
`repo_config()` was taught to allow `repo` to be NULL.

So there is not need for checking if the `repo` is NULL before calling
repo_config() in the earlier patch.

Also, Patrick suggested having the test inside the
"t1517-outside-repo.sh"[3] instead of having it in the individual test
files like[2] and I also think it is a good approach as we will
have all such tests in one place. So, for this patch, I added the
test inside the "t1517-outside-repo.sh". If this is accepted, I will
move the test for previous builtin cmd which has already been merged
to master to "t1517-outside-repo.sh" file.

[1] https://public-inbox.org/git/20250210181103.3609495-1-usmanakinyemi202@gmail.com/
[2] https://public-inbox.org/git/20250307233543.1721552-1-usmanakinyemi202@gmail.com/
[3] https://public-inbox.org/git/Z9vCDFRUG7IzU_AG@pks.im/
 
Usman Akinyemi (1):
  builtin/update-server-info: remove unnecessary if statement

 builtin/update-server-info.c | 4 ++--
 t/t1517-outside-repo.sh      | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.49.0

