Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96A639
	for <git@vger.kernel.org>; Sat,  4 May 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714813125; cv=none; b=l/J7Hw0JOYBLR903978kRNfU/6Vim9KcCEMsjSlnCXxWl0Lc6+AkxgiCckHf+rz/4dnge1VK4Jvmj8MupMAVK2aex0YtgeviXDayLBN65+3v0PlgYWzm2Ga0lkicLGtQXqjYaQB/aEwBkOmUKWY4Iq7FtgKazqqBAhlkG/SAM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714813125; c=relaxed/simple;
	bh=t0XxxWaCw68wFeTQbZi/YW6OCYJLukh5ATxJF0cbdqU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F9LFNhDpIL+tJLxKM8xVfUdG+q0p2ozJ/gqRKCfyi7atGwTStOMvIZotbknZMSFP+t8vF4QhmGJ7VDODfH4+hKt9Xfs/MFS7AoRxhbhVbYaYuFYgzKAh/+0k3Z8arotWiu01wHqcO5w5DaTOsdMZ3khu6GfXK91VN2ad8hexhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=sNwA0DZI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="sNwA0DZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714813118; x=1715417918;
	i=johannes.schindelin@gmx.de;
	bh=BCwRy4vSiZaA3v5jwGk/31TQbdBioUFW4IWVo9iTFcg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sNwA0DZItMSpyt2Qymdf4RdyipVdzSy7dv4IZ3jtSB4dVkwPgEjOMqGiX02eJptU
	 mc8Rh/oYOIgVmlXOcEbzZPbxNbSw+RBlR01OhPC2ig+Q8dZi4Of++im6Y+0+t0sqz
	 VVUxbg7o73D8ElNSbnsF2CY5gXbSqc44wQwaxqJdHy9vdUaiMcU+4ZJPSJ7gr9Gyn
	 M/aRCEOPFBUcrcnzFAzUV1Bt8YOKGraGI/ux0oXFKW4wq5PeTEkrSGxrI9lel3GXx
	 AGOWhHoHNupLDGmNz3KCzg1LZ/mXsmBV08eIbNoSk4Zre0ZK0tQOYJmhCZEpC2lpQ
	 mfL92ArD4sfVM/8sYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1sm22E18aS-012VXV; Sat, 04
 May 2024 10:58:38 +0200
Date: Sat, 4 May 2024 10:58:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: ds/scalar-reconfigure-all-fix, was Re: What's cooking in git.git
 (May 2024, #02; Fri, 3)
In-Reply-To: <xmqqa5l64e0i.fsf@gitster.g>
Message-ID: <b5226d6c-8038-4ab3-6e95-1a262282dd74@gmx.de>
References: <xmqqa5l64e0i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wi37t6wTmE3XJcHCc9C3g88dNj3sOJ71NK+ltrIDWw13Q/AQjeJ
 W9erzCVQsQeRdm0N13B4d+BNidmQ/kOCmx21rQaIZjUjpdKjwO+o3IiZzghxa6y+u+6BJMi
 GaJuXvlwPjv8xUVTi3PWoc0nos8BFYOsVkDGUzj0/G0Fp+CgdYczDuBhc3y0WegOcty3hNt
 Pu/XT+J+Ozp9jchDr1RmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2AMPMa/Qhyc=;NGule1foZB13Ly+YbnHGvXmLBYg
 fnBCDv90Hho29ZQkr/ui6BsO8pHfX0hRvCY9Iz2HFo+HkWMf8E0O/IdTIdJ53msdvzNVGphXM
 JqCXi19bKZK3y/hr0y5LZgX2bDza6BjKVhSiWBU/Z7UPNSws6eXMFFrQDJyPZy1RKHYkGxNBf
 SoLFcYEcYjzWAhGLrqSIoIRciTaHUkpHeMSbrZaN268tbxb/X0slR/snyxXpzjE1plbgCOrU2
 tHvG6sx/C5Pjgr9pDKu3qJoRZGWRivW4H+GpFBT3yU3Ruc9vAvtbh+0jpUCfBsDEN/3Enmm3t
 /8o/vfsXht7j0qjiZISl6ABW6AnEKOfPti8DfVWdUQlg2JfMd5Pl9coV/8TKYKh9O8HoEckdz
 9+qvjwfxG9cgR+xvYwHt6K4Ga3cBSw0Dq+P2t7ksZmpNqgsa8rMwyIsQICLoHOJJSC4LAnQlp
 CwBI1ZxGK/8SBxRlOYO9JNXjZw5JOwNkBoNFr64dKeLR2lD0D4d1WbUnVpYLL5lt2KvXZOQxU
 qFAtXlpA9S4BYuG1a/u/iiu14NZNJ6P1LvhPY3bzg3/icCojvLWrrG0PHIFw+BPu2Ep74tT12
 +jGeKCRL12HtHJXiZfNFGPPQ+h59tpcUFiBIvHvS/Ec3hp3BPlfOh/Bxe54aFmAGItrXL08/e
 OeOl3exy+/f5AGLlEdsgk8P9uGNXWlFdXsCTgA3MkDfne3WGHP9zrzjU4ZcpfSfYInvdusuq8
 S3p/rPJf7p1NsxM14CQmwL9kDTCPAoTpJixocc8V2nR/5LSEJPAkU8txV/SbF40KnOsf2l1d5
 uTFZCkcxlUHq2krvihDINTtORk4OOvplQas80zksuApxg=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 3 May 2024, Junio C Hamano wrote:

> * ds/scalar-reconfigure-all-fix (2024-04-30) 1 commit
>  - scalar: avoid segfault in reconfigure --all
>
>  Scalar fix.
>
>  Comments?
>  source: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>

Patrick commented on it in the affirmative. I do not have anything in
addition to Patrick's comments, except that I agree.

Ciao,
Johannes
