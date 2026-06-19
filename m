Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48240399011
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881010; cv=none; b=KQzsZY5Uw58+DUh35XPJNQTuyTgqSZ3jFVn/ie1Gg0R0dfSBiI/6Ln4fT52I88V57d4+MrvSS1DBbOcJGEJx3X0MGm82dXt14k2o69meC+INNlpvYYVVEJRc2RgnIaBBGyUQAp85HvD4hT9IpRu2Hg28kXQI6DY/GZMIKlhjepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881010; c=relaxed/simple;
	bh=laAiaAnY52Vs7h4ueV1OVXp+nNJgOxPRHQj8MNu/S2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8rdInVHDO+9zkCBJJ8qN9SK9Y7crgkIU/I2iThMUSVtsxLuN/0WhKvvSIV6NRDvVwRz9B6nBa0QvuGKBYnA+GAU47JRZAN2LUb5YMwWREQBc06m7bBZqAVjplJgeBRSqR+blWD2FWntPXBmb4VJuIDvrVxUpFNYQ29ENB0kQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njSIT6T8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njSIT6T8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49241896317so4237885e9.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881008; x=1782485808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gseaeGUpJbXzoOmyiphBGXOvPdALN6vsU7WldfKd0iE=;
        b=njSIT6T85AKQlJ1maNUl8pXX5bNRSWn3xKxivA7ogH2dNVm3Szn4w6LK7J4fE5bQcZ
         M2BDW0//y7e7PU2iQhUp2RhbQ/ewShnNmRk/pi63hH2NLKV6ovBdJ3+0GZrRn/6Bpj2J
         8hkofipi49mMFHndhmXoq3ry3qSwU8OVc/shVeINFPZoOGucTayk+9fKJuJ9HxoYxcng
         GiqdrrDfyAK7vqbJuib/q42cVjIoXYzX/j+dK/FTR61VNf5U/DfA72SA6RXj2NHUr2nQ
         TwarRnht4XUS9uJ0ieoNaCuKo+UlI0fJb2q4H18RutPAd6gOyfzE8LXRdyCcVX4CJxNo
         //Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881008; x=1782485808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gseaeGUpJbXzoOmyiphBGXOvPdALN6vsU7WldfKd0iE=;
        b=gcNB7tOlC4hOnFPFM/Q2ES89QPw9gGVc3JETczefTkiZbZy9GgrSchU6XgT6ypBlHd
         lanvRu7zVmrb9YB+R/GEyUtNNE52vAj4rkDQuBogOpcOm1DeCEnAA38xRbnmyHbkka5r
         vcX3as6JHo3ApfqkocFTp2s4ZTPwb443kaY79T/F9c1nFPIR/bqqB1hdLRaBRfwrzo9O
         CR2ZDzYBO4t5GGCQXeN5mHofhuCnM5FHVOMGx9vl3uoEgB/Y04uc439V9Tju5mKlTOi1
         EtCEyefkiTkTh+rlE73/bvMH6RloCX06QYQgTc5Eq8ECbVNzTfOK3vMwJn6+mLj9F6eY
         jOmw==
X-Forwarded-Encrypted: i=1; AFNElJ+Y1iIXWH4e4V2bOyF3AwYZHjIFYHheTQQT9+3u1fDCfB/L8d0Pj5p7BqOr7X1zSVRU2Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxhNQ0RL3CVIauOEq6iOWJ1P1ynLf7YciHedTjljGUSPIrb3kH
	ax6qv23BtmUIjfIHGpe94T41mVLUvkHGJ2oJmxDMAzn+0eagZGi1VTHT
X-Gm-Gg: AfdE7cnvH0UYhromWEzyfBLyyvi++1gSf6BmuQmCv3HrRst6EI1YLq0TGbP0JnIlg5H
	Rxpl4hUGa3I+XhnM8b838eUZTFS+XL21QJt8U3EPydRRZOn93fumfTkbNKkmoxB0DZlkWkN3/Al
	VB/KWN0SBDAK3UM+Z18maLoMeH58ihwtnrUn3o8kARIgYleVIv1Lr1P+aDtZJPZq1sBzEzX+vkQ
	5qPo1hGDtL5fApIr77yLtk0KszDgcfOjNMB3OoKbimHHrjfkF+wQAP9+UsdTUjmjityyBkOyfnZ
	KminP6U4VYUmS4qIwYyzzoGkWAWfKpFUATN4bOheELbA3PgfVvLJF1SvnXW/ROJXHb2D6aL7HM3
	uoX50oKMozYDGHq6/isYpkkxKmUIg3jNPdMmWTq9gsEgjc/WhErbCWsa9gQi8t35sCFLTK8Fq4H
	mWGfhHtMK5l2li8WHE1O8ejLgYNNwt99sR/YFfWbAM61DXtSN/eZPnrieKY/eWZCod4tqH0I1tx
	c3CK8KptGLXOVVpXTDQIOPPEL8rTdxjME5gwAZ0U2/8aYnpypMTycRzHFzrGIrpQktyi/zOe94p
	f6Kjrru2RnWTnmfG2GTCvFY1YnN9mPURjJ6TW6fvbpMd+yjqzFdiTHI4In3Q/neb0iPgTAgrbd4
	+ldkn8+JcuDXUtA==
X-Received: by 2002:a05:600c:3548:b0:490:c6c2:bdc2 with SMTP id 5b1f17b1804b1-4923ef518bfmr88687035e9.4.1781881007488;
        Fri, 19 Jun 2026 07:56:47 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:56:47 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 01/12] transport-helper: fix memory leak of helper on disconnect
Date: Fri, 19 Jun 2026 16:56:30 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-1-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

disconnect_helper() only frees data inside of the if(data->helper)
block [1]. When the transport is disconnected without the helper
being fully started, data->name allocated in transport_helper_init()
is never freed.

Move FREE_AND_NULL(data->name) outside the conditional block so it's
always freed on disconnect.

[1]: https://lore.kernel.org/git/05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im/

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0fa0eb2d72..8a71354d50 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -266,9 +266,9 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		FREE_AND_NULL(data->name);
 		FREE_AND_NULL(data->helper);
 	}
+	FREE_AND_NULL(data->name);
 	return res;
 }
 

-- 
2.54.0
