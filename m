Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99F158853
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736279; cv=none; b=G6R6KNa2foYLW/O5wfXMZTa4Ob5au6cawwe3D+BLOti0hJ/0KgPutN1vumB14G+Eo2STpK6rpVJoeBDU6laWGD7VsL/jUYkiEAQvg0/ULuZZI1vriGaEoRd4zYaSuQE14wqTB1n0X/N4nmCAKDlBa0S2WlekzORtGzN/mVRsEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736279; c=relaxed/simple;
	bh=CZDIN2iNT+5J0K3ClvIWFNi8uzZqiggQO34mgSuOARc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncFM0a8dGvgJ/gmhcsLrLhQv03NeZa0DXczpzI8lc+FNyAFbCvey67aCvRXZ8SNj21jMDBHAqaLaDBhxODwI8K2BEvHPUNV7nUBm9AwSt6+YfBifmys1N2peBxU0G8WgNmxCFnk9cGPbDIlORzVVkgnnC1QcyTIn/tHHcSajvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=V9Ba8Itd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="V9Ba8Itd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361f796586so24611865e9.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1737736276; x=1738341076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOjmoujGXrNSarW+M+IiCievIUP8NBhJv073C7H5pD0=;
        b=V9Ba8Itd8Tz7mcBKy5WmYMKlRiPZPGPXraq/TAOTsQFbQLOOg6SP0175/zFYdCa3TL
         m3c+5bzyD+B3TxA4CS1WdyQRs5wI++4sUaxOokXgPyYm7JDX6snuPwKpmAKveUZz4Yow
         XlSlFIgmGPW8dqPOMT+K8IiA1YB131fVPrHQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737736276; x=1738341076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOjmoujGXrNSarW+M+IiCievIUP8NBhJv073C7H5pD0=;
        b=PElk/KFpB1mH18VX+YHl9t7XacJtZa7qwFo8rGMB9J3JYc9hO07cbT1oa9veRpsOpd
         zEgKcyA3FzY8gTJw+TLXsDa/lHCbfmPpDTjrBBQPPMTGMIgKpZivaeFfI2RG+IYU1hK/
         U3jTSxNao+PbZr59/B71SVejJFEeLyC0ih87ib4wYaUZIIgcTRLq+u9mG5BnJSAZADAx
         9aRVxJv8c5M4M/5u6FtOphn4nC9ou1i4Pe2kgXe5cmT7BdwwhP9nuXFSiC+YBijX8xLf
         CKoHYMZ1jWwyIXwbbMMkeiEUp+teoU3ec1I5MzSm64plZpQe2ZdMm4JvQ3PJKawiYYcV
         Xa1g==
X-Gm-Message-State: AOJu0Ywmu1gSqw72WChSdhZyZHH6gUxPdEywf1jz4TPPFwuggiHH1gEn
	vqq/mQxNiZ+6n4tCNEhZG8+QQfM3xg9K07rGSlecm/bOgprovZu8X0DfXA4cee3seM+hwCiJsIN
	A+w==
X-Gm-Gg: ASbGncu6kjTfZ2FTj8wumD2FMlm6+v/26+i7sj5to66CuuOFtU3l/UNtFvyEPi027BX
	ELr1IlJRNN9onEfX6x3NwuzyhnImZkfdlW5gE2izwjetTS0Gj3MMpe0hPgTUVE0Ivr53Nd3qtwc
	ePqwvkXEzVREsKq12p9R/hjXvFY70G4GX4bNzX2rZL90rxpeCuYS8xkBmjK/krZ6noh1VbekmeE
	l6dLPUSPLmVPP5zWdsi1+TKf9pvofCOwzlePJJsu/Nmd+//h8HzGOTpUbb9wUcsA0i9dAtVLCuV
	jY6Ldh3pAhmhZwregBkxPsFlTUAzJI1KeWiolnE7myG4VWWYPhIS1LP+5sYrvhPGjZwzpVPowck
	EsD5QuEEU
X-Google-Smtp-Source: AGHT+IFBVepAFAmaExP8GawPAJYmeFLep0wFShKA90NoaR/Mv09dzApKOB4ZvPEwyseQhzJFgft6RQ==
X-Received: by 2002:a05:6000:1786:b0:385:d7f9:f16c with SMTP id ffacd0b85a97d-38bf57be11bmr32946586f8f.46.1737736275801;
        Fri, 24 Jan 2025 08:31:15 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb040sm3153332f8f.67.2025.01.24.08.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:31:14 -0800 (PST)
Sender: Peter Oliver <mavit@mavit.org.uk>
From: Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 50OGVDLn024007
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:31:13 GMT
Received: (from mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) id 50OGVDmw024006;
	Fri, 24 Jan 2025 16:31:13 GMT
To: ps@pks.im
Cc: git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: [PATCH v2 1/2] meson: bump minimum required Perl version to 5.26.0
Date: Fri, 24 Jan 2025 16:30:48 +0000
Message-ID: <20250124163049.23965-2-git@mavit.org.uk>
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
Content-Transfer-Encoding: 8bit

Commit 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) dropped support
for Perl versions older than 5.26.0. The Meson build system, which
has been developed in parallel to that commit, hasn't been bumped
accordingly and thus still requires Perl 5.8.1 or newer.

Fix this by requiring Perl 5.26.0 or newer with Meson.

Signed-off-by: Peter Oliver <git@mavit.org.uk>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0064eb64f5..f01d81b39f 100644
--- a/meson.build
+++ b/meson.build
@@ -755,7 +755,7 @@ endif
 
 # Note that we only set NO_PERL if the Perl features were disabled by the user.
 # It may not be set when we have found Perl, but only use it to run tests.
-perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required)
+perl = find_program('perl', version: '>=5.26.0', dirs: program_path, required: perl_required)
 perl_features_enabled = perl.found() and get_option('perl').allowed()
 if perl_features_enabled
   build_options_config.set('NO_PERL', '')
-- 
2.48.1

