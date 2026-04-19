Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3B2BD11
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643050; cv=none; b=enrxu6aZ+sTJ2AvGuzglbc1EnUah6LFu5tDRtnLoswg0lDxwtd/GI75Vv6HMTq7fTlewcWoAdtyJahz6IwjubpnW89xL9YTdsV1qbaV5oRiXcUPEVPUNs4uXwpCSS5SWxpw5LR1+Q2VPReQx6Z2ofVeg/lB0lGemxKXPWqhKXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643050; c=relaxed/simple;
	bh=HG5DdsDuApEMlsalJ/eDtNIZOLEBq/uVxYfviHmAh9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdVrE+j+fGYqlPQGovgdiuiOdPRjqmIfB1FE/sWy5KUAjQShMn9eANc5W7OcAOubCtHk1w/OJykWhWlfwbXtQF0PQ+GGDX1HJkf+HChWcisSmeEVoQKNl+dFdee+81NKpDIY6u7tSiWr+Kc4V0qSzc4YxplvLpzGPUfVlezyxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEkpmarG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEkpmarG"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a60975dc5so23564867b3.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776643048; x=1777247848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/Zt8BhIPcX/cPy3Ke+YyxyG246A5BS1Kd5P15I0z2c=;
        b=BEkpmarGRbY0CbzQLKIFs8AoOii0/wxQLa1iv/hiI2acfXZwcYcl6I1kjo03Cp0tXs
         +JJK8v04J3obDCPwN6Kn+eCiRVG33e/Ugh1Xc2bR5OEtT5UDqFQHBCZeDUoxJ5WMg2/t
         5d2Ea0ITmKxh4Ttgend2wQwJTRPA6p3lHdfbBloLQp6aQICnEeiR7osK4OFNDs5FOaTe
         F0k5V1lFmNRkX70lKh2M0wcfhC5hlnl31tB0dANLvuhuNPInPXAndv8+ffE/cbwJldD8
         u/MToqTT0XkvhfaMZDPktKGspAagCGKwpXt9h8CnlUgS1OCj8RKeVl0fmmWv+QzSnPwS
         VrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643048; x=1777247848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/Zt8BhIPcX/cPy3Ke+YyxyG246A5BS1Kd5P15I0z2c=;
        b=lQ3sqRUsh1Zut9fzbB06rl4ZBedlSXPibN7l8JiKm7o5H5VeGcQnLJTmfM3RGgN6e6
         fEziHNNAk7l+LyyYctL3LbBEruR6f+5fpTMpzGFLXp+DVQQ+iD0YiY5UOuSrFwRTsQlf
         8ay8pJlmCzTj1SRPwIZiow+PtgR9YIp9ptyXdoDIlIsqv9K/zbnVX+7y2Khp9azj/24r
         rtjnGdeqPdOZz0qa+/01cPh89KniKePcnLC6urJIbEg3H4wjIwcBSe8P72KHswZXnPPT
         Huj1uC4NRgqd6lw7gkqEdE+unoR9YtADsaDcFRI9t0Dy/wYqX//7aj72pPwTnHT4h0li
         nDUg==
X-Forwarded-Encrypted: i=1; AFNElJ9WBChEdXqdxryW6O/NGErPzYcs2MnOZhX+PBAEoC7OuCABXQeoavycAcz1SraJn8PSUqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziTFzzjNGjRJ6GWyJsFsI5a9aX/WLWAvsh5gF7TBjrPLVPi7GJ
	akgnLKQqG5PT7VOse0zTX78GcqHC6FPQeGFAHU2CoMjPUSdkOuT1/AkA
X-Gm-Gg: AeBDiesopFVvm+fdT4Pre7cEkwf2sCVyyQXi+fMo2zV3ik+yUONXuFKpAi1QC0Brxfm
	Uy5n7FsSk+Hy33TN9QrZYd95xxNT3+cjo7BHMUJWCupcooBJNMpubcD0CoeM9K9J2j4SC5uR+YN
	9lzkr3Ttc2KR0ttHIr2SImJxOqiUhdGy2P/tEAysGwxpUnNWXaDujRcqvoinV0vcAoqV/lqLZKi
	NXwKgnOHSXtah4VEsJmFsFaoh3RPKOv+6SkzAgnFf13MEQfwfsIEznDzN4mUOo40tOWmld++Odb
	FgTBopk8YmHmPssPw9FL1HpU+ks5NzNOIJbrGLJY3yTmo8ChkQQqL6Ci60kZRwmg9UKGzPsD81V
	v1penBhnHRTk95i8zCIzsP12WG09H0bLjfSJElslphLuo9hzESRnwg9NfSJl+q1bMaJSaEoy9zW
	Mxu5+7/08h+2W/f5wL9R/5Ry/g5R1JOTb7tIWZ6puHI1FQVhPspazkRgOKJX7MwEsa9V4wy7Igz
	lxs1VXSeLzK7rmVOVfgkfScqvp/eR6oaxQoLjf04D/xJl1o/ZYdddxU5JeTHCdEE9cVQ26N73XL
	JjZsCifnigjjUmw0qu3ugA==
X-Received: by 2002:a05:690c:6ac7:b0:79e:ce16:38b with SMTP id 00721157ae682-7b9ece91854mr126435427b3.4.1776643047945;
        Sun, 19 Apr 2026 16:57:27 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8c3f8bsm37241277b3.19.2026.04.19.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 16:57:27 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL v2] l10n updates for Git 2.54.0
Date: Mon, 20 Apr 2026 07:57:21 +0800
Message-ID: <20260419235723.1579499-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <20260419111136.1577323-1-worldhello.net@gmail.com>
References: <20260419111136.1577323-1-worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Here are the v2 l10n updates for Git 2.54.0. Changes since v1 include updates
to the Bulgarian (bg) and Traditional Chinese (zh_TW) translations.

Changes since v1:

    po/bg.po    |   62 +-
    po/zh_TW.po | 2699 +++++++++++++++++++++++++++++++++++++++--------------------
    2 files changed, 1822 insertions(+), 939 deletions(-)

Please pull the following l10n updates for Git 2.54.0.

The following changes since commit b15384c06f77bc2d34d0d3623a8a58218313a561:

  A bit more post -rc1 (2026-04-08 11:00:10 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.54.0-v2

for you to fetch changes up to 5f53a3662a2aaebe36f8751807be728f41f65907:

  Merge branch 'master' of github.com:alshopov/git-po (2026-04-20 07:37:21 +0800)

----------------------------------------------------------------
l10n-2.54.0-v2
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmnlaFEACgkQk24VDd1F
MtUpsBAAoyMhQnxSHprl+xXd/JVOn/pswGUOvXyr8c/I/BowkG4wQfVyRwpw1uRR
lO1jlEyyJjIAXJERnTODzuCEktBSfwedF7HgZhS68kTq7xV7hOuxJVS8GXCWI0O4
TXQ/sNQcP93swIxqbTUhnP+sFwb3P7YoUDWIAbNJa7PLkGZbOdet4iWYSk3etcya
JbE6MAZpTjNidleTcpjeC87Wy6X59VCSFHAr6x3AaOyaZ8W5VayiRJRb/Zy6gd2+
ebc8qcPVXAWlwZfmPlQfCV964tbfhc8Lz/vHCmuNgA9bqqZZHPJSHE+UNhjuBOfv
pDU8MVhKI2NTCqUdrW782fXCewL3iJ72T0AYTV6m8MhO67gi3OYk4Y0C82kH/6eg
9FEk5uu1HnwhdVYb0yh5mS7nEbwjJgUcfJelWggHfl/tDlumw1EOrQbF3Pe1DIIH
K4Km7sNgAiXyJ2oePkIR9Pghh/5yJgQ39NUc7houFgaz2UfnQ3taXgaDL5cakhOV
42yCnLNsiTm4QmFbctMqLK7l7C2Ql0/UEm5moRosRS/KpaOMSlrmxhuE5Fad344f
VeZsFiHJGtkB/hFb6lhfLEIryVjkb7mpt+6TMZD+P5os1dHWM4Xez09YHg+i6I1A
lre6pVUSm59qQTmHhpPIl49Ak6A4t+OX+/3CIALotAkWucOuiCg=
=WrJg
-----END PGP SIGNATURE-----

----------------------------------------------------------------
A4-Tacks (1):
      l10n: fix 'zh_TW.po' 'Applying patch'

Aindriú Mac Giolla Eoin (1):
      l10n: ga.po: update for Git 2.54

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (6226t)
      l10n: bg.po: Updated Bulgarian translation (6226t)

Emir SARI (1):
      l10n: tr: Update Turkish translations

Jean-Noël Avila (1):
      l10n: fr: v2.54.0

Jiang Xin (17):
      l10n: add .gitattributes to simplify location filtering
      l10n: docs: add AGENTS.md with update POT instructions
      l10n: docs: add update PO instructions in AGENTS.md
      l10n: docs: add translation instructions in AGENTS.md
      l10n: docs: add review instructions in AGENTS.md
      l10n: document AI and PO helper in po/README
      Merge branch 'master' of https://github.com/git/git
      Merge branch 'master' of https://github.com/git/git
      l10n: zh_CN: post-2.53 code review
      l10n: zh_CN: updated translation for 2.54
      Merge branch 'zh_CN-2.54' of github.com:jiangxin/git
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'apply-patch-reject' of github.com:A4-Tacks/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'fr_v2.54.0' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po

Mikel Forcada (1):
      l10n: Update Catalan Translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Stefan Björnelund (1):
      l10n: sv.po: correct various translations

Yi-Jyun Pan (1):
      l10n: zh_TW: update translation for Git 2.54

 po/.gitattributes |   35 +
 po/AGENTS.md      |  877 +++++++++++
 po/README.md      |   98 +-
 po/bg.po          | 1630 ++++++++++++++-------
 po/ca.po          | 4215 ++++++++++++++++++++++++++++++++++++-----------------
 po/es.po          |   34 +-
 po/fr.po          | 1244 +++++++++++-----
 po/ga.po          | 1457 +++++++++++-------
 po/ru.po          |   28 +-
 po/sv.po          | 1351 ++++++++++++-----
 po/tr.po          | 1368 ++++++++++++-----
 po/zh_CN.po       | 1454 +++++++++++++-----
 po/zh_TW.po       | 2701 ++++++++++++++++++++++------------
 13 files changed, 11694 insertions(+), 4798 deletions(-)
 create mode 100644 po/.gitattributes
 create mode 100644 po/AGENTS.md

--
Jiang Xin
