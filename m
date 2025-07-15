Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7602D77E4
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582041; cv=none; b=TrHpqO4QoqGGJLrzjpf62KsICBhcrZj96zST6B1l4xPXVTkKUr2mCf4sNvZynKpD2vbImnl9o1gaV+5RNwvB9kDfb3wDyogwW9G50Ju52Dnv5nJs3suNiln6+yX8/TFIawhdHLZei0keTduXArTCRx27huUkIA15BA8Ag1tqcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582041; c=relaxed/simple;
	bh=YAu4lNmS7aDZ8JTFh2QmZ+keUF4UQdbUeFVnCyD3R/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iw9UYMFoXG1Z/QBRwsTYA57IIPeeK3SIt85WB2JgXdgBo26xHGGASLZYGmxRz1Fpz1o3RJAf5zXf75U6AK+jGX4UPgijQwVtqmWySfdRcjmv38ATzP35DVWfHBXYIR62ahPptU9ZicC7eDHDnOQk/GH5cTwVtx2JZYRQD6Tuw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=Hh7lX03w; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="Hh7lX03w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752582031; x=1753186831;
	i=oswald.buddenhagen@gmx.de;
	bh=YAu4lNmS7aDZ8JTFh2QmZ+keUF4UQdbUeFVnCyD3R/M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hh7lX03wNFBWjoH2xH1zRd/OT5l91clQRAyOu9bLafAJ1MEMVElISTVabMNKFqMT
	 hfp6l+p7YPz22fE8P4k2sal2OSoCV+ML033kIO2rHu7km6/KWuvIzp06A5WP6JbUl
	 oWXVqWHLi7ZFm0UYa5yIMdt2KLuczuzQdJQecL1vnzF/4ca+6EwOGoE8m5h30oSm9
	 kaGNN1h6YNpjsLaVGpX/8May043Zhd8YZ9XmJcpSQ/Le69vAqhrEDP4z80EV/ckSo
	 ghlgPBKSbetUVxFa96am/7WewumrIrCsp8Np5smNj7vI6AP4KvZvXgnvnurRLg/uc
	 buFxDP95eSg1ONL9jQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1ukYb02vOy-00w9ck; Tue, 15
 Jul 2025 14:20:30 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ubee6-qYi-00; Tue, 15 Jul 2025 14:20:30 +0200
Date: Tue, 15 Jul 2025 14:20:30 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com,
	phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
Message-ID: <aHZHjkb9Vc5Y_ta9@ugly>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <aHYuwlWlbkc600Ps@ugly>
 <aHZCfynoeMDRdN4X@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aHZCfynoeMDRdN4X@pks.im>
X-Provags-ID: V03:K1:Uepw3vfPbq6yvT9y9/0fOOq/isfIzJZfld/VWBDBjoPulVZHxdH
 V/tfwHu9SUx8FkE4hsyaOVdzYcrx13I4knwGkaffZ04YZeNCE0E00jbNrgCgDm2Wgqee7sB
 FTxdG6x9ZL2Xwy6XJIlJPNY7g7/ZV0lWSZfzs7c2qX+jWP5SQBqrFW5VlGhuKmXOrwfRkR6
 W3mXAdSARB+PbtHxZnZqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0lY3n+/zYKs=;944ywHoIRH66WyXUxnmKv8O5gGL
 7KJRzP3XEo8THDKOw1G6NzMHGDIrV1O+y18Ex0Tc1Tx/mqM8CMgLN5WCyuPW0F1doCebEpJoE
 nZ/sIHQIu0FwCU/Br+AQwL6dLePe6v/nw0U2Dc+RxsSR0R22PmVHgys1a1lE+cWpQJD0A8Bii
 IsHv0yPeN5vHb7ZHq8253MfTPSMuyRtgo36NY1lqtbXilXycjtvCigMiZo+jRIK2EGfQbuxP7
 W7aazNDtcKYKuy1LBLeZiaW8gYKhw/ilzG9AKJH+xsn1H+ZxpVCdiYk5QOqjPDtmc+F4+wdbL
 y6zrmzBMqt0IYb1nzWDJp5bDX2+XsPWoFjWpMVc9pUvVuQhnqmjFdKU9GuXKuOWPElfElGUAc
 5CelFh+xsCbBap5Jnd1CpKjA7PIz9aNLrQnpDrdqrX2pw2ZmnMZV/6PPBbTsJbU2/cpvdmJ1/
 kwPQMcnuavtgbEawmwE8Sm5Ow2XUUdd28reMw24S4NiR7EWBnJZkPhD1XANQsS0ZcT+l6gva7
 uMl+AX2Cm+gSWX0IOxSbAQQCFeOanvI+YJtmhbMpVvy9VF34YwnDgsgk26ntOQ+4T82BqyR9V
 Q/NNCt3f2EFWVFCTQihaI7VDKZ7cWoG2SyBwr2t8BbWia9xhIyL+5xcu0ZyaxFQY8A5txMM72
 vnezyb8SHBLyZUqfKjArslBbkFRv3oUenXHvXaU0epxZg1UJr++gwrG2bp2I6hawCRwugKizl
 WCw581/1gJW+ybgplwEVgDJksywOb29/FeYa2AcKBha1xPpnm2sSVHfB+jD5yN/wWohMS9Xys
 xKfn5weybpWVLji21SEWNk9E1SsMCF+1r1HJyGL0Ard+sQJ1A72FSSqV04l5HAIxOfd4C0h0o
 NAlh3J1ltkhCqKqRWaIBzPZi3n5vTtnuAl7gXSPR9OVPBYASEAVsKpj6xJFZB/H12lgnCX8vR
 fjE9fZcf74j2vyZca9YJKfJKFWZ0jaxKcwpsMdxZWptWcqCeqgkAZFmIs1KhNexewX2nJLapo
 sN9MnOSL5WJmEjQEMFzsaBWSO3HDQz6atze+eZo0RGL2uAgpWVMo1d8ScGHUmsr0tBvmCvAbY
 pZ4gvnvGYE+IOsM2Ci/zDuvfIm7nRSgZYV1pGmPXFr6IwPbTROi46jTeJtIrMLyca/gmJVsQI
 oXG6mXoZpFVqeaX6SlxmwWgoykhmP0QsnZEvXdAxrHOBItxLBAj5lQZ1R5TitdmJNx4XhzoDX
 lzoS30gzcVguq4iJIV1jXJ0i9fjgToDAW+kz8YX0nrMR0lxTKD0GWGqRiDNG6WyPakHWL7+ew
 x47/6GQYBHKGEZyw+mpiQCrxeXAeSPGZDjC436BScjJdCDK67EHBWKsMfA2qodw0uMkvBBbnf
 IPzCHH0RjGvLKTcJZYjJLVDrRQZKe5i0UV0bBFx+4d8UMhhrGOtXjVuQOpzzYGofYOSW33mzc
 M4MeHv7jvPSvzidWf6+Pvx8tFOisDgYdqTF4Y5V4IHQNbCn8TM9xYHD6ewiIwzwB4Wej3rQCs
 IOYaFyipahk6lRn1fV0/2WjeKgfTBMJjGaXdP9mmSZ0f7O8xsfI6E8VE0QZRTtUeBBtye4YAY
 jmsvL0UuxaNW0rF4SrTfl9fJjw26eY0oCWPVhbR1CMXqCbJf7C9CyS4iKqhIo6XyDFtW9nlDK
 DhuqnswSB3CSxCt2zUYrRvE+0OoeYMRtXs1uP8S4HK7aac1zsIdA+DMHsYieXqlW3dOnUUCJf
 sDP3c3zB9882AM5alikDrFxqjemjAFwjOQD0zSkc+Lpe2K3F4LKdjISYVIWjdPsf8Ir9aHMDB
 zbwq+Z1m8enoKCvLqmra3J1O6YWfNY6Ll8xnLkSnkmk4zxdWRd/dWc/8CuEOKdNqgOV+5fpIF
 qKYLEBoGgdSAR/87nfHPRn/K5bvw7GSQFVuMuJkS+rTwOpFft1Vp8resJsxqIO+7gwVzuxM5o
 5dg+QF/VcQel/GSXdEB//DrhxjzQPGp6GriR1zW5uuNvI8m76hg+cw3F1vYILMShm+5ZIDDgK
 UD0hKlWTlEESI2Pm3F9F3KnCDfcRfrFNo2+KJ0Vu+yk5NUUIwyOx801voOvKfZgNHpG/BiuwK
 iHn25v+79K5fyZOrxweMZf8XHRfXEWtiI6uhuisRD1vr6y/vQwv9GNPVADewfZ1WeFp0wrgol
 Sa4zrKzPZ23PxjOycnXkkjGqG6nDGfHm8ci9zTKz5tvBokgoPT8i4KOacaooA4M5i5KZq3T7d
 Op1UQnoge6hcrwxDjfVj9P7kjwUlhqZqTxWdP6RAqV6buHf0wlrbwaxCu99YcLbXJX5lTMeV7
 auFVyapSM5dWncrXisYFas+kWZ2gWmAA6aBNbdnTlBe14NYtmslDv9fHs9OFPmXktV4VHHYH4
 tXi/LRfUMZ2ZoBZnujY8unWmTpbYziglYaIgwvIm+Xb9OJQE6yPn38wViGuU0AV3q7NxGcwl8
 0JDk6o5WKdT57aUAJc+1Pr1VZH4ZFL8tHz7bxqtxjrIQCqNAxWQhoWz0CDpeFcV43nXgAlVNM
 9wQurb8Kc6LyNzp+nYwu314OJzPer2pFqsp6pNzzzTLEaK78d4PSOABLB8L4/yd6bomYN8uUd
 8npy2LVQgTIwjVW7MkzGM/EkpHid+66Vx+txb+VRlbkIL5LoZTCqn2PI/P8E26WX/oTFcIwOw
 or8C7yt/z2KHNVYC2jXf7FXHXPyqkAa7g9DCU9GEQucQO26o08zfpznRx23wV/oBEGvryJrLI
 iBSmoU3CDQBrsvb7MISYSoTafK+iKU4rGv+E3eYLrWGMONBpdpq4GVWZuXY+bpK91jBN9RYFn
 lQsGA3z3we5APR6z8Oh9Fpknj+PkwoWE3KIDLhNpQsD6Btfcsk5cSh5OmQmBCkouwh/+DRSKo
 FKx7PYhv4sUw6O3AO24Wyv0jOMdP7NUjpX1/3VYq2+DG8/GakTYHFTH4DsEM+Cjr/zCsM2Ah9
 8QFpXUV6NPdaLI1whPuO/3ADKlPBt23T0Adw0LVXTTpQUycJ2SMgUTKATxHfmL1WY6IlSIcr3
 mSQ8PECnNg4SNR4qGaSBTZd26kpUl0JjV7U5f6/Q7Zr3GkB8U0+16fAh+vj6984dTvFVGRwAI
 1t5+QQFLUxy8Fn/X9i7P/x7BjdtJIG6jyoEE+yKOVRMx35jJq49EUvdNFK99Mq9bgs6MDwDa+
 aljGmR3XOw1FQ4eIo7sk9PJ+H+TfxxC9eeLFHfqONNwjpxpzqqvI3GHZRbtII3GjH/OjsVQIh
 hZ71cppqlRmDOVpsHqeY9Sk4p6S2c1UFYtsllZKO4I9W7wBa0fIAFlP/h6eDxR6KpEMmy/dUH
 SD+vSNsHjVRteSISeNEqtBCpC6z2Ty/oeTGglrZZo/1bnfJ0vAbNIbCSfpmGPkLengeGvcyc7
 hJgtyuUoS3yMNoupNG5twBzmtkCvsC9v4+Z55Mx9o38818dij69P0i3cGzofFI6evDVPX57rW
 /Geef2I9k4E5Din2XIgFyni5C68XcO3i65VIrxs0lTq0fmlNG6fdDdUZYhxa1BgGFVmbZkkyJ
 Iw==
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 01:58:55PM +0200, Patrick Steinhardt wrote:
>The `repo` tool wouldn't be executed as `git repo` though, would it? So
>I'm not sure whether that really is relevant at all. On the other hand
>though I do see that it might be confusing when you interact with the
>`repo` tool on a daily basis.
>
i don't think it would be a problem in actual use. i'm more concerned=20
about people talking about it. really kinda a trademark thing.

>"Query" is way too generic from my point of view, as it doesn't say
>_what_ you query. "Meta" might be a bit better even though it still
>loses the information that you act on the repository level, which is a
>bit of a shame.
>
by that logic, almost all git commands are too tersely named.
but in practice, a sufficiently suggestive mnemonic is good enough. =20
preferably a verb, because it's a command.
the fact that it's now being made into a "multi-tool" also kinda=20
preempts future collisions.
