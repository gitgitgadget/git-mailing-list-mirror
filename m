Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239E3B5F48
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981443; cv=none; b=tmt+tvDNwPHieif1KQvG1o2s9eNsaojM9ZwCfftJb96gPN9t6v84/0h4C6ptawI7NRvRu0SKObTnXLUolNozFSq2NJiwNCxOIikBtQMEJit51QvprfBKI1u1xmfbVCLhC9tYmPyZlbCTEfU7kDLvY1WN1RDBM4ClkorjQx4Ti4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981443; c=relaxed/simple;
	bh=CqzCJr/bYKQK7yz1Oqcth+9qT1z2kwrv7jBHJzzfJ8Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i3FKi4wUWFo5hV6mbg6wtwEfTaK3ACsziSIiYDDEZhvISw06WSX5sqtaQOUQJUCERjppUcb5bZx/B5pnkMFzb/0O1WukNM+ZJlH3hMRgpRcoS1lVQ+0VefdjYAH0jXsZ9TBLO6TR0KM0AScYCj8Un+7rwwcg9bGihUpBV40Gx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3OAGLei; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3OAGLei"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-382ef647e20so6763047a91.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981441; x=1789586241; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fiS3MKZxNfuXjpb0BW138Jso6uNlgcMNEe66vqL2lLA=;
        b=f3OAGLeivmYNDpZy7Q30wBgkYcbu8sKd60c6OaF3l20Rzo0K75G8ZnSA1eM5zPYB5y
         C7ahLmtBU6TOrNpBMnE6zLZSE128M+mtwc1CgK8FhrZ1/MCOADPkD3ItOr0W95sUms2H
         yYDtbKdn7VJfBV76CkicEpXiS42h8zupaiQukmVx945VhBDijCeQl7URufZfqdiEc73Y
         dxnpvcenG8kB+2d6Vdma9jmfPm9lVw60IT1LuiGbOu6kEER+7/g2x12465zYQWNq5q4P
         ROyl8BayyZRJNK5ggkZWiAHBy1rtW+gQryxmIBQBSG3XuJ+JbRg13hrHm58WefqWiscw
         lQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981441; x=1789586241;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fiS3MKZxNfuXjpb0BW138Jso6uNlgcMNEe66vqL2lLA=;
        b=Cm3wTmT8XochAgo8TN2bQlWrCg+1EjMa4cXFrRsbUQMHVO8LlKOwFRpPGz8cGWHNjm
         2cp/8BDnRz/slzvQXU85+qwu1zQislZHpgjJirnT3u8g9cXqveNL2JXs7fZtfoOFmbK4
         fGUSJYWcGtYscoLaMPO6icxafvxWM2rb8I2Xl0eL/BULRgll8r/SQoTICpNTJR49pre7
         qgZfJ4YkTVsjdftSn8Eb3iGDgFfA+12wY7Kz3109sD3sNUPi0WqEDnlrDUfbYrQuk069
         CQwI8iDQn4kXl2qUYE7GoomYlIgdIztPJHEPz/1cCKs39HWxWP/7iFI2OJD9JgwBfUWA
         uKoQ==
X-Gm-Message-State: AFuF++mhggcJE+YMrsWTwCA6FDSDYF6cJOeCSw54gsjN6U8MFxaj9Gct
	+XbTW4JI2pX0gPoERKdTZGZLTZ7ZSOIa0dJbsBxTof9QDn5dY92w72vI5nYYhg==
X-Gm-Gg: AYBFou0z/HJ3w/KpJNHufkDDqtClUnw7t8ZF2AXvfU/MqSu+BVKlD2aPv9etC1whrm/
	/YNPYM44DltBcIoCeH8KBH8yVgveBBDOjr8RKbi4UjxdZJh92UxGf5VEibX3hU0fub26WOs535o
	u9OzSTmgJ+ts2OC0ZuTqBpFwR/1mZPXSq9MZOzPnSUb74I5QmYbJF2BVDiQ33DutgQILLDMUHcn
	r5B0r3ICUKTQ7H1+ZBPfO5mvcT1H+pdUiMDqImC4LLXd4PacbSFgzbTYqj7zDd4fgHLUy67K9WC
	/ohIYanWb9EdAy8uIK+nKDV8Jav53Ne6+hTdrFn0Pa6m/nrSVand1g6bKIg/4mmqsmrZ1TFxgr6
	wZ1ioEjk0DwdJSlgROOk70UoySELW6WU+2EOeHApDST0GBaOYVBTCTbMqJdQor7p4Ez7WK/jjrt
	R+Zg4wuswIX8m/gK5/QRxxxIDBCl+Q7rEkj/Yw0qXtfRFsGbnkeUlV4WWOafk8uauxz0OzfuoB
X-Received: by 2002:a17:90b:4c03:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39b26130698mr51345018a91.11.1788981441602;
        Wed, 09 Sep 2026 12:17:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm40938073c88.3.2026.09.09.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:20 -0700 (PDT)
Message-Id: <47fc97458247529f9d2205cd7c0bdf5125ad8832.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:06 +0000
Subject: [PATCH v3 02/12] mingw: stop hard-coding `CC = gcc`
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is no longer true in general, not with supporting Clang out of the
box.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8dd8acfaa5..a464b2009c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -771,7 +771,6 @@ ifeq ($(uname_S),MINGW)
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
-	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
 	EXTLIBS += -lntdll
-- 
gitgitgadget

