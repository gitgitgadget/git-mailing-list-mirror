Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192639;
	b=Ly61KLtjMw5Lbsto24cWyDt9JNw0GuFnr1FUdAxYGFmK9TGlqO+lcPgxt7HL+EXP8k87
	 Eye3nxl1RdSuvCBhMAIiAc2Zj32ajkx015GZuN56lensPeHNHY5rhWPmqpQv8IkQALG2c
	 YTGKtyI8Jb8WU/w83UnbMdFjJAb2rQhcPrUjnAymXlgOJqc7+gX/xsJuU8m0JLQSYsTns
	 lL2OWZ/CNSEdEb9QEL62WRoflPqbUCKI496HbWQy75gzMqzVaiQqreTIYv5kS06H56p4C
	 aJ5snJV1ySSYAe5trZzJeZ/YIyqrMc40xcWSEzVT/g/7vambnDMxAzE5wyMqES0rxtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n1eXrWSa5VbM4jCE7mchHulvqdRQmboLZSoYJ/HYdaQ=;
	b=l6tfQUK9q9g2H/7pBS6ep/hhX/wh+c6TFMAI8ewdxixAnX95xGM7cZbxTbPzqZOZBmKq
	 DDvB8kj2dMmVIo6iehKzZor749iVg/ogmpLqjOTkWu1efI0HqzUKWfgJUSLeEfg+WMFxs
	 41fs2DEEAfhloGHZktkMBipxrlFqdvbhcntV88Ifn0oIvNV0/HN7fC+lmZ3hhTy2Clj7U
	 +uV/bPMuBdFMtvl4zvx3iSAmZqpeS6SVclgyEE6irt/hxi2lPNlDSafOKrn7Wj7xqnexl
	 Z2jsyl2oXQtzam3ic27mM5nUOAeUeRDZWXViXVUGbiKKOqEaqr5lrZDOd71FGB/BvwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jJwMC7hV;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49410606A333
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49410606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jJwMC7hV
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89d6bd67045so530021b3a.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795192638; x=1795797438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1eXrWSa5VbM4jCE7mchHulvqdRQmboLZSoYJ/HYdaQ=;
        b=jJwMC7hV2ZkqLPjbbZVhtW85doteej33L895OK+f73G1hPhlXouBBgK7+cuGtG0BqA
         FbH3aDeMTjbIyS07N05GbNKXWDeX+ReaxFj6cP9PIM1sDZGA7f4dJ7D9EI++8m6fxcQu
         QK93tV6N5e8Fl5R6Rt/lpy4fK7I/7a5uOlklsojUG3SjjD0LPbAd5IyWsg9n6KGI2i4V
         z9z3njqjIk9OJUq1dz1NLqc+0eZmvsLIf0gdw0iN5EwU86pWrY9mM7gCsXKbHY9tLXdD
         e37S7Hv/uB9ZT9M3S8RnquIWtcmI2y+AqT2poXukuJSGX/RyGA4Vrx8p2RiwZZx+ZAHU
         j2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795192638; x=1795797438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1eXrWSa5VbM4jCE7mchHulvqdRQmboLZSoYJ/HYdaQ=;
        b=VjTXQ5lMw4zLOfn5A3VVYLdmNgM5mBvj05TlVjIkzP7xfwERjC5wqlcDIJzCR0mARB
         USeHz+HDMxxeuOF8pJY4u/7HK8IYWTepddrWdrrPgVrhDJM4bYvcAO6L6nXLqRXizf9I
         tfa6amaoQTpliy8Z6l3aTMIyvVrpnLhOoW27pGpHWL52hMrzMAdD86WSKAKFBFRP65km
         Pm6Ldy882KyhIXLtWxz75MYq8zXj28+FNTeWl7EE7pphIGbwBv0BBB2sIQBU1mben48c
         2i1TOE4WJY0G2wF+W8JvJM0rgPlkckOdZnnuaDGpP+S0vLCCH3MQj7odF+8dGuc4BTxM
         ZrMw==
X-Forwarded-Encrypted: i=1; AL+hErE9O2hdV/PvBEJ8iGjPK4ODzU+v5jv0h1bQSEp7gy4UEqgxBeD2XF+6S3/fMr+zEm3GynM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nPJB5vG9ba0G7q7J0XhxtZrALdF8uhzy5+sL7McZJzjTo1JbN
	u3UIMGdGdzd3opU2gB0ngQk3Tt7l/tDeWql58Gm7XmUB3x3q89bxpArsGG8NcBe4Uw4=
X-Gm-Gg: AZFdTZeXcsx2DOcvT7/weuXNmQmUCZT/ObCX4gxMstbnstV8gbhTvIxwT6g+7426LvO
	1BKXIhZjqsxvOfVwHAhFK2+laBdvNHnEU0xcp6UwxN+6cFHyLTtyGbEjv0cVCUEXbJebH+HY9cP
	jZZZtiNPV+ssYtZNz/ilm7OYlkuW+9sOwBVro0zM02mGZJ83Hql2fds/BckWvWxLU7rlEdgMsYf
	AtFiTVr9GYErvASuKMOPQ8Y66tNWXogEe3AHko1PmvMQQDl8RJiUs868XKGSkzQdyp2JGddxMD3
	2chcUDfTXgPvE+6FXillGpirdfGgimk7uEQWByI1VpjsppgvtBn2ROOkJXvwhYl4Gb9ubP3rC+J
	ACRd/jupu3kkQfVyZ7F4WcMHtF9iy3x+PYvI3yLOnMq4XtB299j9xNhirKS1R2P9PwPb6kBGP00
	vFkDRtssemvoYIvyMXrzNnesZD02guLgKZB/jq/Wrk71oUjjEq9L1D+A3jrZwXvCy7fQt4cIuBY
	G6G45mjSLTvXV6MT6TvAH0Jv4Xz6jGGLtNSC+Bg80W9Rb88yfpVTx/7JNLbyeA+liE9FoNld5X2
	0iqLRGuqvkHEZQ9kaC4BI825QJZjn41siEjRc3Of8oENuzFo4kzpgpSDobZ6WlBcPJgyFaFjaQP
	0maO+djwm0xqnU5Oop0o9+yyNfSBGIWq2Mxr483LmYg==
X-Received: by 2002:a05:6a00:1492:b0:8a0:5f42:a482 with SMTP id d2e1a72fcca58-8c7de587185mr3609628b3a.43.1795192638436;
        Fri, 20 Nov 2026 08:37:18 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c15asm1759943b3a.20.2026.11.20.08.37.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 08:37:18 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: ps@pks.im
Cc: toon@iotcl.com,
	phillip.wood@dunelm.org.uk,
	nikita@nbobko.com,
	git@vger.kernel.org
Subject: Re: git-history(1) fixup broken with worktrees?
Date: Fri, 20 Nov 2026 22:07:12 +0530
Message-ID: <20261120163712.64814-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aob_LsfI9cO3PewF@pks.im>
References: <87jyqt1m6g.fsf@emacs.iotcl.com> <e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.com> <87y0evcjpp.fsf@emacs.iotcl.com> <aob_LsfI9cO3PewF@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Patrick,

> I've created an issue [1] for this scheduled for the next release cycle.
> Happy if anybody else beats us to it though.

It seems nobody has picked this up. Can I send a patch so that git history refuses to update a branch that is checked out in another worktree or is getting rebased when the update would change its tree? This should cover Nikita's report.

Thanks,
Aniket
