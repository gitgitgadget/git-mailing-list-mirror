Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795169285;
	b=31t5RfGq80LIO7Vu/tobrzoRiw0/O12cVHuydwgc8wPFAt/SF4SAbJm330ESErzcsGR6
	 NZawTcNMLdFHVIc6dv6j1WI/wstEB6Fkiae/tJoa3KbOvQz1E/BGO/btUVO+BXGV2uPbZ
	 PUkaW3bLZWpCp/AuOj2/l0APLVV/oPuP7D1qXYudOPn7e+wbIkoWje74NhPPItftanJn/
	 aRR9dw9x0dJPTqjkQ4w4ZuyJGSJqzMMY+jviUhjocyP4ag5af3a0pocKuUMsgGJifeyIg
	 +M3HuFK+VOU11EsSbCvgVtc9GASg6w/8q4JzhNPuy0D1leIjATG2aBnKANnsxORFY6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=LvfQiQRhv1kZlPwOH5HUwMSHxKcrYNyJ6j3e3pMZS+s=;
	b=XVDxImDpewKyN0bPehdBCGKek2LJjN6TO0Uav+lN4sEJ0fu3TdF3mUyanHO70RxN8zmV
	 Ca6Z4zGesWBZfvSG6dmP2twaVSN5S2zI08lY291tqjJyo1xhcEWKTvYsLG3g7h3lTi3fs
	 V9PJhU0u8O099gqUgUycHtBUUp5LsNwg4kdSv74kBFZpVLQC73qhR1cbToioYXtWaCS8m
	 zDreeWe6LRfMc79R64Hqo1e9UJmPKR3QhZ88hNzsYClIuPxgzQmTuVP0Htiv41yJXhhnk
	 dT0YjVEJOgQ69Okrz+tKJYyO/ELEFxMES+hf4vb6Ffnng7EzzFZ8D7Od6ooHaMcvrpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqH7z3na;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D5606A335
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1D5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqH7z3na
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-53ec2cc397aso547621b6e.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 02:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795169283; cv=none;
        d=google.com; s=arc-20260327;
        b=M0QMG4vs4Vmqd0oHu0nwwva0kmXyvRTKdkKSCRRYz/qTQl5N/aN7YkNw4TX36guLQz
         /YxgP0Ba0nDrFdXIsdi7pwWOKqQolPbls3q1doetxuebRPusWD1AtnT8PJ5x4SrB4Wlx
         ghFHpnqACBvsr9Ao3/ZriQM0xCTsBkx5ppRaOZpIwRbZXbvnnJUrh7J42XqmMewA2eFL
         45Jp1URtF0AAk7pSC3ux1IFOm5ZjNpwGPUCGGwqxFQqzO3Sl0pyCB4bQgFR9zKaBu+gu
         h+VGDJt8CnMknDbMgQGyb9XdprshfJhyJjYfSAGlJo1H0Ne2uYk0YIdfgHK+A9SR6Pe7
         3e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LvfQiQRhv1kZlPwOH5HUwMSHxKcrYNyJ6j3e3pMZS+s=;
        fh=cFmPBCRkUlbdViCibjE6uk5A9Ac092edx/tETJJ9PM4=;
        b=FvlNQW0gSvOxYz3205m8dz7NjRAtPuyJdM2VJitoN40IWmv+7JOUK9W5CYgdw4EtUa
         1Nt7p8B9kn6io0Z7tL6rVdpCCYiRC/8vQfglJLtLafAzH9cwpU32EZ6L+NmITslUnHU7
         So64EqUSxjW6ttLF/tdM2SqLcQez3d4WZmD+oy6dXuRtRli6LSZliYnbDtdZra8dJj6Y
         CI2+fcDGvBmIFIiB5b127xH/wn94CduUdsz9owQrXpVznfdLt009I0icPkUM3LUZgjq3
         uQ2q0heGNTyKB9QaT59T2mT5C8teViD1ouJQlcpRP28PXdUQo0isdbwkWQh1Zov6/rI+
         zEjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795169283; x=1795774083; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvfQiQRhv1kZlPwOH5HUwMSHxKcrYNyJ6j3e3pMZS+s=;
        b=LqH7z3na3vghN2n+5JRtjQ6u6YVTc72cpIP5jYQhnnH2PZtqyl602VOVwCQjJXzGcb
         MQt6bYvzdgUHeqYbz57YHdsIcWpTN8qYZYUE8PL7R/4HWVCEjNcYm0odOxqy7dt0rcXl
         q+KWh0iQ8aenCZZ0v4riA8VZRA5r2Cb/bjRUUCLbJYBWK0d+vJ3rTiH07DgeskYnzNeJ
         i51KQMMKElr28iqXuKaKefvgJJqfLMkmY9DVp+yNP4SpjXRsjIzFYAv1pqvl3LuLFQPw
         3Zrdvmih9XhpSSXdeqF3gost1Sr8fforX0fn8dnVe9+T8j05ggxYW6V3VLRXkx7xQ3ll
         7xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795169283; x=1795774083;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LvfQiQRhv1kZlPwOH5HUwMSHxKcrYNyJ6j3e3pMZS+s=;
        b=DPFlaqn2wcmqlEUROizRVWANawjL1op1ERx+QvcETGQ7k6Qsonb9lZiB/OqBPoEIhp
         k5SHKlEhsvHBjRIK6mDMvQuSXEpIs99fli5/lG5Cj+xbJ+D2dEmzo6le61JrtnJycqFD
         AW6G2ZxSoxF7vGeQgPVNALr+pTWCd9pb3PmYTqV46UBNILDwA4uG54ftD9941rqC2scb
         P98L6dZN6i9Kg65PIEKWBZra6r3w36RdHvNZKdIKHXdDMH1NBZyP7xZhEJEU3kpYFbxN
         cV2ywFlBfSVhmvnYLRXPa/Zq4Qg2dRJeZEpqhNzdIEOYmNPYcUnxXyKK7u4uGyn+uYZA
         9XOw==
X-Gm-Message-State: APuU4Z+DibH8xnmtCNfT32HCUgN/ZCjJnj8543G9HJhl6Tk0R9nVUnH+
	mQ0YW/yTJ8irF1XQ53QgWhFZghHMSUag+wZRUTwruBsdGKUc+2SeA9NDfbmSsEWIlay7DhRKrAh
	+4ylgiBadGERSqyx/41apn4Q4eaMnF00=
X-Gm-Gg: AYBFou2gMX6L0KAZqgMbKT/QDXpq3eHPV3K1iwKCdXBnvyVwvaHtCMex4cu/NEa2SWD
	QUMJ6GAsFvxvmyAvivv/2S0jeHoUG+cxWIefSH8ihq6e6QrzbMDX5UkcYSyWvQaa9RAiaM7TE+1
	JhcxFdISPjwQRzQNQkLH84yhZaKLsswp8kbho0H2Tz+8hG9CwT6LogzG4ChC94c79WnBwfcuQ0k
	0nsLGU22QesVlqzxgdbrK7pXWTZOVIysW09AJ5XS1oJlPGi7nBwaGXHcdTzC6lMSMFMBE9tlEYe
	sQfpI5/Ea4SJLht3eeRh0cZnIvR/AY4G5UCR2e15A79tHxFrPaWTUE1YsVs1EQ0KsGnAu2CSdkh
	D6RiqxQYnvH4uxty8T0ABkpQXmEJ0k2Y18D+PYsfcsJqdo3AzYOMgkevC
X-Received: by 2002:a05:6808:c168:b0:4b9:e6ab:d07b with SMTP id
 5614622812f47-57a0a40a176mr3116626b6e.27.1795169283503; Fri, 20 Nov 2026
 02:08:03 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119105300.95746-1-okhuomonajayi54@gmail.com> <20261120055908.83043-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261120055908.83043-1-okhuomonajayi54@gmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Fri, 20 Nov 2026 10:07:52 +0000
X-Gm-Features: Aa3M54ptk76KMK_9nzAMSjTq37wCSVhrDHx0rI54Jfd3DGGCatE-Zf6Exp_UITo
Message-ID: <CAHWeT-ZJHZrAtVEC+-WOy0HPRZuepdYVzPNw86DcTysf5z-gXA@mail.gmail.com>
Subject: Re: [PATCH v2] doc: wrap emailed text near 70 columns
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Okhuomon Ajayi wrote:
> CodingGuidelines, SubmittingPatches, and ReviewingGuidelines do
> not say how long an emailed line should be. State the limit in
> each: keep the text near 70 columns so it still fits on an
> 80-column terminal after a few levels of quoting.

I'd say "to a maximum of 72 columns", to take out the uncertainty and
match the convention for commit messages, which of course are quoted
in the same way in replies.

Andy
