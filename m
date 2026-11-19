Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047659;
	b=lTj1Mf6wIvojjZhPsTKdcdU+jKrGIuk6OwN2xE9kGc2yY7qbRkdJc82prQ8s+wGzonPA
	 /HY92GTtPYfYYFvnGTa3NqxsQGm8OUzSrQl8QCKqxxzZAsipLhsqmV/MGWNl/CZ+OyRhK
	 O5kmc1EJDaup/lXynxebbAN8c7lTSlk6gbrxAIIycU3TuQ3ivaVpCwCqa5QzS0dcVkQo+
	 FY1x6/lH2Oa7+gyBijhRJibf0LvAK579OcvlLuFiV4VPOh3SFLoU+ppTNY/g/xsxkfLAD
	 Zls8CNBUHDmX4SsGohxHHVOgIXus2vsVxuhPgcfe2xiQh2x6XgvHXnKUEv0L/xw8R1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GmiU7bMRRHfBFF6Kcf5wWfP7hVvBm2J5qniokMJn5rc=;
	b=tiLbeUO/gBJ9oCOReNcwKpxN8elnkeiGeJ3bFUMkj/vcdceC4eUzqPiiu2kfyoDndLgw
	 It874B0hoUb+3d9mFpB7tj5Dv0BBGfM1O67sEdOnMkWalv+oNobMdWGUy45hwzAuX2jMy
	 ePvjGdVd2owGGrBvsFyecYRjkHd+itSGxDFjBc1NsDVSC85IGMeJzoE1GZqT4udPs9SL8
	 lLDor0LQHJR3UI6hOHLzvE6pynWHiRGUwaRpAnYT/iGkXXSWdLdQfBjvJ+DSqiLw2SK1F
	 PhphBG82uSCEUB93f16ff3mzzSOGwcIX1vqkspVAoGxR0zaA+UFwz7IkzSGHfgi4KXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMkR5DVc;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66DB606A31C
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 00:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D66DB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMkR5DVc
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-86156cf8a7eso296784a34.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795047658; x=1795652458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmiU7bMRRHfBFF6Kcf5wWfP7hVvBm2J5qniokMJn5rc=;
        b=WMkR5DVcGheszuHdniW+ZVtBkfsXvIufMRY/StnFdq4B634abT8mR9y7Yojtx20yhk
         ANY5qvaGfu773edbcRvfIZjYEXYR6WdbzzFxb4Kxzg8aO9wI1detMe2ET3vj2m1lAtE6
         6XcTbDEkdv238hxVtrdQQg2q89HZWiVYaOMaHdY8MLktP3U6oLlpw8fWL2fIJ/FYkgy7
         mGFFqqmN30F4NxJXSly0XKc43O3ILXbREjWK6TkMurOgGlqtt7rRPMHczwWeA61uTPRC
         ZUN2lL9EmWa2UIdwJsbEgs/tmqTG7rRiIsoVAdn93YljUZEAsBQNl+Ye05TswPJ56vVQ
         ytjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047658; x=1795652458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmiU7bMRRHfBFF6Kcf5wWfP7hVvBm2J5qniokMJn5rc=;
        b=vbyUbeS9iI911HpEnbYtsaOJTiOAGqIy8laN+9j6yRX/JwBH0UJWyjeMYhF0uRcQgP
         UDE56OFxwinggEjymt7MGhFCQLK14KdzAndvbltgb9sB/SGWusV0NHMMcX7LhzV3hYYL
         dKp6DExURIIviVG1Rg/H5aumFM/BCuu21lXw2UadMI10vLClz3B1WzQo3XShF7pSB5N1
         D2HTjgBUpc90m3FkA7se31qwqyd/n+EYuO6SeY3bnhBRSClecuNnWbyh5mOtMIfPUY3/
         xQ6jccIM8QjaTUNTNAjQtvMDSjW7Sls6Qh8ydbvek4un9/5nMuHFDaS6HnFSBFd+5ixP
         NCcA==
X-Gm-Message-State: APuU4Z/VQ1qWWQCq/IbDMoGC7lblRS3Bl8vGlENI/j/xSNSfmI/fBa/h
	EPcIHWEn0qvrOehGSdHTf0opVQa9VJuli7vJN8DSgfNDqKGVwrhqVpdP6GIYqA==
X-Gm-Gg: AYBFou1GZHS5Z+RHBhjiwJF8IDR0il1n6DExWKEebzWWpdVifkB77JNrOIMf8amwjzE
	KuYRmARizfsGuKH0/UuNIZaveMHkwHi4rfmQtt8TSdEhvMwNZ9wHkddBIXK+p8tjz7TpySviAUi
	Loe8Mz/QQuyPHCz/JcIJK6md02z/DiEZqppZfvMi8qSkmoMGN2Vr0NnJYWzvsXrPtRzNlE53G+a
	/3tCr9PMJ6xvc01xhnpN2w2gyz9wUvStabh1W+CnlAk7p2X09IEBi0jAH6Dq13uxVF7YF9Kb98d
	x2rkMOE3XIYK3MGWdBCUAPrg4dk3HWr+YkDOaY0Wx/0m/zSj8XD0p0YifmOg3B0l5c6PwxZaQas
	qsY04uZwPwL+/gMZh8jx/eZgTczzftqU8b3uACLGX/0MpmooPjL5/KxvMIq06pM57Hhe2FJwREm
	JFtrHD6iNlxpvK9R2bzxOsPx3bboev9VM7B+/cyiaW1acW9e8i6sbAHG672R6/nTeDKZ5EAsNMi
	guGpuDGIcnwVnzsOikFIdtc7jleh9ezz3u/OjGpmFoPmmDZwHf+xIomAPU3jb+aq5z2uqyQjrLS
	AiTIgGAz5uS+7ekUxmLsSWcsBTde4oC51GTbZYJNtDniSkhz9ifwin1SgRlSU+1YoRjJ
X-Received: by 2002:a05:6830:2308:b0:847:b333:229f with SMTP id 46e09a7af769-86304101183mr178818a34.19.1795047657834;
        Wed, 18 Nov 2026 16:20:57 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d492dsm3293400a34.6.2026.11.18.16.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:20:57 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/6] odb/transaction: avoid "ODB" in error messages
Date: Wed, 18 Nov 2026 18:20:42 -0600
Message-ID: <20261119002043.2108654-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261119002043.2108654-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261119002043.2108654-1-jltobler@gmail.com>
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

When starting, committing, or finalizing an ODB transaction fails, the
`odb_transaction_begin_or_die()` and
`odb_transaction_commit_and_finalize_or_die()` helpers die with a
message referring to an "ODB transaction". The term "ODB" is unlikely to
be understood by the average user though.

Refer to an "object transaction" in these messages instead.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 odb/transaction.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/odb/transaction.h b/odb/transaction.h
index 2a40c85bc8..f6c4b523cd 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -125,7 +125,7 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
 						enum odb_transaction_flags flags)
 {
 	if (odb_transaction_begin(odb, out, flags))
-		die(_("failed to start ODB transaction"));
+		die(_("failed to start object transaction"));
 }
 
 /*
@@ -146,9 +146,9 @@ int odb_transaction_finalize(struct odb_transaction *transaction);
 static inline void odb_transaction_commit_and_finalize_or_die(struct odb_transaction *transaction)
 {
 	if (odb_transaction_commit(transaction))
-		die(_("failed to commit ODB transaction"));
+		die(_("failed to commit object transaction"));
 	if (odb_transaction_finalize(transaction))
-		die(_("failed to finalize ODB transaction"));
+		die(_("failed to finalize object transaction"));
 }
 
 /*
-- 
2.56.0.173.gf57c9a7388

