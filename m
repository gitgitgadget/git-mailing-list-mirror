Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45B15B0F9
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699421; cv=none; b=CSeJ0NPqosJuhibGrsnNfY+VKlNF5A32KS+ijJABwHZFso8LADm2um1PTPfvhrVPov0hN4uhlb3Oc9/2fwQxwIFZrO29oeYqmaLCv9O245tmnSPF2WD1mV7Khtn7FLkvm44ZHtwjWu1OBsWVfLAnLh6fdjIRi3Wz9HB7YPAzI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699421; c=relaxed/simple;
	bh=bZXNi9akDZF2r910OiOElkF6lHacl5qsGG0iJAfFqRo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GV3PpppWd12O0Yb1STw/g+qZsz9g9KGyC86fbCjbO+2/VivovdarRoIDyHv2E0++ZY/O2miNmcFT2DyTmeJgCEamzBUkZFHrFduXwcTsS38kOVjItOayW3P48ux+zS9SNIP9gxUoKsepyyvnPbvefxwX0Yk95aEa5HwiLtSBpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=SOyIXF1r; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="SOyIXF1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720699404; x=1721304204;
	i=johannes.schindelin@gmx.de;
	bh=F78m3v/wG1FSS3YbZbw0QXYEOVI6GpKpm6dve/qA9o0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SOyIXF1r/rwVvr08Ia8nGMi7G5gzP/nM6Pj/YTQ6oPftPHSySOA7lLuZDVzFw41L
	 X1ys+GbIWTW8MCU54oJR/EYEDfKe+p2+izD4TyfRx3JAQ8Y/Qs5Tya5p+vtvTaGH9
	 dYjXwTT4Ehs0JEYjIReGGrWKRHLxfBXewvItwz89SEmmXCXEJLMX+0GHYx17xe6Ut
	 yAfV41VAfPZ19qEiunN+i+qmCzXEFVD1/tnDKgqiZYxR2+oaBqaLEv//665u7DeZy
	 AWfT++/Y27mjqX/WI6v4zP8L78LUE2sFB9S7ZfjYV1osfbYQRLh/p7pY12LUBQ67m
	 zACTX6AhzqgJkSwVnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.84]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1sZLJJ29rx-000urr; Thu, 11
 Jul 2024 14:03:24 +0200
Date: Thu, 11 Jul 2024 14:03:23 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: phillip.wood@dunelm.org.uk
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is actually
 used
In-Reply-To: <8612a47b-18c4-4071-8827-56b4f3bd0d80@gmail.com>
Message-ID: <66345b2d-6662-710a-5513-6cc70507b4d0@gmx.de>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com> <8612a47b-18c4-4071-8827-56b4f3bd0d80@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YQuOb+slHGrGG56+N6kQ8SNpCfcGgQetduEj+cO7t4Fr0QU4wVP
 D/Vo7uUw9bs8sBn3sOsNj1t8CiD14d9A3SqIns7aZ1NgU4J7YGOYhXXTZd0IWdBhfO8fOmK
 rDmMye+rgd3a+q/m5xCHFGzoi7ZHkWWCOqsuNJ0kcBK16u4UKA6yUtl06TPiMyxOZ3AjJ50
 71K10Gwa3ueZL5N08PjQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tKkApB7/5w8=;usjr6688e30Jh8pXvtJcmapOtxP
 xbeQx9C5VKv2ulGBNAm/J5kP8FNpSKiI45ltO+5uBXTEwKIo39E/OOawIpvvXam49NTQWVtxG
 5r6kBmaK2SFgIWgBXNOu33+eqfS/+8kA49H1ydztUQh5rRG47E/1Culk8RzKQs0ohdMoVjqre
 rjBKL9iFSQgAzFOLNH2ndx2mdsCmMuv9BYCyjrfppxGMtxaqRQhKOHvuSE75mKIjOqWq//8+c
 60slh6xYkykEreCcmaDTA0qwHrVJ/avwjrJXLY6+VyPeCbtb+Dhd21vhc6luZ/7BVrcL4ic67
 x+8w3Zm8O0LvTxsh6raQnywLub/Lts9mZ8W4IYegUivWaw/myWDsOhIfTBx9iOOMP3aB1xXnh
 m4rjfY5piM1rEaXkXfDyDdZNrRMnrn4TYqCWAbDAOfFdDWhMqmaInlVat4cqAU+5DhdgOaBb0
 0J4T4f9WFCQsrWvSjTAWr6y8yU3SH2VakYCJUfej2fo0fuXqgTO1PpeklWp6KlQSObo/W0FtW
 So/+iro1UDQ7APRCnGW+mgTYAGw10edW4RZg1sktvuctNUza7Zef9Hj+J6JeL1h04XeOMhTTY
 6OMt6uRzrL2m+8UDM6jNSOjfCzUmWUj7B8z5Zo3rf7WHfFUGBCDQDSFfqT7UU536eIjo+N0ra
 6knYBTqZMq62XBwqpkAMUJHtDtmWQk0BtoVI99Vy3Lww4ysNKrsYZfN2qLGtdvPsgsVwhwaqN
 IdKLz5ACzvO30DB+oEsrOwVOrwlpv/g46qLILauDzJ1Gbthm8GtRWzqOjsWMRUdayYOs+fhh6
 S7U3SlOh7KIwhYWTj1NyGX3w==
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Tue, 9 Jul 2024, Phillip Wood wrote:

> On 08/07/2024 14:02, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Thanks for putting a patch together so quickly
>
> >   static char *shell_path(int ident_flag UNUSED)
> >   {
> > +#ifdef WIN32
> > +	char *p =3D locate_in_PATH("sh");
>
> If I'm reading is_busybox_applet() (which only exists in git-for-windows=
)
> correctly then this will return "busybox.exe" under mingit-busybox rathe=
r than
> ash.exe, so the calling program would have to know to set argv[0] (which=
 is
> likely not possible unless the calling program is written in C) or pass =
"sh"
> as the first argument. As the code to support busybox does not exist ups=
tream
> I guess that's best handled downstream.

BusyBox-w32 is unfortunately displaying strange performance patterns. It
is partially (and expectedly) faster than the MSYS2 Bash, but in other
scenarios it is substantially slower (which is totally unexpected).

Some time ago, I tried to make this all work and investigate the
unexpected performance issues (and hoped to fix them, too), but ran out of
time [*1*]. That was almost two years ago, and I am unsure whether I will
ever be able to elevate the BusyBox flavor of MinGit to a non-experimental
state.

My original plan was to eventually no longer include `busybox.exe` in
the mingit-busybox packages, but instead a copy of that executable with
the name `sh.exe` and thereby have it work without that hack in the Git
code to call the `busybox.exe` with the `sh` argument inserted before the
regular command-line arguments.

In the context of the patch (or now: patch series) at hand, I don't think
we need to let BusyBox play any role.

Ciao,
Johannes

Footnote *1*: Interested parties can find the latest state here:
https://github.com/git-for-windows/git/compare/main...dscho:git:busybox
