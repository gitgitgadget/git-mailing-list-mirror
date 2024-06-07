Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F1154444
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751143; cv=none; b=RL1eoQH2WiexqyzlcuZ2KHq1YlzPyEt9624Urd/QuZe5aWO0y1F5GVI2OJ1z7D90MPBn4MPso9zecvx0kHqbGPYgnHfdmjg22WDyuMjJ69npzdrdq4KZqETVl84dGJcDDH2qy9/qZdhn2JI6V7MG5ztoDam+MdacJCatUdmcarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751143; c=relaxed/simple;
	bh=9jS6hDGBlzzOwzIAOOKJmILWMaLcmv5bpSQDsMbNkek=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=qHHWsQlAvOXWcRfKBS62nUma0ca3lCpv+9hXU37mRT+2evjCwRrmQeUMGwFa6Mvc1f6qs9OImjygtQzK53ulXYScsZZR/+rf++7QvsdAhV1IaUemkSFsOmTE6T7T6oI/OuOrYhDV2ThCWpYhR9gxLRi4vykTaDxJ7nM5SJpG2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GOo04xEr; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GOo04xEr"
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f220:0:640:b85:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id D0B6860AD9
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 12:05:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id V5WbkpFJliE0-3hFvHswM;
	Fri, 07 Jun 2024 12:05:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1717751131; bh=9jS6hDGBlzzOwzIAOOKJmILWMaLcmv5bpSQDsMbNkek=;
	h=Message-ID:Subject:To:From:Date;
	b=GOo04xEraqjEAso5JCrdhFR1fYLK1F5Ez7wtIhYpAd9DuXOWe93XJUeSa91uYKdb7
	 hOFD7cpRN6kbXnihQWO+jOKkkP2PRLbqT2DS+YubIvB2KYTcqvd9NqkZb2jX7r7Em4
	 2C4AzDVZW9ji32Xjzy1zbEW//Yi1I4VSuGfD1qn8=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date: Fri, 7 Jun 2024 12:05:30 +0300
From: Konstantin Tokarev <annulen@yandex.ru>
To: git@vger.kernel.org
Subject: Autosplit option for git add -p
Message-ID: <20240607120530.74297526@yuvnserver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello all,

Is there any option in git to make `git add -p` split hunks by
default, just like 's' was pressed automatically? If no, how would one
implement such an option?

My use case: I've recently started working with big LaTeX document
having every paragraph as a single line. As a result, hunks quickly
become larger than screen, so that splitting is highly desirable.

Thanks.
