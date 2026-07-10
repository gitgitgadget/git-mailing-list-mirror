Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934E1E1A3D
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701686; cv=none; b=od1WRKiRB8AJg30zewC4DNKzjAj94CS9RO/1FTkLHxIEtvJtrVe6TgBTgsGbRBujnzOQhKJFqo9aGFsms6xLxNwgBqJAGRv9teKB3TpAfRLyU0WS3iH8m6CaSIgT0qdh7feuFhN8G65Sz6Q9QigMcuveoNJ/IyyoHOTLCPM3xXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701686; c=relaxed/simple;
	bh=ybf0XRPB6fGoYcQWEAjIRJsRXBy407C2wSdjBILB0Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrXm7EyFbixFAC1foY5gBQhWHx6JnmwxMSpfCBKF7EmuxL7T/1QMw5NDYanPVfNEA0oDej0KUHLx3cXypt/l3lIQallVvIlqoSz5USpx1QfRVCRl99SgYHFQfs7DHMV6no+YS3c+qtzrA+WxN3DT/mF+pJjkhorj4u8V+0rCSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/q48OSX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/q48OSX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4629051c9d1so695482f8f.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701683; x=1784306483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=W/q48OSXTHp8dbmei95a6XCHZOP9LWg22bqzfXouJBQz+zSWqesUGdHgRZIgVu2GBK
         G+wocYNOk6JBo5/fuubYawsA98HI/uKApe/GGGTiUSynLpo8vkNgFdPHoWuWdGHRqLfb
         FMDT1TM1mpzPV0SYbM20uNYvWKSFHLue8PAgwYcfINsTSuUozCYS6NJc393h2Y36Kw6q
         yraDPGSO7TI03aM5A2tf4ve8BhMGjGE2mYE3w++FAreGRtGjXpLL8CozzXWb72c8c9N0
         6sXQm64yslc9XXV6Pu/VUJzEFWR/X+jV2fCdGO7lh6TNRInT0hZznaHTcFP8RCUGYVkb
         diag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701683; x=1784306483;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=BdOGr2W1EOPwQygUSlJWw0P3j8DhpqGICH9FSxtFF0JH82xY09Ea6Wsl2cLFzvPI/7
         9fLP0h6nFL3je0rExKewUWmo0nxTP2aAICYU6cbXMuh6XaxH/yNLCRPU+rPeOpKmItKq
         ITilFFLVNvr2UoVHBSOzG0eB6dXu5UN11hlV+5qZDYnHdCI8UHi8qy/z3wxk7R8Tl9iz
         ExtNAZO4qJSx2VnI7O2YjBoIlgeaUCUwq+S5Fk2BRbtCZR6EFFRaVvRc0I606FiPIwFT
         W8JhKx0SQzFC5nK2pMq0R7k9VAYEkl6knoaJ1hGYiwkORNVeXqGigFqtZ4aC+DnZZhon
         pQNw==
X-Gm-Message-State: AOJu0YxvdZVqzsLQhhkyQUjrb+rA4FpG5zIykQH3qxN3JkL0woght1xF
	K4h00XQ0U/nyiLWS6XBq7CSpluOaXwTfOazq+J0Xb2OYAsuyPuxOMeqyWvMkz9UR
X-Gm-Gg: AfdE7cnklg+NWDiDBc96kazkNwC+/S4gXruZpWzorWqvgBGLeeSEMn/AtKTQSBT2vIQ
	9ZPVjETIsxTSi/v6S3kLuwYFYcJlg1ucGsSW9ADHI4nCNgkLYDxnf/bRyi0OWFP/onSDGmgzf3W
	p5L4ECNRsqdwbSEviolPvP0XT7q5k7XAO53zmJBnF01ngtC7O5OCtUDj6o8K9iIEg/2UiXwNqvR
	/06sfDqo4wJggJOBU3EJDeaXNpbAnUmwUTChICkP9Z35sgy17rjcs8moW3fQJDb7Fi5U3+9+2wj
	gA6u5qOdDjVyIm/1ay+s1Iyqsy9KeWHMZkJfmtpLTXuQ0Zsj8wSErpx6COT3eFu+UhL+mTU1v7O
	nc+vOSDUf9UhBwHCQd7v0tOokmGH2HITCu+l+YbH5N25HzT5eQIDIowan1QwcGP4d4EG3HKwhYF
	0FP9XAcdpiHN5od9b8W+a9m7vMHJZXBX048g/XmkmdgoYYzeCAnlkBQPlCWIlLNwxeR5U44gR22
	tjNsq/9W+F90S22ZX+gVFT3FXXxqbuPXvyBOdcV+RJOrF/ggHjB+0rjVC+YQo4m6C7Tc7Vo66rS
	QU1E/2wilMj8v0vuCqDhZmghpjdG8OaAixsijLiVgRG6pE6fAO+56i7wjMZiMVAcScN7dC9NC5m
	ePTC0o6SBJw==
X-Received: by 2002:a05:600c:a43:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-493e68d8e61mr124009015e9.33.1783701683263;
        Fri, 10 Jul 2026 09:41:23 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:22 -0700 (PDT)
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
	toon@iotcl.com
Subject: [PATCH GSoC v16 01/13] transport-helper: fix memory leak of helper on disconnect
Date: Fri, 10 Jul 2026 18:41:07 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-1-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
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
