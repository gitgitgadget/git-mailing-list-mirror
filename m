Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6BD2F8E82
	for <git@vger.kernel.org>; Thu,  7 May 2026 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194933; cv=none; b=g1irGcw65BjnzuNADuWy4lgFWI2iLHbAkpZrjKRrX6Uj8GkdyJHnKtfeZRFJLo+wPVijcRIOdqkYwIO7UBoOVR4DEn+/oUepKgaMc3ggwVGAwR3PM+SPRfQH+OM16E9sFKsEbf5YdOpN9jCsc30kEk7ynM3C/E+lc2rjfJvTJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194933; c=relaxed/simple;
	bh=hChZY/6ymdaBN/Q7omFf3/o77vXMFM++rVf7ayAbT08=;
	h=From:To:Cc:In-Reply-To:References:Subject:MIME-Version:Date:
	 Message-Id:Content-Type; b=FlqDdb/gmBfHYAcd0woLSJj8FkHBjKLLQMTMGLqstRU/RKWJILiZye4RzkTY+9ALIrMS26G67UtsWC3OUIkvKkRbvh7Uzln1OggAxGllslugZ9r+wz4oxe3/W7YoiNc48zEKjncIPTy6z2YE2PSNS9glz7RhxoC0rV8zvS2ME8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru; spf=pass smtp.mailfrom=ieml.ru; dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b=B59bjFJX; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieml.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b="B59bjFJX"
Received: from mail-nwsmtp-mxback-production-main-64.iva.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-64.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:7881:0:640:137d:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id C8CD38108B;
	Fri, 08 May 2026 01:55:49 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c0c:bca9:0:640:8c35:0 [2a02:6b8:c0c:bca9:0:640:8c35:0])
	by mail-nwsmtp-mxback-production-main-64.iva.yp-c.yandex.net (mxback) with HTTPS id hsO9JP4ulKo0-cUCCd1Wf;
	Fri, 08 May 2026 01:55:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieml.ru; s=mail;
	t=1778194549; bh=umBRjlGrZuwDTCNq9CXMuOCbnE324Taodl9je5L3fiA=;
	h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
	b=B59bjFJXuvol0lcPmc57r/ssLsRlpjAvW8shDznw4atuWc12Car7frGNNE5jGRzTb
	 JMscMRkf9w0hcR6+gASQp0k2zXTSZW63y/veYETm2zAnJ3lxXYz+sEvsTeEqgSmxB1
	 RGuh8S5sDTo+kVmuZpnWbWtbHBxgfl7tGbQpdDcM=
Authentication-Results: mail-nwsmtp-mxback-production-main-64.iva.yp-c.yandex.net; dkim=pass header.i=@ieml.ru
Received: by qnb4xdsvdwd5l2mw.iva.yp-c.yandex.net (sendbernar) with HTTPS id dfe8b5f2029711c184e8c162216c109d;
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
Message-Id: <3268811778194549@06693829-27c3-4fe0-9d46-424ac6250bfe>
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






