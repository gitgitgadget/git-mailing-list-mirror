Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105717D2
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911659; cv=none; b=Y69ODYSGwKkVuiAaTnGtwB7NHqsYmZjKzKQY8rbSb2jwjPvgqO6lEUsGRts0ABjW0NfGuKApFB7QJZRqPE9OKX/CWyJUrDHnjOFCl2GdnZCuqhyn8XARO8y3vu9CFTI9gIreFgK4fm8AClZpGpi7TcP2UC6tgpbvwxi0r9/nlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911659; c=relaxed/simple;
	bh=9jjz5F1a8/dNZiM277C1aeXpMRBIIEehRF47/i0JKOs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PiFvqfOimNatWahja9dcHR9kUq3lU2fheUM9l88Raa2/vXvk2MLctIwgjGjo4PycLxU8wDgGssN5g7Z9Qyr8t19cJMy+3Y/aQmHl13GGhheyGAE+AyadFeUtoeLwzbrlMaFzDv82uspUBxvL8axrxNjbdbuMtlrpOQwKk+B7Zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP2Nwukk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP2Nwukk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f2f391864so892832f8f.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741911654; x=1742516454; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZpoFSg52lF4whc6ZSEX42NfZUMdvuxvhsh6l6nJHN0=;
        b=HP2Nwukk41++u5XWlNjKDgAWkJM8H5jJ7V1nQQIm9z/dYJ1kwHBX9+yOe3CZZqjxaJ
         Y1wwIBYleVnlQKA1w01S8hDWarlOlsBKpE+cTN1i0wOKJM2ppEnmSeY5V1sbEfnCtzPT
         R66XUNjbG4r3MGfGOAYo5UVbuqI3LJk2EtjNNQWn9AhExD56Ik9SEYmDo5uIrHjK0y0L
         abby4vIHWrWHrMpWy3KwLuwhLi5VGQ2Pgkw0G+kJg3xTXtzq5BTvNlCRtxjEUvfZlyrX
         9Pr7Vm6WcG8/ryb246e1Umf/IW9qPVajWgHzH0VwmuvxebqjSepqO75rqmNjtJpolc/V
         Vwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741911654; x=1742516454;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZpoFSg52lF4whc6ZSEX42NfZUMdvuxvhsh6l6nJHN0=;
        b=J8CimVpN5X8BhSe5BDr14rVLepF2ulcJBENzevpTjvTazC1k0JsZDf77SJabFejkkq
         fQ1KM/+1n6DGQJGylM+DuXhJJl3e0VYt1m4sSzaScQRSXBbKA/skta6tPMMNGy8h8zp5
         4OUIWqpfaXTrYcU+oVEpGoTLxjkA0vf1dkQZYqrz1BAJylFc3Uk2PA5xyUqISXLD6kdv
         /LZBbvpP2SA4y2rErtBvnWTirZ5A+bnQWY8irEXVRoEwd0qvNBITUG1KbHkarDYoF+QV
         o3CqLLTnfsrVuey4eZTpljanM1q2psq/tXJrGglSt85+HjzOXsAw/Qr9t+EYS6ADK7Ac
         JIAg==
X-Gm-Message-State: AOJu0Yz3mSNgOm7Uk/egFEmgni9zN9J7ThSp8x4SuMhhXjRjtV5fSfS9
	hkqfHaaVH7oU3up0lLRcNAoTxLJ6QCyOM/HlUkqXZMYHZY+tiFDlnSTh+w==
X-Gm-Gg: ASbGncsy9kwOhTAlatwKFdjhkMWLZkS+9uuVhtd0yO9wyZpZNodTD0bnW5A2A1ZuTMI
	N3jrSxpJRZSYm370moxxpPSTs9r416t/FOeNjR6M0tUpWlz5f+HKKRU3d60MyHPOGWSGmrOGJgM
	ryu5lWY2wBRfjGZucaLp0YppXrKmgQLFDaR0GknX6IPriZoalz3itrt5BaLR6QUUSPsoiD0t06/
	B9X1EEuM1eZci/f1j5uXU4oahHfS13WWMpijwZqZi+lbAunf+pWpPCWrBYLqoGkLXEPwwey8Cnu
	JRhB/0LClruHdHGtGvERo+FXHUqXt3sPULSHVvnN21LBRjnFBZd1WfYt
X-Google-Smtp-Source: AGHT+IEAKDmrVrCPQfL2Ol/CE150cjcCKyZRkQNLHA45chtmWQ92nHkjx1MuDF9wgs+HnIUzMlYpag==
X-Received: by 2002:a5d:588b:0:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3971ded2b2dmr383104f8f.29.1741911654382;
        Thu, 13 Mar 2025 17:20:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a12sm3678084f8f.75.2025.03.13.17.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:20:53 -0700 (PDT)
Message-Id: <109060ccb8665c73aa0c4f73e3cbbddcd135bde4.1741911652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Mar 2025 00:20:50 +0000
Subject: [PATCH 1/3] git-compat-util: introduce BUG_IF_NOT() macro
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Create a BUG_IF_NOT() macro which is similar to assert(), but will not be
compiled out when NDEBUG is defined, and is thus safe to use even if its
argument has side-effects.

We will use this new macro in a subsequent commit to convert a few
existing assert() invocations to BUG_IF_NOT().  In particular, we'll
convert the handful of invocations which cannot be proven to be free of
side effects with a simple compiler/linker hack.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-compat-util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e123288e8f1..c3415ad7e0a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1460,6 +1460,7 @@ extern int bug_called_must_BUG;
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define BUG_IF_NOT(a) if (!(a)) BUG("Assertion `" #a "' failed.")
 __attribute__((format (printf, 3, 4)))
 void bug_fl(const char *file, int line, const char *fmt, ...);
 #define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
-- 
gitgitgadget

