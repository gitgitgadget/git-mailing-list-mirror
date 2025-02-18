Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB426BD92
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892669; cv=none; b=pd1A9MUftICjIGGp9liZUEkhGJULlx+iImxdbsSQyBy/JpCXv4K1LefXkgZl9GgVkDfSC1FPZ+NEsPj+DDb62FVngwBXnBLv67oJdQQExjGocKQFhlaOUmeha26NIv5sYIzBtbx4T1psPN/CEvFRlNUX3fOk9BVsCJbeL0vncvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892669; c=relaxed/simple;
	bh=uTfgEAqTydZsnQEivvmLsy1Zg0yhOncLuhAxzj1pjFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ehe5EdQ6DVLJJn+JMo92AtsMj/d3/cLiJnfhly0Bm6BEd5QHM6qkZM1IVvMNwgiXfoLjLSI1RRN4t2bE5ICb8CXwY/HUJV+QpzVc3DOpz74Ga63MPABChhoekZhDxXla8tZbVLkVZjRr82+SOZNkNxeXYMzjyfzOmXpiIUPRi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=VA8VBdqB; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="VA8VBdqB"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43948021a45so58192685e9.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1739892664; x=1740497464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+GJNV9LdvaRHgPwaWUAij7MYLRlFZ7EH2pvr05khus=;
        b=VA8VBdqB6yf+ONcRCY44KKaS/KXq3EpL7gJnTNwj2TbuUAH39vj0Fgn9ihiEqX6IT2
         X2C2qkR5GJpJhfH5IoQizDFw6iDuPD2hovYqukR5aoWYc8cE5ej1IED+JwLz8Mfgk49a
         h838SXdeQQKDKke+wLCaMjJnzErT0TxllXQ/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892664; x=1740497464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+GJNV9LdvaRHgPwaWUAij7MYLRlFZ7EH2pvr05khus=;
        b=rfpFs8eKnDb/61AN9R+q+xyyw3+WZv6X1WhKjbMeQOgl5WcCdVcG1CRsDqiqz/8SWE
         N1PDY4wQm1nt78ayb+UWKq+Uc5eJXae5lJAfe1vF59iqvJPqc0CFDyS9g6KqtQsXKxh8
         ImSdqc97fpoU1pElBOnxS/c/3Am6TPKTeB128/nMABaqniLQKfa5rgiXbz6B44CPCTDW
         O7DrS0yysM9apV/dMBLqqHSLY/Z2bcaZX9++N3mvIdM5sUHmDyckK3Litao+MkWrQ/5E
         14jIgasjFTzbPAG1FkMN2RmA1hgD8dEWa6tUPuXDiWC6A3Ydu6T2rvWPdyAkkOb6wmhI
         4yoA==
X-Forwarded-Encrypted: i=1; AJvYcCV8lruFfcSPKv46C5lZfy9eCKEAa1bUtdPjBrKvsg7qXNsqox6B82LH/aLXVh6y420OjNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRaLE8Py7ct4tk7dsmv4ZstBKzjVM42HbSN8wrNabr9mFwDVhR
	y+sNwAF82epMXZUHF/s5kbd0teP7mCK96IDl88BXD3V0PC78LOJxC7MKdl0gQBgOQREJCB0vnwP
	+YPfBkZ0=
X-Gm-Gg: ASbGnctCcSkuUHnzoBdkof8f1YT1YiPu14Dm25jrhwYQijHcx2HTnbSAAKk751F65JA
	HbruOHukoTOFQyJsFYce3DjEiUxUw56glFYiHqqDDngkYQd1XotWJUX3FklnxeZeUxZziwjybVk
	NxpGJ6Iqo0uQU8mQCNpRZblYAO3Sca+W0G9b5taGamZ0y7wXY6W3+OawgQ++R+ldLp/gQwcxqre
	rmTtgQXtxg/eKv3WXYwtheLaRSF2LZy86jKFUDcEFazlXNEYyAgPrRoAdhHt4O9JA80jgdokRix
	4d8lWoR8jaYFNg+xU0/Boa37KXCEn7vJZOXXguYqlq97lY2BownHFY2WmZvDurFP2o1wJg4IoEc
	/Kmuvi+34JnBlpR3/g8U=
X-Google-Smtp-Source: AGHT+IFWnhEggEymln70sV06CsmDWOLYLIDFhR/f2jtyKllX3dFFAE4Z24/IGmDmdLvke/SUPofDiw==
X-Received: by 2002:a5d:6d8c:0:b0:38f:394f:d8c with SMTP id ffacd0b85a97d-38f394f9cc5mr11683026f8f.33.1739892664140;
        Tue, 18 Feb 2025 07:31:04 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8217sm15531774f8f.90.2025.02.18.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 07:31:03 -0800 (PST)
Sender: Peter Oliver <mavit@mavit.org.uk>
From: Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 51IFV2WS063564
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 15:31:02 GMT
Received: (from mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) id 51IFV2PL063563;
	Tue, 18 Feb 2025 15:31:02 GMT
To: gitster@pobox.com
Cc: ps@pks.im, git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: [PATCH v3 2/2] meson: fix Perl version check for Meson versions before 1.7.0
Date: Tue, 18 Feb 2025 15:30:43 +0000
Message-ID: <20250218153043.63535-3-git@mavit.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218153043.63535-1-git@mavit.org.uk>
References: <Z5c4OzzHWOo30Hu6@pks.im>
 <20250218153043.63535-1-git@mavit.org.uk>
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

Note that Perl are seriously considering dropping the leading 5 entirely
in the near future (https://perl.github.io/PPCs/ppc0025-perl-version/),
but that shouldn’t affect us.

Signed-off-by: Peter Oliver <git@mavit.org.uk>
Co-authored-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index f01d81b39f..fd19d348c6 100644
--- a/meson.build
+++ b/meson.build
@@ -755,7 +755,22 @@ endif
 
 # Note that we only set NO_PERL if the Perl features were disabled by the user.
 # It may not be set when we have found Perl, but only use it to run tests.
-perl = find_program('perl', version: '>=5.26.0', dirs: program_path, required: perl_required)
+#
+# At the time of writing, executing `perl --version` results in a string
+# similar to the following output:
+#
+#     This is perl 5, version 40, subversion 0 (v5.40.0) built for x86_64-linux-thread-multi
+#
+# Meson picks up the "40" as version number instead of using "v5.40.0"
+# due to the regular expression it uses. This got fixed in Meson 1.7.0,
+# but meanwhile we have to either use `-V:version` instead of `--version`,
+# which we can do starting with Meson 1.5.0 and newer, or we have to
+# match against the minor version.
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

