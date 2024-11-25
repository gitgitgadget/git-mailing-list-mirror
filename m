Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702B161328
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513003; cv=none; b=NrLCoyNTV1UpGW7/NNP/TMcxGb9BkH+a/1GvEXGaLXucuVprkazXEp69rgTZPerkI+2KhD0eF3VZgEUT3VQR0m9HSD0fuu0+/N7aq389rRvfa/XfmYqkJUj2c1eVsdLFcjZ/QxaKEgPThU3wW8TLOeQF9sNV33KT57iY3SU80iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513003; c=relaxed/simple;
	bh=U5pzsmOoStP0pS9WJwGMU1OQ5UAsgvlv/XLnnIrHnEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xmec1zNwDIYmC5TmcRHHbCVDtAaQbwb/tR4EoDF9NG8is6ue+DoN2x0SZYVeIPvznc5G8XliucWx4K7GfUfGxTu+asclmjz3sT40HJnelBjQYuV7WLBKhDhAa4+kfFcq+oCfdBmu3QUjcQLBJeFfKvqJU6MFej6ka1TxLvGWCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhU9E9Pa; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhU9E9Pa"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b667348bd0so53593185a.3
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732513000; x=1733117800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn8FQjv1gfSpsYBysM/LGNumClviM0Q39gmQQg8JqOs=;
        b=WhU9E9PaVyyZ7VUEF8QtoeRACLv/SRXIKlCi17VcSoSO2GeABNEaR67QnHaVeKOf5U
         MOU/3iC2ncXeD9GCaO9gUNlkKYIAk72M6766BrVUA3b0c16PjPT+NvoT7Hx/Lhpjt4Pg
         P8HPEIG38XQG9ko0hps9NjPTue8jrczaJmfSdUhF4aLXCkFnOjfmuYZEaxeOfJt1l0QW
         tUkot6ZlFSzHYHUELIIqwKoc27TZhItUdT7PMUjSavtKc4IL1GRpFsW2k1ihNuWQn1UE
         Q/vmTperf5CrGyV//vfVOeqt//eqDs9aaOm739ECSk1rOGe73i/yP0dy+OrJofweG1Bi
         Lsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732513000; x=1733117800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn8FQjv1gfSpsYBysM/LGNumClviM0Q39gmQQg8JqOs=;
        b=hZmFC2Q9d0bopOjBMsxOpqCPSdprvufVKmZZAuEA62OBS57LRwCKIxSqZfFyvS7GJ6
         lffnm2rQUMpfZtEyY1SiQCHlYrhtBn+aYlOMDvgb5FD4k3zToaGT6+74fiOv+adgeWsK
         Ne5WbJJzrLDJM+rYg5yTgrDbksaKV++urQdOM0656DTYeYD8SBxLJXyxjx8NFUhj5bD1
         dKCUluDghDT1OnsjNS8xE/OAheLvSe1+zP12s2skDAArRU5KSQ8VjuU+ZulEDPeXG5RL
         CMfQqGdvfcOuFepmjsomb0iL7628TRVBWlLYS5aLceUs9KlMgB74eBrdtiBkq70bbWk5
         I0tA==
X-Gm-Message-State: AOJu0YxNNfsZWFM/GBR94tsbrSjUeQpmkWYbufAP/76u5GQZRNF3hbQ7
	Mm5NV24fnAzEfj84bvelv5v4oZtU69I7PriidcIl2CumJnLvK3WULSx9tuAl
X-Gm-Gg: ASbGnct099w/oUZDwdXhnM4nxd+SqItdmE6hif8hyCLl/yN+czo5MkFdHiqw6bxBj7d
	mOiJ73VAnRi/7OjHDPu9sKzfpnA2XbB1Gzd4mCUNKTgxA6/kxKO7fisuN8wUaEU8VcTBigIYX/E
	lmwZsEQyAUKjkWf8repnpgT2S+XbnHXD5+q6ijPD/nAp2409KaufZJ3aM1h+KxFOaAEDOt6dYUo
	pw5jSQcBHTZIXRePs2UimVSuQe9tnm7SEtwGDCUTVhSo++9JGVbzgxEIYuOlcqsdHcqdQt6HDPJ
	UQ==
X-Google-Smtp-Source: AGHT+IHXgPg4Ce24CI3myMyH/ahMl4sLDMj4hsvTM0/UxNDcdPJrhetenGROmh7I6RAdgsqaUViczg==
X-Received: by 2002:a05:620a:1b8b:b0:7b6:672d:7fd0 with SMTP id af79cd13be357-7b6672e09f9mr549721085a.32.1732513000320;
        Sun, 24 Nov 2024 21:36:40 -0800 (PST)
Received: from localhost.localdomain ([184.146.186.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f90534sm320522585a.25.2024.11.24.21.36.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Nov 2024 21:36:39 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v7 3/6] fetch-pack: move fetch initialization
Date: Mon, 25 Nov 2024 00:36:13 -0500
Message-ID: <20241125053616.25170-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125053616.25170-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

There are some variables initialized at the start of the
do_fetch_pack_v2() state machine. Currently, they are initialized
in FETCH_CHECK_LOCAL, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables.
Move the initialization to be before the state machine,
so that they are set regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index bcee4004a1..eb4aface36 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1647,18 +1647,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-- 
2.47.0

