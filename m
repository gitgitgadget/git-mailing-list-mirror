Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F2268FD2
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489712; cv=none; b=N7mL5czgURc/Dd8SSdQCShtSIgA87BBSGpkQJI+CIXrV//ZlxJlT/pqaSX5PIPH8VlUNrwXI984Hf+zN4NUk3Pf5zPZqwS/QIpAIwnegKpWHiwP3/MrVwTPUkcRzqymitdmLySbX8XkfVZn1aDUo30w/O9x7ko3REu+vyyEtjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489712; c=relaxed/simple;
	bh=dKAVAYc+7Bgw7JZdcIMaQWdJdidIWFcAyAVzpmecRMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoFc8m/K3LrsUC73cIAUUPOgq+MTCmaE7zw/l4gmiOOwEAARoeAh6DfIdwTR7qewunFydUmUDcgYn7YBDcTzSOIOWNF4bLS45sO1N6I8IGfSf5k17m53VAhYP0f7HBWusA64DYqLgCRO1E0eoLqjkJN7/4U/ElTNodbqWz0hMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9lGVn12; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9lGVn12"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso8250347a91.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489710; x=1741094510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LmQ2YImWfbSfaaB+1MToiKl1REfwyXXn34jm8/oJLw=;
        b=V9lGVn12IzCMLkKmmUD1ebSUeW//5K/N9cBbWx8VIozQrvXjelrdh/ckVq12f64iiN
         mti+BxpvI9NngvNTTezS0t53azrGKaR9tkYDMsyH6ICl+vHB3/BiKWnF7ACfaKQYB6IA
         TNXkIL3TQ/iXhgic4u2bu1xwU6neftRZztFe3VccQ73WnHb2pONARDVf4uQF4EXIgty4
         bgYNRN0/q1BhnVvY4ntDS0Raz5Dn7+8/ACtj2ke1mjWqsp7L9g9v3VTD4NC52C86GvOX
         lSIeYKbn91ShivZ5dzhS1CW30OhE5EKc7LrKLhPe8Z/aMKr4U2h4J9PZnWkRNx58K3sK
         S6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489710; x=1741094510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LmQ2YImWfbSfaaB+1MToiKl1REfwyXXn34jm8/oJLw=;
        b=foF4E0cnGOs/06ZNJasXQhmjf1waSYievBMbQelNmb1qZD/W/1fcNvmh64lwPWa7mx
         +PgOsRc73/Rq8ix3AyE7v1KZ+QXXw6N0+W/JZ8ub4NIyDk9uCanICfInAZ+NOzfqoRJf
         jV8/ecdmPkQou8iCjySiKjsdTWiqy7NM6YL7mFVoN0TvMeKupWaiIAtIhEkLdlXedR+e
         OnkOQDJicEvsgzZJb17NDoZMHEOFZc69xz2e6/qtSsPNQ1FFV6mnpxKIgJSyAWsG5KnK
         +7cFMoy8TuNyeSkTTwo4MfFvhQ3uB9cyWyDkOJ8IeIJpsalGjaskYAEPFUCaK36kQldz
         GJAw==
X-Gm-Message-State: AOJu0YyOe2gw9K5YQb/ycumfDkwa/VRLf0BguKG3rddkgshDpwhCie6F
	URTBNKxA+hy6Y+82fYNSLgcH5p7qLM7beNNouXiP0wlYC4XzD4fsJpux6g==
X-Gm-Gg: ASbGncsfJEqCvuFdXkiCeKyNz/P3hIwHTbGZJWTrGdN7UkALRgQZOd7/0nIp43+hfET
	fmvINqu/NOIWHRZU3OgJViJU2Prbnw+IXuasoQxBzqqupuuYFiMFyRd0T6P/9uUqQ11GFHASQRy
	VxpN5vHvJjU2hP3aVaNHIcU7oYY9n+zrT/mG31b2AXiqnpJEh7CzHJUh2fj2inEvL7jPOKSKcWH
	9ZR/dPufnsYq6m255ECv+wV5Hgeu0BwPgx27uuzBmAEHxYw2HZ0qNskm7FZ2MjcF50pal8FkKVk
	eoyxM2r+rw50P0lbpsd0yg==
X-Google-Smtp-Source: AGHT+IEbmnizJr2fXSYkiTKZ51NwPlEtexYCebQR5JBfqcNA68kX5GpOzq05VNIWzjRXziAac6munQ==
X-Received: by 2002:a17:90b:4a41:b0:2f4:47fc:7f18 with SMTP id 98e67ed59e1d1-2fce78a2965mr29864078a91.10.1740489710149;
        Tue, 25 Feb 2025 05:21:50 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a092ee5sm13860485ad.133.2025.02.25.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:21:49 -0800 (PST)
Date: Tue, 25 Feb 2025 21:21:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 6/9] packed-backend: check whether the refname contains
 NUL characters
Message-ID: <Z73D9X_9Xsptgaif@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73DTwr9RicKMINe@ArchLinux>

"packed-backend.c::next_record" will use "check_refname_format" to check
the consistency of the refname. If it is not OK, the program will die.
However, it is reported in [1], we cannot catch some corruption. But we
already have the code path and we must miss out something.

We use the following code to get the refname:

    strbuf_add(&iter->refname_buf, p, eol - p);
    iter->base.refname = iter->refname_buf.buf

In the above code, `p` is the start pointer of the refname and `eol` is
the next newline pointer. We calculate the length of the refname by
subtracting the two pointers. Then we add the memory range between `p`
and `eol` to get the refname.

However, if there are some NUL characters in the memory range between `p`
and `eol`, we will see the refname as a valid ref name as long as the
memory range between `p` and first occurred NUL character is valid.

In order to catch above corruption, create a new function
"refname_contains_nul" by searching the first NUL character. If it is
not at the end of the string, there must be some NUL characters in the
refname.

Use this function in "next_record" function to die the program if
"refname_contains_nul" returns true.

[1] https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de/

Reported-by: R. Diez <rdiez-temp3@rd10.de>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4891c86a5a..a74ee57776 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -494,6 +494,21 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 				 last_line, eof - last_line);
 }
 
+/*
+ * When parsing the "packed-refs" file, we will parse it line by line.
+ * Because we know the start pointer of the refname and the next
+ * newline pointer, we could calculate the length of the refname by
+ * subtracting the two pointers. However, there is a corner case where
+ * the refname contains corrupted embedded NUL characters. And
+ * `check_refname_format()` will not catch this when the truncated
+ * refname is still a valid refname. To prevent this, we need to check
+ * whether the refname contains the NUL characters.
+ */
+static int refname_contains_nul(struct strbuf *refname)
+{
+	return !!memchr(refname->buf, '\0', refname->len);
+}
+
 #define SMALL_FILE_SIZE (32*1024)
 
 /*
@@ -895,6 +910,9 @@ static int next_record(struct packed_ref_iterator *iter)
 	strbuf_add(&iter->refname_buf, p, eol - p);
 	iter->base.refname = iter->refname_buf.buf;
 
+	if (refname_contains_nul(&iter->refname_buf))
+		die("packed refname contains embedded NULL: %s", iter->base.refname);
+
 	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!refname_is_safe(iter->base.refname))
 			die("packed refname is dangerous: %s",
-- 
2.48.1

