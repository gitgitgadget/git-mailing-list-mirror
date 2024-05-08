Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF979EA
	for <git@vger.kernel.org>; Wed,  8 May 2024 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132393; cv=none; b=jvr8+jEURZ2v5AKnxpf+lXcbEznUTHIRq9F3YbGqzCerKFSSkymBv/nSHzNZ03XrrXnU7MXfUuxJlkC8fuWkwUjVpxa75T9GCkdzIJpACTzv0xugqFNzwBThyE50f3f9iJa2GQEbixYxhoMfOaiwxDi61Nvv46cRQLx/sXAIrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132393; c=relaxed/simple;
	bh=9R/Cl13LPJqoQ2ENwnzVC7D8bwE59UF4U02EdY4vWoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzLHtRvwvYfVyYTIIO96mYtZUBQP8qaR1VlDpy7kE6KEZo+rdY74wH4U1TwnO9zRy92OAbpAUVZ+o2ksP/RUmmHHa20DYrKjWdkGbzORwMzgMGzry2EZUenYbYGrjD6LCRBdClCiW1G/mtjgJXSwn0bq2BfTYVaHemOhltI2zFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwNaIYas; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwNaIYas"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e183558b42so57368739f.1
        for <git@vger.kernel.org>; Tue, 07 May 2024 18:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715132391; x=1715737191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R/Cl13LPJqoQ2ENwnzVC7D8bwE59UF4U02EdY4vWoo=;
        b=RwNaIYasgw53DsMYAbX+YAAL8WAYhMcaT3MNNY7ekUzFMPWQTzrGeznUq2rLrb9gMF
         +oQxIfsoqyGTAkW5DtJQPO6dPpLzblA3b7r8C+6xrx/n7mR19OVzy6VSB8m4wyBTB4uD
         haToT15wq5EnjHkjmYuBxYhzd8xqFRZacOBN1BGKux13LND4yS4YuMIFMZczCogQv8Md
         BpchVnFvX5K/9sN4+V6G494SqZekVb159EeGqW1oC7CCz0PnXwuDepsomtPUXEHDbVey
         UKGgKTyBEXw7r3LSBVD9QH0cd8i4mmrShByv2ZWuoY/5nNn2rq+mHU4d/+3plNG1c45+
         FTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132391; x=1715737191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R/Cl13LPJqoQ2ENwnzVC7D8bwE59UF4U02EdY4vWoo=;
        b=K74p42tX55DU1p/0t1Km/TrVWkCs0aaDB/Gxj1TW3MPbvGDORSSriomieeFmLAEovI
         tCACfUKJ//5vSWG9ucURV/90slDg0Jp/ARr8auDfMJAK3YMLVnpdh9ICo4WtyJ3I0r/w
         5akQLOjuiwRPCxEprKEt0lvOBMm0yALTEUsvx+vtS+mweliHG8azsjOyAyfw49TMQeN3
         pywVBEIspjUKrkrqaJXKw3BcQMLXXVSxQ5uLNsh3ni1/M6Y55bCmErj+SJBSoLgvpBO3
         kZiZWI2fjppn16bDVGaY70yeK0uPon+wOvv2vtT7/KH8fn+Zm03rCq9r0OGbyFZORzM6
         yLYA==
X-Forwarded-Encrypted: i=1; AJvYcCXoLUMDjnP/1cD1toMu7YptJIbNMDw6lZPFZvmAnuwGnSaoIOlzTk8ADfLEQf76f+XuUExh1zuZtv8igc0FzYtVbfB4
X-Gm-Message-State: AOJu0Yw33SAZD9T3mwmuK96uRxBlkuJq1cAXRnzzyWS/vUpZB7MXKug5
	JD5FTqtigntojE0Q6l7Y8PyeskH+AJhy8CtfcMbQXF32SYmTz9ivn6I5nqanhLaA88RjdJs5olj
	GbI+BpXs337NqTgJr5GRdz8XhpWtjtg==
X-Google-Smtp-Source: AGHT+IEsjzEAvgSDHjuXsA6nmJo1h4wexE6vsfijPwey5bzB/XWYBm303bAhYT0YeXIih8R67zBid5ZoYtDtvbw9rMk=
X-Received: by 2002:a05:6e02:15c8:b0:36c:4dab:7716 with SMTP id
 e9e14a558f8ab-36caece0c14mr15199475ab.11.1715132391040; Tue, 07 May 2024
 18:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
 <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>
 <CAOLa=ZSre3f+0SR-_migfkPONqhinobKjU=NnGOJ_sTNM_L5ug@mail.gmail.com>
 <xmqqttjaydbw.fsf@gitster.g> <CA+WCWMyxBA90QRsxn-i0H1TRi7WrhRcD=Tgj07f_Y_=UVNkhbw@mail.gmail.com>
 <CAOLa=ZTu1to4HRc8sD2BcA+1ZzgcnXW9nHb1gg_VEG=nLOjHvg@mail.gmail.com>
In-Reply-To: <CAOLa=ZTu1to4HRc8sD2BcA+1ZzgcnXW9nHb1gg_VEG=nLOjHvg@mail.gmail.com>
From: Ivan Tse <ivan.tse1@gmail.com>
Date: Tue, 7 May 2024 21:39:39 -0400
Message-ID: <CA+WCWMxmpjeYfUGb=eymFF-xD7mopP0nVMSh+KHhOtrYU_euFA@mail.gmail.com>
Subject: Re: [PATCH v3] refs: return conflict error when checking packed refs
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Ivan Tse via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karthik!

On Tue, May 7, 2024 at 9:37=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
>
> Hello Ivan,
>
[snip]
>
> That's correct, my question was merely that we also have a
> `refs_verify_refname_available` function call there and was wondering if
> we somehow need to catch and propagate the same error from there. Like
> you mentioned the way it is currently structured doesn't make that
> possible.

Ah I see, that makes sense. Thanks for the clarification and for the
initial question!
