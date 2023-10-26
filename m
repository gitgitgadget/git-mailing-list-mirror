Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12F2EAE1
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiEFJFoc"
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DFED47
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 16:16:11 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d87554434so9840026d6.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698362169; x=1698966969; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Agi5L8XZvGbRy76oE8lAx86Syz88JiFYgfQNcGt+vg=;
        b=PiEFJFoc6kBswCHMx+1VLAxUiNFkNTgoUseby02QJ9lO4UyOaAV7cY11hLoyPfnaGN
         ne3nXlaItCBY2+ZcKKwL1dotrpm0md/a9l1D/ZwLyRVlqa5rZUn9TTVkiKN4CotsFd6L
         kvCkNUcLiaL17gLjbNMsnEALc/Y1BwFo+pvHPhAtuCTsv8roBq/523+7UQGt3JjGq98D
         G9AwnXF5Fx11Bbyc02gngYQSN1t56l9e844+jsJt72PryzzCLpQthUUi6IUTAJYoj+S2
         MG4nlC/PY36m8CoXd1ohpAdDWmMF17qCOC3prrI66Yhrb8kt6aO/80qTx7Pn4CTM9O8y
         woCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698362169; x=1698966969;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Agi5L8XZvGbRy76oE8lAx86Syz88JiFYgfQNcGt+vg=;
        b=SRxOkL1VLS1GbLPBpJi0xKFlgBx9B9KcGukjoos3oQOoWq4mn+3Z+PLjdLjfFZIRja
         6uY+ERVzFh6iB3zDpgLnrfCdbPMMNqPH0g2Dmdn6EzQYra5lb3nLECBuZ0gpPUrqsfga
         dX6FJfXR9QHNtEh1n617shgyA7CvPgOh83xplE8oLJ8ouEG6lLlXfQjSBamxjIX8uD4V
         KqgubYhjjKkfG4PTvwB6scW0htN7qWY0lgp41YzGESL3AIxjW6AFkkkZaKuo06u8Q7aJ
         weXxpwQsgBgCYE60o95SQr/qUZreM9wEbR1Gf4O/ihSsQXNlBRWj6G4hbn2CNRzK+GxA
         mmEQ==
X-Gm-Message-State: AOJu0Yy5pJxfL8/OkKAFWbKBRr03D8sXXicBDmAgX0NTyNjVabMABi8X
	yVjOc2RscE05D/qqxv05x6fLGeJfTb8=
X-Google-Smtp-Source: AGHT+IHo4YuEuIzaInxmjLXQCN5dhIQuoXUqvno+OnnhTRd74pgGwjxSQpQZ2ljPqHpfniS4bEoLag==
X-Received: by 2002:a05:6214:1bcc:b0:65b:ed3:9a02 with SMTP id m12-20020a0562141bcc00b0065b0ed39a02mr1290005qvc.17.1698362169685;
        Thu, 26 Oct 2023 16:16:09 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id do10-20020a05622a478a00b004181b41e793sm132459qtb.50.2023.10.26.16.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 16:16:08 -0700 (PDT)
From: Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 0/2] pretty: add %aA to show domain-part of email addresses
Date: Thu, 26 Oct 2023 19:16:03 -0400
Message-Id: <20231026-pretty-email-domain-v1-0-5d6bfa6615c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPzOmUC/x2MSwqAMAwFryJZG2jjZ+FVxEXVqAGt0ooo0rsbX
 A0D894LkYNwhCZ7IfAlUXavYvMMhsX5mVFGdSBDhTVU4RH4PB/kzcmK467wSNyTYyqm0tagS20
 muf/XtkvpA7goZPRlAAAA
To: git@vger.kernel.org
Cc: Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698362168; l=866;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=c25/S8J2j3/ASTrEk1VFln5Bu0RwXsHjm7bYCgK4SLo=;
 b=towqtLlZ11LkN6CM3bQPcnssXVQQK61+cZbHHOWyAT8hhyk27NySymX1R7lI10/5QHJEDaTuD
 S26HjWOXe6EDT/bwYHSZRqW2hnAwlm9iCCQSjUH5dEvv4lKsKleDR4W
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=

Many reports use the email domain to keep track of organizations
contributing to projects.
Add support for formatting the domain-part of a contributor's address so
that this can be done using git itself, with something like:

git shortlog -sn --group=format:%aA v2.41.0..v2.42.0

---
Liam Beguin (2):
      doc: pretty-formats: add missing word
      pretty: add '%aA' to show domain-part of email addresses

 Documentation/pretty-formats.txt | 10 ++++++++--
 pretty.c                         | 13 ++++++++++++-
 t/t4203-mailmap.sh               | 28 ++++++++++++++++++++++++++++
 t/t6006-rev-list-format.sh       |  6 ++++--
 4 files changed, 52 insertions(+), 5 deletions(-)
---
base-commit: 2e8e77cbac8ac17f94eee2087187fa1718e38b14
change-id: 20231025-pretty-email-domain-2eb2ae23f416

Best regards,
-- 
Liam Beguin <liambeguin@gmail.com>

