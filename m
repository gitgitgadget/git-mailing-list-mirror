Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53747849C
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736084997; cv=none; b=BRrsiwUMJFXoNfp58zjvUG7t3cTXQxVJ14UfJhIUB3gwlR2KSAIF1IipYcBnf12CbQ87PcktYBiAsgu4ph2Ui/afPVMFIioOBHRiNyRL9CinKcMMPZbvLkJZZb/wJjHkbMamosGAn8ZEUZMqMguro388O2rFF2wtij2JABAjNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736084997; c=relaxed/simple;
	bh=bTgRovIqaZN61VnZ5aaBXmpGOS31+O0dH+hWRiP9w+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Glz32h+hkE+uiFxKtSBZKJXf0CO8fZC69vFWsnQOlTiBXw02Qck3H82RIkDFO3VCrjmPPcD2beWfILaESTQq6sQ3NgKsQ/MtDhpatsjDqIPA2Xl/0sCDoY5gMYb7Veekk6blSu8MsFfhH80k6vbPMunNI56y9rwMlXDxzrH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxHkaZ7Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxHkaZ7Z"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21628b3fe7dso186218445ad.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736084995; x=1736689795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAHbQzHtWCo0OMNmKvqoMEqGnVC1+2onyD119bGj7dg=;
        b=XxHkaZ7ZIa1YMIXPWQIlozv/floQ1HFT7A0GM8FH+49gR11kaVb6Q1sQP6jMT6I47J
         WAs0WbF9sxDz6mg5XByQjAKYVK9QeAPaSwkyS0pFHvuymGGq2F8HLdgoyNBNQ27XOjls
         Sn2fGfYkaw78UQyPQ202/ywtgtRRaRjDzwAsVRJz1XM+B56dBWhgm5y+/nBrv6fSBZ8L
         ytOeQbMFm41aK2h5N7EvIrO+btFay+4KjLTW/pJMjWZK97XTPM+7+JSYT8LVk7jQ4BiK
         YKA3tl4OVO8s407sPBWmR7RCiYRjfj3eRQnhIisUY+5QbF7VS/n4N+yX7sHpq5ByyQDi
         ukWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736084995; x=1736689795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAHbQzHtWCo0OMNmKvqoMEqGnVC1+2onyD119bGj7dg=;
        b=fU8B9cdgxAZFTqtAhHUJhXHzX5cvndEQrPD9Pwk1vc6evRvDt5Rk7ILbnvPVUXoRxS
         A7Ypujc2reb4kePePawtq6Om7QyvFdWbZxKrH+TgAAHzR4RQE/QoiP/bqAX9Xpbcrtvw
         sAHfAbKC7dqMCXarutVXSPzYjt10ZUEzT3nbVSwWoDOVEF1iC/rH3mioYBwx77FYbYdW
         vkcLxBm7d+KAGQftuEX+JWdfJy2pCJEyPu7ZLtkdaXiQgQGZ5xa45KsoU0vXkmimidDn
         rtio7hLvkfzGja+xJnHFlMalwEDqLuna1pp2RiieAoY9i8SkhIngZfQ9Q80QgZti4R0d
         g15g==
X-Gm-Message-State: AOJu0Yyd3uPu+YJnvjOVHXyJJXx8T2BbwNOEnLFPgvKskc1Rdzm3Op8P
	NgvC21ee27tsed1X4uRiczFii+TAHdh2DeAWQ+fOVoVLRcLcd6QcMp1zEA==
X-Gm-Gg: ASbGnctnIpIaYA9WgWtUP34r0oJVdtdrGzrE97V3sUZ5kk5sGJSr6KMPCKw3CVJXhXM
	Shy72dbgqjhLsP4FBjl8q6ctGVDq/ZseZHJkNhvtAZmkKNrBCVZWpb8eZFLGCBSZ42D2GYEQhQ8
	hvap7P17WkBIG5M7aiI9q8+HTyB8MwDxCZMFcM22WI6bXAqVGhgmK11MPq4Tf6ROMiuI/wc3bXA
	Iue3QbVs7v2s1H3qQw/3JS1RcTcTb9M7ak=
X-Google-Smtp-Source: AGHT+IEI6bSUD9xiz6JqYGaHeNU5GrE1I04Yg2/uLpQClSD3YJIlyLh4spb0TDqxsEsONlUHbkCNHw==
X-Received: by 2002:aa7:88cc:0:b0:725:df1a:285 with SMTP id d2e1a72fcca58-72abddff55cmr75574440b3a.12.1736084995012;
        Sun, 05 Jan 2025 05:49:55 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81617csm29519100b3a.39.2025.01.05.05.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:49:54 -0800 (PST)
Date: Sun, 5 Jan 2025 21:49:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/10] packed-backend: check whether the refname contains
 NULL binaries
Message-ID: <Z3qN_8-HKdspwcDb@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

We have already implemented the header consistency check for the raw
"packed-refs" file. Before we implement the consistency check for each
ref entry, let's analysis [1] which reports that "git fsck" cannot
detect some binary zeros.

"packed-backend.c::next_record" will use "check_refname_format" to check
the consistency of the refname. If it is not OK, the program will die.
So, we already have the code path and we must miss out something.

We use the following code to get the refname:

    strbuf_add(&iter->refname_buf, p, eol - p);
    iter->base.refname = iter->refname_buf.buf

In the above code, `p` is the start pointer of the refname and `eol` is
the next newline pointer. We calculate the length of the refname by
subtracting the two pointers. Then we add the memory range between `p`
and `eol` to get the refname.

However, if there are some NULL binaries in the memory range between `p`
and `eol`, we will see the refname as a valid ref name as long as the
memory range between `p` and the first occurred NULL binary is valid.

In order to catch above corruption, create a new function
"refname_contains_null" by checking whether the "refname.len" equals to
the length of the raw string pointer "refname.buf". If not equal, there
must be some NULL binaries in the refname.

Use this function in "next_record" function to die the program if
"refname_contains_null" returns true.

[1] https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de/

Reported-by: R. Diez <rdiez-temp3@rd10.de>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3b11abe5f8..f6142a4402 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -493,6 +493,23 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 				 last_line, eof - last_line);
 }
 
+/*
+ * When parsing the "packed-refs" file, we will parse it line by line.
+ * Because we know the start pointer of the refname and the next
+ * newline pointer, we could calculate the length of the refname by
+ * subtracting the two pointers. However, there is a corner case where
+ * the refname contains corrupted embedded NULL binaries. And
+ * `check_refname_format()` will not catch this when the truncated
+ * refname is still a valid refname. To prevent this, we need to check
+ * whether the refname contains the NULL binaries.
+ */
+static int refname_contains_null(struct strbuf refname)
+{
+	if (refname.len != strlen(refname.buf))
+		return 1;
+	return 0;
+}
+
 #define SMALL_FILE_SIZE (32*1024)
 
 /*
@@ -894,6 +911,9 @@ static int next_record(struct packed_ref_iterator *iter)
 	strbuf_add(&iter->refname_buf, p, eol - p);
 	iter->base.refname = iter->refname_buf.buf;
 
+	if (refname_contains_null(iter->refname_buf))
+		die("packed refname contains embedded NULL: %s", iter->base.refname);
+
 	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!refname_is_safe(iter->base.refname))
 			die("packed refname is dangerous: %s",
-- 
2.47.1

