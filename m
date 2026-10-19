Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A348596EB9
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420737; cv=none; b=djHZyXDnGdf09Jp8N/Pe5ZqoXn8/MXPOZBeJU1c9AjVseLDwOhw7un5Ww+B9hJCjTmKJexppQ9vqTEYb8/qLBFMNnpYZPk+PcFsmfhwLBLlSXCaHAuNQNGHMmUN86KLPxHSjSvoWx9dZ8YiXFbD88gsMyOSZcDS6dpJRzxdMcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420737; c=relaxed/simple;
	bh=P9dUc9S9UiC52/RH8Na1egy3p1LtaAFcTUyevKbqptU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEhYN0+6Dac4jCIn8c9YdFmWuqrfJMTOBuihSbTHdeFUk8gzLe1cF4AV+Ei69icEEUE16u9eOuzl6OyiIk8xc6ZlR+9wMJ2mQn7x4QHUnMI0DxXGTU7UFUnxIxuf0FnY4s7agZKGPiuKKm8Fv3mF+vGNq4cRkHkeYVpRqFK/OeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br9Xx445; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br9Xx445"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so2615424a12.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420734; x=1793025534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2AeqERtwf4mjNs+j5GlYlOzGrv2a7gwUoV0xLMz35d8=;
        b=br9Xx445NtRgVri13JqkLtW3CaEUHCEDGUBHeYe1Xv+mNQAWLQ1DX/kVrEXz3+DTNw
         lh2OSBdkq7tXYzid+emgsrK0CTqyTjAbuC/aYL1xI54+IjHIJhyk2m+9Evxk3tJd2oo5
         Y/94GThViC+f9GPah36oxaJPUzDaP0hmeIgbbTZ7aBcZ0Bpvmwu8DsvMoZjiHjvSSBBS
         XntDVNN7CM0/E7FcFiG9cU/2PGD+DgnPp66PE5hJnNcGFeA27Dm/rvpUzqjQoeL1M5Gb
         6vxsP655gd9F5RrZOAVYWa0XODFHu2f3te1zRDGtSse54/E0IHG1dH49DncVmw89f2dE
         bAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420734; x=1793025534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AeqERtwf4mjNs+j5GlYlOzGrv2a7gwUoV0xLMz35d8=;
        b=BpctaXdTSQN8NzDjZSSsfuxyascS8joDPCyXZ70PzwKB4207eD1ygLxFo23AFRmSeb
         MgFIHyxq2syRBTRjYx06ahEHLUtU6S5y3vIM47aa8ijpG9vg0lvOgtLZgUp5zdpOsf7a
         8ODwMEwCqaY/xKdSm436wbpXq5DGtyawzL4liD4fTuHGMiwP8qoeptIM9p8zMu+UD9Iu
         s/GbOVq/2dgSSlkuqhvsR+QsjVvniiTEbiQmGyS9kVZn+9xYrkhXJf2nuNjF693zN77/
         UTRjYyYaJsMGwH9ffJ7d+MY0Nrm/cVE5BDbzqwQAPT5BtnKMU07OBOHxJurFDWPWgdu/
         KJJg==
X-Gm-Message-State: AFq9FYJS7+uUrrs+vdNZ7J0eJ2WxIeTzf0TPMEtcyA29wejiFb7OmUPD
	gA0O5bn8RXp5DmKyzsg534YYpt2vdm3RmCLUbh2dnAkYW/cqaY74p6HVvNcM6hXhmjiIMQ==
X-Gm-Gg: AYBFou08nfheooGq7jwjop4c/ly2nYGr7Q/ye7zVVESzVYNys8MWRPkom/vGaHPa9uK
	7GG4La3vc71d7t4PJHm0SpNdvsvAQhK7MLQb7i2snAg/fb6z+BJhOi/lg0jZYRhWqHNYoQDl+EB
	B42pQLeqtPk/WpK7zXhJIwOyrtkbiFf3ihfsKViz6Um2ew4AvK2Oksn/C/nbyq5iv/G9VGIYBsx
	ohiEWAE3y54ZcmycKbtNrrCgBHnpFuqCMjgoQZ8CvZu/eBOcyLPf78Xrnm6pRQKT1m02D7um+mh
	CE4sPd117u/vrgVLAXRGnreuyx7MQgPxAgNqnKupZbJd+VanuqPzX3IS10tbJOmrXhCUu2RuRsS
	ig5aT5i4LaxZh/4omi84gI2EEkstAH1DDH2Nadu4oH0JsIzpGDDopVbvXL8gqRmwin4R0iqlF+0
	qbBnzBF96dIRTmMs2QPjoAFqGvn8c5ybvjXQlQqq0HD/ps7f3PYDNYVMhwXsI7yc/Gu2mbt54=
X-Received: by 2002:a17:907:868a:b0:c40:aa04:18d0 with SMTP id a640c23a62f3a-c419da41336mr500098366b.17.1792420733377;
        Mon, 19 Oct 2026 07:38:53 -0700 (PDT)
Received: from omris-tuxedo ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dd1130sm374484466b.25.2026.10.19.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:38:52 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: git@vger.kernel.org
Cc: Omri Sarig <omri.sarig13@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Julia Evans <julia@jvns.ca>,
	Li Chen <me@linux.beauty>
Subject: [PATCH v2] doc: git-rebase: Update incompatible options
Date: Mon, 19 Oct 2026 16:35:45 +0200
Message-ID: <20261019143546.207295-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several options in the rebase man page link to the "INCOMPATIBLE
OPTIONS" section when the option is no-longer incompatible with any
other option.

- Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
  incompatible opts, 2023-01-25) removed "--allow-empty-message" from
  the INCOMPATIBLE OPTIONS section, but did not remove the link to that
  section from the option description.
- Commit a74b35081c (rebase: drop support for `--preserve-merges`,
  2021-09-07) removed the `--preserve-merges` option from rebase, which
  removes all incompatbiilty references to `--ignore-date,
  --reset-author-date` and `--signoff`.

Additionally, `--onto` doesn't link to the INCOMPATIBLE OPTIONS section, even
though it is incompatible with `--keep-base`.

Update the description of these option, to have correct references to
the INCOMPATIBLE OPTIONS section.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---

Changes in V2:
- Update commit message per the review comments from Phillip (Thanks for the
  review!).
- Add `--onto` to INCOMPATIEBLE OPTIONS.

I was not sure if both adding INCOMPATIBLE OPTIONS (--onto) and removing them
(the other flags) belong in the same commit, or in 2 separate commits. These
changes felt small enough to me to not require a second commit, but please let
me know if it's preferred. I'll happily send a new patch where these changes
are split across different commits.

 Documentation/git-rebase.adoc | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6536ebdc90..6363b1a096 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -218,6 +218,8 @@ OPTIONS
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
++
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 See <<TRANSPLANTING,TRANSPLANTING A TOPIC BRANCH WITH --ONTO>>
 above for examples.
@@ -334,8 +336,6 @@ See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 	and this option would override that behavior, allowing commits
 	with empty messages to be rebased.  Now commits with an empty
 	message do not cause rebasing to halt.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -m::
 --merge::
@@ -489,15 +489,11 @@ applying (in terms of the author date).
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --signoff::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed

Range-diff against v1:
1:  27c94f5ff4 = 1:  27c94f5ff4 doc: git-rebase: Update incompatible options
