Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20830BBAC
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155153; cv=pass; b=ASeP4rBWdW/Mh5M30oc45DSh166+CowMzKd15fGFSjqzq8Mf2u4wz8lamg5VCCpSfpDnIJVisP3bY6pbpaPYLy/j5VZyzcosGb1QMgQc1P4iukAg9mYSo/pw3tsc2XcX+J9SpgziQqmA37wlBTb+eDX4EZ0VcaNJpndbLQb7Z4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155153; c=relaxed/simple;
	bh=rE0OZb0Qsu+RZvKqe9l4BT4PD/MNwPaj4YWK50952OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOMp8DSsZCBDIVJsEa9Mp0EZ1LhphYwjTlmHei+jU1iT1QWYjajtqvWHfNNcNGazdUOkB5hfd8ADveM2UqnTzuDoY6X2HE4dUvmU/ESw4ivecY0jHzwdp2WZJCjd9QH6xtvCYA45DTjadULXE7TXcVcgSTJjiRjB78b0AyWKvWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaytZxg/; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaytZxg/"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ca423ad53so11788778d50.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773155152; cv=none;
        d=google.com; s=arc-20240605;
        b=chtNsW2cxOpgiIq8K+r4lLeir8u1Eaa3I7bQZEsPwK87owlHhJY+cshqHRLk+yUXLS
         kdSo/wkeOEp9MU/2kN63B5SP0DDeeTioFL3f61kMkBQZXOaxzxNChEZj/GE9E0A1Pobw
         vv3qZQ4a3CDWItqRIx2qLrnkrhOA+0xQqWMC2gCY5a3llrwcijlmoSk7bzjR0p36WVbS
         kxPCCCb5ZuMBIdk+erySB/usoMq195+rsWp8uSSvBaM/OQ6YUWIljE1whrkWrJwjwOnG
         Sp5j4yyp61BOnjImrOcwPWeietOlimpetig3ovsCyKD+Z7OYv+QbZ2WYmPqvBg5IUmfN
         hLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jYcdb2uY3zLlLrl5huciRchyKWGUeoUwMdpUen0LTvk=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=jaswEWodrr8nwSaoHq0bhCrrPZcfER2qirjZuIkZeNSZoUo+JJ9yO19ut3lGO6V/Au
         i+q9PRf7S3ucPsPBzoBy3QZFCC1XWWIynp831J0aEhqudWNvdrC0jttDeLpw8Y6w5ZuQ
         Q7RDAgFvF9kUpGYhMcCxO482wUEU7Hl6Xbs0wVhaZRC9F/Dc7F6jjlh7oeEpEFBy3SZa
         AGeRPQtdA2RC2bi8Rl6GGfnq7yAVJ8ypeMj00eFghlhIKCSkujwJAkTCLj0rSSylu3WB
         5b1RJwfy9S/rdnEBYMQZ9GBKpSSHmVerb+8X3fJlmIH6oZDwFynTtDZAWetj4k9VNdIH
         E8Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773155152; x=1773759952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jYcdb2uY3zLlLrl5huciRchyKWGUeoUwMdpUen0LTvk=;
        b=IaytZxg/H/RtfXamlcjP7xThKVpOphOaUvz+X6whcDm9imbCGLvxSu22zMIpl7kAhG
         e3V+AtN0rc1vUqkSpfPMGhvXPyaTr5ofFhE5ox3cPLQCgTHaT+pf3ZSc+0NLkZT8Q6kb
         MFW+bkyjbFU/2lIlCbJ8TvKWoIe6QEk95D8q3HqWkbEosRod51FqFx5L4PvSmY15havc
         xSfdas/PDxlu/kpnj17JgDOV7Y3fGDo4kd1rFAPIIVoXbq+4JIqsJDTTPMsrvepL1M7d
         VagHA1uSdBtH1MoqsYlYVtYG3e8R4JDjCFz/j3ZfMzNxq/yAFlzgGRB7CUug4z241z+R
         9x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155152; x=1773759952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYcdb2uY3zLlLrl5huciRchyKWGUeoUwMdpUen0LTvk=;
        b=GoyPkENRW9+KlklW/VY4dXoCg9nbiL8Xn8lu4epy/V2kuHrttVI+CZg4Ot1OGJg88o
         dKTdIU0cZVrWR7hgTQfsmXiJEyTXpGN27wx7NjrSZWtPS83KEVlr6SEoBbyKtMN0UY1d
         lmPzdV/uxDcmhwaaCbYM61aaGTgCyJ4hldExe3iZUbvWdcz2Jn8JUDFQTuLdH2aHo4ke
         XMc3DVgfzVKUZ9Sgnxrcg9UCibnLMMfnyMVzNzbVL7/qg2bFWvIH1Ak1iGbvaulPVRLR
         NiMP2EEtoIrCyeSup+l8/Mf5pFMElPRPkt9QupdBLYuksvZoHNH1zAnLEl+a/yjNhDpZ
         5vPQ==
X-Gm-Message-State: AOJu0YycC1sYtJxI6XBPfrrsvf2b0WvotudxkPvUWBuZNbXpDPRAYp3Q
	fowMuw8LdcTvEuiXyivC0q6zON5ObYt6zYz8T6rVT2QcdDcThnWSHowA2rdYhyMtbhcERYweWBy
	SK0Wlc1MPtNr+FKJCjV7wTvz0vv5WMxI=
X-Gm-Gg: ATEYQzzpK0CQ5vgL9KaTsmriNTp2JPjCvNNHCTZcc+uLMZIU777pFeJGyqNRUQfvdPw
	8tbQp66bWKnvjK5J2olKept7yPeW8jHe0YJRGHP36m1skKlfFIDWZJK3Wp58MACxc+Kj9HaDmDy
	OIUCZVN7g9f1pmFEO4cwY4w23Ce7Ybi/KtHUNw/0m3mWwka7JNLjNnpLOeshnqhtTudwE+p4+BI
	ZOEDLvYao6KO+LzqpIgXjCe+z4wVROZXgzFPk7UvZWu021JwiF3qKM9OlK200DQyJznw5uk17xG
	3CLc5HNZ1zD1urxd/ACqMQXTKzdTxS1GRqgZr/hI2TDwvyBq6CGvvnlMmropWzpwibUd2k03KIk
	jf56DtqbvD/FzC4tTYDV2RkQ=
X-Received: by 2002:a05:690e:1482:b0:64c:f90c:740b with SMTP id
 956f58d0204a3-64d1406595amr14628194d50.18.1773155150061; Tue, 10 Mar 2026
 08:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310041929.1687483-1-pabloosabaterr@gmail.com> <xmqqo6kwxp17.fsf@gitster.g>
In-Reply-To: <xmqqo6kwxp17.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Tue, 10 Mar 2026 16:05:35 +0100
X-Gm-Features: AaiRm50u5bYlS80UabAyo_S7sjoDvnoT8nUjqT-MqaOiZKIu3MTDnkJUaqZTmjA
Message-ID: <CAN5EUNRmXQZGj-3AxrdCmuxNwPfr3gBQkNMsvvjSgC2sZYFeZg@mail.gmail.com>
Subject: Re: [GSoC PATCH] format-patch: write numbered list in cover letter
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> How does this compare with
>
>   https://lore.kernel.org/git/cover.1772839973.git.mroik@delayed.space/
>
> I wonder.

I'm sorry, seems I didn't double check that it wasn't already started
by someone.
And my version is way below Mirko, I'll search for another place to help

Pablo
