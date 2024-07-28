Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BB8472
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722168644; cv=none; b=JQ+m66G/Ix6hOKkgXRe7N0qVjUjNuW6LQRv4ebArXUVaKipmGZOPFpnxUZ725wkexRJC2gp2FaMPwJtUssexg8ZywWHuDuvS+maJi81ePRymChJwsdd6XF5rQ98iVOdKWkypK7y0nZp+fUAbMDfodpUkDtf5m8HJQN+M+khtTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722168644; c=relaxed/simple;
	bh=4vyMIauJI3fCIwYXotTvw+AebQb7yy3W9oX8JUBO14Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FmBnOJTScDvwptQFYY/mm91UBL3woEplARKYBELYQflb0duannBh4bJ0JimlMfHEKWrTh+rJEO2DhYTH6cZzhjntK2PRpbwzJeLk2Xj1vJlL2hGx0qcPL8RJu1d7Dw/cCf4vV9woPpVRVfkb95QTLbKlNObRz0LRRuE3IVJCLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbhRGAGD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbhRGAGD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2ae44790so1522527b3a.2
        for <git@vger.kernel.org>; Sun, 28 Jul 2024 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722168642; x=1722773442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2KT6pp/gN7b13aMmPq8rfEOwqnP1Glol6zkr7goZDM=;
        b=LbhRGAGDeyEp9OZJIHzbf7iI58bmm1r4lsZ8veZlfq4FnJtu70PUavaYFPsMppxF4K
         SGb2r5L/s28x7NgdAhIYxERyHDmggUt1eXqUap8xXyJMboS0YUH9o8SbYwT7z9dDU6CB
         ujUtQe5b+3QdiVpYvVUOG+LG2XdB0TUHuPvKpDs8srsgLMqEoPuHLXcwfTsuXRRCOn69
         RQtRe4TA+s4tj5+JpxAVwfron9fm0xigtu5qjeZok+8MVFak7GNXIqHnIpCRqI4zWMNO
         g1jt9H1Fs6S37Jn2EvDaLhbWsCUWFm8rVW+5BqYtwMxJ7BuZ4G5HbQSzYf0ltRR/tSCA
         myAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722168642; x=1722773442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2KT6pp/gN7b13aMmPq8rfEOwqnP1Glol6zkr7goZDM=;
        b=UAxdx5rV+85WZHpyjWlqAPa5KqqZ3ECfgGmePMzxVIulawU9/NwXC5qMRjXYINbAWn
         zf5G7oCxuxOY06K+d2SC1niaYAIXpmw5SzQm7uvZuIoCXXjRqo0qxgU8s6kU2BiwZh45
         lk9kpFdmXmkksyUWJ4B9FYc49pGAGg6u1ivUakXKidd6vv+LQgc0CzdWYZ0IZaWeQMVP
         bLM6WmycRNdyguEqPINZstQn+Xevt/Vmkbl7mV9uLMZ6Q8LKClUBxMGNY8E64NRV+Rno
         FM1I3+DYrCjj6IwAGGZoLo76LAvC9Pnc4gaLW7N09LXvH+ZcVw2C2oWyvCsgCXSP+iBn
         zirA==
X-Forwarded-Encrypted: i=1; AJvYcCUwYAQIZ3qlEs+jlniEezci3k1NNN+dGtWOKtPOqhuOVSzXDCugE9oTlom1IJm1vvoduZHqFMnyKE3NKGdV+H5iB+tQ
X-Gm-Message-State: AOJu0Yxom7o2SjgaAyGc7hx01+WK0wAMrqOnTMFbu3ZJ5+3oFZD0oqpK
	amxdJ1a574fRotmQpDYRSFQUybaUOJgKVlenUUd4VV9fUFOuPMG2
X-Google-Smtp-Source: AGHT+IG7+XRajRY4t1zWZW7UCwmHGwt8A5rXmoLkihJMNic96p08lQS7GN4IYSjMt9m4T4vjrDpS3g==
X-Received: by 2002:a05:6a00:21c9:b0:70e:a4ef:e5c2 with SMTP id d2e1a72fcca58-70ecea30033mr3496345b3a.13.1722168642188;
        Sun, 28 Jul 2024 05:10:42 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead718290sm5311688b3a.76.2024.07.28.05.10.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 05:10:41 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Arkadii Yakovets <ark@cho.red>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Emir SARI <emir_sari@icloud.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.46.0
Date: Sun, 28 Jul 2024 20:10:38 +0800
Message-Id: <20240728121038.32199-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Please pull the following l10n updates for Git 2.46.0.

The following changes since commit ad57f148c6b5f8735b62238dda8f571c582e0e54:

  Git 2.46-rc2 (2024-07-23 16:54:35 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.46.0-rnd2

for you to fetch changes up to de86879acedd3d6be01ac912bd6b9bc6601d03d7:

  l10n: zh_CN: updated translation for 2.46 (2024-07-28 19:52:41 +0800)

----------------------------------------------------------------
l10n-2.46.0-rnd2
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmamM4AACgkQk24VDd1F
MtVLXhAAsyc+AsclTNXqFjfkeTFV2U4lGcn8KcudgUYRZ3EJnHc3q4sFjqKI05vS
9QvbSglsIcJmpJ+/RtidqjAd9PNihvVBZKMyKsccPUmj7oHEdROqAWonWRfa7H8a
S8qAQVVp3iJyJRHkVKs9qbRLu4F4V4cxlEEu6CPqnr54AhxUUQT5/CfhvYOnWtFT
ajrj7L7hjnh8N0RhQwy+ae47jJknAey7Cs7Pneo7l4MOrbNoGGE8QiRK5xl9bykE
k+tdZLOz7ZjmaEyCWwyWs3q2V+45Pxf1ctFMGjvEfNCQz9fzjy90EJ5LUM3vqgwa
xJZiA1axJ9FSphealxuIGCeCiAtzlQG3THMlQUTAGkT0Mpufcp2f75sFPM+OPbZI
uwQxAKWUq4Iu6TelO43efr3gzIl7j7N2I15vcJs7kyFD7IKWWKH/oQJht6swvYzc
HS76PBSJ4JZSYUvskPP4DWmUUGXFrJBFGmhwj6t+TJEVDcgdcGX7/bR6QpR+kW0V
Qx6vVUUcG8W3dpmiX9vEwt2ZgDjFig9K/MVQMBn2R22sZZ2JwRam7yigIW5ibvPc
Zl81C+Y2vc5NwSoP7TiY7zyZG3cFIsZSRQrETJxgyZgGg1bI7OUkWlev6BycicHI
1AXX96PysXDZgRdOQpPhRU4MNjItLZPi6VEWC3zCURywtzrjJvs=
=99A7
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5734t)

Arkadii Yakovets (1):
      l10n: uk: v2.46 update

Bagas Sanjaya (1):
      l10n: po-id for 2.46

Emir SARI (1):
      l10n: tr: Update Turkish translations

Jean-Noël Avila (1):
      l10n: fr: v2.46.0

Jiang Xin (8):
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'l10N_fr_2.46' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch '2.46-uk-update' of github.com:arkid15r/git-ukrainian-l10n
      Merge branch 'vi-2.46' of github.com:Nekosha/git-po
      Merge branch 'l10n-de-2.46' of github.com:ralfth/git
      Merge branch 'l10n/zh-TW/2024-07-24' of github.com:l10n-tw/git-po

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (1):
      l10n: zh_CN: updated translation for 2.46

Vũ Tiến Hưng (1):
      l10n: vi: Updated translation for 2.46

Yi-Jyun Pan (1):
      l10n: zh_TW: Git 2.46

 po/bg.po    |  810 ++++++++++++++++++++--------
 po/de.po    |  743 ++++++++++++++++++-------
 po/fr.po    |  801 ++++++++++++++++++++-------
 po/id.po    |  899 +++++++++++++++++++++++--------
 po/sv.po    |  734 ++++++++++++++++++-------
 po/tr.po    |  750 +++++++++++++++++++-------
 po/uk.po    |  749 +++++++++++++++++++-------
 po/vi.po    | 1028 ++++++++++++++++++++++++-----------
 po/zh_CN.po |  866 ++++++++++++++++++++++--------
 po/zh_TW.po | 1732 +++++++++++++++++++++++++++++++++++++----------------------
 10 files changed, 6470 insertions(+), 2642 deletions(-)

--
Jiang Xin
