Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACE371895
	for <git@vger.kernel.org>; Thu,  7 May 2026 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194565; cv=none; b=mCrhGV6+aK9P6VFL0EVHEqROgd6Di3N2zWwhCowakT37aHqzUQkFdzoAsY6ReJonmIKAlXhkyHm50bN0qZvGPQZlGNcVYCQ2u9r7XAPV4mLVIW4+CYbFeJMJzV2NkNBToFgr49dQl+goQfoPqPEy4aXxUJseCfI7EHru+E6D3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194565; c=relaxed/simple;
	bh=hChZY/6ymdaBN/Q7omFf3/o77vXMFM++rVf7ayAbT08=;
	h=From:To:Cc:In-Reply-To:References:Subject:MIME-Version:Date:
	 Message-Id:Content-Type; b=VEPtmcWmJKt4cgArbBv1JcUXmS4YhGj9QMgMUsHqP6zdPgcBGvSkh1FOswF8qnrIPIVRioqD/ozfCqPpx25LiHpoPCZvJ5ZTNcTMkEgapcuoWzmDaIFn6WQJ9NSlz7xdD1HxmFnGhsZyV65FgKIDz8zvYMRwGHQFjz9Hs4bAgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru; spf=pass smtp.mailfrom=ieml.ru; dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b=LNzrHREr; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieml.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b="LNzrHREr"
Received: from mail-nwsmtp-mxback-production-main-13.sas.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-13.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:39a:0:640:597:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 7B65C814DA;
	Fri, 08 May 2026 01:55:50 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c23:1d44:0:640:6c14:0 [2a02:6b8:c23:1d44:0:640:6c14:0])
	by mail-nwsmtp-mxback-production-main-13.sas.yp-c.yandex.net (mxback) with HTTPS id DtOVvl4vsuQ0-J1Y6S13z;
	Fri, 08 May 2026 01:55:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieml.ru; s=mail;
	t=1778194550; bh=umBRjlGrZuwDTCNq9CXMuOCbnE324Taodl9je5L3fiA=;
	h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
	b=LNzrHRErL3pSdU49zn8659YWLkUGAjqst5UpsAuPZN+XJugdsn2P/ezYPvStY69GM
	 /mdWkxC4HqdDfvdTH1D68rVyv3y2IQ5LMlMpErcJXuhH9bnDbrZoiMwk73j4oHcl7W
	 shxud6KFAfZFsNnM/+LWYZY5lLSYplO6B6kCPslw=
Authentication-Results: mail-nwsmtp-mxback-production-main-13.sas.yp-c.yandex.net; dkim=pass header.i=@ieml.ru
Received: by sh4ynqz4zpjobpoa.sas.yp-c.yandex.net (sendbernar) with HTTPS id 74dbb43254493b277723105bd7e5f86e;
	Fri, 08 May 2026 01:55:49 +0300
From: =?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
In-Reply-To: <87E428E0-97B3-499F-A352-20A1E617D168@gmail.com>
References: <14616621778106505@de6a8060-5532-44d2-bc08-24865b6e9c4d> <87E428E0-97B3-499F-A352-20A1E617D168@gmail.com>
Subject: Re:git 2.54 fails to build for rhel 6 (2.53 builds fine)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 08 May 2026 01:55:49 +0300
Message-Id: <13728641778194549@82262e03-137b-467d-af78-c41a576b58da>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

git --version  --build-options on 2.53   on rhel 6 actually revealed the problem. it showed that actually git compiled with system openssl 1.0.1.e

  it turns out  that ieven though  my openssl version(the one shown from  the root home is 3.5.6  git tries to compile itself with system openssl which is way of - 1.0.1e) it fails because of  this item in the change log of 2.54                                                                                                
 ""imap-send" used to use functions whose use is going to be removed
with OpenSSL 4.0; rewrite them using public API that has been
available since OpenSSL 1.1 since 2016 or so.
(merge 6392a0b75d bb/imap-send-openssl-4.0-prep later to maint)."

git 2.54 successfully builds on rhel8 because unlike rhel 6 rhel 8 uses OpenSSL 1.1.1  as it system default
specifiying openssl dir  where 3.5.6 is located has successfuly solved the issue  so  for rhel 6 command became 
./configure --with-openssl=/usr/local/openssl && make -j $(nproc)  CSPRNG_METHOD= &&  make -j $(nproc) install  CSPRNG_METHOD= && make -j $(nproc) clean
and to prevent  any possible errors in future I also upgraded my  command line for rhel 8 so it became 
./configure --with-openssl=/usr/local/openssl && make -j $(nproc)  && make -j $(nproc) install && make -j $(nproc) clean
lesson learned check your build options (I was always using regular git version without -- build-options)

thanks  for pointing me in the right direction






