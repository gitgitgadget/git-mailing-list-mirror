Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C233624BA
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775805624; cv=none; b=G17Xf35hNFgytI9/3H5g021aly2hQdgZpFENKjuDVUBl2vPXCwpT3bwxoEPHY0wygiq++HiihQw9bj0A+ZD1/hDuR7Qg+epUmWqR9Y+LLD1mRql1ObeTjsFqoFXtOkFaKTh6alnr3LjboymGG12sToONsceGsZDqZ2pWlA5+0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775805624; c=relaxed/simple;
	bh=np51Z2jNOunSMUEBFmKlS6Y5fMvTGMoeiOm0d/XKT4M=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LBgKwhzmF/GuJh9Bzb8nYzCfEgao+0aH6SFSXvuzo5ms/Lprts/Ydd1b3grNc9pHgstEtHjxkhpL6isHLPXmZl5qOLgX2brIP3kfs8oW4lW7fNbeqaM0xhIr4xO74rXx0I5cuPmtG53hsZwW0krigsrjgo60fz4cBicNnVhdUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7YKgqIs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7YKgqIs"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso1032531f8f.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775805621; x=1776410421; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TPHAA68qc2veRHEzImDUf6X+TitMg/XktRFAR6+Nmg=;
        b=R7YKgqIs5LofRcApVoxOvLm0DAoNSiU06DpaOsaaTV+iL5FCHiF/5lL/ftdjgjRcac
         TpMw4mUX8XKx8B3nWZsIY5UOF2/eDoGVtFRMILa9XOYHMWaPJTa8AXi54xFrhYlk0wc/
         GP4FmxMyQW+tvQ0bT3Xehev9fmm3lXw1oJ7yrwriTkC02LwJ5Mg2NHz7OctIcNeApzx1
         W1d7ozXCGzfveiJoNyLqaL3O5hDMiYshGd+f/e6rc5mEpi0RAtRP1Fd5r4yyHmDn6M6D
         46UimQD54enmO3aM59xxtLBEKQJgB68cmmHytce5h8GgdBt9YYcYXuAs8vCr+h8PyRMt
         zOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775805621; x=1776410421;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TPHAA68qc2veRHEzImDUf6X+TitMg/XktRFAR6+Nmg=;
        b=hdHm9r4Hc3qObPJ0to7L0o06d+7Jj3/37JqQB2GZNZBCVVHtqPz8qcp1i4u2HoCMos
         214MofF6Fa5Ca7OJymYe2YmC8fqaWX6vfCXSKOOZPPX4VvcHIQpOsRWSLfJB3fKaKE1T
         8ubo+6Gjq+FyCDKaLh9QVlBLhtuVchRU4f+VRrmA1yZbmrKYZZZ4mSW8EAcetv6wqfSZ
         FWyHs2Zcg3tt58GzKNvVUWbPpaOfzNFo8kidiVJv2nNGFzdT3T5bWKpQSTAirO1WDBVw
         x3qQdTcuEOoB0gjI44FCzZTwg7bO+jQRV2xV58Bo2HrEyzc0rBSPCycFYLXU1iZlprzj
         I0XA==
X-Gm-Message-State: AOJu0YzLas43QBrVC46ngQoo/MWLCZ0+k1+f0/Df8VEW9EsD41mS4hG/
	2XXgbTwlFzzWB5Y6HahFSSIquogaXGIszjhwcP9wrlZ474LVwX8xFydjgQmvkA==
X-Gm-Gg: AeBDiesq5/a/r0bLD8DswXK0exQ8rawc/Xrlxd1mtP7TnjKjrH5KMffIMqNd8qJnC1O
	j9hBKNAVgVFitDqgIusIX6zydJvsODFHeR9N2HSGkk2tq6Yx6yaaMLTIu7P6uSSJ87Wx2kkbmPC
	zh6GIQfpxNUMv/DnolZeugIlNM2f3edxJSbuM+Mp8AIq/xT4JIS5g6PdmT7J/0td8rvnpWNqRXu
	lWBC19vvPJL5lBtsbl5FqkVoiG8xvLsbrX0G/JR96ljquqbBtIiQM42JD4iKElgo6Qi9SSgQ+17
	BVI36umu6gkHTIj00MNjqQWkKZCN8gD6WNKiv1qdyNFSoj1iJbswb6k2Qb+iiVz2u53iAn6/Z+P
	9luroXtMM1h+z0Zp+0yZcK0j8kjxb41QCeIX2OsZqhdpB5uvsqdXg1SBYpgZYyl9DVhEtefoNxP
	bnhk/WMULvsFzmw0kNLCBtdpP2LLRJ2iSRySdMRKPrwlL9RF+MrzHXqDJEtL+/R0XZVmbamfAKg
	3UVrSMhY+gQIRJKVZUd/Rhh0CpHPga2zHpHDVL9x96fNh3hnfQV1IgZj8P4jLMcZA==
X-Received: by 2002:a05:6000:2411:b0:43b:8858:1146 with SMTP id ffacd0b85a97d-43d642c1adfmr2831643f8f.41.1775805621376;
        Fri, 10 Apr 2026 00:20:21 -0700 (PDT)
Received: from ?IPV6:2a02:8429:4dfd:eb01:15be:fbd0:655a:eb21? (2a02-8429-4dfd-eb01-15be-fbd0-655a-eb21.rev.sfr.net. [2a02:8429:4dfd:eb01:15be:fbd0:655a:eb21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2e4csm5549306f8f.2.2026.04.10.00.20.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 00:20:20 -0700 (PDT)
Message-ID: <a07a6a49-0520-44c7-b9c5-2173465cc1ca@gmail.com>
Date: Fri, 10 Apr 2026 09:20:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Pascal Chambon <pythoniks@gmail.com>
Subject: Bug - git fsck never ending on git-for-windows
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


What did you do before the bug happened? (Steps to reproduce your issue)

 > I launched "git fsck" (with various arguments)

What did you expect to happen? (Expected behavior)

 > A long run of fsck and then it's over

What happened instead? (Actual behavior)

 > A (seemingly) neverending run of fsck, exceeding the expected count 
of objects to check:
 > $ git fsck
 > Checking ref database: 100% (1/1), done.
 > Checking object directories: 100% (256/256), done.
 > Checking objects: 190% (54090/28351)        -->  (process still 
turning...)

What's different between what you expected and what actually happened?

 > Normal, finished fsck run, vs neverending checking of objects.

Anything else you want to add:

 > This is a quite old repository (from 2012) with quite heavy media 
files in it (70 GB total).
 > I've tried to "git gc --aggressive", it worked, and pack files are 
numerous and about the same size, but the fsck anomally remains.


[System Info]
git version:
git version 2.53.0.windows.2
cpu: x86_64
built from commit: e9edee0b34751bf4d7d1feda0e2535bff64d4e77
sizeof-long: 4
sizeof-size_t: 8
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.18.0
OpenSSL: OpenSSL 3.5.5 27 Jan 2026
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200 -> actually Windows 11 Professionnel 25H2
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
(none)

