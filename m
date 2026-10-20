Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792534319;
	b=Y+z9Sv6CUZvN3rmyKFoeEutO99mDlFwa4mrD/+rh4Ka+qj1YJ6BS8xQGU3UyiI3HDFNZ
	 /X3+G70Zr2Y5lihpEppbe1OiBi7XviPbVFYGx3YOETvMsDyldOS7kr39wnF2K8Xu3sDor
	 PpYMGVxj3apQbkzCHxv70EauglS0NiGgRNqzmddz4f1Q64pq+PALvobikRelxIf/bgbuk
	 NFGsq2ya3SjVu1A1ssiKMZ4Inb2i8tLDLXTfvF5sayIpop/8VQ+d7jGDj/pNntC8LH59w
	 1j9vr9CYrWFCdr9ga5P20wzKc5Xt8CkxEbTG9AHxpSEgkO8GAWYCGbfxfFAknXudhxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O8MrWTl6LJXCG+yuJ5N5OO8ll46b/kZDQLXvvYo8dMY=;
	b=WMjlBP6G9hOpPBZbKHgi7vM2g76u6PBoahJlVssf8gnWs1pDE0o8jHrhKaa7e12udbw3
	 CjrO1940NIabrTpygxX/O+eyr8KZav9yOEc92gcBGrYz9O/odtaq9rwfhBP91LXVA91iC
	 FAg5rBV0lpATc9wqDXNnKyMeaE6Q2GIWbOqe9DRoKYaVO5//0dGJ7CugMNkmuSGT4wuka
	 qBYlrmzYPubT0EeB078Z5ZGvOaa+qZmtfOGS/ShVBtGlEEwFJ+DYUdW+XoeST34VdS74+
	 DNY1vv1Pey9KRoN3/aPnt7N06NshFIYMV1uw9PiwwRmWgcwXxjHv9eXvVf1k4zOU7/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lqFmsn2S;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47D606A31E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 22:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C47D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lqFmsn2S
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so27872a12.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792534317; x=1793139117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8MrWTl6LJXCG+yuJ5N5OO8ll46b/kZDQLXvvYo8dMY=;
        b=lqFmsn2SHpYH+bF+qjqS2wKSaSq0eVlTLC4yI5QG8JPacVAViI5yCMOLaUDLubAhst
         GZHdFoPJAZ5fa8owX/5ORJclwUKz2ZEOXWbDYB0aTlaaoqp6V3naQyyZgBIMLa2hT9Z9
         q06AT5hb+l1+EfB5pN1gqxAGh7Y2INFJW8INZ2OEzMcOo7+WzLRh6kItapnzBUiEwDwv
         4VWVJDvimiqXEMwhFhwP1C+StdG9McJmzaGlPK9LImdaJYQITdZl72/g9+xjd9Tr5HjV
         bxFoJiUK+mN5r++MAH2syEbmahkMRs6UidZ4ARHGg8mZc3i+TFbOsPDcrm1q0ry8IBvL
         qQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792534317; x=1793139117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O8MrWTl6LJXCG+yuJ5N5OO8ll46b/kZDQLXvvYo8dMY=;
        b=XbGci16rwnJ85XSWe2nKEKTXZSvukDz9yoh+hlQP0KuWWWp2Mc1RqD0Alwf72P9ne3
         gKZwfnMNfAAAbjsnlzxpaj7jmqo/tdPNBA0WFVU0eVxwjRsj9O+deiyGP1gSqvo51yEg
         DKdC6NF3bJxtIvIZ+ZU5zDoAl2JQvb6Mibb4Z9N7Z3GxpZiteKunBtn/7sQCdSDqbJbx
         TqqVaZPbqmYL4wZcJVnInupJ3MLgazyF7ZYSGPkkjnLmitAcJR3i4s9+9tdWPDE1S3ux
         mRoWXGSAIV/OBnH/OcQRkSneMGfED13eLVSVTQgPDBpf7vPEdI6O0CBHTKnh5i+KVnnq
         JvCQ==
X-Gm-Message-State: AFq9FYJF8nwc6eCLKEY3mAcTEKKoBFBMM+azXmD4uN5iLooeWGNwxBEs
	gdF3hBIE5hsNhQQdyn/yW8Atp1NaQDek9HFuzRfuY+5FxkvcE5owFaM8EgIAIVDv+SA=
X-Gm-Gg: AYBFou1AP/CJuCfdTQKuyEWAvkUcRVLZZkhP2sm3c1jbvtAasZj4mO2AhWgUJPmDEwu
	W8NoPoMJePB/ywhygIZwAYYM3wuS5Lnrxyf95poV85wSqjGMiGR2EXs7hu4DMs7Ob3EI/7YVdGc
	N6dVuK6Wj92m1lbFeHcA9RXzEInLR5QDZY4zsullkCjzAiJRORNzCObHnpz02B8HUKDua29gX2Z
	wXxUJAOimGJ5nNGeKqZZ79qfJKMAe2ghcVgxRhEe05rAAx7AK39zGr/splWanQpy3kxC2isDOM9
	wx0UDZTb+4eDSRl1lqlcXOgB8b8KosLeCgAIf/GKDlMvwwzG4MTxy6SpCtSYuj8+3+uqyuAQfKR
	MT7aoFAw2IUiTZJD5n5GFE+aosgYJmaW8sPrC3yj/CFgZgrKSxilET6/XtcGoPoSmg+dHKxTrzF
	S0Nn3YlaC7g9iG8G9mnGeegdH83++fxed5iWQqR1dgaNcwg6JyGU45Pc/A8ckDRLhgfX42eHTFX
	gAdww5XtGqHV1kf3HwyxhZSboMXzvmapmhQ/6UpGG8mNxTsi9po7V7yCAnGjGURJn2gFKZA/iwO
	1L41sJTtC3i12DaulhDUgpCGXayqbw0p07F7weN4Fu5XKmo82bhyUpIQC9BJ5E9We28Wg8VezVI
	=
X-Received: by 2002:a17:907:86a5:b0:c41:285a:46a9 with SMTP id a640c23a62f3a-c4679a0e44emr35706266b.46.1792534317152;
        Tue, 20 Oct 2026 15:11:57 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678fecb4fsm16411066b.66.2026.10.20.15.11.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 15:11:55 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	okhuomonajayi54@gmail.com
Subject: Re: [Outreachy PATCH v2] credential-store: add lockTimeout config option
Date: Tue, 20 Oct 2026 23:11:37 +0100
Message-ID: <20261020221137.31715-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016212216.58000-1-okhuomonajayi54@gmail.com>
References: <20261016212216.58000-1-okhuomonajayi54@gmail.com>
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

Friendly ping on this :)

Okhuomon
