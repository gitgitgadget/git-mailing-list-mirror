Received: from relay3-d.mailbaby.net (relay3-d.mailbaby.net [66.45.229.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F24A02
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=66.45.229.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054715; cv=pass; b=rEeMkRUXZ6gVF5Xac1phJGj9Ve8EjDKTantIzCpKZU9iQAY+2TUPDevEbr4m4+D4Jp+G7e6Fw+NVD99EDfIiv/HDw0uy7kE4QO66N4xxaZSVkzxQ2cE4NPx/LcT3jWc9x/kRCENMuFL/g6ubS/6M+EOrraCA48Y+KH3qP0MJD8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054715; c=relaxed/simple;
	bh=blVpBL9jvKozvLjDVDvvBCm6zZdDoPwZVxuaHPkF24E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+cK3P2ZT47heeG/h1+eV6H9nqTvHtqxgotqPoXqSSXFeulyTvGjUUwlnckAizc+3WYro0PtSWR+QMOPsbozJiec2DmIansTCAhuD3+kPHVik0Qvsv/zunwfi2VBlfHcWn4weIpT5WooXlN4Wn+4KDZGsV4g5TPII1Ijf/K35ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=k4XAs/jd; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=0OUK6wqs; arc=pass smtp.client-ip=66.45.229.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="k4XAs/jd";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="0OUK6wqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=FqLzZLv4NnN04ChtJjsZE4SjgzDXz95m6enjUT3nWjo=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=k4XAs/jdvAzAcTp3tssumKGhe3lwzrjMQhYQHtKRLVueB8IXUBpl5EX5A4uV/lef2yGp2RlV4
 DkOYfbvwUxCtZbPLtz0Y0BDQiueyl3aRe4bjYWLDR7SRDK3m2LW4XSSqLR64go72q7cqa+IdHpt
 6p9BiibX6gG2v8uu9v6zT2s=
Received: from nyc3000-r.dnsiaas.com ([96.47.167.18] nyc3000-r.dnsiaas.com)
 (Authenticated sender: mb6724)
 by relay3-d.mailbaby.net (MailBabyMTA) with ESMTPSA id 199cb6aa0d30001c62.001
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 09 Oct 2025 23:59:46 +0000
X-Zone-Loop: af6a4a5abeb7ce1f492b379f877b0694bbd3f561c27a
ARC-Authentication-Results: i=1;	rspamdcluster1.mailbaby.net;	auth=pass
 smtp.auth=mb6724 smtp.mailfrom=code@agatha.dev
ARC-Seal: i=1; s=detka; d=mailbaby.net; t=1760054386; a=rsa-sha256;
	cv=none;
	b=obzZYfLJIbQaFp3CMlVkGwTYSzwfDDgQ0rhbHoceLeVYhqxwbOqvEmN1/nnGJAppqgJuWt
	tHbDjXek1x5D+QE4ywvToBB+sL/O696MCRwWQbQvuWuDSj4UDj2fdOwZKHOvUhC1Z/EItO
	y62LDwJ1spvUgb6BiDwYE2p6n6rmqISctZ8tMVaHwqeP6TWTFlswt8iPApU5U1MKTkZH4s
	fYdzXxYU0kV+8QBnFoPvs9NIARrzz0CKCDr6lXcVqakg/j81f23xFTc2aS2L09Tgrhem6q
	+lipw0K9orT2T9pxFOp3ohLPZSBSQiUHWt6d/8uRLEzkiau7kjJHNOKAXmy9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;	s=detka; t=1760054386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FqLzZLv4NnN04ChtJjsZE4SjgzDXz95m6enjUT3nWjo=;
	b=ZJSYk1IdjX29Z5TtcZTZPyWMWc1Fs1Djy8/VqMbV/PUkhl8/GnNVs1NsK2XNrNBRCpcGNQ
	urmRgl7YoaV1RyBz57OKKu1S9zqt1kbsI3Q8DBoWjeaDteeIizwbA1Wlk/CkfuOyvLl7av
	lQHILF41TWi4OY/Vj44pqkBLjVvswzeiPK3ZgD7lpdXWgw/oxBNANSs9fpvMReeEQWpJmj
	BVzfudE3Wfssw5ELB9HlNbWE4qfCoY7tbngF8fWIi42LF6NtwD70U0cSoNJ4Wz6UkouAi1
	gZ4Sg2Nk2xbo+EuEEPALF+/WBOXik35/B1ct0mvYnKtpvf/HEGQKwBJmIrKmcA==
X-MB-ID: mb6724|me@agatha.dev
X-SPFOrigin: SoftFail
Feedback-ID: mb6724:199cb6aa0d30001c62:96.47.167.18:mbaby
X-NS-SCAN: PASS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FqLzZLv4NnN04ChtJjsZE4SjgzDXz95m6enjUT3nWjo=; b=0OUK6wqsjm4q4ZlJ9CaagpqjW7
	Am4m5IhzLhrVky139blkQuNL26lcwwI04EpMwo02fi3AhJYvEiuG79lm+Bi5Ug/EiiWZxgt3uF/QV
	HgbPibjN8b13Ltmi3oTAJHU/iEtTMKov+8ulyOOeYHLL6LoX2ZIxl0+PwH8i8TEQVZAqpDZM5/ZGH
	sqjaJ3fMB6AZ7g2djFODm9jrnv0XKFTkejkTf8a/S9fHjIp52+6zuG/GJSUhYyhkgsTf/7XVYgn7h
	pqSqKkwpM0gzOLrGPWvrWYNWKIvDz/kat1Lrn1ULUbWVA1B/R1EsSq+apLk1vORwBxyyJCXVl7Qqz
	vt3OBjLg==;
Received: from [23.94.14.143] (port=51490 helo=lavender.agatha.dev)
	by nyc3000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <code@agatha.dev>)
	id 1v70Y1-0000000Ftue-1O0u;
	Thu, 09 Oct 2025 19:59:46 -0400
Date: Thu, 9 Oct 2025 18:59:45 -0500
From: Agatha Isabelle Chris Moreira Guedes <code@agatha.dev>
To: Immaculate Atim <immaculateatim56@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy] Introduction =?utf-8?B?KMOBZ2F0aGEp?=
Message-ID: <iob5tcve2ca2v6424l7cxszvsxktkze2mumhdaqzb5ifp4sn7f@u6bslll7szla>
References: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
 <CAJXmEzTVJiDLe_9gv-6MkNcztAezQJob90S=HW7r_AkVZUMukA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJXmEzTVJiDLe_9gv-6MkNcztAezQJob90S=HW7r_AkVZUMukA@mail.gmail.com>
X-AuthUser: me@agatha.dev

Hello, Immaculate!

On Fri, Oct 10, 2025 at 02:35:42AM +0300, Immaculate Atim wrote:
> Hello Agatha,
> 
> Welcome here. Please feel free to reachout to this mailing list or the
> mentors in case you get challenges while working on your micro
> project.

Thanks a lot!

