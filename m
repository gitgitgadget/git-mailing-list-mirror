Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937470;
	b=mjKY6sPUaE9F+YvSin8WtnhVDfKgwp57u/nV3Z9XFCoufigeZzviH4SlojGuecajN5jY
	 cPbCwKnU6Sa+D3Wdc8IrYbPJvp4C+GOGOC9XvSjLB/wEDutOROQXwLHaaw5YRbrnEd3ZS
	 JRg89NAmbGnM/t2BVCzei6MpWCttUnwbq8FWudnuNsEWxrKmeNVx6aDuf5VUmfv1l8PxC
	 r6NznK0YLdH3ATPrB9LR8WI/C5hmfKqIrr5cIzsZTOd73MEFHlZ4/zVhpHx1oo/NOiqek
	 PjbqudNENzVlxt5tsvb2SZNkWVAWoK/tzGkdylo5W9fWZhM0NZUS8RiW8er0hjg0wrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sY1VlcpKHnlcsEhyr0KqfRV1c1ZeBHTD5VE9cH1Ii9g=;
	b=2P4SZ5wRZlbgxNlGaOyccgngvxn6MSAE2M3baMjqzXEG2jCTBybFEz6OnFHmqQCpH7Pi
	 Qte9Jdqf1GdqYeNgyLc/fZS/AacnEAyjRLP5ZJzDTZ1ExLP+mi3kPcIqznok8DUUn6DT9
	 KMXho8YlSrLb1uQN/0ybCkJs/HDpkErlySP0aNqEc3Oo4v4klNUiRIui9ulePSxpOQSx2
	 /3/F29H/h1jtOZnicDfG0jes0kv+QkiBNVbbYyJx3OtQMTN2UTx0BKSUUBrfB6I8e/ooU
	 MK89nAFXBaZ/KT2b9RA+NaShYxFf1QBYS661s5M4b44BYyJ9/6ohuWRSY3EUTpnit+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6BLMW2O;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48A606A33F
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E48A606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6BLMW2O
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c50933bdf4bso288409666b.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 09:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937467; x=1795542267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sY1VlcpKHnlcsEhyr0KqfRV1c1ZeBHTD5VE9cH1Ii9g=;
        b=C6BLMW2O9+pyfGVFsiO3k7l2ODV8KJcnUYg5CS2/BMEqdYW1+bQEz5wOe0YOxVPrjR
         VPOIgDVssRV1ie6FPpGRZjfPDDtEISVSbJNPXQAvDpT7jS97fP7PHSnXejF6IuXFKPvm
         FlKmGJIULZd1agyffBC3gzHycULfb8lwGMow/gpTC5WLBz3ECZAs0eAE75wqItqjqQoK
         K63eITCqjaBVfN8dmK6C9DPv/uqFFB+u8DpOFaH3AwJBRC3coSt+VVfLNZ5Ob1hZngYa
         j/C65fl67ClKmw3DHg2mO1amiOGNOBfTBoujsH/kwDNyZa61LvPwsAJ72cyj9el3Zlsc
         PjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937467; x=1795542267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sY1VlcpKHnlcsEhyr0KqfRV1c1ZeBHTD5VE9cH1Ii9g=;
        b=W0aY8iWj2r/Ftw8IUxcd7UWb7hWnyQkJV0SahYkLGwihzcPy/5WKO104syNHpaRsNN
         dxL45jJIuer7INcOaUEYE/4RkzOp6ZiOauhGL/ZvjdO9DiYtWPGUACR8YH5O8cm+V+gG
         ax8CKg/u/sZmdsmE3jmiDznsx1An68bVu6MhZLDJpEzwOItxpkEXriumC5+D/2WLWjXC
         9USWYO8abH5VXhN6YSN0e9lAoV1nNR7ywCfxceH7VVvhDhIGoYWV3mtwJaS/uyOKn4gw
         v2cuhvg6EoiNOTASMnXFBmjuyJHXzkbp+kOiN9ySGFqkWm26NKYxNf95Q0rUf6+uI80H
         uqOg==
X-Gm-Message-State: APuU4Z//iYRy9rISwlJn4aXOqwsXgd5zbrTGT2LrDQ/g8fuZ7TmjaoeG
	WicdOnLAAx3WUnp9I4NJlwAra94RrXfPkGwY0SlWMdQSXTeLE//5Jff0Wn3Y6g==
X-Gm-Gg: AYBFou1Enb9xWe481pBbkXMzpi6wjrvzTdFfiMikM/ldQafWcO1ZQzU1tSgnuCkK7dN
	Ega7rG3FJyvovo2d5FP/peCXyarQM3K3exo1w8kT2Rz9Sftzes5lVvwipCxocI4El0RzeJvUAJ7
	1CfXjTx1MyiqduCRDRzmu4j3W+j5du68hZPFRT0DKRxAl1OqOVjP2DXktCrqeR1SvEY6yOv5BOL
	iJfE/5tn6x8+9oYvs0DqnRjyoz+5irk9V/+JYITsf/dhgRFtJFkZ07XBYsLRmzCo54jRYj1rnaF
	4cqQ9v6OKW8ZYMuzmgqy8MShW9wHqxvxRMjRmGHLJ+0j/FGsu65DjhN1I8ZhVvGEPW5HjQiGAUR
	DsN1OtsJBMgCRMcIJz3XE8y+3Wx3nwPY0lnh4zkPcHwp7edTX/01z0d4PYbZb0eVKi+3FavNTKM
	MEIyiYl1A56IrwmC25HEipphUfOIJDr22XXdm46lFUBXcYsJq47OTY49k7yfW/QV6ZGQSd3w5VI
	eO1NMslKCI1wQgCtTd5MrfoxBk1dX1aymJvY7+iBHVTsSXXYR9p49P1HoUlqadnRVaMrpCPZu4v
	BSbgIazfyDuTowaXFcTEkmPL6T5xYt3EXhd6Ypv0WzaAcGDYMUG9Yfc3NkK5opaaQgny0Oi0Ri0
	JMvADUdqGDCnVsCpYSaaORIJ8gc/FiSP7RWzYdyPt4JVm34trfvLpNwJBgAexxpD8FZU+f2MbQH
	rmwpGxG6jiwJz/NUee/uWpFSLiq6Mrmi34gnveM4Q=
X-Received: by 2002:a17:907:1611:b0:c25:4d9e:bb28 with SMTP id a640c23a62f3a-c50f320ca48mr331252466b.3.1794937467528;
        Tue, 17 Nov 2026 09:44:27 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83fe47sm7947366b.5.2026.11.17.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:26 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/3] notes-merge: use size_t in write_buf_to_worktree()
Date: Tue, 17 Nov 2026 18:43:55 +0100
Message-ID: <20261117174353.1158905-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.495.ge87f5c5eed.dirty
In-Reply-To: <20261117174353.1158905-5-christian.couder@gmail.com>
References: <20261117174353.1158905-5-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write_buf_to_worktree() function in "notes-merge.c" has an
`unsigned long` size argument, while its two callers from that same
file:

1. write_note_to_worktree(), and
2. ll_merge_in_worktree(),

both pass a `size_t` to that size argument.

Since c6a4629e32 (odb: use size_t for object_info.sizep and the size
APIs, 2026-06-15), the first caller reads the note into a `size_t` size
before passing it on to write_buf_to_worktree(). On LLP64 platforms
like 64-bit Windows, where `unsigned long` is 32 bits, a delete/modify
conflict on a note of 4 GiB or more therefore silently writes a
truncated note into NOTES_MERGE_WORKTREE.

The second caller passes the size of the ll_merge() result, which is a
`size_t` since 81db32ddce (Merge branch 'jk/xdiff-size_t', 2026-10-15).
That size cannot be truncated as since 1c93cc03ea (Merge branch
'kn/safer-mem-arithmetic-in-xdiff', 2026-10-16), xdl_do_merge() errors
out if it is greater than LONG_MAX.

But we want to get rid of that `size > LONG_MAX` check in a following
commit.

To fix the truncation issue with the first caller and to prepare for
getting rid of the check, let's convert the size argument in
write_buf_to_worktree() to a `size_t`.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 notes-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes-merge.c b/notes-merge.c
index d361e70a48..4b010bcfc0 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -310,7 +310,7 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 }
 
 static void write_buf_to_worktree(const struct object_id *obj,
-				  const char *buf, unsigned long size)
+				  const char *buf, size_t size)
 {
 	int fd;
 	char *path = repo_git_path(the_repository, NOTES_MERGE_WORKTREE "/%s", oid_to_hex(obj));
-- 
2.56.0

