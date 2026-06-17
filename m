Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D22DB788
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723517; cv=pass; b=bD0yo7jhsegqhvB+YO9fOGTO3UvC1wTMXL6yw54P8aq3TTXqizdT032u9KaRrIYZ4I4xWU0XF+IQm1GnqC+VQ+Q2oDffpIJICKfx8X6SeCpNOKWStdR2+1zZIbp2TdvV29Gzyg5lPo+I7LhMnuTezz4kSW1GKTgGu0SytyQ1eb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723517; c=relaxed/simple;
	bh=IYnVYWJdXGKbORrdfTEB4Zg6TkeJB1HhkvW/E0z0dYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAfDNLW83TzOH9Kjwv5aDLgV0TWriiq4rgp+h1yxvobKw7VReFBeDPHwG6pFvQcsvgbvXxmHLXEc16LL1LKuBLnKGpFSoPmJmdpfVOZZKS4wb+4gRQONGnGVDQTwTGx0V79ufGAgM2a/uEl+VDpzBu7BO4dNVCm3E5O74R/anQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnGd6PzN; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnGd6PzN"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so46241a12.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 12:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781723514; cv=none;
        d=google.com; s=arc-20240605;
        b=JvSv0dmrkbGMmrHvmN3tOyubOT+MXzq/tywUEWnGPd0yLUnnguQvjUob0wLXoveVru
         CzxZotnsSqdTWwcJvpHi0x2ryw83zN25qrFpZkewpfBs0Ku+PQ3hb+XVe/X2+sAlj9yl
         PtQnrutyM84qCiOqbt7X3i391gu1uxZm4OgLNLHmAxoA1iPoLYXtVwtUL5n+8UDZir51
         RxVcagmFhESyQivzrGKnTYEt+AVFsfGIDy9KG9JN5PiiigP82KIyEdanRu2+yMeF32hM
         L90mrquJ+rXePXtoV8ZsQad7DDog+ziJhpMg/HraJSpYC00qz490U2c848CSsR0czD2i
         W5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IYnVYWJdXGKbORrdfTEB4Zg6TkeJB1HhkvW/E0z0dYA=;
        fh=zUHYrQmrnTIvGR3EP/ZGpJyRQ6ZjiNoFKfUdXDhw9og=;
        b=H6whbubC/dnDQt85DtIxTqiEaA3AMt8VddYqKIvImAcCFirCCpO12QQabBwpaG3yLT
         ERkr8WMeQbyw5e1L4h60r+5I1AvmtJFDYNJtt5zvLAIgdEnQSiay0tVLT0Hp7EKIrdqd
         Sgxxe641XuPUk/MRhSPjzfcP43asqhaDw2kdiXXBH4sILyHhdLc9CD1uCOg3pXz8ipKI
         Mtfny9TQo/HlE/7kPTbGKQ1zoAoAYKlhT/zvW09HeHEw87N0sPgw5mjFiYLNbuP3xu3W
         8Xjy4t3Qa6NCsRB9Qoc8kSIto6dALxIX0lf4HEOEg2HL87dXzjB7hqbHfZPZuJzfsHBP
         aY9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781723514; x=1782328314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYnVYWJdXGKbORrdfTEB4Zg6TkeJB1HhkvW/E0z0dYA=;
        b=YnGd6PzNxfDsQqRR8xF2tEQBwQHv0TcKdmZBwv4nd8J+juqZSBrGNNv2Go+q4b1HVc
         fEcCSm775UZo0k3PrIAh+BN7zy8MHpfqHJuEnyl9rLGQqRjElU/wxIPQSrlehRa2inyz
         KTMRK3JAWeg/xfE6PSteey6W7qIRloSgncK4ReKcbmA1/aPwsaur2g9vNwbHZyhPak8M
         Wqzrc+gGGtKv+ppI+VDDii9a+Yb2fYZrS7Q+t0jbtyTLq8TPULZ56uRi4PAvXQmOrig3
         WF7q5qiCZ1eDvDwK1lvW7UETNa3mxWzzCBoOV2OZ2BUQpKBPwnZPCeBCszlMB0YWh32f
         RviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781723514; x=1782328314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYnVYWJdXGKbORrdfTEB4Zg6TkeJB1HhkvW/E0z0dYA=;
        b=BGDuz7MGSFMu/sFXrnGIs21JBHfRE0Cwc+9fiKQnRxZVWFkPHS0x5vmuh3kHOh/+bz
         AigbtbaJ4bDBLPrGFcMe3Iil9NwAzXLilGLzBjqDZ81jvhROHiLplmUYA1kLn5pK05rZ
         WheRCWE6CC7/pr5OpHTfLpbJM4CDlpUTT5gy9TInherztugPCfShhxcWOCU6c9xbRBTr
         JINhkqUEyaNTBQVye44nlS+HZMO2+744l1NQsqYVfzPPRHFAVYxn8qC0teSPcDCdc6El
         U9AWghlvc2dP8H+unArc0ThkMz6IuEuSbW/fOQz09PG01nvObzM4JQQRg9tEwphHyhx4
         PFHA==
X-Forwarded-Encrypted: i=1; AFNElJ+qlGVywMuMopCJwlpBE5tbrDh6m5aShO/o+pYDWgeYAFz7LsXh80nNLtY8oUX/sTf8yzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kKmLr4BD2VUirUYZTWb5qfi/vcI81kCeU28aOChJ78oWjyr5
	p3Gp3HWYQ6TovzCEJOHE4Tl/I3UdKATg+J+LQ0rAJAR+8AgvrVyTSJcIZwselL3NPXUBs++hLuf
	bDc7TS93RRMLgi1Pkovn0dMI8qurqyxo=
X-Gm-Gg: AfdE7cn4+DLyStP/FK3ZlbGVG/0fL6fElu6OXdcnSWudmaAT/AY4+v4cxHjGgYSSz5n
	RrmBnsJlLa8aZTLIxk1uXZvid5vfulgxGhQnzX9sqYgpG/Ba8+8uhi/BCDpdBSFouQ832OoYhZ8
	TDPNmHm23aF66KYHMg7MhRZART5PmWfIMPQQ7QqtOA08F5XR3ClFzzZg5bghecfY+I3eD44BxLf
	0sjWKIxfBMAyCQ28KWZSFshXufdKGpJYykKgL+gIE9c/JsnG1tOgVdsnwvbiSs1Z4qTwCZK
X-Received: by 2002:a05:6402:548d:b0:691:acfc:54bf with SMTP id
 4fb4d7f45d1cf-69547492d3emr2815462a12.21.1781723514401; Wed, 17 Jun 2026
 12:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com> <f68e2a11-02a5-47b9-a01a-458eba821c37@gmail.com>
 <CAHwyqnXRo=P5Zihs6s7Uh8CrYCO7mjyeZ5nAv9JqYbGH0RE72g@mail.gmail.com> <5829103e-d357-4880-b295-fa0d9f4a2c62@gmail.com>
In-Reply-To: <5829103e-d357-4880-b295-fa0d9f4a2c62@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 17 Jun 2026 21:11:18 +0200
X-Gm-Features: AVVi8CevEMHwHNls8shiYKcqaoxsZgH8mtAtf6L_Ht4KfecYsuMPsAdXNTzv-2Q
Message-ID: <CAHwyqnWFM2jskm6soEu58tp_TgO3fmuODD-yTiK6-4Hpv8SMLQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/7] branch: delete-merged
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> Right but you sent that version a few hours after I'd posted a partial
> review which concluded by saying I'd finish it the next day. If you send
> a new version when you are waiting for further comments it clutters the
> list because you know you're going to have to post another revision when
> you get the rest of the comments. Anyone reviewing the interim version
> is wasting their time. When you receive review comments, by all means
> start thinking about them and updating your local copy but please don't
> post a new version until the discussion on the previous version has
> settled down.

That's fair. Sorry about that.

Will you let me know when your review here is finished?

I received the same feedback from Junio before, so I'm not unaware of
this problem. I am trying to slow down. I often prepare the work as
soon as I get some comments -- I'm on paternity leave so I have a lot
of time when the baby is sleeping -- then I actively hold off on
sending to not overload the rest of you. But at the same time I think
it's valuable to keep up a certain pace. It's a balancing act.


Harald
