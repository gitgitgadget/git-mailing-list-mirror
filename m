Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BF29D294
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880516; cv=none; b=dlu6mh8EUc7hbJPLL/vbqLsu5ULIFo89lydfaozdfKeXajcMT30WaFAdGfwKjluuNBMT6DNQxEinUcDm46QLF3TfEeTcVfq2g2jX4f5t9Fki+W+kqJn469ES4pAetnAMtUabMzioLLLMj953sTnqIN3ffHfXDsGEOqEQaj15Buw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880516; c=relaxed/simple;
	bh=F5kzkWtQdng1LTw7FVhNoJ7QK+dp6ynNz0KRBQ0iOtQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ozb0tvrfXsJQj3mxIGUiAdD0vWB1A+jBuOpUuYwXh28DfF0ujJOrbQbe361JO24Q3NCgIRF4WYyj8v8Qoth7VE6hhREHgo1AvMmDyQqv5pg57S3ChLm8mg6hI1553UOWTactTryxibQL0MJIeqYfyxLHMVgsEpuCDH1CDFU4jDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NzYgwwSZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NzYgwwSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758880511; x=1759485311;
	i=johannes.schindelin@gmx.de;
	bh=F5kzkWtQdng1LTw7FVhNoJ7QK+dp6ynNz0KRBQ0iOtQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NzYgwwSZRzfEJUd8wc0Y+IuhWIEFS1L1OWNy4BitIewVDqAwMllC841QL2Kwh3aa
	 q3TbTzHhTGnpZ8JZlLfJF2wM95D/WH2CpLicBOMW5GYsDwtwlCaZZTz3XsCFWKEUp
	 CAVR+rIjOR1G0ltcYK0+9ZCBx9yxKAdrWg0JFw5wxr3z6s4yctYvtSd0gnopOcU/k
	 GAqnFGHfw2yWWIp2qk1OyTKXyO0zN+LLRzMkWbIym6TO815q/0n6QmrxoXEFOu55j
	 up8UzkaTttv/J0M6LhLBuSXn5GHAOINx/aT/J6kyMKpWKsWdNkBEXmOxCqCmK6CoP
	 /PWMe4aqDc3hjtfvUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.228]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1v1o3I2FzH-005DO4; Fri, 26
 Sep 2025 11:55:11 +0200
Date: Fri, 26 Sep 2025 11:55:11 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nikolay Shustov <nikolay.shustov@gmail.com>
cc: git@vger.kernel.org
Subject: Re: git merge --no-ff failure
In-Reply-To: <5cbb5c0a-4c51-4d15-816d-6d7d4fdf4fe1@gmail.com>
Message-ID: <1f78a660-3c1b-7aea-5b3e-945ec2b1ad80@gmx.de>
References: <5cbb5c0a-4c51-4d15-816d-6d7d4fdf4fe1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NI4L10/m7bF8xtDFsY9GXfW1rBV0EG0OM9l5RXRxHjIkDcr6X88
 MvAbcg4/px6bVhbUW/OZFohlovHFd7c2MLxsBhv4WHK5okXTihbOXxgYFGkxQxdCYvvrLZm
 FnwFcNvqh3LoQEMGDBmAtiICNqAxe3k8qyZL6KKtxLRimy214t7t/aKh+K1Ejwo8X5NGctg
 5dOcPPgLAdhhg0fUDVUFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0d1Aqi/Vf4A=;ruXeZ8c+05MnsFC+j1CyFQt7etC
 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
Content-Transfer-Encoding: quoted-printable

Hi Nikolay,

On Thu, 25 Sep 2025, Nikolay Shustov wrote:

> Git is reporting error while I am trying to run "git merge --no-ff <my=
=20
> branch>":
>=20
> fatal: stash failed.

That is indeed a bit terse on Git's side. Can you still reproduce? If so,
can you run the `git stash create` command on its own, maybe there is a
more helpful error message there?

Thanks,
Johannes
