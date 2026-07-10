Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0D41CB39
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683592; cv=none; b=eyx7TH/rG2EVaEZ3IWOSoyMjiEAE1K+ms8VAEoNU5OS0nub1rLsqFyTYtB1vgLalMuwfso5GDyyy5qzx5/XcoP7E/ajlXuxGfZF1H8lCBN+Hkm7BGig567En50yXPi48xOLavAyPgABI8CW5g4IIIA5loIVYPKSCn+3Olmjw24w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683592; c=relaxed/simple;
	bh=Aq51t/jqaZ5dHU4B9HJ1ZUyktO+EY0XKTZmhDoAK2jg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TF/6/2nirxEJPPPd8Vxd8hFewai4K7yPxXbbYbqQN0IBXZjR0tVqHuQS2voJpIjnB3R9nBXYfXQkbqvirBUlzrcF7p3KgIhLz08L3F4Yk4s4d1QakCIEACrju/4UCFuCcAcajDoqNWVDAQalr9L9V6Yyn/Agq2ZAb9HKkPPLXw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtC0RL62; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtC0RL62"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so541790a91.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683584; x=1784288384; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1MgBrNRhw2fDfdabPrC34J1vV/v9aId7PAgURviIf6k=;
        b=BtC0RL62RptjZAsvvVtO/ueDGnj5vv+xNI5xuo+3lOek42vQ3jWlumQ/gEUx5HlTXk
         BIRH0+nau7JHhusaOQ9wBUPw6wORitErWtU6DUZvqWfgpOBWNRlLi4BH/cumkpMwlWvL
         HO57h9hclHSisZw2khDOXCso76LGSQGixKGN+mpfeTHln83aGlJFm2zflnZ/5vMqhIiA
         33ua8mtQ9hhNkUVswJRevGVGxo5KA/PMHXvBaJWMkka5NzGi2ouD53gCOghYNEZCVkkf
         uVifKw09uupVu/Cwz6c24eXf4n4DjVu4AAndf2OdZvmNjTOViMxAz5us7BT7Ol91TOCt
         NU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683584; x=1784288384;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MgBrNRhw2fDfdabPrC34J1vV/v9aId7PAgURviIf6k=;
        b=gyA0j9pGhAOQNYo/T2IG4ChTV+exotrZoyu+q8+b4oqGTKjQKGnDpPbm/1MLiZV71Z
         YH5XKYgBGryeQaUFnLTnO/o23/9U+Sxg2a3Kbxy1AkVv+fGISggUsriYKHbrZxet1SND
         e9j9wzvHCpp3uumiFfXNsWFGMeHoXGNuCqdgz6N6wmNPq7fYXxi4V7FnXPrTot+cMjs6
         1E6xhUNBJfDOCz1ocIaFZNuBfyNwA8QuEToAocETj5oKAegJbD4UBzMcyfT1ePvlafWA
         fINaffuUOsY/W+wQoI2nP402wZjTwSzuTmlBseSj9YEVNJ47FeYmQvUGz4ooVNAGikKr
         FRPg==
X-Gm-Message-State: AOJu0YxqoLGUsYISM1vt4iY4bFAqNCZpVG6RtejabxEi5ciSJo19vQGY
	GEU3BRda10qh1GPjyabO3X2cUaAjt+mfA+ffAVW5Hiw54MdLaq+id+IqjtSTfBl0
X-Gm-Gg: AfdE7ck6Rp8aoMjYeMAQfbp0G0tis3654vUom6g8AegJflFyE9GBV91NrCO3ZkhqVND
	fAlqkBOh7EVyJR9cd3BpsCSHUyXOelcP9ln6vtyXPSs1eZL39ZQPvJkHqMmKduOWDHwc8oVmty4
	x26qtA++iP/bbFtWDPD8Y2hIefJYPzI0rnpa/E41AcPcPWOMAXHTqXrfN6RrpmpmeRwu0dtpSmy
	op6o1Uv05xcRJOOsojQlTlHUFRIveFASHc316bvYovYcP5nwJpAtGZzvNtSdEzR69BM4rl9bip1
	WofmE4Js3cQgzYLl5d5V0A7sr1xKsGvRUMl0cT8ZbA7zLVQaX2XYCrrUmYMYEuhM38mXTsweU5v
	qPM7D0zmfgJxkuF6wnqrXMLaG7E4W7CZ7HefStxSA3z16Sn+xDVGTfkunqmfkg3HXzTbd/m6ntG
	grZYo6Krl8xRuQSb+w
X-Received: by 2002:a17:90b:4a0a:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3893fe5b59emr10013416a91.1.1783683584358;
        Fri, 10 Jul 2026 04:39:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e26esm59283535ad.44.2026.07.10.04.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:43 -0700 (PDT)
Message-Id: <1398a2f1200da5cbc716b1a926aa614ef6c13503.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:27 +0000
Subject: [PATCH v2 03/12] remote: guard `remote_tracking()` against NULL
 remote
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `remote_tracking()` function unconditionally dereferences
`remote->fetch` without checking whether remote is NULL.

In practice, this never happens because the only caller (`apply_cas()`)
guards the calls to this function by checking the `use_tracking` and
`use_tracking_for_rest` attributes.

However, it requires quite involved reasoning to reach that conclusion,
and is therefore fragile. Just return -1 ("no tracking ref") when there
is no remote to work with.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/remote.c b/remote.c
index 00723b385e..887e388f9c 100644
--- a/remote.c
+++ b/remote.c
@@ -2681,6 +2681,8 @@ static int remote_tracking(struct remote *remote, const char *refname,
 {
 	char *dst;
 
+	if (!remote)
+		BUG("remote_tracking() called with NULL remote");
 	dst = apply_refspecs(&remote->fetch, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
-- 
gitgitgadget

