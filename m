Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61816EB71
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864303; cv=none; b=MlBtEFosNldKmnkoKEbasIwLxnNvFH/c+WynIW3fGXBmSG51A/JyM8zcOWTGKpFxfsgz28f3dZUqOGHlPrLo0I7wJLZ8FRxZeC1tQzDsZEFRO+8BqpkKq9Pvhsdi0IT34M5yOoCwRtejeAOyPu5D6uG0tuzyX14YgfqTqrExyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864303; c=relaxed/simple;
	bh=C8xUrvIftfFy2Nd1V318yyXTurzkIj4447sH4HUGI3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eoeJ4c5m8kaLBYvQx2UyzLefLmNyyZ5zaBg4kEeKppcd1y4oGtRQZzodqAyaNj/gNCe/DNR6CmB5BgEVPik+s6nrhywFADblmrEKsQlHzz1tjOynunOu3bVee44EREysWzoRCnLnNCYA4m5/UwrzQ/6Ffx0BpfF6AOo3x7V/UEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=N6iFdhgP; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="N6iFdhgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719864292; x=1720469092; i=l.s.r@web.de;
	bh=YFei5lC9hegioVN/2YedXhE168wFDdBNW+vUpSWChtM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N6iFdhgP5Q7btdphz+d6e6oKtC2LSoYDuoPAtl/p2VCyMysPwtGCGIHH3/O/VqQa
	 sHpoO7o7xBK2F6F1NkHHKXTn8HzNaRNvfA0+BhmOr4Pnu/lKzxIPU7Vh3ZvPAR6+v
	 GlPe6Beobh5lH4XJkTgUKbj75c/kek86VrQ/eoliCokh04DdU9v6xcOml6/4v/9Wx
	 bZDEZhmlWgByZcWbR4yfHzaxInFgo93GSwZhU7At9OW32dCOOYSDn54kJTsrYjtri
	 8I+KoQFx9n/5/QufaeZKkHn2XV4HaTqHTAfxInkhQ+SX1xuCjN2ttwcCBZybpnySM
	 233LYN7SpqurjDkWMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1stIBQ30Ea-00K39l; Mon, 01
 Jul 2024 22:04:52 +0200
Message-ID: <1a9c7351-68c2-4f2a-b00f-b4c8422ebe08@web.de>
Date: Mon, 1 Jul 2024 22:04:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] t-ctype: use TEST_RUN
To: Josh Steadmon <steadmon@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <abb96bfc-ed97-4c8e-a99a-0dadce45398e@web.de>
 <eh556xjlxipeyumm3gchiiggyogpcuznil5kwvudcpyecj4uxq@uy5tk66blzsl>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <eh556xjlxipeyumm3gchiiggyogpcuznil5kwvudcpyecj4uxq@uy5tk66blzsl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bxe0U1NHGovIiEakfRe+mT+2rYeycb7s9Ble5bUOFytHCI6Wkxk
 y8SDfN/ZA13E8LZJd9Ng/9aIoyf2MAPM3RiVNG3q/OnLtbO9si/FzsEm5Kn9Hzap3tGK7Ge
 eCCwCxUVcPlDadsEui+UUv3eiMOX1vO0MihaqpN64iLr+RW2BKeUfMYH5r0AecORG3VImPb
 9e5SJGbXLfg6FxenPOwQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S5Fc3VXdvoo=;XgHSORXo2wVcNiscT22leT+xfWx
 u4A19WBNCQpNszofI0imkCuzRLOVkxtA0rclqrvo10uIJPowt9jhupBafpMph0FzJJTCrrGZ8
 tegxjVlUXpcFLWTNt0wSgNp+xAdp5AtGwGAhC7JT1z8M9pacVK4+v9GGxBwQmpFW6teR6XxYy
 60l5B1CWMQaaJvqg8n/ZVS8a0GDG7vWPT7DHjD+VhsD7yqbwAWEbnLdliQfRz8bRcvXsl9Orj
 S2GAIG0ZwpNi8vwF493BJAjjrGqQSlOdnO+CvcsZeg/hkjfYS4n6BsOffQ6GTwCof/dZa/eD0
 bccw5DjmpAeakvlIJv4xmCEtOhE4esoBo96T+2enTfnQGUQFogduziG3iN97o/BeSLViccjqf
 BaRfOHA2oaRmCyvxtTZtvR02pN7zN+yxj3sRFyW/Za8hAs16ojQJdp0CILjzV3HkOvyTx6aFF
 uKkOq1KxHpnKQvjdgxKrfz2LTaSV2HTSNORj5AYVULXIvrzK/h5LJyGXtwgA7L876FtpK81j9
 BwBZSSFXddyclPVghu8uG4gj1KcR5Wn6LPuM+N9eVHWGxSdOvU+e2yI0J86/GhMwmi6FPrJpS
 9SPm3/A2a0mE4tpTtHkVZclnWWx9Nt8scc0Q63CJU2wjgE5cAp+4w+TdlroGQjJpi2df8dprK
 1zOCYWI4SGn2bYAYrzd+oIuJwfKZ9khTZsVaR+9FCogaU44p2O7R67h2s5Y6Klm74xHs+vhFJ
 vD0mr3lRgAtLk6qyXPT7MJFa601MpWBQAIRmCXj73/A5LXAV4D0MlNfCAsWtxIVId5j5/Al33
 0bsGBqupHRb+U0Uwt1EnuD1STSP5HCrb+3gzT0JpnQAc4=

Am 01.07.24 um 21:49 schrieb Josh Steadmon:
> On 2024.06.29 17:44, Ren=C3=A9 Scharfe wrote:
>> Use the macro TEST_RUN instead of the internal functions
>> test__run_begin() and test__run_end().
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>
> Nitpick: please expand the commit message here as you did for the
> following patches.

There is not much more to it: Use of internal functions is discouraged,
so this patch replaces their calls with the new public feature.  Perhaps
a "Kinda-requested-by: Phillip Wood <phillip.wood@dunelm.org.uk>" would
be appropriate?

Unlike in the later patches the tests themselves are unchanged, so this
has no consequence for people that want to add or modify character
classifier tests.

Ren=C3=A9
