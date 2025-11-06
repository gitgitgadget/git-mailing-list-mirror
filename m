Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E924414
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396238; cv=none; b=Hr0G0oLVD2lmy6Hq15zh8CepT7D7TkAmikJ1H+iyf3m0fSs48tHXJWRWlR2SE5k0HnUn2IJbRKumzBz6khOkHwZHrP061YozcohNrH9xEyAlEk5NUUcwPUgkX9UmqMKlkdWp6HwnIYDwIn2NKbCag32tMyvkMFnfUKo/M4XFqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396238; c=relaxed/simple;
	bh=PCHzaY83rCezTkvU0YITYc+K2p7n/sBEi4lwczXzu2I=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=NhS5hRJfxxO7C/yLMkOJ7YWbxfP1KTIz3IG9Zq1yq4lLJxOCygmMal0oxqRn3/nD+08A4wOlKIUFLCssnwKqngPoGcq0Wg40zrQWEx/WmYS1aCkygiFebGQCCMrGADoCsr4cTQ6yCWdd1o+jQ9LEKw8fmjpHWt6aCeWaxxNzMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 92CFB3F11A
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 03:30:30 +0100 (CET)
Message-ID: <5bfd5a1d-5d4c-4bc6-9ad3-bdbdf11b031e@hogyros.de>
Date: Thu, 6 Nov 2025 11:30:27 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git <git@vger.kernel.org>
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Going one step further from git blame --reverse ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Once again I've found myself in the annoying position to find out why a 
particular line that was present in an older version was removed (i.e. I 
needed to find the first commit it is not present in).

git blame --reverse brings me close, but not quite there, and quite 
often it will point at a commit where several branches diverged.

Is there a way to make it go one step further and report the commit 
whose message is most likely to explain things?

    Simon
