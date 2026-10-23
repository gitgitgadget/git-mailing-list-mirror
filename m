Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792774161;
	b=LB/slz5ODbHtYNg5emR3BE6IDet0skJUojVayq9VReNE50h8XhgShc8sWvh17GjyqG+G
	 Guddb8G18w6jjp5kNLHlreq0fFm1y9Icd+6kjkq91n4dja51FEmjbaZUYnJ5zezNownRL
	 plblDANmIyF9jv9+NzQrlc4gw5L0XtsG3FsBCEa37hdcie5lO3nd0fkdecQKRLumDZt2w
	 s020K3ZddYABFfC0oIU+FuA7M/qJMbHyL4OnNG8ckACGA9+GGd1Cd0LOIzyQv/sQQ5eVU
	 +2I+hjJgvMb3qTa7mf34+wFmw03zVxxbz60BuioAq1tHNA5wl/Kk5ypDvxt3Z6VcKiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MdlYi1mlVTuA+5B5b2WEXam4D7mnHaFwowHPKoVcooU=;
	b=r0aHkXy44TZvq3ZANc5/rNjRAGp7KRmRAQDRv8VAh+2mr5NMZQU5c+au3WOLKBSwcXtX
	 GNSmvNpTfU75Zh1bMiEFAvw+nsgLzJDal+e5y59R4kvjJ8DztTzAYq51LwlIsTSTqXW6J
	 o6SUKflsLSIgbvgbjBXs4hmi3IiP8fhTsDRxylMK0dlN6dpmcgRb+WE0RZiYr6jbdCCjE
	 Ro3SFeKYWkUnMjeWzlhsIAuXuxKgg3gEaPm9eXL2a1tev+pkCiC+iZpfB2dm8vM641tlZ
	 rLVjCe0hHMbZvExMH/0zotIDBk1gfU10nyYmt2FlNapRhHfrMFb7m7VCiCS02aT3QRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UKa9yPKz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68A606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF68A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UKa9yPKz
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91791ec1b83so9309656d6.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 09:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792774160; cv=none;
        d=google.com; s=arc-20260327;
        b=HXH/BD8L1DDotAHAuCN9BYgYyV2H7k9QfXz7reqAoBuY/Ew0r2VtHgsRwaSQREMcg5
         AUbGuEiRvje9zBNVel8VM91wEHIJkBu3blCqGfNHZn5Fhxz9onc8GprWvjmLFgzxzJ/W
         /T2TrbIgCYzhels+/bwTjzToLpyYCvSP/Qwl9FuGQExtuR/InDhUWdeEfzzTf87o7ige
         AOxeHGxCL3DLot5VwXCVZBrGtsPHT+INVevSxTzPQlH3c7f8eCS/z3xT78BQF0e4QMOF
         cAho2PaPNp0x3T4jp3M4Amfh8JGZjz8UOGwQBviLhKcN6xSIeI0JYmMyFu7euqfHK55X
         qggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MdlYi1mlVTuA+5B5b2WEXam4D7mnHaFwowHPKoVcooU=;
        fh=CzydaGP7awRQ4r8cGtpKOhdEUB4ulky2c57BrGY8DlA=;
        b=e7QXpveFTnYRkp9pg59VHAYEpSoSGdgl5/7FgXaSDuTDr1MLTCQ6Tw9CesHXn4zhFn
         d1lqyqySijNcVIMa4kU4VfUmi6NvbkKrcWmEQNONKu/qDizNcI5Nd2I78OswpE3qG2lB
         BSWYbdRDvDTJRYUFgQjYyKmCL8DVYI0A9Ul0+mqBg1hCRsagFpyjHjnck0sbrSYO44uV
         yZ43vFyvPCEIPSBzl1pjgbf6mIdNU3CAiV2kAU1AaYM/IPikwYuX+2mmdIsAJNLabxDh
         UQZTyS2bneQdn/ooMiRwjcS7K2VRGiEDfQzLLNpM7eh1topwK/dE53GWnxAjLMe4Fzgv
         q+kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792774160; x=1793378960; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MdlYi1mlVTuA+5B5b2WEXam4D7mnHaFwowHPKoVcooU=;
        b=UKa9yPKzW0L03ykq1mu7BmnQy8EZ3VYbB2+hQFpsSmu/bU7zJ/5j29+7j8Fu2OFTB6
         EV2NIkCptdpaS+HFtv8RoK7Id6BxVlQdATdi8pp06HqydOhYEYfagGRGHwDxzMzrUbrl
         zbmbGxz17rPYX2GPrhTt806QHuJERHqVblDuISGGA/0KrAIbKlv7Ow3rP7yESeowL/UB
         omprBtdocuCSbvt0ig9JTz+hGTT/kJdoO243ZpvY7MM16ZQHfdc+kOWMp0ewAr3LTC+E
         GiTy6Mr53Os85d9OKtq8HXkNiI7VVj9CApfOmxYX6TaYalOCXAGT8iHaVFTFrEE/u6VI
         N3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792774160; x=1793378960;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MdlYi1mlVTuA+5B5b2WEXam4D7mnHaFwowHPKoVcooU=;
        b=gMyQr9yyK+oCCkdM4+TL8rRUcmkFDnm+Msgmn/8+uS3PPvZ/HabbqmInTnFr/UBkVt
         boknRcoyhynEqIoS2BQFoaG7UL9Q34XNCJaXssk1c3fOrUURpZw4Vc4jdNokfWLUYRsG
         WaJAryZdaJPiMyr/iDdM0rEcX/sS/l0d/5E18+iXh4Ag7naZiNHTaCdz9pKTN9VFzXCI
         M/WmvaTg8Y4YE8RxF7HZDgK6vFJiVIhkQjJ/1mZ0zUQXb5pBwLGBSxRfgnvaEcqn/YVO
         W8VgY7tZneiprhKmU3SoH7bGgVzSKHvn9jK2R3MBvpPH5UnRPCP+mJq1o+ZVQJb7uw1U
         qSMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqNQMLMpSJyL3648At4bXqCXsNjI4Ok4hBIzTQluAJWbo7jHt0gBtAheHcytqK/QKpUXE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLProAf3pz0xRd55Pl5KkzHxoFtVl9tqLwP2/c18PpCx3/kqTs7
	1zChfDSP2Sj/TqJmZQPY9wWkZVeK9xD7hVsM5jrlzzZmGddQRT8xaFWEWsRZvuQ7tfAWTFYhZTd
	D3dskGdsUnOr8hQ3DNMcdEYOHPGz9zec=
X-Gm-Gg: AYBFou21WTk0k4ZsfRFzk+cYNw7g5jR24HmewTque0UKMXojIIcUMRyPDYf8bmuQ2sI
	4FtNgWbZCjfh8YWMtdKg3wEE0y0Ngk2rj6fJS/xbSjfFMpwKwUd0JFh4fsH84p5XuYU9JXnyT49
	6LmdDhVLJ+nh/J62P3CIttr3bt6dwaE+Yf4VMKZhRMUCXmlDOrXidWOsWiWuzyF09AFbcohlSeO
	PcRAluDZ9pkSfiZnppLVrRqG6U4KYEv1SOkeCxvzMfepqN9+yvUxSkVSsqesC/H5qVFfjPcFPYc
	K6GSwWraOQH+aKp4T8b/MmBBdChLy8QNmQN6lg5rPC7ns+50wLunQy3a5HI8TCH5TPYtu4AnNR2
	sSMh8/+ofWQRMIm4MsFuZzWTR7Yp2F1st2hxvvIQzWGYtULFRIBJTeNaAOQ==
X-Received: by 2002:a05:6214:459c:b0:917:ac44:8740 with SMTP id
 6a1803df08f44-91c3a8ba88amr43633146d6.35.1792774159599; Fri, 23 Oct 2026
 09:49:19 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
 <aqeTas30Vs3aGE9D@pks.im> <CAHwyqnUG_ta=m5e7rk-35D0Dve+GeQX3eNuFf_U4kSd5+Sqy+g@mail.gmail.com>
 <aqen3lVdecDqo89w@pks.im>
In-Reply-To: <aqen3lVdecDqo89w@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 23 Oct 2026 18:48:39 +0200
X-Gm-Features: AclHuK-d00o_ardxP29V57Q1P4CB99YfhXXSTLBc9hUSvnjeExoXXswI63GLxQg
Message-ID: <CAHwyqnWL24G2KNPxhiems4zzU2qEjZE0_jqrJuHXCuYp4FUR-Q@mail.gmail.com>
Subject: Re: [PATCH] ci: drop no-op gettext link on macOS
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If you look at the pipeline though you can see that almost all of the
> jobs were skipped. And in particular, macOS wasn't tested at all.

Here is a rebased branch where all macOS tests have run:
https://github.com/git/git/pull/2402

Would you have time to take another look?


Harald
