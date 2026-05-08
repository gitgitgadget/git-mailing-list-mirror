Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DD37189C
	for <git@vger.kernel.org>; Fri,  8 May 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225819; cv=none; b=oz0uywx+6jgtmbT2x7bOUbNxW6QinAG5jJ937IW07ChLppLgIVXYBImJ8nY4V06jIMHXd6zwMVPnLowXTryaNbsi9Ux3qjYc26yaKAKq+qsGoVNfa20GOStrqr1RpKbNvVkhirFQpFwl7OZMalqPDCu91LNlCpbquFgG1oz8oW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225819; c=relaxed/simple;
	bh=rpVbx7KpQguOBlUPx2vhJFJD/ZdoEoCjRolPDBd7IzA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d7w/9hIZ9tFGbzG1kxfTETiJK4mG9XPPW8nCy+NAD7Seko99z4jFTE/rzaQ6H6jkKrUXnvA6Xow2JQbVEPci5qkH/4nR4D8/gN8lARqXe5h88/JNdlJdauUKo/2wpQgQKsW9jIloV7YbuKbQnFhn6sy8QjnaC1gHIzmeCVodPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=iOntFVr8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="iOntFVr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778225814; x=1778830614;
	i=johannes.schindelin@gmx.de;
	bh=y47X2OSz/EIHluY0E7nVFQ8hr7TxWt30SJNgo7Dyvyk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iOntFVr8mZ/ZtHV2PD1E/LeVonuo6ZUjo8mcrNpaOQCU6hMaio9uSr62LxYtA5r0
	 oD1X39XHRa9QETLw/VuLF2PFFTKubLp01aZrA0DAuQvMJuVmKDGvWJFg7/0vSoml5
	 43MC31tv06MB3NJZ6QK5YByF5xwTglqwEb4A27HMzONTenLB2o0xVeelJVnKCx5Ci
	 1yPuNpNYT6PnVt7UBdx8sf8rm28JxFg2m38yTM82RmgJLNLMY4RX5d1NEcJ/TuYjS
	 jX6ZOzlKVbV0V5tbxZPKUfG0yLh9m+IyaJAYjUaUWmcaEenDJcZY0jkNjOe5xIrvc
	 esQfucGRno6xdjRouA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1vVzqa3J6M-00gpUQ; Fri, 08
 May 2026 09:36:54 +0200
Date: Fri, 8 May 2026 09:36:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
    Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/11] index-pack, unpack-objects: use size_t for
 object size
In-Reply-To: <20260505191100.GA12275@tb-raspi4>
Message-ID: <fa39d84b-ddbc-3943-5cca-078fb18db80d@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com> <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com> <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777914508.git.gitgitgadget@gmail.com> <20260505191100.GA12275@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-469213181-1778225815=:12327"
X-Provags-ID: V03:K1:6rz+fJbvF1VnLsszv21UAVCw8Lt/aNFJkA+myBwh2tsp0/V+hAQ
 /QaTJ2vpIHlYRezdY8ll2R1smPnfpxlPCo8DBjHrq9/s4QZe62P7dtsAwLWUKIyXVyo+IpO
 AuTYCL/kknl7pgqTrmacgEZQMy76lnpCYhkHeoDee2zp1wz84Vs04PqarnvUHP5U9M3mHmK
 nYeBRXVmCi3d89fpZjW6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KopQDr7zK1w=;MM4eM9Nlxg9I81YQuz3Ytc4jNqD
 bUH6U4hkgaYZjRyajxieaAWHCOaWgnGraRFwqDSwew1SfmH/KX7XcisalKN6vDo2JaZKcPC5f
 QJ1A8ciwMyQ6OWgxZvXp4MVdcIjS0zmxOwsvUqSryRCJ3Rbt3vUc/ALjFdEQsrq1N9Uc7DUX0
 3pTFIdeEmL30ZHwrn8hWTJCH9YP26s3OMKCebsSXbF5MS2SCH8nIWX/Ynlyw9DyQTm7zehXGG
 FuaRnDxlTV2duH9UMr9S0UAE8docdIT+HSt1Elc1OsIi7TY0VFpEYDKtkZS5taAi2T9qsnc+3
 NSrcZHaTRWOw1nfvpWWS2KsIcPoHSLNKPibZYocHVOLKanXyHFYx/EiT07l2afUfCjACgAdvt
 GMnD4z+Dd7W7Z0B3SffO71NEVENl0vhkOgfpFMdh/lV9o0Bbx7X29GNvMsK2/HZuHM04lRmUo
 079OMG3eGmhj9J8w+CHHhn843SgM9fgbbk/YXV7BRpDzMhOXaUaRaJ6cHvV/skUJ4YFxiKVSR
 fEzAe4gl29N9EfHftUjZ4nSMhWoXUlfUAMIe2+LNvyfSx4jw+ELYfk52uOR8KqH689N40spD1
 VcgLctMlQFH7ki+emS04z1K88NX2l46/nwUvO4tstJ2FsQFVEKv3+xAR8OGyFPWjJ3QfSODaK
 ongNr4hD4qrJNFsfUYa8M1JysHuQuBtH+xNZqjXhBXXHYBpS47jJ+v5WdyT6peYLOhHd9QILn
 e5j7c3Z322RRpQjba/qTjRTZTs2TRH+HUU4DvrEEmY2uB2Nxz5MWm4zr+74sj9m5toDx7FDrs
 s6d0F7sEKfEPA77FCUz9Zyly7Ipca5jJGYXi1qyL55kiUUX2rbakpWevsy5N0O/o53Zr3TFMV
 ccvK5pIe1RQ7YWIatWwrxlgmJyE1ya3UWVv+Oj2sayNACBjBR2njqyeb8UR59nAcFiZDbrKwg
 FMInSepAad0z3e+SXajIeQ1i/sXmSSaH4DQctuhr4jldJqlw6c782NCobb4bWl/XkfW7uedft
 von7aDOtneQt1IkksQdCBiyUtHAZzRznDY+cT+RrJZ7Tfnsgm3HMDxxj3cX/MNI9uzptJbMIw
 yOkjDP0hZwobhxY+Z1sJMUqG2gbh674zLwhRIzw7mOn/UOQztRw3VE0l/4fHvL25P+K5dUvBc
 LW/hBbSTEVhlda3C9ef97CBLzbGvckEbPi85ij9zjZstnrll6oHye4Jy8OWIcZ61FNVvvnRgY
 yUVkihEouD64RG95LrdY3WPrrf68ogCFLmftvRTGe8cPF3gvOXxe6FoKG/hU/e4TLaViQWXHp
 NHLNH8R3sYx8Q/A04GzIVSU7alSLdITVyAojqSKP5D4fYZrf9MVjNNrlvaZ2vlSBBFKD/KRYv
 +qrwTkdLBZlUtal4X2j+ugWP2CWP3H3TF7LMoMGUdjYgNJEQzNZ6XqkFDT9ya/vlMbM0NDm3W
 D7LCadGrYCZ3MfM72a99wIb5CAiX/efj/r8y3endEZ4D2e6j5Kfff8oQhvOvkDLO5J4rx2ia7
 9ZKJCXlr/+LsQA8WlXsSW+gRc/fIZvbSdEMEJLSGujawTfyg54Jy41nKbhJ8XGPnH7ath1xhf
 fZTaSL9UWDC0xlSJPIDy0xR5sWQ0eYDPg3xdnn6ZbK/kbdqRp/Sdt0iUlKcX40OQmLAST2jbz
 /FJSJV8gYLhgj7bgUQFCd61Ti/lCc3SDZD7yE0SeAT2V4rt4ZV3WZZf/ajtQxdnkQ9/mkp5LR
 ePCW/Km/vk97zD1Z8+glYqR6HTLBYPoMlESv6PR4OP+wKR4EcYnjPuFH5/J2nsJoGIRqbaZdG
 nGBrpsBat46jSVGOPD3K2xwPVEyMid/PeqIsz+42wR3GqVXzunVsCjnwmn/21Tn250srZoL9C
 1ZX0IWPlhi68mc/AAj7gE0tVnMysYLR/L4mtRmdiziY+APs4SkClRX2jhChfVq1k1+ciuOltn
 b/gJKAQBAnINycAvNEHoNap/PcdR35mL2QrI9oE3v0cIxgFUIv6xdwSFYtPpcISyWO0WoVFZv
 vxkisjeke4CB0oEck8XOFnG3U0D6G6jJPI+C3BGk+SUIv/VnnNMNR1/5xYiER40VkRkt8qMwI
 41pQwIqIo31WeBUH+bBIqab2HtveOxlYw+WSwTJkmqYgnxNqqB4GF6NlgrNJ3N5uHRznvcjCA
 33gOEYEbNl00/SNEDskiIVmigPDPFR6QzM61RLF0PF2It+4qkoQ+Ixw2YuXlAaBrzO7C3b7pk
 JW/6SF1LJu6ddnlj4cLYTvVivlOVh64UdtBZKGPPnLmlFk+WZlVxnA56SuH1bpBQtQD00jzBN
 fziAncCaNUcjASCZEEWzHGrTroETetGzZwFNOD4Zf902C3vhTOxvKrUEs+5htMPjLvKAlfmmk
 yge8Zk4Dl84AP7DnBXYlNdkj9Eu+3uMJrTh74cXiRxkdR5gZK31DPgvF6ZnWlm9pR/HexecKQ
 JExvG3HraPR+E9lqPoXC6p84R4yKYF2EEJvCuMy7HUJcdEJqtXfm3Khq6Hd4q8rGzKuEkiI01
 d73q+qhKlbb1WOpsZitVP//4+d7Sj/piNH7p1RRx4GfUYClayd6avudXvuPrfde9f6xYHYHPb
 EMdzzRxpeNSu877A0FSMqUfOdMJJmMctekSH8TgBE8aWycHNwQQ67kPWp16A8ETBMGGPlvueI
 qkHABX66Dpu/UEhRlK7+gY+XwWYEY0YhgfDqt71cTSmG0DWKUTDTe/X8kGYOCpN+XPJTHMHKm
 sAkAGZqRKGqcobTBBFynyZHe7tyg93yn+r1/yY49oss0jMLwnXpP37sMc7ZlDVQSjpfMvNLaz
 KmQWBkKFJLUVoDcGXAvOaqiOQes0YDd5h1TSdKLfVHcz4FBb7uApNV7XZvHGLoMXhbaWtkWl1
 iHzca/6R/UYVB2oark68bCdYRNFbD9M65vt5HB+L4ePzCWnnTegP+IPQ3VzeR77MKA05xiP4b
 OAs6OF4D8xzFw7uhjx/PjUmZ2eE0YDr8VqM8SEqdtazfsERg9JjUehQ4jBflg3EOwXrholpTP
 ey8S+UgJgewDZXV/+vy1rL0uyNqA1qJrRLofK00b0apWuMsgQ+LrUuFk25cuMeVcHXV2MwWOi
 3xsIyY9biQL46MmtMSZRxiH39fZCOGHZ0F2YzxZvgcLUPrE9LskQT2BFeLUs9DfSOkDX5+8DA
 hdBaLNUNmen2KcsC/xuNVwEZUuzvOXC6UBr7TeJVl07ePVaEYqs7+wcgeUhkQKkqy+uiguSmG
 1bCCXLt/tLm1RxSUJy58c+Sz00WLFUFLuCo5sjTh5V7JzZuhh6c/UfiqRalnBj4FWLr73V97k
 +skL0q34xXDl0jEfsdht+VJaLIcvqebHd7AICOdwu+JZaQjuEuHenUA4b+2C8+Pn14AA3K/uw
 l8BtA4TFI/02NC+JZiA7sQTCj2vu6C+XoRISwIcO7tRx543P9v89TUqnSo1LsxW/y4YQGyaYg
 WUdrt9nVighDaT+Ri0mIMNMZsg4KLtC8dnwRJR0H7T1xmVFz7zUR9m7s6QLUGtK+ig04r7naN
 N8V7OH5aNMGqztv6QMOGcOjJdq+ZlMBzrhx6h5AyoLwswyrRK0jb2WL76pmehPxy5HCX9MF83
 YG6jR5BklCcp/A2tRoEUQn9s+ySv91Gg4A2ZZ3I3ME85+5GmiFQ+a+3/ZwXa1od/ABlWQTz1d
 RH5Zjck/uTg/9oB/ItwhDZW5xF1xGwoezWajbkUlkvJp+L3tTyr5ou+bYvjrEhMRSdvLTMaUD
 JZiVqlpG8OpxzkdRiPYrOg9TAbu0BpFJho4baq3uDARv/gChXoRZVmPTc53WGvTUU+WZLjaGN
 RpQTI+kyYlHbY5p/yOo/So0SdGrFxTOHYsCSpoEhDmTFhhR4PGdf760XA3cEnT1PmdBWlmONL
 NRHK6vUt3jc7Hdcd06VXN5efnvXYqzhu5sqg7nlQUVxzjUJZ6c8j2fS9+7neV9lw1eLNJaqhR
 9CTqWSn+CuqpzZ+KAcnBmBhb0IX2Uklb2rhXvnFkM/KVh3DgO8UHA45EiAakjLXxiLBQbbb4q
 aMN6GY48DKhVlJE23XInrHWIslKW2O2RLN80Ix/uX1abfdXqqGZwQ+JHhaYNDf071beLSHAce
 7JpQJxmSzzbL87j634AgseXi0CYBqPHiSylp67m4XlVbKpnHtWB6UhswN+ZdZQzzRPxTamnYa
 2IQ8f4UGsA5S8bMPYd4RJ/qfQYsBqhXZxVWecUY0r/WrOOSr2/RkWSB1FzPbmwbAMsSD/w8ts
 Hq5r4q1te9PFtAz4W48eotBj/cHddFok0c3daRwg6bEY66XSrRzaGsDHH7PtBnij7ydBrInGc
 MDCbwjo1pTbdJ4R/OV5lN62iIYv+48WcXnV+W/NNLyr0cCl7PyTWhnODROKHxlF9K7hSHBr9d
 FuZSEH3K3xaYVT1TW3l34CDfsUCv4GxesfLAETHxK2MS15V5oyQq8Ya98r9Uj/QKOJOWclkYw
 FKx/Pw0JgIfodO46LgWdzfuu4Uz6XrIkKTEUIRjbHXNFgp8HzuVqcGYbO7QLpUKs4STaZmHst
 ypDKfob29npxIVDZHZf3QAxu13nUjf4SyhZhH9k3ulvw2e+za3O5XwDORp65Nk4erqPDzQd15
 qObYM4UDAcsU9eBf/koP7/iccJBSce2C66KM68LK2EHngfTj8mFisWRLv4Ndz1ZPyjieFYzvg
 RbRtrsTHqv0Oq17TYufeDv56f+9jbN/H2p52pURNrU8VxsqYLo9ERUBGuqzAGYD92RpT4TVXP
 y1c9MFDKPoN2di5c0Ua8adxZSzp7DJLFxyN1Gd9MpQiYY3P6U7hqxMYXCPDinWeZn9aD5efha
 0ei80Sx5JSnpNu8NeUeRaXW6VVw5L+aMTkArIl5QZmfZtzaXcRxCnwBj4IwS4pUVVsqTwf5Pv
 tB1qMnnjEnr4Y5F+9fVWyweT6wAfLkgaopiqFHpxrGmy5MuzIcPxlRmv41nzIvFeEomt9dnxp
 XmuWdWv4dJbF8vXNCMtOHCDl/+GRNoW/Z4Y022TbeNzKuRemDkO/KdhssReZSyYZJKrqOR5QC
 sPw3lAdxf4EkeIAGBaC5/A/Hzk0HRwgdbLuLc3Z/YtIqB2etI/sXLOiK2YJsnZv3DDN8PTIJV
 VW76gkUw+ilEWBmjbvgJiLRtIB+hVdncQwf4YaIldkiN067FfdWUFXsnvm6QUROrgj8zaNW9t
 IW6qrKdijCxNBfoCnFumchqeOIU8AzNhQS2d62UKSY4IJtHpX6iMg7bOOYCXsPx/w4h/GZsvz
 afrqZRM10CFXiHejczkV0lMVhnYabrxLXQ1ql+uzBxM9n7mJTM5Y+7dxqGApCGnnOanQhUvbE
 L4K4LGhO51qJuaGrDNaehq/LsiiOuev6p8DiOa6S//4DzPQ417EcgvJY+C1w7qyOChrHNy1p7
 INUJDxk7QxxcufjuhUWtVmAKcSBMnQ4q3ohH//B4x+GJXVvZsTCVjF3TR9656cJS2ccDODeBT
 KqKcIvn4iOoWhEVzCKOFx3JBYI3FVgyC3DJtLx5oErlmbCK1FCnXb1LQDYcTJqCyC5KEPksAY
 LdW5NWPoTBoZRUPF1/3ddlmK7L8=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-469213181-1778225815=:12327
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On Tue, 5 May 2026, Torsten B=C3=B6gershausen wrote:

> On Mon, May 04, 2026 at 05:08:18PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > [...]
> > @@ -524,7 +524,8 @@ static void *unpack_raw_entry(struct object_entry =
*obj,
> >  			      struct object_id *oid)
> >  {
> >  	unsigned char *p;
> > -	unsigned long size, c;
> > +	size_t size;
> > +	unsigned long c;
>
> Does this look a little bit strange ?

Good point.

> p points to an unsigned char (better would be *uint8_t)
> then it is dereferenced into an "unsigned long".
> Then it is masked with 0x7f
> In short: should "c" be declared as uint8_t ?

Almost. It should be a `size_t`, so that we don't have to cast it when
shifting it. I'll include a fix in the next iteration.

Thank you!
Johannes

>=20
> >  	off_t base_offset;
> >  	unsigned shift;
> >  	void *data;
> > @@ -542,7 +543,7 @@ static void *unpack_raw_entry(struct object_entry =
*obj,
> >  		p =3D fill(1);
> >  		c =3D *p;
> >  		use(1);
> > -		size +=3D (c & 0x7f) << shift;
> > +		size +=3D ((size_t)c & 0x7f) << shift;
> >  		shift +=3D 7;
> >  	}
> >  	obj->size =3D size;
> > diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> > index e01cf6e360..59a36c2481 100644
> > --- a/builtin/unpack-objects.c
> > +++ b/builtin/unpack-objects.c
> > @@ -533,7 +533,8 @@ static void unpack_one(unsigned nr)
> >  {
> >  	unsigned shift;
> >  	unsigned char *pack;
> > -	unsigned long size, c;
> > +	size_t size;
> > +	unsigned long c;
> >  	enum object_type type;
> > =20
> >  	obj_list[nr].offset =3D consumed_bytes;
> > @@ -548,7 +549,7 @@ static void unpack_one(unsigned nr)
> >  		pack =3D fill(1);
> >  		c =3D *pack;
> >  		use(1);
> > -		size +=3D (c & 0x7f) << shift;
> > +		size +=3D ((size_t)c & 0x7f) << shift;
> >  		shift +=3D 7;
> >  	}
> > =20
> > --=20
> > gitgitgadget
> >=20
> >=20
>=20

--8323328-469213181-1778225815=:12327--
