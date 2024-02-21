Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399E79DAE
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525502; cv=none; b=GUpvSulic35temxXMhK3NxbP8vZ9PfNxzB9PVfkZfc3AgTR9or47s6u0UYjzD7WfA1nbbYb1Co4pVKnH2oiQLZ+YALERhXmOp4ILl873/75wsxhdmDDm29NYY29wmLX0kBrEfk2KskUlCKa8tB33nRO4I452/sV/gNPWqAr6yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525502; c=relaxed/simple;
	bh=YKBBT5Wsmhb9IdprSnORXg8dX4QMNrOoFzRdZhepRN8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=DrjcscCOmdaCfIZCdJL10FXRwbgjxapxX34byDoLck20jO3VCwcpFH48wM0OWs22cuWkaox2EfkA6lPtfQx1uOcb9wXEfm63a96V1mTAXSoYrhV+23tB4K5oGvfLTLkgDUWF6zbOl2b8NPntb5bWGzPjTsOcM2j2rZJAu2bf+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6rHC1qJ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6rHC1qJ"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e45439925aso603091a34.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708525500; x=1709130300; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=YKBBT5Wsmhb9IdprSnORXg8dX4QMNrOoFzRdZhepRN8=;
        b=b6rHC1qJxOqhRn2ZLu+jXFbaxZC303YTZyAhWyjOvEjms1OscgOd6FSDHQp4JZvDFM
         Rbgqbe3dMEtuhLG/NQ16jJhKFRVnwU9G9TQV6K37wi34in2mJjBGNAF75+2iOrITCcXk
         0Fi+0UlpkrrYMzsrCJexLTmg3G9t3B93/gnM9r/OZYAOaE38V1GzYG+WjRt0jMR8vuqk
         +TfuQsOpyICx1ZnkTuX69rwgC2OBqjZwLSt1s/Wf69IdXKpygqGJ73ih/J2cOOCZ46Xg
         PkvzQPAgQhJtzDEI0CYsYhGfNn79J8JGJGCMajWN/5/cWuS2F+ZwFhsgeXgvEPHggNC2
         9RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525500; x=1709130300;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKBBT5Wsmhb9IdprSnORXg8dX4QMNrOoFzRdZhepRN8=;
        b=aJSx93lcYW4TWobsLUTlyz28qIPg5TtT5ssKcOUIvO+y9+w+l77F8Wkg0rDQnkt5FW
         0uNxgtK+g8aVPP4DI6U2lUyDqtl/gdTd+317LbyFxTSubQbHHy6An4AxwUimcSxbctKP
         Fhzuvg1MLOBVBxe1gxodha7FbucxtM+craST+xIRzGHnLhqTFk+F19nQW2+M0FE2V0DR
         97aunlnstlyEtvm31sd9ix3DY7n7oos7C+4pwPjJX3e4Ypsq7wNMlSUFHMvem0CWKbcm
         lNpjNq2ZT2Tu3uvKgC2UHXVnQTuyGJFJX0c4wz9DYYTlL15YXqywAUgvENY97UNom8V6
         bV3w==
X-Forwarded-Encrypted: i=1; AJvYcCVsZFHMtoHTf4LBNNxmuRo5l5Coxz2IBnS9sSHHfs1ew44C7sl/qffsYC9M1B2Rf7WVagz1L0r85FWJEVrwozCg6e9N
X-Gm-Message-State: AOJu0YygmaQ6qD4dPtGFL/aRVwnHXfifKwZZ/OpRz3CxbIjq+hAo8vI3
	w5BOC5+N4oEgAriWf2JSwQ7ZEf363TQB6JEv2ZDX9cHOlg6ciZnXhTnTzFzs
X-Google-Smtp-Source: AGHT+IEaYqlDihv6MJXN4oUvFaRV7MegHm7HeqwhqLXYF9fj0BL+xf9CiEuMYMlFeBp10v9fHlMGug==
X-Received: by 2002:a05:6870:e244:b0:21e:636a:b96c with SMTP id d4-20020a056870e24400b0021e636ab96cmr15938469oac.1.1708525499507;
        Wed, 21 Feb 2024 06:24:59 -0800 (PST)
Received: from epic96565.epic.com (pat-verona-h.epic.com. [199.204.56.213])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84794000000b0042c70c153f6sm4367815qtq.91.2024.02.21.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:24:59 -0800 (PST)
References: <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
 <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com>
 <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Maarten Ackermans <maarten.ackermans@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: Breaking change with "git log -n" since 2.43
Date: Wed, 21 Feb 2024 08:24:26 -0600
In-reply-to: <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
Message-ID: <m04je1dhdx.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Maarten Ackermans <maarten.ackermans@gmail.com> writes:
> Applications that have been relying on undocumented features and
> limits since they were introduced, now face a hard crash: "fatal:
> '9007199254740991': not an integer". Regardless of whether this is an
> improvement for future implementations, a crash in existing ones is a
> suboptimal experience at the least.

What behavior would you propose instead?

--
Sean Allred
