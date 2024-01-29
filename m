Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFD5576E
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520954; cv=none; b=rvqPs9fyimk5NIFMbEmqOlfFX+MLThho6UFi3yh1glG29CIYJ+BzRHkGXu0dXDautMVEx477grvhKjJ1FdX4bKcd5d84+GVLZBMC04AlEc+T5ZkHkE+1Nyb4qEYswlWk0/QZJj692RLvYnX66TMC1O0Q+ZK2J6zZzn2V/qANLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520954; c=relaxed/simple;
	bh=TkUkYK8hj2YMMr4pbX/sHSBKTZflyeDrMKL50/ffmeo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UIWZ83U2E6zn89GqOVIAsXtKDRO5SwqQh+k5zUQ49nuhibIp6treFh0nA8S6gYzJsdwlOnYP60ZC3QwDk7xxkWzeprDTebGatbbnejhV4MH+wjDGPKG24cCsPQwP1SflWk80JyjGS/bcxFGtWUOEGgwGj7rhh/QnXLCiEcn2W5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j20BEqkR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j20BEqkR"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5102b00c2cdso1580751e87.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706520951; x=1707125751; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgW3qYx0fmomjY3NSQrJylfIvLUYogsEt64XsvefmSY=;
        b=j20BEqkRsHGU3g78mCMu6NWao4elPKUQ5fysNmIpsiiISZ/5jEU++05P3jm6IealaG
         nynMBimftg7+i8+ChDs6+O2QiB6e8lKHAcwaYdf98Dmdii2nFLjfOu/0w3+oQccl4chm
         ReoMQI8db5QsD2TgMqsNJ7Fx6iQqp/uKstMtUFhlRnvXpZDEHVD+vLIJ0rvjXMeYMubJ
         k/rBOy05Iarx5ek1i99qAKGo3nr4uE2KFoV0DDWDiajo+eqa19x0MT10W2ZHpgu62tVb
         LIsH0hJ27DPWJIs7I4rIjSIwqL7VdqcfYHBfl1/SnvReLJJjmIdeSJwiItOJobLDFQxU
         FRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706520951; x=1707125751;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgW3qYx0fmomjY3NSQrJylfIvLUYogsEt64XsvefmSY=;
        b=W5i1Yp3Co4Hf+dN+/MYZoj2Ng6kTKSQnsu4HKEb7rXfPw2n7O3Q1o11SUI0WD0Lcq8
         Bm4ZZiCiM7sjx05Rt68lBsK+DQbCRLHKAVO7bu7auIf7VsnFWuls1a/qqLUZUWHCUcj4
         iGzZVCsB6oGRC2vYfoMlbtRT8pSitLo2aBpA+QNuT5fkB7uFz/yU38QBv2B/OCGOvWr2
         QkoyZNOl3fwN9uzmsZcettOXlrZXuOky77kSZ7E5uW96aMv7FCSTwj60IJ+pfhm6SdvN
         Td6nxrR7C1ISAlnhEkwnVO0c/ptJUV/FQNFXvRVbzXPSLgM7XRIO+INikrI0Ut9qfqQS
         Ne3g==
X-Gm-Message-State: AOJu0YyrbeWmbF+3401kLhe+I1vs4Qfhz50TpSutaO5uS+5j2qwjTL6j
	uMF5mun/F8NqE8yUzYBPW5x0Te+T5OiJkF3DPaop8j5Oh9gP4OXgX/5beEdA
X-Google-Smtp-Source: AGHT+IEgbjOG3/mgGeINtHFBXRoyuvpURG3vUU0jZopg1mZ53GPeDMLxnLdNb6T+KC3ogAnwUItqKw==
X-Received: by 2002:a05:6512:2209:b0:50f:f9b9:f542 with SMTP id h9-20020a056512220900b0050ff9b9f542mr3600776lfu.7.1706520950483;
        Mon, 29 Jan 2024 01:35:50 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t8-20020a056512068800b005100ea98eb7sm1048121lfe.229.2024.01.29.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:35:50 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
	<xmqqzfwspmh0.fsf@gitster.g> <87ede4fg8s.fsf@osv.gnss.ru>
	<xmqqzfwrjdul.fsf@gitster.g>
Date: Mon, 29 Jan 2024 12:35:49 +0300
In-Reply-To: <xmqqzfwrjdul.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Jan 2024 02:00:02 -0800")
Message-ID: <87jzns7a8a.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I'm still arguing in favor of fixing "-n", and I believe a fix is needed
>> independently from decision about "-f -f".
>
> Even though I do not personally like it, I do not think "which
> between do-it (f) and do-not-do-it (n) do you want to use?" is
> broken.  It sometimes irritates me to find "git clean" (without "-f"
> or "-n", and with clean.requireForce not disabled) complain, and I
> personally think "git clean" when clean.requireForce is in effect
> and no "-n" or "-f" were given should pretend as if "-n" were given.

As a note, I'd consider to get rid of 'clean.requireForce' anyway, as
its default value provides safe reasonably behaving environment, and I
fail to see why anybody would need to set it to 'false'.

Thanks,
-- Sergey Organov
