Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F243AC0EC
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479588; cv=none; b=Tc8yAhyq0hTfN5fkP/D7fVhSRU5izMVjX7cqcfiAkBtBEnk0vHiPd/A4sQAMPc62HvbeM3/qmN49pyawsKdiaimPJd+C3fZ6o2n/KiGtuDUdak42k6PHdumE8fe3/dw/Du6k/p32Hb1QZxjFP2XPQgQQMFi3eD4XxVB9h4/mkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479588; c=relaxed/simple;
	bh=NuGbYGMJaOIT3oW5GSbmtoX9VPDNJ26Hel6553jdf68=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZbyNmP3OHkF4eJnSQoW/WDldmr2eDBUFVsNAFYGruulDU2Kni939Yj2NYXtOzXZAYW+ZMGCZJ6uWzTqTPuYdo8ARJ3M5ToeBr6N9EpKII9B3WiEnd9a21maRvXhUlfWOKDsItfv5itrf8IF1ekibBFeTP8FN/RYg88pKz45+lrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8IVvubr; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8IVvubr"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a31efdda0bso637308eaf.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 19:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479586; x=1784084386; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YKPzgBpt81Hs+3V6qum0ZJoKxyVjrzqIySCLaa3blnU=;
        b=V8IVvubrvsiZ0a0Vc5JenZrHCPZxb3eAsJTwx62is6mIVqxCwcNawnYQy+vxXU8pwy
         aYnGXWtEBAs428TfHlCKiEj0xvQAdphbJ19V4mRj9IG8k1IW1KpCUFsrnK/QQtResXE/
         kmLnGOdZH7iu3vHhkPZp+jj0lsWpBa/vXxmFdfWHygeASbfULYQsoPjADLxpFEsd9z0H
         m3DN9866olMfig8qxc5ZpwHJbD0kRbE+SwKG2gNL1kUXgAs7A4EvMlcGj00ktu7npC+9
         Jg1p0CrzkaxX6ung6WgaSdm/gtEytTbE9M7yM6hTm61lpcuweaa0EIumb/31xC3R/U6f
         XrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479586; x=1784084386;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKPzgBpt81Hs+3V6qum0ZJoKxyVjrzqIySCLaa3blnU=;
        b=SgsrbFJ6rRUdMz+7kHpwGUABkiqClqsSGHeq1lTVzNhBHdgy75ZeFaHET6IsGKyD+9
         dB75ppfeqlVfIy4WCVL5/r98DJaW7+phm0RvuijF1JSq6LZvCf87UfbMwPAmUrsU5U9e
         kXXxY7OlRifhni6v63TVBcs2W/4uE63rFVkb4kMVHM6U7gXOoNdzWqCpqbo320vtPWEs
         1CRHMSc8o0e4FWC2s4rU9X96F5HVsA8LmIB6Mf1u+GEy40l+UWaEQw8MiqWfN/qyYDuj
         TU7NsoqyYIbUhDRdy7vJn72MOBrImCP9vy/4sBmy78OmNv/htb23gNeRNkRDf+rsMTgX
         dDNA==
X-Gm-Message-State: AOJu0YxYtBeTCwEZl5pGzR3qEkESdxKMoIyDhMHbBf06ac6S8RY0dNxv
	DwZc9QDSQCQA3pl17N6APsvsInGujk5esP4I2QJ1FgEsX38GbyYgm6fjesRc6A==
X-Gm-Gg: AfdE7cm5KTjelMjN579U2zOpdcpThAvQaxjqcslsLfbR1WlVFeQBtHThO57mBKMJEUA
	3THj/9ZweZ+ibAq68xZnfDRsZNNRDbAGWtIdaY29KETJSJb/rXCkE07gbzdBoq1Ropn5EhYWoME
	+EJTFSP385L11QYqY/GXIuBy4w8xUoDm/Wl65aFZLcpks1w80Qc9BcwqKGZxVfwJoK76oUWGMAO
	pSTm6YsdIHzDRidj+FwXnGU8/1YYXpwjvvPx8t8DEalxj6uX4NiBWUOXElqZ4UhtzFiKErPHSwm
	6bvTX90IBNBkPKU9SwLvXH6Wl+iPDSL0pjoc+ZOHK0w70mQzAY9VmlDEUgAcnUux6gLuQEL8nO9
	X2bbaLNzi3BVDd0NU1V454fwJfAxyg7dcShlPI0qR220dRANr6BRTDK9xNLUQjJh+bps2HoHHJK
	XcWune2iHjXaeF2yFweg==
X-Received: by 2002:a05:6820:200a:b0:69e:53fb:7867 with SMTP id 006d021491bc7-6a36d4d0340mr409761eaf.17.1783479585704;
        Tue, 07 Jul 2026 19:59:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.102.208])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae1dce3sm906477a34.3.2026.07.07.19.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:59:45 -0700 (PDT)
Message-Id: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 02:59:40 +0000
Subject: [PATCH 0/3] t/lib-httpd: make CGI test helpers concurrency-safe
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Michael Montalbo <mmontalbo@gmail.com>

The httpd tests share a handful of CGI helper scripts under t/lib-httpd. Two
of them keep state between requests in the shared HTTPD_ROOT_PATH on the
assumption that the web server hands them one request at a time. It does
not: Apache serves requests concurrently, and a single Git operation can
open more than one request to the same endpoint at once. A partial fetch
that receives a REF_DELTA against a missing promisor object lazily fetches
that base while the first response is still being served.

Under that overlap apply-one-time-script.sh loses: two requests both pass
its "test -f one-time-script" check, one removes the marker, and the other
fails to exec it and emits an empty body, which the server answers as HTTP
500. In the field this is an occasional failure[1] of:

t5616.47 tolerate server sending REF_DELTA against missing promisor objects

on the macOS CI runners, with:

fatal: ... The requested URL returned error: 500 fatal: could not fetch from
promisor remote

I could not reproduce it against a live server (the window is tiny and
timing-dependent), but the macOS CI error log names the exact failure, and
the new test reproduces the helper's shell error.

http-429.sh keeps its "already returned 429 once" state with the same
non-atomic test-and-set. Its retry flow is mostly sequential so it seems
less likely to fail, but it is the same latent race.

Each fix is local: claim/consume the one-shot marker with an atomic rename,
and elect the first request with an atomic mkdir, rather than a "test -f"
followed by a separate remove or touch.

 * Patch 1 fixes apply-one-time-script.sh (the actual flake) and adds t5567,
   which drives the helper directly with no web server so the overlap can be
   forced deterministically.
 * Patch 2 makes http-429.sh atomic.
 * Patch 3 documents the atomic idioms generally in t/README (they are not
   specific to CGI or HTTP), citing Git's own lockfile machinery and
   make_symlink(), with a pointer from the lib-httpd list.

[1]
https://github.com/gitgitgadget/git/actions/runs/28756172690/job/85263916762?pr=2169

Michael Montalbo (3):
  t/lib-httpd: fix apply-one-time-script race under concurrent requests
  t/lib-httpd: make http-429 first-request check atomic
  t/README: document writing concurrency-safe helpers

 t/README                             | 32 ++++++++++
 t/lib-httpd.sh                       |  3 +
 t/lib-httpd/apply-one-time-script.sh | 38 +++++++----
 t/lib-httpd/http-429.sh              | 21 +++---
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 6 files changed, 166 insertions(+), 25 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2171%2Fmmontalbo%2Fmm%2Flib-httpd-cgi-safe-proto-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2171/mmontalbo/mm/lib-httpd-cgi-safe-proto-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2171
-- 
gitgitgadget
