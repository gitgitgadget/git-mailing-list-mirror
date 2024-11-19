Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC538528E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044242; cv=none; b=l9uVyx/RxUguzwEiTWypBBQQzfiWdcux8lnFSLUZ3IMFb7omBR01gid3bUFjdDNpxEnCV3jws+EsVBzUAJkTtzRi0ZWPlnKE7uPnK0Lu3aaInzaHKyjoYWUeT/qjjz0V0SJ/db/SiI4hgZ5a01CK0sYP3kCDnceBEsUHZnNRtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044242; c=relaxed/simple;
	bh=ZevFsVmZUPGUv0wdgwKx5eTA++rg7eAfec3+wt3fMvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMECKiJ+wHPRPCd/nIwSzFXVXfwfOAS8h/2eBk3dTDDm7aGbVINcR+GX6M7SPEySbsQZJUrylZquAT5TaFmlOapfvld3F1wxaoojMZVygoXXF6kwBSdhFymg0Mx2FwdOgZN7y+f6NssANXzsoK1XmdhzFXa9+KjY7hNmwrS1ucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4XtDtx09Ssz5vKQ
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 20:23:52 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4XtDtM3Q5tzRnmF;
	Tue, 19 Nov 2024 20:23:21 +0100 (CET)
Message-ID: <7b826bba-11cf-4f45-8292-937522dbaf29@kdbg.org>
Date: Tue, 19 Nov 2024 20:23:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/23] Makefile: consistently use @PLACEHOLDER@ to
 substitute
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
 Jeff King <peff@peff.net>, Christian Couder <chriscool@tuxfamily.org>,
 git@vger.kernel.org
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
 <20241119-pks-meson-v8-2-809bf7f042f3@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20241119-pks-meson-v8-2-809bf7f042f3@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.11.24 um 12:50 schrieb Patrick Steinhardt:
> diff --git a/gitk-git/po/vi.po b/gitk-git/po/vi.po
> index 59674986604891d9901e87c163e61dd39db14184..184430dcdeea7cbb76895840f84a889b6abc20bf 100644
> --- a/gitk-git/po/vi.po
> +++ b/gitk-git/po/vi.po
> @@ -5,7 +5,7 @@
>  #
>  msgid ""
>  msgstr ""
> -"Project-Id-Version: gitk @@GIT_VERSION@@\n"
> +"Project-Id-Version: gitk @GIT_VERSION@\n"
>  "Report-Msgid-Bugs-To: \n"
>  "POT-Creation-Date: 2015-05-17 14:32+1000\n"
>  "PO-Revision-Date: 2015-09-15 07:33+0700\n"

Is it essential that this change of the gitk-git subtree is included in
this series? I think it does not hurt that it is omitted. I can pick up
the change and apply to Gitk independently.

-- Hannes

