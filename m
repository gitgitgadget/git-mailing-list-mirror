Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077E1E0DE8
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202926; cv=pass; b=Hw0xrSf04s8IMjWL8Uet9Jdvc0WGR83H63DIsTcRI1cRPAWsEF/3sCv41EnQicOQVIjS5gAmXtg20bdZukxgFiM7yjnelLy3IBPLfujMWQj/2FD9WdFbQEBukVFcIJWOA2MXf3fWkldTnlAocKO+yTqBtRqZ0MqeJSacxYKn6uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202926; c=relaxed/simple;
	bh=ZpjWBxw5tGDT1PrIaQ/dH1u5ZuISrmAV7MhJdeVFNVk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XMkwfijGDtErPuPep44cX4H2vwkLU8jFvSzfZO+eD9/+sxCwyM0ANWIRnlk6F2LV0NjQEjZ5yYP2vXRDKboUOgb6MMzI5xhquXh0c1fXffPHJh45nOA3vpnRPf5BbSl7ZIsPOnNGurM8VJ9bBafYw6Iiv2uOD9LSy06KM08rj5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF4c97aT; arc=pass smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF4c97aT"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8f97c626aaso589095066b.2
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 04:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777202923; cv=none;
        d=google.com; s=arc-20240605;
        b=dBwCYenSIkpS93lkIkgRwoU0b8p2u9mXZeaByaSat/PNhEPSZP28rdm/INuOlhfEM4
         uLRaTx1E2BzGbydGmdQHUC5ZL5Hr/9Q3GSpxhQ3IdPvJPm91vh+NEGSFUn9Duh2LATf7
         jlVZTmJIrUNiZoJZ+TWQRCLQHDoF/ZDxVAoTyalJoWVxWQxUegwacmajdSzBtqKjT33n
         tcIBCGagOwXKDQQJaDtxZq0YFE2w8aepzr8ZWbWDV4TWOPHA1cINbTwC1QPKYu+KJyxf
         Mf/sGfbBOVKu2Wb89PXN005QQnR4gascPZ1VKEDV2YXIvG+4DaYQKjZiipy6diXsakAw
         KZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=z0uKOZ+1Mr96tEYFQQD3rodpY4yniZicwEb4dHjWYlk=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=LrVHDMcLN9TIKQOCYqhuZKpaFKMta9j7pwpCHJp0pQC8wcIzswb9+2ymX0Gkw7uSGR
         2xdtnQ64FEhoTDDiFGsptjKluxlxS7IuQ8S4ZfRXbjikV+k0Yan0fxhH+cqW8tMnjNjL
         elXT/9ez2aC5nhyjTAgSmHqb3ugUx/hWGi6eNP/NG/KVI4JTmZWH6KL8Z/M8Ahh9TfJj
         MUJcqWBVIb1JdCnMddIScB8+B3IS7YURpH5ns9Z6IcsCW2Td96/l0950AS83J+8/4hTw
         HcaWFZNmxToZbjDjvsn21JDyJ3D+qccmjWrOhfjn8ApsmyblXfgi/yepIlJkZIZKdcrN
         gmmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777202923; x=1777807723; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0uKOZ+1Mr96tEYFQQD3rodpY4yniZicwEb4dHjWYlk=;
        b=mF4c97aTk0Nalau+6ytlMN7/ldlzz1v0m2au/Cu8WkqVpAVcvexnRwxt2UZdePIpQB
         u5mSe7idAla1PWIPG/tZQlrefv0+SACLEWPfQM3jBrT06NHM9J49oyFGfPskd1FFdqzE
         kluH74Sx38zdTqpazq9JkErVcaSnqvEA2nDdlgTk5Thz/sPxg910doyDnrwOVsmQLJ+R
         QsDuGJpXX1+asLDN9UFYr+pTTj9rNHDOwWEICKfeESdJqPZZ+WmraC6Gr/khwn/bhuHh
         Tx08Pg+yfCWcni/fMuapoC3yqYFDU7Qy3QqwmgRUX2kFsAbnIcGRJA01jw2D0ntQy1/Q
         bZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777202923; x=1777807723;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0uKOZ+1Mr96tEYFQQD3rodpY4yniZicwEb4dHjWYlk=;
        b=b9jh+51EDUf3QDTA+ePTGWmTnpZ5Loh3JDKFLSEvovRIen7r5m6YDvz41BCGUJ1Km3
         mbusTt1o68TdrKdbvb4LMz04Ty3InIzcvh0jUI/Nq0dnVil7UE6QferEK5SLuYwigrG+
         wHu/9d/XXvS3bisjyd6US31u5a3e82ecFj/APrbLK9Uvc0fsn/YKdzLexw5a3JGjcih6
         SZy+l0Mm7gK6Fo7n5ESddnJEkhy6jGpIgWTAH4lb/VN5O8bzHsOF2EBnH7S0dsceC2DB
         kxvy7ZgZJSb8QNXcFsINkuBQoAW2yrgRulcNgld4tazCksFO1DFLROxW6ARCePFODYaO
         nRHA==
X-Gm-Message-State: AOJu0YxGLgrS2bLNY1CXxPZEJhSkovKZRN6wPXdTSlz/kLY9MjAD3XqW
	roCLTWCqqc7pp5xcFDSrZ9OhlNu+CpCXWyffPpIX5OVr5iJ6oJNm35rP822VujDqP1Ocpfw+qR3
	hc42fGCQfGWFEN/VUGpSN9Tf5TzxKmjE4lnUtwo4fpQ==
X-Gm-Gg: AeBDiev5EOc3AfPrCEEykjbLLS4/OcO+Wls5s3mgLXJaJPcIV9WnSJ532QlI20OD4VX
	jq1WzqwYL7CDfdxCfRKX/8FQn749OEk5TuPrmnOowj6x0D8oJSrM+GsI8k2238MMwPsaFZ4aIvu
	+vZs0ZIMG3DKmnMzxhBFvj6N/mW40FY8ijzgppLCKhqDRZeTva07WIy0Dt+NTFk9ouaT7gugcWR
	LiBtB+nfPQ55Q9CJAA+jLq4sm2/xj1+wvvdP7P7WtX9rEuiSibbxLlsSYzXYBsLGZJzDq3HNtV7
	+Rg1LkJhVmYwpuioyCQOzlaQDIX62IxtsbqU7yfndrM=
X-Received: by 2002:a17:907:9342:b0:b9d:e301:20db with SMTP id
 a640c23a62f3a-ba41de2e49amr1862082366b.25.1777202923053; Sun, 26 Apr 2026
 04:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Le <pynappo@gmail.com>
Date: Sun, 26 Apr 2026 04:28:31 -0700
X-Gm-Features: AQROBzDN1uJ5WAasK06l00JXNd94iQikjpbTJY1Bh-U8NJRLPO9l-xm6Mss20IY
Message-ID: <CADEXOKpTG99=o33do0R8Dc=k6YkgT-mg+nufDQrW-b2s+eFRhA@mail.gmail.com>
Subject: [BUG] git check-ignore --help doesn't cover -z/--stdin conflict
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Just reporting a minor issue between check-ignore and its docs.

What did you do before the bug happened? (Steps to reproduce your issue)

- Be in a git repo so check-ignore will succeed
- Run git check-ignore -z <pathname>...

What did you expect to happen? (Expected behavior)

The command should work, printing the ignored paths out of those given,
delimited by NUL characters.

What happened instead? (Actual behavior)

git check-ignore -z <pathname>... fails with:
    fatal: -z only makes sense with --stdin

Anything else you want to add:

Currently git check-ignore --help implies that -z works independently of
--stdin (specifically, "If --stdin is also given"):

   -z
       The output format is modified to be machine-parsable (see below).
       If --stdin is also given, input paths are separated with a NUL
       character instead of a linefeed character.

Either patching the quoted documentation to match check-ignore, or vice
versa, makes sense to me.

[System Info]
git version:
git version 2.54.0
cpu: x86_64
built from commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
gettext: enabled
libcurl: 8.19.0
OpenSSL: OpenSSL 3.6.2 7 Apr 2026
zlib-ng: 2.3.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.19.12-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 11 Apr 2026
22:36:29 +0000 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.43
$SHELL (typically, interactive shell): /usr/bin/bash


[Enabled Hooks]

---
pynappo
