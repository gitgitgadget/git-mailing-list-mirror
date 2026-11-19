Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047655;
	b=kP/p06t/p123zcvLT29Q01SmhMqODhV/4pnFQuN7fK5nnb4IUXAdtDXI+7vOFm2JPPH1
	 zT8XZHR22i1oF9S1p/hDaABPWSGNEd+7VXCqVi9oYxJGIdrjeXzY0jdmSJngPamPTt6Ki
	 ficRtpbS4mcgTWtztVqwcqcjfW84WMWOL/6o2Pcu1pveyfcT8tBuVgjTXlKbwU9ddIhGU
	 kAG/j1FysEVd2pUtwXxPAE7rwRlLeev5BKktNGDDTnIxrKJUcXZymG5qd6v9BYE5Uq8ho
	 NsFk2IoAAZ7ZFxJFDbXR29IyNWCbBT73SjjtYa68T6XPSZtrT2dJzdWPFTQXQWuH90g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xpD80DimQYgR/0e1e3paRzNhCO1o9FKm31PzSwweQis=;
	b=QCc2t6p7IOqfLiW1+UpBEJRmNCXacv6NbXw5Po20fODxPBZGsHM2JUoCYJ5CvTuywupn
	 6XjGPbm5UGWsVJfgvvVRgtYN3Wjg7pkHtF0ZIWBJkZqvJgKGmuO7S5+jh8M+/Nz1fxvjN
	 hporXUZUjEQN2XiaJ7MuOgaRS6yNel///rU5Id1/4+cRwKZfFhEY6JYWP0PjOT0V6cU3L
	 x2qhJpgmRDDzhEUsrFQ80YcJYyb3r7dQWamB9CcXGaxG/b1SmeRYTEzx4RQDetJgYpemV
	 sVKESaxWEeiF15LLJ1j1SwG6q41PKeemb5qbKAUNCJ+uLtqvQTQ3sVYJDegrDsK2KPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nXIlTAV2;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A9606A330
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 00:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890A9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nXIlTAV2
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-716d052dc23so886984eaf.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795047654; x=1795652454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpD80DimQYgR/0e1e3paRzNhCO1o9FKm31PzSwweQis=;
        b=nXIlTAV2njQOzNq00qv0RaiLSU+5hy6jWTuF+b2oB6z1WFrsFtpMdQQdiMjfRoN+0j
         qfkRRHsBWr2d8FVHuurIaqSQPAHXVlpLZpqNiG0JxFnZQt+qQMu3TwRZ/JkNYukgpMxD
         zLh9Ubs/m9nmQJcGMznyMnBvlPwOgxlQMETka0bs+EcUSzWVPal9pPiZXZvdi4DDHUbB
         fCSZ8ctlsaiBVZ288SPwRiOwmJaqT1t0m6cpo5gmtYNsgVdVjAaIBNtj9XNhrIQfRCb/
         XSUnSoqyU7ljhkxx5k9+8RTkDOO40JM8tTHdtmmja533O02nDmjxOL5G50jSya1xDz7Q
         EjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047654; x=1795652454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xpD80DimQYgR/0e1e3paRzNhCO1o9FKm31PzSwweQis=;
        b=V8UfbYDT2fDgjHMD5EgqsRaMk3j80IzFqp/Su5cNxZM1gpoWSngs9nl/UtQmtrxjDE
         84CdWPk8oMwx9tRVExbMgQqLueu7v5LHv+cIY+f1E7f7FP+1w1gjXDIxYtxKR68VaqLi
         DVe5IP9fYNJetAmQ8EmbGifgHJ0oFPJOGcnUZvap0nPeOzRFnPpZNzvFOGMAlhd9t3AM
         2G7JC5KHn/sIspR/zQky5esGJ99OuCQOauKXqu71656K+zIlKjlSZjC28tfyXArDZLe9
         3KJe6PB4FN1steQgNJ+zBhxE3BM0+VBdaadrvg5MRUbWDHn82eUA9nH+dmsdtEiXMe65
         608w==
X-Gm-Message-State: APuU4Z9FhO9evz1T5d3A9f8+Fk58oC8NIjCbR9ioUE8rQq0lUPOI7CDN
	pjZCtv8Tc3o0AkXyZGiCTDeFlvmXyne0Is0lBlbt/FdWyqSJ36TCWDsAtdALsg==
X-Gm-Gg: AYBFou2C30Iclhzim6jstLB/Gcn037fdFgtSEEeO4Y6uDGWnGKrg6+3145Q5kZF7cXQ
	kxeD7a9+RS4ldZR3VDNDaXbau+gZrXLcs7/VhzVEGW4wdAud9zMqL4nVVYj4sgJudaMTU1p68Gx
	pAbD/cBKRCB9dJGIA3D6dnbTw2E2b2bufy89NfzpOtSuwbBb5uMBFE+cYRuKeR36x890HM/brht
	VphsHYg9n8pQls0KkTrXOB14TiixmtPyftcs/y+S+i7M4o6T+9Duco2yqCN31jwier4vxQgc27g
	hxnDhBPGOtD5CdLLKrPmG+7XcNgp/bVU/8a9awND0GhZIrCbpegNi7lSF8B+T9JAfFouiE7AU2H
	DZzHuc3BG8UQlLk1uxQ2QtZMKaoYtG/Ou2Irp6K1r20p5WYjCYl+zACbA6F+Ot614EL0atsbCtH
	zxBVsMDq8GripG5CKeVShYSUQR7xolowakGWQZ6Re/9eRR9sxSDaYsv6oc3pi55SpOyI8AopUgb
	ndVYGkvgnJtXJw3uFv+5Ask/iEzaO/5TuZ0Ve0Ybg3No1LgyJcYPn/oOS0YpMhIz47g+O0whB/D
	ZlZpNlLk3vxdkU+SsaOiPMdJMLD/yaaGDtBROLvIIXPUV+agLvyU5ucpBp6V0lPWyAjK
X-Received: by 2002:a05:6820:480d:b0:71a:f794:49b7 with SMTP id 006d021491bc7-71b185845f9mr2921450eaf.54.1795047654439;
        Wed, 18 Nov 2026 16:20:54 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d492dsm3293400a34.6.2026.11.18.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:20:53 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/6] object-file: rename default transaction prefix
Date: Wed, 18 Nov 2026 18:20:38 -0600
Message-ID: <20261119002043.2108654-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261119002043.2108654-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261119002043.2108654-1-jltobler@gmail.com>
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

By default, the temporary directory created for a "files" ODB
transaction has its name prefixed with "bulk-fsync". This name dates
back to c0f4752ed2 (core.fsyncmethod: batched disk flushes for
loose-objects, 2022-04-04), where the temporary object directory only
served to batch fsyncs of loose objects.

ODB transactions have since grown into a more general interface for
writing objects though, and the temporary object directory is not
inherently tied to how objects are synced. In a subsequent commit, the
temporary object directory is created for every transaction regardless
of the configured fsync method, which would make the name misleading.

Rename the default prefix to "transaction" accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 132aaab6f8..201d9d6490 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1566,7 +1566,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->flags = flags;
 	strvec_init(&transaction->pack_names);
 
-	transaction->prefix = "bulk-fsync";
+	transaction->prefix = "transaction";
 	if (flags & ODB_TRANSACTION_RECEIVE) {
 		/*
 		 * ODB transactions for git-receive-pack(1) eagerly create a
-- 
2.56.0.173.gf57c9a7388

