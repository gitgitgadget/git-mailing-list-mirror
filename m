Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFF2367D3
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768802353; cv=pass; b=tJ5CoRaQS1YAMAmNOaeiuBkUhbsKkRMxdRudCV7nvMP2Q+WwD0IbPrtUcffDgWmSc4hIHxrv0EUYpMAtIbX4525HbPlf4C1EKHccd67Y5NzuAUJk8bozz046mVhgEy6RgG33H+wA4BbCV3Tgfd2HmHQTj/T4FTphMO0ARGPZ3HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768802353; c=relaxed/simple;
	bh=6r9kPJ4I4B5eLwaWdGKWgllMQ5OALYdYxiiQXOJjUEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihhu8sj3Z1RLpPOxI8tndGxhVEoLQasl/GkhvMoSYmySFFbks6HQAzGkm8eZxPCDMSgiSiHu6cpMelGlxNwjIpMkGCJORqD6+M7hg/L3hZ3EXs4AENgl0/1ah3egxSyizfVJ71a6T8jnxjA/7hXBVZSlkMGrcRNgzcNtRJ9sTgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+ctvjY2; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+ctvjY2"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so4227357e87.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 21:59:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768802350; cv=none;
        d=google.com; s=arc-20240605;
        b=hdpJmJEU//r8qH8cMFfGMAIyo0t8t5BSlRYK8lCmVc8R+YivrVOpsHhQiUeXTZDJTI
         /hNzcVH63230emvQZkbeAuWjqKYVJiHJ9/AfnFEnxd/MpxVlA3nbrN0lb4o1j4LiGup7
         hLUjyNC4b6UiAzZQb7uW9K6YmgsY++U9fhOxY48CIR/Ldi6VQj5gIr9CNMyeedyirCvT
         R2BmEMqgm08ikg7XbFhnoTti1UmKsKKYfSfHqeQtDNXcCC7jij52L2ySQXBqub2WBBtB
         DlB8cTZr9EBnhHt7UBDub5R57nP1GoJFUBUrUmqph4C/5e36gvcEJJ7D/kvzkO1fNZWR
         V1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6r9kPJ4I4B5eLwaWdGKWgllMQ5OALYdYxiiQXOJjUEk=;
        fh=K+HPDxeGk1gynixEKaRM6v4+kELjAY29q3Nz/U9NL50=;
        b=XAZXVrgxAlFVQWXs/pH8fWmadwJdNj+Eo9O96P2jnp5LzNfW/B+Nz5O7GdS12pt44L
         +Wxxs30aq2FTC/trqpxx3qK2KEbbzyJ8nD2SzQIJ3dZsGS+JyA2Yt2x2z2TYdfRn/4bn
         0Rqnbok+qggKQaHqbO6HGu3B3cjji/vQzQZjRvL+gS4zePAOifKTJAxZA9tpeuFaUhLp
         D7ZHu/9INxFvKkRq8cd7WN/IbUcNpFxkeVKhsjE6A8A2gZOGsPS4pbqEZD9cmQMsQdDO
         tpVkvU2Ja/2ZOX8Lz51oyD9WdAGcZRxr1by+U4y7GM7fN+iaEglubUYpN4ORJonbrp3D
         uskQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768802350; x=1769407150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r9kPJ4I4B5eLwaWdGKWgllMQ5OALYdYxiiQXOJjUEk=;
        b=R+ctvjY2vzbu34UNhHiIeq6i1jNdCmLMOOzaKXZR5BjrOjoz64axj9+DGCxjN+ZJsw
         e2CJp1uaHTeAmSibuMxGfm6XhTftOQOBbmIe1y4QtpWJunFtCdhgp9lht2figCmCW9Pm
         qRyXW6d12OmVKSugXq+zTCmJOgVOV5t6YDkSHde9Xas4NGPo9hFVczOJ5Dsr18Klh73A
         Wndsf0HQkKkmE5TNqffr+fAWQgdTH+0Ee7XWllQhPb1PaBAbDKLqCYy6KImgmqxD+lJC
         sa5TLSb33pCf5hJ3cE0t9WAv74zuIL9Ud20OhDB2wIrTq7zHdWh7iCCH7QBLlZ/hEG99
         hAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768802350; x=1769407150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6r9kPJ4I4B5eLwaWdGKWgllMQ5OALYdYxiiQXOJjUEk=;
        b=ELLag3S8jMlhPUd1afSidURsu2+xsZ0+5YgEyvdN70aQo5QcpadPOzbkoyqJPy/rIz
         2x5msaWs8J6Zx4ZNLf/y2H8E8oAy6fZHaeCeLSXDzjh7t7Qe+yWOupGbXOHsHE/2ksQK
         rLCIKTBBCG+aBTgDUaYXq5k+Lbzev7auzTGrBG9w5P9VU5YJ8LcW9gtTqqaYsrJ7nmL5
         gzTDiuSV+YONOhL3RGqukP8IobeMHXn7rxeV/KwTQEp8nAP9CQs7yUH+eEwKtY95N1CL
         ix6X01g04CamYqmro9fp6DDwBjBiYCXOADMcEeNUBkq+c9P/WApsZRJ51jSK6iIcTk46
         DkSw==
X-Forwarded-Encrypted: i=1; AJvYcCUdMs1q1XYm3RBEOqtkayhmg+UJpqbUNpNRbVmeMcGSdmX9jK3cRpkgfMTBwbxFz/+ujEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+1omMp8uSW+5YUN0jIsO4WxCN7jZwSRJkY+rHzYBwTAc9d2x
	DOlQjFLLns/leLqVQSdoJWO2fReZe8dzelSbVTxVbvszoOSE7XKflH9NVLy2DAeXctdT9Fc/m4b
	tjWvWbkb17isGYwLSaLpq9wlT/pokmHfpDA==
X-Gm-Gg: AY/fxX44gnU9VK7uqLZCVuXmUyd5j7p9bB4pDWyHfNyoyFB+JQ328gJVwl9GG+UNm+5
	Igxukw/sM8I0uld6YJAgDwKW6dqUDMtuBtCXcfSxaWDP/33CAhhSDRGO7Ds/ikHvxKEsyxxZmfH
	9HH8+OlbFoJURUvxo5xJiTs0hEdXpmCq582LD/2TwszT/PiGhIJMlZYgsqpoY7di/NG7qZCmKNB
	Fbwb1v5h7WHWGZPoY3M44GT0I8Uya/Bx3vYo2KOg6lg+nWIGqK5mSTtGmBaqjVr8Xs/dWfO
X-Received: by 2002:a05:6512:10d6:b0:59d:4a12:5f9 with SMTP id
 2adb3069b0e04-59d4a1206famr110332e87.3.1768802349685; Sun, 18 Jan 2026
 21:59:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114211013.GB1008851@coredump.intra.peff.net> <56D0BADB-43C8-4E93-A871-6E6B11B59DCF@gmail.com>
In-Reply-To: <56D0BADB-43C8-4E93-A871-6E6B11B59DCF@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Sun, 18 Jan 2026 21:58:58 -0800
X-Gm-Features: AZwV_QglCixPaKbraXz56bYWkIu5BntqFtMGlKkYH8r9YV0915JwfD2goHjpsgw
Message-ID: <CAPx1Gvdpyfcioot5V9Q8=Yg-aPSPeVKaE4Z2_Xt3-SZ2WhVMog@mail.gmail.com>
Subject: Re: Triangular workflow
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(I'm somewhat behind all week so this is from Wednesday...)

Re: status.compareBranch (or similar): I like the idea; I'm not sure what s=
ort
of details might be needed in the end though.

On Wed, Jan 14, 2026 at 1:42=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
> I favor something similar to what Junio described but also including @{pu=
sh} by default (and ignoring it if non-existent), so that folks discovering=
 triangular workflows for the first time are easily able to see what is hap=
pening.

This also seems to me likely to be the right default. It's useful for a lot=
 of
GitHub and similar forges, where you send fixes upstream by first forking
some official repository and then cloning your fork (e.g., to a laptop), se=
tting
up your local clone (on laptop) to have two remotes: the official repositor=
y,
and your fork, both on the same forge.

It's a little annoying to have to deal with *three* potential
"upstream" repos, if
you need to back up your local work to a corporate server or forge *plus*
a push-for-pull-request at the forge as well, of course. But then at least =
the
"compare with all three" option becomes available. How you wish to spell
the default push location is then up to you :-)

Chris
