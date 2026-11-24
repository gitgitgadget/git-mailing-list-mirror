Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556943;
	b=iXHthhWXgXRxa/RC2pB6ATvXCnjoQ35MxcHSpgAL+mRmI6yrtcctcrIVr0c/KfuL/aq8
	 zWVo0KyzY5XJwnSaou24YEx3C8lWr/dFzhB1/OzvIpPvhnhdzK7Fqe6mopMrZe6Ta13IZ
	 mFyrWWQTtfOmGoZYnCkwonodxi86U2K0WDSDYMUvXRsJYlpBCpimQm5r7cUoSQrIJQ8zP
	 7TGHmtlc+iR72euxIeD6tNE4JBHj/b77/KaWiiGYWfsk8OnrNCnSLKkH08sdsGas40Gka
	 SYQWHcX4oPaL4knns8hKgTVuNwOn/ZbjWkPQqpikNvBxDst+rOcAG0CxNs6LwFsQdZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Fcc:To:
	 Cc;
	bh=uBBjAR9PkD/I6Qu4R81vLS4+I++P8wyDmA3aK9QjQWA=;
	b=Gtnakyk4p9QaBQzjRRj/Q4fqqwbacwd/alC7osUWfQZhKysYEuz26CZMXbbH/17jM48a
	 b571lWknLCxRxiMm4S7+lkZWFyuHmIAdX2IiigVzI3DMmN3MjGnvBQMqC79Rc8FnoIeyA
	 80usfecMLmXagFkrxuo7KkmibUTsy9lcXxQt3Z9xsWdZ/f/pjpCHHopo4xMaqlhz3Ed9p
	 LIhjB5skkgkhgmC2EURX+YJ+lLk2HOZVG23my88s+wCZEncKPqYVGkshVPGe/7p5PnLt2
	 ULj6M9MC74N8+QzS6nm8uRJKBjd5BeZe2E2dJeRxxo8dCLUVm9dqrdDX890cbHKHbHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwwMeM8Y;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C2606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 21:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D97C2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwwMeM8Y
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-85ac281604dso2452804a34.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 13:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556942; x=1796161742; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uBBjAR9PkD/I6Qu4R81vLS4+I++P8wyDmA3aK9QjQWA=;
        b=FwwMeM8YuLNFQeUwS1W8JT/VANQcd9p6EsaSwZiMshUp52Co4CA5GuXfMluV10wGUR
         oxuhPVSHMhCQSYvyiTmDhOHzA9Wt+qw6sHrQxxddy4EX3gkRx9fMwyMySZR+mD7/nanX
         2MVJhvvoFPp7U2v8Tft0/9oSSFDhirft9l5i2+nLM5yEy1T/SmkNmFmmZaoE7ujskbCz
         OGZ8VA/ATQ8uWTSpIiKSEiz/cqxvo1Sn2ceVnUUua3N4Z5X9z75eI0BbEjUyH7MjLqKp
         AHrsFGD3FI91dr0Cgjt3sssWmfEJASYBRScIWchdqurpLKbyCJ2ZgrhhkQ7ripGSJf+c
         fHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556942; x=1796161742;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uBBjAR9PkD/I6Qu4R81vLS4+I++P8wyDmA3aK9QjQWA=;
        b=AbY8p6RiVIxpWqEN7L+hx19pxnmQThv20XaEyOsGJGwbUkylKStD0gQIHj2WryF6GA
         mgMMyv6OaPwN+7OKbNL727NMUeVrs8dbf708fdUSOCkPzWMcf/EMiC+SJBoUm9tmSKzR
         uF3Rb++xPPdp5/3VIxUgq2kT5NLIMRKa0sdS1kxUu0ODNjO8xrSk+zE55W3uDP9XKCHu
         VD45aqaX3r6l6wdrL78oeNvQlfvBdlAXe6EJgxRn2lLnYGGeKj/vig+RPoQ2jic3K6He
         oBTdndtzHDzNKwLsKBB6jldQTKca0Lfq449z4YzZrBzAgi32vpb1N+7firkXug4/Kpqp
         g4cg==
X-Gm-Message-State: APuU4Z80tdYfqyICZppsUYftoJV6sT2IiCFicWmkZ6+3BMRYMNws3vNE
	/99t/de5g3T7fkn1VgbkuQamL+bsMC+HxnT8IiAwPV43EEO4MLlkDWxZj7CJPw==
X-Gm-Gg: AZFdTZeSOWTazC2ZFfxyZ8lY8yATDRALVxgUrIkV6jbiYlvSFuy9qUmKhZP50pLwysd
	sY8IJ6Z9onqpYA5sDmQ1RRE0ftlhvQvoTaOZkZ4ns5WbYNgZoF8ouZzsoulWsHFi0Ml7LIpZ8VT
	5rNdWrZbH7A7OFoiCGUSruGnBNBsjl6Sgu9rrjYLrrz4HQtcgSvUkajeFcnVSgD4Xo3xRIxH7oz
	VIzfUgsOegAVAjTsAQc6d7SiiVaL5rP6ysOj5S0Sw0G6CUHKc2osxlJHIGMf3a6CzTjuAyRCUqr
	crhJvl8CSmmcNvVYNM1dc6TYzYLWSCYf+rzvKokdvi4rg81KOKa12NyMbdt48yxS30wqq2jp7zL
	Bqlipt0zzidH9uLXzj+iHwkm3yKaoGRiCVlFKIfkVHOO5+De9nmZ+aXJlTyOLgVq9qSprWq2giU
	fMgB6ESjLnEJK53PgB0msMRYCC0SB9cZVLFML5W84dZlvTh11A5XW+mJAbhu7RQh+ujeOzj7Oy0
	M8QYHPJP9V0X/18RdtmNUOTU4XRgo3wXDJrDrZbXrTGcbwJmoaAbQbR4WJHRqXeJhx/r8Jovm+S
	kXuKjJeZTAHtnL7FXE+gGn/vfLywLpzh
X-Received: by 2002:a05:6830:412a:b0:862:a48e:24e0 with SMTP id 46e09a7af769-8631598c215mr16400336a34.17.1795556941870;
        Tue, 24 Nov 2026 13:49:01 -0800 (PST)
Received: from [127.0.0.1] ([40.80.212.165])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6d8sm11445680a34.10.2026.11.24.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:49:01 -0800 (PST)
Message-Id: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 21:48:56 +0000
Subject: [PATCH 0/4] doc: convert git-svn, git-fast-{import,export} to synopsis
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This series converts some more manpages to synopsis style.

It also moves the config from git-svn page to a dedicated file also included
in git-config.

Jean-Noël Avila (4):
  doc: apply synopsis style conversion with git-svn
  doc: git-svn: add missing config options to the documentation
  doc: convert git-fast-import.adoc to synopsis style
  doc: convert git-fast-export.adoc to synopsis style

 Documentation/config.adoc            |   2 +
 Documentation/config/fastimport.adoc |   2 +-
 Documentation/config/svn.adoc        | 175 +++++
 Documentation/git-fast-export.adoc   | 193 +++---
 Documentation/git-fast-import.adoc   | 381 ++++++-----
 Documentation/git-svn.adoc           | 978 ++++++++++++---------------
 6 files changed, 917 insertions(+), 814 deletions(-)
 create mode 100644 Documentation/config/svn.adoc


base-commit: f7de81456940dd6f3274e461149bba12965de609
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2324%2Fjnavila%2Fsynopsis-style-svn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2324/jnavila/synopsis-style-svn-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2324
-- 
gitgitgadget
