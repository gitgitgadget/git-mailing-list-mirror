Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108789;
	b=iUXLf1uQ1MTwmkq5VQrSDqCuuPBEe03+2GNNIqmGFmaaEGIirwctrdrJ6SSYsExdPI+U
	 lENbxqRA0qBpOXs4TZH5RsnKxNaRlgzwe/F7HuYbCYBroG3h4IIPj3eoEclVsv7MrKwIZ
	 p6G02vn6S/fK7/+w2F1IwfIEkMEfJnhMDBHxTW1ZGG9FUynyIo2VF6BgDF/tZaiYFKisg
	 HadsamyunlmPUhi02hmpvemNoqA7lBNpPw24yKUb+7yYAonmalwvfRB6PGjwaPrLzG9Bq
	 VvcrrO3lamTYJsYkLKMiXAORSGM1WFE2idGxENie4fbaH3Quy8isU+YoYYHqoIEmlIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YSwcYr4HaMFUT1UNltQ7CPe331hn0X7Fid44AW1lJK4=;
	b=wKzoF4Jniz0y3DeHFStA2BdiMGlzw4wq89jJral3O4pbS4D06GCw5rHLC/LreX1Wb6PF
	 k9EdNt3Lp51DbEjJsrioOcsZKLaINhLV9CKdylst/VPTOvHVlHhUOY2UU4wfHccLHP8RF
	 7TfPdOZ1/gWAQHFV6fqSrNoBLKcuaVlEXvkK813xYX17oeBoIaf1hpl3JX1CzIiKQP5wF
	 CIZnWBn08y6Tq3uX4w8qQz+XNKpHUOf/dMukqGJkrvSEpemZmZZb0PZ6zFsoq6wJxad1w
	 SOTK2ceV6a68PZxRAV4eWha4xsfNmkkF+6QaWeu2cr4DyI6KCfRqIhAM1Z9oGPjgE9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBT9OYMX;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05755606A32A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05755606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBT9OYMX
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso3640a12.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108788; x=1795713588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSwcYr4HaMFUT1UNltQ7CPe331hn0X7Fid44AW1lJK4=;
        b=rBT9OYMX8TlXlIo1z9fbd6CCEiRotkF2ujY03nxPFlz3oFKecKRugW6cDpZpq99QWM
         +wwXd4djPQJHJR9L3y5qrP1Pn37pvyfqz0lW2NK31zWL/B10Hc7WSDzinMqZ+/qZ+6u0
         F2vBw90rDxCR5lchricul+Qfa74XFoDIT7/sCzgiDok0+ArzfMyHxQXKYvrkWzS14zTm
         rg6JU2+dQpX/GXU3JyHJBCOWSBzkR5CDpJFcsx6s0IWxj2nNI5gH7XTm8EFIFsJwd7Ki
         gAGo/KQMnxMuXnjHOJiso5/uNeuUXrTTCj39ZT6p1jbrwsW4Z+g5JJwQnC66iBh7Q4Ru
         Bxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108788; x=1795713588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSwcYr4HaMFUT1UNltQ7CPe331hn0X7Fid44AW1lJK4=;
        b=WeeRRpgjQ1afyrDjOU9OaxUIgZgCs0pIPI1MIUHasdcP+PYQUKmNLBO/2CHyJFTi2J
         JIZdYmDY7GkQE/o5o2laXVAF4+eHTKoJXXCXL2HwTenWmhcyQk6n+Zajc+WPtzy7fXR5
         f+J6GIl9zq/mH7xZvwkhyAX/wZAMz0vr/ItPB2OrafpoysE3aY6SC16vjPSt6CKAIsTb
         /gWy2h3MKA2xsGkOP9L3fToo9g1h6tl7kypkdP2YIzpAWSuwWi+nH3nvsTJQlcu6rmkS
         M5202gRQPbKctmkJf2wZwPXFsR2uukGs8KSgfaoCDkrUx6p2jvgLJf4VZ2WP6rXLyAEL
         kl1w==
X-Gm-Message-State: APuU4Z/pqkC6rgji7GVcOtdHL2T1Dtfr8+wgXAzXOJq0QVg+gJfu3x3Y
	fymeyV3BK/h6TkPI2G822929EXZDBU+BqjLlAlt8SciFpANQigRiEiu8tqndEtqc
X-Gm-Gg: AYBFou2aYlmIpPAADyp+8jtdAdHahLf5hcFY1Ci2bAolhcojZaJy1nylqChXoGvrOyW
	HenMpVKZ7KUqTR1/tOu7AZK1fnGmtDS/PT/MHadpuC1oQk1q+7XiFYcoW4/EjhkKD/zO90WbA/+
	JaxD2UX/eaXvga3Og/BIa9SU2RVBLCmyiK4GgWPxpUz1J8hgr1Dz3aIvjiIu9sb9znfppeBSEMO
	DzhqUIckY8OyQjQ7942vbEKwPYvH/YihgmSm1aeKed/wHOxvp0y8WrLgVOltWde0itLRUMqZ/Sw
	QykDOUUkcSSbC/vNB+xTcSUSzWtd+YKtY55tgYkjti1dGnRFc0+y4spu5WsDzjpz1NmK4csYtEh
	5FDtvRStimpjQZIG6MVh3PdUjIV4a+EL84TUJz/laBEXJvbsq3gK6+7X06hKsO4W0Y1KGHlwKiN
	mHJR2XxQuMMTiEC0z08LNePf/ZBtYBeJeYyzJLM2jE16yPAhTHpHAxvNDrRgXpuaONQVbCPhbxk
	IjY+RPYZ3S+6lKguPCyv0wEzUqyV4s3Tl9wpargc6vOny0efHy4G5BqX3chpbTr2b7vRvtCjw5f
	y9HFeGgYx4Cncunrk02Ge9tDXHef55wwZqqmKS0jXwOIFnHVh/LGPKS+yOy5Fp1CqzsDmAv9Hz8
	gbLT58U2Q+aXhlOPag3Bk5CmNZIAAsjex143uEiMCsZ0=
X-Received: by 2002:a05:6a21:6116:b0:3e2:1418:aae8 with SMTP id adf61e73a8af0-4014dd566d2mr281815637.72.1795108788283;
        Thu, 19 Nov 2026 09:19:48 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d026d6fsm78147a12.19.2026.11.19.09.19.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 09:19:47 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Beaton <mjsbeaton@gmail.com>
Subject: Re: [PATCH] dir: do not turn blank ignore-file lines into patterns
Date: Thu, 19 Nov 2026 22:49:42 +0530
Message-ID: <20261119171942.85689-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106182945.1316297-1-aniketgupta3001@gmail.com>
References: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com> <20261106182945.1316297-1-aniketgupta3001@gmail.com>
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

Friendly ping. Just wanted to make sure this does not get lost.
