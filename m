Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF46B663
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737091926; cv=pass; b=JouqB4Ba27r5bb4dE/0MCWYJ2fMQzgU6rN1IW+pZTmrBAoH4F6SMe1v0v7cBEN9+EqEawxjkhuhBwXlkgBNNhLl99hWPMyfyhE1u55R1VrGImE3tOi/mrNMPELmfDuXazPLIhgqDaj65je2XcHHulH1+d7NxqYRpl6mAtCuKJ48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737091926; c=relaxed/simple;
	bh=i35f+D9z2zSgyw1Ewip3lewMP0DCBmrQJ271IvQi8m8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aFV26czbB6LR6KQi13xoWzvWa996JQK5hSy84cGfAhnnNXr7gK+Ax3SKWwJCOLmFWxsvVDF7rO3pae8CsBkOFh9FBy3mKhjfTYipGPQK52u5nVbw0pL0wDKjSt/kTMjvC9tFuC7yHqk97y5ayiHZeJf8FmIVi+JIGQYBMPC2efs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=EjJc22Xr; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="EjJc22Xr"
ARC-Seal: i=1; a=rsa-sha256; t=1737091918; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k3Loak0+W/vlLAPKYhAuw2jdtOTpQtFxvdhna/yi87xVh6dkOlGou0KmTI/PWxZvuDpH7RK+wM4pHPEpG8Y0krFiyI2/KSrX5tKqUoVcBTQQrVp7CQQklc1E+UKFWHRj9Ts9HlKIc7qiKKHkFGynX22vZAUdhNu4/8Z3i5ZAvqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737091918; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i35f+D9z2zSgyw1Ewip3lewMP0DCBmrQJ271IvQi8m8=; 
	b=Lx1yI3AYcIFnpcU0J3Dje9AyH/0QRgImhB1HVHqzQVk7HUgBLQDplMPkcxd8HugyKRSvDuKw0R2rIZfoUvc+ds9TFgWEn9t2IuAimIq7tl/CPC7fq4SKWUv7ofqNwhCLDLs+D1oWcxJ4BZ1tIfA4otObTex+8U6RMWGhwLCI3vs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737091918;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=i35f+D9z2zSgyw1Ewip3lewMP0DCBmrQJ271IvQi8m8=;
	b=EjJc22XrAT6M3/Pzk1yDWBNvX3ExT4TeEH2bEboedo0FhXyp7h+R+wv9TwFqxwLw
	30nE6vMcJup9IVyIlViZ4oSICnsjxJZRAnXtHpANU17J4zlWmwfBbYS6V4qgq+T0Ka1
	33A5d6wcQuNPP7nlTG7aP8XTamDCPSfwiEpB5N8Q=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1737091916651989.445575563929; Thu, 16 Jan 2025 21:31:56 -0800 (PST)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 16 Jan 2025 21:31:56 -0800 (PST)
Date: Fri, 17 Jan 2025 09:31:56 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Jeff King" <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>,
	"git" <git@vger.kernel.org>
Message-ID: <19472bf2353.2c31e5fd10001.1997220058832133228@zohomail.com>
In-Reply-To: <xmqqo706u2z0.fsf@gitster.g>
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
	<CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>
	<20250116105246.GF773990@coredump.intra.peff.net>
	<20250116125313.GA2301268@coredump.intra.peff.net>
	<20250116135227.GA2323616@coredump.intra.peff.net> <xmqqo706u2z0.fsf@gitster.g>
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227c56d529f48cfe78fc04698f600006cde04f68187b101a97a263aa478f4a768f4fb7663e022391f:zu08011227801562e165b5aaeaa39b974f0000011108abd5721fb50ff69074f2b7b2c0d6bb08cf0dacbd2296:rf0801122b6f7de2a211e9e6a22b5ada4c0000ce1c61ceb7a4ba1d09a8dc2c43bd52d8f818535b5fe5a98dfefe99c613:ZohoMail

I think "git bisect" is very important part of git.

Linux's "submitting-patches" contains this text:
> When dividing your change into a series of patches, take special care to ensure that the kernel builds and runs properly after each patch in the series. Developers using git bisect to track down a problem can end up splitting your patch series at any point; they will not thank you if you introduce bugs in the middle.

( https://docs.kernel.org/process/submitting-patches.html )

So, as you can see, existance of "git bisect" is rationale for contributor guidelines!

Contributor rules written the way they are because of "git bisect"!!!

--
Askar Safin
https://types.pl/@safinaskar

