Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515522ACEE
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496732; cv=none; b=jtT1nyKyVDpI5A3XcxNuXBXjFNqt13l/oF3MZMxoPwZsPg93+zWrT4ahWQ5FDK4wNuLWw1Ys8qF6Um3InPb9PoKsGzSi+cVYcFMXEiH0vh8gAFbS/4K2Eb18OwbGrXHpFmLdahgTvMGZWhHGNUAdEW2HVNSlPtzeARoE09KSjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496732; c=relaxed/simple;
	bh=OIDcR+5bxRYDq5X7fDLWN+ofSk1UN51RmDDHmRXSQGI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OpHZ/K8V70r7BtFej96oLpB0jFgxdttZfZiJVDpgWQITi8BFvUjaO153o7XNY1B9h5/bB3RI+b4c+yBT60scSyzmh/ckKqP5bR/cAos1eilkoHyU/sgp+YOrfsGH0vICycX9Fle7GK4vb7EPMXDDQrE0Roj7aABTv03AWec8epk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=Wygkdhhv; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="Wygkdhhv"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1745496726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIDcR+5bxRYDq5X7fDLWN+ofSk1UN51RmDDHmRXSQGI=;
	b=WygkdhhvvNnTWXTlqtYmjQiNsmD3XDANZMc/gXpxnyDaG4RcbfFsrAAhi8iXIzpu3st8tQ
	+WEtfd4+mwZkn3KT1fK19bmGnzOdfvbgKjHFFhMXh31uNZVSUkIEcz8KSWn1JFODg6FA5r
	qexXtdbJAA5rBWqHRvrcD0IMc8ykg9o=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 14:12:05 +0200
Message-Id: <D9EUY5KQCL4C.Q54QUC0YJV0@swagemakers.org>
Cc: "M Hickford" <mirth.hickford@gmail.com>, <sandals@crustytoothpaste.net>,
 "Shengyu Qu" <wiagn233@outlook.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Erik Huelsmann" <ehuels@gmail.com>
Subject: Re: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Julian Swagemakers" <julian@swagemakers.org>
To: "Aditya Garg" <gargaditya08@live.com>, <git@vger.kernel.org>, "Junio C
 Hamano" <gitster@pobox.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM> <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Migadu-Flow: FLOW_OUT

Nice to see this gaining attention, if desired I'm available for
questions or changes. I'm unsure how etiquette is when someone resends
a patch and who is responsible for followups.

Regards Julian
