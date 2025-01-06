Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E241DFD84
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736204761; cv=none; b=tXiGleEm+gvzXTAkPUb/e1ksLrMvZWROP/9nmdxej5bSZE5iG1xSmkfgbNLA1SwGhJo8mXz2cre210QUcwJar/UNwgR0u++4+VJnpH43hI/Sx2xygWh7TtmcQbbyWW7zsAcyVdVWmDILar3j7G3B+y8vV8SKZhCa8aW+M7uPVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736204761; c=relaxed/simple;
	bh=9PI4Xq8OOK333gu9FZJoiYZod1wr3loFvWPumFu74yY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rqjnSh7ouOeF+g+b+IPShqcuBG8ZAZkYhCy1nN2z4Hd40oXrbLb4xev2x+r2dIll7c4Yr17iHsoNJujjE7D36aHwOt9QCa8XVLMOOQHfPnVhGjB9hZgNQh3dJm2+D9kVVh2Sp3FKG1FwYc1mucbTxLQ4F/LLz40LflrEN5dHh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeJhKBVr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeJhKBVr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43675b1155bso141794535e9.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736204757; x=1736809557; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAuQ74v1nDuSm+nLxI9iTbmgsYcBSVHbsCchAh1txgY=;
        b=DeJhKBVrQHFjmImGFhcvtF+MV41Hyhy0vljhlWLGzljE2ORwDTlUzJxUHiMv/unt5j
         YuYmHCwitBtfZpuQ08N607Irf+XebgsC2+lnhjKrhTcHxNL7tuXtBRz0zpvFn4pRDZ16
         /a3UafdsA/MfSzzeCzTE+GmyzDtYqvelDPktcNyZSpS6CqJYHx9yb87xgqLe/sCrwPuS
         HwVeiU3ZHvFFpZg42dLpKONwlsVMQl+stZo3ZiQAWibG/xnuSMyHZEI/H5NIB6isUYTG
         vBDveH+rMsPfe35AMpMo6CTTAzkwFnjgvqxuHaCQwFfmFAOGgxYEyAr7+aX+uWaiC9gQ
         6Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736204757; x=1736809557;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAuQ74v1nDuSm+nLxI9iTbmgsYcBSVHbsCchAh1txgY=;
        b=Tse9aRDhIv6f19UIjpYGK5S9L31p6D+gpN7SNjmlVycK9RAmBGHLxLmRsyCJbkFmfM
         dXG8q9yg5IJ1sKVhmaxSAXc8zPnE59PX33uv/2uQZZaaqV/AmVxzNJkuu5mEUMLiuXje
         i33/7InhS3u74GcoYCXGnWQ/LRzR+MR+2E0G6GBGFlsIeG0/Zm36xxg8eiU+vXZ4qTQN
         j8+oHf9MvW8axWAGPwMhZ+KHtJo33rrOsd8uuK3nMWI177Lep9XoWdrEl69ZpGtj5Qbp
         0wxIdHXiPoyQQ3n3a69QoySdvMnycjCZlgL/csCnCJSYreUZaIP8PvyTI2n/BqEYioYF
         nDmw==
X-Gm-Message-State: AOJu0YzULOmmDBO53XUjiqJL5rtZZeH2+rN/UP+JfgqMVsdshtO2saJ3
	xHkBL2zE6/ZTll7qOC7fM1Epb0y7Uqr1FfFDKtQk1fNvsaVyOyXcnO2YVA==
X-Gm-Gg: ASbGnctJ4HJi5ZSMeOE21tPgSSQwvyW4+Z5Sp/3nr3gPiKaAopez+0I9IwBfq+GhjTM
	kqe68Q6dlHwRm4dEpzggljPkb3cwlh7WF4I1DKZ39HqfVBtGdxgDuoC9gIHwVLzOExxOSrvVnNc
	9FaLXPKegutuyIlun13YqJbipgOau10jvRwNm5VxzzlR+Dycq06BsbS3vlzx9eb2278chPLED5H
	6Gn/ldxXi9aVANZpdXJVyPE9EYLTlJenXRRLlXHgDRPrSTKb+zN55BZgw==
X-Google-Smtp-Source: AGHT+IEoone+tNzTe8EVMCgjX1vlOT6Ebml1pGfN3B0GeoSo1QYi82P8IhWujTp5ErYgeGBroW2piQ==
X-Received: by 2002:a05:600c:35ca:b0:434:e9ee:c3d with SMTP id 5b1f17b1804b1-43668b7860fmr446350975e9.20.1736204757363;
        Mon, 06 Jan 2025 15:05:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661200abesm578204305e9.18.2025.01.06.15.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 15:05:56 -0800 (PST)
Message-Id: <pull.1842.v3.git.1736204756030.gitgitgadget@gmail.com>
In-Reply-To: <pull.1842.v2.git.1736193131798.gitgitgadget@gmail.com>
References: <pull.1842.v2.git.1736193131798.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jan 2025 23:05:55 +0000
Subject: [PATCH v3] credential-cache: respect request capabilities
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
Cc: sandals@crustytoothpaste.net,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Previously, credential-cache populated authtype regardless of request.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential-cache: respect request capabilities

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1842%2Fhickford%2Fcache-capability-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1842/hickford/cache-capability-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1842

Range-diff vs v2:

 1:  696780d4782 ! 1:  e9851c5c4ac credential-cache: respect request capabilities
     @@ Metadata
       ## Commit message ##
          credential-cache: respect request capabilities
      
     -    Previously, credential-cache responded with capability[]=authtype
     -    regardless of request.
     -
     -    The capabilities in a credential helper response should be a subset of
     -    the capabilities in the request.
     +    Previously, credential-cache populated authtype regardless of request.
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
       ## builtin/credential-cache--daemon.c ##
      @@ builtin/credential-cache--daemon.c: static void serve_one_client(FILE *in, FILE *out)
     - 	else if (!strcmp(action.buf, "get")) {
     - 		struct credential_cache_entry *e = lookup_credential(&c);
     - 		if (e) {
     --			e->item.capa_authtype.request_initial = 1;
     --			e->item.capa_authtype.request_helper = 1;
     --
     --			fprintf(out, "capability[]=authtype\n");
     -+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE)) {
     -+				fprintf(out, "capability[]=authtype\n");
     -+			}
     - 			if (e->item.username)
       				fprintf(out, "username=%s\n", e->item.username);
       			if (e->item.password)
       				fprintf(out, "password=%s\n", e->item.password);
     @@ t/lib-credential.sh: helper_test_authtype() {
       		EOF
       	'
       
     -+	test_expect_success "helper ($HELPER) get authtype only if request has authtype capability" '
     ++	test_expect_success "helper ($HELPER) gets authtype and credential only if request has authtype capability" '
      +		check fill $HELPER <<-\EOF
      +		protocol=https
      +		host=git.example.com
      +		--
     ++		capability[]=authtype
      +		protocol=https
      +		host=git.example.com
      +		username=askpass-username


 builtin/credential-cache--daemon.c |  4 ++--
 t/lib-credential.sh                | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index bc22f5c6d24..e707618e743 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -142,9 +142,9 @@ static void serve_one_client(FILE *in, FILE *out)
 				fprintf(out, "username=%s\n", e->item.username);
 			if (e->item.password)
 				fprintf(out, "password=%s\n", e->item.password);
-			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.authtype)
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.authtype)
 				fprintf(out, "authtype=%s\n", e->item.authtype);
-			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.credential)
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.credential)
 				fprintf(out, "credential=%s\n", e->item.credential);
 			if (e->item.password_expiry_utc != TIME_MAX)
 				fprintf(out, "password_expiry_utc=%"PRItime"\n",
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 58b9c740605..8da0afe9395 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -566,6 +566,22 @@ helper_test_authtype() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) gets authtype and credential only if request has authtype capability" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=git.example.com
+		--
+		capability[]=authtype
+		protocol=https
+		host=git.example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://git.example.com'\'':
+		askpass: Password for '\''https://askpass-username@git.example.com'\'':
+		EOF
+	'
+
 	test_expect_success "helper ($HELPER) stores authtype and credential with username" '
 		check approve $HELPER <<-\EOF
 		capability[]=authtype

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
-- 
gitgitgadget
