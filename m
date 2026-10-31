Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793463528;
	b=5eLAU0yu/8o8IQO4bl4ujlDbcv+eVVL+iPom8ox4iiLFDpZ22X3Mu83nHjINzVi7V4qU
	 YA1zYaf9LUnwuM7qibDhID74lp1r0pIUPLURE724+J3illH0PzsmdzG78hgatDMQfqTba
	 DE27YN22qM/HggBb0v2EnTGbVDuoIY0RdWQ5vQR+wL5u+xt3/50os+pf6udwjGiWgTMcG
	 Yr+4PGWxzkxwLBuA0IBFkpxYE8WWS3SlS20N+lPTfa/GDg2FhhzqSQqaolBYa2iOa8d82
	 4BCuWVoVa8n+4IP4W+dcKl0X+exRnuR8E0wdt3+fWAWxz++i74LYmwn3/4BceIvN5Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793463528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=vHNSaJn0HZAhb4+EcvxQDcRg5G6Wy9DvYl/uCNa1H4c=;
	b=vlg2HB08FuScuLsal0hITQJegmUY9QX00RwmJ/iH6HTXvV4rw2Duqe8xrG64zDPMep0r
	 Q5R0hef2wJ37VSmJ9MDn8+O/bqFVjSsJAoCzu9S5OX/HS/2d9fT/O03aK1IV9k+uGA86Z
	 RiyUFogUdqrlXte3AxWbZC5j+9iohezpa6zCMsM2nJpzCNRWxRPxhrPJPRb+rk/imZFCw
	 ioOiiEVywrpyVvl3Q0h4fXYXOh2vfqdwgiRvT1Pb9rcqfaW1uf8YWbrH5nsZfbR1zSQyX
	 NpDQTOXiDWPrBCB+n6XitGkm4TcZqnIlCqhlJRVe5XuqtGDg+2rDJCwYTLcqiwMSRPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpFfYLA+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F097606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 16:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F097606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpFfYLA+
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a3c08d6928so2221715c88.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 09:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793463527; cv=none;
        d=google.com; s=arc-20260327;
        b=MsD0afDqTnlb5uc4fQnCytolzA2EJBp7asLCbzDoHKS9D0zCFUNpzzqxyqn/FCDXDa
         /2cUDAvImmHsJxrQDJvAcZCsNXNpSo43fKGcLyQo6edh9sxPUSITCSFLfrH4INkJVoDV
         V4qObzsm9qy//VWtW319iSRcyjgG1rmfYH9ANx4NnFvlbgcDgOERtazoprMWt8qJdgwx
         wGviIVdp8SAQ2ouvtRFNRr725G0dJ/jyDpHYDF9eaUwxb7CPt+0Zfj4TxWWRjylkC5nH
         HAJT+AvMArgBq3pdqmkta+knWBBmQi9W1NTUTUgcNiPNoiZt4dG9Rv85PsqK/aEB0ijT
         WBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vHNSaJn0HZAhb4+EcvxQDcRg5G6Wy9DvYl/uCNa1H4c=;
        fh=ZYsNSz1TLA0lEzp2/5sNdFwJYirH7Tz4fUxI8gkBKHQ=;
        b=s8N6+ejGvdKUKjzJCdreJ/6wRd1yWZP9S5a/fBtQ6Qx2QCJAQ2vprXo7LbF2a1k9k3
         u11sV5EbN1oDb7ZCOMO+TnzJpNqjITopWKOFGGRAcylj8L1cKRLhcIDieZ768+d4Yeb7
         wkAB63BH28nFgX4kzoXPFTv33RRLS0MLaNjTOBki7prGazL1rJPRjGke4oNHjAd/wKLm
         NzKSi0mk2GJiv1lIy0lHqQsKvGuv/q8aEB3DVfyTSx7WdsTKgAsGzNpYS4v4hTCuKzW0
         EO6CPBq1h52XUsuLatejUCjUZfPww9H9jXY2HERZ5tJNU9l9RGR0rEDurwIZyQZ1/7nz
         1o/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793463527; x=1794068327; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vHNSaJn0HZAhb4+EcvxQDcRg5G6Wy9DvYl/uCNa1H4c=;
        b=UpFfYLA+gjSc4dcckB9duMyqKtgn6vezhQKkcis7IlNtN6q+rdwIeKMP7rngKEpuw5
         ngxnmgnghGfczjyPA5nFf70jzsKcOIaAi4IlZ5tewzxg5pVqJ3wZ83Q6dygGMRBHizQ0
         KxFyG1/FpWE3UAW4DinozVOjTGDsCAkooAuNh1z2Ch4/BU/BkP+T5Acvf6Ewvq1hCkYA
         Omo70q87UPN/1UAk9gQQ6SAcbIpy6vuBvMzYnZfs2doT5/wm5g5Neiyk866RdsBTLkOe
         KiDVjOT6hvVi1RqpjRRWIYX80SJnbOPv6iLFy4QngZsBQUvF5IRM8DACMQMsEkpW+roO
         2FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793463527; x=1794068327;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vHNSaJn0HZAhb4+EcvxQDcRg5G6Wy9DvYl/uCNa1H4c=;
        b=inCBxmPSaB8+QYzbtRRM9OrUa9GVlaKiD+I/1xlFU9ez8tiqUAFm2sVJairZpSlnEU
         fzv3i/Ts83LozJvT2/ZMIZ6wAhFkSpP4aGCoxRuerTyZH+Y59X5wRSI+/k03M5a52LAm
         CaBnsIHhaqL2M/VmNckFJBD+xNLZOvfl1IQvobhi5IBtFwY4lFstsn9L+KfTJXzkShiD
         SHj1MaYduED055SXP7foD6KeI/IQdiL7dWJhYjl2vOueHGLPOuKzdFjUYhdYkL8bRpUk
         Jek5wzmjShXe1v6h1jP26tzzNV/1mpCNHmzT8YlWjhoKE2gP0Q1AjXGy/CnO5l/YN/E/
         BiYQ==
X-Gm-Message-State: AFq9FYIP/AdC/nul1P+GzRhrbV40E0bfhxCj8cglGa5GNfslQEYqilW/
	SbeMy+rRGu+8QIzQXif29GUK6+RVtsB+bRIU7/9q6h3DICqHVNMBkbC5+BaMa1BpXvGvjBrHv0E
	pBWaCJKRQk+iD/yZVKo4WaWw2ZjbiQ26OhlPjYIg=
X-Gm-Gg: AYBFou0BgAFSTX+GdkHELxAkHUc+aW+E4wSXI+ZUDrNZ1krWmJQ/S7LtnsyB/ma6Bru
	/mqG4LD42GVKVpoCmT1ZLH5JB9dCOFJ7M/vGJfDR0cbuujLdPU6NgF60uudrvgTgrDmYjMUwd63
	ugQaFx3AhzebT6Dad30k11JiCIgWE5jGe2wFUjAaFWgl2Tq7AyngUA34RaAe3CtwNRoG+TF0VZz
	Z2xMRbsa3oy/nc48A9ERyNGynZLtuHOuqwQqmEiJsGNSFdBlRnu75Wm/Yp93n2YtWCANkFlL2f3
	wxr+XUE2COPqcGA/gIZfkO7I0ypxv40Im71A+gVvSx6X5fmo48I0+8Sn59RcIW+teo1UPBLmgPW
	7NBXhSnFjCBX57EPFEbuO7CuXa1gETc48sPGAKiu3+jfRPF9xcpuS7uslN9TaT6pB8kyhAKA4mI
	2E36B6w3Du91c/Alxi8Z2akzrH2ZfIu9Z4r3E18aRzO7MhE6lbYx89+yDnZUN3fv+WCqhZaxHBv
	hT3rZJE+ogS/jmf/dq6LncQ
X-Received: by 2002:a05:701b:4515:20b0:166:5552:780a with SMTP id
 a92af1059eb24-1ac5b028b11mr7483991c88.8.1793463526808; Sat, 31 Oct 2026
 09:18:46 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 31 Oct 2026 17:18:35 +0100
X-Gm-Features: AclHuK8T5LZj69o8_dMrkndbxS8b2XeMN9zovw5Ya7fG0klmC5LiBRZ1scdwjhE
Message-ID: <CAP8UFD1YXKtG1r0aNmeBbuJx_msXxU0O5qOYM_jNU5wubaQZ3Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 140
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Aleksei Sviridkin <f@lex.la>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Thomas Bachem <mail@thomasbachem.com>, Weijie Yuan <wy@wyuan.org>, 
	Tyler Cipriani <tyler@tylercipriani.com>, Pablo <pabloosabaterr@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-140.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/872

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition early on Monday
November 2nd, 2026.

Thanks,
Christian.
