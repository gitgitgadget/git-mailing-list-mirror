Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4574C74
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744659657; cv=none; b=puw85cZHE7VWLFqAe08EUCkNypVuGtPtKotNuM3R4IzGyVRYNG2kftN/nr3ZouLP6u9ActBOzJtY4S4Xgx/hpha9uGPK36SUI57w82yG273r42eJyISHb3HkL1J8el+Ygsqvb75mZv6MT7bcDUglhZBfgTr6AfToIT7wXUI+1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744659657; c=relaxed/simple;
	bh=5bvpnmxIAtmmd6154obtvG2t/hXqp3Zb6yBDLlQAXE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rMy/tGokJUq4MX1qh6H6T5akJhe+7+toiLnX1PqXKWDbiQtnHSRYuNEf23euBXVFTWVfmuvuJ7LZa8P/+7Hx31xXqzrsh/M5JoxjVnFzostaKcieE+lwjbOEwtIwXfBXEXjs37Qk4seyD5JmPHtOlWRQWXHOQda2igWcK3BT+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVRj4o2s; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVRj4o2s"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso922664166b.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744659653; x=1745264453; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bvpnmxIAtmmd6154obtvG2t/hXqp3Zb6yBDLlQAXE8=;
        b=fVRj4o2sJIlr6y4ckg62mHbkFuAQf7an5pNWGybZiBAsWym+PJvt0CbgkmYtuhPbyt
         aOqkVmNE1K4tMIO69eW01peuCZ8BirrSaDw0bwlJTPUo5/4rht+9NzP3hkX8qMp6ResE
         J71uyKWLKXOtYzRwDTavJtPVadx52ma7OdR0yLiW47O3EtcBTp44mGQqQSgsbKOHM3NO
         R51Olx61nlmTa9+AkUPkbMz6bIOuaYP+Jo/gJ3605W8JqnzP1AEurAgEFBneXLC/zHoT
         Q+w/QNBwBIwbmL3N/4+DmRutFvjC7z/Nz2eS7hYJX/Ffzu5ao4R54OL7y/1FZcjrCjVw
         /v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744659653; x=1745264453;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bvpnmxIAtmmd6154obtvG2t/hXqp3Zb6yBDLlQAXE8=;
        b=ncYGbyHTXuAo87BaxTqp05eizugJsdpATf+w17mHk3s1pgV34KhrdeGYPIdTKByPxn
         X8V+n/ujMQc/do7rwWv3e0C3x3J96EZqwD4/UH/FUrEQmLfJLnkmKe9y17PWPMEXQM0v
         A62+CrdygFmZyxqOO8Vj6UoY1W/1mNDPYyw18QfmiQ7loHnvKnDxTRLZgMKDIyw3R32y
         yTLSNDf9vWEmieTIcXWBMEEVLK5uR6BVQfaTRz9mPLVSEINILbFavWbpk5HKbphPyhQW
         NQIRWljJL0NmycHWWNHn+kywZQ5OmKS1K7EFZJMFQHFzZPRlczGd8Kc4Xqg1VbdLalPi
         HtNw==
X-Gm-Message-State: AOJu0YwFCq5pzf+8kK/1XeSE54u8/uZ13b35CEM+bejfFqo6QE7Lp/e2
	mfWEn0IILBA717PQfQLBpHX6Izg7zlIxUuT8nEkMVFlclLS2/cVMC+gkqyFtfKNWUH6r1g6Vo68
	XHZbt9dxg9gTIlRCByd4IiWQlYq5FtRXo
X-Gm-Gg: ASbGncvJraTCTkMgSOGCcNhapubNAYGJoOAKUS8f8GteM2IOFyDqj0XLGiIuZRd6XDi
	mLrsMikHJcsxRkkQwvdKAfcySdrW3k8tMFZ6oeBgcKfcz/wgRGiK3wTUmDqbJefviNImcDiE1sh
	EN8FYpb/ulGXq3oec06xlsF8K6ItHw6kWYHh+waEFIokG4WEgTC58EIqU=
X-Google-Smtp-Source: AGHT+IHkOn9nSzWS2vgT4bM0FVIxHQ9eV8/KpxYjmUPeT7EUgOUlSuT0OR6i+XywiTOAD14lXSlq841D5GkNMvkidTs=
X-Received: by 2002:a17:907:3f95:b0:ac2:49de:45c1 with SMTP id
 a640c23a62f3a-acad36d8a01mr1009612266b.50.1744659653133; Mon, 14 Apr 2025
 12:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2afd91ca-13d8-4b40-aa8b-c1917f0882df@frank.fyi>
 <CALnO6CCUHE6-RcZkTBYT-CeXHnYPBPe1eGSogWd7=5tK5NyuxA@mail.gmail.com>
 <669a6a0f-bcfb-4596-a0c8-73c722a6ec10@frank.fyi> <CALnO6CALCFLWSs9HBWX13V_BUZkoeZuVjHVnF4_e0OMy3LfEjw@mail.gmail.com>
 <351a6036-3bac-43f4-88b0-cd52240312cd@frank.fyi>
In-Reply-To: <351a6036-3bac-43f4-88b0-cd52240312cd@frank.fyi>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 14 Apr 2025 15:40:41 -0400
X-Gm-Features: ATxdqUHw-p--cpt2HZEP9qpAJ6D9-eNQXaFfsGLHGl_rbPmMICHrV9hQch7rQSQ
Message-ID: <CALnO6CCsyF0w6jP+Xk+qQZCW-r_004b5_80XzsPLH2n7fnogsg@mail.gmail.com>
Subject: Re: Way to "impersonate" remote or sync remotes without fetching everything?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:44=E2=80=AFAM Klaus Frank <vger.kernel.org@frank=
.fyi> wrote:
>
> On 2025-04-13 23:52:14, D. Ben Knoble wrote:
> > That all makes sense, except: why need the sync (cron) job? Treat a
> > local copy as authoritative for you and push to all your remotes. This
> > puts you in control at the cost of not happening automatically. (You
> > could conceivably have a local cron job that did this.)
>
> Cause I don't want to have it locally on e.g. a notebook that can break
> mainly :D
> (I know myself I won't be making enough backups if that is their primary
> location)

If you push to other remotes (or cron, as below), then you'll have
"backups for free"?

>
> But I have been thinking about something similar earlier today. Maybe I
> should just
> trash my software forge (gitlab) and just use git from the cli via ssh.
> Then writing a cron job to do the syncing would also be easier as I'd hav=
e
> a local copy to work with
[=E2=80=A6]

--=20
D. Ben Knoble
