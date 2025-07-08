Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626AE1E5705
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751952956; cv=none; b=gJ48+O6aF0D7ebaA3f+8oUKt9ritDECySK5AVeyhBqNDcOThl1/19I1fEpvtXrhHCOK/Dy1fIBx7Se/FBOwNGmMDSocVYu6rusnoPqjfwLd065fKuMQobJ/RWnS9RpVUGRljCLkEpbgpmT08cVx67lMocbSMHPmxVHSaCDYhqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751952956; c=relaxed/simple;
	bh=/FrWVx+Ebw55Mgv42lc2rpjbFvwL7KwueNxjnO59wdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ccsfFyXThh9hsTynM3UNH8MVFiDTMeWv0AM2bcmZaiItE2BOUcFuNfzs9RWrh0ZMiidwG00HziY62Z7B3x3heCPTBkanglfb8mOw+ZRSDKlU909x+2vIfOBRvKCVyMY7wX+VxaZnyqvtPR2Fa83lP5sRfEBrLvPzdi6WtsHGqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=an7n/6vV; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="an7n/6vV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751952951; x=1752557751; i=markus.elfring@web.de;
	bh=/FrWVx+Ebw55Mgv42lc2rpjbFvwL7KwueNxjnO59wdc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=an7n/6vVnf3Fn4+i7dOBLb9dTbbbH6Nz7dOVAndxNSLOOe6gFcg8QiqfOfhFNvQo
	 +oElCj6k7tcKnnfCThLQhXc9ZqIttrElhBaYR8RtKeNN79PFtZOMheMqBrXOq3kS/
	 PpzTeyOpfNm4qw4zyP6q0oGaz9apT81V7pm1SvoWQ7dTL44A4DIRUpbE1oSDh7i8c
	 7PTFlE9h297Y0a/NA5+NyW0kXa08kYPC1+NQQaOoxNabpw7xWEeHmjaq+QLUz8usP
	 hsfVYf2Fs9+S/9QbaFOiFlRjS3hW/eWRC1ngbqeD5gtNpNNYENWrHJFEsN4FnN21L
	 2X/8MxK8cZzL5g1DYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.216]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrww5-1v2pPF3QUX-00byaU; Tue, 08
 Jul 2025 07:30:36 +0200
Message-ID: <a4b7226e-8069-485e-85c1-432047b847e3@web.de>
Date: Tue, 8 Jul 2025 07:30:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_How_to_restrict_command_=E2=80=9Cgit_grep=E2=80=9D_?=
 =?UTF-8?Q?to_the_first_search_result_per_file=3F?=
To: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
References: <fb74577d-f7b8-4fde-ab5a-5283e70b8258@web.de>
 <87wm8lo89w.fsf@igel.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87wm8lo89w.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FaznW78QEtxCAQV8uSL7aUCns/8CTiE4MbBZ3pruedFrVHYSBpD
 6cexbpOHFnp0waX6IfkzwgMiWklJtI2VKV3XkMOOljfGK9/BYdOqyDWcTsoae8PESICogu7
 46ESkN8J/yio407WlgIf8IYfaZt8hY//M2N4X1wIdRjBGBqL7StLHyipedCrMlQwbhl9W97
 YvZuPmwsEFQvroi1uevJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6NwWZ4UcBQo=;/nfrVicR/AvaPs4kK4qlFCx7v8g
 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

> Does "git grep -l" suit your needs?

Is it possible to determine such information also by a corresponding function
(instead of the mentioned program call interface)?

Would you occasionally like to transfer file details for search results
by other application programming interfaces?

Regards,
Markus
