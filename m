Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80592328616
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521178; cv=none; b=K+5zOtynJK8vkDbRffBjtX7MlXvMkJL6q3wSj8KaxrludFPkGCHQkb/F1FgaWVa44lPuOciV/a20RWZFXRgoIVZRRB1h8KiHWNjyvOMyqi4gjqvuxg6QCC1x571NBeJqbOGn3YerBkLE7ovdXouW6fEB6zDC0UQGbgnKHFqozio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521178; c=relaxed/simple;
	bh=G8sl7dzNjgylOgBZaK60IpBPczSgVPHJwVnzdpn98mk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VjlsunCe7Lhjw5WLAhJPd5JQTULBMz48jcwqAjQIPyv9slnZ4uGX2DNOIm3zm/eRFCydLEGhYgy7rer0HR6z6FzEK4P6x3I7x3dTc2n0QKWezNyOBqB4TEmyCArw+yOpDiyW4HWVEaAY8lhaT1on0Fi0xjQYvJs4FGP4jvZKQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJgmSaq4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJgmSaq4"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1156449a91.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521177; x=1787125977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YyKion8qKaZ7fDGgi6y8OS2wF/7TkO90zb+N3hqj+GI=;
        b=nJgmSaq4iUDi23/Xvqp8LYP9hf5pI9pKH6M76Vi0hVM80XnTxe0kBlfStfIPDOsEM8
         fL9jK0xIvHi7MFgaN5gPw1bh5l3cox0zKs+yqfvHke/qXKNMl+l0i/0cBSPsbCE3U+SV
         s4vXl7MoqhpSxvAr/LUEnFu+rh7jm+jhmYE2XsM2PksWqUmvc6I3mHFZA6Erytndk7Eg
         kokl7l+YVqny5gKdZeMID+JO+pJqQnWOpKSgfgai789OsCIuoTs4PPf+UpNwrk5XLzbk
         A5zlO7I7YUzVkv+AiN/zXjpN5OZfwYTpuVkUlhGj7NQfKZDBFNLrpM1k3ihpDvF0C5/P
         F8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521177; x=1787125977;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyKion8qKaZ7fDGgi6y8OS2wF/7TkO90zb+N3hqj+GI=;
        b=ECE9D83EkSOs+zaDCov/d3Uqek3d7u7DZTd0W9zIIncxsvUMoxh/o5wRAB2cq4aX8/
         V077CjIgLc+aYteSjSLSdXIjqT7c2qVLlecN3ErkphlGnEnor6vXRPiAAcaEEXnhL2IB
         etFZQYBTBAf9vovGHr5UG+TwMq0MpjNmRuXNSE/sq11vBnTu0PL0WIG+oV1EszHEppxs
         SJEqxVN7ZFlt96m7/FO0zSvZ39BljNQy4Y6yYNnY1XaL0Lyl1QVDFz+DSaSf7/QOK6iB
         ugaPAD48lG+YkTVvNbqbwyQXbvrc4VVhq5VmUYPWXUmbXYtHe0RdYkLV1e0OJ8gB3T6z
         LCNQ==
X-Gm-Message-State: AOJu0YzQMfJv80O39AlBPRrX3p0qeP8zwjBB8+BtZOj/TPlsfeOtr65V
	82IQPbNlap/3lDAWpFFgfIncPpr9X1gaYim8rtWpoJlRkU2YZ6nOarfP1jY9Ew==
X-Gm-Gg: AR+sD11PprBvbkNBcGPVh2JLNdadgGg/5XqCUgT75lxGIt8KBD/wBYxllD4DJ8m/aYd
	zGcBf+SPRzpCS0XOc6qcj+8wGb9nbLydoYDp9b2+klVz2hfb2v/G6/0Ql6L87KWtDLWZs3h7Cit
	7kb3gWQHVZSPfHpI+zxijiK5fSNMqvdf+9C2nxNSpsSFoEQK8l9cK3T0UC5zXdpnsbHLyLt55qS
	n7XM9ZDGD4LCtwTQ4QOtYKcEyCXcagX2kn7Rklg0OnLJoI9Yva6/Ejcad/0lvvN0AXZ41PD/yrs
	VY3Mtp3pxUkp/+qo93zhrDfOThrjGKZHt5T+Y9Appyq1SvysDvWFLVF+g98PASzdVPiFeHMHYV8
	22HGeK57ADg2CBtOlUdrw7S+6OoD0PjXIQsB11Tnmlf9Ci75vMYpkwdc1gFVtkhV3XDXPZh/Elx
	+L2s9t0hmQgFTgMT6T5Xld1rFW5SyoBxBOVTDqGwjP0/xRWZ/DUnOn9SuzwRNmG7rQ
X-Received: by 2002:a17:90b:17cb:b0:38f:26c7:165e with SMTP id 98e67ed59e1d1-3930125aa09mr3265869a91.9.1786521176830;
        Wed, 12 Aug 2026 00:52:56 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8d00067sm2755188a91.12.2026.08.12.00.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:52:56 -0700 (PDT)
Message-Id: <fd594ffa6cfacaf7896ab312d51d39f30d09be81.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:41 +0000
Subject: [PATCH v2 01/12] mingw: include the Python parts in the build
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

While Git for Windows does not _ship_ Python (in order to save on
bandwidth), MSYS2 provides very fine Python interpreters that users can
easily take advantage of, by using Git for Windows within its SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 9ebd240378..8dd8acfaa5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -781,6 +781,7 @@ ifeq ($(uname_S),MINGW)
 	HAVE_LIBCHARSET_H = YesPlease
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
+	NO_PYTHON =
         ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig
-- 
gitgitgadget

