Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB361B4138
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763961811; cv=none; b=KDewAUqTU8VIesbQZ6H5WFHgIg6l3nl4z+FVOGZImssRDFcKFp4jXjgjezfhWVE3HBYDSrl+mbuKKvakFGXDtnK0RGzWwMtPNHzNTlL37yYMATMk5j+YqbLpP88EGqdAncXfkY4u+/+OnP/tkoYGTnQq+MmmoHr8n1mRbNwEAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763961811; c=relaxed/simple;
	bh=qYKl3LZvFIkmmM/Obhoo4GxH2wP5kAuWhSOpNd1kGRA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XKu4OTXZiCNWx4O+yx0F0dArgYsk12oVFGb6XR99gTFk1s/VCnTo1//M0qiXIK1p4yQ1C/mh4NdV6ZXM4PvKIysz6fANwl1+9bh1/K7/Ma4RQ1fgT308R2xzwz0dqHDyLIy21YnPjkkSmvmV5svQSK54c6uokP3mSXhum8An96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=HQnBEO/9; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="HQnBEO/9"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3e7e57450ceso986878fac.2
        for <git@vger.kernel.org>; Sun, 23 Nov 2025 21:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1763961807; x=1764566607; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dSCD3DHHspvIeE7vEGWy9qc5t3Z0w80XeaohecTP51Q=;
        b=HQnBEO/92Sc2H20Q6Az8+5JojDD0l7jbClPobJAZl1G4kYXIe7BnRY49KofQoQrNJu
         +33jGGrahrbRfgSACxHs2VwJnpQ3Lc0bt91w7ZKgTcYLzOKUPyKFwKwd66iuvcOR2X5p
         q0ihQjnKx6Ss+Thk1yXXPTYoQSNZGAeRcG+snMMOHotJf8XA6DhhEOJre8tpJjxh14GN
         aLe8yk/IKTlwR0LYZEJgaLJUSFL5h7Mdl36HJprFjRi5k5yPyIceI9t8xgf/j1PwXgUG
         YKCmhUP7iGMu+rS0xqtXhGBHe+qYwJVzke85h7YjKHTHDq1j5gBWZibDdRX4eS02A4SX
         kiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763961807; x=1764566607;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSCD3DHHspvIeE7vEGWy9qc5t3Z0w80XeaohecTP51Q=;
        b=Ni2qmCs7STV0RFOK0c5fDULdRV4C95+UBSAKzzOAR3pP3Vz9VSECEmmvDi3AcQi5NU
         z9Li/qrLpD+twH/rMgSbhKeuNlgTQEMllP7Z+HiDmTdIMCYfZmksFGsAmxNJ1DUxTzJA
         oGh7vxBDLKx48FqjiWx++He6wuhNEtMR5oPP2JtY5E2gc8QC0RgdjhA/583Ri8vxQiEU
         22KFKE7Sshb53TixMXeoiaMxDCoT9RUUiGoDf6GEh46SI/ERafsoi0fgVYFCU5QR8Ag8
         7uTBL7SwiCiQewAeORLf2r8osh3v551gxob3oFJ9+wKVoAkIqB+JlNtX8KywSYPbRP5W
         0PIA==
X-Gm-Message-State: AOJu0YxPlZJjau2HV1JBAfJy3ORMa0331UN2BnFwx2LWk3TgpNGpbpxc
	a10PGVlC/0I90mCuZlHoJyj1DuZ6duJyggTyiXxFyG1ycxZXSIW4xoa0n3wC0W5rBeedixZWONk
	csoENypdzjKQvJhWrgbEmXfQFEC63jQKLwmgbCKk3eD0QQ6wzf5M67/0=
X-Gm-Gg: ASbGncsIlbkU2GrUuAeqEEM4R75DYsCfV3CNbd25sN21JtN4EpYVng1YITK85rRysMD
	hNlaX0oDQFpMszOJVzH/CO6YL2JDTe1vpVWQoQr45bDcA2LWwkbag7tcpgyVM8dmRR4gXq/6laP
	xLikxQjHwJ8iSb9LCXjufP5i5liykH347ZA6eLWs8mqkM3rdMUizEwzfZvhnQL9OkhYH6ZK8g0g
	Hti1G7QOmfPD30+RSMOWHBrpSj84PFpRXPZQ+jDceum68CBaPWHp9fUA+A670vht4EbvFVs
X-Google-Smtp-Source: AGHT+IGns2eNdCrf9sBTMOD5JJ3mAhKOgLgdymva2GdTd+tbo0ahS8OiBBjP3hPjslInacBgBfO+minPtbP6vgyNCA4=
X-Received: by 2002:a05:6820:80b:b0:657:71fa:5f6d with SMTP id
 006d021491bc7-65790bd69e2mr4197374eaf.6.1763961807437; Sun, 23 Nov 2025
 21:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ran Ari-Gur <ran.arigur+git@samsara.com>
Date: Sun, 23 Nov 2025 21:23:16 -0800
X-Gm-Features: AWmQ_bmPy0y44-zqcSJJE-RlF6Jc_0uYZKlHUe6QeBKojam-0Ve1iQElSkOoXlA
Message-ID: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
Subject: [BUG] `git clone '-c KEY=VALUE'` no longer works
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

There's a small regression in Git v2.52.0; it used to be that a command of the
form

    git clone '-c KEY=VALUE' ...

or

    git clone '--config= KEY=VALUE' ...

would trim whitespace around KEY, making the command equivalent to this:

    git clone --config=KEY=VALUE ...

The relevant code was here:
https://github.com/git/git/blob/v2.51.2/config.c#L649

That functionality was removed in this refactoring commit:
https://github.com/git/git/commit/dcecac2580ef871186fdc4e9efc87815a4ce4c66

As a result, a command like the above will now fail, with an error such as this:

    error: invalid key:  advice.detachedHead=false
    fatal: unable to write parameters to config file

because config keys are not allowed to contain whitespace.

I believe this change was unintentional; it was not mentioned in the commit
message or the release notes.

This probably isn't a common case, and the project where I ran into this issue
has already fixed it on their end (they now pass -c and KEY=VALUE as separate
arguments); but since Git aims to ensure backward-compatibility where possible,
I figured I should report it.

Thanks in advance!
-Ran
