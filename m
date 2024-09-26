Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE31509BF
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364159; cv=none; b=Rg1ddr5RjLfhFEQvHJa/INO+jVr0rY4QlF2F8OTB1n3U6jXm8mzuqSKLnaZJ7NQdGVTiyjsL5AHgsgvqBxzNX+D5oaRCzWLUKouxQJieaFCipYGwgmi5gQ8qtZox4ODFG/V3TRruFfORKb2q9aD+ARwm8+ngNsDpeUeSoTt0qZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364159; c=relaxed/simple;
	bh=1oqJeg/ApvJGgWVk+L4bWE8NkNkI6oCBbDBrzS1BWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRAeW0k1YDqS0J5wN2ZfQKhpUNn15MwTc1Abz3uzbRxSXdhJicDoeqrt06PfMrZ+s3jGkORar1g5iOmtvRoaLE8UP5kwTpfbBig+U1wp2F8GqDnpfZXpt2HysEVJ8KVOIG8qzujwON1D0lIst1QWgvR4CVKmcWwovBJBENjchQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YM0tOhTL; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YM0tOhTL"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e04196b7603so1071287276.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727364156; x=1727968956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2Ef2vIQsuHHfBp7Av64sbPmnMivM7QcEaEOawEJggo=;
        b=YM0tOhTLPQRFQ77xCi6H3PPlgPySvYeqv9BN7iAjD8YNrRKbtINP/n7uCha/NiTcmB
         xfXarBvmzfLcApu5kPZNxRccEEkup4EXs8Qv8ZGhSfgIdMlKexPS031N/rmStjvKX9/3
         1s4VMNiBzJpMI8Lbw+lzvTUPhdAziSObgFHTc+SSU5Gq5aaJfcZOACPiGQUkNFzuV75s
         KR6An8UTKls8kMyffOBTSNzSpueVeQXxtEkXEPEQBqr/kfShabw3l8hVS38IYZXKM/Hb
         UAF8o4sDd/zPC5CAKk/m06HvBvKMityLEIPUIV88pO7H0pbixvsGus3XiitutXvUalB5
         IxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364156; x=1727968956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2Ef2vIQsuHHfBp7Av64sbPmnMivM7QcEaEOawEJggo=;
        b=Uf1aLgzRcj7CPbuymuGh7Kv5Zr8w8L0T4/mEkjZG/EQIG/cXNoh5kH2V27ZAH7H6n3
         96m0e1bb5Gfg7+ZtOPxQzfQRvOoy+Nizxz8T6oKAsa+KE5rjEoglJGMoWqvi85O/sJ8c
         g5Q2muOyrYJRWSc7B7lL/BEf4BWISbOsZ1EiPmzxsds0MfwkAokDj9RRThkdaJ3fZY24
         3FXQjEjSYZfBPfy4nsi833zxOcX9k8M22oYiQJD6WyjBOO0W1ENLdVo4swgRUOxYgeVL
         Iqfm4b8GdXnK8KgLQvsCFYlE7BkWwyBkvL2L/QM4z58VpBxph+12kwJSMHBFguxSUZR5
         KFsg==
X-Gm-Message-State: AOJu0YzheTuws1UDO6j+qGAzJ4Bfzh8p7FJAQqTW+S471VB14U71S0Wg
	4bu88EeUqOxd/j6K/zQryHaohEU5Eaj7u7BG7xW17U2K+1Rsh/A01l/ES42LbLerKgXZh2XbNb1
	HQ1o=
X-Google-Smtp-Source: AGHT+IFIPgSe1BnZt8s8vHdQu3MvfvLZmTJRiXyoUifp8/k626wNn74aJiPn4RYTnyP+vrbT1PxBeQ==
X-Received: by 2002:a05:6902:dca:b0:e25:b49f:c8b7 with SMTP id 3f1490d57ef6-e25b49fcaf8mr4011369276.50.1727364156626;
        Thu, 26 Sep 2024 08:22:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e3ef9b70sm23616276.3.2024.09.26.08.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:22:36 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:22:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/8] finalize_object_file(): refactor unlink_or_warn()
 placement
Message-ID: <133047ca8c9aed3e297483b60ca3fdb02eb532a5.1727364141.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727364141.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727364141.git.me@ttaylorr.com>

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
index 38407f468a..5a1da57711 100644
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
2.46.1.507.gffd0c9a15b2.dirty

