Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFF364022
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933644; cv=none; b=r9WPaNWqcVFtcqP2q9GMaTh9+w3m2r92x6tuf40lPaUyzzuvUTfkl8zOkDFyNFUkDJ/UeqMChvsJvZWPyNG8K+15SB6qRAD60+isEZskZUfQcCTZdVdoGONIUb1EJcDGXdRza4SKeyvPiTuudSgAardhSNf4TVufYsREFwsdLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933644; c=relaxed/simple;
	bh=Bd9D1VtCumIWZbzUepcLIdYdQCzftsWLcb8YxD/j6tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXns757YPRnnQmEov+MHlLk0ENLx3tg3XkoC0Dhefs6mqXeGp6E5oYDp4i/Y03DWFiQgskZQuWgLzTqvcDSGW9XWxZUvCGdMe3sECY9mfA8ygWD/kQ2eUKMQ6uM4TqNyL6umRdPKaxUbT1YMOvm3fpSJkBQYkiRWx6mJwsuzU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPlgwHpq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPlgwHpq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso58743535e9.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933641; x=1777538441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqxDK3F1izkzYs5hfLTq/4I57uRGE1Q5vx9FCq5CFMU=;
        b=rPlgwHpqo+bAX9pzmaMhiUWKnfAF0HxhjcL/AGtq8Qad7OH6i0pIfKN4E6sL1HdnVy
         PXOZbIijR5Z4+Pqv4kGY9296NudmH/LNR7ixH4FGyNqKNagNhg5yF3VocMIfZ8k0cpW+
         UL4m7+gsOPElLk9w5ge+wFGPL7fArgqBmzPZswhyYVFDmpCfIB8U93KmC/VF9e3j82jj
         U2fdMcxrGX3VlFee47akYD7Yp0AsiwNTFcqAc2P/rCAUAWTdQUYCR/wRe8khCeUtxaD+
         A6f7un30PXf6hg5Ms9PJfl/MiuqtA04+ZAqI1VXoVI2tkfBh/zv5QhMbrxQCGedK1rv/
         xuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933641; x=1777538441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqxDK3F1izkzYs5hfLTq/4I57uRGE1Q5vx9FCq5CFMU=;
        b=Q2sx4loAZMq8/twa98fZBpL7tH4pEHIJrCr6ru7VEVn2xt2CH3kUvVfqj1II4FVZe6
         USoesJjEfgg3Jy+OJ8WfguIB2Jmlfs3O1C6DVu+MGx9xw/tdMnX0AFnpCeGFqcu336kc
         ia1llkmZ446JPXj6VLpqloCqbRt93AZ36xJaSzBomIZ1df6+hLXGiHzGejo/TNsaWxJw
         mIDvPMiPw8vPX9PaCbEy8gOchyR3NaP240kmw8JJajPvaoa9WLOI0SwO52zmzncBj2A/
         TlbuzfY7dkeennxV3vZv0CbVcg5wcDO6z2r10ekNd+Vty3fveURE0IMS7U+g8nN/DJP/
         XGTg==
X-Gm-Message-State: AOJu0YxxsRatH+axTChPrJJz5TvZ9ly49ZwbL9BQrkHG6Wkj1I/IrgHn
	AJZL1rOlf1IympX9gk8BS1acn44mLQycML3p9T7wHOdlIwKacSxIL52lczte5w==
X-Gm-Gg: AeBDievYwbLYr3rEgMkY8Y6mv81jCXolgoAJcYTX5Va+TY1o9EuNo7PXsyHri3fvzGj
	d1UZwYVre2zNPZPfDcEaKIKyEBK8Pj+i/ZPO98vBjXrPsj2k7kpgTNHXTtYBR4/Jvy9zlEPihwn
	DG+RITH50VhH5gzudN80vmXD5J5pAkR8VGPnq/8hXAoLZxgE/XKVlHEgIGABsgJE8mm1pNDKydQ
	nhv35y8xmMjTu0LydxZZwRJeGCc0UPwbCky1ZBPE6NSYZqThslZSXl28BCWOqJM0EHQ73+UsISa
	93YwO90F1HMg1RFeI8b8YkkOgDgBoY1Lcgp8mIux/oPywm3LkXPRf0RfzrdMZsKKQMVo3FveoDn
	9slzer9bZyJi7Hya2+V+O8JFYH3VYErR+8sFdiQ+jjS7/5nL40xj3MjTCMBuG8K0eZEsvSoiQWC
	k5xZ2wTVQwA28wCLqRP/YrBeX/WLphrmio7ZFpjn+u
X-Received: by 2002:a05:600c:4f49:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-4891ff176bamr238667225e9.1.1776933640394;
        Thu, 23 Apr 2026 01:40:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:30 +0200
Subject: [PATCH v2 1/9] refs: remove unused typedef
 'ref_transaction_commit_fn'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-1-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Bd9D1VtCumIWZbzUepcLIdYdQCzftsWLcb8YxD/j6tc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wJZYq03frt4dilU2cGJIQllqS9UPIL6a
 HA9v9bfQbkcaIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsCAAoJED7VnySO
 Rox/zoYL/ieA4y7HJtC26sYvytQxtFzDEcpuhXr65OXtd2xCTo3A7dw8v0vUaLff7RKHmuypueE
 cfdjdvrFjS7YqRepgy3dQl9cnRO+UKw2Bck7oQxk3mR8pBFMMYQosQJx8pe2H5phcIgqpbq15BD
 zilv5F6rulS/5fXKEy4vvizz1a4mFw6mCRjwlfb15/k1h7MCGVr+NwLSMux0V9vyNxdtEgzpUHu
 62YxMU1oKWyN9Qu4IK1DQCoiKBlhAImWUAs4+ImJPMUhW/OOgNl39VR2tbTgiH5PqiREO4FE8eH
 HMXesze78yBr9CdXlnoOt8f6VyTtcQQ2j+Tvjqlh4LwS4j6ReyLO632tNiKpmF/Z1Z3/1kE77CZ
 UY6mbykC5xqgDgTnyNHhV+NNCFGWKgVFuqSwV+aW4rzFwQDvGYNRZr5ZJ9mPbvUq8V427iV27w6
 yFfmVUme7nL0AopHhPdvdUu6YFwUR97rwaigcAFPco5AEKjb8j8CDIFtwGRBoQwJN6sduTWLSy7
 N4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The typedef 'ref_transaction_commit_fn' is not used anywhere in our
code, let's remove it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/refs-internal.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d79e35fd26..2d963cc4f4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -421,10 +421,6 @@ typedef int ref_transaction_abort_fn(struct ref_store *refs,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err);
 
-typedef int ref_transaction_commit_fn(struct ref_store *refs,
-				      struct ref_transaction *transaction,
-				      struct strbuf *err);
-
 typedef int optimize_fn(struct ref_store *ref_store,
 			struct refs_optimize_opts *opts);
 

-- 
2.53.GIT

