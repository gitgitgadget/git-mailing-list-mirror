Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6881FE455
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055562; cv=none; b=LssaDxVnRxh6swtglTqXu0888r0lVkNDXH11gIrH7Qd68hPD0VApdw5IrFZ0y8dJ3JJp0NrXYJYd0eVZG58TdAiZl+I6mWyqNp8kuu1omlg/FQQQZLtXEoNjSeBl+YeWFJEsOCkkvpUm0+HnVNT8tfMl1QR9rT+2w1tNZwhfUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055562; c=relaxed/simple;
	bh=JAzdvjzD+gK8ku82B/RPTXTxzmeHz0gOnL62GrfTPc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqvovbwnqWkEgxjRFY86Lfvitn19P+5mStJqe7AZ0wlFIxkb+f4I0JxgpmmdX8B2Fcrs8xoyhszyHDTCcILZY7mExei5SdO6T+lTNnxUigciOz3Wa9E/SHIU6YMz6VLM5q0mnxHuRBUq4gY8l5ATwuyLlUaZy5piD5lOn077QAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyiyF9Ax; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyiyF9Ax"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748fe69a7baso3031950b3a.3
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751055560; x=1751660360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A4qDQ5hA2v4N2kIYTIU33V75IdRd9g5bNAHi04cbDfA=;
        b=AyiyF9AxUNJC8xKAFAEz5TqiqffAEoIaQQoedsIq8dYNDRsGDx2MAp3WlOb/HKBRtR
         R+25nRJbNi+71c4WHApY4VUlwHmnqAtdoXiyXONTWgw7z09Y1JPQ96huF/OSwJkavl6j
         k/x7q17KmZ34Cwk4XrXuRBODpglIhnwuwLFmR9rI9LcIJSYG5Kjslc6QQXfrz4aKnrj1
         7DFPrWqRYblSRg5LAOcorrGUsuKQqJ+ulqDZ80rqpSJ90KrNAWjhhN9FVQq+c/VgG0kw
         v2QF9mDgU8NhG8J6z6g3onhbAv+g3HdUan3qhqljQAy9qD1pWfaPPCi/4C7kvY/AX0i6
         X1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751055560; x=1751660360;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4qDQ5hA2v4N2kIYTIU33V75IdRd9g5bNAHi04cbDfA=;
        b=wee89jM9gR7LxwY2bKsU/aBNTFCxrupBZsITBXrOcuU54wemOHgTUcluDlk79Co3Oc
         2EUDNME4H/oTb1ryXs0IrZT2hLo34SqZfLPCofsOGHSw1PZ1NI7G7vU/4pFThIkxQaO/
         nbQ32s20cEDzEmdg6riAiARn5ojmAmjLOC0KC8ghVFNBV1nocWp3ultRsmFxP4Tl8C+N
         BcHBM9enMq2UhYPlTyTrgzCjmRDg5QxWciEq/fLAAqQGRYzxw0TAe2RdwJzbtiLI3XDl
         VqQrIRuhAhiy75QrZNyaJ1g//b5h6DKHUYZ8IyGqLBo9Qn0UWhQcCEg2KUWvgh+I4Xgr
         9unw==
X-Forwarded-Encrypted: i=1; AJvYcCXg5vGPcO4YO6X4toCS8tAhOvZXrOdmrBPEfPBk3O4bPUHbr28WCzDWC4udhptxB00SMp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLTF8hubNzFcYgYtUmyBAtTebZGPshrTmXgG0NADW3v0TX1OB
	CUmdsR5iIfv3lleY4WXskuUJBFIJbUvg9MLDEsqZyN6v229b5di0gRYe
X-Gm-Gg: ASbGncvwR464txjeAaRT7Jdt8K/BaDf/bgAX+ruWDoAaVYT2EvZTNig/33jUt53rYh9
	r/1SvQ5n1b73U+uMAlRkJnbG+nTO1Fi1AxYWLGvzoKPBTn7wKkHnWx16t7IzLO+Yy4WR2oCK/m1
	zrfntkrkAeMoOGiiLPXxaGJdnwZEIvRbbRzNTnXqay3PbAUBtXG3ZI1tUcv6byZ8TwkRzq8VHO2
	eqiA0p/wE62LJeTAwwRRpeMw/2ok2BKKP5L2tpcJw0M1yTWP/mxGwwp1lieIEF/B3i9yImg1RtQ
	+UnaPc17budbRSZ5XRwTd3ww6lPHEC/8SPz9GwG63Ue0xWafXocEuqCuJ/3csMHv4TkxZcsTv0e
	+u3uxwodVebdvVnMRZHXeDWZlDMA=
X-Google-Smtp-Source: AGHT+IGkoCYtPXUsLORSbrgRFqFJ+9vayMsOO7so+XLDt43gyNt4rsfl/QEVwGIWDKg0PpAt46b3rw==
X-Received: by 2002:a17:903:120b:b0:234:ba37:87b2 with SMTP id d9443c01a7336-23ac3bffb49mr73536305ad.10.1751055559956;
        Fri, 27 Jun 2025 13:19:19 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b7986sm23927585ad.164.2025.06.27.13.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 13:19:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,
  yoshfuji@linux-ipv6.org,  kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2] daemon: correctly handle soft accept() errors in
 service_loop
In-Reply-To: <u4scxaxivz62fsljo7okkfdvcle3zdby6h2sdzd6ed5n6wi5xb@5ekxdycixwxe>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 27 Jun
 2025 12:05:15
	-0700")
References: <20250626161038.85966-1-carenas@gmail.com>
	<20250626172159.87204-1-carenas@gmail.com>
	<08804dbe-56dd-4c0e-b36b-a82768b0aa29@gmail.com>
	<u4scxaxivz62fsljo7okkfdvcle3zdby6h2sdzd6ed5n6wi5xb@5ekxdycixwxe>
Date: Fri, 27 Jun 2025 13:19:18 -0700
Message-ID: <xmqq34bl7xa1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> On Fri, Jun 27, 2025 at 09:38:47AM -0800, Phillip Wood wrote:
>> 
>> On 26/06/2025 18:21, Carlo Marcelo Arenas Belón wrote:
>> > 
>> > diff --git a/daemon.c b/daemon.c
>> > index d1be61fd57..f113839781 100644
>> > --- a/daemon.c
>> > +++ b/daemon.c
>> > @@ -1145,6 +1145,7 @@ static int service_loop(struct socketlist *socklist)
>> >   		for (size_t i = 0; i < socklist->nr; i++) {
>> >   			if (pfd[i].revents & POLLIN) {
>> > +				int incoming;
>> >   				union {
>> >   					struct sockaddr sa;
>> >   					struct sockaddr_in sai;
>> > @@ -1153,11 +1154,19 @@ static int service_loop(struct socketlist *socklist)
>> >   #endif
>> >   				} ss;
>> >   				socklen_t sslen = sizeof(ss);
>> > -				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>> 
>> Why is the declaration of incoming moved but retry is declared here?
>
> Separating the declaration and assignment for incoming is needed so we can
> insert a label for goto; moving it up just removes distractions so the rest
> of the logic is clearly in view.
>
> Obviously that includes the definition and assignment for retry.
>
> How would you suggest to arrange this better?

I think what Phillip meant was more like this, perhaps.

		socklen_t sslen = sizeof(ss);
-		int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
+		int incoming;
+		int retry = 3;
+
+		incoming = accept(pfd[i].fd, &ss.sa, &sslen);
		if (incoming < 0) {
			...
