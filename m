Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE053FD971
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535238; cv=pass; b=GoX3b7lY9cn1XVP0JMzV7j11ogjO2byFwJWh3WPxA3o/gTJuGwo75tf0p79TOBiY1f0bw8BcMqFJdDEtMtBLaT38RU5RJBsREibw5ooAlBf647S5T5UAIapvirJ1f4f4sHZVRvdr7LXNrL1mFpixaEco8K/0PSl5Aw4so0denHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535238; c=relaxed/simple;
	bh=3/52sTURc08fW9CFI5hwEZPMkagnY8An4NEU6tK6g5o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EwHzpqV/QUiP1VV15rIZxWv9vPW1T3th8Jm16Wy+bCFzqCnMyss+DJMlrtp0/Ux7Zzjo7xFwXsdD36qILDU0Irx5g7lIhqFvM7iQdrRG6f/3e7SVfHjwkCd/o7NMUnnSAFhd99wr44iHHp2PHKRtuOZOq7b4ywruGhaZrQdenXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD8a+pWd; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD8a+pWd"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1363fe80fe8so4938815c88.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 07:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535236; cv=none;
        d=google.com; s=arc-20240605;
        b=jAbX9+8JLAfXi8nyw03tb4Xc3IvE2a6RQAaeJqVfLIu/fI6DdcJmAHljXjF4n+8qkY
         idfLuWFIzFsbv9qRBOEmbLVd2fdC8ioQPCZc0qqqa96ji6e8RWrsKlqMjTh/9SH1PH26
         psg59xFbp7/T99LkBOKIJUxX3KXTymqEYbuhETKEBFR5N2ON6QmQ5vnbsS275mhNmkvP
         IRSKjgw6081iKzhvlkuY2TQQrBCUJHUs1weLbGLfe7XG+o6QTgEGuePlt9wXaYLMJGjs
         DR7XuWbJa3IwrNt6ccnl8XU1R0qwrbkuNSp3WkWWjdWih4h7h6yGbRteqocGDq9igrcr
         zwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HNrBtBTyqxkVoiweeftO8zxacfyPlGXY7NL8/lH+wbE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=DOmY1b+tLf0K+9MvmsYXo8WshV8NcTOEMVOQ+JzjfZVmdgs9+Hm0PFOunSunqTvxaZ
         ztrcwWa0YVZnR9MkYvsJyUZAKNdjIuUU6XKfg3WD2plxStc1JCF3HBSfuDT3qth2Uei8
         RKWxZNom06wudxgRYa4KwTooi7YHMKdNfn5wilnl6R9OSv5MiUf6JFxX9/SUnRMK+FvS
         X0V1ZSeVJc2SWX1ViBtsAr3/WepfW/AXLgEmZ9c8NPTJI2dAccYPBq3ASWk0Gc04qiSF
         ekl8B2LGc752k18IzyKe7x4x/17082104q1zTcyMWFb8gxDAnTbyEYYWazmv27TlNC17
         QQVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535236; x=1782140036; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HNrBtBTyqxkVoiweeftO8zxacfyPlGXY7NL8/lH+wbE=;
        b=bD8a+pWdwGd8yOF9qJSWIMdLuBrAT6xHgSpNig0RpRfOBuyo4iPkxScPtNo9oUhHiy
         6XtqJ/uYLc79ufprotYca82g5YMGML+NKSuCuHDZG6cFP7kq0MJenVSWIHxzS3K0r0Np
         TF9dVWV0sd+dGc9fNvOCr8R/1jIl+23CHuboW5p9CsdS/5CvTI0B7i3cDYz2VrXgS2om
         ms+A7hhgvs2BxL2bgMnto1pNR+AEJ3srdN6I0gvs3kfeq7hXlQpwTLeqmLMYLaf1+8kM
         dyx/vWGK7e/+6jJe2Wxq9lp6NBNdGPNoseTu1YYBy5kemBB1zU6qmQLDTJuAn9I3ugMT
         /0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535236; x=1782140036;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNrBtBTyqxkVoiweeftO8zxacfyPlGXY7NL8/lH+wbE=;
        b=ov6ynydXETGTLtXRKZzPOvRqKrlJlm6+7QW5QVZAIITvKFVbvwuTZniuaRnElpx9Ec
         mOZlkA9kmHWEmvkGYguqE2A7tryDy3yj2jTm4rAop1k9atpt76p8ugbbVL59CMf987sR
         tfd8KeReN8M35rbL6TsHdDsqEn+ilvmgiKPwHjhbzfKuFAQYcqIF+LrZWOIheyiG5+wB
         nk82q/mUOY+BQtWeE7qV/FXD8qTaPC3Y56UYLlhLNOILEMW9cAFD0NYkMcAwRiPgYGQW
         Aq165yw09Sre1tVisHoJjQ6SgcLygcIsvzEGW026CETEvtEXTDm4C5/fUFILlq6yUitA
         BCJw==
X-Gm-Message-State: AOJu0YxsnQFYsCxtC/DHV4XLiZaFNTUjGbZ/zdNNFBhTbf+aanOEjcNa
	pbVpKLroKROAz7yWkZO67OcK+iiiPNlagqN+SvsL92u96MCYzDuJXXv+AfKxgOYYPikVyxBNS6H
	UTkvjf0MWwBVg729A38MwGgFrv06huN29ILpfWOANhnO3
X-Gm-Gg: Acq92OG+ooFAYKoG1aTzsqoj0xshRhN8DgXTCPQjwo+DZMRXWo08dfDUWr4iTlUUCYf
	Z9dmzn+PtXXkJ2kfrRoPO6Lfk36afBdzXFx3mfhxQwW5PVrcZxT5xXxiT6I2B0pQUvhdKaUASnX
	TeatDz4grKFYhzrHLCI8j8+LNFvv8ZLKAivLczCSrtp2qrfSgkEu5OWDGkKzhLpbMs6rMyfyv/Q
	HwmORVrSCoIDFrcbV3chPzJ8ckl5Y3fUbLCLYbFwJ1DZSFdnyF/1tZ7jwuGDA94XZo6IXqAyXwk
	elPeCMr1nvh25D3JrMHwQbVlSHO8k2RMoW0RT+67KO0k1glB0UhNKcj8Hlq3SaVL9Pd5fMwzFHa
	tSFha0lFOD0fetf/Z6dyJfMUCNZauS+bmOw==
X-Received: by 2002:a05:701b:4285:20b0:12d:de3f:f3e5 with SMTP id
 a92af1059eb24-1384bba7cdbmr4940853c88.37.1781535235644; Mon, 15 Jun 2026
 07:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: will.flowers@gmail.com
Date: Mon, 15 Jun 2026 10:53:17 -0400
X-Gm-Features: AVVi8CdQK_MtHAvK_IDDLw4sdUAdsnQQvHC76t0pQJ3rM2-crPCNiHEVb6XaSrw
Message-ID: <CAGA=4btkTrxi2AL6mr_=dinhP-K8Y3afPpVEwyG_OqwpAUR=cg@mail.gmail.com>
Subject: Bug: Git Bash appends GNUPGHOME variable to existing value, rather
 than replacing
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I came across a bug with Git Bash that I wanted to report. I'm using
another program in Windows that requires that I install GPG4Win so I
can use their GPG signing integration.

Thanks,
Will Flowers

Bug Description: There is a configuration conflict between how the
GNUPGHOME environment variable is used by GPG4Win and how Git Bash
uses it. If I set GNUPGHOME as an environment variable, it is used
correctly to set the home location for gpg commands by GPG4Win.

This is an example of the home directory that is used by GPG4Win:

PS C:\Users\wiflow> gpg --version
gpg (GnuPG) 2.5.20
libgcrypt 1.12.2
Copyright (C) 2026 g10 Code GmbH
License GNU GPL-3.0-or-later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: C:\Users\wiflow\.gnupg
Supported algorithms:
Pubkey: RSA, Kyber, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2

===========================================

However, in Git Bash the value of GNUPGHOME is appended to the
existing home value. This is an example of the output from Git Bash:
$ gpg --version
gpg (GnuPG) 2.4.9
libgcrypt 1.12.2-unknown
Copyright (C) 2025 g10 Code GmbH
License GNU GPL-3.0-or-later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: /c/Users/wiflow/C:\Users\wiflow\.gnupg
Supported algorithms:
Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2

==============================================

Steps to reproduce:

1. Install Git for Windows (Git Bash). Use default settings for
everything, including the option to use some commands (but not all) in
Windows terminals.
2. Install GPG4Win with the default settings.
3. Set the GNUPGHOME environment variable in Windows.
4. In Powershell, enter the command gpg --version and view the results.
5. In Git Bash, enter the command gpg --version and view the results.

Git for Windows version: 2.54.0.windows.1
Operating System: Windows 11 Enterprise, 26100.8390
