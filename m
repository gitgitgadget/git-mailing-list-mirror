Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDE82D93
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695203; cv=none; b=ELtaH0mvK9/VmYFYCmteCuKeYr5fig2Zp2Qm2Emd5C/OxUfYBGlW3oiU+PbdKF52RpT1IKTi3axXsv96dn6LZzPni4A/sYKmWadbdd+EDcFq4mXCVlbg168x6CRr1bGGWE+vIr6Z12d1v5Jz0/JYuXE+ErLmW9u1oVdh1Mn/1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695203; c=relaxed/simple;
	bh=d3cpoy+HHm0tma9zsTsqEFYrno2dpyMGB0TYdSyJPEY=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=awkxk8+sPiW8b42PTxs9wJFEuSI/53Fsg5GsAO7b3KrJbimVlfWpDDugi+uEPHSf7tGjy4rRVamAXslXxokZHAiJGaIBPN4dba6oj+tbTzMjOZb+GbAwEtgG1nUAzlZqL/ZjX52bl0a2ufGnz+mmDIniNcDSzWTSJTLnbpVxRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0eQ6NTy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0eQ6NTy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427d8f1f363so26158845e9.2
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721695200; x=1722300000; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:reply-to:cc:to:content-language
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OsiRCDvqSf3CLdP0ooCEsl8tyQ2Y6Iu8NPtBjYXrM6A=;
        b=j0eQ6NTykNnO1XGf81qtumTiT9kqwAYEn6kXpQkrvd5po1QoWXnnmELtYyyt+Mm8qF
         6VVKjjL1xxTNbA03EFZL4eu69BdEGoVBCXbn9Fjm94CgmveownY5aq/U/gPT+665a5Rg
         G/m0KJe8FwQSjx5soIl7GoSidGn+QyjZtL8T5MyK1JHPjMJ9b9PeyNBIcHLZaswyf9Qn
         NRUFfGrsm6HllNX2foQG/fTIhKCkT6gDaG+gNNb9zD3fXL8u2+UssaqSdgp9yxxjxokl
         yFih4LxtSncpbHmMNEVTru29wz1tbv/wko3a/lXu2zO9zjnOLwU++1HUdl4TlqvU2KZJ
         zWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721695200; x=1722300000;
        h=content-transfer-encoding:subject:reply-to:cc:to:content-language
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsiRCDvqSf3CLdP0ooCEsl8tyQ2Y6Iu8NPtBjYXrM6A=;
        b=jL9KBDmpr1RKKzSpLwh+cAbK0nEJwnjwty9vR3cJU1HHp2z3JY59vrJoWosuEMpAn5
         og4eKV25lJItoyEAU0hSOWSQRz8dyV/HhTs23EK/bk/ZhXw3GTskZRqCSE68ycb/EnN8
         cMOIaV5NuRS4t0wLDYYEIiTwUdRCDQwNSocD1obbUpXvjJCvk1Dsgg/mO+7u2MJbVf87
         RzfLhe/gnmcS25gFEb1yG7scS7MgPypOlqWyLCiUUMy4x/IxwWmsWCgqgQlbkq6H8FFM
         g7hzOtK8Z2Q499ZMzLNEP1c3UsealWtYAQiq2nM6R9tOJLqmv2WdtLV9EtISt9sp4lWA
         ZfNw==
X-Gm-Message-State: AOJu0YxkLogLyeFr6RFhF8gV72fstSbgV4sa0QZta82sPGAqw67B+nYC
	Ug0rOfbgdSuciET9KALSluOxGtHCPmIHdux2Gu+8Dz+tpz+BbrJLpSXv8Cl4
X-Google-Smtp-Source: AGHT+IFcqyDHl2zM25BA5tGRGT39mg6PWYDTnLsGuugEaQYyU189qY4cDpP60SsDU+DddzHE7CiWAg==
X-Received: by 2002:a05:600c:5487:b0:427:9dad:8063 with SMTP id 5b1f17b1804b1-427dc51d315mr44046445e9.12.1721695199881;
        Mon, 22 Jul 2024 17:39:59 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa171sm149372705e9.1.2024.07.22.17.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 17:39:59 -0700 (PDT)
Message-ID: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
Date: Tue, 23 Jul 2024 02:39:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
Reply-To: 43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com
Subject: [PATCH v2 0/2] add-p P fixups
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rubén Justo (1):
  t3701: avoid one-shot export for shell functions
  pager: make wait_for_pager a no-op for "cat"

 pager.c                    | 3 +++
 t/t3701-add-interactive.sh | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  c3b8ebbae7 ! 1:  15fbf82fff t3701: avoid one-shot export for shell functions
    @@ Commit message
     
             VAR=VAL command args
     
    -    it's a common way to define one-shot variables within the scope of
    +    is a common way to set and export one-shot variables within the scope of
         executing a "command".
     
         However, when "command" is a function which in turn executes the
    @@ Commit message
             $ A=1 f
             A=
     
    +    Note that POSIX is not specific about this behavior:
    +
    +    http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01
    +
         One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
         0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" being
         tested did not get our custom GIT_PAGER, which broke the test.
2:  f45455f1ff ! 2:  b87c3d96e4 pager: make wait_for_pager a no-op for "cat"
    @@ Commit message
         "cat" [*2*], then we return from `setup_pager()` silently without doing
         anything, allowing the output to go directly to the normal stdout.
     
    -    Let's make the call to `wait_for_pager()` for these cases, or any other
    -    future optimizations that may occur, also exit silently without doing
    -    anything.
    +    If `setup_pager()` avoids forking a pager, then when the client calls
    +    the corresponding `wait_for_pager()`, we might fail trying to terminate
    +    a process that wasn't started.
    +
    +    One solution to avoid this problem could be to make the caller aware
    +    that `setup_pager()` did nothing, so it could avoid calling
    +    `wait_for_pager()`.
    +
    +    However, let's avoid shifting that responsibility to the caller and
    +    instead treat the call to `wait_for_pager()` as a no-op when we know we
    +    haven't forked a pager.
     
            1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
                            2006-04-16)
-- 
2.45.1
