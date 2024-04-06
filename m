Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE55947E
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366543; cv=none; b=CLpjbd6R7N3g9Qpbsd5cI7uM5eLJkuKW8xhWBqPmCdNdWh8vfGtuI9zI8QvdvyRRomFKrFXOlIXfc3qDAbaEWOX3tBwCkOYUh6Ftcp0XQNSlvi1hCqFluoYU3CyGg00LOa5DRZXltWr1q7zS+LO044tyWfmzOW45YFWqkqYbqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366543; c=relaxed/simple;
	bh=vcQ6z8+A5Fqbco8sFxdrFU/OO8em9qflDOvoMhGUbVY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s3SM9pFZganwZitUhb2X/IQL5r4qCA1VELgKB06az0Sn5Ds39KQiWMp73+f9CrSEaxQia74th1vXPI996J3blT62CezNbxL1okybx0ecE/v5AgXFt3GhfFgFWz7N1nDfv2d7om1s5r0xzQ22wbvAdPdPAK8pz6Quv6nLdGK62Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNErc9u4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNErc9u4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4163a8bd184so112085e9.2
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366539; x=1712971339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj17tucsBUGbyNmeNwAY/DnKxGauoSiyw/ZPtBvyark=;
        b=MNErc9u4MXrojiw2oQukDuTnvEmttgZj+EDTaXWBSUecxzLyAu6B9YO2f6M4dGb55n
         SC+00dzS88GcIyEGqRcC3589QCC5lsi5erQZXi2NC9cQkuJZNK0GHkzLXN/1I+IrUq0n
         Ic62PqLWmbn5WX1EYvV/QztBtKJJwviFQ1KLm43Np8t21n0UACPysJIb+wT5T1O2Gjed
         a1qR6KPiMmdZB/k4rItonZgt+owJMZVhVXvTKT/va1DAajdWx6M3R/2HjUYnMJ1UbajY
         ADYTmrbc0laejiz83usbFgwohYbEzhXUoHdhWKMS+mUA1OAHVufpgcG/B1xn21e9gQth
         Ilbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366539; x=1712971339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj17tucsBUGbyNmeNwAY/DnKxGauoSiyw/ZPtBvyark=;
        b=GI2o+ahixN6HVkQPqmYm1h4z7TdHD34poagh09TXGP9WwwTwmGDsf9VWYMwjZy7/f3
         SsXzDQ3PYA1MrCG5+03ORN1Y6ZsXpX3Z8/+MkFeZ2qwR5y9cNBaKk0a7DueZGfJ6MWY/
         OAuolCwcmOatBTI8c3AZQpYOAeT5AkbNegwDmOcX2XzHZ/83doSqRpQ1gSC6VOHQ2XWR
         TNkxUBlbUP+fEnI4aYETfs0vicjYmt45755Lt326miF/JWe1Kl+3cce7vuZyjy1ZbNo2
         mtHPfiXK+ySjbOuxKBMI3XybouhOI/pLsBgVk0sJMKNUuKw6pm0ZHABXXmaD/quPXLIX
         ynfA==
X-Gm-Message-State: AOJu0YwEDZmI/aHp0Aw58j3kPIzs8T4nXu26ulTl/oFzAZf/QUKv2yqa
	QKhEQ052IoCAGMmcmdJ16hyquEZKG39AW8+EdQkFge8ulT4TusgpMrVeS9dJ
X-Google-Smtp-Source: AGHT+IFNqUSpanozjx1ykeyZHiXjhnA7SSVaIOBx9gfKPebYykJgcyBxQP+BviPh1TkWzb9umUevhw==
X-Received: by 2002:a05:600c:3583:b0:414:216:2cd1 with SMTP id p3-20020a05600c358300b0041402162cd1mr2259767wmq.5.1712366538630;
        Fri, 05 Apr 2024 18:22:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c46d200b00414659ba8c2sm4718603wmo.37.2024.04.05.18.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:18 -0700 (PDT)
Message-Id: <3817e7f3cd007fe26b8bfdec6babed1c17ec3795.1712366536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:09 +0000
Subject: [PATCH v2 1/8] MyFirstContribution: mention
 contrib/contacts/git-contacts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Although we've had this script since 4d06402b1b (contrib: add
git-contacts helper, 2013-07-21), we don't mention it in our
introductory docs. Do so now.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/MyFirstContribution.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f06563e9817..ad3989f53e5 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1116,6 +1116,11 @@ $ git send-email --to=target@example.com psuh/*.patch
 NOTE: Check `git help send-email` for some other options which you may find
 valuable, such as changing the Reply-to address or adding more CC and BCC lines.
 
+NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you should
+include in the CC list. In addition, you can do `git send-email --cc-cmd='git
+contacts' feature/*.patch` to automatically pass this list of emails to
+`send-email`.
+
 NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
-- 
gitgitgadget

