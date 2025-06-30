Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4B242D70
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272722; cv=none; b=A9JHeTQ7YYy8a5NFRln8vb+MG/d6TDvaDJ3CjzBAQggTCV5NRmvSSrVM6I3aDvwcklEeRrbwhljoAUGWkDNpAMzmDJ3Epwti+Xa57I0S5746tRubpEI84+Wwwx4coGi1wfSO8H5dGTa87evw3AuGx0xOIXv8HufB2K6xkW3L4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272722; c=relaxed/simple;
	bh=E2IBz7uA3jeKXHwFdsgwLsmI3TSquKoY5C8lyXrNF80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrfGSQlsahsyoIOtqF/xksp1+bZzMfE86NRB+EGiQSAPlyXK9D8310ETq/D3FeO6XmjsRyQofXz7lKitkacYSCcJUXzHiHclv/HlPQASb/BDw9ArwcI66zgchLPBYvNh43DlKelZHVK2YU/xNGGPbob64n1agX35cX3AOCTa9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8yKIvW1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8yKIvW1"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso3738514a12.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272719; x=1751877519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krXDqwDrT2ZdRO1EqGRRYlg4KwGnIknc1a5vh0e8Zl0=;
        b=F8yKIvW19uTtStaAIx5gFUQMUFApDUvjtcPx04G3COmWLX9NO8IEy8c1ri8MSLRPRG
         1/QOMjcOSVo0ta57xLAT0XG1KNsBnMGSzAVxzFC8L0kl5Yw5NC+c9Iqx0Y2jfAkiHOei
         o2bY2Wv+TmPNmuMJCHExCgm6/DLlVHK6RbdK0bdhX4/eOjKL4KlAqOQF+ne8oHG+m4/I
         2MOyWejfIIlonzT9szhbmZRKp2O1G+foft7je3FxZy0G3KTUMG5Kt1MiUtvHY5339pXl
         dYYZMOH3ZY57wsmbM/CrdibHBNPwZj2uB/GKxmmC/VCNAzv4iE9xkseBUgfxSdYM4DMs
         sphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272719; x=1751877519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krXDqwDrT2ZdRO1EqGRRYlg4KwGnIknc1a5vh0e8Zl0=;
        b=TfyDdyj1z/IcnBfQLjcOhkzLBkOMRsuJ6Idrjvj2k2u3FtBkD/0EQXH/bRqmoig1U5
         YI5Mg4Emu1my3TcRgDcugDePGxxHPflTNUKc0HCYXHkEMGBMEiq733DAeaYZxD4PxlNK
         jN7DGSn2CG2NeMmfBlOrOdPQiw5wNp9HQKk/uk4lDLZ48Bo9y908dpEnw6P/ESJKKSDU
         KbOdE13JjBWntp4qP4+eFJX67C7/86DMVYAZd0cxdn6e8m6ZuS8GhmSMUwicYjfol1x5
         qA2Sl+Lrr82+VwdxAR7jYC0zYj5jJlkig+Noyd3DlUs5fjUk5ckPI+ZC26GsuuuCfBWe
         hbCw==
X-Gm-Message-State: AOJu0Yz8Eu9vIOa5pOIOfDERR53GgnfZ1mKBTLRdewdzlYa23GNuoWR8
	JkfiyyD6IOax+X+rmj+HHud8CGXySupIgXuIhTC5NP61FcFV+i64Yfnq
X-Gm-Gg: ASbGncsKJNRdTZtffBkYcpaZEou/T+tYIDtTJp8FauA04u/A93QNqVJn/tQKmEim5ll
	0TIduA5MqoEmhHQlTrrltkU7GN6a2R7kvhElK7vRhlMCt8Gk/Ufw8JQoBqQqJ1G1NRwLH+cMwZz
	bOd6hwOIGdDmnYs5BRWLkLwWgPlqqM9DsaUo89/PPPPuJKyIvpys3j/t/zdbdE9Gj4Ch3Y15r/3
	yjEsMBKbzRuVZzExZ0zAhqj8/+H7PRjgl+39x2zRUliImVFktSkAx9ozWnSIPk+EspZz35xPzWq
	jrruRcZpzKykEKX+yjLaA7T50EDMuxwdA59A74WUQ+Ru9Q==
X-Google-Smtp-Source: AGHT+IFXpiqHrmiNlV1OmJ4e51AG6MOh7Hgo6Ki/oAewQhYI1tO8Vas4Z779QLRp+yZa3e9+3vxxhA==
X-Received: by 2002:a05:6402:3585:b0:5f7:f55a:e5c8 with SMTP id 4fb4d7f45d1cf-60c88dd8cf5mr10221560a12.21.1751272718319;
        Mon, 30 Jun 2025 01:38:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:cab2:9615:a476:665f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60ca83610a1sm3413749a12.12.2025.06.30.01.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:38:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 30 Jun 2025 10:38:22 +0200
Subject: [PATCH v2 3/3] meson: add rule to run 'git clang-format'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com>
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
In-Reply-To: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=E2IBz7uA3jeKXHwFdsgwLsmI3TSquKoY5C8lyXrNF80=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhiTQo6vbwuiP9PK2qWWlw/i5/3fQS25qyeU
 +V5dfbCQN/tDokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoYk0KAAoJED7VnySO
 Rox/gEYL/00OmHfQlvVvwI2ydOamTyvKCEeD7j8Lq6TYPYNFrT/NXB95SwGuK44rwz61Jr+Wi6e
 CeEJOGK9zpRcAMzgycb5AMkCGsGrML2fIbsKeYBQtJx+oSxJTmkjvxzjBonQM4i0KfgrLDzzX7O
 rNyPKkS/sb1aWQzZrQo3ACeV7UvLYtRErPlMNTNrzbyzjToc8uTx4JsioBwTeC1yAXY+D547RVW
 BhsUSSCaDK94Prcj8to3d19pLAF+AXPCO2iSnBwbw8djC1pxWBgsPhk0xYKKjpKrEtDGaRWW10A
 xgtwbe/KRL1SzZpiHRJaSJh1wx7doCqcYnyxVNaOgYMYGF/r+QU28WQJe9UL8SkdDp/O5LDytih
 LeRH1pahyr8678IxzPv8gtCqe7NV9NGclx8xZVQtUPqPNyMifh2KT42UfN9rW2TGEbRKSM0JtFC
 3KwpZ60V6p4RLgXsXAWq1CKD5oWagitcRloisVsTaFZeCV2M3FgMPARj6VzbEmBd1MCGUNlDox4
 vg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Makefile has a 'style' rule to run 'git clang-format'. While Meson
intrinsically supports a 'clang-format' target, which can be run when
using the ninja backend by running 'ninja clang-format', this runs the
formatting on all existing files.

Our Meson build doesn't yet support a way to run 'git clang-format',
which runs the formatter between the working directory and commit
provided. Add a new 'style' target to Meson to mimic the target in the
Makefile.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 meson.build | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/meson.build b/meson.build
index 7fea4a34d6..20ce0525a1 100644
--- a/meson.build
+++ b/meson.build
@@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
   alias_target('check-headers', hdr_check)
 endif
 
+git_clang_format = find_program('git-clang-format', required: false)
+if git_clang_format.found()
+  run_target('style',
+    command: [
+      'git', 'clang-format',
+      '--style', 'file',
+      '--diff',
+      '--extensions', 'c,h'
+    ]
+  )
+endif
+
 foreach key, value : {
   'DIFF': diff.full_path(),
   'GIT_SOURCE_DIR': meson.project_source_root(),

-- 
2.49.0

