Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132D32824A
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092445; cv=none; b=HbMcZOGZjA2MURPdvAs33lFq0KZYN/ogHnr5U2sNM3wEaEBVL7xjJVtcOEy4LrfmVXADKkVuOIMIfyYsR50/0s0GyKCiCm1asM93Uqqe2EFVR67zgWlFpn/mSgt8zKRThYCvMlH44To1vHoBFoBJ1CJvaolrgER4sdjFkgjHRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092445; c=relaxed/simple;
	bh=12776nTdEqLEe6Bg8T09vnf8dJzLA95AgxfQTOX52gs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j9jFWpo9tC9izNJJYTIih21DSakPmM/KP3hd9f+xPyg6Z64FyoPntACs3meB4pwQvaHtDvSdA/ScC18YxiCMtS2ObmBsVUPrWA+cSTDMekFQNFnX8KJmSHGShvzu4NjHgfqeuRcjBCgYly+duegytOAbcgBFw+6cXCNOEhBRuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ql3JCU/2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ql3JCU/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764092440; x=1764697240;
	i=johannes.schindelin@gmx.de;
	bh=AfHgPEXyZnEPRAm6xyG1nmvZk88RUr2VKipzlqH6Vh0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ql3JCU/2YQvKZMnW44SNeNSTgjKtN7y+pdKXDYfIvdQ1OvyDguLvCDCAF+76IJoz
	 Cfi9ZCA4p8mpx8Z/xK39tqJ/WSQX0K3lkkJ2FRBeRCsebocC19falL0oeWoxd451z
	 Fw407gPsSApLSrfDTAUbVd7Gp/QyASBf3daKf1kJKqWry+q0YC8NMaSLMazxyXM1g
	 Tx7GZ7fIGwt/Hnyybz5HWkl5CoutHmk6quEtX6IAwzrkx/HKLSAy0Hqo0hlf/JIXD
	 1frxPgT2uNTpayHErydixpj0B/Bu3Ju/3NHWmoplVdEfYGcTVZQ0zcEgE2BC4g1jj
	 Y5aTFL+qGVKjacB3ow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1w0sgA0Axa-00ad5J; Tue, 25
 Nov 2025 18:40:40 +0100
Date: Tue, 25 Nov 2025 18:40:39 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Elijah Newren <newren@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] ci(dockerized): do show the result of failing tests
 again
In-Reply-To: <CABPp-BErdhTjbqDem4Xvc-XbhgLUEpy9-eiaaR1F_diMca--6A@mail.gmail.com>
Message-ID: <d8054499-aacc-f697-c117-116729432c3a@gmx.de>
References: <pull.2003.git.1763399064983.gitgitgadget@gmail.com> <CABPp-BErdhTjbqDem4Xvc-XbhgLUEpy9-eiaaR1F_diMca--6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-689714056-1764092440=:18364"
X-Provags-ID: V03:K1:A+uhG531qu7TSHeGE1MUJOUJ/XtPJ8XlrcUPk7rGtnl+yFYviwo
 lv7+FkbQoVNUaMSABrL7LOQdQ4oAsuglUJfqTGeLinvsP2wmIFbrZy0LCw5XuxkqdUbU044
 YwyCnoK2uADoBgZhEJCDDTUZPZEZrqHaQfGHLf4o03KOmozbqhlI1Nh/Dfv9M6UHxAqjhdO
 QbLqLx0WmyYhcaKiomV1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MaTSSNazTiI=;sfV61rVk9wwkMcitNY15ScDp5fb
 U1FJ2+ses6p5vIlxcoXtsGB1tpV8RsvagzXnBOSl3RtpYs9FIn8RGp8xBnM9+qGc0vnzSAZA3
 ooIzR+wo+Bu8O2E0ctW5hFMaqurHTs2BXdLpHhmQQ63Mp2G7e1+qPqZu5GotfGvhyl6aBHgwW
 uQ2xsst5ldAiE93TWhPr+p7W/mdd3icIALTpCcoohCVBsKcJkkgaaf9xsHB2U5c2/W1D6NlNP
 sMb8bim8Zchbj12Jl28AVVdiTimldHLWwg9EEQE84Nb8ogolshMdjjuU6BoQY3paRC45rT/Gr
 biPeozu4DCIpO/IYi+kko94b2XKLv0qPP0+VnbXAbXNuY3oqxKOoFfcFnVRawWqokxWgddCsm
 0WElMASslFmRevEcS57+J+om89vxDt2Tjep2OHoRQNYdNI51a6JyEjSWk9xBRYngpEJFWix40
 3v+G1ozDAJxTkrmWvqtXPaf21wOKOgp4QFWXKJL2MT5OunrVqEH0Tb5XkCVFyuDWEfMHpTyUj
 Yj7mKImBBKH4BKx+xt0/84QzTwIul4cj+NvHrLLksUEcui5tKDjnDzNYp4ithDsfCCXgxGoM1
 7dpVg41myDMhND1URncsxvdaWId3NEHRdolZPUPNb2JA5eVmCVOhDKdlp+ieEIka9tjNKyll5
 7s0NpkZMbkukd8s6Xm8pLKXrVl3lSHWxcUCJqwGi+4JGK0YEH2AIGgKypFCVLD8AQbZRbaH8R
 w7Pqon+HenYXjemjeFLrQ2N7OkfL2QDopEs1kR5qJYoobQpetOw5CR9x56eztBjmw010xhD/a
 kTE+idPTtrt7rGdr9+wvT2mhV95qN4DpUS2gJ2S3XZzAgsh4Bo0AfKWCg/1JHHYNR3fsNarde
 ORVLed/Qu37CNe5X6r43mvQHMUv9RIm/AIyGKTZOAgfO4jxr8fFlVDpiLh1ogzJMZ6U2gr0pR
 vS3Vv/bf41LiecMmHusccE4buELfDAMLJndgd3iUD9cBnhhhzTKAdRPEfosd3HEkuSkEbJ7MF
 gpGVqo1MPA5NHoXe0Dzch/8+KJbkGmC4QcRSyLcmwZZRxsJsX5PcFjrqSMyzmE74okzBzHqni
 tkGURSGqlx7AQGmOPfKeXGLWHkVb7fSgRXwYYTOJGrfklB6crkG48mcvWUcUxqKaMW0epVzVh
 grlgnJ4JHvy1dwTzPVQt0K8N1kty8BPn09YBiBmBToxVvXT9jp7SgbwbsiZu9CCMLzK1ve+yc
 6DVxQ8k69JIalAhKdcWtpykHxLALGgjtePRTgktSaMWHlovHUCcofvAXW+pRKWCzKMFwOJyRM
 0iAPKWAY+JiKCehFiU9ICaWFBu684SctFHyxq8rqNiU2wjv5zcMOFUaFdS2LyWTxzXOW9yB+g
 vkhzHF8i/iu4pS+IwlmITLcLr3e+0B23tRGcDicRdHfW4BpUxNbfA7bfduoaGT7P3g1OoqMis
 MniK99iKxnZrAQeXV8iLmfHf7M5BVVuD++oQqxfKumFm0zagrn4X65FRyEmNNFc7r2nFVWM2t
 GGPdDKKfkUwnGb6ndxbY/NZGS6z/UiqgoLyTKeBO3KvkdOY5DgXpLXEkPycxgyjY8yITf/Boe
 qEgnzz916A21rSQTeUxv+dYjfbpZRYR9Chlr0tUTbp5r/J7Bqw3VuT9aRVnRZDE/MFz7h4e0f
 LHGOnSLw93Ho532l3+VxvYnyW1qiWopivWYq8OKc8TuC4TdqBf1GFtgwa2TJX2P+qDC4Z5IYa
 URjxbZrMCxdvaDhxMldnUAiO6Y+u4+hclDHOY3LKSc9e8iVdxe/EUTLGE7Yjd3A2hl94kAExd
 q6OeAiewpNa+hJ7D6/gswDZq4Q1iUksgDVRnScaMNwPeDb3zztIfKZ8FhNfxB/lFaLlBjqvIM
 DWQUoduWcE/TBOBdqbGrgOHp16o+8JxZxvCAJKlN+KNBqOBYlaHFbTfgktBoFTKk2MdrwlF+5
 2bxDLGA02jK3tsHyRRnX52ct30vK0K6WtIvYcsWeTGM8ntBLG+JP+JZ71H6EBzdIW3W6hOzEk
 0sX/S7YtcKbfOkvrpHYpE9KnG/R9Bjie/FFedvdeie4bdhxbO+wVPQZcnS+w9rzjxjml0p+6Z
 ZD67NDYNqVr9ImBYpIp//UUG8BYaLe2qmMfOTZiqWV5+tvRtoO5M4tRHm2uBtJOhWizjgcHds
 WqFz6n2IiuYeKResInVdtudXYj6Wh3/jq3PmRD4E8Oqtwx3W/hS3QU1aSs9jL3f0LRNJ5MgfR
 ML7YbWi9Z2YZ4hinbjqzhRAfV7JwF7O8PLJDFVH930bq0JSPZlAup9p0uZRARX5ZjNc6IMsjl
 xXEXxBXrXQnteqyTdas6WKIJxXVe/GIK3lKh8iSR6mNHP3kNJJzJexmq2NJXfLib4tTqvVHvN
 H1OaL+K0X4uwK/YRap4wDd1i0SbhmMyumynhHw9JRf8eOtbR31miVLNiBRxZ2EY2lwa0fdG9a
 kiQjxrHr6nPyJq0mHOty9v8MXJN/4I+kgK0Ds0O4+ktAoEp3oh8mYqKIx9GJvKA1lh/NL3lNC
 Yil7R0lrBQu9SBPRJ90QZRPsiXsDyH5VDh3J4E0Enc4gHRziDcem/PBUoe/07ZoNjHhMP9uyc
 Q84aQx0q2ZDtsqM54l6VPbM+x6a7S7vVAZ+c19SfSJNWpMDkwnwT8BmZpLjMWhAIj4PQ/mdkT
 fwy8nmVDpnEKHYtxULA35PFnOCUmh0fFL6iLOBoNw2o7lnb8w3KHDxi9xd5U/LbO/1apQzhmB
 aJ5gDCZq/k8S/sWLoW+B2TscSOzaU7B/DaEBDBqMiSh1ZHFOK3ltRmSnlrZHlp6woamfZAtvO
 M9tmCUVjYw7j1/+VjjWMHXlBM9pybpJl48mzUghlQQcJHY8lpeWFZK8hOIf0Lh+C2MxPCVbdc
 uXnm0zPq3YtCmHh/w8ZrFlhz21qS8K7ALvrQq0P66QcSoGRv0481dpevBpmv+VrfL371mt8fn
 QqJmcu5b4L1AvpAKkLNZzM9jvGKdMngKhX1j09DsjI2biVD3XvbGdTdIuRsRzhseT+AWrQM6w
 zifaaW8B+JXPYQwjBtpQRwFQko1odbtpOKXorATifDbnZpxCi/9NaXmsj+pkUufdGjix/Kej/
 0cZ5kVylnUlukm5wIlAPgR6e3bRzNYXogjVxPzMUQ4qo9O73Hy/v9/hm3RkuW1GBRUaY7NXBH
 8c6GtbzkofcigGOboZiXeM+/EjImihWxa4TOq6JxW1T+P7shY3TCG+ucsmz1Y150Qcd+WNFCD
 2bX5SZSA6UymwrE1hSQAM6FeTB+KBK/P5Fv7x+5hZhAG6f8IaWr0dKHDNU96Sd/fkyT7tGyIf
 386e4+W+lAi7s/XKjVGufPmIUr9hwvCSnHwP40rMARtKL9/hPdop6YyByEl1t5QviYB1VaXVb
 gZqxguM/6DarH+9czRaOVMJA/ZFu34MDcwRkY7w237Pu6z8VkmM0TTHbOtLdhm0uG3RL+Az3Y
 SwjBNUehuhHBcRmkbMj89DMxoOTe+08r6byEDmmk6rN2xa1DwiRkrOMgCPyONN6cpu9TvD1Se
 XrPVUzMqCPWhH9bydkUmyR9Mjwss4po6+8Nk8kqgvLzgYTsj6jfgl35nMU8ynEI78jDEG8D3O
 ANqKx56/+2sVUm2uvox9hgYpZCvgOQRlcpdF5+AufnHWA+vv6bNVG2UOAXFFTKYu9BzBumrij
 WZpbDH5IWXwjPN6aSSazuR9Wx7uDf4zL1EzRI9pR45KG/3sYRQc/8DZTen7nyfxsXMxFhUlQp
 dTBF+5wgyxIKVllrleb31CCceiHifvDOZMFlPmelEZj1FLK7K3tvLUcVud7isH0g1nrMzaEF9
 6F52e9NKxT3QqSzaUJuD1oZyKJH1n1TVIUleWr0mnDi4y0+Dk/hSyvYZqVFdFk/NDntERDR5V
 yQ+kPexphcriXlsx9oPmKKOtJTNqaYXzjb26KRUNCLz8Zty6hMyvpU8M/B7zAL0SEr0yAZSVI
 H9sZHgafyX5CfXVlCWZduklttI/BXM8wAlWjCONM6AtIlZOAteEW2BvdEj9m+JfirPmMeqqhO
 jdu3Oo+P3n0YFHMvh8v6kfGLyaxGUuCZyRPmtNDazom8jvNMZYm8XV9PFdv6A4Qj+c/GYtv+h
 OjjYf1xR8BhpiBV8wEK2+TsVDXBzwoonh05WFfszjKcaBWmSW5fjeC9krAQnOmUb+QfJsQLnK
 o2CvsXWXz3ov0IfdfQPpfBgh2sw4OU8WJnwHTI07cWlUuYeYLIqGkgd0Zc4CP/y9Dj9KbAgKA
 xTIg3xqM8NqKXDGQ4s2MH7Cym69uEjK8BoMwYbNOin/Hp/Dq5rnMotbTWglmbT9zSIQa+R65N
 DaCV4iPUjffX5ETmEENfRCKzfPly3jt847r7AO8xq6mdJA72hROMwUjsYqnA6NKop3JR+Nl3v
 SV1nBIuixnrnKqU6WIsFWRdhb5h+yqqoUQ4aoNXnnHrmUtCzDJ5DlKRR+RZvDVqISOED05I61
 pD221uq+McOWd2KhG2C6uEKFv6lJ43DcbUvO/zm9/3FLG/YrlCBFzPxTqDvaS2st+xUW+Q4nD
 GM9gxiWVirpLw4R3bxjppxSp5NN08nnQ++VeD38s0IAaTvH+OUZ6jZCxZFhoGZS+aP9CPCyNm
 F/GVbMMVkw7QXIG396JsuFgPtz6k4qkFk8Xudqxa6Tn2aXpY0K6ZRzY/WpjovMAl8zD0CdtCG
 BMykhr5EzxOUGLcUCUD9EtrWELEL5YZ69hMw8GJzX5livVTFSV+3l2XsEeLsxGMYkElqVNzPs
 xibBQ1eqKqAZvZx0gTI09oYGyDatOeeB9Sk+9IUnuhdZQRU42BOYIfACKFWAl+qsjZeY+g7/a
 TuHkgcwPW359B3YX8pXfLPUPrhP1wj6TQ07DXk7Me6pKwMS9Ya1ceDv28UoB8dQ0Pw0dFEi/0
 JH4QaTirpM/TTvb0vlLedKOK12lXcJnoEwZl1XBRy6o1t7ueZqowHe9aqHjMNeBSyi+jgG0IK
 R2quxELMuknypEMlbxOOcr70clySd9JKmSXcNkffZ9jQfbbRj0eKcurqTZoBtJs+5jznHRp6W
 un74JWTVvflZbLRGzosdxAJ1M3HKAfM/GoWk4+3lHitsPuMkcs9zcF+nawABOVWo4z+tcGGbS
 ZhT0jzDCa2V9yWylGHHnI3/M9QKQluzNhb1rGIp6yr4t3ngVbyoiIKuDfa9uwmiUdGzndKWGo
 Oj/Ncqgul0p5WgtlD4qrFxinwhwCp

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-689714056-1764092440=:18364
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Mon, 24 Nov 2025, Elijah Newren wrote:

> On Mon, Nov 17, 2025 at 9:17=E2=80=AFAM Johannes Schindelin via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The quality of tests/test suites does not show as much when there are =
no
> > breakages as in the amount of time required after bugs trigger test
> > failures before the bugs can be identified, analyzed and resolved.
>=20
> I found this paragraph hard to parse.  After re-reading a couple
> times, does the following convey the same meaning?:
>=20
> The quality of tests and test suites is most apparent not when
> everything passes, but in how quickly bugs can be identified,
> analyzed, and resolved after test failures occur.

Yes, this reflects what I tried to say.

Ciao,
Johannes

--8323328-689714056-1764092440=:18364--
