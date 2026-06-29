Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392D352012
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741440; cv=none; b=nLBWqr61KaUyRzerfbHXS9d4TPqTWFcRG7kag5r83tnhMFNn3sTDOlNhkfGPj9HYon0gN/41uy4+y1iOc34BXc4rufYo/9Ppt+03o2D2uJqvPA0SWNV1AImuIvNo6ug9dGY2imdFJhMLzdCU6Gj+eClw3B3sbNvTebN09R/WBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741440; c=relaxed/simple;
	bh=g9OLa6dDTYI9MS96rs7oEZcxXWnFRhvCqunEsw7b98I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JdDtz7pNBA1cz59AJiO3vMrRZiJKeEY7P06+JISYITgQdYQzvuT6CyUhXA/dWbdRQ3BZgTGtoX615UgkbhnrWvvIQFKDUUBaSdYnlIrICx3faRof/aeT62us1qNJn6oyoN1sLl6Kp+6SN6615s7XSw1wNoFBKA55xT7B4TOp1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=FbiFxGor; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="FbiFxGor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782741431; x=1783346231;
	i=johannes.schindelin@gmx.de;
	bh=g9OLa6dDTYI9MS96rs7oEZcxXWnFRhvCqunEsw7b98I=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FbiFxGoroPP/3d7fJq7Ew3ziqsbsej8oMNEaxrxiB+sfskIOXwAffuGNnX8S/q9G
	 t8KW+oglsDBr3J3wzPteLzv9SWhFoPeIRnznLIR/HEpkpsQsnHOkSbGNEuFonp0zv
	 HDpipEDpMOK6ooWDBx1PFgPGVv2ocf5YCUj7iPkti4P/tA2tgNFIRatgBcOrhnkot
	 3XL/6pQ5PewwNPxuXSLmqSgsxt7OsuTY82R5HuwzyRk9fz4evzWKwluvLNA9a3O2i
	 URXCOuuLSkBbERZJNbTRN0RMuuwWlwPR1QlnyW/EGVdN4fASJUReSmDXYWHrXNdPi
	 rphu71Sc6LerGKmPqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1wobnx38LC-001ePv; Mon, 29
 Jun 2026 15:57:11 +0200
Date: Mon, 29 Jun 2026 15:57:12 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Person, Tim" <Tim.Person@personent.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status
In-Reply-To: <SN4P221MB0713994458A94BFCB51F7AC494EA2@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>
Message-ID: <fe8a3a3f-d762-d2c2-9454-a57ac9a75331@gmx.de>
References: <SN4P221MB0713994458A94BFCB51F7AC494EA2@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:nufrbxQhZPFbC2vuaomaCONjXFe09SpcyLoC20PJHFvXJZu0ijt
 PET/jcR5ZujOePQcPhv1Mb7a+9Akko3pL1YFAR+YKKLy3ESgvh7wtGZUxhYl8sJkn8dtAwu
 DU077yK682BkA/qA5lWzHv9hDQUNfjEuVjQGpeT7ufUU90T8ygvRFpN63n4e4KxpKH6jc9u
 WvmyaDVs2C4/ZxNZMRXgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JX3olYHJPdc=;5+2v+/avjdBBUu0CiCNlChuR+0W
 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

Hi Tim,

On Sat, 27 Jun 2026, Person, Tim wrote:

> I am writing to determine when Git plans to release an update installer
> to patch the security vulnerability in Git 2.54.0 because of the
> included OpenSSL executable. This vulnerability is rated "Critical" in
> the CVE (https://www.cve.org/CVERecord?id=CVE-2026-34182). An updated
> version of the OpenSSL.exe fixing this problem has been available since
> 06/12/2026. I am just wondering if/when you plan to address this major
> security issue.

OpenSSL.exe is not part of the critical path of Git for Windows. It is
merely included as a curiosity for historical reasons. The critical CVE
you mentioned does not affect anything in Git itself. Therefore, I did not
even consider making an out-of-band release of Git for Windows merely for
that OpenSSL v3.5.7 update.

The next Git for Windows release (v2.55.0, likely due later today, may
slip to tomorrow) will include OpenSSL v3.5.7.

Ciao,
Johannes
