Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A144568B
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qHKJ2kuA"
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3b87:0:640:4625:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTP id CCF3D60C16;
	Sun, 31 Dec 2023 16:50:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ioYHhCQDXuQ0-bFhbiC1C;
	Sun, 31 Dec 2023 16:50:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1704030644; bh=U6OQnY1xsZe9WSkYIdPGjNy/kpRTHFHkbggR9QA/YQE=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=qHKJ2kuAYUUXcT9KrdHjcAMYo3KT1lJ+FtHOqEoiJsuogqwLzW/JjxASknj9lqHIP
	 MqdWpWcfkA9yG5Y1DX4ZL14ZPKXiCa3x1ZXiUB7Sv6Pqg68ZjDlCreaeieI96exLik
	 42O7SyivRsAFyL1CTXhH7eB9j6ruYcCGpHxC4hX0=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date: Sun, 31 Dec 2023 16:50:42 +0300
From: Konstantin Tokarev <annulen@yandex.ru>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: Concurrent fetch commands
Message-ID: <20231231165042.1d934927@RedEyes>
In-Reply-To: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 Sun, 31 Dec 2023 14:30:05 +0100
Stefan Haller <lists@haller-berlin.de> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Currently, git doesn't seem to be very good at handling two concurrent
> invocations of git fetch (or git fetch and git pull). This is a
> problem because it is common for git clients to run git fetch
> periodically in the background.

I think it's a really weird idea which makes a disservice both to human
git users and git servers. IMO clients doing this should be fixed to
avoid such behavior, at least by default.
