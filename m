Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B911448E2
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818308; cv=none; b=TY8toWOxemgVk6g0n19pjuP9T7x7hUTB8aUEsT7mDyuL/LRCZfsy0tv0OF5+hvJG/8cwXKGHxxaX5sjxkHYErl9Rcv5/uLw6RoKBN21WbC5+IJEkH2c5DLeWQDG4za6FtJe0W7QRsuB0sn7ExWYb/S5+e97BtKKy+91uJSFnBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818308; c=relaxed/simple;
	bh=vOhgx60j18AVw6SiElIGfvpFbDYggY5tbmljggHe1S0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WgccJhrgh6m8hzbWVoPH4kfTwajDxh6oOsqzLtSaM4w4+EvJ7vV1zvf9afL6mB2SiJNtirpIZuGppC4YixoKYdeK85JR8Pkbqz0uC8L67eD+re+jvj4PXsV2MHYdILoQ7M1/bdqbFy/a0ZtxFYht2mSE2gGaEYj9onpaAecTf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=f7RE6P1s; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="f7RE6P1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721818292; x=1722423092;
	i=johannes.schindelin@gmx.de;
	bh=qF0SLZ8AaGxM4mgeThFsavIXdS+bhbplyoA1DoXD69o=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f7RE6P1sGGUpN503xJYFm7WqFYo4F9NpMiuGfuNPv3RBHpWPOx4ePa1wP+dpPwKl
	 SrOeAq0yiyJKQVQVMDk8NKHOZaoaEx81ggaPmvQMtYbL5fk5468WVcLNyUpELfl/i
	 1F54URQjGQOXZlTvnjERWrO/rSFn1VwyT8ueSVF8AihVHdNU3qLuKjnAzjp/jwnbo
	 Cc8DJJkvR/xssJWqSNss9xDebrQ6shd/YJfWU+ZluM8ACcdkrnwZW+gp1vN3mPIv2
	 mepenisPa7gAQdbI7myvten0ClHy3JB+UFmnlUGjR+8GDbGNQaBHqeN3+XkEGgHpx
	 bEVrkPHwn/dXVeWXGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1slubk0x6O-00KbYe; Wed, 24
 Jul 2024 12:51:32 +0200
Date: Wed, 24 Jul 2024 12:51:31 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Randall Becker <randall.becker@nexbridge.ca>
cc: "Randall S. Becker" <the.n.e.key@gmail.com>, 
    "git@vger.kernel.org" <git@vger.kernel.org>, 
    "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: RE: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <DS0PR17MB603115E943565C4281FBE199F4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
Message-ID: <43ee3c5d-66be-dbda-542b-cf186e761c07@gmx.de>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca> <20240621180947.64419-2-randall.becker@nexbridge.ca> <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de> <DS0PR17MB603115E943565C4281FBE199F4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jUDYACkbYLctEI5ZdMQyAJQKS9KcYT+i3jjAO9kuvCqNQP8wB+m
 jUHmy2gHUe8sFv6GUzWmX/2SBa6HeJDaVd461GKeTmzKuB+/D4rvcAG77yiLZAoWMgcrb4a
 swHwOWAaRXYYtx83L4bZ4eNBQD86eNByLq6IeRVRib3sAaTi46lSChviMsJNfQJbzczRrdX
 0SVF7IgaOhj+IinvVvpDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:de1vigr5Tm8=;jMOGeTfDWoGRz3eVsWGWZIpn3z7
 hzQR5+IKbwm60HfBnALlXyMyJW4ATVFB5gGpkvHohWeHEXWsykcdNClQU1zGtEdBjhFh/5Vzm
 C0hYJiX4r/BIASebldWm6aNlQRobBmAUAELv0ko+kEN3O8g53laOl4oRbQa3qihcnDwM+7lPU
 +GETwI2zeLf262+ILQOHhiBqAG3sNe43NNPJ/58XA+wc5uvKuFR32f/cMGmCjlWquvVXb8EbY
 SpfW4M2xHgkwcmCU+sMHTi0h/d3+/VZS3UtcUi36oUokdgKx2gdwOtUUGXIQKt83Xf8hJ6vHe
 BLQMr6YcupDZUlmS5hBhLBXOjJ6Rk72Yhvrhfc9b0tGPZsyRFdGdz5Jv2yr00aMmtHO2t750T
 7Sr8/7sw3BMY8XdmBIfFJag1yDfyFVriLGM5lEGQIChWZ30ubkF5AO1O2o0hoO7lobQCfSATL
 mM86XcAHA66atpJ4eq/XKDhyTKfTD9eCAmFWsbR3rvUazSs3UYygeuo6NZTzvGiqZ0o8C/tQN
 tuMysab+bS5TEMRZe7FGM7UzrYchFtUiN6dQ8k5NuAf5oau2bCpWEAUBnRlDLrejjZSU0DKVx
 bFncICy/tR8m0Op/NfiQf3+GwAYUVS8jwikrQx8U8MTXI1oLvw9onRx18iu9Oe/BDfS9gSuK9
 xe8TAuVgF7pPWVfvsedbgM/nevgp1zUswFlEw3XDYOs/EAVB4tUoEeqVaSaKIihSwfWQhdv4s
 F1bb9wvDE3qFR0AuUSQjnmEdtqaLP2Ee3m3dBE4v+vC54Bg2CJHYPz1aKteMohgST9f2eTdFh
 RehTaT5zza+uUMkhzbcr3W7jIIlTNF7XINNE1hpT7sybQ=
Content-Transfer-Encoding: quoted-printable

Hi Randall,

On Mon, 24 Jun 2024, Randall Becker wrote:

> On Monday, June 24, 2024 10:13 AM, Johannes Schindelin wrote:
> >On Fri, 21 Jun 2024, Randall S. Becker wrote:
> >
> >> This change uses the libcurl LIBCURL_VERSION #define text macro. No
> >> stringification is required for the variable's use. If the #define is
> >> not present, that version is not reported.
> >>
> >> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> >> ---
> >>  help.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/help.c b/help.c
> >> index 1d057aa607..bf74e935b9 100644
> >> --- a/help.c
> >> +++ b/help.c
> >> @@ -1,4 +1,5 @@
> >>  #include "git-compat-util.h"
> >> +#include "git-curl-compat.h" /* For LIBCURL_VERSION only */
> >>  #include "config.h"
> >>  #include "builtin.h"
> >>  #include "exec-cmd.h"
> >> @@ -757,6 +758,9 @@ void get_version_info(struct strbuf *buf, int
> >> show_build_options)
> >>
> >>  		if (fsmonitor_ipc__is_supported())
> >>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
> >> +#if defined LIBCURL_VERSION
> >> +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
> >
> >I am not sure that this is the most helpful information Git can provide=
:
> >It reports the version against which Git was _compiled_, whereas the ve=
rsion it is
> >_running against_ might be quite different.
> >
> >Wouldn't calling `curl_version()` make more sense here?
>
> I think the more important information is the build used.

It may be informative, but more informative would be what libcurl version
is actually used, not what was current at build time. There may
occasionally have been a mismatch between the build-time and the runtime
version that may have led to bugs, after all.

> My reasoning is that one can call run curl --version to see the current
> curl install.

That assumes quite a bit. It assumes that the libcurl that is used by the
`curl` executable is the same as the one that is used by
`git-remote-https`.

A very large chunk (by some recent internal measurement, roughly two
thirds) of the Git users use Windows, where this assumption would be
incorrect.

Ciao,
Johannes
