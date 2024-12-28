Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C4156C6F
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735386158; cv=none; b=TY1DxZypmNSBPvprBAQZ6cJ29J8sm/SExlP2lchAX6ttOh4e1TWEv4QyZN9MgJLMLcYvMsjmR7fHmJ34QO3FLvBo0975imMjbgNe4pueU7CfWN6UhkrjTr0AHWNzwRKrnbkYQ478G7vpfjN4Q5mt5aDPyZ+Ed95jMN74cfWW0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735386158; c=relaxed/simple;
	bh=W4d9AZaAEgpNMcmPwfEqdGS/M5D7KzPRE5HQ4k2muL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmjia4W+tO20FXLeRn06DJIC62SwuLYpe2qtoSDWxuoHhuG582Gh0xxDoxNoTBrCsDDUNR4ZgsBQ6icLnvUivQ0eoDShvmTu/zWKVriikWkks3MJUbTscdKRdYGhiSVARYSGOt5K8ck+rmPXNA/1K7oL9HrTpX+RI0kCGNmBGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=egxzisse; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="egxzisse"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so10784817a12.2
        for <git@vger.kernel.org>; Sat, 28 Dec 2024 03:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1735386152; x=1735990952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aBoR9l7PvTqpOBwwZc54oz+N3CVnY0ABmNTPLNAuJo=;
        b=egxzisseSxGvft/4wwU0Vem003qHz4IFFsMh7BWIt+GbeRE02TR1TmocxZRiVllKim
         bJ7UvKYfEL3Sk+qcuAMAy5gBRoMeSjJUw2/vXfwZUiSHmiIXvC/YbBL4rSLYXD1MsxXJ
         26zWf0Cg3BtHDqFWkSkroKa2F24GubyuWprHXzm2yskBErTkBPg5SMG1w+r/VJ425XQQ
         kIMXw1351aUjzgQzYvdlxW4AHVaB9MbxWFL5gNV8f0b+KhoN8g++IUoUqbzmKp05c7+K
         yZYU69W3k54WuFIK7ljTuSYCactfnQSIxBI2kcEfQtFm9VG64tIdDEktpKK4k723WYcq
         lZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735386152; x=1735990952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aBoR9l7PvTqpOBwwZc54oz+N3CVnY0ABmNTPLNAuJo=;
        b=GscRf45EUsalRTbH2GMz9wmZRAquHC/wehR1+EJDOPBGH+0j1urjneZ0npF8MX/sLO
         OZJfl35WFnZ3jY0eZSiSaWSnvTWyaRrGyPDnpPVVSGuoBw/JfAOkHf2pLq3HEmY1Rtpu
         eDDPMrv5K41ApRNyij1nOv4pUQ4c4s2jy4JVTT3b0sgj+AZjzAucfRqWEVBy2sBGQP0f
         aZI4CcQG4+upTotx9VbTfBfuU5qOx+QAOJohdnH0jcPkcha18Bn+HBTNJh2T6lXSQ3ES
         ygqqmSYCf0RdrshvsneaKk3b8sEyqhF157hM4HCl5gW/vmbxpJdwNRM6V7y3L1AtME2X
         LBjw==
X-Gm-Message-State: AOJu0YxA4kUHpVER+DL5pcDQ8uKME644OTQmvuBT3czAGL+UzqbxNKv/
	Muv5hSicSlP8sKPANCWBDVrenLulsmedXtZa9/HK/JhI+LZ54fd/OlpwwpEt41GUgV3sJW/hged
	g
X-Gm-Gg: ASbGncuu8I8gg4wUwUJESdjfMe3WcL0yXnZZupLV0g3J4gGjoEUBs+ziszVy6wXMGF3
	xgukvO3uNIrlIn+JTbNKF4agdJpNOey78bF07L+t/9xAnhMCS3bKILjQj+9Sdf3f1jz5usOndUd
	uCaUCZCN3qrS1iOaT9hWJ9KbaO01YGCguf6CZwDVo/2lsdRLZY+EriEIwGyJIrGd1MIlk1cJir2
	tvnHHK4AInlr/aWfZQKH8XVVs7ceJ9SKnZRzcT5twCV1G33ujdevAuLM6c2RlX44rFKYrLB5zsK
	TUC5
X-Google-Smtp-Source: AGHT+IEZTr72PiSb6T2XgoKHdHeWv2iwvaxq1zjTRhucDB1/+aDQzosNexB2RyMZGzNiaUj0IKrCuA==
X-Received: by 2002:a05:6402:5204:b0:5d0:ced8:d22d with SMTP id 4fb4d7f45d1cf-5d81de05c3fmr75729104a12.22.1735386152385;
        Sat, 28 Dec 2024 03:42:32 -0800 (PST)
Received: from localhost.localdomain ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4988sm1251511166b.124.2024.12.28.03.42.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Dec 2024 03:42:31 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 4 0/1] Localize mark-up of placeholder text in the short help
Date: Sat, 28 Dec 2024 12:42:17 +0100
Message-ID: <20241228114221.10351-3-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <xmqqjzhm7jgl.fsf@gitster.g>
References: <xmqqjzhm7jgl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

I am resubmitting this patch to make the substitution placeholder text
localizable.  Fuller explanation and example are given in the commit
message.

I have reworked the translator comments to be fuller, clearer and
prompt the proper default in case of doubt.

Last time you asked me why I am localizing the `<>' characters for
substitution but not the `[]' for optional values.

There are several reasons:

1. No one has asked for such a feature so currently there seems to be
no need for that.  If someone asks - it is easy to provide the feature
then.

2. <> are much more dangerous in the shell than [] when copy-pasted

3. So far Bulgarian translation is the only user of the localizability
of <> and the action there is to omit the characters entirely - they
are not needed as the alphabets are different.  Omitting them makes
messages shorter.  If you omit both <> and [] in messages for
terseness - messages will be ambiguous.

Please indicate whether this is fine. I will iterate on the patch
until it is deemed acceptable.

Here are links to previous times I submitted the patch:

3. https://lore.kernel.org/git/20240707153526.97984-1-ash@kambanaria.org/
2. https://lore.kernel.org/git/20240525122514.2608-1-ash@kambanaria.org/
1. https://lore.kernel.org/git/20240421180425.78940-1-ash@kambanaria.org/
0. (check for other teams) https://lore.kernel.org/git/CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com/ 



Kind regards:
al_shopov


Alexander Shopov (1):
  parse-options: localize mark-up of placeholder text in the short help

 parse-options.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.47.1

