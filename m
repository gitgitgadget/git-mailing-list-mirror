Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764310;
	b=kyG/hvE4gE+wXuo2bleBhR7YzYe+gii2OVWYA5T44gt/SAiicYQ1uPuy+HshWXrKLU6d
	 hAMgzpWsldfadCewPSbKAqeE3T/W5zRrgPYhFZwaelzujpYsBWRDwgGhk+PSuPbpfXMzQ
	 XkPQ/KWwup/M0VQr3I469XlGuBdKior2rLgZ47eA/0nCKzWtQL4mI/RYLhSMi3FnwlkGm
	 odhAD2KBuhYy9v92MpCwLEiDg5meqKPquf6Iz0tfKbljxFSV2PxgV0ckPW816hlplMlXZ
	 enjBRvfF748iVU7wP7vUxlUJ5351ERrvk5/S026p2k0Xq+KkKkbvHiNLfwvrEx/KgsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
	b=WJipo75/q71EAQS2GGxx/A2x4Id/cbK//G/y/pzJ66Wbg2LSlofXH29BZp+JMJjK5Lcr
	 tL6Yeg4xaAaTaXfj+umeWq7KFvEyf5fpmLk5Woy2ex++Z49Wb1kB6hL8+1qzB9YDYjBxQ
	 kcbJ+JZUXH+Y8E6nnqWqAaaVNObm01w/Bs5T6Ou+Q4kGdhF9B/rZ0fdjOePYFXgpDIOdB
	 2apMRtzyFpy2O7mhmT43AJuID2yB05rgZDKyXGSbyj0oMH8KTbtlcM4GXcsfe1yXimC7a
	 +Y6qCHXewmWGZ7khctYKpW7iovlKYGUzNA+Wp/rLoUki2EZYDSes6dk1HNdMhQ8UwZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CKnIyrFs;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C45606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C45606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CKnIyrFs
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5366ae57896so8972451cf.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764309; x=1793369109; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=CKnIyrFsm5FLduwa0alyBqiRuZG0BGI8RrgKj/GPzD2jeUp67bIM1Flili35ii9K2x
         LULPFOv1u4dnPVOlFlNRJW+a3YTVVvX6QdyoOEhqNs6CSAN+YB4wXhU/mtu3O3cY9jz6
         XOJEj7nEqRdfFUTG+l4ZrPJzh+wyCiIO+/OIkmZKqqUACgbgaCEB7ya6ZAX6nAn86Vt9
         chLzjda83cz18PgNk0KKE7shMW8l+1d3nQ9Xin4ehQFiK8oQCX6GQ4YzTOpxsYlXlbTP
         QJZDX0Rayl5C9flv42Dh8gSIW+26Fomq1K7J4Yx7TC29pgFof5C0WJziUhXcQ5AitLuD
         rrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764309; x=1793369109;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=osogG8/nMBxgdBGJ7jBq4YfebjcFNXVXoRChRrFAONdzZMYiH0++tyN/dtf8/bzVVL
         KCL9AQrvJ85nRffPdS+Ne85pXjq3TK79Ib2jBBv91B8c6UwS2Aldet1lwuIsE3LNOTpq
         BLAMh0n7A6R/z6Ma4FBgZv58LKvbCpJCrBwKVxa4AzZEpAKOM90HJNX9LCvfymvjVlX1
         FJZM5JrVJPxklmqdCF+GAZCosmiCq74MDDW+Fauo9sfciynbhL48PqllBNF7RfdNQy9k
         TvAenqiCLI7Zrai26cWV7zicuh5ZDRS/FRtngJTXyrF1Az+cDnex2yrct8egzSb5nqqN
         Cp+Q==
X-Gm-Message-State: AFq9FYJXIXjvGYchbGobwIeV5LW27CfHgBCeUV3StRRwWVR5JK/3LCU0
	Mi+VgZQVVQWCamCZ+SqybC99WOJX4FEI85iVCgNn84Iq66Fvgap2RQdODd7EFQhAtCw=
X-Gm-Gg: AYBFou2x59JwEdT4DlzuZrsHvP1RFqfeQPGSKPX9uuiypNQALagFDbHhx9b2/UcRXEW
	a8XbB8C/r42hL129u989Vl1Nck2C1OU92prkq/BbVh+ohpCOq8ZhbCoMf+VPYRiKdKveF68tXfE
	bX95/napG2U+MGeCRi/4D3LFgxQcTytxeG92Sczg4RUYcN+hubEpJwsV91g8MTe6X+U5aIWh8Mf
	NmkaKBDyPuzL3n6wUwzoHVWm2fvMeuGTZWUFLsRAthBIeqiVsInCR5OlH7TBL5u317jpzlkcmJ9
	0YOq9MeJ3LyM+n6uvZPldjIOWmPYfmd7ZzNckgvYsF2q+4NTZDwNFFVqSDO/YszbPbxNG34kIlK
	SrUXeV8TfHqBmQMpuztK/0MRizo2o298IPLK5Vav11MWyZTQsCTPYDhCIPtTkBMo/r36mWk6Nk0
	VSBZKN4HQIYEtmoc/ymfer9GqLMGS6ziOXCLugSq9mVLIdQtFv5vD9b9IGQHSNCt3bUsH56Wb+4
	z1Ok/imQln2n8SKScNPAVJmmvmS7tdrxwEvfSxOvwu8J0gVw3Xx0qZGjm5lS9MtwZYoMucDhZ36
	oaQ=
X-Received: by 2002:a05:622a:410e:b0:533:3192:7a8e with SMTP id d75a77b69052e-536c28359f1mr30943971cf.43.1792764308703;
        Fri, 23 Oct 2026 07:05:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.58])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c17ecc65sm17236671cf.10.2026.10.23.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:05:07 -0700 (PDT)
Message-Id: <bbbf44aff15ab10b67e2f101682ca973ebe99079.1792764293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:04:53 +0000
Subject: [PATCH v4 6/6] doc: git-pull: link to new merge conflicts guide
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
