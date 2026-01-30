Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF0035A95A
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813946; cv=pass; b=bb4TZnkwlEsJ3mq28qI4Nc3uaOlKZg2CxOtNaBFN0X178zpNfYjWqd+sh94gLzQfl8IlEjq+JN3jI9tYTb3C9UhXHc4ztc4KtAlnjNsrL0+o8SgV+Ldmep8onOPECVXaKristm9moBrlEbcao+6Eh3fkBKE1Q4q7bY9ig7kRJCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813946; c=relaxed/simple;
	bh=lBDPG/ul/cH+RdkPOeOuyo1I1Ovd3nFv7Ks/XO+lxlY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gswyZVFCtrVOmRZBUurPUf/fH4+PSK9GMf+COyJhawpA7f/9mM1cobp7amncbSJhx+MgrWThqTJEgEjmWboKTIZ58OMGXudR6Ei4eVLIrr6wu4Oexn/z3MS/bgeWsxHhjUqoji0s75PYLiYn08RhQuI/SE7GbXy8ONEoKgBfnac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cliSd9Hz; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cliSd9Hz"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1249b9f5703so3798776c88.0
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769813944; cv=none;
        d=google.com; s=arc-20240605;
        b=gS/OILnFmPleDf0pTc7Vk5JGFeeeB8oA5je5fZurWeR7wMa/YxdJZ4aGt/i7X8eUuk
         S8mTZc8/e6Gbtr2R5clSX+1wS7yZROUKmj3I+lBgiFV1XaTy+bw++zx0Les/0I9Ub0NH
         7CJ+iDdwRUQ7EtZEkCECdrVm38GfpqPadXn6obXa9FkNdSqHIZN77whcUxA2zE2GLEjR
         QEhgBzF+IzHPhnNUH5an/AdUqpM8FI8MZvAP7xrmq8j2vCDAzIKy+bargbNbTcrdX32X
         kL7l5ldrH9LnIyDoAXmSfBWciIMYn+NrQ7C3PyUMF2IOkKfNoN388qWeJ/7blNalBtpl
         FYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5O0cfK7deAOQZzN7pwuiVU8/HwcLvARKeJZlLBeTFm4=;
        fh=INW90c4INXrEx7SVMMEyFAHdwN7caP0PjfCK6Ehvkwk=;
        b=ZdIcsDoN4RXQfEtilVYEG+qY5z0tI9xKNs4/q+qOejf9HNPvKLinVzpVs9wH3MwSwf
         jqOq6GiqoJpJUZcGPJOfmR8iGZFMlm+zjbtqESipNnNh0nvhV8g/+XVtvlC7A3gCicaQ
         rdsxatMRbnauDUTTdEKAp07LoWuKSGwd8ZIgaOVFYAfneoKlXCZy7iyT6dfkb24tURua
         0JpBPCBEH3Y6gsyxVJJMWtKrtqvZ3Fy25TtMQMYYIT5UIKTLEzqSDQUV6eEDllgLDaWw
         ibD09HGsynrmRMSZwD61+ag+NEVj6juy5hWQy5guag/OEQMkIHlplavihe4j++PvdyX7
         9AJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769813944; x=1770418744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5O0cfK7deAOQZzN7pwuiVU8/HwcLvARKeJZlLBeTFm4=;
        b=cliSd9HzHnNckzby6+suip4fpalRubH9s6L5er3LkEMO8q9WR39CZKT8bwNGMT5TM3
         R6frWKwIaWU2CTml1bZhpLN9azpipLhVvWQ+ANXuKwb9DF7S3Mc6JD0JlGM11eCT6ewY
         c/MkcyBUIivu9GvKJ6WpMsCV6NOk73xdnidagHvXf5myR1QF8KFiFkoiLqb5Q1wjVMJB
         iR1ysgPZzr+N0fVvJb46137djbdsEYQx6YELgMf2eoWsjcnpeaDC0SATDxVAONJEa1Ur
         KMgYHbBAzO3NUNj5enj3GSIxrWh6V5Q41Lmva/k7VCmGddcxMQHkYI9Onx96DS40+LrI
         r7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769813944; x=1770418744;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5O0cfK7deAOQZzN7pwuiVU8/HwcLvARKeJZlLBeTFm4=;
        b=J0MR+4O6QaXobNRVINiHUmmJTY9GYKQATsA9RZOiKstthptWa15wccnO9OFF7aNptf
         USUCJWz9ypgQk72RwzjLkvfnCm5+k+029oLToqG7qNH64AuF56WFIWcIF4Slpa5c5gP/
         ePcM9dE2fE3WI9v+zTy6aO9J2xNk/mG4JEoueMXJH+u8eoQeDmFXeu18lVTcuyeLrwLB
         Dz3ZJ5cb2asLdAWToYsSZ9Y1hIY6p6sFzZ6+cTF23r50TTF6PpV2RwWJhpJlesXqQU5W
         mFpSrmHjY/vRdPDW/44YY3UKbYzQfuLZ3mXEdYLj9bjrM1nCY8SvtsegmOTY6577XU81
         Wpog==
X-Gm-Message-State: AOJu0YxATHKkITwwY+jcsodZec81qj39VLqJ6FTx8Y6Qo7ubpAYuBnXm
	KCNXCOg4bo5tkLSeDjzuEK/Khfu9w2QmnlEEBSeUHTLdguDw+cBTyo+woMChL2PwaBltg+6oUnx
	aFKXrpQVn9ozZ4uytg9O5HjRzFBEjXr2kJuyrJ+k=
X-Gm-Gg: AZuq6aLV4vLiRJXCjmPaCXQZquZelo6wUTwtpI/Bb4fJXl3oMJDEW2YeViajAIH5Ws6
	+fl1bjm5rvPKsT0M9/HuLFvNOEWUWqpEl+aHtRkem+2SgyOraZ35NCdeeXqGogG/0xzlsQ7/naF
	JZGYJ+Zn9P+zJNvDPJI8zKZ5hRrAEGxaGES7vp3ERS1WhtL4MuCQIdq0k7LPye2PPm1eNiH1wdI
	m00pWUnRB6EPTULNJNmOXuRfQNWEN2DePUP57Ta9MW8juTkFZN1YRb4CW+4jmzOAzH7WWZz1ReA
	CpxyLGRZ/7+uSPdhACsz5sXDgDi5fn4CVe0AfJnAltWiz216u46ltcX0TCrssHMq
X-Received: by 2002:a05:7022:e25:b0:124:a93c:44f0 with SMTP id
 a92af1059eb24-125c1021329mr1908664c88.47.1769813944090; Fri, 30 Jan 2026
 14:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 30 Jan 2026 23:58:53 +0100
X-Gm-Features: AZwV_QiSAfW4SIxyech88LftP_aImhACUbzRPG0WKms8kREK-eS24aGOcRImx5Y
Message-ID: <CAP8UFD0ozWke7m7j=wEn+sG+UmUZQa=qfzfOKiv-uHRPEhv2Rg@mail.gmail.com>
Subject: Draft of Git Rev News edition 131
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Stefan Haller <lists@haller-berlin.de>, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	Collin Funk <collin.funk1@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-131.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/817

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on Sunday
February 1st, 2026.

Thanks,
Christian.
