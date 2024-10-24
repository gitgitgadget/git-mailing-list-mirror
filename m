Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8E1E51D
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 04:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729743508; cv=none; b=Rn+ByYPtTp6gwIBr1zGEs8bQGwPF1giMSSX/lYU8xbq4vTAWgcyaXNeBlhekBEzB7AEPCk6ShAk4CdJKnFAh0sRcAdhlZE9odVIeZ9A9udlmRMkr0d6QT7PVriTGw4Evy97tWGxQrj33G1VIZNQrzpkgJXEau9AiSwLk/YhGXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729743508; c=relaxed/simple;
	bh=SaLs9gdj9Lby3TeOM8R9ZZd+Juwk4c6+JFWEmi4hWBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIj8vJag6B0vZXFhIi36O9z3mz3oewyilr7lXzWcVKW/EiSBvt9llkihhhBpLKhcgZLelp6xjj1TePowHa7YqOQQBf4lSRZx5muZTja9c2caAhJY1yOQ2lt3hx8oEkDZ89iHkQPF2vZ4rdVee5w0702Vk/zXDgILjite0dUMlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbdd42bdf3so985226d6.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 21:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729743504; x=1730348304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaLs9gdj9Lby3TeOM8R9ZZd+Juwk4c6+JFWEmi4hWBA=;
        b=JtyViVPlAoelUcd760VE4N5Dset3qW2H/d0vlmH+I7/8ABtHGFPSuiH1RJaJ2n4E6s
         IICegFruvFVknmpgbeN+mXow7UHfPVmcQ3kbVZRrAVB72QFkfsqF24cahO1SFHUmLSTG
         gmpbRMqvHbqRMrcjVAt3jIm4TD/OSb3hbi8t4oi1jWdgELFHUycbTxsNHHrSjnVbsWSf
         K6dpYpxrGjkDc3I1cQNMQcqnw4LxEkTIGR7KDVCImQOh2g0DVjk9zcL6V1HFSewtlm1f
         2ijm7Tl7dfZvExIKkkmvHJuZ2fHxAHxk9fbiShPLNXaYzLoywplwZqicVBbo5iJdzbXO
         ADLQ==
X-Gm-Message-State: AOJu0YxXF4mu3R4M12t/1oeCQf6DcTMqginwwAgci19ltmubcQShTJS9
	RVmBTtjx2qASXjjpbTHNJqmFUeHcHTatvu9CtTqF6p18MfJSQXr1uINm68LTXxf03GhwGDLsK46
	NWY6D5nMqG3avvkjjeLWCaANPjO0=
X-Google-Smtp-Source: AGHT+IFNHFRtC/F9S8dN8OfkhpPiWcq3CMUNKQvUse9mkLh7ZiWeuEw39Lfgk9FwOHFMb+Uc0Z+h9yYTSPM+FYnFLn4=
X-Received: by 2002:a05:6214:ccc:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6ce3413a69fmr30619716d6.1.1729743504582; Wed, 23 Oct 2024
 21:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729677003.git.ps@pks.im> <036cc8f9d602a817aa579092bdeaef5d1156214e.1729677003.git.ps@pks.im>
In-Reply-To: <036cc8f9d602a817aa579092bdeaef5d1156214e.1729677003.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 24 Oct 2024 00:18:13 -0400
Message-ID: <CAPig+cQH+Y47KdpjztSMkJOSHxZ3ZNXBWQutEQCfPO348FQr6g@mail.gmail.com>
Subject: Re: [PATCH 1/7] reftable/system: move "dir.h" to its only user
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> We still include "dir.h" in "reftable/system.h" evne though it is not
> used by anything but by a single unit test. Move it over into that unit
> test so that we don't accidentally use any functionality provided by it
> in the reftable codebase.

s/evne/even/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
