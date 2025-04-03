Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242571F8720
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682373; cv=none; b=pGP6QcZOvr+SNpTxZSZEQg8dhogsMc1XhrNIiGEPvAXZgHV1Cni05ZiSL4JMZ7w1i5By98pRuQF8N9U1mx44aR11UPK1rUb8oJA9J+pZuc2J0R4RclUuemsZSzTr8i46UkU+qmHOAPpaPInSyKSkA0cG0nS9Lq+bFY7JRPWyhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682373; c=relaxed/simple;
	bh=OjLXyBh+6DCwBs9UwvPjazTVbn6AuDEF08A8ddUyuoU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FpXa+fWLHvdnbIOq7wbs1zMqGjTUrhbGUMO+nK0rONQhJvvNJlbXYXSTxmKCdTn72e549wUXrT4maL+dITVmqkaxPlpi/VhQ7qW51wFHwNpls7xIjCnKK5sIsGieVpZb2sRK3gdmx8wZMWsP5l6zvFFzDxkFB6IhjfLgjsqHvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ovF6bH0s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ovF6bH0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743682369; x=1744287169;
	i=johannes.schindelin@gmx.de;
	bh=Wr+WBmfhFbaHiodyvn+8iYHFaN445q8VwA77oKlF7Zs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ovF6bH0sQf967Rwn2eP7m24Ns+y/wJ/ojdLNni0IjdrKGJfZLxM2CnvEU1A6uRQW
	 6TOjn5E/cc+nyMx1FdkxsgS0t4eACzE/n9t7la5MzyGC1WRliEVlF1bXSqc/Xxc/+
	 PlhuEje670IFMX92DjgqegdtcQ2yocAOLr5gV8+ANMzO6YGCSTb7oOnYDhkZmWmHA
	 9UA0GG6Sd8nTliPxVyjTfVMyugXqpJUr/Tdhyoaohmr2KQ92pvfW0uv3W0ghaHII/
	 DFdFdHFb8QBfzSBkkbEwLypcDa0M1mYIu4ZvH7kzpFnOxSU8+f47LKLHgDneYxzCa
	 Vdo4SQ0WhdFf2/aTPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1tkopN0M8G-00M7eK; Thu, 03
 Apr 2025 14:12:49 +0200
Date: Thu, 3 Apr 2025 14:12:48 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 00/20] t: drop Perl as a mandatory prerequisite
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
Message-ID: <5e00e50f-e2c5-a633-28ee-684e5026e92e@gmx.de>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Bhmdy9GzzbYOArywmE5i19BS/4Wj2ZsSp/S3jLJowYPND+rI4R5
 74TXL/e8Hb1Ed03/vOcUBHTzBGQh+bBYMKVx6ooW16zAtDJyL9BkFGalHx9orHduCXT0Wyk
 GYYas9oozbatE2t/GAGFVAx6kw0Rx6kSAO6+pdNIxo0aM217conony1YPp17/Kjusl9d0EN
 HrqoUv3NqXB+EvDLeSKQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BqtadnRGfpA=;ysKq9mJHmYE8AM8/l4I44/rfqjk
 sJ3/KdfS1WcG3kr95a5tKlvZXH3Z+6w7rQrqYW6IYcaCbvXCXoekh1hV6cg9JHtPcxprpYsf6
 UVV3Gk+DcCoXVzgwjux7qXyJfhtJqcufThCozSuToR+Pk2u319IhOGHwP//jKPt++t4Nkog8w
 XzFNM/G6q3/c2lReoRPXcmutl9dzI8dA1YQHHulGydA/w1whnKk9NuIfKE6LkDI/N/shw7vOJ
 xVGcP1KzFEvBia6xNJDpJk1aeQvrFWsRAiqmO26QTBBWE5lifQQUd4nBRYa+BDmtO7lHYIdsm
 TQ/vOuc2COC4BybXhh9NW9Bto/0/oi95CTBCVUTNpZIiHJgVyrYI2ed2K2CKiudS8upKP9/Xa
 PRSJqe0yvVtinaebBIY+zh/wwlrpe3tVQ7NcKPR20/Xm9YGyCDTzO08onudEzHbJihgVcD+H/
 kCb7ps7V2swIP/fdhN2Jbx9+f0mtJjjnh0BILsjx14R/0JaOBWH9RpvZdbLs5jouohph+BRvy
 J6f7v6hDW1ab3+iXO+qKjn1QRqEGjZj9u99/GTMtuZtj4UHhQGCf1H5JstnUuKGqXh/B62Y06
 BcSuvk1/1kUX1xcRzRU334TXk/ocXZfRiaF9VFSR2wToxZrJuDkQrSlagk86AOt1FPI0qk1td
 UqlT5AAmF0CZtSc2n4vD/NtHWCV0F9Vd3tgIGwGSGEG2smaD8AdyvfvJkh1nmEDxCl9QlPJE0
 am2r9fCtuUWVl8kLIJ+3itJPob/Jt9/pyOT00wjKyGIKhtnuiP9jm4+6/CbC8BIUUsw+tFRaE
 BH573CrvHFlqdg7a7h0H3X/KAt++eNG19Qs/RdIu31ZROvTVP54vx/NVTipx2pjZo04K+STdq
 V7qxXm/xyoa0cJCuHbcXCiZF2ZvA7UDEMwbrf/oYP6+zMEJvMvr1v1o0PbFWykjwqBLWo8kmg
 AvgIn4u6t/9w8rYCcSxKqadEyWSD7FxzktsOgms2+EUXFcmVGUxUXKoRoT5Mp7NYHxjST0Aoa
 xCtD1//t7qqRtTreDlQFPcdwxAa0SLP4xK81AVBrorGUWqbdN+P0uAnA4/fnpmePCA5gCVgCR
 Y8WBZ6+Yccrh+rJhwIV5DILe0BGPrz1eTKPpgl/aFnebfj5mzQpfyfSiyDZHNfemee6edHYdT
 JjtRZi1toYPE8+SEZIzLXPTuTDUMukPMO8Y8jIrKpPkjKYqKPN2bjIxuM7v4bgsLAjWmGI2XQ
 NgzP7di6YfMmvNXuGcuh7k2XbXSoryCflXpN9YGmnFN9ygi5aC8LS9AQaXQs+ffefQA5YjuK3
 c6RebE5DXCsnAwfyrblTniaavuOzDS5g0lnfDv/Dwk3XzL4SJIElI9jt2U5MDOYNQphK1/faJ
 VIbSyiM+k1CQXrrNQ5EmN5kMoTQtIVylVDDYoBGtdvYdGvmntWDu2EIri3z2XdL193SGIa8j3
 o7Nza/4rNia+Yrn88nA0nX7u4sjJ8UAslt2uvKXF2EzQ9BFNc

Hi Patrick,

On Thu, 3 Apr 2025, Patrick Steinhardt wrote:

> Changes in v4:
>   - Improve a couple of commit messages to better explain the changes.
>   - Link to v3: https://lore.kernel.org/r/20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im

Looks good to me, as well as the range-diff.

Thank you,
Johannes
