Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614421ABB1
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432782; cv=none; b=ikbRhsOfJLxwKVDVCDGLuI35/tRn7icsPpPtkRqAzB8Fjn4gyP6REPAdOmsvUaT8U9gacLOJMMMLBMWgF9X93DAETf6zeGPWIWChFjj01bVfEz6aUFNBAzVc/KEvHQeoewFVPJdtPCp+MBjEhccTUVYp50QQf6WCVKW91k4CkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432782; c=relaxed/simple;
	bh=F0qLPJ9oH1kRrHeYMfMT/erFUqj9owVUvKRnWcJBTww=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PD5lqGMvvmAv5o+vRCeNZeC0JPhhmTrImiougGKOEhgEvAYzaHcq+oDATkx1YyDUoTJ+dLzE4+XccA8ZEZLBDXWeVy0w2Kwpv+fE2E93PpY/QV3gJ2vA1jIuZ3nFvpJ+P73M4SJGSKncfI9ju3+475IcSGs5zLOAe9PMqGtuHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=LA7K/5Y3; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="LA7K/5Y3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743432766; x=1744037566;
	i=johannes.schindelin@gmx.de;
	bh=kN3n4n4P6zlWuabSJmmGrTVruds1DyIQtyuS9+TmIlw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LA7K/5Y3YQw+Du3/KuLQ1shD9yZaC3Wpasmg0NPTmGU1xu8+EIzgnR+Yo+rPIHQc
	 WbBhnEy4ZvQgSUuQpuZnQ3+x8EJyNIfbvUCrOWQvHutXm1Z5ZEmdqBYMP/jejWE34
	 7lhgTunfXt3LlroXjYT/zP0kzOqU8xbBos87E52dPHR8JBvrsKyEHJTcA+Eh/F/Ux
	 E2bwxwwvsB3cmv4Qqe9xyhlr9j0W1tzXRT4pgQyMQpE/whugsOeGsI165vTFwLk00
	 SRg9F+Qz/65CdWf8IwMyuSL95RUGwWH7g1qV5rzx7kkMQvr7/A52vCMwx/Av+mCbl
	 0DI9JdUQ8alzCQg00A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1t3iBx2H7D-013gdo; Mon, 31
 Mar 2025 16:52:46 +0200
Date: Mon, 31 Mar 2025 16:52:46 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Josh Steadmon <steadmon@google.com>
cc: Junio C Hamano <gitster@pobox.com>, 
    Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] libgit-sys: add symlink to git repo root and
 build out of tree
In-Reply-To: <xnjgoym6makh7q64sp5efvkmcubslklkjeidja45rtl2wjm4jd@xfww2a52hj34>
Message-ID: <71a48992-b2f2-fb4e-b5c0-1f7f5dd31353@gmx.de>
References: <cover.1742339107.git.josh@steadmon.net> <cover.1742594960.git.steadmon@google.com> <6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com> <CAPig+cQ+05r0iJO3me2=yz1KWaU_S_WQmbeciOqZGxYWgbT8dw@mail.gmail.com>
 <xmqqo6xqo2o1.fsf@gitster.g> <5qvxvuquk2yuyoyoctz2ji6sj4yld4ridig24elpoiytghlovw@a5hgdufrchwr> <xmqqy0wslndp.fsf@gitster.g> <xnjgoym6makh7q64sp5efvkmcubslklkjeidja45rtl2wjm4jd@xfww2a52hj34>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TytdD6kUPAxfhPChAV1ZyNHQ/tbu6jAmqg52ZAV+gXyUA5fLqMD
 LOzNunsMu5IQGaidH4yYtqqxMD0prcjw0tGAmwbu3Z550G0QMN2vJOSwOZObwCm1krBwJHV
 mvRForTFUnYu5EYB55G0FngTl6TQnD21EthMva8LC0KwlM+PSeYv+z78YSAFRNzuogMCcBw
 sxLrWfm8CgqIMiN3x/9vQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ydWotdV7wRQ=;1EVlPaRf4wWScoIsgbcarrGh2t3
 eWcKz72ZZ3WAKzKuaFOP/bgVuaIwQQN28PxIM+GrKHA3I3NuFWKaZm/KP/WDjQqwF7rqQ/HAl
 I6VI0ZMn9yVJaZHt8rxtB6wv+NjIap5joJ1UBOx8AkXmArWkq5dzsfxkirAQrtyrYEnlivRAK
 1UkDV/0aitBTHfWJcc7rFAcpqwlCYXUtrLCMAYgji42xxDUcS5wiOEhgsvHSmlzcAaTLU9/jR
 q7HByrYb76RxQIEP4uKVeqR+k1Y4r27zlodQVe2xobZP4l7Wqii5GLubiD0rHLVZv+oFANMLu
 L9XiRtpwy5RH5NAWWixyn+X2yuf5UR5Ap3PvKcMWw6a15qil6bE0oemXu0oarEaqB9RaNwsEl
 wS/ZOiiIY5FDCU/5wuYxR25SVT+M984jJelyCkAO35ZIOWBRrkLwXYnIKSOL9hEBb9R6/Al+w
 H2H6zH/EU6i36rA6jbGOkNO/5ywYzyNKejsylpokUT88Tk/2emSSnZu6XEFXwGdnEN/33IkUr
 rhA1IO6VExR1jD3VVyx5LyQ1bBs1gtdrEUyaTejDGLTwYaKsLkCvpA2BkXMlNrUxUrO/zxw/M
 nd12GHhDGCWw1HisT/8AyyV9nuHeAsovfqhAEbRM6nb15rt8ZOIKRBAX+drQdPJdxc/B0rPYr
 4vGqobXzJisBAbhrt6IIXWdavt/UFJWg6dcrQ144JEZguNkggn4vKSJ91F5QKXbk4MbfdpBfa
 NB6KGQ/N8V7LJDJ9u36ZFejgu6RoiUTth5yevoPHjHUSuPFAyZGEWNq+oPXQVhrS8ZNLJU0nV
 CRkyW+jTf+UaoAef1PnQaI2GjShJyMfrkhKRb9V21SQeQaXC/ppElmAkFBechvRBtWSamFgPZ
 tftAHqYRF+CK80k5aE2QzZa2iv3cPrDRiHujGnIokhoiifRTOmYZxtQcePD8WgR16fEAKr/X1
 x/7wKUIpFq7TpxLGif2TbSQbCWqZAM9htJaaHT/KwwomM6sTyWD7Feu9mmBVbj5bGELF0Ejo5
 vA/CNee9TEO2WoSEFXLUAFQ6ROUrBz4QfG/J76/Ghx72kOjr604yTo9lsLq561yG4Fq0Nl7Fq
 vrIdp6/fQyUlpidxOYW0mMsM/ExDwBKMLouzFd1qV8V/Ql9NZe7+ZYgGWKodp2q1tVRjpTzMM
 FU3Eq3IPWIYVPoe9jHccW/p6aVgIyeQqW5+J1YjRqgf5nw+9L58S7JK1FNTc4pT0b/AXLKs3D
 j6IiMrHd9DDqbMp9R3qCje8tEf3BizsM0gTUiVLTJscviFZEu6OtiQh8MC05QzH4rUaxlNkDE
 qnwUokLpAmNXgvY6iv+7qIZg4BpYd/P77KtmNcpLFkp3Y2fskfdsmf69U5JmPtHUpOtNVuMRj
 k/PyBhuXupKUI0lV4B6h92Z49NuOBL7/jw7TMRG8IjW5N2jcfYkY8D2cemih18YCjngzUPDVn
 vmTOLrSdNP38XVi6OYlX5IKToaNgGBFsIaBQLxNIAGnTrGwuWWXpAXAs94kqzu5TvrMVCXcgr
 ass9JvQmubRHxo0ux0A=
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Thu, 27 Mar 2025, Josh Steadmon wrote:

> On 2025.03.25 16:08, Junio C Hamano wrote:
> > Josh Steadmon <steadmon@google.com> writes:
> >
> > > 2) keeping the top-level clean of any Rust code or configuration.
> > >
> > > If we're willing to have a Cargo.toml file in the repo root, ...
> >
> > If it is more like adding a new build configuration file whereever
> > we have Makefile (or meson.build), and is not like we are adding one
> > new file per one existing source file, then I see no reason why we
> > want to avoid adding a few files to the root-level.
> >
> > > ... we could
> > > create a "Cargo workspace", but I'm not sure yet if that avoids the =
same
> > > problem with accessing sources outside of the crates themselves. I'l=
l be
> > > able to test it out later this week.
> >
> > Yeah, that would probably be a reasonable thing to try.  Thanks.
> >
> >
> > > If the workspace approach doesn't work, the alternatives are:
> > >
> > > 1) avoid the issue for now; anyone who wants to experiment with
> > > libgit-rs can do so by building from source (but it will prevent the=
m
> > > from creating their own packaged crates IIUC).
> > >
> > > 2) move libgit-sys and libgit-rs to separate repos and depend on the=
 Git
> > > source via submodules. This is what I've seen done in other -sys cra=
tes
> > > such as zlib-sys (https://github.com/rust-lang/libz-sys).
> > >
> > > Of those alternatives, I prefer #1 for now. If we build enough momen=
tum
> > > on libification and expanding the coverage of these crates, then we
> > > could think about switching to #2.
> >
> > Yeah, or putting it another way, #1 would help us gather enough Rust
> > minded folks who are familiar enough to come up with ideas and offer
> > better ways to manage this part of the system.
> >
> > Thanks.
>
> Unfortunately creating a workspace doesn't provide access to the
> top-level source. Symlinks seem to be the only recommended approach [1]
> for embedded crates, but since that breaks Windows CI let's just drop
> the series for now.
>
> [1] https://users.rust-lang.org/t/including-files-from-parent-directory-=
in-package/88969

If you need symbolic linkson Windows in CI, please set
`MSYS=3Dwinsymlinks:nativestrict` like it is done here:
https://github.com/git-for-windows/git/blob/4ca71ba5311a8f1bafbf002e97e076=
f15dcfc15b/t/t2040-checkout-symlink-attr.sh#L8-L10.

It might fail, though, if it requires _Git_ to be able to create symbolic
links because I have not yet managed to upstream the patches to implement
that.

We could fast-track support for `readlink()` without the other parts
(https://github.com/git-for-windows/git/commit/86420a1b84d1), but last
time I checked, Git's test suite did not pass under
`MSYS=3Dwinsymlinks:nativestrict` for some reasons I was unable to analyze
for lack of time.

Ciao,
Johannes
