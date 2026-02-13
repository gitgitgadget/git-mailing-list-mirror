Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3D33D4F0
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026933; cv=none; b=G5oSddv8m6hEFFkhU69A0QZKXosBwM/Is6N9OvhtWVH5+80+qY91F5H4Kibbf7dUxb6guv1hqcGmh7+2hPZ7deSRjv8EWNKKtE8KLJj+XWTgcO2kbGMrqmuCamJq/72rhDac44UzEVO4iD9+Ix9IvTxCD9z4d1xaVIWYsvl1ObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026933; c=relaxed/simple;
	bh=ATL4Aii8pGYUkaTnZM5lqTcGThCkDovHArUCEEV/nEI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oPWFafUVl/ji51/sk5GGlV3j2o572Z96EWAspY6oTMC7Smxc8GtVpMgpAR30UJJWr2g8Yft+Am7VfyfP8yVbcPqg8kjmhMrMK91BaAIFZL1OtqZK4zbJVGJ5C01LdTXkKW940r4YowvmqleFTBoxDR6Ce+HAZfmzFB1oV3ZqNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsTsvu53; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsTsvu53"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506362ac5f7so14131521cf.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026931; x=1771631731; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJgjn1DtiMPmcbSlIam8nDrvf2oyHy51YWB1cRNfeNU=;
        b=CsTsvu53+4VQ9Ex0eyI9E+Zs4E+OKx4OtBuU1lGkUglOx/1W9BxW9/fGl1b4lXyc/d
         7zV6TJRZywsON3PwoLdyGsBcZ4cvdyDl1VqOahTIWKcbGj/uLIseUyQYxnnU93sYmgc1
         jaotKghC9I2HxqMqAv29ORh/jeoShhyp5GcLWPb0eloUrcM1QcnKcgiLaf/2q/j+KpXG
         H5Jz2YWEy5IsokYp02trfCj6Lv2KMsvLXxE1qM7KjqMQRx0h7QBNvBCC3Ys8TP/6bIec
         ZFjws9Ud2Pnt46z5syAczXJaQDkuEv/SsGgE3ecNYF2e8457xltviIwXVgsBB8m8Mi0+
         SFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026931; x=1771631731;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJgjn1DtiMPmcbSlIam8nDrvf2oyHy51YWB1cRNfeNU=;
        b=D9wxZfk7F4cEagRt/BiJhiZXurpD8hXYxiNoiWM0P/fu272SYdPKy4IRd0qwPJ9YZu
         o9aw2usFnhPM2cMO8bXRmPB46Kds6Xq5bnU1jnZOskq4HNpfpO/pZB+5oXHWBW0utk97
         zYRLBE+yxgK8FpTm0va+2bYsWFjxVFHu51JzeWiSx6YllF50uW4RVoTzoz5R3puAJcpb
         WKvOkzGlg2XmYJ/cFUmEjho3h/TCh34kAr4yo5M/P+DCsg2C8BmD1Ac5YQJ9d5s0lL/O
         fO4sgcR08Me71+4/hV4tfr2FHEknKDb4vp1e/6SSCri3MMPm6DnCRkZRY5qa4FL6GHGX
         OR9w==
X-Gm-Message-State: AOJu0YxRfFTQGeF1hA+kwlNY2cJTAkkdiVYQYE7CXVuXSlRjth+0ypZH
	Psv+lJsfeLnuibuta78CKn0P7c/L7WlfSPTlGlY3b4AfRqHzV6IKpiiFrF8qGh1x
X-Gm-Gg: AZuq6aI+Z1mPHbYYLBGvBjiKlr17SRjZADVPOKS4k7vlKJBLnU/4IjjRoPBCPJ4vvlh
	AdE5IVEMXBobknNR9bxp/K61iBl24JQOfDNo+yD/mFx/I2/C+zPDk+3T72yFNQYnKHB8RC995Dj
	GQJxRBP35o7zEnQq5mveAYc2GgWWx2zuIBdMHgJow2GHcFwbvtjuL2CailcjE8A92phoqKTlnjY
	a9XAVtj4RlIkWoIsOSp19ZrD87jG56d5nC+XHA9aV8rP947Kk0e+7ASTMLDnGKo5Fuk559qa8Dw
	WT2K9JT0irJxRvLOSzbUALS+CO3DSR/pkEwG9ge7bzm8VpfjbnhsMEEQmA3gRrk+P5ZrpRxxFq1
	1kIB8XrEsKbrpOwSznzHpoHrS0CrRh+vLyysrvwgoKY9mJO1+PH3Yvm10EtsvmP7kVEt8vPf9EG
	xvnYvTaczk6Uc2RU4Nhu0SfZWa
X-Received: by 2002:ac8:5f92:0:b0:4ff:c894:3bad with SMTP id d75a77b69052e-506b3fa2817mr17088831cf.19.1771026930806;
        Fri, 13 Feb 2026 15:55:30 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d78e1sm83626811cf.4.2026.02.13.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:29 -0800 (PST)
Message-Id: <f8e0b8304fcff1d380029542fe2915c2d67a92e3.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:10 +0000
Subject: [PATCH v2 05/13] config: format bools gently
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting bool config values into a helper method
and use gentle parsing when needed.

This makes 'git config list --type=bool' not fail when coming across a
non-boolean value. Such unparseable values are filtered out quietly.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 21 +++++++++++++++++++--
 t/t1300-config.sh |  4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d259a91d53..2c169fc126 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -256,6 +256,24 @@ static int format_config_int64(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_bool(struct strbuf *buf,
+			      const char *key_,
+			      const char *value_,
+			      int gently)
+{
+	int v = 0;
+	if (gently) {
+		if ((v = git_parse_maybe_bool(value_)) < 0)
+			return -1;
+	} else {
+		/* may die() */
+		v = git_config_bool(key_, value_);
+	}
+
+	strbuf_addstr(buf, v ? "true" : "false");
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -284,8 +302,7 @@ static int format_config(const struct config_display_options *opts,
 		if (opts->type == TYPE_INT)
 			res = format_config_int64(buf, key_, value_, kvi, gently);
 		else if (opts->type == TYPE_BOOL)
-			strbuf_addstr(buf, git_config_bool(key_, value_) ?
-				      "true" : "false");
+			res = format_config_bool(buf, key_, value_, gently);
 		else if (opts->type == TYPE_BOOL_OR_INT) {
 			int is_bool, v;
 			v = git_config_bool_or_int(key_, value_, kvi,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 362e580604..59a82b9aef 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2514,7 +2514,9 @@ test_expect_success 'list --type=bool shows only canonicalizable bool values' '
 	section.big=true
 	EOF
 
-	test_must_fail git config ${mode_prefix}list --type=bool
+	git config ${mode_prefix}list --type=bool >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
 '
 
 test_expect_success 'list --type=path shows only canonicalizable path values' '
-- 
gitgitgadget

