Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EFA38DD1
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199139; cv=none; b=QNrxPVYKhGfYDY+pi+K4fu/rnrNs93AN6SJg0I/yETzufVggFYna9l01tzSkqFelZuiEfR610qP0lbXGvCR3LCJxHogYVwKbFM/TbN50JDNRXTLjlbpuucZRAZ24RF7tpFr9HnSm5gOP34giiYssHMdmTUDMp377to9hoQC78gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199139; c=relaxed/simple;
	bh=HeBrCo+ZVTeY0GRFVCQNUBnHo9dG4ey5LSlkb7wKNQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GntFs1dEWaIthDGBqg14i25oBOxvjxZj8iMarTFZR/w8wjvXgej2yyDFZnyb4lXlQTU7AjzN7Z+D9txxpI0+13O0Vfg8Kq17GTHMYovL/A8ywkw3A5Elv2LxA+rupj6sStevokOIQpiRCNeX2LI77Iw8dNwoTaW9636SUMnoOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QjMtRqrC; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QjMtRqrC"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e20a8141c7so10820927b3.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727199136; x=1727803936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cX8phJkeB+hnyG0RojMlo+hq6/5rVRNGKooNkDOKJnQ=;
        b=QjMtRqrCcKsJk6+9gHlsWQIfobHK/sNFrlwktbNFwxdyJryDezvcDxjX7Ey4qCTyqk
         FGgRGkj/hGxsJgZgF/dH/lF/x0Opv9w9VkSOK8azUR8pAlpwlFVKIH39W/w7gAE8hbL5
         IZ1m3ahOYJxjrfTTNvRJhvoIZvAjmd1cVtGL7eh0y2F2B58unXjRdhCyDTM7bOreG8c0
         SSdJb53sPT70rSa1HvWptOw0Ia3ytqtYs7wMFwozTBke1UPlE+NfpGztq2e5MLa3/yc0
         AQYMnwSOlDfWrf6jXssFxh/UaRU3xg7CUKE/y3/aXJPFg2ViBG7ajGsEKQ02m6hGgeQy
         CVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199136; x=1727803936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX8phJkeB+hnyG0RojMlo+hq6/5rVRNGKooNkDOKJnQ=;
        b=meZQ0sspzsZo+p97Luc4A+QHEo1sndaynPA3DwOzei9+JLHDWnGxQW63dC9lfCJdZ0
         fhG9JM5PufPijqrmYvyDAaJW9Ci7THwCKaoaaKJ7g0yUQlTdMvw1zruNISEZByi/R2OQ
         KaCikPTLRSzcoC+Psbq+TvSxxa4D6/bFg72VKfX6b/oENhUtF9yn8vagYd+BOoCTq1wK
         b1ExoUQSnF8YquQYO5OPYg5sv3xxisah5gZtRt4C6f68YOlr21/MGjHgngnUcydVA4TC
         0bDN3/uDTARgQzXp83jfxiMo8zi5nXGFaFVvtiFUlMr+mLHNV73drfymyVTRVGp33neq
         p08w==
X-Gm-Message-State: AOJu0Ywnw3slU3jozfz5+5rnDeKdf4ntar5kqSAHGV7QKdnCBzWIYqeA
	dp7xTdgEcIgw0zyIIdzS7oB5725nQ7x+MzdBITk2Sr+hQy38/HlcKlUSHkCNJcFutnznD5pG8rT
	N+0U=
X-Google-Smtp-Source: AGHT+IFFOufsCpakZz3jIf+0CKMH1HXxQvgkpw/pKNdWbaR3jLSwqZMtaqlkC9+oADF6/m1dSQVdWA==
X-Received: by 2002:a05:690c:660f:b0:6de:b23:f2c3 with SMTP id 00721157ae682-6e21d6ec709mr2186657b3.7.1727199136170;
        Tue, 24 Sep 2024 10:32:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d06ea39sm3101547b3.68.2024.09.24.10.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:32:15 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:32:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/8] finalize_object_file(): refactor unlink_or_warn()
 placement
Message-ID: <133047ca8c9aed3e297483b60ca3fdb02eb532a5.1727199118.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727199118.git.me@ttaylorr.com>

As soon as we've tried to link() a temporary object into place, we then
unlink() the tempfile immediately, whether we were successful or not.

For the success case, this is because we no longer need the old file
(it's now linked into place).

For the error case, there are two outcomes. Either we got EEXIST, in
which case we consider the collision to be a noop. Or we got a system
error, in which we case we are just cleaning up after ourselves.

Using a single line for all of these cases has some problems:

  - in the error case, our unlink() may clobber errno, which we use in
    the error message

  - for the collision case, there's a FIXME that indicates we should do
    a collision check. In preparation for implementing that, we'll need
    to actually hold on to the file.

Split these three cases into their own calls to unlink_or_warn(). This
is more verbose, but lets us do the right thing in each case.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 38407f468a9..5a1da577115 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1944,6 +1944,8 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 		goto try_rename;
 	else if (link(tmpfile, filename))
 		ret = errno;
+	else
+		unlink_or_warn(tmpfile);
 
 	/*
 	 * Coda hack - coda doesn't like cross-directory links,
@@ -1965,12 +1967,15 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 		else
 			ret = errno;
 	}
-	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
+			int saved_errno = errno;
+			unlink_or_warn(tmpfile);
+			errno = saved_errno;
 			return error_errno(_("unable to write file %s"), filename);
 		}
 		/* FIXME!!! Collision check here ? */
+		unlink_or_warn(tmpfile);
 	}
 
 out:
-- 
2.46.2.636.g4b83dd05e9f

