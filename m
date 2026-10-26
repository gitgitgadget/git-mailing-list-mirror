Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003723;
	b=1yWhGGZPQcbnAEv9zSA2eef6dD3v1WoNG13ApxWFOGWY5KEPrUZ6qTiZLAzYLxd2Y3cl
	 PfbVCxztohO2sUpS9xESkGy2E0c6EOLiRqf5lYa2oxx7koGbUsFlIocGsybgENnrvaxp8
	 afTMGVtMybmnETPdnkHuRq4cck98rhyOL1gxK+sXOD1aPo/ky0hfL1KOtx+nihdZbnHOD
	 YhhlGrLAZZzNIRRXUCJEW4bLOmQoEJRACq0FaPjjJd/viw70o7RhmKVpzV1eqgQWGt73S
	 7vFVS9LZa+/A72J95thKxKoQ2ZRfM1tqnlweF5q6Fa498+cNw3n3uSB068o0Hh8jyRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5UejlZU6ZGv6wFOZIdLwc0cmbg1ulws0Y3doh33b+L0=;
	b=kn5r/AkqoYeJNPvB8on4HoLJpw+WxJHU12+XeyhOmakeS6ZLlRwhFCLXnoD4Pu5TT5Nb
	 S4RPROagUXeGvUM0o95tXbp4U2AscAlk1UxwvUQu1dd6FF74cUwH0tAyOF7bcHe17ciBd
	 3WkxH1XzzFuq4LV50PtTYGMLLaHzRRrFoIs6RMIQrpbr3POhw41c+MwUj/OuS+0HaZKyu
	 qxWfOLtkGWhnJE2L19P9Z8m8JWVaxjk5kBhykV370JDOVpAAPL2Ddm3MiOIN2uqCrAW+Z
	 CxheHX2d+0EIiQnKMwllFNUy5kOAS8+opNMQArBv/OJJzbArmnuSlUVB0LO89fowAxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jnm+VoUu;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3B606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F3B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jnm+VoUu
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so16584175e9.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003721; x=1793608521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UejlZU6ZGv6wFOZIdLwc0cmbg1ulws0Y3doh33b+L0=;
        b=Jnm+VoUunQwWN5/tw9SW3wA4p9xTvB5cvfkwqv+h9GxKB16slle7cBBr/1FWVe1XCj
         uEYtdFb7guhzmhEGHePOppJcwzTgmwsX/Q5IE026y4FOcMBeUhHHI3EAVtVM604e3hS/
         RcJzRt8UAaIeMNMJunISslX9x7KChvllqKJKk9IA2BwptYGjS1sthtjHg27dslE8QrcA
         hI9UiwkqjN6+bG/pz1AoA/PeTn+H7k8Rx3GwkEXFaDW3VoWfzuwZzslcvp9ZelJvZ1I0
         k4vFY8V2kuocyQI0bi2CB7m2Hu00m/1xEthAAgbTIFJhfOSWt5jQWO/rpZjKYHnMJofR
         BoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003721; x=1793608521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5UejlZU6ZGv6wFOZIdLwc0cmbg1ulws0Y3doh33b+L0=;
        b=H4rnq4bqr/xYNPwfgxPMFmfj1K9H38xiwJ0yuY3I78MXu4i8snkcTpVqlahCj5v3wd
         MSn8QMxQf/63hOvYKeKf3Rm3/fh66WrtBlKlj2930Z98GSOHp162K69+q6R4dsrh4vrI
         sSViPyGKpUBtuF/wTmJBTINDK9B4obVpspa5k35uO0Z6O4hPQJAcSzLajF5vHsH/SyPa
         nRP1Op/dCAfZTiOtPjPULUDlWWoTAljPqMgqXzSFnl6tMGzo/lf5QOyCOtcIkYn51/TC
         TAk9Z0cS+QDF7nY1pEUdxTVgYlgw/vWiG4zLjRTiFkGDrl2ok1M8AxmgpL40SuOh8bQA
         Iinw==
X-Gm-Message-State: AFq9FYJAv09SaSxwnGxSVpNWtW2wI4yfYtMWIUneYFkYSxR1i6yJ3a5P
	ZSgH7YoIek97Pxx6F4B5o7Gp0m+nF+nwlaTXbJSeoaoP8Y0TNnbEJpLb287tjq6H
X-Gm-Gg: AYBFou1yBqG7/CEHgAszXNceAg1Jx4VTKmhhA/8//soekQrS0j3dQh2+TiEOtWu/q9T
	C3WRk935Nz3rLAPaBFOemlriF4plwApRBCsBx9e10/CWPPzAde2W66LtSKeCGFZLzkp9gQX1EHJ
	7DXL3gQKcpow8LnqrUWTD3NrMRHObP7/AMq1b5ieUkDlIhvDDMOo+Ie9H5R0Qlt1qOx4dNLeedj
	SPAzWeYlLEmzT/M50qt/EjrNZw04VxAUzsJTBk+ffNpt9NFnTRFfrROMD5NqU/YvlplCvr9d2m6
	QmiFnWHPR89rAGGa5Nc2DEmstGTI2YPFs9yJUNKapwQdhaxULDbluIdkQKOQjcQr6MpKN+rwoVh
	drqoP/XPKKPNuEEvMn/B7C5hmtVZva/qPLAzqAZnV3iPJFHSgx4HQP81TQCkg9wm8pPlHQEwdMd
	+c6aK/RriPOkBaqf7oQVgShyo04jZ1L1QkVaQDa5hg8Qo53zftxh5pJ/R14LweCRV+p7GdYe57O
	tbfsCzJUzRoi9JzbK2j/apiUdKoMkgQ0jzwRwck/6DUXY2/41IGcjwMN+eUt2scR43sQhSh5TK4
	VeIKtl/dPAqmCYc=
X-Received: by 2002:a05:600c:c16b:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a35aae873dmr110595205e9.0.1793003720691;
        Mon, 26 Oct 2026 01:35:20 -0700 (PDT)
Received: from zito.localdomain ([102.88.168.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fbb725sm177475635e9.0.2026.10.26.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:35:20 -0700 (PDT)
From: Azuama Odinaka Maximus <azuama69@gmail.com>
To: git@vger.kernel.org
Cc: azuama69@gmail.com
Subject: [PATCH v3] rev-list: skip --grep argument in early scan
Date: Mon, 26 Oct 2026 09:30:54 +0100
Message-ID: <20261026083055.18873-1-azuama69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021172458.6373-1-azuama69@gmail.com>
References: <20261021172458.6373-1-azuama69@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The early option scan in rev-list does not account for options
that take a separate argument. As a result, a pattern passed to
--grep can be mistaken for another option.

Skip the argument to --grep so that it is not interpreted as an
option during the early scan.

The tests check that patterns beginning with "--" are actually
matched by --grep, including when the pattern resembles an option
that the early scan handles specially.

Signed-off-by: Azuama Odinaka Maximus <azuama69@gmail.com>
---
Changes in v3:
- Improve both regression tests to verify that --grep matches the
  expected commit when its pattern begins with "--".
- Add a blank line between the tests.

 builtin/rev-list.c          |  2 ++
 t/t6022-rev-list-missing.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0faa833fac..453d82d25c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -771,6 +771,8 @@ int cmd_rev_list(int argc,
 			revs.exclude_promisor_objects = 1;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
+		} else if (!strcmp(arg, "--grep")) {
+			i++;
 		} else if (!strcmp(arg, "--missing-only")) {
 			arg_missing_only = 1;
 		} else if (!strcmp(arg, "-z")) {
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 1bd2c3bc4f..3757bde708 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -215,6 +215,26 @@ do
 	'
 done
 
+test_expect_success "--grep accepts a pattern beginning with --" '
+        test_commit --no-tag --missing-only &&
+        commit=$(git rev-parse HEAD) &&
+        echo "$commit" >expect &&
+        git rev-list --grep=--missing-only HEAD >actual &&
+        test_cmp expect actual &&
+        git rev-list --grep --missing-only HEAD >actual &&
+        test_cmp expect actual
+'
+
+test_expect_success "--grep does not trigger --exclude-promisor-objects in early scan" '
+        test_commit --no-tag --exclude-promisor-objects &&
+        commit=$(git rev-parse HEAD) &&
+        echo "$commit" >expect &&
+        git rev-list --grep=--exclude-promisor-objects --missing=print HEAD >actual &&
+        test_cmp expect actual &&
+        git rev-list --grep --exclude-promisor-objects --missing=print HEAD >actual &&
+        test_cmp expect actual
+'
+
 test_expect_success "--missing-only requires --missing=print or --missing=print-info" '
 	test_must_fail git rev-list --missing-only --objects HEAD 2>err &&
 	test_grep "requires --missing=print" err
-- 
2.53.0

