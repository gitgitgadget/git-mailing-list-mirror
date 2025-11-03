Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B62D2499
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156732; cv=none; b=DTJ0btNfz4WnQ+WyEVJpjjTOL+4S9Xh5G7c1zUarw6BtrndRYl00qRF/cSDEvYPQ070OOac42EOHmLzmFELYdFF5/8qF12QexrM3wl4dyAuLQ6laAbkiXkCAN+0OxosX0flvDEMH8QV4cMlJG1jtMUL3pCn/OW5zKZIuUuue72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156732; c=relaxed/simple;
	bh=K+1PK1+R/VbxLSpW6dTcrU+QR3GcmvhlhFtH74+Jax0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gY+fw5HXE5FEThx2OalP/BoeGMkKHxdMNtc1GL3a78pE5W+NDOl0knbQXgbWFm58HLHbBKo60M55Wo/DjYp6vT2MswL1htZQjnmXbZCjGYLz+uVym/JKTDIAfBoeq1nhpfagXIGYEpAWq08znV4n6gAlSnwKAMsfSWYvPVwff3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRpOuFco; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRpOuFco"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so2198919a12.2
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 23:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762156728; x=1762761528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+1PK1+R/VbxLSpW6dTcrU+QR3GcmvhlhFtH74+Jax0=;
        b=SRpOuFcoXZjuMgoM5gIa4NbLiXZ16MVwjjLsclY3GzNbUexyCKYpzgV+E1jI2I5bg8
         CGKMeYx32q2h4Qu4n0FcHK6vbYQnBvJc8lRUFVmYJLRSg2ZYP0ZH/r25+sp/JJN+Y3a6
         qKYnDF3hIsdYT3ehxgwvCwhiJKNh1HpDc2S68ufgsXF/9Ty0dTIUkOyUWYE15QGnBGLQ
         08rqoGufIsEyO5dMCW8D7GPLhush/4YCPcIu1FNNbLNQauW0JI1fVixg8lVtb37zZxmn
         76pPG0NhVJZ6Y/IGGQBokVRW1jOHPq5ILHcg4MdN5t8Tvnu93IsYBvSIhOTOnXAzZFiW
         U7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156728; x=1762761528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+1PK1+R/VbxLSpW6dTcrU+QR3GcmvhlhFtH74+Jax0=;
        b=J4xkcyhzkP9M0eiTxxO8aOPFHBtPqp0icabSDv1XHtr6FRryR6//gdMSXqiRAI31Pt
         gUjVTj+VtYT/3xOysOPwIZIiOO18k4hVth7OzNbWvTXUoATYjaIDuzMpZ7Ne0NCh/fRO
         3gokX+G7t40bI/GYqvfo3x+qE1zlpPQm9toxtnRTzgNRds7f7QlvAL/Ob8oReFQuOOVg
         aD5JFoisGxvS/bltiIDA7gR91jus4sZF/NBoUMc7Y4lMWxvIUWCfAJDhHGwmQN/Gvzrr
         cbD5spt+C5EJt0WC/zLFg7MUYF9xBjlAanU5P7bT8Xl0+XRR8teegIk6CiwXQM9pujh+
         Jizw==
X-Gm-Message-State: AOJu0YwPFOCAA3RUz4/bXDYOHengR3gmMc8Y8Av4MAh3YoWzZIfBA6cL
	FnGSAYHMtGZlZNp//9+H3i5uODieix20MPGUJhhLzesOEP8Tr7H0oDx91zpI9Yv8M7bjF+zxb6l
	+1b09ZqFYCmMMjlVEx8HzMhgqxuOzkTN/l/+Y
X-Gm-Gg: ASbGncvlwD0+Nf7dXucLOm8K/oQmI0PECS1Hdm5/Pe+rSpXS0YfxZ4J5d9hGc8g56rb
	1VhnKih6EykW8zy/mFXtORKZ5VObp3XnzAVaEwLw5HOpB49Evx0uXYq7UtYPOdggMVH3uNUW80n
	YphEL70uVsUFPvX2bRlU/Bczz1g3CMHCOPuKJGwP7YOTuE4K1IekIU40ZL5jFXbHM/ef9ocjgYn
	MFOa1wodhBB82uAXUJyFvzHVvsEn3bQG2UnmcXxy/HCp/Ct7so23KP/8CTw
X-Google-Smtp-Source: AGHT+IFYy0f0uDmFGgrCdUdjouloVRNBu4Ol2eJ0wnvoAo+zreioC7/Fp5QhV6+SB9DzD2gxcsjsblxPnCIb0JvV/vo=
X-Received: by 2002:a17:907:6d09:b0:b70:fd2f:6a46 with SMTP id
 a640c23a62f3a-b70fd2f6c1emr170510666b.20.1762156728148; Sun, 02 Nov 2025
 23:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQZaqG6t4F6XE0nt@ubuntu> <CAP8UFD3TdUb9RBktdxwA7Qj=6Oxqpzg-ZrVP5eT_+38TPE+n-A@mail.gmail.com>
In-Reply-To: <CAP8UFD3TdUb9RBktdxwA7Qj=6Oxqpzg-ZrVP5eT_+38TPE+n-A@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Nov 2025 08:58:36 +0100
X-Gm-Features: AWmQ_bnHc1wxW5Ja6l06LO295mmO4VTThys_KjJ6gHW_2ApDTlEeELC3H6o2CoQ
Message-ID: <CAP8UFD0yamBJQHT8eh1=u9-m2f80K9FM21nozB6paPpEJrP5wA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BOutreachy=5D=5BProposal_v3=5D=3A_Refactor_in_order_to_r?=
	=?UTF-8?Q?educe_Git=E2=80=99s_global_state?=
To: Bello Caleb Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(There is a "Reply-to: 20251030144934.9689-1-belkid98@gmail.com"
header in the email you sent, but that email address doesn't work. So
I am resending to Bello Caleb Olamide <belkid98@gmail.com>.)

Hi,

On Sat, Nov 1, 2025 at 8:08=E2=80=AFPM Bello Caleb Olamide <belkid98@gmail.=
com> wrote:
>
> Hello,
> This is the third iteration on my proposal for the project
> "Refactor in order to reduce Git=E2=80=99s global state" for the 2025 Out=
reachy
> Internship program.
>
> The change from v2 includes correction to the subject line to have the
> correct encoding on the mailing list.

Thanks for iterating on your proposal.

Please make sure you properly submit it to Outreachy though. It looks
like you haven't submitted it yet, while the deadline is today at 4PM
UTC, so you don't have much time left.

I will try to take another look, but I am not sure I will have time to
do it before the deadline today. So don't wait for it before
submitting.

Thanks.
