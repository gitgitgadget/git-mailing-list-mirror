Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82D33F589
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729001; cv=none; b=NRyrIdCOiv4oNKQ+1y0qsOW1CeftoVNKVBDxg0Fh1n2jzBtyLmvcAwFfzzpd1TZOF8aoxIOZsgCYs7FGfWShcVjaASQOynuaoC9Sg6yl5nLppfhugj5b3FniNg4lAs1QjSDAP5W0zdw9qUuPPDnBlvA1nkagWMNc0c69H3EIxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729001; c=relaxed/simple;
	bh=or4Dxa6YeRgWHGWUIaUkuSt+LKAmsNb/CY6ujDhYSHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwq5bXeC0T+k3SpVx89hk84Ukf5oHA/1RDlfUjypyoNdMmJfwz/WPGC1MG+QT3IqQTzLh2Q4HMZDkKz6+f+5uKN53Z9o25viA4CP7JS/jNntBIQ1cgXaR/hktNQ9lhThNbuxZ/rZn/irzbtqP7Aggtx1qIGtfZuCxN1nwTcpcOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hynsHJuP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hynsHJuP"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso1118805a12.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787728998; x=1788333798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6fOHGW3d2UTxxUi6jZWxTZLFKJuBq/juXEtPmatZsQ=;
        b=hynsHJuPb65i+vbrnLPQr92s3PIbnIMfG8UgFir7RZnwW4U3jZE49w0DH/aSOMTzBD
         ELj1PBzctlkPu2RLcDxYO3b3ubBYdzT+A9oyvwZfNua8O1vemn/hhte1id4Uu9J8qxw0
         61ZIuRRjOzmCtqLlbQV/rlQ9wY4c09JvzZfqS2/Iyu/m8HRnpaHcV9QR+04bS4+cXOkE
         L7IzokhZJFix5XSqy4AdUVoYR04L6FONCR1y9k1XJlk0X58/w4/TbAec/LeM36fSI8Xy
         urKpVurNULNnd1nPyS134bEJvXFmL+WWNr5wMXWbD/AG224dG08SHL1zGVXhkRNHzfR9
         HRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787728998; x=1788333798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6fOHGW3d2UTxxUi6jZWxTZLFKJuBq/juXEtPmatZsQ=;
        b=KqB+62NMu9uLGnjat3lk8oRCFfzvaA9i036tb7+8eXwQTPFImtyuVptgOMbouudo5G
         MB7dscR1SovmJofuwfwTKKI2z2VkT/walIcbJh/4MPmTWNlZfTEJmQtGGzbORD12QqgT
         QZIYeAxuyVsLeZ/fMa+C+2MpT3Dci5lK33D3LZaMnr2QP5OanzThHNrfN+poV8ef/u/h
         A3gUYlrNYgKswq/k4TZFBsld/PaXct0MGaWqF7+hwpUtQkRkyP3dNl4I4L5XiNp72o8F
         Tm0Na28G1b/cCaLiwPdvhUFrR7/husEt43KsTwdjKWCDB6oGNb3gdB6X+yd3P1HJYVsK
         KHpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSHCAo9WeyqaCi9iBIgj5mlDv3LcFqLcyON9bTAx0UfH4bik14FKaLZNSM0q9j+gO7FpE=@vger.kernel.org
X-Gm-Message-State: AFuF++l69fmDpCG1cq6tMwEtEeInNJpVzJK+OgLOeKX7kJYH0gBRH84y
	dhlCEMegX/2cUi6UYgFJl8NoDmGnVlkETGM0HmlMikoTLzHXn2w5IDDt
X-Gm-Gg: AR+sD13qUtX05e5WooN+C0h8weqcYHwN63zwMY3P/Oqh1v43641JL1vBC5D2DQLbBoA
	6rb9Mwb46BFRxz+L+uCoB+PT2pPaNFiQnBsZF7nFFtUZCr8YUZ+OxoQc+NuZFvsgaX/VvNy+owp
	hxN6ykChPD5JK4rRGZFqxZXx0+pWqofUSjrFzQiJ7qesJLwq5ZnPFdG1NR7nOXdsEPqoLGiNC2c
	zssa6RmpkCEbfL93spBpXHs2DJqVquR2ign4VTbv6QftkGAQs8MflXpWOgN7Xcc+1yLT8wCI9vM
	r+3WyiqtCqQPUdfQx88R4ykiQMxqpK+AE4Jso+oUZ3PwfhbSGXYLn8kn6avL4yQ80rJ8VbXuQ+F
	fnLcW7KcM0LzV/FtlRgCryU/U2fFmjhi17uIEME/TvlApJ0P7lJfcRyTXIhCpG1r2LA9nzCURlO
	Gq1Cv4ommOcA8ILQidDk1HFPeC5/3XpBDM3FZ294HO3a7oWeBTT8p3JVIgJ0u2/kWkwZpKpYSh+
	+5c5InSPM+6covj
X-Received: by 2002:a17:907:728b:b0:c1f:c061:569a with SMTP id a640c23a62f3a-c250bbe0e01mr520626366b.7.1787728997565;
        Wed, 26 Aug 2026 00:23:17 -0700 (PDT)
Received: from localhost (92-249-246-87.pool.digikabel.hu. [92.249.246.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25258a0438sm110765366b.22.2026.08.26.00.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:23:17 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:23:06 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com, lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v5 0/7] add more path keys to git repo info
Message-ID: <ao6UWnHfOK9VkD4n@szeder.dev>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>

Junio,

On Tue, Aug 25, 2026 at 11:28:11PM +0530, K Jayatheerth wrote:
>     +@@ builtin/repo.c: static int get_object_format(struct repository *repo, struct strbuf *buf)
>     + 	return 0;
>     + }
>     + 
>     ++static int get_path_cdup(struct repository *repo, struct strbuf *buf)
>     ++{
>     ++	const char *pfx = repo->prefix;

This patch series depends on "repo->prefix", but it's queued on top of
41365c2a9b (The 4th batch for Git 2.56, 2026-07-16), where this field
doesn't exist yet, resulting in not buildable commits.

The series introducing "repo->prefix" was merged in 2688b28699 (Merge
branch 'ps/setup-split-discovery-and-setup', 2026-07-19).

