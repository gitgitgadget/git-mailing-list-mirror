Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC637C933
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321937; cv=none; b=f6JhU2ba/Z9Gw2Jh07rhRkvd6JGpwulIuhB9+mYieF3qT/ze++Mp9jfYVNJEIXF2fYsn0lLrafczr9dhAJmBdYn/xBDitXj6EImI5rCGwPRqhqo6f/6VsCAfwvE23nqQ/Lju3pHdbS83fRNYL55X/Vy7iuDpJCozV8ZOziaC8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321937; c=relaxed/simple;
	bh=74IJSJ7MWBrWzai1KyBaG6lYMesQZDZGq4FNxmBh86U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBp8KvwtGAkIM3vfE/sDRDVj0tdn8BUCkQxClhQ7Ech1cGFJQ2FfyPzsnZ8EaPQE05BIUdyDX2EU0ZmJ1Qy1D2eb0wLxTelr1KhxkGmQ9JjqlXemyk6mdi60l55AcM64HH2oYEaXVQllWOZl3cKGQ90vN9ngFhDubjMcgwnPu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAXvyWbW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAXvyWbW"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ebafde87cso6680964f8f.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321935; x=1780926735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=epFUyCtI18Pa6JvTWQfYBZfSZLUmJy8sUv4xXPYIu/s=;
        b=RAXvyWbWcbnzGb2zW9K+EJrwwR/ESTdGhsixd6SytJ1uLeG6VL5D5P74yrqSZbf5KD
         8SRPzqc5ukVuU1ieqDDgleZ8LT4NqPL8EPOqIvwXa1yQqGxZJrbPr9qtuTWua7ZaxKzp
         nZuiqNy8ieUzTLD8gU+la8vhkfY000Q4HGh9jv4aMgzYZJ9amirFh2qe1UKPuc1AaXMp
         oJVK3C1H1UgkV3W+r8+8QkKa3nLArr0kGfr5DJdc1XuXSF/tk1B4iLR5bQmUhQ0BUnHH
         dRhTu8AvwYr1AWgsfmmrGFRJouEGAC5c+v9RJyVhy+NXbxykJpUaNKwjMTisBKiWqSRU
         ayqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321935; x=1780926735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epFUyCtI18Pa6JvTWQfYBZfSZLUmJy8sUv4xXPYIu/s=;
        b=Qc3R3INkdH659tGL7Ym85bH3MR/ksMr0uUZePy6Wfaj4a6DgfFLD1HAfXYpfVMi1Mm
         c+IrJr4AHfXCJHdSBi3t2zu7euooHvvrje9v8SBBYdcQ5T6iZbYzZ2zaot6I1mQUlJ70
         abZcByYsmAvvwpgXiEth0Ai9W6MwbD8G5rowp6yvSnZgKP2agbYLWyYI8jK8qzDGgxeF
         iefsSHHbQyTi7OuMgXelGlf/2N+yDTdnplWSsoXUaLS42A3aqRbI2k9K1zjBZxP+K39a
         4AfbQ2myLrR34ja4s4A9zfH6yk+/75NTnW2zY2W7C6IGCysDjtRIoyNBqXiciH6GrXmb
         EZfg==
X-Gm-Message-State: AOJu0YwWbhUNpvxZ61Pa9iqB7E3IlMk6uXJR3ikpgW0m/dCcRe4HFoQ+
	05aNUKqCtlNvlUcj3VrXa1XDAdUECoagu2jKuiwD1AC48MtTxRJUyzCgp3EtRA==
X-Gm-Gg: Acq92OFjJXWsBFVI30j/3sbDcqgqtKfnLV1xnZ2hEZGDbWlq8+gh6Y52WusbLoy4qyJ
	SnoZ42ai2/A8pb+EtgRpwg9wFIkx1BxcCTvAxImgh3l0yW21ZreZ1S6rxX0SQUSLpFdHevAaejA
	t16w0SASFrBY3ARmPMkOlbupcP6pfMJB2pCQnGuf3BmORygT+czQ4u8n8wwuToWhHMun+5qvvvF
	HMzKQ/BcivOUY9UyYTCaXchFEfD3zHhkQnfSBS+YzrMRA+8laNiWvv0K2//5DuJUHdzb4NnSsiA
	qQU6tK810YZ7znrYiLHPMoaKp1t1bxZw1c+niYTMZZ4pYqUg3ogUxUqlRaP0l6sEE/f2xMPg2LU
	8z8bRfdD6drqPwRc7iZqyeVywJd0cOnaZXFiR8vVvAyzGdEphePVb8QprAYFIIFa/Lyuke0PcDj
	bStIwsq2pZICbGOwWbfpgaeHVflFEM/s2RjS06U/7TPuE0O8yMs8Og3o2fIFtKe0aD39RDu0yTK
	w0hsl/FG3xiVvLOLJ/3bZqJvKmSowzrfQ==
X-Received: by 2002:a5d:6192:0:b0:43b:3b80:6776 with SMTP id ffacd0b85a97d-45ef6b88abemr16451535f8f.30.1780321934666;
        Mon, 01 Jun 2026 06:52:14 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef358c07bsm26377008f8f.36.2026.06.01.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:52:14 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:52:12 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, fox <fox.gbr@townlong-yak.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/2] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <e5b2347a4d48841e5dac33b6f36b6200d50a84c0.1780321770.git.lorenzo.pegorari2002@gmail.com>
References: <ahjUmMCKxREamQE-@lorenzo-VM>
 <cover.1780321770.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780321770.git.lorenzo.pegorari2002@gmail.com>

Inside the function `fetch_and_setup_pack_index()`, when the pack
obtained using `parse_pack_index()` fails to be verified by
`verify_pack_index()`, the function returns without closing and freeing
said pack.

Fix this by calling `close_pack_index()` to munmap the index file for
the leaking pack (which might have been mmapped by `fetch_pack_index()`
or `verify_pack_index()`), and then free it, when the verification
fails.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 http.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index b8443b1ef4..99da4d7529 100644
--- a/http.c
+++ b/http.c
@@ -2543,11 +2543,13 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
 	}
 
 	ret = verify_pack_index(new_pack);
-	if (!ret)
-		close_pack_index(new_pack);
+
+	close_pack_index(new_pack);
 	free(tmp_idx);
-	if (ret)
+	if (ret) {
+		free(new_pack);
 		return -1;
+	}
 
 	packfile_list_prepend(packs, new_pack);
 	return 0;
-- 
2.54.0.129.g2dffd77b94.dirty

