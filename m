Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395EC770FC
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488120; cv=none; b=YcVuclKRRJoWRPcbNBdW0pWYRk50uQ19KLTJGUjaV/6oqj970+W12KxeWmAWmQ6wlOafv13FnPnt+KHbpghEIQvRBYufpmffwFk2UC3glqUlJnymxY74M8BBtDAvidn+UmgsWAvUbhmz0glaxB1LGVUAtPvvnFE44gOFGokJS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488120; c=relaxed/simple;
	bh=cHc1WhcLM8hiD+OQ21qivhS9RH4j6GRWd9ejQYVwS0g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CuuVbYNJMXv3xxXvjlyHtEQick7Fcj44XK1u3YhshJdztX9NwRLYcW+GpiNGnpxTulSHDmMFK9aTcIsNEZtTbtIQXDBO71AEoPCSN9u1LN6POh4q+gkLv+z1oUYDrxd7jyHk9fGDiRUqMMyQOofV3sbOiMFd9sVFFNeFhWRpqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei6fWy4z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei6fWy4z"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso29766835e9.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488117; x=1715092917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5jOy9jd0xiROoe/7MwouFpHnIdHgx2Cz93tn+PNioE=;
        b=Ei6fWy4zX/1GP6X6Qgp3QZs/e7F1XeKUuKSJjrWlMaGtsQcXpzzSQ5nDM4WG2WFkTr
         G9DnkSTVEPQrHZ6qoBHSH5uXIPFQERM2Y0Pi/XDlNxY77w+JmUwBo5mEq944BRzcrewq
         Gy+ixYq/6Cm4Qu5nKrD5CGcwQDa+pEL0QK7Z6GGHQJOsGP8sqofCDsiQnHR3a1H+4zyy
         vF8qyoDxpc/86UbHZ1vNVfZZJqo+Mhzt75BjuLe97ozJByUlfz+tAGRZXsGDuuFCwtAl
         3zPskpWvGyjkR5aqq6PmD8zjDOcMxM6+a+ZZqhhYk00oaJlwq4befuTdXOgWfodyuxf1
         Fjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488117; x=1715092917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5jOy9jd0xiROoe/7MwouFpHnIdHgx2Cz93tn+PNioE=;
        b=efYFO6VW5/SWqiyw6gDe8M+oowSIbm4lJUPml5yN+st2xAMXr+KNbfZz3kKhN+wE/D
         PIsBgmh4SJpOtV46w8jvA3H55cyyWwkkfIHyy2CkvgQSr2D/gNVWQRG//zaUGU3XIMzW
         TWR0mjn2Wkawj9Txk/rkjnVicmWguVqRx8fFjflP7TgpxgBPAeAqecs8KmfLayAMhKHj
         8VsaHCwoDsdh3tZkMr5cRG8saVkJJVT3UqqHENhVnl/Eb1jpNQxinEFXoTAN9fKMChuU
         2TZFQAF67WcSKwU5D70y/FE8oaVLHes7mDniWVZAOQUjehELRDOKGWEmk3+ZK+NLu2IC
         4CYg==
X-Gm-Message-State: AOJu0Ywm6fP6lArWWJ+eyRCnawT8kSHjiJzyRa95Ty272aVPO1ds2GjB
	YXTma1H5QywN0htW3COZ1AIbyXHC9Sq73JVmUKsb1m+pgPSTiYw/VAJKtA==
X-Google-Smtp-Source: AGHT+IG4dBh76Pe5WPZE14ZdzHkmzTAe6Ht7wPalh36dUrOKE2Zc0hDpnogrBfJxOKBzPk6CvbSGWw==
X-Received: by 2002:a05:600c:524b:b0:41a:b310:8959 with SMTP id fc11-20020a05600c524b00b0041ab3108959mr10152412wmb.32.1714488116781;
        Tue, 30 Apr 2024 07:41:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0041bf512f85bsm11439386wmo.14.2024.04.30.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:41:56 -0700 (PDT)
Message-Id: <ce047c58aa81cc5228ae9068d790585e012491c5.1714488111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
References: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
	<pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Apr 2024 14:41:49 +0000
Subject: [PATCH v4 1/3] builtin/commit.c: remove bespoke option callback
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

From: John Passaro <john.a.passaro@gmail.com>

Replace git-commit's bespoke callback for --trailer with the standard
OPT_PASSTHRU_ARGV macro. The bespoke callback was only adding its values
to a strvec and sanity-checking that `unset` is always false; both of
these are already implemented in the parse-option API.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 builtin/commit.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6e1484446b0..5a3248370db 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -142,14 +142,6 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
-static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
-{
-	BUG_ON_OPT_NEG(unset);
-
-	strvec_pushl(opt->value, "--trailer", arg, NULL);
-	return 0;
-}
-
 static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
 {
 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
@@ -1673,7 +1665,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
+		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
-- 
gitgitgadget

