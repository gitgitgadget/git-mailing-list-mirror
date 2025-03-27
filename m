Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4F86331
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070706; cv=none; b=XOZIibVjHx5I7zylThjv4a04Eq8cE4cqCw/JEaonKudC/AwsP2fIPub1zGHoM26kuKO/I9QsrMubZHpc7CGWDvWHaYHIWLM72Ii8sk2Ywv9Kh7YxwifjDB6kgoF4PQQkNZINRaKGhNvKC85jHNh9VsElQjepNh7et1PTHrAT9wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070706; c=relaxed/simple;
	bh=wfLnLXs+JU3yq7ob0k5ECkRowDwA/WFPOmHHG4YYFlI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PaGRjrqBwUt2fE89xsoO6A+XaJB9iTIU0jOswRT9naMlDfuPbrVtY+IxPs4O7JIXIdsRFC9aVZlFvOkUtpzOniqodbHUJmBW88oXO4wWO9+usn4gma9+XaHNSIdgHvvyOwdtvv+Dsg8GWundUOQADPESVZa9dhvaTVkByNMHoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=MbC240as; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="MbC240as"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743070697; x=1743675497;
	i=johannes.schindelin@gmx.de;
	bh=jkT/OI1Ww/mlH+P0u9QS185JX88BOtOpAgGMkBHhnYM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MbC240asXhh86N2epBNGhjEhh0R1MvWhQcSUyJvR3D29ZuOCu2GeVtLwGJHBXkLH
	 Ut9l+sHEMfqQu3aC8eGnYKMlFZE1dqmE7fcqrM9i+wp9YCMzZKYCvr4/K5OCkJ1Pj
	 TEWGl8cckZaDq9IYU2aWWb7wd3d/OOUlF4IIp6gIVWh1L/G1up9XIAujSxbGXc+Yn
	 1OJOi7YRjT6f5Ipyb732rRPoSL/Lsqx6FLbXY3gPxpD6EOD9nSK+TiskD4WYPfeq+
	 /hjp4LBtAP1Jpo0fz+T++pfsq4H6iaoRWGtjg0tSKJeAHzdzU6YNxvfh9/T11m8q+
	 bvPc/TliiRpK9jM54g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1tB1Hb1ZcU-010Wsp; Thu, 27
 Mar 2025 11:18:17 +0100
Date: Thu, 27 Mar 2025 11:18:16 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/10] clang: warn when the comma operator is used
In-Reply-To: <Z-O79qs_iL0lYany@pks.im>
Message-ID: <04edcf09-5f72-5405-9c13-ef150dada1b8@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <91f86c3aba9d19d5df11661675fd6c2cc049e191.1742945534.git.gitgitgadget@gmail.com> <Z-OWp0NkjrMVQieH@pks.im> <9cd9a690-1258-d96d-33c9-53a3b0f346a1@gmx.de>
 <Z-O79qs_iL0lYany@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GvxasyGZ9bXXtPyxqGhEFPCPYO9SOAr0o704IYjKgCz8m4E3pXN
 HMANG3TxG+lUHJtuAP7UbBwD7nLkFFVitRmbnit/noPmIf9ineERxMM07cwdKe6mfOJkaaM
 bjpnono3GHIsxNUL0J+elqloLQvnAjHW+kVDsO7hxbkoNTOihSN86WobXGzMmHVbd/+rWDz
 pLtMlOlHFY/6O4pOv0+jQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AulHIsYFju0=;Wjbw74gyzIN+T4Hdbjn5bIfSBk8
 aWvnOkmRlqUaWRPMBYHqDfXXx5KWqxLAc7Imrlqknb/dMHsqD147v0tTD1Pae3yYSUprD1M3k
 eYK3htSS7ZqdhfaJXqDcNdbEeMMwApMQra/6MKZJ79K/dH735MMFm9PebGl01+eKAawjb1ujt
 mHHDxOZHEfOyO4Z3QzgXlRVCIDBweO21QNb9hkSVbZ3lYfVRmjAGDlFxFbEr9utAXyvQ+9l/k
 jlPHFWY2vqQH05rExnCtTQ+cph0GZ1QQ3rYcyVaMgUjTT7sa8bO3KyG4W6OxP9R5/oSLJZSWA
 BcmiLlgdmka6QXR9kTJvGAj7hlCmJvoEn+7xaUdP9296vi9WWEaO0gA5i7rAEuDxVOfFXpL9J
 HsxykT6EfjVCK4VNvpvwmNAqAvBI4l2mgs5YxO6tZCoRmtEPiOq5qhc+Na0Nf/fINkj1r+bpW
 DixUkCnqbAgKPjC3m8vR4CxLbwV87MviK7x+YVXxL7KQAv4HTxr/CcD7HGpMyl9DZpY1ByL4W
 jGo1pj174608kx5qxB7aYPKb0Zuu3OaqlWaYBoPUt1y6Ic+Vz9jBjqu/1sEV7467JrtulcmT8
 3hwHK3QQDZEoEV3CV6/QmZhZSrgOTbd1A4EwlBRK+dLBFJbVJ9b1/uq2sZUKcz1+L+XK6nAWe
 R9NrJ1MqvsQhbjBG9HUyelNE3WpvPoGaSdS+V4lnukcTh10QyR3cyQibL4cIGVDrIdMOcwGag
 HcvMwv6Dj2biye6ek3cH/VeLcRVAGovC3gC2SM38LTeRSnM5jAXWcYgAHnw/9yDIxy7O012dI
 925V0tV8AX6O5d4zLddCTZlwzKZxdJkP5JAI8wCzx7H8W890bbz9C8ZPYW5gwbg+Hpdlojwbb
 gFO0NC1QfiuZbGPbf+7ziKy0ZAR22NAmPgmxcSFInUsGaEaFLsY54cl986fv0R6+cHdPEUJ7T
 d3dc/l9brQo5XDOCUv605J4qqDGEqet65GB1uYpzBNLT4RyWAu+A7+MRuly3+gzNKQAFNNLbZ
 qdO4QQSO6wAReyz0aZC0wVxJgXDLdUcRpk5cIO30tX490d0pzexVYV8hxM9FYj6iX8qfilMfH
 tHcM/hTHk8OEy7MAFqiXqofmMJl0HXvQurGxZknYHhXKwG3Y5MQRD1qGwXn+a8G+rQmclAsH/
 xIFJzutU36Ya3/p474jvJuso455/pNqbJuN272V5TEiFE525E8RUf856V1rHz7kKXkv6zVDAm
 bexRyImerL1H0xUvT6DMkCYpP4PxmvjZNVV1Tz++1u+8V+x78JDNlFOKc+rt1jkZQpRI5T0/4
 PwyUNzJoBC5E9DaICheGoQbMzGxDrVhmmDs8oBNJqgAQQ5U2+LJDn4kmic92Fw2bQKWFO60Oi
 23aqC04R5OujxjmZlqgMc7n3W6LHRcnNkwBntJ8LwEjGZ2cQiNo8KKhRPPS9r3nkilXpJvwkP
 +CBAqhIAPZfmYVrV54Uh0u3JCMi5D+OUvpHn6JxtRg+otIdmn
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 26 Mar 2025, Patrick Steinhardt wrote:

> On Wed, Mar 26, 2025 at 08:50:24AM +0100, Johannes Schindelin wrote:
> > On Wed, 26 Mar 2025, Patrick Steinhardt wrote:
> > > diff --git a/meson.build b/meson.build
> > > index dd231b669b6..a7658d62ea0 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -717,6 +717,7 @@ libgit_dependencies =3D [ ]
> > >  # Makefile.
> > >  if get_option('warning_level') in ['2','3', 'everything'] and compi=
ler.get_argument_syntax() =3D=3D 'gcc'
> >
> > This `get_argument_syntax() =3D=3D 'gcc'` condition catches `clang`? W=
hat
> > other compilers that aren't GCC does it catch?
>
> Yes, it does catch Clang as well as the Intel compiler. The list of
> compilers and their respective syntax can be found at [1]
>
> [1]: https://mesonbuild.com/Reference-tables.html#compiler-ids

Thank you for this valuable reference!

Ciao,
Johannes
