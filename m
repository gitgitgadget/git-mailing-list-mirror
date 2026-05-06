Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10D17A300
	for <git@vger.kernel.org>; Wed,  6 May 2026 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106928; cv=none; b=KViBezO0Uk9A6aJJmO0JeO48cTZaNnLeEdG0Lk4IvRwg4qzZAB5UxSETJUDHgYsh3+5HHc07hRzFMDKaYrgl91h0s9iIZgyst1O9/1c84Z7VLvgTnVuhs+uu6mk4N8pxOJApuB4ey9InQjr7WhuFATjNgEEn/Rqn9g3BefTK6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106928; c=relaxed/simple;
	bh=jnU3it3FPFtiWZGJvJn6MgvZncGH3kFn4cZbBso9yGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:MIME-Version:Date:
	 Message-Id:Content-Type; b=jIFp78uMLgq1Tzj4c1Y6FDCNAMWpPWF1vQP205/dfh8rujKA+pmACNjtd1M15vnx7pYiDkShklkiK67DtJgYXf//84GEcS9l1jeyNxzt0TkQiv88v5bRPdklyXGWdJhZPKhi110O1/Emeyc3t2A7HbIIDrSv+/Lr55ELPaM09bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru; spf=pass smtp.mailfrom=ieml.ru; dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b=YtPw4MC4; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieml.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b="YtPw4MC4"
Received: from mail-nwsmtp-mxback-production-main-66.vla.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-66.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:120d:0:640:f4c3:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id C5552C18D7;
	Thu, 07 May 2026 01:28:26 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c1f:3b26:0:640:92e:0 [2a02:6b8:c1f:3b26:0:640:92e:0])
	by mail-nwsmtp-mxback-production-main-66.vla.yp-c.yandex.net (mxback) with HTTPS id OSqUco2wbeA0-sCOb2o05;
	Thu, 07 May 2026 01:28:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieml.ru; s=mail;
	t=1778106506; bh=jnU3it3FPFtiWZGJvJn6MgvZncGH3kFn4cZbBso9yGk=;
	h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
	b=YtPw4MC4VHc5bv3sfqAkPomDQV25KMPaluTvGy5iJLHIdrK1/YmLQymJWkLmyZs+H
	 P2eFc2fQ6c50E9EGI5kHaJ96jZ8cLkAqpS7TqvaTy0/FtP8ndPSZ7kkAaUyJilGWeV
	 Bh6Epn6XjCz973KQVm9YIJa8sgB01Zl6ZrIC//aI=
Authentication-Results: mail-nwsmtp-mxback-production-main-66.vla.yp-c.yandex.net; dkim=pass header.i=@ieml.ru
Received: by mail-sendbernar-production-main-46.vla.yp-c.yandex.net (sendbernar) with HTTPS id 0fcc86c444e3315b39435d667efa83e9;
	Thu, 07 May 2026 01:28:25 +0300
From: =?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>
To: brian m. carlson <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
In-Reply-To: <affprsBwpM7L47j6@fruit.crustytoothpaste.net>
References: <9692091777837852@4991cc90-7cef-4f92-9de9-e195e7f2c04c> <affprsBwpM7L47j6@fruit.crustytoothpaste.net>
Subject: Re:git 2.54 fails to build for rhel 6 (2.53 builds fine)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 07 May 2026 01:28:25 +0300
Message-Id: <14616621778106505@de6a8060-5532-44d2-bc08-24865b6e9c4d>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

any chance someone could show what commit causing the issue, since 2.53 builds ok. Ive looked through the changelog for 2.54 didn't see anythihg specific that migh cause this.
