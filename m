Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4204207DEA
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264009; cv=none; b=TjvGpuI4c6J+w5lKtCr9mDm8Hboi1wJ9Nl7GvEo7AOjp739M1T3lWcixYf94OQCj1SNsfpMP7YOXzi2+D1DlkryKWruuf9nlTR4MrNH83U33vuN1dxl4pahbaHxS0K1G6pavmgF6/jbS5r6mhu5fq75KsR9N6sFbIAOc8snBkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264009; c=relaxed/simple;
	bh=04wfnZhQlFtBVyrij0s9A2DPqOqY0by42Bg7lpPJKnQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gbe+MImZiIzEWXB8KWduIWCHX8d20dZ/JAmTRzUP3bOgzjGFrCpfkibaoACHuq1SyBLw5ZI2X4pTM9T2cRajA/ts8rIT/gLYTnjzw7Nd6WlrIvUcIAE0bk1g9znKvu6ckHtdoogdwsLylfbZd60G8EvlduyMozi3ZWzD9MJc9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Tfoqdmc0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Tfoqdmc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741264004; x=1741868804;
	i=johannes.schindelin@gmx.de;
	bh=C9mtroxAgDQi3nt3vyDhDPlkIjWS7Z25S4mCjzUCP6k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Tfoqdmc0dOH7IOX6F2C0sySLj6pPjZmCmKr66RAeXPI4JFMyC2XKTrDd+rIOrDRn
	 BO/petLRLF+A1/iChU8idtFyuwAOsHzCNghNfzpzwvb24ZpRUOKOmdTWwPCTwck4b
	 ucfnO7euLRhZi1M0MZt/WYTa3o5LKXY+T3rXge1ZCiMzGFLPxgWK+kIVw679POzpg
	 UjwuS9CNnMdj2wH3MZKukvKhM1ynoM+OpA+c8NFLydLnUa7RLezT4RUuT4z5PXhpR
	 DAiWVC8w/+a/OKhGan6/EiP09S6+Oc8xhZDU7KgS2MYzh22Ucjc+UiMD9xMwDJWwz
	 riVdYubHBOOcvu8r+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.101]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1tEMeb2umP-00mjeq; Thu, 06
 Mar 2025 13:26:44 +0100
Date: Thu, 6 Mar 2025 13:26:44 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ident: stop assuming that `gw_gecos` is
 writable
In-Reply-To: <Z8l967w0rjrnWGpO@pks.im>
Message-ID: <ba3bb865-d6fc-3125-e32d-935fa501c0c5@gmx.de>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com> <pull.1867.v2.git.1741256780.gitgitgadget@gmail.com> <3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com> <Z8l967w0rjrnWGpO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k8xKltPEDeHM79ayrwrt+zqrHEOFX0T3CsicBoyZ7nDLUTrKsvv
 jv0hc7C9pZhCIHihE3wCeyevLyEBtZiOCejUoWMLK30m++xAHVqxKphNhJOly/QPqHgxq6B
 +K6v5+yR0WIaXsMi+No2Tp7QiDf6QB5HYhYKxF1y5X0gnat8CCnplDAs8+9UPyzpWSdfsHZ
 caLVfJHz0O0gA0Er3pkig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dUdTI+JV7d4=;jQdV72bLUWV9jQ9HXLhqPCZqhH2
 26cB0q50IpILvnvq18fBgULf8z6P/opwTIyCR1xIv1tudkbY0C/Q/3Ro9w+ftAPGdvuxHU9Fx
 JGeeJeq/VIkYb2Se64p2vm1VRhg1d+KlVi00Bo8Pfa178NI0sWEVx+kkz8xMzTFI/srFmnq+C
 JsmUXz2jktaaadCey+JcnHqb1xVhVIvK/hNJS92zzmY3WZSXujS7ryVGha9RDMhDNC8sPu83q
 UmZE1nKK7AMQAmEBz2jbN0eoSBO2GWuv1dYLl8SsqJAqmPMkI0jLqYP0yT8iPQx868taTzwhO
 uNOOlf7Gho1yVUqrQJjssmgdmD5E/t8+jkV2+jkkxzkaa5Kd+rzXAuULF6LuEeD0UMNFTWI9G
 5ca41kWJqMp6DAc5+JgZJ3lOumG+fbd4quF8n4tIfrGvXVrOdzjJ3Ri5PoHIHQ7Da45zZsbGw
 BK6UorIGrDJ0f0ZPtN3BR6K5RQiheJ+VFJLtkqsGqshZditHz+ujWm4IlHE14gauhXAUPHhlB
 Kdx6msXH0HWCM6CLA7Q+y83Au/D5dsJUmCRhMnLgf245e3ixPygrDtIXG7bM/+vq1GAzOIlGm
 +CUwNbaW5jfx4RM8TCHPmUWes+a9LVyWfcIa3TomXcs+bIHaFLO11qLidK21SMXyezK9HlYeQ
 yN3zwQh6kTwAj6LchIs2es1NXlM3MTOkOoaOeEXDZ5Qa0szhRVi8YjWbD6cQuCQHbs+L2LezZ
 nEsmjs8oG/QF88tyhEwBEWWfZnn4yfnqbTM5gk/P7IGv15XepaD3MUQ2R/5hEKM0Tq1tK9dBx
 XboNeLtjn2Wehh1khETp3cA4mLHOzAlr6vZ8mw7PNFhqUZWBWlHYMLK07g5sFmjTWaXCwolxl
 xJtaF9Awz+tCUcZwogxqdMKh4SdbBTImqkikNDgz7nj/T7nAM2dmeQG6kUgBjrf8Ag1GdO8Jc
 b0TQUH6hM5r3a58KOGUTooWS666WYAVaYZYL0yxmxD9gdmTgph9elim2J2qxo69lWpckxMmU4
 XE7g9oBXmGhV1MHuP2ZklJLLf8Rhl3vaeZE4QoVP7bwayREQ6WsVzqEVjH3uhQK4n52IQeO5G
 qes3W8yk4hjg7MRx/pRzOfj30NQkJej5EnZYpUfkmCxfmv3rZKuW9zzwFqxGYAbychCv32Lbz
 4Owodx7PjaWZSRKwqKtdUHUVfH2eifnqFXKyP+Zygv04umZ4h3Eg0LviBSRQ5k9KggAO3356/
 E/weifuO9MhfhGCv1SLhiJPR10SNUuIF9bhnngXBvamGcY8XEyLFaVdF6jsQEi1Ogam6ul5NT
 P3BPA+SrnKNyS1wWTcWVMn9eaGREMsuzX7mIO4VDiyx/TKzYJGzSzlrLxhcoHR5PmB+ybM4pd
 tiaPvLDsbSwMD1MfatgUSA1UIr9ZUSJNP4UMoFnHIYP+G4eKH2OxmmmFZZPDB/ySR8UiiF7Ny
 6odrGVg/qQTWao0oOCAkGnwyDt1nxfp0arqtnyPNfKCQwh+0h
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 6 Mar 2025, Patrick Steinhardt wrote:

> On Thu, Mar 06, 2025 at 10:26:18AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Now, why does this not trigger in CI? The answer is as simple as it is
> > puzzling: The `win+Meson` job completely side-steps Git for Windows'
> > development environment, opting instead to use the GCC that is on the
> > `PATH` in GitHub-hosted `windows-latest` runners. That GCC is pinned t=
o
> > v12.2.0 and targets the UCRT (unlikely to change any time soon, see
> > https://github.com/actions/runner-images/blob/win25/20250303.1/images/=
windows/toolsets/toolset-2022.json#L132-L141).
> > That is in stark contrast to Git for Windows, which uses GCC v14.2.0 a=
nd
> > targets MSVCRT. Git for Windows' `Makefile`-based build also obviously
> > uses different compiler flags, otherwise this compile error would have
> > had plenty of opportunity in almost 14 years to surface.
>
> Oh, interesting. I didn't even know that the Windows runners had GCC in
> their PATH, and thus I didn't expect it to use that compiler at all. On
> GitLab for example we can see that it uses the MSVC compiler as I did
> expect [1]:
>
>     Activating VS 17.10.2
>     C compiler for the host machine: cl (msvc 19.40.33811 "Microsoft (R)=
 C/C++ Optimizing Compiler Version 19.40.33811 for x64")
>     C linker for the host machine: link link 14.40.33811.0
>
> But you're right, on GitHub that's not the case:
>
>     C compiler for the host machine: gcc (gcc 12.2.0 "gcc (x86_64-posix-=
seh-rev2, Built by MinGW-W64 project) 12.2.0")
>     C linker for the host machine: gcc ld.bfd 2.39
>
> We can easily fix that by passing the `--vsenv` flag to Meson. I'll send
> a patch soonish.
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/jobs/9324989037#L95
> [2]: https://github.com/git/git/actions/runs/13686408338/job/38270746786=
#step:5:15

Please do not invest more time on the Visual Studio support via Meson. No
contributor will use this, and I want to stop spending my time on this.
The user experience of configuring a Visual Studio build via Meson is just
too weak compared to the ease of CMake-based builds, and while not many
Visual Studio users are familiar with CMake, even dramatically less will
even so much as know about Meson.

I plan on dropping all pretense that Git supports Visual Studio-based
contributions soon after v2.49.0 comes out, e.g. by deleting the CMake
definition and also deleting whatever Meson-specific stuff I can get away
deleting in Git for Windows. It was not worth the time I invested.

Ciao,
Johannes
