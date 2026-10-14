Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4C352C34
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958175; cv=none; b=jL3psfuXYB7Jx+6tlQrsRciKpYJzzVhE1gkIdPeQnx/Y6atnF7uP0jOcVFtfQ1IhLD7iyZ9aN+jGp8dAxkGPr7rLovCTq4kihnv4Xva0S0p+lMeTPGYaYxUCm8AHsIwdCq03qJEdm8scqD0npHnyFCklsmoxFPrGHfbOpoHLOFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958175; c=relaxed/simple;
	bh=ChtOMmQbPG3yLrMwa5AYiB0/WcIObhe/IAw9qT60PVE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ek3RUtwhDxOYQmlj8zb1E9GxROzjEsvlNFnns1p0lqlewsRUcDa/lFIsA7qPMDrZXN2UKFmEyro+YEzAoNZoJo4WN6wWTskIc42w5dIFs+vkNXXmuiwDZseirkVv4vzG4EnX2M570G7y+Ym9mFc+CYYKQ96fulfqUsKWNg8oirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggDOx5WE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggDOx5WE"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b813ac020so41425076d6.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791958173; x=1792562973; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PJcTXIs9jpH6Hx3PBoC3bJmAq5OM/TGSjulDwj4/AM4=;
        b=ggDOx5WEHaKNaYyN224bXWml51PALinBGeLpEy4WHqmYceqnwnx1Y/MWCjfpydUhlJ
         sghvuCsf7+fDS2cs4XUHTfRBhHYqLSac3QogWcStGGDN2extR35no1e2Rgu/1ARzY7YG
         pxBOPHjAwGewjgVBPtiSlLzQdMS9Xv6xO+I4oZxB/KgOK0RIRH3NCWpjNDYHBsn2Kdop
         kN8CIVOhkM7toZFynzdBoH+LBh4E8YxzoyvF7R01bmJJnwADbFdP1CxTbIFN/vWBeXo0
         uDK8HzDFbzAJX8ogk+G87GHBHvKX0q3zfd5Xzahkz5aw5glFaCEbYrl3YUZ7SCin7Erh
         HRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958173; x=1792562973;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJcTXIs9jpH6Hx3PBoC3bJmAq5OM/TGSjulDwj4/AM4=;
        b=Mqhi+ROWpRE5qak8xPh7Vf9UvlM+vDjaLVQ8wM0aRps2NsOopBQR5fLAQVbo9F56rp
         F1vzXfquUpVsvEpFIkD3rCpage0bL9f2IvhorhzKlETtC/qUlP4oficR7+aqqAPsbHqI
         OupAMWqzX1odmxif5/veORopuTi39wh+Cf8C98cXNJS9GSXa0wc1MMgktbcp8RD/wJhO
         BYY65Dr297XnUiCUNRNJ7FiY+rSAjXFAYMsmrDpXsjQ0g1qO39poJu/T3Z3eybQ5hx8/
         NgxDHPSVKyVvRsec5VKIG9687LNC798+NDLDH3qNn9KYEzwmnPl9bjlUp1jI8sFrgpMd
         twqA==
X-Gm-Message-State: AFq9FYJskG2G8N5m+2EQV+lyq+c8IKGHwPpeH7c5kg9LOtH/8hPlxhJe
	86GQyCsJAX4TrcH7s5k3QBbehfmcmz2rCQxMPOPDIQPT/Jweo5TKN6xhhupvNQ==
X-Gm-Gg: AYBFou3GBbwTzXQOq+oo3nrmzuMdyrI367tGvBvLtktFyyUQw1Ka23/O0AbfHHKRKQq
	3G+pO/rrpnJk5m2eaV7OZfDWAOvP8lyGr3nHfPtO4v45C8D8ZnCPrIwsCKFxIIRqx4z3cdf9uwn
	Gsvoin6ZTK3zuVBqdynf6VaZV/Db8ky/s9njExrSvciVTSOpNY2yIDSPuiS29yFIqgXJ6l40zBZ
	lLZ1ufXRRdK9Wb1BdgfOy7yqedTN7GGeOCCtlSz4IYLekARGCkMQlQnFnq7uLjZIbASvHmClUb7
	JB5ua6kRV1WGxxrhz7wJA/s8tKAuOi3tjw+B2X5AEZOzEqLjwHDkqiU67yv9ikojU/4RpGAFb5t
	VUhAmbb305A6mpin9xACqiqwz4gqSTAxKTQAlLrOSG5/msL0AeHw+8vYAweErqmVfBmob7VprOy
	i1H4L4aKgnIDo9+z2ub3TAzqBCpQJe9Muz6vaHsZukvsyE7uYgmMp5dJeYk6+b0JbkRzbXRe9YG
	CZLU0uw6cFB
X-Received: by 2002:ad4:5d61:0:b0:91b:b26a:9783 with SMTP id 6a1803df08f44-91bb26aa385mr2882686d6.55.1791958173161;
        Tue, 13 Oct 2026 23:09:33 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.149.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97c39482sm44399616d6.45.2026.10.13.23.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:09:32 -0700 (PDT)
Message-Id: <dcd319476add64e892e517faa71966f09010029a.1791958171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 06:09:27 +0000
Subject: [PATCH 1/5] archive-tar: guard get_path_prefix against zero-length
 input
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

The `get_path_prefix()` function uses a `do ... while()` loop that
unconditionally decrements the `size_t` index variable before checking
the loop condition. When that variable is 0 on entry, the decrement
wraps to `SIZE_MAX`, and `path[SIZE_MAX]` is an out-of-bounds read.

The current caller (`write_tar_entry()`) only invokes this function when
`pathlen > sizeof(header.name)` i.e. when `pathlen` is at least 100.
Therefore, the bug is unreachable in practice.

However, the function's interface accepts arbitrary pathlen and maxlen
values, and a future caller or a maxlen of 0 could trigger the wrap, so
let's add a check for that.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 archive-tar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..2da6e55484 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -210,6 +210,8 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 		i--;
 	if (i > maxlen)
 		i = maxlen;
+	if (!i)
+		return 0;
 	do {
 		i--;
 	} while (i > 0 && path[i] != '/');
-- 
gitgitgadget

