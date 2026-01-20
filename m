Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB83370F2
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890012; cv=pass; b=hTa1AOXq4xszz87pLvaHFA8JitfX3l+rPqbVrCULxTNvCSeQypHCLlaYr9n8OCLcks2/tqP7L9XwNKLU1xAtfQItSDfCCdkWlE77gNBcYgqseWxSvpyb2O+jp3xtxdcuQ5GALl8fr0we4cfglk3Lxu/GzSnXH7rGnk7DuMtoy5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890012; c=relaxed/simple;
	bh=nrBbru/FHxBAyS0S82cItkG2hycPmtFeZF4MtQTnfGw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l6WDPRateQ1cze1H744MZIR6DzOsXFwL6JD2y75ShpzAbluAXttIAapbJ4HjwFCsrQO1g5HjjIIkntIaEGONyonczal4Pj4DyMc8JX6eX1cwnYR+EER26FdhIZtI2ssEM6aa+XFthMacfRgudHzYrqi92VYcIpbjcEcyQgCAH8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=M1QZQZPb; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="M1QZQZPb"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6442e2dd8bbso3938714d50.0
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 22:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768890010; cv=none;
        d=google.com; s=arc-20240605;
        b=ktxMKpj04MUrNSF9+hLCU0vGUS1uv+Yr2Umbj0QvvfymI+BEuHyBF8rYpq8kwDHkOq
         8t79V3EVwGqpsqCodnXWSLpC3O5dUuUsdxSqDKnreQFin/WVcjpxo/m5C73XeRfAVN5C
         4cCFv+MfM4PhNydgiyPuxlsBx16Z5SxTl0ayVIXg99G0lxF6OojljPTDjOYiKf45lQvf
         MQHz+dfHmWAkkQP/eydBznTqjyXc/t/BMs1jZm1sQb2g7kez8xVN5JRm30Xy9mQabejg
         a5rAtnzOHVn+9v1pNcC2G2UjgfYhnrl+GmK3bOeXbvo2kdp4bg2DgyF3YaS28/1IPtWZ
         prPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Ilq+Bwj92YKYSvNBrb8XiqDYtN2dxF7nLIqwljI9P3Y=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=SAQjlxeypehU+V0OAIhMtPe3m1kEHRHYjq6XvcWMbpqXErfNcIS5II4CWpejplfViT
         iucESLXXh2a7CXp0Rey38fP46rbvyg8UnNI4jHUUFRLt2rlRRBIceZselLMI2GUBf1CD
         ZAzf3sXFKKJr36DIOjETi0cqfbL9cQgSK5jK+fG+dNov9zt0Crc9ZvDrKIheNTY5/oY1
         P+TkkEVilYrFB+Ef4NvmNxir5ly4ZTrLudLzw6iJft7+zIkpHESj+c9cLwMliUnfbhHr
         EpyFPv0d66V/PFX77jQwgnZY7bt5m7YJ+0FgXaK4VMmp5WF5nRZTSflPC9f9xrRWCcBy
         FzsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1768890010; x=1769494810; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ilq+Bwj92YKYSvNBrb8XiqDYtN2dxF7nLIqwljI9P3Y=;
        b=M1QZQZPbuyrqN7bCdrHDOUtUm81BIG6W15STWuijtRZ6HdSFtSirGuJoeCtUkAr69P
         0GFzLghkJUA6M1jZ35MnTdWm1CQu2XroKBaMgXK/FkFTu8s9JK1MDdlu4LwHMbldNiC3
         iCgdIEWgXTkL73B3px/J/PYbjfSIzso/crZ1d+AQK8rREsWBOlfo1QqA3cCauYLy927y
         ICYtWzAWcLhHF+yqE5ju/+Byv6k8JCQ1ey+rCNiW0biwJ9zSJF/G+WEzJCEZZ2zJRwlZ
         5aGszq/Xxxl+GQFJAsFoU6WNnJxPq76FXL39Jg6Y4GCX41pI99R0KAJIkGkdg9UBlQJ0
         zSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890010; x=1769494810;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ilq+Bwj92YKYSvNBrb8XiqDYtN2dxF7nLIqwljI9P3Y=;
        b=eAxNS44jePgvEVgrOwcBIDLE3GwrC9SeH7TC9nMK/VzeYIOpOj/kXpqL98sRV2lio2
         VTinbvzU+M6O7e45aBJ/VTk7RepHSannbYmO2gwD0qBBZUD0wBYGTWhwZT6j50YJZkTp
         oqWR9qswnPuDOtvMzbsy+RISxDYhyGCw94DUvSk+kbtleUTwvMhenqrTDdc7WdjhBL4b
         m16J6/ttvJVSyBzDRcqSCW4WjysLKvFVerP/hMCb8VBocSlM0oIF9y20Ss9eUQoR+i13
         PyAmSBagF8ZVuG5q7VfpCsD6j5nCdVBJGLGXj8zg2+MJrRjmDQvFIDsitRoiVvBK4zNk
         nqHw==
X-Gm-Message-State: AOJu0Yyd/RGpJGn8zn25jgv/vURUSYnZeZQdipRqHBnc9U4gX8dNU+O7
	mPresGzV/ymQ9mxYeg0nvWvvlE0R7UM5ONjtm2JEnT9WULwMjyfX79KmBvad+TE5G4Jd5P5MblX
	C1xAhoOgCx+iCOkAGbKqApysD16SUszWS1EIkbnaTdM/MKmu01beeZA==
X-Gm-Gg: AZuq6aInStcnSkZq+UlNSth4dSxeVMRGnJZUT+OnG5UlrjyvP2G20bB1zXC+uojh12t
	PIbYAkNhNICYgoB1kgoV/Az5dDjHyqeIVi412R6FGQ2TiAjfMgXWh7m7rGgrGjtWobUeosqKzq1
	kkAH04HI3iVXrvQs63eCIy1jWIZVcBkNroNj8YdlLKCDSBNLIgisL8QcMGwcP/XgYaey6Tk/ha3
	U3Id9aOheA+Def0juaFvJwVUZuCaUxkOmWwKwiUoccuQNHBqL5I1/Pb1JAn+911IReKSLImmH1b
	inJtc/BRa9Fh
X-Received: by 2002:a05:690e:dce:b0:640:d174:3839 with SMTP id
 956f58d0204a3-64916486fa8mr10566904d50.36.1768890009825; Mon, 19 Jan 2026
 22:20:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stepan Tsymbal <stsymbal@atlassian.com>
Date: Tue, 20 Jan 2026 17:19:59 +1100
X-Gm-Features: AZwV_Qjp08NoTUaSR_7pYjTlvqfmnPG_Hv3zw2mmZKvEzxhL0fyDS5T3lnGex9M
Message-ID: <CAM8dTE=RciNHyyyhtprjXL22deTrzj5DKcBsSiAt0jFz6Az8JQ@mail.gmail.com>
Subject: How to get failed refs with new 'git fetch' behavior?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,
Appreciate your time and effort on developing and supporting the tool!
I hope you can help me understand how to work with new behavior
introduced in 2.51.

We parse output of =E2=80=98git fetch=E2=80=99 command in Bitbucket - in au=
tomation
that synchronizes mirrors. And from the output we see what references
were successfully updated and what failed.

In 0e358de (fetch: use batched reference updates) =E2=80=98git fetch=E2=80=
=99 started
to use batched reference updates. Which is a great improvement by
itself, and required the change in 'git fetch' output.

With git 2.50, when repositories had directory/file ref conflicts, the
errors were explicit:
    $ git fetch
    error: cannot lock ref 'refs/remotes/origin/branch_path':
     'refs/remotes/origin/branch_path/conflict' exists; cannot create
'refs/remotes/origin/branch_path'
    From /Users/stsymbal/repos/git-conflict-test/first/../first
     ! [new branch]      branch_path -> origin/branch_path  (unable to
update local ref)
    error: some local refs could not be updated; try running
     'git remote prune origin' to remove any old, conflicting branches

And git 2.51, in the same situation, no longer tells what ref failed:
    $ git fetch
    From /Users/stsymbal/repos/git-conflict-test/first/../first
     * [new branch]      branch_path -> origin/branch_path
    error: some local refs could not be updated; try running
     'git remote prune origin' to remove any old, conflicting branches

It is trivial in case of a single ref being fetched, but when fetching
many refs there is no obvious way to see which one failed. For other
errors there will be a single error message per ref, but not for
directory/file conflict.
The 'reference-transaction' hook also lists all references as committed.

Is it expected behavior moving forward? Can you suggest any
workarounds to know what refs were successful / failed?

Reproducible example:
    mkdir first && cd first
    git init -b main
    git commit --allow-empty -m "initial commit"
    git clone ../first ../second
    git switch -c branch_path
    git commit --allow-empty -m "another commit"
    cd ../second
    git update-ref refs/remotes/origin/branch_path/conflict HEAD
    git fetch

Thanks!
