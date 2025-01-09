Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2B219E8F
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432669; cv=none; b=kNVFssRHsO6eu+VKvZ9rnJQueiuIlAc8orq80lWrhW/jpXmf2pnTSUGTHk4qGr3MGtBc7jolzm5Vr4rpJuGqxMIAj0I7+My8+cEfAu20g7LJK6KuqlS15ZPJjlYEfCodyZ0NIAQxRIlXKAFTjTkp4DrFHLznV8mY6To5idWaiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432669; c=relaxed/simple;
	bh=wQRJt+OXCAqOclCkg6KEZzYTJ9i44WoOx1oTpDLLcsE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GMguQXHKZhraeqmsqP6YDB4Ant0BUBXTWf72VBzvOaSLQjvtnG/csVavsgeZpUInQOqitwM75ryDQGTxPp/9m5uu7aiUe1LDjK3BmER5vUQGmEKwyQm1jrQd5H0ABgk4JXYKg7W15TdvGYsP1YE4jIEhF9GV671p9dA0CEKxha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9nUYuhH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9nUYuhH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso876519f8f.1
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 06:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736432665; x=1737037465; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CpAKmSejArlIk0tymd2KyzGhD8Au1DOWGVaOh6L/GZU=;
        b=D9nUYuhHoaAIAuojld0XePx68RzXWY4nPcKQCdLTUknZwSnwjpNK2qzN1ltYtRrQij
         9jzxFkYZGQOO1BOq1KygxTNZNHN5PBOHYuPq2QcY7COEfHqfWIQBX0kkOj3MjDg0ZhlT
         GJu8EOkBCHstQdu9Z4N19H8ZRHF80eBn/3mfByM7FjwOYF55o8qc1njLxKeIdYMKa4cN
         OAyrNA5uX5Hh5BWQ+mUiYGXbFVA0ZAu5Hz6O1fEw+s0gVWYw2Q4jmE9pFdFIBdgP7Ug1
         XMfhKkQa/I9nExsnQZB9eTVblyFzaGL7gBEz1d9Mos2bNT2Dc6ARgdY1jBZfAY8Flwm6
         mUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432665; x=1737037465;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpAKmSejArlIk0tymd2KyzGhD8Au1DOWGVaOh6L/GZU=;
        b=gdRvEIXexSdotSLYHgz2kpKx76nJB/dTMK4d7wNE+PgAz8yCcul7XPBzDU0k0BxIm/
         HOly+F2Ewinb1/OTNdGdw/TljuhuBDIafHP1tR9wqgaemOgNE8rkx6RSPo0hkImckoeH
         0OH34mZMIRiiOrtu1ExWwOn6AMi5hffe6c5p1lRwdooi/x5SdvpnylYHwsl9vCnwEph2
         Ks+QNKrR5//GrEUC8lMjsfKA4+WYKv2i2xTI30mVZQTVdgTsbkRaOKwY9B3nQ6N5cAz0
         nvuPZcouu+QG4g4PYOlpZrnaNUxVxilQgdOtFm10f8XHPw0Ulrww99wjhs2T+SWIjA5m
         QMyQ==
X-Gm-Message-State: AOJu0Yy46Aqk1SWeKnwzqo0sjL8B8BvLHCPtlFdcHNWlocCFgnDBuRyp
	P3UyEhyen8VPAvFKw7ecAwJR/tlDzSBqfiHCEkDB+L3wlpGNlKxEJuWJ6A==
X-Gm-Gg: ASbGncsZrxb68huw4YmmObKDQqeD6EiEej4BXYUONNHtAV6Xyx+dvLykOiakNCoJv1W
	ak/Tu9SAhEGfEeYd2n4BJwwbQBBwJ2CTYtZZw7U3+9fd9HAVdb+B/Rb8iySwaVsbrz2WrYTrfgY
	eO8Da17kolAuOn42jevaSbidSM8hv4PdUPkBxIRiyNVUfC4ihAd35Vwv/cayzifWVZGaJ9XYDYJ
	0fuWK9SPvQROcAntJTYvWK0qzHdqBlvr1aGlcxVXAAGetdVtwznQiU4ww==
X-Google-Smtp-Source: AGHT+IGMXvUfPmT/JhnTtSoVwrvfk1rXQjb4rljp31G1+WVDpEEVlP1oal2oZgZ+dxe3u1Xvw5phAA==
X-Received: by 2002:a5d:5f44:0:b0:385:fa33:29ed with SMTP id ffacd0b85a97d-38a8730fa63mr5472188f8f.47.1736432664488;
        Thu, 09 Jan 2025 06:24:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c596sm1981868f8f.51.2025.01.09.06.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:24:24 -0800 (PST)
Message-Id: <pull.1850.git.1736432663587.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jan 2025 14:24:23 +0000
Subject: [PATCH] GIT-VERSION-GEN: allow it to be run in parallel
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

"Why would one want to run it in parallel?" I hear you ask. I am glad
you are curious, because a curious story is what it is, indeed.

The `GIT-VERSION-GEN` script is quite a pillar of Git's source code,
with most lines being unchanged for the past 15 years. Until the v2.48.0
release candidate cycle.

Its original purpose was to generate the version string and store it in
the `GIT-VERSION-FILE`.

This paradigm changed quite dramatically when support for building with
Meson was introduced. Most crucially, a38edab7c88b (Makefile: generate
doc versions via GIT-VERSION-GEN, 2024-12-06) changed the way the
documentation is built by using the `GIT-VERSION-GEN` file to write out
the `asciidocor-extensions.rb` and `asciidoc.conf` files with now
hard-coded version strings.

Crucially, the Makefile rule to generate those files needs to be run in
every build because `GIT_VERSION` could have been specified in the
`make` command-line, which would require these files to be modified.

This introduced a surprising race condition!

And this is how that race surfaces: When calling `make -j2 html man`
from the top-level directory (a variant of which is invoked in Git for
Windows' release process), two sub-processes are spawned, a `make -C
Documentation html` one and a `make -C Documentation man` one. Both run
the rule to (re-)generate `asciidoctor-extensions.rb` or
`asciidoc.conf`, invoking `GIT-VERSION-GEN` to do so. That script first
generates a temporary file (appending the `+` character to the
filename), then looks whether it contains something different than the
already existing file (if it exists, that is), and either replaces it if
needed, or removes the temporary file. If one of the two parallel
invocations removes that temporary file before the other can compare it,
or even worse: if one tries to replace the target file just after the
other _started_ writing the temporary file (but did not finish writing
it yet), that race condition now causes bad builds.

This may sound highly theoretical, but due to the design of Git's build
process, Git for Windows is forced to use a (slow) POSIX emulation layer
to run that script and in the blink of an eye it becomes very much not
theoretical at all. See Exhibit A: These GitHub workflow runs failed
because one of the two competing `make` processes tried to remove the
temporary file when the other process had already done so:

https://github.com/git-for-windows/git-sdk-32/actions/runs/12663456654
https://github.com/git-for-windows/git-sdk-32/actions/runs/12683174970
https://github.com/git-for-windows/git-sdk-64/actions/runs/12649348496

While it is undesirable to run this script over and over again,
certainly when this involves above-mentioned slow POSIX emulation layer,
the stage of the release cycle in which we are presently finding
ourselves does not lend itself to a re-design where this script could be
run once, and once only, but instead dictates that a quick and reliable
work-around be implemented that prevents the race condition without
changing the overall architecture of the build process.

This patch does that: By using a filename suffix for the temporary file
which is based on the currently-executing script's process ID, We
guarantee that the two competing invocations cannot overwrite or remove
each others' temporary files.

Incidentally, this also fixes something else: The `+` character is
not even a valid filename character on Windows. The only reason why Git
for Windows did not need this is that above-mentioned POSIX emulation
layer also plays a couple of tricks with filenames (tricks that are not
interoperable with regular Windows programs, though), and previous
attempts to remedy this in git/git were unsuccessful, see e.g.
https://lore.kernel.org/git/pull.216.git.gitgitgadget@gmail.com/

This commit fixes one of the issues that are currently delaying Git for
Windows v2.48.0-rc2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    GIT-VERSION-GEN: allow it to be run in parallel

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1850%2Fdscho%2Fasciidoctor-extensions-gen-race-work-around-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1850/dscho/asciidoctor-extensions-gen-race-work-around-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1850

 GIT-VERSION-GEN | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 6d1cb66d69a..5b49e2d72fb 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -86,11 +86,11 @@ sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
 	-e "s|@GIT_DATE@|$GIT_DATE|" \
-	"$INPUT" >"$OUTPUT"+
+	"$INPUT" >"$OUTPUT".$$
 
-if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
+if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$ "$OUTPUT" >/dev/null
 then
-	mv "$OUTPUT"+ "$OUTPUT"
+	mv "$OUTPUT".$$ "$OUTPUT"
 else
-	rm "$OUTPUT"+
+	rm "$OUTPUT".$$
 fi

base-commit: a60673e9252b08d4eca90543b3729f4798b9aafd
-- 
gitgitgadget
