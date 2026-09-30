Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F1446BF8
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757601; cv=pass; b=NTqWdwtQ3GDgqmws7PcD2Kncp1tT3RRcZ4vZ0Qcm5rOytqd12Z7j1Z5fWhEg55EeC/hs+LnD1jZKZV0sIk6mBjD9KN/aTFfrLgy7uZxhiulI4xZpb58GkyUSmhHdf6TFK8zWeQMh0EI3PeZAQUXYBsSzX0boZMu6IXHu219mmpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757601; c=relaxed/simple;
	bh=hxBxb9tj/v+6casPh5mHWXIRzCt2uEr0kgkhZBHhSLc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S2xgXc8O2Ao83L1zwDe4xM8sVhzOCj5hgj3qYQKkR0JwCDDQXVtjJMuTwNiuW1CB5W3xQBiyVWhs262BgZbebjT8XVnUoGVYZR/Z4QUXftav6YD53lE2mwGUNd+qD+CgVTVp+xAsSO8gdyiDMS9hTc6W+Tr09gBt+JB1anZzEYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=se598R5Z; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="se598R5Z"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04edb5so8640618c88.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 01:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790757596; cv=none;
        d=google.com; s=arc-20260327;
        b=fB18m2vUjnjNGOba0uLCZn2TgwS77LZ8avvWOvxFt73+GHzhdqep4SfeFQ8eiS+pt+
         fSo8LuzU8s1KXwITNd0Pdsop2sLgJDjLrAmiJMxhMR3w8qi7Axb+3lsEDlYxCnUBzZ6t
         /xUlKVOPAYj3XrUzM1QxunLGvn+APSMuh0NV9Zo0xqA8znaG4pdk9PNRhUHRqSTegH9i
         DEoKbHqRC0WEZqSANU6Y/2lfK5ytDhp5BqILy/oXR/WfwpOlaoOBbkDfIuKcj7xhAa/K
         cA2ZTaxFXELv2s/dCusV17jKFNG/OTwdSMq0XE7hNIDV9ToIQUo8N/rdjlQoAypPqzB4
         Aodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+kZz2JcILk1fCdg5EK36LWmn61lq9HUXWXOBzqD8BHs=;
        fh=1hsHg2A8KfpQ5f5R4xzcqhynqNho6Ie10tJsSKgpn5Y=;
        b=W0ZJmkAHcYLKGTSiku+B7ItiEkp55CrIztlngBQw25ieR1X+2UV6m4Bmr3HC3IuOtO
         T6EwQcwMg7DgBLGR9Wo2IN5OjnXdSturKcObSQcfJWQ9TTRy0S4ZNOoew3/7hJol53E2
         5maqEDt41uHN4OKqJ9HFkk8VDj/PU1TIfqT1GDrGOqkROy4b8eMjFcIDPgT80mzHWbBN
         DyCAb2UYB2TwVVEw8iQr+LG+voG21/OGhhmNJjUNgYJoE/nCjMuPCQge7oHSSu/3mTo/
         McQhHiB2xE+E+q1IPQEZ5+kYg2E4tNGY6Fu9tygdxZpRfmSSZOnl90cCsCN1TRbe4MT8
         3N9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790757596; x=1791362396; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+kZz2JcILk1fCdg5EK36LWmn61lq9HUXWXOBzqD8BHs=;
        b=se598R5ZbyZ2FEUdkg717U2Dayfyl5jXpfXbWhso7k8QC2HBByrZHir21ITdlgQNwD
         zPSR3pfxPS2U6OATHBEV4V713kk3qKBmNzL9BB32jB/Xm/JBJHXyETK1HI98IPDWOTVN
         w77hudzKlJPkpQJm4kk2rw9gwJ4/OO0VVBWleu9X107DeXASHqQtvxgJOobFRU9yB+Vj
         9btFvqa1nBlDhwIVin9ucjkh4ft2U/ODsZj9310NTaUK8KqiWTJmq9fYZ/tJ44xOhpAH
         NKb3OxZ1J1N4EekYDrIfkYmBkizGDHTJ7259vcpqDLQLfjyscmm0cJj7wxh5G1mNdxMT
         e2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757596; x=1791362396;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+kZz2JcILk1fCdg5EK36LWmn61lq9HUXWXOBzqD8BHs=;
        b=znk7VGgpwLxRQxN4uLOD63lCYh7b2UYHh+bUwIR0+1H+z5Bi5SeLiGYVcx09Bo4Cdx
         xTeswv3vRo7mF5HFO+QPJKI9RNDrQFhuRGkUSC6htYm1N1EGdhtoU13fBhKtQ++0m+cG
         L13sfcytLR6/WHJV949dCfZIj9h1gAgmVKs3OuThFB1OlwlnlVCUJ1wcQW4oUsKY7XOo
         VWZSjlSONRg7GwmmOP5acVbTOkPWPjym+hfRa+oHxD21XjSpFu9T1JRme9y0YR09yGze
         AbR9JC/+YwVZVGv/SKpFFbGLUnpXRzdm2mPgy875dphlatX0jgYUn851nW5/v4RJp36B
         81pA==
X-Gm-Message-State: AFuF++n5rrCM4aTLYTg1j6yhjLCX9YRXC6dbg1Fu/FXeJuCCwqyfr2B7
	rtqMQ333IBKC+qtfhQazXLvxk2x4RaAvEato2HSlRNc6enfwQmA/RgCt91R14hhbfb3jvT6R3ei
	rBDDVYcFi+Y/sQ1MqffeppnwEjIZ5s40+d5uBb7qZww==
X-Gm-Gg: AYBFou0WSC6i6hPWCZ1xkt1f0XmJB+PI6ieFqQGWUR5vyj4dU55eRJeF/5WZhI2KTsR
	Jbq5zCQRKLuCqolNgr1gIRoncdPHuBLfiS1QoZdpT5vCF/JJd1crjsSczYozeZRrNdpvDNi+iJ4
	jZ3tCPIaJsb1+M2wnu9L3Xkc3sDU05XnHAE8uQXQ53iwaxOQCpvHv4GJWubtBxGHeynqBg/9P1p
	Es/gvOy5VEIX2C73Id3ZI06J5y954vfVPfkqlp6FCf11jfphA4Mj0j1lMQM7p12hbMlY1QD35p2
	b9QmG4Jfuv9bst8Vh9ppVYdH5Jno7FG/gM+UM8hUwRHafjpvBdCYdktYwnusSECrerxK5epTs/T
	SBhkzU6EsxyMbyAFBlcZVnHDEWePa4uugpxmr4W9KwU8W7nYz8omCyTjFJcsMhSdwomVztXN5M0
	LfVYQcM/xXhhtAFL/DrQdOUwzTf+RKg1CKGZSCDhHPMGplhbOZqw==
X-Received: by 2002:a05:701b:4544:20b0:144:fb42:50 with SMTP id
 a92af1059eb24-14d331ab843mr569065c88.31.1790757595881; Wed, 30 Sep 2026
 01:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 30 Sep 2026 10:39:44 +0200
X-Gm-Features: AclHuK-yLBn23Ym2etvISTwV2i2YMTtxHiK4KjQEh-_WT5cBZvo54fdvRE6FC2I
Message-ID: <CAP8UFD1cA5uCpLRoozRMzemFwMbs9=ug+OQq3ATQcMA9HMK72A@mail.gmail.com>
Subject: Draft of Git Rev News edition 139
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-139.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/860

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition early on Friday
October 2nd, 2026.

Thanks,
Christian.
