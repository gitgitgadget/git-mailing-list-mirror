Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72538FA7
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="w1/jPX4S"
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:73a3:0:640:6804:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTP id 3ED0860F87;
	Tue, 19 Dec 2023 21:10:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id o9ReTL7OqqM0-hRRNzgq1;
	Tue, 19 Dec 2023 21:10:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1703009415; bh=IZoy96/Q5Q3ElKoqMqZHPNMZ3T44qJ1hMUeqAyWp8J4=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=w1/jPX4S7OzEexu/yGI+tq+wOd+prVHDcmcMamVkivSs6Mh/LL+b/xpSSey8iuQ7G
	 069s60dzCyFysCunbBtPjgkgYJ9zPZhoIcCuS3qolDMbYxG7k0zU9apYlSTYRhV6jR
	 jipkEziXWxy4CMnBTZlNF0zXdRK6Csd3bRy6c1HE=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date: Tue, 19 Dec 2023 21:09:49 +0300
From: Konstantin Tokarev <annulen@yandex.ru>
To: Elijah Newren <newren@gmail.com>
Cc: Mike Castle <dalgoda@gmail.com>, Tao Klerks <tao@klerks.biz>, git
 <git@vger.kernel.org>
Subject: Re: Is --minimal ever not the right thing?
Message-ID: <20231219210949.747ddd50@RedEyes>
In-Reply-To: <CABPp-BEmgOAj17DozyXNaf-9CawDic4uTpMbckef3+zHf7URqQ@mail.gmail.com>
References: <CAPMMpohbQK+3o46iiY+0o=vS+UC_HBB=CxsNT_hAb5dDz+514Q@mail.gmail.com>
	<CA+t9iMyrLAekwQHNky4w9nWD6WwxidxwfSmbqCpSRnkJgoQ0LA@mail.gmail.com>
	<CABPp-BEmgOAj17DozyXNaf-9CawDic4uTpMbckef3+zHf7URqQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 09:55:34 -0800
Elijah Newren <newren@gmail.com> wrote:

> minimal is guaranteed to produce a minimal diff, i.e. fewest total
> subtractions and additions.  That is sometimes "best" quality, but
> definitely not always. 

I second this. Recently I had a case when I had to use --anchored
option of git diff to produce more informative diff instead of minimal
one.
