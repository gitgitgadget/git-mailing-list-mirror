Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870661;
	b=VOQO04YEAoRMVPRrgdjP9rWDZ9Qc5kWFZQrsk4b0LerdeUfjAn+l4BjyhJB+mt4yZu2R
	 Rg56Aa3/cG0Wc0f+P2C4vvEAeEr2SuIOHAN1Srj1mkQUJo/DXviuEmhEduo9niA7s/L+Z
	 XhxO9xw0nP8Qyu7Hbh8yqTYqA2qXC4GdlFUDayWIS0qWzaYRu+OrRLjrkN9VgBYr/+Ec3
	 M8u5/CbswW8V2+TABUNfGfaRNKKIq1fZGNSezikOeGie+Sz6H8+lRjozX8OGGjqBubWSX
	 RyUHvogqGJukeEbvWjdyu6NMHbLT4240fTucvNWDzra3wT4W47bODhjDRqrDy0cGYow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870661;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=39YX0hhssMSdpGRqVJpAVsggIdyZKuYyRNupZu8Gz8k=;
	b=lKYf6ntKjw1XXuW4+hFx5aa0Zb0iDqgyQ/v3Djr1i0OKTgOjH8V+isWkPCrOLxqTpv6J
	 i9JuXx30xtzGUg2vXctmE1tozLz66jx9wd36pe7ZOrRMyIc8z4vVw7j1d3kDpnzFBToqL
	 QS4vRO05xV7uhkw7ulh1LkOK7K30Ni6sirZ6xwJyX4M/DgCwPUu3S/AwdEySfMKoHP4wW
	 dwmFcSZF+6DlrWyYpsaLlLk8LWsDbZYS/3bYd++nAoNiEhRxGwYUIM7+a97jzUdYknFhw
	 RmH8GYviUoKiFgdKUE/ZMkSv0uNXF7HcUbpNa4CWwojiF2pcd/pNTHgdujlmK57u76A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=dy1v4Kqb;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F36606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 19:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F36606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=dy1v4Kqb
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 69OJbWqI021341-69OJbWqK021341
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 24 Oct 2026 22:37:32 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xKhYa-005qP4-Ce;
	Sat, 24 Oct 2026 22:37:32 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 24 Oct
 2026 22:37:32 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id c1dad575;
	Sat, 24 Oct 2026 19:37:31 +0000 (UTC)
Date: Sat, 24 Oct 2026 22:37:31 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: <tboegi@web.de>
CC: <git@vger.kernel.org>, <ps@pks.im>
Subject: Re: [PATCH v1 1/1] t1450: use mv -f when overwriting a read only
 file
Message-ID: <20261024193731.HR-Ro%taahol@utu.fi>
In-Reply-To: <20261024183056.6342-1-tboegi@web.de>
References: <atmvASAoaCIpc_ca@pks.im> <20261024183056.6342-1-tboegi@web.de>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-15.utu.fi (130.232.247.55) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhRSBgbKBgDG0YBBUhYSFpIWVxI
 WVtYRlpbWkZaWF9GW1hIUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIUUgYGygYAxtGAQVIWEhZW0gcCgcNDwEoHw0KRgwNSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=39YX0hhssMSdpGRqVJpAVsggIdyZKuYyRNupZu8Gz8k=;
 b=dy1v4KqbPvaO5ug6JwZT9zGX8jXU6ODzz8Lzxilugd4Wd/mjn69dPIfn01byPcwwuwObgOiMUDRr
	pgXhRM+Y/GGZFn27ZjaQRginoM6VXZscLsW4bTUXC/Ml/bdt0z+vM29GE2irc4bx7fclKrDoxaIL
	V6sN1RNvI5bziCYhfqxof/4D84+aooX06OntT5a/Dz8vRDy7zsKEeTvyHXFHzWbSwxyOcJGYTMdL
	mRuconINjz2tF1Taq+GeLTCSf8opKhw1HV52Dpep08IQXULQgmPYbIwEVMN/uq1ylMwR4f64Xk2b
	U+U0KRYSZXnzCBhYV6kSPx/MN2idyO5SN2ly3g==

tboegi@web.de wrote:

> 
> POSIX mentions that the observed
> "prompt to standard error and read a line from standard input"
> should not be done when "standard input is a terminal".
> So we may blame the "standard input is a terminal" logic to fail.
> 

s/when/unless/ ?

>  		test_copy_bytes 64 <"$obj" >obj.tmp &&
> -		mv obj.tmp "$obj" &&
> +		mv -v obj.tmp "$obj" &&
>  

s/-v/-f/ ??

>  		test_must_fail git rev-list --verify-objects "$blob" 2>err &&
>  		test_grep "hash mismatch" err
> -- 
> 2.50.0.rc0.46.g7014b55638
> 
