Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D742669E
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890473; cv=none; b=ZEtiw8Vf4kPsImCpVegumydDkv0op7wPyJNjFZ9/5aw6QaDCkCpL/u3FtCimLThl6WlVas7rxMPyvhdGEkrFct1AD80JoZlntfPq5epTSZDgM1t10/g1K0SkI1Hg5FRyqRiuPua5pg69+M/NAcTVS4kUmzjD1b+gboJCBiK16lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890473; c=relaxed/simple;
	bh=ybf0XRPB6fGoYcQWEAjIRJsRXBy407C2wSdjBILB0Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwR+SUUADgQot46va78RBDngKP1q3/RlQ14MJDk8mBxiAr2FC+J1Zb8EJfUyOafzQrGKtNruCpPbXks7TTBzQ9cIZKy6PHUjCNQHCmOCqmYR0Pd5mXop8RLnqatVI60W9hwH4E82Vp10NHqH0cLvGRtxlGxw12ys+qFCLobRBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYPytdiT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYPytdiT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso1875385e9.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890468; x=1785495268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=UYPytdiTrsbcf1mwuoh+w9awF/pf8uhiM88J0Mbydhf3Tk+DTyMGTg4ysmQoumqd0F
         uedi7XaXegXc689M2Jwk4ketV7z+7YN+8F+O+fBwPl4MjIrJfHJiHlyCMe3AOEMRedf9
         htoTdAo6jYcLzn9QK4ZapZOzW3/3qddmvGmv/d4nlTBhBOS8pidUpgxkoFu0cvuvEBGk
         EoRJCadRjqC9CpOzCicThes3kdp/KyginNsZRVLkFCiw//82ihiw3Y1CVre8QBAQZ/7V
         2lbkUGlF1uP2DBZE9rBug9qaONkvKyz2NDl93zONs1h5rTByNpa6l2V/Nx40v49uyPX2
         /YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890468; x=1785495268;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=LFpVpK9OL7Euu60jlLBeAPqR0VJ8goC9654svebZ3D1cwoAuWYgxfMRQrE0pjKuiCZ
         m/G63m2T09UBq6j4A6EI+oy/1BN97dAYL8XGQIOf3C8EAVe1wJW5t04XVByJYA8/3izC
         kLBZLDL/Lbxdouh7OVdsrTa27FtdorfHHsYgUMBi/Fiz8ItvCJ2bsEaSqO8NcnfOHTXQ
         HOfhGWVaYQDjRA7+zixs5a6qhk8Aj1wqI+yjjPvi/skcMKliIBSdyTiWDi14j+GW4tJp
         Ft1Ya7iWT3s2QawjxGzqFR9USTMVCKDsTd8zroyrfc68b7gMi7vK2O7rfC260G+2glbT
         qoxQ==
X-Gm-Message-State: AOJu0Yz2v8kLPg0I0gIH952k1bj5YRmbA+RKG2xv7mpYkinIiGo4tres
	dX+UqFUS9TUdgdTmata1YgW9kHUq40JsygwovFDOoycK8/HEt64wz6e+rPfVTUY6
X-Gm-Gg: AR+sD13FMaVUNDpwI2HVtSfXvVbePEtf8y7xfAaQ5I76FCjrcY7ai39TimkxzeVV031
	TZRJFU1pEUX6+gMIfcovjEYYLbfMTVgrGmCELZUsPkO27xFvzuMW35akgmIGpodnq5/L76QaXLE
	AUxlyUDLOCp/AsBXOuIFY/mL2VetP/hz82/XuCZ992Pf9hnz1ZfBMG381eFzngesLJODKoOQbdD
	MBLJUqvQay3SaWn7RgxXP2OwBNb8VNmq19St/DzwBMF1qllYiXIdAWso+bifTfCBHdNKlmtunHu
	0et534Pm0MDP0/9cFfXBfwr6L8fEq+pWRxvBHaTbRP9Ydsu/JUIFC7HLumvzOOKqzGwWLWeoN+z
	trkZB8dB5GtdlsNgw9V52VCyAP/hGp7uJuWHLHIJTBe4KHtI4KYTtY3ydr9YpZKBTk7h9yRSUBu
	5aJbcHvTcO88abTBl8g+LNkxKFQjwiuwnSA2dm2rWfK5x0LjTV1Mqe8hjwLiJC3+AfG6okc8bt0
	fCb47GXTyfWuVql0KdUta67aUj6m1iwjNcQ575gMndIlL1PbULAKD2X35il0TV3uHMTntXLAXuc
	bfq3dT5JtSkP7SOUUQNky0XFffkQEpdbAbkS
X-Received: by 2002:a05:600c:5702:b0:495:5022:71b9 with SMTP id 5b1f17b1804b1-49573cf24f7mr56219605e9.33.1784890468038;
        Fri, 24 Jul 2026 03:54:28 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:27 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 01/13] transport-helper: fix memory leak of helper on disconnect
Date: Fri, 24 Jul 2026 12:54:12 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-1-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

disconnect_helper() only frees data inside of the if(data->helper) block
[1]. When the transport is disconnected without the helper being fully
started, data->name allocated in transport_helper_init()
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
index 80f90eb7ba..f195070788 100644
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
