Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD5193438
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225426; cv=none; b=SaJu8p/wYWisEH2pGkUzc+P277/vMwywE7Ysfx1FwpMUWp2kVX3U3N14NVSk023cP6WdJiO5z8AKEB6COknAOpjmc/ee2J5kfNzAJrxkiW7JDF4IAp4FxLDeZ0srg0/MIpwoaP1c3dOknRw1u2OZGeej0cQ6ir7y1101Up4SBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225426; c=relaxed/simple;
	bh=TzK7lg1x0vCa6+7DGWbVwidBULrWRISxRfhxHAAJb28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRs0KfIHDiYN7J7ZCh4c4IgYEjgPOv00A8J2H0zurGQYoOd/5+jbcTtGuTLzBa7xECqnaN2pgxHXBFoWsEB1pGYsG1ikdw0J4Osto0wAAuKOBy+tC5rbp5WjFczi21IyeSCovat2zCexqFOJK72VWzXqjbHmgM0eX7rM/hm0rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c90GntF1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c90GntF1"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so662681166b.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724225423; x=1724830223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TzK7lg1x0vCa6+7DGWbVwidBULrWRISxRfhxHAAJb28=;
        b=c90GntF1a72D2TVlfadGq53+HJuIYAAHd/hjLH/YtTnio4GDN2herSQIzSJN035lPl
         Tz74e7M0qBRcW55BFWgzIslzL8zA/cM2no1k1bQBu1nD+iuvC8S4GzqPWgg3+8TvUKH7
         t5bwp+x5Iwr8/4WAx87IGz+a3IMfcf2fOOS3wOY4myhLkCXdGjNqOrOlR2LvOWcE8M3Z
         jQPGNQuiIwrt2WCJyzVFOuhhfuecBF74/gS5XW9JzVfO4v76ZeetXthUJ26sHPd1cubZ
         57WI5owqTs+uC6AqqwDjJ7tLJ9JGKadduTMRrljnEcsBLPjCOKN0QFk/Eml8F947Mi4F
         N2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724225423; x=1724830223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzK7lg1x0vCa6+7DGWbVwidBULrWRISxRfhxHAAJb28=;
        b=dCvjDBMYy89FGIxHW3Dga1n65SvWVFDo84U05cf57fGxPoDZyEtlt3Ho4fj9RhaLPE
         wGC2uZNA9cIRhReNFn8cfbzZeMqVW3SvAC/GD/ZEqmbltp9ieJA1bW9QSIwn5lqX4DRB
         r/8GM5yn53+SQrnH3i3INWSMamYk19i5sseaLfdh64LKRdqSTd1XtCY/cluofLab5Pts
         bpFK6RSVmZvIsTsIe50X7PJ7EYywH/ElKm7wTD/wkYUs0L4h0+7S1sbHDElRnQ/+J7JH
         8FG8Qecc84HLwh64nU9+Vp7erz/m6Gl2G1EqNwy8ekz/3RBRGcszuah4Tb//shv5YEHP
         j4FQ==
X-Gm-Message-State: AOJu0YwnwwkVmVO4e92pKMmxsRjEIopTfgwxlqycE8mPJhf6niFy2VxO
	81A0D1zfZoBpWYljvcPaIeGppnB/i+id49W4tdCo+FA7+uGaIwiQemSUFbcC8RAmZ9GdzxJLvds
	EQvs7OnWGwM2WqG83JRG6JWurjb5yvGlz
X-Google-Smtp-Source: AGHT+IFYt07gxsT2by/9s2+bC6fX0FdLyOMpDvykVL5stJhxY/kMNWoDcQdBCYuVRQbNIpcurIYu3gsc0/YKjFHmR3w=
X-Received: by 2002:a17:907:2da2:b0:a83:62c2:6d5e with SMTP id
 a640c23a62f3a-a866f8f506cmr91853966b.45.1724225422681; Wed, 21 Aug 2024
 00:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814121122.4642-1-chandrapratap3519@gmail.com> <20240816175414.5169-1-chandrapratap3519@gmail.com>
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 21 Aug 2024 13:00:00 +0530
Message-ID: <CA+J6zkRf5D5a7j2T_Ro3PLCAAXeYJ7Nz6rC3V1gR67mcbO0ajA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 00/11] t: port reftable/block_test.c to the unit
 testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Reminder for reviews/acks.
