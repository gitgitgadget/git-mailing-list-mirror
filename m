Received: from mail.hq6.me (hq6.me [104.236.142.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE36198A06
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.236.142.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462829; cv=none; b=VnlBC27K0qHV208GCDO1b0LJ3CozLtli0TucaGDUMb73X53G+NSL2SZNYS+zDRCBG5tdqWBxWX3UPC+sCJg162aJTunZwjUpXAEPN4Q22BCCGFTsUIkBuZwEetXe1TNppt2xGb26erGgCAOcrsmGrF/A8HBi8jQ2bfEeRVe8J6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462829; c=relaxed/simple;
	bh=owaFsuHmcyZG8MnhqiZK148h95UBJxQ4uiTy2cNnqYI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=e9TYQ5SDfSPujw0iIidMtR5B0XbfJzKdt9eD/pKz21B8l5cUz3ClhAf1WgOpc23MVnedRK/xDNOSNLl/Kq7ShkcnjUM40hHoj99v8A8XsREsvqNB69TJvq19tJzCRDOkTN04s6Xdix5GgRHK68uPZzfDEXl96zrftP6F1N2gZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me; spf=pass smtp.mailfrom=hq6.me; dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b=pLBoUSYv; arc=none smtp.client-ip=104.236.142.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hq6.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b="pLBoUSYv"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hq6.me (Postfix) with ESMTPSA id E0352120364
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 21:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hq6.me; s=mail;
	t=1733462519; bh=owaFsuHmcyZG8MnhqiZK148h95UBJxQ4uiTy2cNnqYI=;
	h=From:Date:Subject:To:From;
	b=pLBoUSYvD06+fmBGOR1mWOKIy1JKoEwLbNYsfFwb5Gfz/jCVCDjFq05HeAutfVpZl
	 wI1+nxJuDiC6jzATtXo3BsrGjFk/ICoNkY6jK9LTexqWbXeKWJR2KYQJo/YT5hu5ud
	 4u6LAUL/9zfL0dm/w4xzP+zTKcKe6OoUXG5zlUaIQJK9baNKG3PXiqipoiY+Ar5TuV
	 6EdC1/m/IJypcWyHv4Jc/4H6U4Ir33emsNj3aZ+suo9SXmk+A96Cx43Psv4lsgg9Aa
	 GEkdGhNjkXWv8FIg7cTG5YRcToT/oLDWszZfAEw5UhPwBZ/mnwjZNEbtOGLS134uu2
	 EDfc9F5rNiOSg==
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee8ecb721dso226208a91.3
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 21:21:59 -0800 (PST)
X-Gm-Message-State: AOJu0YwuHONwiIYnyMS+1BMVKebG9r4GIm3hSvSZYWhvUgetg3q1aVVH
	of+SqWK+c6Siu/SCVymOJBWkr8um1qMJolH4besYjCD7JABwjZ9KzI0vIBhAdHWcwRb8mU+00lf
	EnbZ7Dl056MzgBJHQhnsBmDfTq+E=
X-Google-Smtp-Source: AGHT+IH7oOjld9R0msjQNPk1/TH1YodBx5NDVz0Pa8khbwr60s2YDuZwf8MXlppmmsSZDXywGlrb9rx/4hS+YYLlcaA=
X-Received: by 2002:a17:90b:1e50:b0:2ef:93:154e with SMTP id
 98e67ed59e1d1-2ef6aaea0b6mr1073260a91.5.1733462519509; Thu, 05 Dec 2024
 21:21:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Henry Qin <root@hq6.me>
Date: Thu, 5 Dec 2024 21:21:34 -0800
X-Gmail-Original-Message-ID: <CAO8bsPB8JDzKp3xRVd5sAyUSzDrbrGGU5b4o1igkDZ+pDUO_YQ@mail.gmail.com>
Message-ID: <CAO8bsPB8JDzKp3xRVd5sAyUSzDrbrGGU5b4o1igkDZ+pDUO_YQ@mail.gmail.com>
Subject: Feature Request: Support git bundle create with thick packs to allow
 application to shallow clones
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

The current git bundle create command hardcodes passing --thin to
git-pack-objects, which can result in bundle files that cannot be
applied to shallow clones.

I've detailed a possible workaround for creating thick packs in my
Stackoverflow post.

https://stackoverflow.com/questions/79256488/is-it-possible-to-create-a-git-bundle-of-a-revision-range-with-minimal-prerequis

Is there appetite from the maintainers for natively supporting the
ability to create bundles whose only prerequisites are the excluded
commits in each revision range?

I think such bundles are useful for applying to shallow clones, which
are commonly used with large monorepos.

Thanks,
~Henry
