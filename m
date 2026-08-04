Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D6416878
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868983; cv=none; b=e6yf3s39/UdjhVX9gXGPxGrcqDGl3eNcmxIIm24sIwQnLrj1HMveBgTHc5PtTfecDnIDiIyyKV4xWSsKp7qWhI+ZDtXegOz/oHzQO+GHTyukRC5QS4M9VvCzOOvvYMFfmMG0JzeQZbINrmJIg3BdsCwbyVl7Z2Oobj7gk7tvs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868983; c=relaxed/simple;
	bh=SUnVFvl7CwakfRhybDBKDnOSgzVmmE+01FmBfK2gX0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a756XJkmmny3chgamJjLG45m21e9JXTv2721cmZMwiKwjCzXYVjjjnnSCnI/uvK8Q3ODN7DA8yzQwSupUqiwSCwB2FiV8vCADrJxgKMo48JQ+34xL1mjY2HiCOOanVbhhbrscX+DJo82qSbn9Sikh8SwED4mTIa5GmdvadUfrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnBBEGFb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnBBEGFb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so1107275e9.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868980; x=1786473780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DE9JDImRbggnFUEy/aIBwUx1YDtqkPOScxx9VXW02Uc=;
        b=MnBBEGFbaI+t/5qvAZfBt70egBoI/NlGstnSxiq53FAKzG3TeCuL0wjVVve7gxQ8xn
         xqYB9Hg2BMpyGhN5rkm+ROnQSy5cx2NOFTQzSmdH5cRZgVUVGacNVRY38c4/R0WVJ0qY
         pKgQc1gz+fvp33gITbTb0lQbQ3oKktQDLjGotGK5l101gkFgCxkjQp89/eoRPZ3Gd9i0
         HvsYZQuh8ZhqmGWahB9dakriiAcvtZYUTDUrowGJ/psIvikpVIjGCuGYtxCYWN4HfUjM
         cH1S5CgSIekfH8SXWHK5ID65z4PiGQ6AxQHZBGEVzd8gaN7gGb0/qjbhVq8e4nnNJtnA
         bdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868980; x=1786473780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DE9JDImRbggnFUEy/aIBwUx1YDtqkPOScxx9VXW02Uc=;
        b=XCbFomLSutMER2lwK59CeQ3oFMIy+BL92s9H+4g9nLFdgpcT0/EKtMP3km2CeCcbKW
         nd9A4iwhK+nXQVyz1F9Cmrcj2F/I+wsAOvyoMJQlCzcQIEFR5Lio79VYvxkeUO9sGrR5
         3q43yOL/cpL2CV6hQBJg8ZeT71FR2P9bRJaSkYBn4tDL1UofwBeGp/Ud9rjN2IauECBc
         ctrzHUeZCnWjLeGYak4kbAuIYXX2m07qRtkEd45VUrhjswMDvnRc4n+NBdnq+nbC7ipc
         wlD50P682EmLndQjmAQw28sXJRX3t6HKrRhzeqf2Pu5IViF91cw4fFSDyWczTyo5QxMl
         cYVg==
X-Gm-Message-State: AOJu0YyE1Px5U34ZNmSUAyRkoMrCA8EBjQ6JMz4yhPKXu06m8PxY3L6f
	aTVO1yrs10dG8zF0O2LEiFpb5iyxBPBUKrVdLXLDttgPcoqMLZHvaPH6
X-Gm-Gg: AR+sD13kGKVUv0Mnk/0EHkNFQf19AP9vfF8m5t/TbkkXMqOB8y0IxIVbWMxEv6wVeK2
	R4JQpzGJKGA14jU2IbYbOa6Xuo6ErvKszeXNmb0aNM6TVlKNsPZ/BVVbkQOLwv0URfce4Hcy76v
	oC5XIr4PMuJbw+tVYQBjdfxcxYUg/whZEQoztJ7VK2tB6M/Hs+TY6yOVgezASJcdKLbAjWsPP8H
	cEY7DB62GqyqZdndzAQ043NaA+FF6EFj6lGUPblrY3kM1wKwfJ0uSxmxNPCLnH7XBpRcFvFxk+h
	+JntixSzF4n/tEIPvraJb7m6xHD+Re40KQHSB21VVaTNEDPMyQ7uUYhmzOLvpfWrnpAoRlzK7fU
	3hFrW9pZ9iaNgueIexKT8B2aoK/DNjhqbPJgmReBpXb5Du79uj4/H3O4hRwxTCHgHOMkm0mcyIJ
	1x9l6YpCblRA0UBluE5u+8KZeZWDk8egp3eaQ+ah0mnt2pV5A46NYYGkJnsWN5vaubxnvbh8eRg
	zaWdQ4uPpwStYUUTvBqbcLaYFSAQGTF6aLMfcZQmEn8FISihxI2OsSaim2nOEOLJcHRT+OVeHFk
	94JW3q5a5TvkReJtspr2at6ZTsXMEzQkgostTO8VuWQpyzH33tsXo+cEkV7A/56EmdEY5k8OHec
	1wUdbOrKv1Wq2ybDB
X-Received: by 2002:a05:600c:1c22:b0:495:734e:4825 with SMTP id 5b1f17b1804b1-4994e7dcf28mr2288695e9.16.1785868979805;
        Tue, 04 Aug 2026 11:42:59 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:42:59 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:42:55 +0200
Subject: [PATCH GSoC v4 1/9] t5701: use test_file_size() to get the size of
 a file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-1-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The 'basics of object-info' test runs 'wc -c | xargs' twice to get the
size of two.t. The pipe to xargs is only there to strip the blanks
that some platforms pad the output of wc with.

Use the test_file_size() helper, which outputs the size directly, and
store the result in a variable. Because 'git rev-parse two:two.t' is
also run multiple times, store its output in a variable as well.

Storing them in variables outside the HERE-document has the added
benefit of preserving their exit statuses.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t5701-git-serve.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 9a575aa098..51d5dd1ae6 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -344,20 +344,23 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 test_expect_success 'basics of object-info' '
 	test_config transfer.advertiseObjectInfo true &&
 
+	two_oid=$(git rev-parse two:two.t) &&
+	two_size=$(test_file_size two.t) &&
+
 	test-tool pkt-line pack >in <<-EOF &&
 	command=object-info
 	object-format=$(test_oid algo)
 	0001
 	size
-	oid $(git rev-parse two:two.t)
-	oid $(git rev-parse two:two.t)
+	oid $two_oid
+	oid $two_oid
 	0000
 	EOF
 
 	cat >expect <<-EOF &&
 	size
-	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
-	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
+	$two_oid $two_size
+	$two_oid $two_size
 	0000
 	EOF
 

-- 
2.54.0

