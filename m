Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA4F430BAB
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320570; cv=pass; b=H06YGLvavvYpgjxw3piq0u7DFitp7ohq9C8CoiHO/t0s3RnFQzx9M/yVALxbxQgXt59YtekF0pZzUYcOmaFQ7cCGAK1CzGS+kT5KQEhNgcGo1UqCbv7YHpfFK18Ilt7m60s7B/I+48r44nDymJRqoFd7bceQUfALOK1iWkZmX3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320570; c=relaxed/simple;
	bh=QnZANBtq1AHkXbTQIqdHt4zIcFufvYXUMxX0zwBMne0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=m0b30bCgy6iQmeRoeBwgEe4ZvA6y6butol0DrEUcGfi5U9RWAG/WvHQ2e88uOZ2fWm8zTiiPcEQMJveFmvOvtMIKxUzvT4zu7tU/oMde76Wig/3zbF+n0kCPYNi3+XKDC5bmbS66qdup/1jkxSwWMlP+yT9NciMeyPQjdpmeowg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRGy41lJ; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRGy41lJ"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-127380532eeso9221082c88.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 15:16:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772320568; cv=none;
        d=google.com; s=arc-20240605;
        b=Lns7ojXrZwspBCS7p1pE8SssHU/omGcmYt7ueEPJPg7CCA99QqwrR4m1iOlY0M4RLL
         BmU/vFtAP1V7gdfSX4hrRpOggYUyY3mc3WtNSQXpKjKc5UTk3wctuRiuHrDg9npkYVfi
         xYgffHBr6bYY015Eh/0MZUHlmJ5RCyNGL8RqykJE9/KDEgIg9UapAtG0I1bN2dKlHQhZ
         W/RqKlcVJijGWSmuGD276vk8LG+7HqDu+iZiFGFL1z9pKDgRDidkFZ9t8tf1Ax8W9BXR
         yDD+bh/VvL6Pr0CZzAqbTESbiknoayKc/CbZ7cdGkgoTXXs4Ac+JdDjVhAlF38/Omhjf
         kf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iv2rv4e9qQmvq3itZOtD8mKohM5TtZvIrexF5CByZWs=;
        fh=6DmRRm0VL7TljF7gyFZG6v3y35/QZ85EGF0YR0rMPWo=;
        b=hH+KeTL7Ygn3gCLEuaJCDYd8Bibu3wB/LG4mSrMx/yIxnT2anxV78iaCIgMcHCJx16
         DpBS6V49924IT0Ka4euaNQJ5lnqb6zo3sza41JBX0dyacZW9B3lZZS0nUooWjDtB+XUo
         JkN9YMBXAMGG1LVqONOzMesI9cMPL/XDmDiQ2L6uAkAe/kZ1adup/ZsQnBnynbuRUBj3
         2At0KL4w2LDjs5pwAKHT7i96pqRgKpzUzADkx9io/Sj8c5JHaEc65PXW46Pf5dJQrAhK
         gJ/9oq6O9NRAHQOnANFlpWaJv1x9g3jbSO7SDEANd60ZymVXm+KAyJKLY5lHh64te53R
         CXJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772320568; x=1772925368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iv2rv4e9qQmvq3itZOtD8mKohM5TtZvIrexF5CByZWs=;
        b=BRGy41lJDzSXhzdJj7DPEnxxDutJh153h4LlAXTM7ie6t7eL5XCIsg71c6p7qyLUHW
         cR6qZ9Ft/oIcIAN8w9e5TzXjgye2Djp+ZsePQG8mepel8tOwYSjxWtSzCr9mTIpRF/J+
         Sgaq/fxk3hjqZa86qOqHE5ub8f8tiSNpaXmMxcmCJQnzph0cpMpJ8IjcdaaGc2aWTALp
         Z5Dr8TJhmbCc4COXy8s6glkF7ilaq7D9c9/tt3s7n5/gNkqna0Q+2CElgQNcKQRSmK1j
         yxEAY7gdL6sX/FLxWZC4OzlEolZseJras2OISaP5W4pW23uUdB9ISGPjeew4TUzSC+YI
         s3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772320568; x=1772925368;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iv2rv4e9qQmvq3itZOtD8mKohM5TtZvIrexF5CByZWs=;
        b=ZzWvqKWIsmP2+KDs1j3nEPPLsFAlrAsgLKhOpRx9t/jSHLIvLJ66vDMpjHeFPvGvc2
         7RguaT6ld056JeOpr3FzEZEeOFOGebsfPGrQmXa3jvni88tJPjk/DU2BJEh3TWJmFy2y
         jkK3YxHz1f1aU/4OF3IpmFgNbgbU22jOHovfeGK068GhXB5fLfYREs80DiJfC7idsXdw
         UjHqnjvoeRIaBkEGGuvH8pj1JsXTOz2nxv95lcpWwp6d6m5iDpJTH3a5WRzfAmcaxtd0
         8uvSaLpHVSLcbIiYXjKlEHIcuoPOxRfqSORHpBG03RISMj/f1uzFbAjM16rmkHTC/r3e
         H7/Q==
X-Gm-Message-State: AOJu0YzeBj6kSUnzsESyffhIzkJpqrC0G0hwFgz24y0+jEr/9W6pDuHU
	jDQP8hUA1ey53SrbvOEcaJ+YRGxOgj9Q2U6OVMZGEuQCY0+oGPy8wetgbq43Be9/aSsJq+XRJSa
	LHg5HWRB9qUvnRd3dNgcx6noLJEmOHqaU6Qma
X-Gm-Gg: ATEYQzzWQb9sbEY0h+sad1hXjAeObovfg2YijCooH+yuEpEiy4FJB59Yaz2gl8GvrzI
	VmEth2uljEN5Ff/xtmiJe4XTniVGoYaha/JPz3tpHnhtv6meRYxy8lcfUgkIquIjR+XXa0OjVfD
	eU+WVaUC7F5KuJnH39MKvnulfLNJZj6/Djmd/0Mq58q8CUZpyw/2lKjkgai81db6w4KuHrmk18h
	aVCGDd5a8HyxxEtIjjPd+6uvU1BCPpZmvCBK66WbgFOUDZ3gM6IqG699AH/XN1jj4RHBH5MbRsD
	iOD0W37mG/K88PjUUfJfESHltB6EOIUvxWKiUmz3LTR5tLD+0AOW/mj37U7zkvGowWZC
X-Received: by 2002:a05:7022:421:b0:11d:f44c:afbc with SMTP id
 a92af1059eb24-1278fd1e636mr3907693c88.37.1772320568080; Sat, 28 Feb 2026
 15:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 1 Mar 2026 00:15:57 +0100
X-Gm-Features: AaiRm50-26jKo5LPGTgSnziObJiudiv74BS8kZM4QCYI37ScBAeXrGmZHrkvtkQ
Message-ID: <CAP8UFD2VLQyru0V2oPJNQeA80fAPPW4gnaPyoUpF_mbODY7Nfg@mail.gmail.com>
Subject: Draft of Git Rev News edition 132
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Martin Fick <mfick@nvidia.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-132.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/819

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on Monday
Mars 2nd, 2026.

Thanks,
Christian.
