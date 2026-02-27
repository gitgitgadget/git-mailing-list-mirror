Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A5271450
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218081; cv=pass; b=KflnOhtw261nwy8hf0c6iHrtz5yTu0ab5nIRo5vzynYdmVA7FjUecgnTG/SLfhIRikeF7it+TNykJ2H43n+WKJjWMlugV6ynSFWB7dGZa1p4qCuTN61ynUdWcH40tJroNvsHkmPiOgvfByVCU6dmdL0i3Mvmtr12866ekpgusvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218081; c=relaxed/simple;
	bh=C05zC8b9vWR7gtMnFt62bEudamZCl6PoAylhOrJE7/Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q7O14hgL/Y5Ed/nGpvMuvvzEY/dQr0JVJGR9Rkn5erFLolXN/vEqdoIcNkZc07m/Dpp0DXBqkPqOqldE+cC8QO/KyXqclAVC+y/7JXpzGNrz7wVlIRL49y+6R7QuuCnALJMdBVnoMRWEMWJg+VXy3ErBjy6O5rZUE4CzxdqrIBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=aquin.app; spf=fail smtp.mailfrom=aquin.app; dkim=pass (2048-bit key) header.d=aquin-app.20230601.gappssmtp.com header.i=@aquin-app.20230601.gappssmtp.com header.b=e/2funEN; arc=pass smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=aquin.app
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=aquin.app
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aquin-app.20230601.gappssmtp.com header.i=@aquin-app.20230601.gappssmtp.com header.b="e/2funEN"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-794719afcd4so22843367b3.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 10:47:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772218079; cv=none;
        d=google.com; s=arc-20240605;
        b=S8MOMnHoId/IZNxiUwCixebhDEiyJ/23liWWaDbOQXUcTCU/9XnH6UHyy8t5vxnerF
         DIP1jF6vH8skYzfrhHwm5TuKmByncgZ2juH+Tw9sejUm21DtNZH2FFTgun20tQDTmOpc
         tYbEi7qx1JUOzVnc6zkpGO+vv82TmSkff1pTyuvNQngH47Rdm7QrRwykZ9qrHGK/eQW8
         EtxZTfBNPMdfrW5dA2I9DPo9hYpSiHyhbqvn0ehpB6RyapVgKg+MuwOWkwmmzaVMosnH
         Dh0bfu5V5uNTNL+5rtonRyzFKLJTppAQsB+5iiC8ZLfP2irZXFfZp/z24hUD1CmJswgV
         ckdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=C05zC8b9vWR7gtMnFt62bEudamZCl6PoAylhOrJE7/Y=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=EaU8rHn/1Pkj7uhO0e/rxhY0ZFw5aoa3fxHtnAENUIDmoe0Kw78V9MAy0mOiJ9O/Ow
         I3rDPwZ/jbt1KIxeSeIglpmyEyNqmCDZDseWs5qyG20sOd7OzfW3jgP57OAoE6wTZELq
         l8TpCrXAWbp/GvGZHNToxXt03wnZ+DSo+Ts29Ks71ZoG4YpY74wghAyu4ec8tcYr21qL
         EaL+1ovsb3raAWL+vXrKXbdNRIw8UpGwPB2B0jxJleizvKdkxjMSGxwek4j23Uo+9mUE
         yYq9RZM2hVvBEHWwdOxu28uLj9YBS9J6qgxkyDQLpTa/qqVSEoKfTpBU8vdTlKs7gNQd
         eKTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aquin-app.20230601.gappssmtp.com; s=20230601; t=1772218079; x=1772822879; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C05zC8b9vWR7gtMnFt62bEudamZCl6PoAylhOrJE7/Y=;
        b=e/2funEN5Uj/IeAT1t7QVriI1Frdy2CAfK4YP44nS3wjdJYzKjOeGh1rVuldV6UUEY
         C4LnWRhJyTFpG/hlohHtViFlJNUrEd0C9F/hLBCMshB/q2HPEVy/7pSzjsymeTol0UDO
         OjRgDdwt2UmCcm0EApb6Ykil7sz5Efs8Vv6No4aADvJXYoP5EmXCDugZbo62UX9FUHx+
         5mQ7druP1bEoLLVdbafa+1IpvxY5tDVSBwJxgacGPcaZezkh7/BKyIazExnaFhrDege+
         RgjjNNK2TdM1IZ7y0PzTdr+dQ3QjxGGAT7DzWyBInEMO8MS2xnfUZ5ZeoJagNvvTmdhy
         DG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772218079; x=1772822879;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C05zC8b9vWR7gtMnFt62bEudamZCl6PoAylhOrJE7/Y=;
        b=g5Vh8uRhqFGcUgUmp0ET8KSVbBB3OcnXlE0RvyAnuauRCk/wSBa2axMUZKyUZO6ahf
         FayOBIkD+C1xX9AtaaVbBNh/xYE9/INyhRsmTll6B7Ib1YSOYRohXFC9BYUw0EB8OsWT
         w5nyf8VcDWwNStQ3293V9ejE5wiQlISnyEwuQok7XufAVJvmdNa8RRzBykDNTZMpAryq
         a4QzQHrf5/qxIKIjFY3Jk3GWOQgmNYo83uwU6fEqbfhHThiCOHr0MzIR7F4qo5xlXejT
         wY+jLyAx9a9BDrcJh50DScyI22FtqkduvWSn8ZfAYC8eVfLTawWJ2T5Bye4TiICPalJe
         Bq6Q==
X-Gm-Message-State: AOJu0YzCSI/3NvqIliASraIX8NqlfyM/ljMfahNAsPlPD8Fbk6iLEJkd
	U9bjVOoXEKmWIPsae41WO4u8DTsSpT+5cEX8IzJ9mv8VDYVGRawkrO7/5+Ak+E03eHBfCxZFMmL
	QVlTkKvdQo7FXMTn8MoUCzXBImpcMwAZK1tNpMAVbflB9/bEYGveuve1w/g==
X-Gm-Gg: ATEYQzzXOR1ck+PKjYJEVlC7kIAdtOYsyTxfXEGRtmJX5ypT18S4NS2D5ZAdBQBSDlo
	JWfbBgjux0TdJtw5716LJujQcQPdcN56JhRDWKZ0qSpT3RpqAS3PpN0ajZYsVbqYeCK3pH9a4rT
	b4ILCERaudTAOEWl3Nwyq9xRzAzji3AIoVz3V7STIZ87xhC6INKhPaaRosuqfKN2Ej36cDQGoy2
	duDgEuf9s7JNHKeEvGlp6MOQ71qYv6aKEPo4Y42utW+t3gKi1LDpdOwBA4YBLJHN1kSMcVUu3Ek
	1rBipLb9yFuElvUx5xKPpqJt9L4OoQzY5pLe/KxN/nc88rFbOk4w7WIoXFsjlGObA7lwHQeGOVG
	aZfg=
X-Received: by 2002:a05:690c:a8e:b0:798:6400:c876 with SMTP id
 00721157ae682-798855ded0emr37035877b3.51.1772218078738; Fri, 27 Feb 2026
 10:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Pcannon <paul@aquin.app>
Date: Fri, 27 Feb 2026 19:47:46 +0100
X-Gm-Features: AaiRm504EhGzUYe2BlFfrICz0bd1_gDhIAMLe3oeBFmg0u4bbNHHltUZqgqoUwI
Message-ID: <CAM0YaAWxhRv=naQ1S1bkzBY=-ACi6ZLv1sY+ejEd-SxzfE_rqw@mail.gmail.com>
Subject: 16yo working on git patch instead of studying
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

I'm a high school student who builds open-source CLI tools and APIs.

I've run my own Git server for a while, and I've always felt Git
prioritizes correctness over UX simplicity.

I've been working on improving that, is this a problem worth solving?

Best regards,
Paul Cannon
