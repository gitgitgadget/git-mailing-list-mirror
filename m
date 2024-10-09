Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FE1D318A
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494038; cv=none; b=d8HoO9XBRVxcNBKkzV88X9C+58phLzWp4CAyOAFAo0OwPvjQ7Z2f2zurESuhmoLG12U5eBCTYLnBRuwKrWX3RylLkMSghFiyy0qO5J52pisSViBxfh1PdOxVb0mqnMkjQeSLM9buhl6sHuHCrQ5Or0mzmZFptl2BLE5EAX9+3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494038; c=relaxed/simple;
	bh=8l0iiBT4FCNSAf7dS9pY3If1aYqXgDsVrNgvnajbQLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWS3E/By3SJqHoCu4k4G7DlPjZJs2mPy1pu6PXn9gKg7wmB9vYOx1jM/4Dqbt0PwDBxjpRe+AKb+hfUn+b9nGPeCbXb/TbxwOVThKp4n/QzDtA/GSlPjxY6D1VhgeQ8MucYDs1B7JKCFNO8bGjMzX0JUfNz3V7cczJPB0SmrQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=dkp89FH/; arc=none smtp.client-ip=195.4.92.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="dkp89FH/"
Received: from [195.4.92.127] (helo=sub8.freenet.de)
	by mout1.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1syaFx-00Gyts-Hx; Wed, 09 Oct 2024 19:13:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZGhuKBGOSNKKpGnvaJq9CedIQDEMDo/iHQg/RJQy8zU=; b=dkp89FH/oKl3z46SzbLYzGdDvg
	v1dHQeyG0bipx7IrykBnwPVijdtSVtkq57uH6zLdu2WUspa7jWT85lynMuZ5JIYs/tCddXRyRTZkQ
	n+JoBcAu/EUCgudtJRv+hPU1lEj6cWH2flh6MiD/hSg22tQI6rnFEcWX7gO5haqLpNOAS4bzzwocV
	SBmx6CgMFoMUvQBsN2MOK8Aa3Y9VOQhR3it2txhuBYw8tH9uMrwxoqZLB4DdpSQsU7FUst29BLUz6
	IlkjrwdZHuGeLcgo+0Wu/SbY543rab8DvnIUoEEG8dc29iBhIXuya6lOzUoYO1n1ftK4UpZ/mP8qq
	M6aS0iCA==;
Received: from p200300e2e7083000dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e708:3000:dacb:8aff:fee0:ca63]:41540 helo=soren-pc.lan)
	by sub8.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1syaFx-004YLd-7H; Wed, 09 Oct 2024 19:13:49 +0200
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: tboegi@web.de,
	phillip.wood@dunelm.org.uk,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH] mimgw: remove Compiler Warnings
Date: Wed,  9 Oct 2024 19:13:41 +0200
Message-Id: <20241009171342.2354-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <4530b7cc-3f91-4009-977e-97519a5a9f85@gmail.com>
References: <4530b7cc-3f91-4009-977e-97519a5a9f85@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1728494029AF00E80A0DFCO
X-Originated-At: 2003:e2:e708:3000:dacb:8aff:fee0:ca63!41540
X-Scan-TS: Wed, 09 Oct 2024 19:13:49 +0200

Hi Torsten, Hi Phillip,

I have tried to implement your comments. I add som comments after the verable to explain what there contains.
I try to do less a possiable changes, the _ssize_t was there before and I change the type on win 64.

Best regards,

Sören Krecker

Sören Krecker (1):
  mimgw: remove Compiler Warnings

 compat/compiler.h               |  4 ++--
 compat/mingw.c                  | 25 +++++++++++++++----------
 compat/vcbuild/include/unistd.h |  4 ++++
 3 files changed, 21 insertions(+), 12 deletions(-)


base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
2.39.5

