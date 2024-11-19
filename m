Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F61D0149
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035175; cv=none; b=jgJ9O4r9GSiiQNj5xBFvkUTlz00NyrDrtta3iQERd3gUq5SuN8d9PCJqumhFC/y5hQd02/5KBTRdPbcctQkV2E/6oKqlWbhu4zFDauuth3gjvFkRcS32Y378W+DINY6YCveVLG65fxcxyB1b24CVefnwHoNWEdSeptXzGMtmrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035175; c=relaxed/simple;
	bh=bcLW8gEAoNxykFoxvJgFpypLTeTlbslCyifnSt15TPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKodXHA4En01odOulpgt1MdzVQZxbicywUIa4p618Gput/qhOq1yUOUgsLS9xei4iS4eQPD9+aj1iAjDjCoO51GPkl6SFf3UnsExHbIisiwiyc7kR2TD9nabVT9avRoEu8hRmHyncOiD99ivdvRhAzTlcT6Ihozr8iIy+Iw5VHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwk6DMC2; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwk6DMC2"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-296bff3f5e8so437407fac.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732035173; x=1732639973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpdSJ1NJ0AvhBKDupQVBrn+84q0pNQnF1kBa/6EeSK0=;
        b=Iwk6DMC27lcHXTUy6XfNUdh2Oh9taXWMSHvNtPpzqqDGCVja/IYWAaWdyTJKOcaTr/
         dqqJkcJeEYWObXVw1zSMaJcQmCvCExRSVlFb3myhBrF110pkMsZUQwcWaiYbhiVNxVu4
         cu6eCklZnvvaYon9JxCPdEJwT1Bg1/UtMubH2n8guo39t8N0D7q+PSmNg0NBXHYP3KFi
         wqPEQ6yslWOuDFzbdaLWrMP/4sypAi4xcDJBWoESqC4bJy6B53KCOgxlCAKuhgovtTbp
         Dlg8C1dYdsB8vReZAffBCCxM+DWEep0m6HbCPvFXqkrXq7y3/vnOgwV6GeUKJACr+vMI
         cFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732035173; x=1732639973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpdSJ1NJ0AvhBKDupQVBrn+84q0pNQnF1kBa/6EeSK0=;
        b=UqjayN22zVNEi/0uLarXZIkQaJrgMfj4QfSScDIk6PzusTtZeRBKj07yQHhunDyBdO
         /F5ejt+I7pFCHYdcaUWLy+D5jbpDai1sRlrI9qlOrySWRcIqCJ+nT9vVL6c7+Fhkdfxm
         p1+XQZrRhHAhtlPSagdFFKE23oTcb+HikFQnMufcOwV+T4HInXF/7KrekoE+/0x8SWO/
         D+kWfw3QuOBG+4nGh+z37T3pPibMkLB9SDnUv6lZs0u0XfdbJZBIVNMULQipHCmh7Vjg
         mCstWFKEU9J4O+SI1UKsQ3VgNaXyilx97wDefyScaOdSlw4qGw6A7bz6L4fbcCIX8sSG
         tSUQ==
X-Gm-Message-State: AOJu0YwWQNBiJnjMLrVE0C0ZfGZ2oRh3p6KDPF0M7EQqSJLEqCm4ioT5
	vConi4Frs4VBg1WYRGuzV9O9NZsqrkEW132XbONhf9CXq9wZAn0+
X-Google-Smtp-Source: AGHT+IFtnSSvBBegUIu2SAkQ5qUulrYNAyeMaMwmXvq+hJp35F3OHGGk5xgtYc6oZ4B3bDgPABh0uA==
X-Received: by 2002:a05:6870:b508:b0:295:52b6:4875 with SMTP id 586e51a60fabf-2962dddbf67mr11768070fac.22.1732035173489;
        Tue, 19 Nov 2024 08:52:53 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm3583022fac.42.2024.11.19.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:52:53 -0800 (PST)
Date: Tue, 19 Nov 2024 10:51:03 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Build improvements for clar
Message-ID: <7jdpmcwlxtyzqrqmcftcdmrw3tqopawtuuzqf3uaff2gklaxba@covcdisniubk>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
 <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>

On 24/11/15 08:32AM, Patrick Steinhardt wrote:
> Hi,
> 
> Dscho has reported in [1] that the CMake build instructions for clar do
> not work well on Windows/MSVC because we execute the shell scripts
> directly instead of using the discovered `SH_EXE`. This small patch
> series fixes the issue.
> 
> Changes in v2:
> 
>     - Wrap overly long lines in the CMake build instructions.
>     - Add the VERBATIM option.
> 
> Changes in v3:
> 
>     - Fix missing word.
> 
> Link to v1: https://lore.kernel.org/r/20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im
> Link to v2: https://lore.kernel.org/r/20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im
> 
> Thanks!
> 
> Patrick

I've reviewed this series and overall this version looks good to me.
Embedding the awk script in the shell script and changing how the
scripts get executed to address platform related build issues seems
sensable to me.

-Justin
