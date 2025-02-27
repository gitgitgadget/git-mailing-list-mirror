Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611226FDA2
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672394; cv=none; b=DFi2uaPjpFeg5WN0hSls8Fw/hIzu/i+bsxgHn/TnIu8Das5LUj+C0axR3dOMx6X45dLQnaRE1KezUqKFqrSOBZ63Bqh5AK09I15dHnOiHGGSO5V3RHX5ROFDOrrdfrkmTDlhxWae85YCfSEiBH5Q3fzNs6HgnkApW3yJ0zQJBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672394; c=relaxed/simple;
	bh=ykrZGVhSQS6WOf+LDIsRt+UprTRRky3UsT7t5948bOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3wzhyFsjnT738q/H2vcfedFZ0ccSzkf0A/W2caDj2+U4Jwag9UYSBDxscgvQeaIRo7f02qUof9WLnwsaZj1NKqSAAJzdkwrq0CtRnR4t7A+3ynGLnJMgfh76ZqveeVe0JVvKJzaMNAjIFuBZrXnbLLb1AmszzZaC8/LsduuQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGq8tQ7h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGq8tQ7h"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2211cd4463cso22446125ad.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672391; x=1741277191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7XT3daXkBorwta0rfNnIxl1qc9PNm12+Xe0QGcmoiU=;
        b=QGq8tQ7hnDYO6Y84/2HCgac8tYSfkHK3Jt+MXK0wsEn5QSLxgAMwLxWRW7pn4demqf
         2YIj6KIJL+saNPoZCmJBuNQNmoq8WaYawonkrBwgkvx+5k1HIBSCvBan9R+W0p167Hw+
         MMYKsaq+A/h2MAwJ1mQeY+wRbeisJ3agYx2lqpfN8Zo9G+/nPQvk5rucq1zCaGeerOCa
         ADyM5Ez+KhciL3KORQG/dS2ct9lMsPVcwDGpJZyTtKzNolkq6cA0WdNP9ekNU65g6R4I
         MVCqmb/Vv7IvOyudmYAkk3H+iLzQA9RaxtTgpMdJuRnTCPofzehHc1E6NS27HECA/TkV
         yVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672391; x=1741277191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7XT3daXkBorwta0rfNnIxl1qc9PNm12+Xe0QGcmoiU=;
        b=ewS0iQU++ozQlPfVLmUy4i1W67YqUhVEsSefT6V22El7BrE+N238W8UFt5oDZGazOE
         rs2IXsEPfdLC/duUrtbYUU3bocowQVI2qShbBWZwVHdhX1gr9gFFibzgmED4tFBPSuM1
         RhhKn3jPsdwb7VvSfkueV++pWprFFQlCM+ymNccA+CgU/Nt2yp3PsA0VNLdQBNYpY0Lu
         weeLIIeMBvQNNQ5h/QZ8Mfu/oAhQ+6pi30HgRyglVZv5163vJ10Wey9eqb39MkPiUCB6
         2AVk+K9Ip1XdLGRJA47NVtnax+5+VB6w3qHlXg5uy+GEjKsHfZots37cx+YdYxOkoOuK
         pasg==
X-Gm-Message-State: AOJu0YwjL024PLPcLz3H29N3kJZXB5nlsupXWEUBGcdQYkHYs+Geact5
	9fDNZbUqQK4NcwbyeD5dvmz7ZlNxXjswsdnP9bT1TjRIteH2pbLicL9pbQ==
X-Gm-Gg: ASbGnct/0Zn34hermi7KIFABxOR3B90VuybsMF36q7BC88RvD7dDE+8JvaRwCXDMLqJ
	wjjpQ875jTQQHh+QIa/0BbSImh2jVnEFZfQ6uJGuyFjiwmIgt4R92phJL3qQOlVnbPFQXs8xL+A
	URofbEqhIUwDkenv6gG8vstMQ6sH9A2P0qjeOVsI4NWseerVevr/oRy0cME6RY4RkEdsvhTvH9t
	BsBBMM0CRDW8rTATuJLa+P+lzq71RAfEy/8EZ0/aVtBFvYRWbyZgbaF7oxU1aPznI2ox1iEhwOj
	EcI0SBgHTa4dxROkpl/tnQ==
X-Google-Smtp-Source: AGHT+IFvsrZJrSus0YI/g5JiYQSQ7zOvO7bQ0LxywIn0gzBR5c9fCJo63S030GDk8ag7fKwG9sExlA==
X-Received: by 2002:a17:902:dacb:b0:21f:3a7b:f4f1 with SMTP id d9443c01a7336-22307e675f1mr193570185ad.32.1740672390818;
        Thu, 27 Feb 2025 08:06:30 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504dc948sm16566255ad.175.2025.02.27.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:06:30 -0800 (PST)
Date: Fri, 28 Feb 2025 00:06:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 4/9] packed-backend: check if header starts with "#
 pack-refs with: "
Message-ID: <Z8CNkGJjKl0eTolM@ArchLinux>
References: <Z8CMx7O19PMs9sVY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CMx7O19PMs9sVY@ArchLinux>

We always write a space after "# pack-refs with:" but we don't align
with this rule in the "create_snapshot" method where we would check
whether header starts with "# pack-refs with:". It might seem that we
should undoubtedly tighten this rule, however, we don't have any
technical documentation about this and there is a possibility that we
would break the compatibility for other third-party libraries.

By investigating influential third-party libraries, we could conclude
how these libraries handle the header of "packed-refs" file:

1. libgit2 is fine and always writes the space. It also expects the
   whitespace to exist.
2. JGit does not expect th header to have a trailing space, but expects
   the "peeled" capability to have a leading space, which is mostly
   equivalent because that capability is typically the first one we
   write. It always writes the space.
3. gitoxide expects the space t exist and writes it.
4. go-git doesn't create the header by default.

As many third-party libraries expect a single space after "# pack-refs
with:", if we forget to write the space after the colon,
"create_snapshot" won't catch this. And we would break other
re-implementations. So, we'd better tighten the rule by checking whether
the header starts with "# pack-refs with: ".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1fba804a2a..eaa8746f3e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -694,7 +694,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 
 		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
 
-		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
+		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
 			die_invalid_line(refs->path,
 					 snapshot->buf,
 					 snapshot->eof - snapshot->buf);
-- 
2.48.1

