Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA12184547
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050689; cv=none; b=cjxOScSBQJwpW5RbYlHhJma9lEgG8/Ppn6+LpJTyY2BooEjWDcA1IDxPqZOXDl6q1AN+Lqc50v9cKGl6eJntRcoW29Nc97FhY9VuhPTcAf+VyPzMMuWZd97A3S2F9f2zKtICv7fumLNUjaQpOLYkPzdoz1tL0gL2S3jzWfCGdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050689; c=relaxed/simple;
	bh=Am++b4Ca1iMRDF2e2Z/zEP5fyfCTP8LABGo7lO31ihY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1wBNuylEYTZk7enp0AZIeRpbNqxkcYgG1QnhKuJ3l8mgwN9ERlT/b+Ir/PcTejNMWRGlSQrcBJ1Q2hmgEfnzckipel6COe16fpJhYg3OXgte/qV7v9xJePY37gJmpD+PpQtxF66TIrPc4vtzF8t63y2SOZoD8mkMEmsqsuoW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR14JU89; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR14JU89"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75d044201so7308641fa.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726050685; x=1726655485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOEuk0AgbYmXu6mSU/a6aI1cHpOl976ONyPQaRXfVC8=;
        b=TR14JU897nepnkA8fI7eKPpYexTy3EXN7NjffTt6YcsZFMdTURVijDro499/OGAs8V
         IRyinWN9p7TaedgXNZEqmodryeGgoBQFQS62xFslcACGJD9Gjcg5oceWE1lyj3pBscJE
         Db4r/pknXwkze+LUBbxw/4GDvJ0zuLB0NxN3myhAHKzgOE3/m4lW1ZaUSCwHoJ9+eMfl
         PiWqIU4eLOFjl328OHuiipyYAeNrB/SXoKaCFh02rAsG3bWk+40+ZEmMAvjA656UDR3j
         6H+RQFZhaTEPKBIGjfNsnqg6Dp8d85Nl7guKq5ElXmU18MMlidColdu7SY93cmYysxhq
         VzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050685; x=1726655485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOEuk0AgbYmXu6mSU/a6aI1cHpOl976ONyPQaRXfVC8=;
        b=HGw3K1rheBvcGw63/RZssUzqDiFGpNP/dc3guYW3dGBGSynRIHJkqwFs/rJ/5yEiRt
         6X8eGxBOworh6VMajhFN8qIjCKo86c+/kAFtRIcdU0z4b8nIejTcYAbyD6ZPIINLq37c
         g67rd1QrJlQ6yUbFKsT4ZECQJw/5PzmaULeyh8H+hs8f33N20IACBAir5Zd6F+FOEeI+
         N2BjeGcslmYldakP/RKWBsE4ZG2Z5sl+bJt0eUuqvsX1sQtVQPAgBDKUTXv59Wuok7AV
         LwT9dibKsKZDGCPWqkF31AGgyHel9poX9a64Yg5+Gb2sYmXUM5JgtbEWoSLKkuSk8Ykg
         Vo1Q==
X-Gm-Message-State: AOJu0Yxg5rTHGz6hFbrcuOP9wVjyD0z5xho1yVCnDVDO408RKx8Ksfgz
	zaRYhyZ2Qf7DVh+EX74GrtW2zmE99rzCqlAw+hCJulBgjszgWANmkGxY1g==
X-Google-Smtp-Source: AGHT+IE2uoDG46bCIZZ8eIFkYTpOLoGeH6S4vCLeTX6j3kacuwvFOFreqUkhfiA/iFO5ebrl3jYASQ==
X-Received: by 2002:a05:651c:503:b0:2ef:2843:4135 with SMTP id 38308e7fff4ca-2f7726fb3edmr21248991fa.22.1726050685216;
        Wed, 11 Sep 2024 03:31:25 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c07c81bsm14853871fa.76.2024.09.11.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:31:24 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Jeff Hostetler <jeffhostetler@github.com>
Subject: [PATCH 2/2] t0211: add missing LIBCURL prereq
Date: Wed, 11 Sep 2024 12:31:00 +0200
Message-ID: <4f749b283be03e11af30e6ad14909c22834dc3e5.1726049108.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.46.0.733.g1eb83ef1a1
In-Reply-To: <cover.1726049108.git.martin.agren@gmail.com>
References: <cover.1726049108.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After building Git with NO_LIBCURL, we're lacking `git remote-http` and
`git http-fetch`, so when we test that they trace as they should, we're
bound to fail. Add the LIBCURL prereq to those tests.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 This is from around 6111252cbf (trace2: emit 'def_param' set with
 'cmd_name' event, 2024-03-07), which first appeared in 2.45.0.

 t/t0211-trace2-perf.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 070fe7a5da..dddc130560 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -337,7 +337,8 @@ test_expect_success 'expect def_params for query command' '
 # remote-curl.c rather than git.c.  Confirm that we get def_param
 # events from both layers.
 #
-test_expect_success 'expect def_params for remote-curl and _run_dashed_' '
+test_expect_success LIBCURL \
+		'expect def_params for remote-curl and _run_dashed_' '
 	test_when_finished "rm prop.perf actual" &&
 
 	test_config_global "trace2.configParams" "cfg.prop.*" &&
@@ -366,7 +367,8 @@ test_expect_success 'expect def_params for remote-curl and _run_dashed_' '
 # an executable built from http-fetch.c.  Confirm that we get
 # def_param events from both layers.
 #
-test_expect_success 'expect def_params for http-fetch and _run_dashed_' '
+test_expect_success LIBCURL \
+		'expect def_params for http-fetch and _run_dashed_' '
 	test_when_finished "rm prop.perf actual" &&
 
 	test_config_global "trace2.configParams" "cfg.prop.*" &&
-- 
2.46.0.733.g1eb83ef1a1

