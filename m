Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AA38F64E
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552463; cv=none; b=J0wAOQE2QhTxcuDX9rkitT+5A3Yb2UrkDzrekzgnCSDlfshQ3ahRpqgflK440smJ1evEmzVxKGhq8yUIo1SsVbO6wO8AuuzbdkfEbCaTopQ6k+PzxBHo+X6VXBeBh4HHIMOGZhnKon7Ap8SDyMEWqWeIlexruQui6cHYoztxwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552463; c=relaxed/simple;
	bh=7SKQdfPDLQpFjuTS+bUCWEeGQyRwkYdn3i1o5HhdEQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tsv6xYRc9DsyHs1Q9N2UFMSGogeBCOPyeoCihOkqCz0X7KcBuLjfWdOPjlw+dE5O+jSc9xJFfzlnN6b2MkQzgNk+mLWIUmIy7iCP6mhRcnDPF/imxjeLXD5i8YkqZpGkhm3/iwAnApINPyH305qyBSe2cMUu89MTGFGHB1nOQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkIjJXM6; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkIjJXM6"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7439f8837so1291412a34.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774552460; x=1775157260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4XEvXMOdRjiDscRJ1GOImnes437S7rZsTuG9mr3mAs=;
        b=CkIjJXM6e/k6t4YJcH0cgwarfngXdIpyW1CRafRf1EmQbU6PBmiz0gzqLtNfl/xO6k
         srwJVdzvJmeHhu2X+Zf3UV5mla8s9uUlNMBiAjqamx9G4P3/bDxbfr/lrvyqIkoU/OlK
         cW8S8m1W73BiltJ32YxYjTd1e/lJXj2JUbfSoFB3rTRmLyWb/rI9bmDwX/6wTJgVp7lV
         QOyIahwrelhr2FuHiQLcmdEOlPjCtE6EJd1c8/5So23aHeSFxyMUgf9a3QoYZoT0DWFq
         gX4lH6N01QVPzVl+T9221ecCJtxHjRRjfvI6T2ebwmy1ESyHHFuRdp+g0MkQOn37/IaR
         TdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774552460; x=1775157260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4XEvXMOdRjiDscRJ1GOImnes437S7rZsTuG9mr3mAs=;
        b=MaglClhZ4rtjV0UdmQ/h2+W/cfthr6uFBuRNa7ukGCJ7AZBnMJBPehV+ekOAnQiaAY
         fttxEVJ1NsQYD/amCDVtwQv8yL1N7A/3h49qSrBFHX/zBHqZi3VmbtOZhpcwi28splAj
         fTa3BpM0emrxmsAfNvq5m/Bdi++dHxP1s/VUU58ZAKJNfwX8hmslSlMpOUStuqd8mWT8
         l5NYU6ipeKp8JIFCJ6NTbATn+HAgWms1iAVevpaFbYo1FOfoDpD2zBLF/bF4K8f8aaEE
         DKejHo7njqkAyZtkm6JxHvGqalzZux+E4qe/WwwSRn6wn71NwH5/nBrJ/GGw1OjHdzPz
         afVw==
X-Gm-Message-State: AOJu0YxRfuf2vegD0+XYv7lO7kSkNuwd/DLoIk/zG30k8f0HQbsIfeMj
	8OiCys+RSu1XvQ29Env1XibiQ0/xKeD/Kaca0dUGUwSyXZWBrA7Ljv/fNLYyGQ==
X-Gm-Gg: ATEYQzz7rd2qGyAziDLarjpwOAK5nyBM49AQ8eiz7D9b6lynFvRFCauTNXNEZaEUDaP
	DqlVee4p9atPXZfxniBRn8fo7FJ/Y7gmkDGENJwEIPIe6KII55J5nd7bK6n+Bi9uJ5pnKHreQx2
	xkQME1QK2H1L4SWh2QfkPFFPmg+pmqEQk1mVG+XOmNrQaTIKP/YLRZnn8r29y2VfpBQ2v/32fxS
	z6OstB9yAt3LxiHlxl1Fk3+Be170epUfUL9upIgicvt5DsuQ5+IYQ9q6ORWkvL/7D8TPWGmwnHd
	9nuPf8aNHTZfTagMVeXaiQjVKQ3twbl/JOOPe48ThAyAehtNlx/J/MvUN+P0/oepRpeiGDOZaxK
	MlbYFPr1HZBeISbsaCTMK1DmGeAtuevoV11TMvcH7+26Zii8uWgFyVZqTc3L4O0sMGnT9w3NTEB
	4dwrZiIJgVJXWBUhhxTVe0KWTk/sC8DD0=
X-Received: by 2002:a05:6830:3785:b0:7d7:e3d7:e200 with SMTP id 46e09a7af769-7d9ee1ba3dbmr1584875a34.6.1774552460294;
        Thu, 26 Mar 2026 12:14:20 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f5ab2sm2946689a34.18.2026.03.26.12.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:14:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/5] fast-import: extend signed object handling modes
Date: Thu, 26 Mar 2026 14:14:09 -0500
Message-ID: <20260326191414.3783974-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The '--signed-{commits,tags}=<mode>' options for git-fast-import(1)
allow users to configure how signed objects should be handled at time of
import. With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
--signed-commits=<mode>, 2025-11-17) and ee66c793f8 (fast-import: add
mode to sign commits with invalid signatures, 2026-03-12), the
'strip-if-invalid' and 'sign-if-invalid' modes were added for the
'--signed-commits' option only.

This series extends '--signed-commits' by adding an 'abort-if-invalid'
mode which aborts the entire import operation when a commit signature
fails verification. Additionally, the '--signed-tags' option is brought
into parity with '--signed-commits' by supporting equivalent,
'strip-if-invalid', 'sign-if-invalid', and 'abort-if-invalid' modes.

This series is built on top of 1080981ddb (The 19th batch, 2026-03-23)
with ee66c793f8 (fast-import: add mode to sign commits with invalid
signatures, 2026-03-12) merged into it.

Changes since V1:
- Added a prepatory patch which unifies how unsupported signing modes
  are handled for git-fast-export(1). Now they are treated like any
  other unknown signing mode. Unsupported signing modes for
  '--signed-tags' in git-fast-import(1) are left alone because this
  series progressively adds support for all these currently unsupported
  modes.

Thanks,
-Justin

Justin Tobler (5):
  fast-export: check for unsupported signing modes earlier
  fast-import: add 'abort-if-invalid' mode to '--signed-commits=<mode>'
  fast-import: add 'strip-if-invalid' mode to '--signed-tags=<mode>'
  fast-import: add 'sign-if-invalid' mode to '--signed-tags=<mode>'
  fast-import: add 'abort-if-invalid' mode to '--signed-tags=<mode>'

 Documentation/git-fast-import.adoc |   9 ++-
 builtin/fast-export.c              |  15 +---
 builtin/fast-import.c              |  71 ++++++++++++++---
 gpg-interface.c                    |   2 +
 gpg-interface.h                    |   1 +
 t/t9305-fast-import-signatures.sh  |  10 ++-
 t/t9306-fast-import-signed-tags.sh | 118 +++++++++++++++++++++++++++++
 7 files changed, 197 insertions(+), 29 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  1dd316e66c fast-export: check for unsupported signing modes earlier
1:  0e9721fa57 ! 2:  7f34a4ccd5 fast-import: add 'abort-if-invalid' mode to '--signed-commits=<mode>'
    @@ Documentation/git-fast-import.adoc: already trusted to run their own code.
      ~~~~~~~~~~~~~~~~~~~~~
     
      ## builtin/fast-export.c ##
    -@@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
    - 			die(_("encountered signed commit %s; use "
    - 			      "--signed-commits=<mode> to handle it"),
    - 			    oid_to_hex(&commit->object.oid));
    -+		case SIGN_ABORT_IF_INVALID:
    -+			die(_("'abort-if-invalid' is not a valid mode for "
    -+			      "git fast-export with --signed-commits=<mode>"));
    - 		case SIGN_STRIP_IF_INVALID:
    - 			die(_("'strip-if-invalid' is not a valid mode for "
    - 			      "git fast-export with --signed-commits=<mode>"));
    -@@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
    - 				die(_("encountered signed tag %s; use "
    - 				      "--signed-tags=<mode> to handle it"),
    - 				    oid_to_hex(&tag->object.oid));
    -+			case SIGN_ABORT_IF_INVALID:
    -+				die(_("'abort-if-invalid' is not a valid mode for "
    -+				      "git fast-export with --signed-tags=<mode>"));
    - 			case SIGN_STRIP_IF_INVALID:
    - 				die(_("'strip-if-invalid' is not a valid mode for "
    - 				      "git fast-export with --signed-tags=<mode>"));
    +@@ builtin/fast-export.c: static int parse_opt_sign_mode(const struct option *opt,
    + 		return 0;
    + 
    + 	if (parse_sign_mode(arg, val, NULL) || (*val == SIGN_STRIP_IF_INVALID) ||
    +-	    (*val == SIGN_SIGN_IF_INVALID))
    ++	    (*val == SIGN_SIGN_IF_INVALID) || (*val == SIGN_ABORT_IF_INVALID))
    + 		return error(_("unknown %s mode: %s"), opt->long_name, arg);
    + 
    + 	return 0;
     
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: static void handle_signature_if_invalid(struct strbuf *new_data,
2:  18c145c630 = 3:  adc7289213 fast-import: add 'strip-if-invalid' mode to '--signed-tags=<mode>'
3:  58a8216447 = 4:  47ff0060a8 fast-import: add 'sign-if-invalid' mode to '--signed-tags=<mode>'
4:  83476b8971 = 5:  552fea76ca fast-import: add 'abort-if-invalid' mode to '--signed-tags=<mode>'
-- 
2.53.0.381.g628a66ccf6

