Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE113AC1
	for <git@vger.kernel.org>; Thu,  8 May 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670838; cv=none; b=V8xLRtzi3K2JLEzOv/dGNPSVHNsSVoLxIkT5hQ9AtgKMvdiz1xTlV0hDhmtexBppAdXxer8JkuTux+5haToDduJGkDQXWvgadbtBm7QKpGK3liWdOX+emfos4+u2svudOph6qzUiIvAjxmITUcTgwmcYA4QMW6+Tdhgj3pDVkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670838; c=relaxed/simple;
	bh=gshFPOEuS+hZ0/uTyRXP395R5i4UJmjSPmqM5R5aBhk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o/wr8kQPzF74jYJvHiwoMqaPC8z3m8lh8IQtJbqsqbjkqEWLGfPuk0SskqC57bOt9JJSAMzd8MZEd+hUMkEOeEknJYLrI6LiCkmZiVChUUvGJh0Ierv81PGh7ctcl0MFwmNIHUbIlIHJfCuEnUhuOUJk72Dzsl14DoPfeyaPcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BwFvbYPw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BwFvbYPw"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4769f3e19a9so3816521cf.0
        for <git@vger.kernel.org>; Wed, 07 May 2025 19:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746670835; x=1747275635; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gshFPOEuS+hZ0/uTyRXP395R5i4UJmjSPmqM5R5aBhk=;
        b=BwFvbYPwBvQw9tPaHAGYd1fP0F2IA3eaooFhJyzi0f2q7zzxiy3pS6tN5dNXnIhpux
         FvuCLziAEBn3PqNURy+1qDo+gwKOSXbUs0Mc9SDN537gZWJJsvsMUK8Vj7QE9316+0hk
         l0JUQG2uNMndusNHj40noWdtEsI35pT95tDMBqJjbAo6DDtPZ789I/aIIYp6QB9EFcOw
         MDiURuCZA5FiiqonNkf88VE4C/r8XsDfOSLbMnVnHWZmlelYTpwgkXmRuptUrgNd0DvA
         TDU6FVqiv+sOcT8VZCX5tLk1h26LUTrnIR+1Big0kRWzbyB/n6cwfcW75cGmnVYp8LQe
         LfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746670835; x=1747275635;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gshFPOEuS+hZ0/uTyRXP395R5i4UJmjSPmqM5R5aBhk=;
        b=i0UB3O1SFJv6m9jLgFynnBQSJFxHkcqrL7ESTeTO7QOwDS5slC38oTG00WrkKnDTtv
         erX+xTDiqcbh0duAAGyHGunABxF5kff7Ko03DgwqeqeGT2MzqPIMIbmW2Y1DhJtFbU2+
         JMnJ666EhcCraJ8P04+HWvm4ZYx4bevFVUPF3WSAyk1ocvAfyHlKj4XcWRoIgQSW0DLK
         SiFMTdn3Cd412FvyjAYPbO2eUrA0lhuUCLN//CkiEIuTZck5JabbW8eP2m37TqLpzlTG
         TaPDamm7BLDpG+/pUh7g1Cfv2+PLi19xXa/Zf+h48XXgVYUHD6nHsBEMgZBz849O34yS
         ua3w==
X-Gm-Message-State: AOJu0Ywqq4jYCUQJ7eyEQpzYO5yaKvG6Tb4K3KXOlzj9+vC8OTG+ZCSD
	JhlZ6dvGKSvkSCVWT5yNRJ5wgFWQ/IbZbvEvaYWPSk1++Mh5FHpNvEELUvP+fPu+zG23TqV1L4A
	v
X-Gm-Gg: ASbGncu/s8vozPg7TyHPe533GtDIjlxVsWxLvI6ceXS55SeO0GEAUmXWOXdGA7+ItpV
	tYF8z/TSphZUgF+Uzp7He2fZaVI/3hZ8OgP0MpvnLD4+qAoMG0Sg6HcWNRbDEs24Uvp5CLG/nAm
	Cuu/QcZ924gjZiKjH2gHkpgTGZd9yJ6Pc3FH51ZRGJoKRfSV/EL9G8YuE++tNvhEBNsVuuPrWDW
	+rP0dBRG9Ym6npV2XqwQb+CXq4j9CFcf7gpJ84AxgVJTQkqq/Y2pebhp+wMQI0YjUKDCZuBcmio
	Q4u2I096J0NJRQVdKL3YZMF/VwX8K4I1Ihavl0y2ggSJTLL7GGHpaPkc3fGIh7xLjrmH7gZhK6v
	37DH30XO+MygWUqez8jNBRZQ=
X-Google-Smtp-Source: AGHT+IFMbvmqJifAg9XdXDERDa2ttVsEpc4r2B7JDMGHYAX/cpRdCsN+T8E8f2TzzcXIbLlfJ+h+TA==
X-Received: by 2002:a05:622a:1996:b0:476:83d6:75ed with SMTP id d75a77b69052e-49449622d1cmr25409651cf.34.1746670834910;
        Wed, 07 May 2025 19:20:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-49220f81ed8sm26005681cf.1.2025.05.07.19.20.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 19:20:34 -0700 (PDT)
Date: Wed, 7 May 2025 22:20:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [ANNOUNCE] Git Merge 2025 CFP deadline extended
Message-ID: <aBwU8UdGx8bnZWdL@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

In [1], the dates and deadlines for Git Merge 2025 were announced, and
the option to attend remotely was added in [2].

The deadline for submitting proposals to speak at Git Merge 2025 was
originally set for May 13, 2025 (which was view-able from the Sessionize
website, but I neglected to mention in my announcement).

**The deadline has been extended to May 20, 2025 at 11:59 PM (UTC-7).**

A couple of notes on why the deadline was extended. The primary reason
is to accommodate folks who weren't planning on attending in-person,
but are now planning on attending remotely. If that's you, this should
give you a little more time on-par with in-person speakers to prepare a
submission.

If that isn't you (and you were planning on speaking), then this gives
folks a little more time to submit if they either haven't gotten around
to it yet, or weren't aware of the deadline in the first place.

If you have any questions about the talk submission process, or about
Git Merge in general, please feel free to reach out to me on- or
off-list. See you at Git Merge!

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Z+L3Mt58n18KUNzs@nand.local/
[2]: https://lore.kernel.org/git/aBKauXrGU8cMVXVI@nand.local/
