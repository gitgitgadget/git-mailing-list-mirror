Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8334A3D6
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940028; cv=none; b=m2KgBCNyi7kfD8xEIPOB205yMFdKEmbk0r8vnrIoUDoI77/vP97RloaE5VTquXkkK6oNMX/8tgROmFG1hMcX+9+9F4A9JyEKXiXTcq/qBv2oTjXlGchWUKAskVfSyIZ4EjUGzetRNergd4u06G/XVr0suYLXBTGppb/VtQov4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940028; c=relaxed/simple;
	bh=K60gN3CnsnwDPlxbjyhf3cZf88h3yS49poNTacXGbAc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AnL3hzHf9D1jSJzYTQ2sQwzXXkvmNRgmp0kH9Q0yYqD0YRlyCXIkdL7o/Anu+G2gViDUjIK2xPUdG81Cdk7wh9bL+Pd2fykkoIPb6AXwYwpvOoDlJtYid8kifV91VckxtzYO/NgHCCdcVE+lCgXRGAdcFbYOM6X/2pEnt9QEBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+Ek9C1e; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+Ek9C1e"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-668005ba03cso1287485d50.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940018; x=1786544818; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=trmP1Np1a9mBCEUqkoeT5C8Z1lh1laiWfhSi1Cyfagw=;
        b=M+Ek9C1ep9ZPOANVE2KG2Goox8MZ/mYlcWG1345MbR4fo0sFLISt0zDn1QZChiaM/+
         bWxZMnEYB89Xhx5XZ9AWMILZFDq5BnENHltVELiuNDNv5azwBmOzp9KyY1fc1A0Le8/9
         eOJr4Eo0xO9vTokoab96B654LoXdfhPgEm5WaRatS4dvesY+MUup5lge3q+BxjXO74yQ
         q+OBHWHpUX/8mMQ7lRpmfxUoBnqm2bhoQHcjOGuRiTNKfg3mR/+flzXbN2pt71yFLEu4
         MDmfK+VAfmCEZ+h4OWptFmRWngRVozMy1gBv4iL5YA92iBEfCspuHjcaaAlOISoJ+38l
         +VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940018; x=1786544818;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trmP1Np1a9mBCEUqkoeT5C8Z1lh1laiWfhSi1Cyfagw=;
        b=e8VQiTH7rjX7skr1wM9WkOPQYEAPaHSFFVaCUHGzOOalZ24qIOz+nuVvoSW3F2CKfv
         s/GBxbVMNwOuuji4EKQW658TWNexeBtIeTthiKdog5nDjeHJyLeOq5sJrX+MozBPMhSG
         TwAUjn/O89R7BGA8ZwtVWOnKHEAwlwl7FVB531lQK+71dvxeYru2jQ09EVEzTs/Nf310
         8MdMfE+rMBEH7a1/Wl5/fWoGRXxSPeN/eVZ4miR8N1U5wbYYJZi7OD9Nuvpk5eRMpjr9
         zTv6gMvZAGxuXKU8TpTO1ey42SWbJbk1wr5Fv2UNh0cQ41ylh6jl/NpvWGTgyuzywcJY
         ggQw==
X-Gm-Message-State: AOJu0YwVjBYWca6grzJWAQ67ON7740G1fSRtPhVfEN/P1haRo9ANFWMd
	wa0WM40QibxgdLK4D6ugoZAjFPPcOz1CcUGwtfuQ6tLeO02UgRvHLOd18SNSuA==
X-Gm-Gg: AR+sD11yynLNh3arJEatVHIMKKNipfNN96ND7bzEQeUj92rnK4Avlm/RCvF+Y9tNmSM
	KN/tZT0zLOUq7eEZRdrkZz5/qrDyGAa2qybMdUAbWU/K8ngFFc2bYHyPB4Xc8p94XPdKg6frY6F
	E40w/fw+M4vJbW8k5z//88tWq4cNhumXQBFkOJcxVGSKEL2AWWVOMmLpLgEjk0QukVsesvzfrD8
	AIx4M2YmoekKQCy8nViTv/5GBiicBhujfz6/xxDLCr9RxEaynMYIEa0Hk4DvLtX9xNvXxAwiEbe
	CvET/MKKq0H2n2EGaaRJo4adcD9WzGqeUh7j6da1QvKn1M4F7syy2IHCJeaO9gmxEJXTNUxpNKF
	ZjkzeUZ/MJEeErESIaaUGNpOSgmJDcE74rI7MdVjmMiV6ItTUWhQr4d8ZfexJC1hcmrBWzExU0/
	6jNiw7hhqmRIwda2RzgF/bUYqRu/ZsNXEiH58GaOP0himPIr50h5BWrhi4MJHWgoc=
X-Received: by 2002:a05:690c:f14:b0:81f:2825:dfe with SMTP id 00721157ae682-82022874fe5mr37527597b3.36.1785940017563;
        Wed, 05 Aug 2026 07:26:57 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134cadb4sm21380417b3.44.2026.08.05.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:56 -0700 (PDT)
Message-Id: <625f01ad2961a8ca9c31048b9128bbce17ee7655.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:36 +0000
Subject: [PATCH 10/12] mingw: always define `ETC_*` for MSYS2 environments
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Special-casing even more configurations simply does not make sense.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 88bbe1d78f..2f7d445eb3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -519,7 +519,7 @@ ifeq ($(uname_S),Windows)
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
 	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
-ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
+ifneq (,$(MINGW_PREFIX))
 	# Move system config into top-level /etc/
 	ETC_GITCONFIG = ../etc/gitconfig
 	ETC_GITATTRIBUTES = ../etc/gitattributes
@@ -762,6 +762,9 @@ ifeq ($(uname_S),MINGW)
                 ifeq (MINGW32,$(MSYSTEM))
 			BASIC_LDFLAGS += -Wl,--large-address-aware
                 endif
+		# Move system config into top-level /etc/
+		ETC_GITCONFIG = ../etc/gitconfig
+		ETC_GITATTRIBUTES = ../etc/gitattributes
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -fstack-protector-strong
 	EXTLIBS += -lntdll
@@ -772,11 +775,6 @@ ifeq ($(uname_S),MINGW)
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
 	NO_PYTHON =
-        ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
-		# Move system config into top-level /etc/
-		ETC_GITCONFIG = ../etc/gitconfig
-		ETC_GITATTRIBUTES = ../etc/gitattributes
-        endif
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
-- 
gitgitgadget

