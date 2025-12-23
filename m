Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF598233134
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499543; cv=none; b=mjeHiftDPNXqdfOKmtyGRxal1gdKyyZ8lYuv7Ut5Or9+//XNG/ZPQEBhqMiP+Ebyoq+Xntcxq5sYOkPJYNdGFepMvpfo6eojlTsIwxvYkli1ef4par4TRWkCF1VSARBImc7SvzNuhazuv8U9P2R9mIQ2D8xK+Un/6CfXtLwQ5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499543; c=relaxed/simple;
	bh=57TEUnAM8NIxDCzJHr89xqb4qRSO3DhGWAbY7szxiXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIyXH8JqzZBW96E7J9pAJw9jj3hhuaiV53W36nbW21hz6KavYsn3SRnTMAKck9ALjUGv64tJTgZD+Wd6Ku7I9Q+3vGDWJOKE2Ka7tARuI1XaDgpcMIbeltyW1YlMzigfZOBgYAFK33Nid9GlfmtyQfzIlbQuxum2C6UWWw4wsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxToy0jr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxToy0jr"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5943d20f352so5525853e87.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 06:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766499539; x=1767104339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/nzkD+Ss4dELpLVjKv29cGGuC0a/hA0yAJ9Gx4gCus=;
        b=QxToy0jrBQXkyzY9F6asWEbyEvAsPO1BEvKWVb+8olrmguTdDw4rTdv9YlufG8NDNY
         0yHrvje9IIaYvUoLYns/QdsVaMhGpIJSbtutQzLzsu66WH/81UdgATzGJ7QhNKHvz+VN
         BI5g62c1Uctsd+CWn4EyXcvtGqsRJx/DCi00ecMoPUu7aprR2AOyFZ9A4VVgUHCp8rv+
         eNlOtGP1ZA86y80H4aj4jTBiAzODRwpvn84yHmTZ/Wo6v7Z8sumlLijSk4FQQtmQNKSy
         JKudRCzFeJmhkxtjRKupHVLGOnTGNx5zUr/M530Cu1dXBNqwt/o5Ex/xDVPkAuC6eohP
         H9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766499539; x=1767104339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/nzkD+Ss4dELpLVjKv29cGGuC0a/hA0yAJ9Gx4gCus=;
        b=kKqNZns6w0pR6glY/w8q221xodEF43nKutaMxrJzMfMp0tSNmC/O2VTyrJzPeB0Kh8
         lbuuEZ+22p7o6STiXlgr8MzFh2s2Ay/xlxHTJS9sLRHbgYQ2zp/9FXMoXEIGAe261qTD
         a0VEvQLKrQivD/YYhgifm+IaiIHi5WqMhDqXjq9oHCxtBALgRMs1F5nDCY255xjsAJj+
         b6tqVT3JBGgfyMDYTRiN2M+u+HwdnZ9Gp1Vyi5m7/NpdnJqznWH/lJqAar6i6AOm7aKc
         PBcKixXBGsx7/hMunehmX1dcYbrAFsT3hNcFQfxkB1mARcRdAWlyzSa9MNk1ZnX3BB36
         akRQ==
X-Gm-Message-State: AOJu0YzCnTb3DoO6reoCoPkPEHJGx/2a4cFCiVnL4kJp6pf39J/vucW5
	5RKdGaqaduAXHIjb/7FbTfKpdeljWrsrJD+XZDldgP3hnIDG6JWAdYRm
X-Gm-Gg: AY/fxX7WWX4PltZxeF1vClGRox7F7fFC1kpRsA+UQHKk6oYaHm+FAc1IGZKWywckFSu
	5aR9HrTaJdYOWX/NR8QVEjFLnTox/vD/ZPT2C88x+T9qUDkvFXyNP466Ll6t7C5eKhtLun2CK14
	5/1IJ673j4lEBPL7K4qAdo5jq6tqpXNvurjBMJdGMT3dLMMOi3cQx1IVMvufEIqDx6219+gNQLx
	/3WM79AT7enYwh2q+f7cHrnS+LPU1ZcXDMHdhoPafJiT7sPxLPPzI4xEbVwwT+yDVdpkX0Vsij3
	BIOCW4NBptEDA2ijFYD203SzP7ZS2yysapA3L7ctOi18bxruMz8nhF1vrWK8Jf//qv1h1VcYws7
	H1ouXDDA7mgVDxLOlBJPOV++MUuwtrw+O/09vj26AajqbiZO/fQ/U1NSjXAodVUy/ainHHWKiOd
	j2b2BtmnMyl8u3eIlA2ltNaaoYxeY2FJqf9dwNhPo+Li6mTj5dtoN62SnOPTOvCO3upP7wwxU=
X-Google-Smtp-Source: AGHT+IEVeGKlS1A+mQDqr3jMmrK7LNTWEnX1l1AFlcU6Vzx0W0X8Q/wHXBSAmm7llJ2k3A7VYMAmVg==
X-Received: by 2002:a05:6512:401b:b0:598:fabf:afc2 with SMTP id 2adb3069b0e04-59a17d77697mr5294125e87.14.1766499538830;
        Tue, 23 Dec 2025 06:18:58 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5db1sm4184896e87.18.2025.12.23.06.18.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 06:18:58 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: chris.torek@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Tue, 23 Dec 2025 15:18:57 +0100
Message-Id: <20251223141857.70087-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAPx1GvfrQNao78WYfadttM=B8iyXKfxYaxTyX5w_MLZt2_bU4w@mail.gmail.com>
References: <CAPx1GvfrQNao78WYfadttM=B8iyXKfxYaxTyX5w_MLZt2_bU4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That still leaves `git status` with the problem you (Harald) have observed,
> so perhaps the path forward is to have `git status` check things like
> branch.<name>.pushRemote to see if they exist and differ from
> branch.<name>.remote.

I played around with pushRemote and I'm not getting it to do something
that's useful for me here. Granted I'm not an expert there so happy to take
some hints on how to use it more specifically.

I checked some of my other projects and it seems pushRemote doesn't get
set, even when working with one fork and one upstream repo:

	$ git remote -v
	HaraldNordgren	git@github.com:HaraldNordgren/brew.git (fetch)
	HaraldNordgren	git@github.com:HaraldNordgren/brew.git (push)
	origin	git@github.com:Homebrew/brew.git (fetch)
	origin	git@github.com:Homebrew/brew.git (push)

Harald
