Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B71D7E2D
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651976; cv=none; b=Dx9/73TQxsjt5W+gudPhgWi77cXEYzzjwrqpD9J3DQZaGcuUeMVPrTAmHUeVZ3D/in0smMbJvPCGENuxqqWGXstHrqslUue7w/AqzqS+xIr6kepfrtMGi8bYFptmvKpNM4nW68rCIe7J2yFOkS9f0+cr67KJ2ZYUdaEzmHvV0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651976; c=relaxed/simple;
	bh=4d6MxlBsn3ZVo3gEyXEnWUD5FyCn0c6Yj9AZ4iDsuWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWOAuJWSHZsC8LDVacMneH4FUuUtHULtq2WbHq8kp5L87fBX5bYmBYvdMMaJ3xbZfKHTeqNL/CmewlpqojGQoDnBOxgRgNA5XMg0MfHgTQU82Vcxr9KZ8jHg9bNqLnHDvf0vZe+tE3P1M8260qs6rnRfEY0qjoM9K8YJZs5ANQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GY3gUCCx; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GY3gUCCx"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1d06c728b8so2564469276.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651974; x=1726256774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2AdznxtXuiwMeRh1I/dRJwIOrYwjvmsFrfIxW7lzP0=;
        b=GY3gUCCxj+B6sFYLs3jFK0DoJ5opegGXug3yaenrO/Ysp380r67cc9wUMSPVCTaN3T
         a4r3dlkS2gJWSLgSvFHf77pLutznhGFMcRORsGibjJIgUfqt/sunwBk2Ub+UL3BnZNhd
         M4V43+Vcoo4U5lz8b6OKqQ5JUqCkEuTNcw1Vt4v12IbkK7fAYqMQo4SF1+fgigmrgr/5
         OzPZYqaV77TsLPmc+u9hh4OWflCvhBuQXXIa/KMNKzpYKxPhheQ1vmYbIU5IRIfpevTo
         z8txaI2WMhnr2zYCrQJxTevVLHGtGiXtJ8s4galTHQbFX9clpZU6RYM9y97VfFRiMwNm
         +TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651974; x=1726256774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2AdznxtXuiwMeRh1I/dRJwIOrYwjvmsFrfIxW7lzP0=;
        b=eEkvhQeNqdNoJhrnItEalGiS4pOQaLWZui1JULc3LSuxIfYEWjd8Me5g263mFkfu74
         SpVbyEsNL3MfBsEnBeDcq/jXnPbs83MWMz3H7q+K2dTBimOGh80Y2IgTZKT/kXtZa4t6
         cAwYiqYAcdosjmO0OkyoRUxv8YOz0qeAkfQiaBeZ6gAvM1nDgFjI4vF+3imU9eQW1dmI
         i5hCvLEdxtWRV7LJ3T8uwc0Ajb6Wj4QinoNUg4p3UVtGOEAY6PLWCJxOLOAnPItKbw2n
         76/Smz7z+d8sgZUfHdOx7cUqtk0qi5cgSTC2J1a28yH8hV8ENrvy4TiXLegCXIXG07Ql
         cQNA==
X-Gm-Message-State: AOJu0YwkUeDb1TPx0ebyIlF1lGbG9oxzWnV4RuW445CALd8zAdMHtCtJ
	2irXeDLSWEtClq8XPgQUVrKsfybd3d64MGHIQBN7BkHTi5PI+nTlzIj4CTUgHH2/U487mkYUwPE
	5j74=
X-Google-Smtp-Source: AGHT+IEviLb5og7jvd4KGGqABIG+han46PDUPiIJ73dtqEaLIsSiy6Dpd/53wIAza6LXyJreY0CDRA==
X-Received: by 2002:a05:690c:4911:b0:6d6:94b2:f3e4 with SMTP id 00721157ae682-6db44f2f652mr51157427b3.26.1725651974096;
        Fri, 06 Sep 2024 12:46:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db565e6026sm1112407b3.145.2024.09.06.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:13 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/9] finalize_object_file(): implement collision check
Message-ID: <0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
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
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

We've had "FIXME!!! Collision check here ?" in finalize_object_file()
since aac1794132 (Improve sha1 object file writing., 2005-05-03). That
is, when we try to write a file with the same name, we assume the
on-disk contents are the same and blindly throw away the new copy.

One of the reasons we never implemented this is because the files it
moves are all named after the cryptographic hash of their contents
(either loose objects, or packs which have their hash in the name these
days). So we are unlikely to see such a collision by accident. And even
though there are weaknesses in sha1, we assume they are mitigated by our
use of sha1dc.

So while it's a theoretical concern now, it hasn't been a priority.
However, if we start using weaker hashes for pack checksums and names,
this will become a practical concern. So in preparation, let's actually
implement a byte-for-byte collision check.

The new check will cause the write of new differing content to be a
failure, rather than a silent noop, and we'll retain the temporary file
on disk.

Note that this may cause some extra computation when the files are in
fact identical, but this should happen rarely. For example, when writing
a loose object, we compute the object id first, then check manually for
an existing object (so that we can freshen its timestamp) before
actually trying to write and link the new data.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-file.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 54a82a5f7a0..85f91516429 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1899,6 +1899,57 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
+static int check_collision(const char *filename_a, const char *filename_b)
+{
+	char buf_a[4096], buf_b[4096];
+	int fd_a = -1, fd_b = -1;
+	int ret = 0;
+
+	fd_a = open(filename_a, O_RDONLY);
+	if (fd_a < 0) {
+		ret = error_errno(_("unable to open %s"), filename_a);
+		goto out;
+	}
+
+	fd_b = open(filename_b, O_RDONLY);
+	if (fd_b < 0) {
+		ret = error_errno(_("unable to open %s"), filename_b);
+		goto out;
+	}
+
+	while (1) {
+		ssize_t sz_a, sz_b;
+
+		sz_a = read_in_full(fd_a, buf_a, sizeof(buf_a));
+		if (sz_a < 0) {
+			ret = error_errno(_("unable to read %s"), filename_a);
+			goto out;
+		}
+
+		sz_b = read_in_full(fd_b, buf_b, sizeof(buf_b));
+		if (sz_b < 0) {
+			ret = error_errno(_("unable to read %s"), filename_b);
+			goto out;
+		}
+
+		if (sz_a != sz_b || memcmp(buf_a, buf_b, sz_a)) {
+			ret = error(_("files '%s' and '%s' differ in contents"),
+				    filename_a, filename_b);
+			goto out;
+		}
+
+		if (sz_a < sizeof(buf_a))
+			break;
+	}
+
+out:
+	if (fd_a > -1)
+		close(fd_a);
+	if (fd_b > -1)
+		close(fd_b);
+	return ret;
+}
+
 /*
  * Move the just written object into its final resting place.
  */
@@ -1941,8 +1992,8 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 			errno = saved_errno;
 			return error_errno(_("unable to write file %s"), filename);
 		}
-		/* FIXME!!! Collision check here ? */
-		unlink_or_warn(tmpfile);
+		if (check_collision(tmpfile, filename))
+			return -1;
 	}
 
 out:
-- 
2.46.0.430.gca674632b70

