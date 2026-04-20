Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8630EF95
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679944; cv=none; b=ECHBtK79YZFYVZWF1oHCRZdiobQ4pw8RlnVt2xbYW74QDD1lV6DqnPnOC5fup27Cu6knobYWMriUhjXjLxr9ceRzfG90/v1zLu4vVGTyr85CMALb/E14/ZW/dBYj9cVkS0xxzfA9W9nyMfY4727tgAPnTO84AcaP9mOSITvu6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679944; c=relaxed/simple;
	bh=+IEaBRq5tWXZufYOqa4Hyo7UWSQnJ7hq7F5WhcSF2iU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TWRQUxNLhOvdPoxLLvWeX+GZRhCSdRJpeJlnJ1hpcBd6a+VGo/3msEb7oe/FNYuwpbAnzNO5305PCBODujArcLpXDaj4Jheh7uOAL4Hfy+cAQ5qg3+eace0TKhofaji2WDQOWE5Oaw4D/GWCvkz9K/ae4tXwV8QOlNABjRmDqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT+CzBdM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT+CzBdM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4890098abbaso17133235e9.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679940; x=1777284740; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/COCTJywQHyE4Z56MqgfnKme0OSAxkUmAw8FVTkwwBA=;
        b=hT+CzBdMpZRkQWCfVZoEFoRn99ajFZ70D/x5Gu+E3WaCGVEuTKup19O7NE5q0olhyi
         rbEyQJfA70Jg0iX4+zvABsnqaWgnWbfW4U0TcJLHQ3a/7a2rWoZkxIH7C1607jPzwSJ1
         CK6XQOylJGnfEMixtscJGcfLzx3XUEuo7G4ewIhSpXhrD6A2LYpu4e8/C/2zYMIXh50K
         827pVky5ZpsxeEneHJmBx+OV2WdtScyba4ulAkskfhIcXUrG8nqLJLifMX8Y1gwiAkH9
         j3qOdVRVCQY2y1zkiSvzCdNqSzRpbZxowib0aypatMa+w8MxvDRkwJuL2X6s4hYF+GwB
         Sskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679940; x=1777284740;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/COCTJywQHyE4Z56MqgfnKme0OSAxkUmAw8FVTkwwBA=;
        b=We5GQxVvucoUytrZEH1E1fb4RC/i5pahevDgkS8NEKnZW4E04Qqwk/1AdGpAdyQ84k
         pmM+4dlfbTpHBG/akXbCAJvdeACBw1WxG5A8pLyTzGQ7FkcbK6o88519T5dxE8a9Bap4
         GoaLRoS4YIZEJg2GQ3+WVl34geNPWSrhv2QlH96xQ7QAtUerScQWo5oQ3wyxYF/hgEXD
         Rpw0n0wwOOMNlu5ciDym1EwmUQVcibXx/zT9sicu0ddbUDxyxRYb1QpfaLWWsfAzTftb
         ILgwdJ8hsn2OiQjmoGRQ/pOl4v8ekq3xC2iqT+In95Uhg3+Yg6lrc+APGbGtzWF+1As0
         Sv2Q==
X-Gm-Message-State: AOJu0YxNdvxGdjPbQOtdKNUiFPyx2ureyTieDxZPqkXwcBeIdbItMTlB
	vO1CZZa+8RMwDT57TZZsbNuFxxiU3D+0O9jShU6du6Kn9osKrHDvf0cxD0TFQQ==
X-Gm-Gg: AeBDievF6onnv1vlIl/uDsulb5wK6dA8+FeUyfMXeu3ksUl2yKNAksPUrz9S4gnXMG2
	NE2MM5lClEuxY420jS/Mt24lCZzWaEpdJeIsInLa95c1aNIjYDAAQZvJUz412xumd4eYkiOt07x
	UREELu8A1GybxeV65kUS3liDPJOLg0eKed34tOCju4p6rjkqOMFxSk5VT3W31AX1+pjV8AdRFOo
	FGonpSASNik9nQ4c/UYmiWPOGAEnvQy+jZKawc/7JJGkGfxt2jA1/vrXsTQNd21kmSK6LvX38p+
	Ld862VkU1Dn6R67nNZxqM4/Ju2Js+dBr8nO7ckak872lt0GYVHG9KYutquXXDtPLCXKKjJzFtNO
	e1Tgit5vKeedl4P7LbHr4FOejSS9BuwTKFiXrbXPLMwIXiE2VZf6a0xKWvoFSob+9OzyNEMVwJw
	/QcMGYmMcFIW6gCh2OfRYLoK/KOrLw/w7CWWibdyI=
X-Received: by 2002:a5d:6a09:0:b0:43f:e415:cb2 with SMTP id ffacd0b85a97d-43fe4150ce3mr12733041f8f.0.1776679939546;
        Mon, 20 Apr 2026 03:12:19 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/8] refs: move some of the generic logic out of the
 backends
Date: Mon, 20 Apr 2026 12:11:58 +0200
Message-Id: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/75WkC/yXMUQ6CMBCE4auQfXYTaCg1XsX4gHXANdqaLhAN4
 e6u+vgnM99KiiJQOlQrFSyikpNFs6soXvs0guViTa52Xd02gQsG5UdewFPmEcnuke/9G4WH4J2
 PHvvQtWTA07by+uHH0791Pt8Qp69I2/YBqrVStX4AAAA=
X-Change-ID: 20260417-refs-move-to-generic-layer-f7525c5e8764
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=+IEaBRq5tWXZufYOqa4Hyo7UWSQnJ7hq7F5WhcSF2iU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl+/5YhCI37ciFJri3XPGqXZeylH6I7/gTF
 AmrJNRs9saA0IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fv+AAoJED7VnySO
 Rox/6NgL/jNE3KNdC+aaSnmisHbr28+Yg6EVpo0QzRGbItSukACLL/fyDk5j9QROA9I6V/Uxqm4
 fJ12fZONAwZZxDTAYjZH8CAUCRaH0uyPOWLbSuc0xKfiobIXVqKcqDOabb1qKEkoEBFjgFL6+aY
 wJnDTU8yZtgFsT+uZo2Q+aU7rXlsR0sW/hbTQyhSuWY1EyFq8yC+mZL8cCd7q8z44c4oXJcNuxQ
 31rbZuaaBABM0xV/69Iz2CB8fq4uO5Z+gz1Wbs45nOC7dLjIBx9LGCl8DJgGFVI2rP7wVZ6Ul4U
 AqeNoHfKshHyZxYpLFxnblOAesydP2C2N7cYxhRSs2Q6GgFPsg9dhPF7ocfF1nGLuJWMfU7vcCP
 z4wnDaBYkxA+ANaSclfUDDXMAzXFSyq5Ary4luyTib1KH6iI+c37rwB5gsuPgD4+uP32Lg3NCFr
 wryhfC3XZr/uciCpyFUA+OfeOl3Y/m4lhhoxvnk82RdCY8DP4obxaZRMxcKqLBwdrfsihMuWQX6
 ow=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series came together while I was working on other reference related
code and realized that some of the individual logic implemented with the
reference backends can be moved to the generic layer.

Moving code to the generic layer, simplifies the responsibility of
individual backends and avoids deviation in logic between the backends.

The biggest changes are related to moving out usage of `parse_object()`
and `peel_object()` from reference transactions. The former is used to
validate that the OID provided points to a commit object. The latter is
an optimization technique where the packed/reftable backend store the
peeled OID whenever available, so reading such references provides the
peeled OID without having to call the ODB.

Moving object parsing to the generic layout involves moving it out of
the prepare stage of the transaction and into `ref_transaction_update()`
where every added update is checked. As such, this also involves
modifying update-ref(1) and receive-pack(1) to follow this paradigm.

---
 builtin/receive-pack.c  |  22 +++++---
 builtin/update-ref.c    | 143 ++++++++++++++++++++++++++++++------------------
 refs.c                  |  60 +++++++++++++++-----
 refs.h                  |  16 +++---
 refs/files-backend.c    |  58 +++++++-------------
 refs/packed-backend.c   |  10 ++--
 refs/packed-backend.h   |   3 +-
 refs/refs-internal.h    |  35 ++++++++++--
 refs/reftable-backend.c |  40 +++-----------
 9 files changed, 223 insertions(+), 164 deletions(-)

Karthik Nayak (8):
      refs: remove unused typedef 'ref_transaction_commit_fn'
      refs: extract out reflog config to generic layer
      refs: return `ref_transaction_error` from `ref_transaction_update()`
      update-ref: move `print_rejected_refs()` up
      update-ref: handle rejections while adding updates
      refs: move object parsing to the generic layer
      refs: add peeled object ID to the `ref_update` struct
      refs: use peeled tag values in reference backends



base-commit: f65aba1e87db64413b6d1ed5ae5a45b5a84a0997
change-id: 20260417-refs-move-to-generic-layer-f7525c5e8764

Thanks
- Karthik

