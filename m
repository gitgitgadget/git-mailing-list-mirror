Received: from www130.your-server.de (www130.your-server.de [88.198.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1701B4244
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.195.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429886; cv=none; b=WEPdSdMYTSoULcdyvq7QynnLhtbLYaR8TwjW5sBoxn8OEGeDapKgD6sXuklNNPz7qyAaPrLACbKFiw58xpbNMg8E53it/oR/Xk9jpd37U069KmV5slTmzXiczNIQ1RIWE7o9sY38cbdHwkvaYEYFK7B1UbNwDdDKfZEqKkfJqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429886; c=relaxed/simple;
	bh=zVBGprkm7KMfvy11VLU91OjlJx8w378tlHGPjQ7ZizY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OKUOPdYZARqyquOrNQMant3JBDjYL5Q2XV/SsIH0uJ/DNEOoKrlwOqUSpcKpHMUcyUs8mCCPxxnfSuh6SI/TtUq7VmZlwK5utkgVoUNmxdoNzk9llasygYEaTurWtw9izPHSSI+sDk49NtGXzNWqnAEP41Wd/6HSCE5ZUamZ3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=virtuell-zuhause.de; spf=pass smtp.mailfrom=virtuell-zuhause.de; dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b=MBQQV1rH; arc=none smtp.client-ip=88.198.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b="MBQQV1rH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuell-zuhause.de; s=default2504; h=Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=utjVjOs6GkEQFztwY41QSyzF1yPpMTYbcNyHrQBB8zg=; b=MBQQV1rH/uZgnotS9ARsB9VVxi
	bgfI68wrygO+WAidmntN3iI8mORd1f/sUpnDEPjoBaOiaaa5SclnzBtIXbNxUUX986Fhle5pMFT4Q
	T2Tw1D5IIx6QL1NGQLLtcEd7EwxK0+R6OTR9P+SzONm3lnefV8N2S41tulS8fUXaex1zbmgOEZmMi
	LDwp/2xhJFrCcw+gx+B8/qHK6wColTDGtTDFx0Hvd+6myqLuWmtJZ8Od1F+9IQaI8OBUwwHUDXRR7
	83zA0ZJIFa72lY0x2qUzl/bRVKj/bS3fFeKlbjvDaxUUOEeIrvx9z8xgzT0205Mb3flZ+PdQuU96h
	yLZaDlIw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www130.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas.braun@virtuell-zuhause.de>)
	id 1w17mm-000AkO-1Z
	for git@vger.kernel.org;
	Fri, 13 Mar 2026 20:03:00 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas.braun@virtuell-zuhause.de>)
	id 1w17ml-000F4B-0D
	for git@vger.kernel.org;
	Fri, 13 Mar 2026 20:02:59 +0100
Message-ID: <99f2ba7e-cc5f-4ef5-9b09-85896563346f@virtuell-zuhause.de>
Date: Fri, 13 Mar 2026 20:02:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: GIT Mailing-list <git@vger.kernel.org>
From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: describe with --git-dir and --dirty outside of the repo always says
 dirty
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27939/Fri Mar 13 07:24:42 2026)

When I do

git describe --dirty

in clean repo of git.git I get

v2.53.0-522-g67006b9db8

but when I do it from outside of the repo

cd ..
git --git-dir=git/.git describe --dirty

I get

v2.53.0-522-g67006b9db8-dirty

Curiously I can workaround the issue by directly passing the work-tree

git --work-tree=git --git-dir=git/.git describe --dirty

I suspect 2ed5c8e174 (describe: setup working tree for --dirty, 
2019-02-03) has something to do with that.

Where should I start digging for a fix?

