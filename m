Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213D1991AF
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736283; cv=none; b=FlYxZLfmvLifOfuK9GYql9oHROdmn0KmNaOka3WTCXJXaJdv2U5LYR42StHqC7u1mrVXHu/u0mTPspq4Sz+1orlIGFM0v7f+N4Bq0+t9sdtTE6j4xRs4/6XaaSUtZu7bcaGAkFD5JVDYz7Rg87touCLE1/acmfXo6yFIcraYE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736283; c=relaxed/simple;
	bh=NsYpQR8D8EWiAxl7//ZB7Dy+dNeCtRT5jyytUrqyL6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aniz1rAvoyrnVHybH8E/qKL07eVKsBE3KXUP1l4DqaOutZJAQJhSKXjYTLuJhQfKz+4Sj2zkJXGRKvN3jzQHXfXH0551SHGZYz8WscrubVzc22VYkgO2m1L6nUMRiRBuD1X15tQXXqRf1hGu/3cU0H4mDeyhGWzIeDl+Lh6KzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=l/bauwJj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="l/bauwJj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso15862655e9.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1737736280; x=1738341080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=020pw6KPimANOioRtqmhtcPnYPTEs56+5pPiQg3BZXQ=;
        b=l/bauwJjj008dhDlb+633gXvTKx/9m2uFRm0v8p+1YTT8P5cG1+R/eXzciLvY4Z68b
         +YqrIiupZCBnY/k+fWZtr5ztpGtqKpdbPY6A184/Nyp0Us7Hpbq7dF18Dn35CZF1YE+2
         Pf+dsLc51hom8OMJZ/TOT47dbAEkn5GnznNIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737736280; x=1738341080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=020pw6KPimANOioRtqmhtcPnYPTEs56+5pPiQg3BZXQ=;
        b=TAtu7oi2isBqOSFSz8vpu5eu2ueDur0EA0E8+DJAorsLxHEyk3ygyS3J4JUDdBfAgb
         PRfI7WTRt/q+uhJJgv8q9KyHkez9RtGNEyHWEyqn3zpbF8TbC7VltO1hd6NvrXaOgn8T
         PCGz53irpShSMEkPrxpJzBLx2VwdEiWQwUmrvPomLy2tF0I/d4nI7D46Ku3Immn5OxNA
         1p2ZBnKQzIdRVNMxvMkVOr8iMEQB1BpGFVE1YJjiPN+bz1ZtPsY9vuuEJ/ISIg1rIfnc
         3pxsVuT0LzxAeBKu8MvRJ2W8LUaEmMgFwVzkztERAJxXp/0s1XxBiBoRvwXRz9+WkZhZ
         nViQ==
X-Gm-Message-State: AOJu0Yx1DFkmnP9gIfdBTIyX6oXYUHBApfiG4ySmTS6vtuWxg3oIgO8D
	+At3M7Zn/w+3ctkpPL89/7b2CLXafCRY6UGaHpsVS0te48QrN8QSCYIzfXjNOQ==
X-Gm-Gg: ASbGncsuDt8xkR7QNJJ1CvRVyDSmMfVqKZLiseTrPRsKSKHHHPuo+GY7MKUcUfrF9vh
	cgCpECRbL24SMJWbhy9jpn6fLJUCa4HcThE0/LXm+T5z0QIsp6b9booHfQ04DtqiRKDl1eo+lRu
	nHopr/3NLbKQP+0Gepyt9EkWLcUSlBiZBjpcBIwehfDs8w/9rV97IJoBlsXk6vBDSmaeFMfSgSi
	YOyapoe8vNCLmA2z2yv/xGFDEL8ctlsH8LQ8Nbkume6IgpYjkA8vGeQdxqDpmv5YJ6aisMyjNX8
	Y/x9de2v72vCpktFjANDfgslXuyY30uFFISlp3TIuzvhyiwjzKp0dEIhzdTmT7ko2W3f2yVy4EQ
	cLGWGxu87
X-Google-Smtp-Source: AGHT+IHXiaA4w0173ToCwwou1pAg706ZkrT+nL4csyyoPPLTWdBWM5IL6Qw95SuG3sZ+CsnojZ56zg==
X-Received: by 2002:a05:6000:1864:b0:386:3328:6106 with SMTP id ffacd0b85a97d-38bf59e199cmr33775022f8f.35.1737736279484;
        Fri, 24 Jan 2025 08:31:19 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb101sm3239490f8f.66.2025.01.24.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:31:18 -0800 (PST)
Sender: Peter Oliver <mavit@mavit.org.uk>
From: Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 50OGVHdP024011
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:31:17 GMT
Received: (from mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) id 50OGVHoY024010;
	Fri, 24 Jan 2025 16:31:17 GMT
To: ps@pks.im
Cc: git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: [PATCH v2 2/2] meson: fix Perl version check for Meson versions before 1.7.0
Date: Fri, 24 Jan 2025 16:30:49 +0000
Message-ID: <20250124163049.23965-3-git@mavit.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124163049.23965-1-git@mavit.org.uk>
References: <20250120160301.121245-1-git@mavit.org.uk>
 <20250124163049.23965-1-git@mavit.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Command `perl --version` says, e.g., “This is perl 5, version 26,
subversion 0 (v5.26.0)”, which older versions of Meson interpret as
version 26.

This will be fixed in Meson 1.7.0, but at the time of writing that isn’t
yet released.

If we run `perl -V:version` we get the unambiguous response
“version='5.26.0';”, but we need at least Meson 1.5.0 to be able to do that.

Signed-off-by: Peter Oliver <git@mavit.org.uk>
---
 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index f01d81b39f..80af578d36 100644
--- a/meson.build
+++ b/meson.build
@@ -755,7 +755,11 @@ endif
 
 # Note that we only set NO_PERL if the Perl features were disabled by the user.
 # It may not be set when we have found Perl, but only use it to run tests.
-perl = find_program('perl', version: '>=5.26.0', dirs: program_path, required: perl_required)
+if meson.version().version_compare('>=1.5.0')
+  perl = find_program('perl', dirs: program_path, required: perl_required, version: '>=5.26.0', version_argument: '-V:version')
+else
+  perl = find_program('perl', dirs: program_path, required: perl_required, version: '>=26')
+endif
 perl_features_enabled = perl.found() and get_option('perl').allowed()
 if perl_features_enabled
   build_options_config.set('NO_PERL', '')
-- 
2.48.1

