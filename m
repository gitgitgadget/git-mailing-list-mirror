Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509665;
	b=pRbbX2gDaoG/l9WbfWYEFmGT2UV4O122XZRXH9zu0QsB+AnSh9jtmF+U55atzExqwkBs
	 JfBDjFsJbF6urUBPIDD9Mgd7pmkBRJTTOwLgZkdfX2szXGTp2AdCoX2RwWJXXehIt9v1T
	 IVhTIc3L9ozwr0xl9/s0/f5cMdPAHIDxPV58dxY1gN6nTq1oGI3944nISUrEhkLmCARPg
	 bmPoObl9UE74PBEARV7/Cnwzi7z4DrOUkRzgAsrf8XuSd2o+6KMM5s6GBSggYJFbKRbbu
	 /SRI4kRC1nlQo2nSk+G5Njo3IQg6N9jBft3Nl2PCE7ST+DV5ipgN2vQpSvySiW8hjMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YmBMpzBjUGW8YNW8Rn0paVufGdRLWO7YVdcWv5LCpzw=;
	b=Q03CqKcw7bTrkmWDyvoh9fbcOkFEP8SMoXemcf+1QX6XA/hwC/fY5wTQs1s794PyawnX
	 ub5FQ2Oewpoe/CbvCnKpnIbnyzh9Hv06ybYa9rTG9uJDcdm+u7oz8Z2JMr8PEiJO6C0Rq
	 2ZDKvH8zOJtfoSPndvYMarggjK/9J8edjqHH2m0L4R9RAk/eJJFUsQHO44HQIdCxYpgap
	 Dp5hBygVNnUqBGAFANJzUSQb3fD7QMTGe36LuyDulyBchV/mo9dR9JUqINGmHidck/kq7
	 KQOLVT8HYZ/0wldf0GOwZg1gM3s9d0qRkqrdIJg/Cyo8Q7JyQjoWEiqGGjgpf9JW+zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rAZWFs0D;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A546606A33C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A546606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rAZWFs0D
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df8fe8513so2936832f8f.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509664; x=1793114464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YmBMpzBjUGW8YNW8Rn0paVufGdRLWO7YVdcWv5LCpzw=;
        b=rAZWFs0DDfW5R766BevygVWBynp0E+848xn9lkvOzcVW7svgNOojGRz1eJDcHpYBbG
         BvFk+9UrLL7oI3z8VUdYAIs13XgVb5N2k2f2Y0qP+7WpIC59Pg8Lry+WXDlf4XfFwhWv
         fb7gLSt8nzZ3hgnez4PeibTDvqWIZJFe9Ith3CgeIOJ8WDOm6XWNpNMTDWKenO0RHKtE
         89tZBT7XZISA3g8Dqr1O/roKCXjY93vG52FCAFQSfAjTk4YJgkGcSZ+s8KQcTkBY3oM2
         gE2s3kvayJSU2WEK8Zp/9cTILsSCC4p/P2atUaELrLvjoGliXwVM2hG/gJ4XJXt8EPy3
         JmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509664; x=1793114464;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmBMpzBjUGW8YNW8Rn0paVufGdRLWO7YVdcWv5LCpzw=;
        b=NaA1MWAD2Obbbyv3WzlwxuHrYNGDw03VTH+jn33k39xl412JA7Mr+O1cJmrZzxdmVb
         BYo6Gvz7TaE3EV1jRoz8oFWENkfAILHgAJVepaF5XYJ+whw+9mZT6sb1iZqQuYL1l7HR
         cyTGDrOXWEfmIhek1ZEmkCzjOnk9w6FlOkUmNDbAaMZ6uYoOXYwTBTcQ3Gues3FwXL7m
         JdnvrrMKFgSi4+EQpJiUD21ebXjFJ1rSvYQhuPJ3UCp0tWDxPyfwEjrJv4EkKNhbytlw
         IV4/MResV2A0Zt4KSWetUtFsqpzg5p4qlqu/C0c/SKxE9TsJST825quQ40k9SjR0kgUj
         dN2Q==
X-Gm-Message-State: AFq9FYJzeKv8KuGTuxQ1GjWWbvIuMz5ueonoA9LZvQ/mKO4Duzu4TYQr
	bPLWZqpSfZ898sgYeh6yAiK7AdkwjyXc/3UpWgM3qFT4jf/GxRoTiWHhd3PZjQ==
X-Gm-Gg: AYBFou1LBPriGPncI5BtYhAN3+5mBi3BMVuJTs6ViMlXlPxUUsOlaIe4o1GCY3oqoHd
	A7b6Kt05kkzJOyX5s9RyxSvtyJUltWx//WSZgU6TSHXD2aj80hTuSGQQhNCxt0ZSj+gN6BC4pTi
	VlxnzFHufq0/fqCRCOy2ZueRqgr77Cn0eB6KaGBRsad+eXYCG0tH2IVRztkzhyKHWT/oiHcGv9D
	7J2JDP7FFZaZZq9v7NYpVmJUf21lhJNj57awB2vjvws/VxH0JHHSxjKchhwTcWLnmvb6W5xWuGs
	d5gzShTkHrLrRwlJ9bFy8GveWzZszo9tYWwAxVKZs+8Uwu7HdWeFODn593T1f/fotRRO++gU5ov
	pl0pr9mxG+kffkuU8u6fKxP/blDlfn+H8RraKe6qnam0WnkTRw19UF4UrrO7RmL/pHt0SJnhidP
	cZAe3G09KFRq+vRz0ivmJoIKQyRGxxaJl/qF1dSit67ub5KOLo5BVscuWbE3QLe4+ru6Se5fQQ9
	g==
X-Received: by 2002:a05:6000:29ca:b0:48e:a9:9e2e with SMTP id ffacd0b85a97d-48e07bb315cmr16779253f8f.14.1792509663372;
        Tue, 20 Oct 2026 08:21:03 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm6307355f8f.38.2026.10.20.08.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:21:02 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 7/7] stash: simplify reset_tree() function signature
Date: Tue, 20 Oct 2026 16:20:42 +0100
Message-ID: <a486a625c95cd7493e9cae424bb3a4fdc35c9e66.1792509606.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792509606.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792509606.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
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

From: Phillip Wood <phillip.wood@dunelm.org.uk>

There is only one caller and it does not want to update the worktree or
reset the index so remove those unused parameters.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 55916259c3..bc1252790b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -332,7 +332,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix,
 	return do_clear_stash();
 }
 
-static int reset_tree(struct object_id *i_tree, int update, int reset)
+static int reset_tree(struct object_id *i_tree)
 {
 	int nr_trees = 1;
 	struct unpack_trees_options opts;
@@ -358,10 +358,6 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.src_index = the_repository->index;
 	opts.dst_index = the_repository->index;
 	opts.merge = 1;
-	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
-	opts.update = update;
-	if (update)
-		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts))
@@ -738,7 +734,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 	}
 
 	if (has_index) {
-		if (reset_tree(&index_tree, 0, 0))
+		if (reset_tree(&index_tree))
 			ret = -1;
 	} else {
 		unstage_changes_unless_new(&c_tree);
-- 
2.56.0.134.g299a3c16181

