Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E5155A5D
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774676502; cv=pass; b=a+4ZB1oOMz0Q63TxJJBYzoH+GudMKTqqlp3mJlAeH7rCHcaJDxa7hd+IHPpvDO88szlUlJQWnfFAhsvw2T1/yknXmRc+6U81Dk4esNrEiaFgQ8xpBzrv0xdBToSyHIDNeoOkKc4pXGcdCF4WFah7Eb/wX7R/6xrPZ7dpp5PQRXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774676502; c=relaxed/simple;
	bh=spfKLZXLm5Jn17iOfLfDg9MyCNvZkp4fFDSkZC4Iuh4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hf76uM1jfDphBkVnq7fK2O/r2lSs6Z6XVDgfuRns8NSJupAGufLyU65eigTyC5wMsW4WBtDpfQao3bTLyWmr8vz5235pBNx5ETbh/LkSXgXw8KtyZ7UFqc1TG43sOu99itef0dDngIecggsun3ms3e7R8JCQuLXk1pAOYnoUxrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9C6dvY1; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9C6dvY1"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d932cc948so288366a91.2
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 22:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774676500; cv=none;
        d=google.com; s=arc-20240605;
        b=UbUVcqp/yx/6i5WBfJVmbSIsuG9SYFgqaVg4IxHccDCKYUB8SCBTNAJU6LnnDZXcqf
         vneMpeGhCpVK2Gv9HEdGKsOwhdK4XQASt9p2vlslJ1dZnWUyTnGwGo4W78UTKczKBXxB
         rJbf0/jkajzr3qzkZmf35Lb5jI/uYoEWMX+r6drEp0LKknRyDmhNJd0HNEryuWXGJ2O1
         IVolDs8s219AH6Yo2Qk3nqOzTAIzsfCZgq5iLmyzxOxYpNchnO4q/vAQ9rOs7ewYhF6q
         ssljMCTikfIlWM1UnY2pF7DCD8YY1nev8g9Bw3EOEe9Q2xKVzEs99nbLXeEZvmWXREz3
         uY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=apRq/3i0SZtfH66J5frxMXEJtJPU4BDY/SJEoBRP+cQ=;
        fh=APWc+JhKvTHz6E+o9zy+Gkcelizpo31LwhC4aWmD9DU=;
        b=EaqgDaqASijOgrApsvZ/IgycOcpidsLWVmQgjvr0XuSoFWsVtYJ3/VLtCWtl7/GQSM
         QqI9SurMKMzQW4VqHUJvIv02EvxdnhJSUJ1YvH6lAlc749+C/KeahFPDcQV3O7Km5D+X
         qEDzlxyiX8+TUHsPq6RMW+F/aVZduRlGR18nlCZJef9aKAEqTCqwfxsE9YaAYVMrJFYH
         bzOjiymbJw1mstFLb3ZxQ3y/aJaHVibjJlSM9KH5/RNHgLfqAV10qnA/9jpskH/NGsEP
         l6Gbu8/VnaxHbHP1fMTpjDpfPfniHryfkRNmPH7uG3eV97aRFOrCkMVlzGO4d8chJqE8
         ohWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774676500; x=1775281300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=apRq/3i0SZtfH66J5frxMXEJtJPU4BDY/SJEoBRP+cQ=;
        b=Q9C6dvY1FjvOrD0VnW9JDbGiFgeD6a0N1O98tvewu1yZD/ehb1hfH1eAU/06PdGey6
         5Zgm5jEN6GIYgbE8HIvqxwdl4FA6qG8xVmqIARijF7dEaN4G+YdzaWy07iz3SMPH/Fb5
         r6KGjKr8cX/QE/istlcLoHXk7kDcb4x8dW63cgyF/00l1N+/0OfuqPOHW1FXh9411v3G
         GSbquCW3tF88DfSg8C4/rAN0Uw5sH/c+ijtx9AZKnw0liI1HX4a2oayOELw/zZesKhiT
         AnBC+4sSh/hlG6jhvmJ8Xe4u+nQRCtfr/ofGNN6xZHlX6mKZIGK2JhHZXNUNQJhNyotk
         WvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774676500; x=1775281300;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apRq/3i0SZtfH66J5frxMXEJtJPU4BDY/SJEoBRP+cQ=;
        b=MZ1GGVANIXUEuorGvceSthm+c1xARJMdKtBPky2RwceRi9BYVA3pQYtkJFgfHQ4BLG
         wCvnBG8RHMQFahIWfkT9hfB5AaBv7/CjMnKe84Skx3JcMtq8Pa2ZQok7HE4uJsRxK0to
         AOKaEdM8fGScUftiyXOF3wuSWL8ElfwICKXpBAGPXZW2IZQrhbFuHSWCbiw/7coOn7Zd
         wLv6kLV6REnce73HWv/1c9YeKoKhiCuf2hfO1FwfTjsmadb+O0VeVL9CMx+1lW2Zx68I
         13xop3fIEuDqrWVKEv/9psQkf2iQODNlbZF9MRPawo4+YBxNg++A/RGNGyVqP91mXkSs
         o6yQ==
X-Gm-Message-State: AOJu0Yy6prElsTSvItkPhyUcnJlsPzPSFGG3I654YUUiAJ+BTzukgbc5
	T+vR6thP4U4TpWN6S/P6vsKe/43td/ZtCtqEFXFJPdxLjJ5rb/bvVTVt12Q1DRhPfihfagDnc7q
	3yNWM3z8MvfHzBdaJ/nszp9UdpXB75S9/enrMdrbsug==
X-Gm-Gg: ATEYQzzhtY4vUwSxKDQPxuIvRrt97pPgTr9gr0HE4O4qgHxZhlqui8p+tVmZuw9c1RY
	tW6sTwhttVgflZ6MS/xOty1aRHu2Qa9ZmQBlRHpB4jXGoU6+ypA3GSVgS0l0Q5DpC0CjCXxdeNN
	7tIJyoz/ySGiWFRose0HJVyzp78ajljxWICgEgz2x/W3Tkfg3RKAgjekAHd7WHyi0BRyDBq0xnk
	xGh99aXsdKb/GL7FFFjXstXZbwqs+9qQ+ElG6V9UHdAo8lQ5DX/vxvfL6np8Kln5z8OnvOPNanc
	5nGdYn7fQB3Vdctkw0Y=
X-Received: by 2002:a17:90b:4b0d:b0:35b:e5ba:c0c8 with SMTP id
 98e67ed59e1d1-35c3010dc26mr4881564a91.28.1774676500097; Fri, 27 Mar 2026
 22:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Noman <necrospre@gmail.com>
Date: Sat, 28 Mar 2026 11:11:29 +0530
X-Gm-Features: AQROBzDvzb45mLO3W8bb3Fz_zMHRSm1W5tZmji3zVzBdXe6u-KPqV4L-tKWbcgY
Message-ID: <CA+TqWtWiYR+aEsQPOsOwOonc2hinjfXW0oy5mLuDOPx4Xu9mwA@mail.gmail.com>
Subject: [GSoC][PATCH] doc: fix doubled words in gitdiffcore documentation
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Git community,
I am Naorem Ngathoiba Singh, a GSoC 2026 applicant interested in the
'Improve the new git repo command' project. As my microproject, I have
identified and fixed some doubled words in the documentation. Below is
my patch.

From 3d7b15e3bb99878a7121d8372c6298b9be930346 Mon Sep 17 00:00:00 2001
From: Naorem Singh <necrospre@gmail.com>
Date: Sat, 28 Mar 2026 10:53:36 +0530
Subject: [PATCH] doc: fix doubled words in gitdiffcore documentation

Signed-off-by: Naorem Singh <necrospre@gmail.com>
---
 Documentation/gitdiffcore.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitdiffcore.adoc b/Documentation/gitdiffcore.adoc
index 642c51227b..2b3fd5a259 100644
--- a/Documentation/gitdiffcore.adoc
+++ b/Documentation/gitdiffcore.adoc
@@ -133,7 +133,7 @@ input contained these filepairs:
 :000000 100644 0000000... 0123456... A file0
 ------------------------------------------------

-and the contents of the deleted file fileX is similar enough to
+and the contents of the deleted file X is similar enough to
 the contents of the created file file0, then rename detection
 merges these filepairs and creates:

@@ -145,7 +145,7 @@ When the "-C" option is used, the original
contents of modified files,
 and deleted files (and also unmodified files, if the
 "--find-copies-harder" option is used) are considered as candidates
 of the source files in rename/copy operation.  If the input were like
-these filepairs, that talk about a modified file fileY and a newly
+these filepairs, that talk about a modified file Y and a newly
 created file file0:

 ------------------------------------------------
--
2.45.1.windows.1
