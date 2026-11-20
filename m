Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201221;
	b=YcmQKKBL2AELbGfzfBXkpcoN1jathLiWkmBxyidpXiz0XzXNl7TZpfl5AZWw22wosSHU
	 4gbI6YiQ2kD3oRkIqg6+o3FBVDsSsl9jf2ZmHHz4EqCY3o3Xpj5Nw/MVOsNi+wybjeZ+G
	 Wyz3h+l11DW8w2/wEYVUkjlnOGlgP0OLb2WtNdpU5uJZmY+88WCVw7L5CaofDp0v8cGpo
	 WM6X1pnCmVtuBg9oVhrbMj91jmo2WeJWpmRBd/0k/zy12kZfGiMRkhZp4vjPqGdyCW/Iu
	 g6JZV8aPSQzK9nUzhbxAF6yOtGjb4ozuYrAHe9QeTyDvE2pjABacjpZawnwentEPIBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mLnfIm80TyxU/GPDi2I1GYN9H9afPuqt8Zn7QRRkJfM=;
	b=usPDt8nYSQ121TZnBo4NoDaMzQjPiz3KdUsgGtiDwbpYUu2XbPdQuIyd2lehfbA1W+To
	 P8au/4qY8gwot/l5tyeCrQTh/LxzodzKNfOQIENOs5hay2j/Ooue6ObDyfMBim5HF2tsS
	 UvpqlYu0LF0+9Y8kkk8HOrcrXJ2p7oBLxP4Sw8OCcXUVvsk0RTIFDbSgwvQRT21sIhI5+
	 B1hT9OjXz4b0aTUoE6OyyrV500ypjHYdj5n5ex+ZYz/y9beZFls3ZOOtG1txX36yKAm4R
	 +2TjaYA8/1y2bic8Bw0wnpH7wEvAgYW8y9EdNlDrMNdEaGIgc9+IpavyHP0cJzTbcyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ps5T3BzO;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D560A2619
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 702D560A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ps5T3BzO
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38190551625so2073007eec.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201214; x=1795806014; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mLnfIm80TyxU/GPDi2I1GYN9H9afPuqt8Zn7QRRkJfM=;
        b=ps5T3BzOmhbhXsydvrQ+2pjzPG9JU7EBZj7skhV3reY/HAwapUsU/90MlTkSM7DrJ9
         IZXX9x7WgKgHISC+Mny0VaGqAcJr0YlyBxl5kFayEm0KPYq29y4nsOjtX+ySpOlh031u
         z3HG74J6fS1bDLX8VKBl7BPrFeOtNEG6EifHzlhIgsErRb5hLF2HKI/4vIUmzF52H29f
         UAFdrDmwTHBe1B7rsoM8V0Uh2t11vOhH9Hzrd4PHgnC7a0sHvRI4LMu/7irP1Bb0jqCd
         XE1so68NbrcVmuL6Ha0hj8wMAKNo89rt/zYx70/0hk0Yn3CMA+Ifdh5eNRrkrwVmNeCR
         ThTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201214; x=1795806014;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLnfIm80TyxU/GPDi2I1GYN9H9afPuqt8Zn7QRRkJfM=;
        b=SPXvuiljkEOUYtt+riCrRnhxNh8KyhMFXPKR/13EpDgh593frTObHnn2pDwhE/ZpCL
         2M7rwAnInTRbCNL634erev61qXZTZXGqYIgWFmqrW8ktLtIGao1fdVCi6F1gY9HZmmaV
         oHVuZZvZOA80XwwV3nuQ15UVcTgm+8zaEESfEceXLfllwCwaLjIi1b5DZVT2KSMVulbV
         QKfOQa+gfEv3oAwK2z0pUHtPDY2/WkcIaTRDiRypbYAi31MtJ9213AOlfUQY3cW27I6W
         bi2XxmZ9EOmxQ0CgBkpWk24bV73K6ltQqr/niinxbwyK8tYHe3n2syn2TRoNLIp29gQt
         I5YQ==
X-Gm-Message-State: APuU4Z9wNtmZExLOnXLovAbKnXPApHT1c/RGLe08eJihYoySLwjSjEF3
	66Xggxvb/XwJQVbTltDV7IJZN+CXnF1+RcqeuT0rDOaDHRFppUQ2hyrGxr0T+w==
X-Gm-Gg: AZFdTZeJliNBQHKlOmnPch3jCK7Qa1OIV0FI6sBt3R1HnyYDiEeQk11AjiioAiCg8PT
	NIhVP48lNgsG9E7ZTWdpWopwMkDfFV05yi9CQW4OP/ucGwuqkbgstC5z1kf2Avq8XaRF3fODDdR
	VDuXmte3ePKK1i6ToghUFVJuNzeagxzsGuGkse15qpFgchhSjpbficc1KrM/FICzMNqAkbcErZ2
	Fe3nH8vn5pke6yp+VGtkXMWKkANiBVu3l7OoheVrlZgdiG4JQTcE/0OyHuva38kFAQutWXslVGL
	krzITE+P7H2/k/mzBXCXKv3mipdpQmpHM6gj6vnOJfbmQ68ECjJbf+8g1TIQ5sZM1YPR43NjJW7
	LllvukzF0nq9NPcWquCD4Qwbd20Dgu1KL6gcvPhbEL1ekrID6+jzfX9aN1L6E62wINBhClqst6Z
	qk5V18g6jGuVL9wq9j9c9sj2eRB2QsbZc4xZvNFhrw3yjRNcrXUqfBw4wvQYsfQbAUBBQAzwbtz
	AwofIG/TkvIpM+f4YNWOPaYxfm2ZVVFQrz62PfeeETq3x3z/RYyQ+wHPDDzT7x0PcGebc5e2kQA
	Vu48YV3pO3jU3MPtlgT0aPkkFQPwIEeO
X-Received: by 2002:a05:693c:42da:b0:386:95e7:8497 with SMTP id 5a478bee46e88-38695e790e1mr838855eec.28.1795201213282;
        Fri, 20 Nov 2026 11:00:13 -0800 (PST)
Received: from [127.0.0.1] ([40.75.135.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm11652481eec.26.2026.11.20.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:00:12 -0800 (PST)
Message-Id: <pull.2493.v2.git.git.1795201211980.gitgitgadget@gmail.com>
In-Reply-To: <pull.2493.git.git.1795177398801.gitgitgadget@gmail.com>
References: <pull.2493.git.git.1795177398801.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 19:00:11 +0000
Subject: [PATCH v2] doc: correct typo in 2.46.0.adoc
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
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

Fix typo in the 'git describe --dirty --broken' section of the
release notes (chang -> change).

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    doc: correct typo in 2.46.0.adoc
    
    Changes since v1:
    
    Correct commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2493%2FOphirBleicher%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2493/OphirBleicher/patch-1-v2
Pull-Request: https://github.com/git/git/pull/2493

Range-diff vs v1:

 1:  5cb57274aa ! 1:  c9356bf90e doc: correct typo in 2.46.0.adoc
     @@ Metadata
       ## Commit message ##
          doc: correct typo in 2.46.0.adoc
      
     -    Fixed typo in the 'git describe --dirty --broken' section of the
     +    Fix typo in the 'git describe --dirty --broken' section of the
          release notes (chang -> change).
      
          Signed-off-by: Ophir Bleicher <ophirble@gmail.com>


 Documentation/RelNotes/2.46.0.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.46.0.adoc b/Documentation/RelNotes/2.46.0.adoc
index c06a04a91b..2d7b7a0bc5 100644
--- a/Documentation/RelNotes/2.46.0.adoc
+++ b/Documentation/RelNotes/2.46.0.adoc
@@ -406,7 +406,7 @@ Fixes since v2.45
    (merge 4b837f821e rs/simplify-submodule-helper-super-prefix-invocation later to maint).
 
  * "git describe --dirty --broken" forgot to refresh the index before
-   seeing if there is any chang, ("git describe --dirty" correctly did
+   seeing if there is any change, ("git describe --dirty" correctly did
    so), which has been corrected.
    (merge b8ae42e292 as/describe-broken-refresh-index-fix later to maint).
 

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
