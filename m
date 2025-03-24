Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA9190477
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849170; cv=none; b=eOC3Tl8otcf2ppWjxXvBBsTvrvbrVlA8m+XZiEO5IVITf82swC+JSiPts62n44Wux3Im/hu7lBq1K2EtJagrOxN1BZA8+M92686N7Q0KRanEOb3BCkw+hnymfGamkrBx4j8nSFohKyukcH0zfEPuj5EUC71Ts9p+oudcQC0Ltt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849170; c=relaxed/simple;
	bh=b5EquYI+OYbf3zw3K76TPKSDspiYvX9P5dsAqmJF450=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjQ9trgo2+J0cUPCyNHpZoUEc4zIRI9qVrqELk1e3nhe8BIko0sAHWo9ft670hJIzwgH6Nxjekw1dsjxfGg0LoRYRipfON6qa+w+LnJsqF3u61qKOXG687SqJnw5Dce2LwkPVTU0dZQsB7gw6ImGsvI0EAtN9Bk8IpArlC4QfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCXfuS+h; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCXfuS+h"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef7c9e9592so39987617b3.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742849167; x=1743453967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BAhGKSAh5tlJA1H+gVh2AYMRLSV+kW1TVfWs8PASe5A=;
        b=SCXfuS+h3yq/Tm5ROyj4mQQT+BOde9Pncq74kYEIu6+UqM2ZZWMBuXkz+hoLvmTPzP
         gznNPhIQvFolm6sFaP1xXb6i+b4mDS9RaHL8taS3WgNyvNO8XqyYfyyuFZgwcEdQbCT6
         CMFaLTrII3szbg7rdwKN9hZSd/vjFQ2fe4/PE8Mm9AJyUCEpFcKxV22aqwcfJ7bsKT2l
         qNYsZOQwfPspufslA1GO3hYnjTTm91SfABCdnzVFChhuhEa92m8jq+h963a8k9304b0D
         M4doP4OJT4WZCHe1U3HYlVnFEyqsK+s5BjD7+HESRAnFTmTaD53AmY05gokOnDtgK66v
         1yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849167; x=1743453967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAhGKSAh5tlJA1H+gVh2AYMRLSV+kW1TVfWs8PASe5A=;
        b=Eph0ttt9MvQuJL//sjPbHJFsDXSy5xi7Q6DuNU9LW7g0hERWTUnz5ZTcpRXkQENZi/
         fpD9giG3onILr1wYLQUDdj6ggqilrOPss2W6rAzEOA0+yOgSyWaqOHmCJa6+akHkb1N6
         9vWHOofU0Sw4+qWvAyUkYeUHg33Hv5n4q563aLOyBO9cPYUDBg1WTB0+IOwfbMR9DnG5
         H3wQlCnZjx8ktj4OqLW/ab5f6uv5jQ+VVmFRMG2GbG6GAnT1e5lCUTH1KQS5lYELZGWQ
         KRh7lN48vmudBJ+yRwKY7WOw4b4YReM0kmHYUb0YLBTRn7hxCPpzllPV33B+N8b/kbZ3
         8qsA==
X-Gm-Message-State: AOJu0YzdVQDAHQRuX4aQb2eUbyS+6bSjyM3QAqXIUJdnGPBrLqPupP3T
	Ofp10NTNAuoc/SRSCZQnJ75PQP6BfFGDCXUmJzIxpNXccLrEnj463u1DENwR
X-Gm-Gg: ASbGncuq3DgsYCDdBqZXfmYcX9OdOCZWlQd0HJuaguH42SuGyvoAB/kumcoyVWiXzQk
	q/E3FIPkhxwEU+rEkG81yK5YJtHTmrkvbIMt8PTMG/lFQc5ur6JbuUEr5e5HhwVIbhA6OMCXi8z
	Dtfs4uMQncxR0mXFfi4q70ukBETDzxPk6vCN/6w8aHCGmGHHRPB7AVFeTwYIfCcU13O6k7x1nA0
	42Nb5BtWSNQ1tUR+A5HIucuXvbWSucJtcXGKSD4IoTNj2Fi9VYVoCYLLD3355WCKe6a7p3K/ev8
	SGrfkoEXyaW8KTtN8Wwuw0s/pw9oXlCZh1ZqdiVB1ATjtKSSWToZURQMYkIJgjOrzdKampvDzAp
	1btSTdM9cqC4ebArsD/c=
X-Google-Smtp-Source: AGHT+IEPfXtHo2r6rWWs75/XQvfHRz1ZREAiZl86m6f3DyOS5iFSKm0l0j5MCwa+OzDPzNfSXMxz2w==
X-Received: by 2002:a05:690c:4d82:b0:6f6:ca9a:e9da with SMTP id 00721157ae682-700babf622bmr182773137b3.4.1742849167259;
        Mon, 24 Mar 2025 13:46:07 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:9085:3000:f45e:232c:5c43:1e93])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba76d24bsm17173907b3.33.2025.03.24.13.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:46:06 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Fernando Ramos <greenfoo@u92.eu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] vimdiff: clarify the sigil used for marking the buffer to save
Date: Mon, 24 Mar 2025 16:45:55 -0400
Message-ID: <20250324204558.76145-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original documentation from 7b5cf8be18 (vimdiff: add tool
documentation, 2022-03-30) mistakenly described the marker as an
asterisk, which is the character "*". The code and examples have always
looked for an arobase ("@").
---

NB The (French) name arobase for "@" is gaining popularity in English writing
but is not yet universally standard. Use of a different name when picking is
fine by me.

I also did not attempt to clarify the behavior from the recent bug report [1]
because I hope it is repared rather than documented.

[1]: https://lore.kernel.org/git/CAC6paJg19ue7W0VxTnGH-1ra3Zkk+pRnj6McEC755RD54xDzCA@mail.gmail.com/

 Documentation/mergetools/vimdiff.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mergetools/vimdiff.adoc b/Documentation/mergetools/vimdiff.adoc
index befa86d692..ab915df408 100644
--- a/Documentation/mergetools/vimdiff.adoc
+++ b/Documentation/mergetools/vimdiff.adoc
@@ -86,7 +86,7 @@ command.
 +
 --
 When `MERGED` is not present in the layout, you must "mark" one of the
-buffers with an asterisk. That will become the buffer you need to edit and
+buffers with an arobase (`@`). That will become the buffer you need to edit and
 save after resolving the conflicts.
 ....
 ------------------------------------------
-- 
2.48.1

