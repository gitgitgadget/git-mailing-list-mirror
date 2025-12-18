Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380AE155CB3
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766098972; cv=none; b=mJrlQI01pFCwrcrHdncjbLoUZZkmZ9jo66CKZdyDlQiGTjuguBJOzkC+JujZZ6dw0tstnWNuumAZXZnWk3MXk/1K9Utj8viztkGDp+epdJXsQm15eqqWCYOwyCAcSUBrzRlbLGmivYdnikHQmlpj+IN4qW080sLPoR1Dy6U9/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766098972; c=relaxed/simple;
	bh=tYgjUoghpLoJbh+YO1/j57nN6xArO4v5DlJZSu0yf04=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q8wvfFQEpHVo097LXlLEYz100mA1OOnXKbFc/3nDYDD/V7gFshgdbMstKUKkXLZxeTVTE1YvLCpdqay415YSPU+0c0U+7d/EFKu7v98HMyxlxdV/Ohez5c4JkWzTGe9S3kNIEINf6wm0W2WZXua9ijem80GutkjhdiVuiB3B170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRIBNc1/; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRIBNc1/"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso871572a12.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 15:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766098970; x=1766703770; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDB/ieiXiId8bjClBt4HCzk1198fJ6h4b4op/jXE0yw=;
        b=SRIBNc1/oSkHOXoPLwkzZDJ1W4lLNna/SQQuZVxYb6B+YE9DPLmJZGwCJDF51JWle9
         4Zhwf0703teQ/49B0gua1fCfB/hbKPdqUSg9nG0IAXCDhTCQiSOBw4zUqOcGHHtORg26
         L3Mc780uvOBrybtYSjtTFg6sBDmBGba2qg/J1dtAcTOIDlF+KzygWWwGyzsulXrIRE5/
         7z49DFIuoT8nb8CalIZZicmp6/f16ec9fIVu/oYUjbxkvS4lCNq8Do+AtMfRGkMXggV3
         pz/YjNHy2Eueo6alCY78x6nypkDqPLY/EwFIOP1DWG79fI3ecnZoBtUtxr2VxjRp0eed
         vpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766098970; x=1766703770;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDB/ieiXiId8bjClBt4HCzk1198fJ6h4b4op/jXE0yw=;
        b=kXhHtxHyov1dw6hxJ+NY7zI8kt0jf/ND8Nv7WmdZdZUOV+TmYT/qkaINApVPdftzPQ
         2Rns2lK0YKOiCbFXebbS5DKGXWarouBmPAHm71Gjey3CauWgA75hhdGICk1PmaX0JDkL
         zaHV6OyTgUQ8TewddE9QLiKJEbny1FRIDvv5du36jLpLDFPq9NSBvryMFQRCk4G4Wxd8
         HvFrTqTsAbgrC1/l275VQ1Bq/TGicaJOWnWIMeDRIdMo3X8lZtNZf7XvmMb86hJZRgU6
         BiR78ASG1CIcLWIzAVexvkSmgutwb1iuWbgk234/b1nOjnnamzdS8tWVbVbLVgI74sZv
         vvXg==
X-Gm-Message-State: AOJu0YwM8ktvyqNMIR5eWRI/zb8ZC4GOU6zwm84gnSj80bVNMmOgOpzw
	1DIgx7KXgl3M/7014v4ByfM7eJ/TMiEs3ELgHr3b/30LUX9ltFU+dk0eo0W88/juX3E=
X-Gm-Gg: AY/fxX7nJVQ75s83PoPuteIPotfNr8TV2sAwLD3S8hUCwhvyBW6VNl02DnocTDlv+VO
	KaaD06tepKTiqNeaUuANNnxWbsqH2yNDY4pJNzfwpyx4J7MgHT0R3NCnAi2fEsW0b92bNbXSuA1
	uFYMp4mtRa0d8Q9zo+5D1NaPcRwX6Qyvxhcv/KUYwuoMVEBENkcEK1i5EDm5JP/9iD4Z3QnzE+7
	Hv9DeXaRBa9KNUd+BQgoB6mGhXfj3Te/1CLGKBySuJwdvPUb3UYrRmqussQQ+1FQ2uyYQ9p+lwT
	xsOu8GRfIULYweapLsmh4zUL+u4RGcihOgts3cfWgPDS63Ywqc18D98zYXVtawuhI1tVjr1IaAA
	fXoyxobBYZU+SmsdZ5TG4Dn2F4i9m9QevYOQ0VsGk4PLHsWA31SHqR5E2lZJYjBMRVMSeqTm+ji
	opaMkuzdN0sXGD/VeKnt7A9IMr+6KxP8whJZpXrYUs
X-Google-Smtp-Source: AGHT+IFiH5gh+ODG3OWjYMd0Dlm2lX5xTKajR7QliO69qLLyyLfPnBznbxhI2hGNLLfSZXgAg1/9ww==
X-Received: by 2002:a05:7022:61a2:b0:119:e569:f61b with SMTP id a92af1059eb24-121722ac5f3mr999321c88.20.1766098970181;
        Thu, 18 Dec 2025 15:02:50 -0800 (PST)
Received: from smtpclient.apple ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm1671101c88.8.2025.12.18.15.02.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Dec 2025 15:02:49 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2 3/3] repo: add -z as an alias for --format=nul to
 git-repo-structure
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqh5txfv7b.fsf@gitster.g>
Date: Thu, 18 Dec 2025 20:02:41 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 ps@pks.im
Content-Transfer-Encoding: quoted-printable
Message-Id: <5240C85D-7587-4042-AA75-58356BCFF351@gmail.com>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <20251204210843.79411-1-lucasseikioshiro@gmail.com>
 <20251204210843.79411-4-lucasseikioshiro@gmail.com>
 <xmqqh5txfv7b.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hi, Junio!

> * Instead of munging the expected file so that it contains a NUL,
>   and compare the actual output with it, munge the NUL terminated
>   outout to make it text and compare with the expected file in text
>   format.

Ok! I'll do that in the next version.

> * I see your -z output is "<key> LF <value> NUL", but was there a
>   particular reason why "<key> NUL <value> NUL" was not chosen?

This was a suggestions by Phillip Wood [1]. We've chosen this format
following the format of git-config.

[1] =
https://lore.kernel.org/git/223c7cbd-610e-49e2-90e2-5914cbc0f1d7@gmail.com=
/

