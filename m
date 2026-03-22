Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC2317162
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774157895; cv=none; b=NB//7vgOQE0uQNQVWGy0dZNEuEpm8FRXuvvWM8VZae4JGQUgLHWgJhLrm94d56PlS+ZkoRZ2SJojL+non+mZfwMpoksROIkwAWiGPcfRoJRB2HOp08TAYolZSrZVwrznTlPheLYJIs9+XvHKEaoqlG/2C7mxHnZOLcBsXoHqjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774157895; c=relaxed/simple;
	bh=E0FbyiMEJ6SwzOvJw1agmp74zCFZXK1XkCeK7Gvup14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsh66c74Xn1MYlYKpBfkNCcNiQLeTJCVckO9KJuLm6VHf2WENOk7aT8TLqpe6r0kTVFeHk4nYCLZC0Y6XiHOkSExtb2qvqQxwH+/HF0CZrRw2waxLzkJF8MBDjj2a9nwXiQafPpOrTEnEh4qHN6LEgn6xOQBKq5j5xuon6lA4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao+GSP4J; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao+GSP4J"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b07069e2efso18262055ad.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774157894; x=1774762694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7I/c4vf1RAzVY9OV1k2sHS8N/7BE9g8bVundPXpunk=;
        b=Ao+GSP4JlbnOn/HnujEdjrjqbl+FPwjBslaE1xvswhr7dYLkNQH6bD04VF+8aQWMS+
         xj50Im7bzzCvOdrP0xmS04WKvEraOdTucoDfEZSc/EQM8gsum9gO+vidSf6hTrM8cfWc
         MSA+9ed/C34kT9/sgNH5qTkJtsrKQRxjNsK1KBVsrWZiN9jk/nhpPFYEyaSnFLpMNd0v
         /IFszTMzYyW044k9VXgS3qllxhZqY34HVRn5kzf3XQCDK9V3guUl4T1gf64Of/rMDiDb
         0G3G8u/DSXmCsUw/obCWuURIJholTigA8haCghFf56mqaQA3esjI71+4h4UcpVtoSQms
         P5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774157894; x=1774762694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7I/c4vf1RAzVY9OV1k2sHS8N/7BE9g8bVundPXpunk=;
        b=cSMCTsYqMwAfRV7LwPU+kdKvj86SgtexHdPho+Sf9M8cn3f2nd0HlaQm6HJ/LI2+N4
         PxR+otXElJVIjvwQ5w2j16hEPm7pEu/8BJerkb0PRQfzy1GWAnIunkkbBQIjnBCbrvQh
         ZqXEvtQytdI1oeCqus+SemZAIMBLDKyCO/+SkE4xhg5053IrPzI8X6/xU+r99vc1xeFx
         OV0cmYPcROtofeF8FgzeSGyrmRECOo1/wC561Ep4K0h3MNyhcC+0qXNr1fAlrmH8ZK6Z
         Ftib6jvgMuZBhhBuks0+q2e8uamfKmA54G3yYlfrHQU5QdjcuLxhiAokDyNNnmd3zIYK
         h3Dg==
X-Gm-Message-State: AOJu0YzWnZGMlysgjGH+yEHwSTrKzXA2C6Fh/OflxMewneuHgFQ8T+6q
	xBrFSS3lpXXoaYzG0J/ORmNEMQZzgBbh4svuznTvYt3QcDL6j9nrCg1Z
X-Gm-Gg: ATEYQzyzMs0JjUv7qSFCOMSUYqIxW0QpUNhD46L1yYI8EKWcp8GdZptfUb75gsTCtm/
	VQIx9hqPVvbquZm3d+8I3ADlMAZ7is1xrgJTwX2byTmrYfe3hxzVvEA5BQNnpd3gY1hey04+Hg8
	NY8hN2uL5Fhud6odrukjed+af8qWBuxfGNDCPraqM9lP96PhYCr1OEDZ9KX9225YvX6Hs3rEsKL
	FHj72AvgLvz/8SPHs0o/Z5QuLvO9VpSE5pqNmAxSQ+6kPpfW4NVIlbFSzWCrPtbx61zkWexYV/c
	OWeIznJFD55HriCktq9BKnSF6Zkf8z42iFDvHtAd0/QU+wBSlaLlVYrXUe6nwxx7a7tvxeYOU59
	ekkBKjJIsJIUW5dNba5EdB3N999DQ36ptURj+N5MYZptKn/7aPKnoS/U/difcS/lJk/6Ff27RgL
	GQs0CyOWOjD9vsPKoMssVHFxdEAjXx8zTxh+/qLNwudqvVetb/9tIFtfNbe4RAqdZupo5JMTNz7
	vxuxE62nYph/dEJSZB3sIk/dVSfUAhJaFe5b2P/Vm/d
X-Received: by 2002:a17:902:f605:b0:2b0:5084:eb1e with SMTP id d9443c01a7336-2b0827d60d6mr75113155ad.42.1774157893850;
        Sat, 21 Mar 2026 22:38:13 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516194sm67928745ad.4.2026.03.21.22.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 22:38:13 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	joliss42@gmail.com,
	joliss@gmail.com,
	peff@peff.net
Subject: [PATCH v3 2/2] refspec: fix typo in comment
Date: Sun, 22 Mar 2026 11:06:17 +0530
Message-ID: <20260322053617.38951-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322053617.38951-1-jayatheerthkulkarni2005@gmail.com>
References: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
 <20260322053617.38951-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a long-standing typo in a comment: "refpsecs" -> "refspecs".

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index a864a0bac2..a0c9edfbea 100644
--- a/refspec.c
+++ b/refspec.c
@@ -85,7 +85,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		if (!*item->src)
 			return 0; /* negative refspecs must not be empty */
 		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
-			return 0; /* negative refpsecs cannot be exact sha1 */
+			return 0; /* negative refspecs cannot be exact sha1 */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
 		else
-- 
2.53.0

