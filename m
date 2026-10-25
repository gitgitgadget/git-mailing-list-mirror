Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792915153;
	b=AtzDemgqrqOwOy2HH15upih60hZWpGRdhVXA9tdJwE6CKmALPCt5vStDGNtpfJDPo7Q5
	 +SfmNFvOrIw4muNY/gKpJ9o77joBDHCT8sV6he2q93RZYLoY0BVR0SZyKUG62zh3hWxEZ
	 mdeLJlgO4gV7j7mv0JIBLSmRnv0UeBZzDIXkUOear+MEoTKeL/+rSImYGLxlFmu0mu0oY
	 RVhkAfoB0Gnbrgp/d0ec63wFmutHITjp/413fo7sWuG03v6mo9l0Yx7ZFj9IUUEQQ3whr
	 GZdMHKVqH3SEu0tBte1t8JZ/YkqNtV4OFE5wQj3Tn5jA/QiBjtfDLWIqQtgmq9y1BWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792915153;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=+THk8XKLpLXsATYidK5/VOnKvsQ0KTjF4JWtK65STi8=;
	b=i7pEcR2lgIiT/KDgOwWYaa6oD8O7QRWZYvcVG2KB3HcHlFxgdxZzk3d15kX16ZyEapli
	 LffBaLLKgsy7TVJ+o5bQ1CrZ5JZju1046DX5IJpkNtFZTaO5sc1WISU3h5MJ9VjhE6+fg
	 sjKM09yni7afxHMK+lYp2CDhVCimLhN7hTi0iqf3XAW2t8HDIwNkWWStuygs0ry/3Yo6g
	 DabF1b4tqXVB5XG2fxN9TyRtDlpu8o+kLo6pu9ZuOUvZ7NMzdwIOWc8dp2NgFbTFwVH+c
	 6bmd09nXWNoYC5MVA8GQAbXwYMif7TZF8npBY7+CLY8sYsYcBlR+/l20qKqJyfl2Swg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=mkcHUikM;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E4D606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 07:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E4D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=mkcHUikM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792915148; x=1793519948; i=l.s.r@web.de;
	bh=+THk8XKLpLXsATYidK5/VOnKvsQ0KTjF4JWtK65STi8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mkcHUikMylGs8KdJAeo4ZzWujgWXoxd1g4IrtDCwDU5gCzHUr/L+iEOXBFeUhyV+
	 1NmwjBnkiYX8SA2NAuruLNgEQUZr/R42KYAztUNFfcEuYYm28J0Lki82pMmFauyzr
	 bt+34CKV8NmTRNDNswoIShjTj46B8JSWMdU63ll18oAuZFXnhNs0U783zqsL2o8n2
	 VIQvmveZArjv8pGMQI3gC6E6IS7quyl+U71qmHC6yNRovcCW3+wGsy0yRFfEuaSFj
	 JA2nlZRQ7Zqtw4qfFghVQxQ6rXxg+RxCJr5Wtml7SvNDLRc/Gr6Ia+ebEtLWZD3Wh
	 5iypn+nYbfcgzUgBlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4NDQ-1wcENG01ag-011VgB; Sun, 25
 Oct 2026 08:59:08 +0100
Message-ID: <8b60c7f6-4a1c-495a-a594-aaf322279539@web.de>
Date: Sun, 25 Oct 2026 08:59:07 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy PATCH] git.c: drop NO_PARSEOPT from builtins that use
 parse-options
To: Tanga Joris <tangajoris@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com,
 siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com,
 usmanakinyemi202@gmail.com
References: <20261024052449.95869-1-tangajoris@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20261024052449.95869-1-tangajoris@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tmGiCoKAt/Cfhwldir4UNqqBi6QLJXAO3o7tmO2Vb5h7766zB28
 IqbF8Xt2I+66ttSNj43J+ofo8v7Z+m9YWlQiFGGvkDQktyXPL2Zop+3qd5M8ofi76FW6Byh
 x+E0Eu0fjN/71/M6urudBZMNaMghRfwTbQjAl074WtpQ9tcooARBwIadNdXfQ86cE1pz0O2
 ygeQO229HBAKroR2Vio/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MK6y//dXN44=;dMdBiXAhPWk42juOe4xRxwtsxxD
 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

On 10/24/26 7:24 AM, Tanga Joris wrote:
> The NO_PARSEOPT flag in the commands[] table marks builtins that
> parse their options by hand. Builtins marked with it are left out
> of "git --list-cmds=3Dparseopt", which bash completion uses to
> decide whether it can ask a command for its options with
> "--git-completion-helper".
>=20
> Four builtins have since been converted to parse-options, but are
> still marked NO_PARSEOPT:
>=20
>  - patch-id, in 2871f4d447 (builtin: patch-id: add --verbatim as a
>    command mode, 2022-10-24)
>  - diff-pairs, which has used parse-options since it was introduced
>    in 5bd10b2adc (builtin: introduce diff-pairs command, 2025-02-28)
>  - fast-import, in 863937696e (fast-import: use parse_options() for
>    command line options, 2026-08-11)
>  - var, in e19f0779c6 (var: add "-z" output mode, 2026-09-26)
>=20
> This causes "git fast-import --<TAB>", "git patch-id --<TAB>" and
> "git diff-pairs --<TAB>" to offer no options, even though they are
> listed by "--git-completion-helper".
>=20
> Remove the flag from these four builtins, like 66fa6e8ed8 (git.c:
> update NO_PARSEOPT markings, 2022-08-19) did for others.

Good idea!

"git fast-import --git-completion-helper" prints its command line
options only after it gets fed a line of input.  That's odd.  Do the
completion scripts still work seamlessly, i.e. without requiring the
user to press <return>?

Ren=C3=A9

