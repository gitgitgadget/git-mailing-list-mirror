Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6D1D47AF
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651983; cv=none; b=DRpicZZSE6UeAJ6llye/RDxFtHdlIisuEN/s967741c9qN8IsecrDuY6mPR2+0cGSlklLbpPlN/o98lbsgH7mzxdonnSA8VYKTBL9GuJnTmUFjCusgmERf5TqOCWccYILGRhZCoBcesZfT9sxutHaikRqCfuK1ZFXdQSketGtGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651983; c=relaxed/simple;
	bh=gaSsO/Xwf6T9g24xg98hpQ3ycGxbruwxEh1Berp9T0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3zo5KtDLjwxbnBZqUeXhm2xBy35nuVJ+rXUsYmIklb5XqDstC6gOgNEecgHI7Zmg8j7GTymDJa5e37X2YkO7yLtbrAcLxrjLZhECmJL5f8tLwMCtRGhXlPbNFdcZCQrBYMnYUbttriFmTyuwdQUijR2Vtwxm4NFUeCFHcg3Fk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=whnfdboX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="whnfdboX"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-68518bc1407so27250497b3.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651980; x=1726256780; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BzZuitm20Jcv335IO2WXHiy01XhKFs8S+X00N+4JxQk=;
        b=whnfdboX9r3Uzq5J6/6MUuGfyQTui2P9ZTeZcwoQTzkgKUvJI75qhOlpKc70Xa6mia
         6BAlLiscGC1wPm2me27uDed90q1ZnIwK4RbfvFkmhV6p2oc8Mp2Qv1P1+hkAJzDk5MpJ
         SO+JMeFlqWQjgZJ0VqOTQxQEBAaMpC9NURCTi+DgXTnCLJFLl9+1j9ocTGYM28Ul4yaJ
         PQgVUzFwgRytsILtSfm3dSrx3fbjP+kv/L2fsQxQrqdL26+VHlVSDKfZG39Iu9WU2UDC
         ouGNzwIJW6OUTliFEY/+tJibD33OHRDG+Z5xYfHGL5eXQyJD7FnjbzmGo/xltbtLJXXz
         yhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651980; x=1726256780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzZuitm20Jcv335IO2WXHiy01XhKFs8S+X00N+4JxQk=;
        b=MxUww3cdLGT4H1lRJbyARUaHG/GK9LpL6T60sieB7VliQjuIVfELKOxCpm8x6DTjZ3
         mnBeDZTWyFMr/s7YoE9msfzegwC2jY+whfgzUf62LDN60DCx2gpCKgSjDcdF4Nga6C85
         HzLlV5rxe4K0sDJmOQxfL/0JHTUe3JVpWu/wuDEppi42nQZhGwL/JP+tddOGOhvV/93f
         ROKuq1im1xNsASP9BOtuRAPSS+tixw8urE4EPttHr9j2ei8QLh7izyhlMl5X7zrBuQAT
         lpNYiK+98a6etPG6PpqP4X732DjiS23b4deraRekn3KfbHwbpSl7xrePHbstUFfasMc/
         F4Lw==
X-Gm-Message-State: AOJu0Yw97jU1HnyIHS/QbcQJ7ayHhUyIgCwPqnOroytFpCJ6ayFRpwTf
	2KAYhypZvxhQm6JX9OaNX11FFOHWuPxj64BYQQjIgIZwpsDFzZB0yiUKRcLI4dAQHqoB08Ch792
	msCA=
X-Google-Smtp-Source: AGHT+IE2P2wc7q/6/1U2GOTwMxI0xYiTi7TpnV0LE7lJyN60Yvj6oYIg2pTJeVN6M+MSsLe63325yw==
X-Received: by 2002:a05:690c:67c6:b0:685:3ca1:b9d8 with SMTP id 00721157ae682-6db451544bcmr47329157b3.30.1725651980527;
        Fri, 06 Sep 2024 12:46:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db565e601asm1126437b3.143.2024.09.06.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:20 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/9] i5500-git-daemon.sh: use compile-able version of Git
 without OpenSSL
Message-ID: <bfe992765cd562b036cb235dfdddb78f5e662812.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

For the interop tests exercising basic 'git daemon' functionality, we
use version v1.0.0 as the old version of Git (which in this test we
happen to designate with using VERSION_B).

But that version does not compile with modern versions of OpenSSL,
complaining with error messages like:

    epoch.c:21:16: error: field ‘numerator’ has incomplete type
       21 |         BIGNUM numerator;
          |                ^~~~~~~~~
    epoch.c:22:16: error: field ‘denominator’ has incomplete type
       22 |         BIGNUM denominator;
          |                ^~~~~~~~~~~
    epoch.c: In function ‘new_zero’:

Of course, compiling with `NO_OPENSSL=1`, which we have had since
dd53c7ab297 ([PATCH] Support for NO_OPENSSL, 2005-07-29) allows us to
compile cleanly.

This hasn't been such a problem in practice because most builds can use
NO_OPENSSL when compiling the older versions of Git used by the interop
tests, because often even the current version of Git does not use
OpenSSL (e.g., because we use the collision detecting implementation of
SHA-1).

But subsequent changes will make a build configuration that does use
OpenSSL's SHA-1 implementation (at least for non-cryptographic uses)
more common, thus breaking this interop build (since only one side will
compile with NO_OPENSSL).

Let's work around the issue by using a slightly more modern, but still
quite old v1.6.6.3, which is used by the i0000-basic.sh test script as
well.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/interop/i5500-git-daemon.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/interop/i5500-git-daemon.sh b/t/interop/i5500-git-daemon.sh
index 4d22e42f842..c5bf37e4739 100755
--- a/t/interop/i5500-git-daemon.sh
+++ b/t/interop/i5500-git-daemon.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 VERSION_A=.
-VERSION_B=v1.0.0
+VERSION_B=v1.6.6.3
 
 : ${LIB_GIT_DAEMON_PORT:=5500}
 LIB_GIT_DAEMON_COMMAND='git.a daemon'
-- 
2.46.0.430.gca674632b70

