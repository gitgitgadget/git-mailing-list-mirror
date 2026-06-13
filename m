Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DA175A98
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781385682; cv=pass; b=EZnjpdR88ggWe6/eyqRbt6M0QL+rx3KoSYPyzscrY+B/f1FyuF7pArYmBcTgA+DNjhB/lhQUBASmzUATnWBxrbnIbEnZPxEA6Un9kld80AtoHrbegGjLzP5gmmBLgHBRl1OhURkrgXspxp+fA6jiRBPPMjddoVXla0YCsoVLWjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781385682; c=relaxed/simple;
	bh=iML7ZrjpPHfLtyV4B8jqUz56yfQVGrNIQ+T2NWHNo7U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M0NpWGmKFOdwYCdv7gpyT7LCU6xaEFZzQNGI0h5qD/L93uIi2XoSDGOUJRmEKtCjMQdS0Vliu9fF9QSUSCmbTZbYq593OL75Od6spfgdeUOOADb0Oc+WCsyNpcgkXKnT4rJXFmUCFxtXLTSy6s9yx4A7fOLHi3da3F3TY7mI+70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw45zqYf; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw45zqYf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7f015f87fddso22717077b3.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 14:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781385679; cv=none;
        d=google.com; s=arc-20240605;
        b=gaD7z7+01M3LMhYPBndx9otO0e79ENi3bQSFF9o8/YytIAALlGmDjf0Bo8AciZGsRD
         GLdt5Y8YFIaOsJ2dVQfbQl8t0cthOZdXhZPEZU/DVWrrVPBR2XK3cBv7xyWyLSRUcWct
         ffXVZPDyGKmLUZmoL2x89Nl5z5xjmIDVkgJqSVExKNuAK3JZkNuDPiGRhogdta2D+4tS
         +WonrHteHG+cNdB+tBsPF7jNXVmTJsHDQJKGcXA9rl+SzEQA9rwAWklKs9vHFdgj5Smu
         PcuTbJZG//C2PcKuGWiLBbx+beV7+1qJtwwNl2zynloF2CIX5f9J98kOLlv3b5yylR21
         4wxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=iML7ZrjpPHfLtyV4B8jqUz56yfQVGrNIQ+T2NWHNo7U=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=TbslwRqMjsvhtitMzmR+RKaxmlnM1seTKIlAJPY5rsCcgz0o84r/UcGRHC5MWo4JZq
         fQf1FjuDIBC0vje0ezabcuNV4UcRNEknbpJG5wYQaPNJRxPAkMPOPGqdzMymbOynd4Qf
         N1SLQr9nwDkXu57GU2+qqr40cvr1DzR/PfX2Sg5jknrAq1tq0R1xkLzYrKlfOZCsB6Q0
         Y/H5SnLQSVxG25z51b+3aJPyVAGcNzArrr8vW+yq6L/RKzmFWdpzBnZs8PjESDIF6ALv
         DrqPequZXtIFlqHuMFP9QxzoeGgg9MEb/Edp8yxKer54iebEVZ4NqfsvOwfDRuPLIMt9
         yoBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781385679; x=1781990479; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iML7ZrjpPHfLtyV4B8jqUz56yfQVGrNIQ+T2NWHNo7U=;
        b=Qw45zqYfvD72d3MVsFaUGefkSafPB3PFBA1Sx+XCDP8ukZXqOdyQotEPuvzOpQAr//
         82BKpXGSPNcFTNhlKq8+SHAWN4r+HzxIijMWE5MZ7DPqs5QFrZ2dnQ/J1s6KFAWACD2E
         KPAJBmtX9lCt67irY2Cjil7+jkmD7F1/vp/1K/oyLUdpL7SFc0t/XT63WMm+N4sPUhy1
         Pvec+La9riFo6G5YgilZ0NbdMijOkyxdf3pvG004r4m+jfeo4TaOOWYHurlbt29+lb+S
         tn7hLHPazo4yhE8IKU/hS83ItoLMhmZPJw7fDCpY8nDHOhkvSs/S+rEstkgeYZmerEvK
         eACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781385679; x=1781990479;
        h=to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iML7ZrjpPHfLtyV4B8jqUz56yfQVGrNIQ+T2NWHNo7U=;
        b=pYoMwHAaXnB8saJvbWcYkuNwv2pAyn8aMfy/VWr9UUH+H1/XEvo9aQeL/7YKKfjLWB
         ld1+WODql2VDE0cgmkL5T0qAkunakJxIvY3asAT5GZdigc0Az1yZpQa8KBuvhcdi7Y5M
         WBXHOxKdmwMcBGX5e1xhijOVTQ2dNGcMLY48c0aOVfFUQFClZnQ0MX9h7zJPnO66TnE6
         LOBSUt64b8bwpegrxdI+/G7VGmdGzBpgoupUdKwFfyUGLgXebkyTrTGiEblkw8szTN6h
         YHvxd70S5DyY1mcjc9kFwCrkNGPpVpJORbz/MVaVIL4vQhhNJlFHH046pTWIZsIQFsBR
         bMAA==
X-Gm-Message-State: AOJu0YytuedOPV2RrSiCHoaOp5sOKIRxwL0DPGl0V+SaGYKqB3RMk06o
	rKyFtLEJ6G0npBCx4Iwj2XcrZfTuJGGZltlwdY+mFv2aZqf2KlXnY2IP4hgfs+sUuvo7pmKYeAW
	F2E2LlavlV2O7RCJmXFr10+1RHmOgdSVdG4Ug
X-Gm-Gg: Acq92OEvxoWcNrOOcsrNlcVyAsHqguRpFVyGBEbjZnao8ZX8agU295zJeyEafTXdF6i
	6Kqf9ITAANJLJDm0oqkTfLyhuAUHi2nbMGWcJAbosfBi3NuXJvUpTrQtjnnurhRiYniFxeiPWYZ
	5ChBQdQ5nw3MJMUspnFB1FyOn09vjkKz2Ue+e8Q+TlBIW3/jdD3vXKHipVVtptkOcekVPm6r5Hs
	HA5dqk+y7Yo022tbIpGIeJtY18aJuqRTI4mOo+BZUVp2dMkavzU44m2rg5i92cNedNFB6lYHHWR
	wwL3cgpzZpNWX6Wb
X-Received: by 2002:a05:690c:ed2:b0:7bf:eadc:c13d with SMTP id
 00721157ae682-7f798e63560mr68362337b3.31.1781385679483; Sat, 13 Jun 2026
 14:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: JamisonCPhillips@gmail.com
From: Jamison Phillips <JamisonCPhillips@gmail.com>
Date: Sat, 13 Jun 2026 17:20:43 -0400
X-Gm-Features: AVVi8Cd835wXU-mfsNPk2sh8vBHr4W8_YXKp-aL0_bTAWBsE31V3IMb1mw_786w
Message-ID: <CA+pATbgyg3Wqg7NnScPx3hUmo8nG23EFx2QUXuVAd3nJ6Z_CPw@mail.gmail.com>
Subject: [RFC/PATCH] Suggestion: Safe Hook Verification for Unzipped/Local Repositories
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git Community,

I would like to propose a defensive security enhancement regarding how
Git handles hooks in repositories initialized outside of standard 'git
clone' pathways (such as repositories downloaded and extracted via
ZIP/tarball archives).

---
THE PROBLEM:
When a user clones a repository, Git safely excludes the '.git/hooks'
directory. However, if a developer downloads a project as a ZIP
archive from an untrusted third party and extracts it, the archive can
contain a fully formed '.git/hooks' directory populated with
malicious, executable scripts.

The moment the developer runs a standard command like 'git checkout'
or 'git status' inside this unzipped folder, the hooks execute
immediately without user consent or awareness. This is an active
vector for supply-chain malware insertion on developer workstations.

---
PROPOSED FEATURE:
I suggest implementing a "Safe Hook Verification" mechanism with the
following logic:

1. First-Time Intercept: If Git detects executable scripts inside
'.git/hooks' on a repository that does not have an explicit local
clearance, it should halt execution and prompt the user: "Warning:
This repository contains local hooks that have not been approved. Run
them? (y/N)".

2. Out-of-Directory Verification State: If the user approves ('y'),
Git should log this approval by saving a unique cryptographic hash of
the approved hooks to a global state directory outside of the
repository's working tree (e.g., inside
~/.config/git/approved_hooks/).

3. Subsequent Runs: On future commands, Git will check the current
hooks against the global hash map. If they match, they run silently.
If a hook file is modified or a new repository is unzipped, the prompt
appears again.

---
IMPACT:
This would close a massive blind spot for developers interacting with
shared zipped codebases, enforcing a model of explicit consent before
third-party code is executed locally by the VCS.

I look forward to hearing your thoughts on the feasibility or
alternative architectures for this defense-in-depth feature.

Regards,
Jamison Phillips
