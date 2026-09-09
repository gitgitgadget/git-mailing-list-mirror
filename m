Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F7568544
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965504; cv=none; b=dkgbVlROVJ5nz9Uil6D6mTivh8k0GKu+YCJcQ7WAfS3Y+2GrEAka1JvTLgsj5lXMLqllhc11xZnX1LAsQBfyNmVjEhM8RKNvyr7beTjGePko7eDh8u/1UxwBYUqOiLQBXyozdgV9VyFXUI2ch02S5pHAQE5xzsq6Dqj9RDNVZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965504; c=relaxed/simple;
	bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m80VXBTT7nqutubpIbV/zSH7y/OAG7ccwW4waaqjT2aajUtPLZXaYwKcDO7dg4dwOf8F02a6j/5aRqoHaa1EZ5t18UY7ciG4MjPyBnjM4pZq2iyZ5qbRvd+n3KPuCBiWWdDAoAwMZrmGjjSPRTdj3lE9G9DnVyerpXnZPf2V+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSN77GEN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSN77GEN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49954b88fffso44045925e9.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965500; x=1789570300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=mSN77GENVCdYyQt85Yd8dbuVOH5OcwRan2MuyKCoJAz+zUrcYiFwVFc/Mh2ra8erp8
         3Wq/StQ8bK05/FyEiMbW95jCqZW8NJvqgUw6rhsmkHq8bYJ36kfR5dzl0/S/gowyNfKn
         QTpmRlMstnQ03hWjOlO5gbclXdU7sBVpx2+WFfOrxUnevjyOXgXBH2D3MqmkC6OIqZ+8
         T8OL+vlidia5wuh3a3koAhCMg20S6mPVCQnZAFWaJYkAD0PAKXQgD2oHncBEW8vewMDU
         nqeAFA94400sevSc+oOTG0mEpnU3sMoGl1naciCaXOx0Da/d1BXyebZJ2X/XC5LvWeNP
         i3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965500; x=1789570300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=tZPYfWDXOF6CPw5HNaTtVu5kLY++oUtBnoMwzqh99yLNopVVxzVyAMwvQRXG1vpq1x
         +X2gcT+CKgsnfssuFMK9Fd3yoEjKs250/4+SL+JzSt3scuiMf4YSeicjJvtI+ldEQV4p
         wedlpg3BdXh6DJaOdjBZDwsS+AIRnXJr6/BbLSeRCOhQ5SYg29BevgZOKNsa/Uc4OA6s
         Y1D3CXv65Jj6eCGi3TeZCNWHHL7mYqS8z59EEfUzCrvIoapcQyrdbhmMgVlLbiDML5F6
         9t8eoJuhdlfQ4cRYJ3LUJnbtvmNDJKqvFohMuOtfrvPC/YTTrrZIz3uAVjj9S0vZb4pN
         s5kg==
X-Gm-Message-State: AFuF++mGuKvqd7TQbCvgrQuprFUWgj2yp10Jh8BjG99ZEq5NiVXLil8T
	Zr6E9CmqD/MKBepIuw4Lp6LSR6NyiVHfuFI456OelZHUX8oW7fkDsWGy
X-Gm-Gg: AYBFou0t6HVuGzB0rgn/x+NQbzbyZswjJyOouiUJFjXh9ngay/3KM3WFBjNOMuX4XWx
	0Ch3lasFODLo6DetnJRncLaIJvnYRR73omZtCyAXqvv5vaw6s/kcifHTktgnuW95omB5qMwW10X
	vCYpl0z9UFTbbAcKZ5skSzVOMJIRbhO01YcPi/chqHg5C51Yz3cyt+uR5tFB5W0gZCCGuiKtGmu
	3GRT1nUvzo48010LGsm3L/dedez8q4hVbrgVp7iSFR0GMo2QZ8mHWKzNG5q/pGYwjFytEFHgui8
	SWdN5n0xYk/YHMBt4aodn2CsbGaqTap7dsfwurw9uf7RJqrhP/Y37DTN3Akr4NeIuO+e1kb00Tg
	IEPfLvZb8EiiSTk1CCFByX/N8XEJFUTy8/YTRb+DNPzvZd5tb2V8PAhbCZxZRjmXu6S2GAP3M6c
	0zSbZ1p83CNpvoWYJSzE3jtDtQrr8gGkUJsyjYkZbFe0cfZXZRaPAR7Y2idgRX3F39uhD2L1hPf
	pSKhYSZRfW1r1Sd8jJsuWM1E96Ld1yeCsg+yQ==
X-Received: by 2002:a05:600c:4505:b0:49c:dca2:ac47 with SMTP id 5b1f17b1804b1-49cf7fe607cmr335780805e9.2.1788965500155;
        Wed, 09 Sep 2026 07:51:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:a4c9:a6b9:39b9:91bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm661451095e9.13.2026.09.09.07.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:51:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 09 Sep 2026 16:51:36 +0200
Subject: [PATCH v9 1/4] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-758-introduce-hook-v9-1-3043d417e0ee@gmail.com>
References: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
In-Reply-To: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqhcnlFt8rZ5bPT/ZnspG5XCPSa9Hq54sKLW
 jVTA5WYNwOsXYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqoXJ5AAoJED7VnySO
 Rox/HgQL/iocrWvGZpVRKGxPEYA6fwaJ9H7xoqLvL6OWk77qyy1tIdWFvFpUyTB9PLt0Ej/CalM
 9s7nvpBMS6/egPfFlTePrO4h3AwHkdI5r59SaD8ljulDpUIATBeSVzOniQDuVPwSOG3sLuMUk96
 IcncikupWSc4EIhu1GJGUKlYI8Z8HEOqzwfCurxlGYz9+L6MZoS+2DTvb9HQsCboH3PuyxyI1pq
 OEg8B2P/vx4nbr+OMm/2/SCdD4KRxIWbIgwew5qov97ndHxL7t0R3IR0PQ0LNLbzD1sDfYrdCek
 3oZVGHiM92gKxpIKIDSWy0+qyGw+1eEVTgEZUwCh+7bV2xHxiMGlKfB+XIraCctbg/2yO5tYKBC
 Y3lsNH9kdWZ+SiolDNdqxiECP6txL7puRYNCfojs0Sdtcpf0UK1k/D4ARJmXEWGFgDtE25z1WKz
 +PlnHRhXhZt1p/uMXL2ftR5ospJ6C7I/y8jasbkXTXKscaExi6NsjzDO+zveTBDf7qxJ/fTRof7
 tw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The manpage of git-receive-pack(1) documents hooks invoked when
receiving a push. The manpage does not mention the 'proc-receive' hook
though, which is also invoked as part of that process. Add a paragraph
about this hook to plug that gap.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..5806792ba7 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,14 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
 
 QUARANTINE ENVIRONMENT
 ----------------------

-- 
2.55.GIT

