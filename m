Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF019385D61
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940027; cv=none; b=NYOMG7tY8h6os4MmeCTQ7MdMa0VTcG4YmxG3k9TBZKo8LqN1CoAgnQ+GHuJpKsOViIuAvFtMd/dOnx+1Agm6p3uxnOROLs/0eX6zD0Hqf3rTsb7dkHhyUlEkuXEzuytSQV6W8tYRceBq5HeLrhzC0gTet0aSfo1nJuu7/vDGAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940027; c=relaxed/simple;
	bh=Wb0z0ScONlBnC2myqKjPXPkp8TZ2zjW/gBlQDKwyE+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fJNrVf8Hj6WHGgNSPnMWuC8CPG8oSXUrO7goZPy2OSjA7O6L1O20U37otkhdh+Bl2Kh1Vq63UwkhSinh0XLvNrt/dkna+l34xqWEtLavKHbx6H3uL7whCxMyZzbZSNI18sIVoOGyOmKmqp1sHy4H6CkliIJkt/WdcWGWZZ72JSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9snGjY7; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9snGjY7"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93108a3c326so139836185a.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940016; x=1786544816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wp5NKYlxEj5uoYdkzvpvhMd8uALMSstbiZSfAcu3H5o=;
        b=A9snGjY7DU7mg2tL1miix1cdQlm6G5KOjNMrF9wfFR/+bBnZMz8UqLDDNTZNiAQsSb
         /cm2U9hMK1d4Sg0Vs+ouW0Ivzrq21PBx5SAA+PCqVf731FX7Zc0/JcIrF3pD2hOWKDJA
         BFePNQI71MPGhzTlNutMMMAoQzziKwni83kH+rC3HbWCTlpr5unhejQjBGr6IUAD1Bqb
         YsczhMP7XGNV1hHC//drUjrp2/UMrtbe3ZWRv3AmEQFR2WXbc/3klPjsjtxS9MTx+zvb
         2l12MIuwbWe089EhsTGlK7GL3dyQJyAq+2u083nT0cxQH4E85qzC7OaAevqrYtz/S0F1
         6jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940016; x=1786544816;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wp5NKYlxEj5uoYdkzvpvhMd8uALMSstbiZSfAcu3H5o=;
        b=AE0VJAUhHi1VYrkf9Rb5/4ZjtIADwPdqEOH/pzb0x4iNlo2neXC7RAOJrZ9VMy3jDJ
         NNtmGQviCMQ7md7FteQuv1I6ukQUzxHUSzm7/seIz0bKdkzfAluhxeBljDQ37gQ4UBPd
         xx9dlKgBJG4MloZmW6CQRSV3D0syh3lR4T+ix3o83ktz5UIONXKHqwDCGhZCGAcKHz2+
         mDuTRIlWX8tifRW1iPBBtDO6rcWoUCtcy6OhMhTNgYDHtn0W7/9zIAiTiEblf8ahR0K1
         TIDcUX0a/jxoytq0O7MqZyEqI80lTyjvZ+VY4p2cUm+v2niC8FOUL9hDvQjGt1+omlBr
         Mxlg==
X-Gm-Message-State: AOJu0YyuwWu9fMGxbs4uUk0qYW8mEt59Z4gp4IT2mFrxQDd3TD1lgEW1
	wqj2UY6r71Cn+DMnHIKfjcKperl7N0840aw0K/rE73B9RTB3bUO8T7TftO28gw==
X-Gm-Gg: AR+sD12FCO/WHRrKGI/V/V88muw3tAk2D4bRdrwQhDPqN1GNCuO6NQ341uDt2otVZ/y
	Nr0zC1jlag1m6TFLt8fHASKFlqcB8zChstKnCIe97o9+0k5PXpRmPG4GODFin0d6IGupfcznruH
	q5902TN4Ap9oAzNINwag5Xt4HCGd6nUpUrgQIgCcRC3eabDDVsF9Tm1qkKP9hQlV4AsQDLfjbbf
	hEN/1SbPsDVaTD6oeWmJz3B6LNA5No9clJGUT2FKBVwWHFTrYyUGZh6VPfcBNIMSHqqU415yBuu
	dL5ds4DahXwpIt6eFrpmlTFukAdSJacUw8rAZk8sfsjt/W5xBZqzEY0KaFfasRTmXj7jx31zJI4
	B+7q1xJ+lLZ7JUM0aCdoOB63uxOshjPpFMVluUMFSSWpXdUKHQt7blsVTfLnFipZTfVXhrT/rSJ
	/QEdakFortP6Dl6xlox91/FM/R0Y6mtebbK7t5nXs+6cs1FFV6tQcOe356sxh59qA=
X-Received: by 2002:a05:620a:1104:b0:934:a0b2:9bde with SMTP id af79cd13be357-9363197292amr1162862185a.23.1785940016239;
        Wed, 05 Aug 2026 07:26:56 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a4260c8sm162794385a.11.2026.08.05.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:55 -0700 (PDT)
Message-Id: <c4e97449c1065c5d6c4346803ab571eb343ed034.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:35 +0000
Subject: [PATCH 09/12] windows: skip linking `git-<command>` for built-ins
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is merely a historical wart that, say, `git-commit` exists in the
`libexec/git-core/` directory, a tribute to the original idea to let Git
be essentially a bunch of Unix shell scripts revolving around very few
"plumbing" (AKA low-level) commands.

Git has evolved a lot from there. These days, most of Git's
functionality is contained within the `git` executable, in the form of
"built-in" commands.

To accommodate for scripts that use the "dashed" form of Git commands,
even today, Git provides hard-links that make the `git` executable
available as, say, `git-commit`, just in case that an old script has not
been updated to invoke `git commit`.

Those hard-links do not come cheap: they take about half a minute for
every build of Git on Windows, they are mistaken for taking up huge
amounts of space by some Windows Explorer versions that do not
understand hard-links, and therefore many a "bug" report had to be
addressed.

The "dashed form" has been officially deprecated in Git version 1.5.4,
which was released on February 2nd, 2008, i.e. a very long time ago.
This deprecation was never finalized by skipping these hard-links, but
we can start the process now, in Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3a90995587..88bbe1d78f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -518,6 +518,7 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
+	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
 ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 	# Move system config into top-level /etc/
 	ETC_GITCONFIG = ../etc/gitconfig
@@ -710,6 +711,7 @@ ifeq ($(uname_S),MINGW)
 	FSMONITOR_DAEMON_BACKEND = win32
 	FSMONITOR_OS_SETTINGS = win32
 
+	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-- 
gitgitgadget

