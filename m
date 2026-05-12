Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12D40855
	for <git@vger.kernel.org>; Tue, 12 May 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619393; cv=pass; b=SEO0w2KfJzUp+z8dFc0MgBrE4KeQ40EHKIxJxkV6ggV+5i8NLyktxTma1vISmdkYYK5EjWm0byumCj8oRsEHyZ615KdzVHdN0Wl58NB8cborFWEvTbeLnUcCiUTCgspOhhLpjdqlz7OxTJM++7PXKd/UVgNSV2BmllAlLYpC8nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619393; c=relaxed/simple;
	bh=TkzCYmTH+VHcnVBLS+w05UmZZ+WVwg4oFoLhipUlRQI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=juygHcmjXqeVH5pMwvnbnu+a85Pjg4WGhIaBDJ0sQPnPnQmnTNT/SUVmWk1OjIFGe0Xgc/iJBsBxyvrhOZqC5x6coGLTWBl37c40mZRltKVK31o2Hfe9dZZjfjQl7O3rg3shYqSGHSNq2DpTL9v6cK/0SqEzQ7HeiXDT5KeHHOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5zbVB8g; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5zbVB8g"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-439bdb1d75bso406614fac.1
        for <git@vger.kernel.org>; Tue, 12 May 2026 13:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778619391; cv=none;
        d=google.com; s=arc-20240605;
        b=CeeAQ1k6a1+K7K3pyjUpFpNhUYr3PhK2TI6H9Xm7NsGeY9848uDfxUIE7eIuuhO6OG
         cwiRhDEFpvXrFkUyX9u+zER11ORFjVQz+Jy6qa/tAGJ7YpOsi67E/ynWQdCCi5TEuzpu
         GHCr4WxT/iLXYA8ZanpN1U8udww/SUR/RkmsiS1AOIzPUBUqQiqc7n4UCUatYRVKqbut
         EJ0j6pqOEbSLlpSDqfqTQUaqf3FQ2nP/E3n7qeA8V3kCoge27opm9JXA6ooVNivxF33k
         QPUqjPt1hW8r8onP6VgDENNVwMeYyK9THRUT9/X3WEhOl6UuU+ZIjHAO9pjYJS+oLTbv
         VUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Pl1YEH35Xl7P8WK7tTColtBzr04fQZU8mZeEJpQUvnQ=;
        fh=tl7DMVl9nszdLOfopUpnw02iFIb6XI9z0MNiAlYhSZ0=;
        b=X1PVIqWR8HAE3GXToDI7+KDsQJhyQX/gTGbvh+0cv4n6CJrhC0QEsR36lG2mSRO0M/
         okHB3cH/WepwdL8fZCqlisefbkukxyBt+f0Hdj3bCdB0U8JmtxIqI9PhNLsqFJmyXnG7
         3CZY8KB7EHjKZaBaWVSYjNV7RIfMnjXnr8LXn4bxxvA4DftMSwrYyoreOPLViABnMjqB
         74SzhWZy0CcuKU+2epEtqgToQiWvwkleYR8Qd1vzxg0fr+60PNd/9clmAZPTB+ZLVYgk
         TjcGePuwHxNoGYTMEMGNDtg+HzUIDOdomJ+ZRosptmP/0R3JWWl6gV1aUMHfBLk1Tfub
         +dKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778619391; x=1779224191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pl1YEH35Xl7P8WK7tTColtBzr04fQZU8mZeEJpQUvnQ=;
        b=m5zbVB8gNsn/8Hs8cSvJ5w4xv9r1PTks3r5brE/w9QQnP40o4srg+VqDzY07SnxPGQ
         eClQykVRDUd/cQ7XLw1onF5gYZYeR27/7dnS2VD6iGkP4wGSxOYd4l99nLVdR6DYF4jD
         Pie2wKvNoARzfNKoqiZYqWpOVz7c9HOx6BPN+CEuTOzih5OTaBR0rpvpo4tpPOrI0TE3
         GcLLVOH7a4BleoQHoMw6lkOIbg7Errgg7vgKu/vA07lnC9jKEox/aSwin0JVp9H/l/OS
         f6slNUg2SsDfiSpYWnm8n1ixoJFK4YAk8F+Y1l0v4OADW9NVunM816ZmE4pa8T1r3/KH
         0tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619391; x=1779224191;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl1YEH35Xl7P8WK7tTColtBzr04fQZU8mZeEJpQUvnQ=;
        b=sDK4xAZwz3tfV7D5y2CttzKbgD8y7FYXhUu9DYasZwmqJXuRb8ChPPoUFfLKoIEJkZ
         lmy+dECI4WX3LyQalMrSvpwfmatAjQwe0A7OgsKL8lM8wkZPNfzulqXghoWDoOJ0UNEg
         K7dNUpyTJFR+U7RTBKSE3Jqdvu2i9uiAu7zN+5olznONpaAGWTZLa1UNaHJ0CO81PNp2
         SxLnaWl0r2sq/JKBQ9pQaHaf3X++YjHB2avPqLQpVgybwnSxAJccaMYI2f5w668Zq0Ap
         vP3524qE3I4uDyhOjKyqbqVCHyV9ZE29+QDJ1K5FLTZMMO97p6kNab9htGKOPpOauIir
         7ZCQ==
X-Gm-Message-State: AOJu0YxooUlVlEfHj/RRbyRoipfOoqpghBZleaeKg5xWIs77Alegphaj
	WJ4WDw/7YYbXsjt3Bx31y+wzyOqcL9KsFX2iO1Q/DHr21P4pmceytZK4k1pA02UF52yCkM4Vvbe
	Hzlf+qlNIgaMq11FCYdh3S8bWJfWo8YPlGqqw
X-Gm-Gg: Acq92OG5dFQ2+Jg3sD2zXNrgiw3Sy0Ybx8NdBJoMB7HeW3CQUYTkJYzhy8ojGvVYpcN
	6VspOSWfNDYU1HANKLdcgiKYdNQ8KWGwoBzSL1FuKfzO65BrFlRa+GV2V/Onp8IYGyNWrJ2EHkC
	b6RVOSIPw9n6KAZZ8a0GlyM3xfF2aDwnMtWG30VlNM/3N58LL2X4B0vPgNZCu+/+urUSXSbU7g/
	3ALd9whFZXASRbQpAPvlQ/z4grL9+HnZLjRDcRsIEwrvngDIjwX9oDZdyGmFoot84ceMKFIRbBi
	vsorPtxQuFul9GL+bIkp0A8fpBurvFZQD2vJinwh
X-Received: by 2002:a05:6870:8316:b0:439:cbc3:c07a with SMTP id
 586e51a60fabf-439ce2776eamr214058fac.18.1778619391230; Tue, 12 May 2026
 13:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Tue, 12 May 2026 13:56:19 -0700
X-Gm-Features: AVHnY4KIJKsRO2z9wwtcI1MjUtNhghQPTG8cru8qmOgsQL0guzil3vWi6jmdncc
Message-ID: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: vincent@vinc17.net
Cc: git@vger.kernel.org, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 May 2026 17:55:26 +0200, Vincent Lefevre wrote:
> For wdiff, it is just described as "display word differences between
> text files", and it does exactly that. For instance, if there are no
> differences in words, it shows no differences.
>
> For git with the --word-diff, there is actually no documentation,
> except the use of "changed words" and "word diff". No mention of
> line diff at all! So this is quite confusing.

Maybe something like this would be worth adding to the docs:

-- >8 --
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 8a63b5e164..665473e61a 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -457,6 +457,11 @@ endif::git-diff[]
 +
 Note that despite the name of the first mode, color is used to
 highlight the changed parts in all modes if enabled.
++
+Word diff works by finding word-level changes within each hunk of
+the line-level diff.  The line-level alignment determines which
+changed lines are compared to each other, which can affect the
+word-level output.

 `--word-diff-regex=<regex>`::
        Use _<regex>_ to decide what a word is, instead of considering
-- >8 --
