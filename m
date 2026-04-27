Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C237702E
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286534; cv=none; b=iirx319AHMluo4jIMYJBc/jhma87NeRcoyMlczDQoQoRMWKsLhPfsY3RZd0deU4uG1QE2MG46WSTVCfVQzdVjNuE2Amc7zaHZs0araVqr/f+2f07vbhgONYq8tNL05FAq14e+Ez3Q5ICKJj04vkaW9HHsPDTex71BpOLu7705Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286534; c=relaxed/simple;
	bh=Bd9D1VtCumIWZbzUepcLIdYdQCzftsWLcb8YxD/j6tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llLJRbpDN5ZH17Ynybw9sgL4pfXPYaRFc6uGaAEKzucNJD+pUJPSHqjhYIgN0UThI5F3MdA1ZYutu2XLLARjx7ENM48i07VVRdNUruGDCcD+PWqdwoftuUKx3bFBo3m5bqjJa96QM22IcbR9L+629xeJQIBw0AS4pG24T5Xac+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oet2VKld; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oet2VKld"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so6535622f8f.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286531; x=1777891331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqxDK3F1izkzYs5hfLTq/4I57uRGE1Q5vx9FCq5CFMU=;
        b=oet2VKld3fxcaspZNRKN/R2UlaPyksg5gg4O0hALo1oOBafDZWpdt0xbd4/M9aYCfn
         hNErFSsS/vq4FmSxKrFGIZretecX3i1g5Pf/+P5GGcjf4iNmDrbpoeLjgtEsV2mxJwJ9
         +r3xxLfno17iTxko36Iwe/DkwwCnUggdUDQHV5U8f+MJR+2DgefvqO55f3nu/Cdz/A+r
         kG1O/On2aRXdMkpvr2915ZkqH6IEx2l7uX0mrSSr9d0EK6NA5Pto5m86XeZM8YJYSr/E
         8I2qrN8U//TmP4ncG3vitkdZSxVg8TXcvi5tzoFWyCc35tCFIPc0i8S7897eWPRBXVMu
         KmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286531; x=1777891331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqxDK3F1izkzYs5hfLTq/4I57uRGE1Q5vx9FCq5CFMU=;
        b=A6sQEVhbW9EiwNEU0T16K3PP4TEHdBYWb758Dcfo7PFzNbIU8Rr29cCWDljg+LzR5k
         gbk8210DjOXSh3FgCpIvHSB8roKimNSMhy2nuZdc6ZTVEBn/dTvGNKooD+QHdXNV0v6i
         r6Z2l8RqSKkHqaVp0xDu24t/6P6Rq/Hp3gRETalDSV6ZrC8oRICFuQzj37OB8VnJ2N6p
         9kz2k9RynJd/YMTn4TeA/2QBQkY46Vjs0zzlrhIiyX6SV11iqR1VEgxe4Hk0GHPXlIVk
         Ovw9+aFwO7ZjwLt9cJfDfVNNZZ2+huRUsnsXEWqr6T1qlEEPIk0sAW3o9H4ZA9CTaZLI
         mdhQ==
X-Gm-Message-State: AOJu0Yw+nov4lkYQhwVlEly7ekS7TMT16G818B85FMD/XiQNgj0zurIV
	G9q4VWMbVXekElJnv/t7hawnCRi0K9npA2NOE3zIkcR4RNNSstnsI29N127ADw==
X-Gm-Gg: AeBDieuE8ZLOXXQowwDifdOq0GRsoZ/9UApoLDT3TUOAcZZ7Z0g1LZHfvSzDXABxM2d
	9WpaUEWaPEyqcLk91FgUvk8zGJP6Elx1qqvONYrshPbDUJUMWcH0bIEzN3evpuN7IRkODKdKz/X
	mGQJizOscz2D22HPI66FdIJcVMajw7hRl+zs9668o9OKEUt3Le+3GsmdnyVrat6IxDO40ci1+l7
	Lu9+4VtKHpQSxj3XGeNnIUL4gElPsv5keCdZJy88412KzM5kvTtKUIrK8+kvFUUTCB/llgEtbJF
	lrO0a+2iL7+WfxRTOkRn2TnELwBV7lOy8K0r2mPNFKVQp4SuBUHlD00nKtj53VYNtgTCOG1G6Nv
	XzRTpW3xPijHWTyWGGa2GNSJb1Et1s+oIh6LFTxHEOsXD2tUqQ97BSnbrOcH0CZ/6ErKNxv+qab
	CIBerio8QQnwGEs1f/Dpk90cmxgP9JTvYLfkVsEJas
X-Received: by 2002:a5d:588f:0:b0:43d:1c7a:8b5b with SMTP id ffacd0b85a97d-43fe3e11665mr63284486f8f.40.1777286531253;
        Mon, 27 Apr 2026 03:42:11 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:02 +0200
Subject: [PATCH v3 1/9] refs: remove unused typedef
 'ref_transaction_commit_fn'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-1-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Bd9D1VtCumIWZbzUepcLIdYdQCzftsWLcb8YxD/j6tc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPX47rzEyxUFfCjjBjeKJAzkWbiCVkrL9K
 M1I8RBs3yMlaokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z1+AAoJED7VnySO
 Rox/Pe0MAIpcsP/I7F3SqH/X0/2FjblixCzH3kLh1vbQbGkrd57+Dgy+CGKQ4KvhsNdSOP0Ppqg
 Ok5jcY7Tp3pmWDKQyuGPj/m+kUBc9QLXdg3dmL8tsWbYOXmqqbUwtgpa5GmoQqVbkUoGlMJi4E5
 5odIDuT8HHq2u1vp70cp31AN7OV0WDHQDRicSx40peo7Tm7d3fpn8GvhyY7sma8RYdtuoG6dotY
 uJNCM+WWjQIzV6lRkspy21CdIvCU0R6U9o3/+n/jv80VRs+V1yR9PF+z2/zWa7EjZ/XuMPzVtIv
 NY0FgjeFo03Wfm+MwvvDa9ipi8wRPNFH56fuTBAW5f2dmmJ/skrmMka++EgoCX6DzZvyuoKkqK8
 nSTdRH3bdFXaXEacsEmhBFdGZvqy7kPJ+KsxRjbyAIQ4IjlJz1f2CxsV80vVZFxMp4XtFtQ4HAB
 aUvWZDUyIHyse3wqLmpMcMh6NoWm/PLpn/2IhpCfEAe1cQAubWqYylLeusPo7daekG5jstndVj8
 YU=
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

