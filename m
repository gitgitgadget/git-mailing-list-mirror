Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AF416124
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133197; cv=none; b=GWg2yig9FGzlgzODA0h3jOcfjQ4ZarN57D3iXW437qBdISWbX5D17LHbrzhLAkbjKPGbJTpfhBGwhX5IIq6rADuLRzhNuiHhT7xfEKUGarzMNLdI7N3yPiIU6L13yJfLLXd84+c5MqlPM8WVwOJ+Z6nqTqQOHBMRM83ApZtjW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133197; c=relaxed/simple;
	bh=JgC4nTBLMmn9ApMAxtLWP5DSA/oEriXWyHVL/GJJw7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM3w+/w9HfFSeKKyU/FMB7IvZSM90H/7DycRoL+YHBgW38rFhmKqOfbLuVdCsI3MLI6BWOQzUYEXgovQAGXAZuKVlUTBBdKoCFWKJM0DE5L5f2Gm8bccC0edUacfgnUl3ApO9cYO21KmN2k0cyqpcEq3lauUZ6oBN3E0JLq/BLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=FQVC02DI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="FQVC02DI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789133193; x=1789737993;
	i=oswald.buddenhagen@gmx.de;
	bh=PTbFmmdUx96rAdmWZADreUTyT0qDPXrunW61IrUpwM8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FQVC02DIL7J78AgZtvh7RUoxstHNI9RXB+FvpeW0Bc4KiUEGn3op8rtxLsNATm8Q
	 r2PBtR8U0HrVmJ3YMU35CZISJGfBlLoR2tBbl1xW1mYN2d3wNoQPboVjVRP76VVBt
	 2y/rAGutT6OWh765MhNZ0ZtkDk1hnu1YU7n1cpFXIbbZ6dJnnIJXcOXE9bBWNogPm
	 9CzcgnFwr4z2XUz9tQfpguXqUx8fgjImHVtCzywTnLhIQlyRLRMPb34e1kEtzdaTy
	 T4H6GwJnLzfglzmioOu219Ii+9Y79nTtuOfcY9Vafzr0NzEpHHrH5ghm9O6YySh90
	 ghe2//v2+VCjJ2krRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1wUrZl1Xng-00ggaq; Fri, 11
 Sep 2026 15:26:33 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1x51Gy-D7J-00; Fri, 11 Sep 2026 15:26:32 +0200
Date: Fri, 11 Sep 2026 15:26:32 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 06/13] mingw: set the prefix and HOST_CPU as per
 MSYS2's settings
Message-ID: <aqQBiGCuZFiafnlJ@ugly.lan>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
 <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
 <e03279a0df02d772df112a9ec8ffb9be58485440.1789020327.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e03279a0df02d772df112a9ec8ffb9be58485440.1789020327.git.gitgitgadget@gmail.com>
X-Provags-ID: V03:K1:eRBkrhQy+Q/HSt4rTcGyOwNQiF613sLPsVRWcQ8HePk7vgT/i8b
 ZB95BRL4+YjNH1sym6FSjGodZHkAKi/xq/fKFmrXTpMGh6u+j/GGLHH7sAnEn23QSF1/qWX
 Onk8H3DNHeO+f6eh/LAIvKz98tJe5RQQ+bmmZjdURU002sES5IamY2c9HXT80PNBNjLqRLE
 eeG05gspvo0YNb38kxySw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K2gwSzkcViY=;ii7z+MZcyEtDryxjb1PRN+CRahl
 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
 g8ilC7/V6Vx85
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 06:05:20AM +0000, Johannes Schindelin via GitGitGa=
dget wrote:
>+++ b/config.mak.uname
>@@ -754,19 +754,13 @@ ifeq ($(uname_S),MINGW)
>+        ifneq (,$(MSYSTEM))
>+		prefix =3D $(MINGW_PREFIX)
>+		HOST_CPU =3D $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
> 		BASIC_LDFLAGS +=3D -Wl,--pic-executable
>-        else
>+                ifeq (MINGW32,$(MSYSTEM))
>+			BASIC_LDFLAGS +=3D -Wl,--large-address-aware
>+                endif
>         endif
> 	COMPAT_CFLAGS +=3D -D__USE_MINGW_ANSI_STDIO=3D0 -DDETECT_MSYS_TTY \
> 		-fstack-protector-strong
>
this kinda worsens the unholy tab-space-mix in this file. tabs would=20
seem like the lesser evil in this place.
