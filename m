Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C022257C
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806082; cv=none; b=a+bfhMloFaCdedDRf2or/KE/EyrpptYAj87W8mA27xdaNq0malVSAA3hxgwW4GUFetRK2ILt8eQrArP4SUJ7vfcEim0tiYyhVl2vdOYf3jz+WOvWOicf0M3yxHJ4ro9xOVfqu2N/7uiEc1zr1r9nsqVWj7ElXXXZcryuiBknXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806082; c=relaxed/simple;
	bh=x2G/gSR53S+gBDMeCylX4V+CRTsu9Zs8MwxQ4o7L0CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7m0qzCRte/EniVNC+jo17dmZdHNFPckKyf4LOtL1e1JQsb3CX3dtMQMrm79/gj8a78+W0onLoQKsmqiOHXuqIqDkszyJzH0pSzMzaiKsee/IzAnisIZvAO2NLRXogGNWIVTEfQkUxRa9BtZnHAtujR2RxdrYT9Oix0oKazkPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4ccZLEA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4ccZLEA"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8eb195aso92526445ad.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739806080; x=1740410880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxEYeG4Vd1B2ekuwlbBLc16uhwTGPyvo/cYoCOnntoM=;
        b=J4ccZLEA6hVhG0wt0LjWySTnrTLLYEJG/eSFYke+NsUEObBa73oAY7Q0ZK0YMbVZNt
         fZR6RuJBkM5m/wMk7GkQ6WUi4Ax1EonkoAwb0Nml+7cn0CQmbYA/Ajgfh/Smj5vgvZVd
         BBHjiKte+PAmT8KtYc3fXbLm8eKQaj+zHA3UdA/CUjqhr9bAZT9AE9/iQvWnwC99/3El
         U2rSqvCzRVWmHpwrrm2DEBJg/wXMnmwlAttlAgDo6bkKqwO0GP9mhrhM+XqVv48ZCCW1
         cQEFo9XwHAO3G9wugqK0+f/yYDpCOdgEMzuhe8UyG5jKb76y/aRkxR3fYmbgcW8nOwnH
         XhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739806080; x=1740410880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxEYeG4Vd1B2ekuwlbBLc16uhwTGPyvo/cYoCOnntoM=;
        b=jUMrHww/eDlIU4Uj3gBoUHviTOJBG2Nk7MHokmYdAgg2GwCeZgJ1ylHm4aKBYKX9ug
         oYyMtwvHQs6fAPA3wWRp/mkv3Mr0n5K18L7Cd83hptMqwlS0cddSo1x/eULfgwVrde33
         4Ald8sQWgTNLlMhQH5yYPJ5vfOszcoyxlE77C1iofc/mikVDYzpL17Ycc6WQf/0oQIkq
         jydoXVJLrujE6GS6aiqdW12PB+u8EEl+KgT9JiPFw0odIVPrHJycmFY6UQ8CQ3UayDXl
         Az6rMg04HieK5sRF8RbB2YBLV8Rm0EKignU37l8nfOVQEskbQ9tRm9tcnG92ol0s2D+F
         JXCQ==
X-Gm-Message-State: AOJu0YxmlNGN030vOoEmfe1qKDeOl/86ZbvSq9Y7neIGJN8pm65tQK9u
	2J/Qda/wH8NujwbKs93KdsvHXH0fxRxv9sLkwL/WPyutVNvZj6116uER6g==
X-Gm-Gg: ASbGnctB9baitcR2Q8MPjPzaq3HwfQx27a84i80RA8rwIQimZZCYjfL6CkM84NI0lza
	8fF7/Bull9vWSM576iWtpKZ1Zui6vZYH/RTJaIPQgaYiDzPJ3ulJaBsqPymbFwPusbmKXVQF+Eo
	3Ls2xX6DTSvOf9u7c54btCcf0JPSCwdxWKXPnwhjVTh20m05ZEOROFF73+imjiSotHs2BCZnurP
	Y4kiFypEv3ThK0Jiw/qyGikD2MST/IgYrpCepNc6zCwbd0v0MxP+28dvl9XOHZJ3BzRaYN3ELmz
	RwvJ4iJxYtc=
X-Google-Smtp-Source: AGHT+IFqFwB3N60gjrHWr1fSp+zEy2JlO96umLCDoMvfztxJx7iI6VRgAKzVzlfJLnv2Wf81BCk+KA==
X-Received: by 2002:a17:903:22c7:b0:216:3e87:c9fc with SMTP id d9443c01a7336-22103efc0d3mr182092355ad.5.1739806079988;
        Mon, 17 Feb 2025 07:27:59 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556f967sm72379185ad.162.2025.02.17.07.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:27:59 -0800 (PST)
Date: Mon, 17 Feb 2025 23:27:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 5/8] packed-backend: check whether the refname contains
 NUL characters
Message-ID: <Z7NVfRVcwcNYRSL5@ArchLinux>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NU5fZfc8vfSvZ0@ArchLinux>

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
index 09eb3886c3..5edd2136bb 100644
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

