Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF23AE718
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521823; cv=none; b=DkSG35zXBE/ul1G/99DeO7tllw86zvzSeyIBPEBKIlHJzU/uKjPAxFpd7yNfy2EklQyrSo6WwwkKZN9z4sXG1cyeFWXexSs/Vj+uV1Q97Na22Mh83P3Vn8SXqj70DA2X6Fopv29JfivdMRxriONaYEXy+QNeWNg1R+RSAmkn7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521823; c=relaxed/simple;
	bh=+Muevasa9jPcYd7V1K/wLI+mK/GrFv6eGna0Joyn92g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CtEPN7Pt9KmpZJqP0mGZQtfoPSFiqI19o+dqrGk8IrH0y/ook5lsb4Tg20MqQ7tcVqhBJg7xB/OUp+zy3gkd01qywOn4O78rvLmzTduIPYm4BNhbHGlHsEo2gsPb9iKQKahSP4LO7v1qRKZztldkdVzDgh3iFksxIJ7Qav2KZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7ut2y33; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7ut2y33"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caea3f742bso8809225ad.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521821; x=1787126621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sNwElakNprIyz8vd0DZzwqm0QIUBxJKxuV/ofs2Zw+8=;
        b=s7ut2y33i131OYQkOocDGCeFzs5TSEu4eoxFWVAyF97NFPEDJ/ZYzE0GMtGkxFURLB
         dOgR22XcXLd6G0I/YARIAHaZHQWFmgF7nflKQPq77Bznmop0f1gqJJZs6JUr9Vr45e/U
         bky4DkiALbu6jCz5S9NKX4mIBnwlfhSzRV6UIFKYkmBEPPJauH1q73XyAdiVS+BiFriz
         1YyedoXBR8WaaxDumER3AEX57flIu7EslxZPhVSwMmHj7YOW1IxtNnjGNzRGsaGN8UjQ
         1rWi+pM70mPu8VT+PaPdt5uOMaY/Bc9Wj0t70MXm8scfrj2cBGHF8v8YBJPpIG3Il+I3
         tXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521821; x=1787126621;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNwElakNprIyz8vd0DZzwqm0QIUBxJKxuV/ofs2Zw+8=;
        b=LV0FakGiwGxiLR4nCrbcR7czqPN+1dhd4z6H1mTsg0GlXrWKLY6awBPhTpBtcNja3H
         /nYuMwdV9QDBhCOkKpcQ4XYqBYUL+n5aw/+XF9lcTi0CtzIvh8lHDeY+Pnqapc659thG
         A/+1/tw+jddjANr55cQvYuBkceKbf/R51s0caxLTsrxHtlFkfFaR3S1JcMecEP/Vzp5K
         Tlm/4TZ/QIQh0OJsY/U05Qlsp04tr9jnVwEVzGvf96PHWL7AgKDvPH6DsMqf2Ne6WA67
         RpgDO/Mt0FKQ7+IXuQ46lUyiY2jMMkYAkfbeBomX3ZSNkzV/fTAHJq9zy+xi9fQxLEqa
         +fAg==
X-Gm-Message-State: AOJu0YzswteRFEz/yzk8Mz9+D2LHjP+3y4aJeEupR/sebCCXPjT0jWL7
	NkwNIt3+49Cw7wC7JMhGfAqxZRxn6Wx29OxzHFvKRfMXlGT7L3e80RHsuCClSVec
X-Gm-Gg: AR+sD13BSFWkhzXmVsJz3MZ6XeMjeW7pe/qhmUaA35bPM2SPP1XUxhnvuJ6XLBUzjq1
	INTtGGg+5mb7SQk0235opZhcYq6u5Vr2gxbTZ0h/XA2cBNYPkP+1skpYSJHMeAOgdGeN0bkfoq3
	xgyHiaFyzoWPGy6Gg2MWi7dHhzdnarw5HKRPP/y6T036rRMZsNNf1WSbfX7/Q6Eci7qu0AUpH0C
	RkDMkhLjxlHYeWwdL7o8oJLayc5DpIk9Yhv5O8g21HgJIfjE4G+3M9lafyG+ZZpPNu4kEMSR/yH
	8XjupOzw43UT0Ul/PS+P6On1nQnFG1f7CR3sZ+OQNZA+KAR3VjD0fWkOO/dqbtc85p5kfnxj4Nm
	fTJYAd8+JOLEO8DGn8DFU1nmkE7uf8E3rNaEO+IGYbsWFyxHA5HPycsT8cDq+cNGvGqa9SeG3h1
	wcmi/BMywLha4Rw77M0bLleUuv2eHx+t8pyZP3Fjpp9xnaBGDDFj5dzfGp2RzktrYViHzaLydD
X-Received: by 2002:a17:903:4b46:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2d3453848d4mr46367165ad.9.1786521820867;
        Wed, 12 Aug 2026 01:03:40 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35219da19sm2929265ad.42.2026.08.12.01.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:39 -0700 (PDT)
Message-Id: <689bb48fe58186b8478c30ef906ebec4a4d2e091.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:16 +0000
Subject: [PATCH v3 08/12] transport-helper: check dup() return in get_exporter
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

get_exporter() duplicates helper->in via dup() and stores the
result in fastexport->out. If dup() fails (fd exhaustion), it
returns -1. The child_process machinery interprets out = -1 as
"create a pipe for stdout", which would silently change the
fast-export process's output wiring: instead of sending data
back through the helper's input fd, it would write to a new pipe
that nobody reads from.

Check the return value and report the error before proceeding.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 transport-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 80f90eb7ba..31883b244e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -487,6 +487,8 @@ static int get_exporter(struct transport *transport,
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out = dup(helper->in);
+	if (fastexport->out < 0)
+		return error_errno(_("could not dup helper output fd"));
 	strvec_push(&fastexport->args, "fast-export");
 	strvec_push(&fastexport->args, "--use-done-feature");
 	strvec_push(&fastexport->args, data->signed_tags ?
-- 
gitgitgadget

