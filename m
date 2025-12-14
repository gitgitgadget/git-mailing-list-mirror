Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC52D0C97
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765710833; cv=none; b=iCRZByMW8c3VY7ESa1LlmggobMHtFrw5i7BAkwD7pSqQ2KPX47xzBWQ48hthXDFHnGVO3K3+6aGUCdXyLHa+Y/tWOTiAWW+2vpUsu5uXS9YwjrTQFnGYKm0/ObVNJWkg5tOtgZvoKAl/usdNGeI5wLSxnx0QXWZB3rTr65Mcbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765710833; c=relaxed/simple;
	bh=+ahQrJAJ4K0yRQxUYqks3OMirCsfSINHwJRYSHY/iDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKKh3LA9nsQTOdwV5hP+LGPoNexPY97W3274LUwS/omoUI3m3Dt3twEzGXzTpbtILn3SDEHBuXxL4tbGNf130BqK1srs/SKjxs0lRKfmtklhrl1C7BmwnH0G38gL/Y1kksCeKMNVX/NhDmrWI+womf/YqvMUe0rfzRFnNwqR15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SeNCnRIG; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SeNCnRIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765710826; x=1766315626; i=l.s.r@web.de;
	bh=WO6/yivN0MPVGDWl7OLB68vzL886umn5rHy688GMaYc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SeNCnRIG0maLrYKbcGbp5L+G7Iz4yAqsLAcKGYEwC/ecnzD7oqKH1OSpFJCck50w
	 T40Qji2AObzqeLJHH1zJz6bLxmF2BswxzZUqTyYYEXP7+MbkXz6hGfkJ4FlD4ZWP7
	 PUyr+hp/Vc4BkQe5Deo62xn+P2SmoGIGUsEUvI8xgF7cL4M7R9If7JT2gUObNGh2S
	 dRmHsl/xu5ZsUkiVB4spcFGfXBxCVdurP/vzT038cIU6NKHuEQZrWLY90mgo3Gt5J
	 ycuFllQ8g/RCvuG9kLvj5DPa72hbN3l3bXZSVSYyFp1wcLyq9NiBsjifUqmiozNgR
	 b9XLh+406AOihUG09A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5bV-1vWCGK3sNh-00O86d; Sun, 14
 Dec 2025 12:13:45 +0100
Message-ID: <435e4190-6c46-4404-b769-234f704f608a@web.de>
Date: Sun, 14 Dec 2025 12:13:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Makefile: add NO_HOMEBREW
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Torsten_B=C3=B6gershausen?=
 <tboegi@web.de>
Cc: Git List <git@vger.kernel.org>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
 <20251214064544.GA26358@tb-raspi4> <xmqqecoxa645.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqecoxa645.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yLjrUh1web7FqKBZwozpp++923a+pOQvoHduv/Ym1Wlx2PYZisb
 M2TYi8U7vpshHfiNJZ8y4MaIvjf9NeKjL7pJ9SD6YSZ+gau8yy98V1brNivXTJETaAnZ4ii
 smSe5Ufu9Oul6CuaM12+A48Cf3OAS7SK+jhYdiKrvOd9QJ7bNqu0kXoiMddx4bKk4/XPArc
 t60p1JFn+a8TIwgdSCTXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YIN1Tb6LESM=;j86T6E1h+K9Th8/mHxNLMFzkV7b
 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

On 12/14/25 8:13 AM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> On Sat, Dec 13, 2025 at 07:42:38PM +0100, Ren=C3=A9 Scharfe wrote:
>>> Allow disabling the use of Homebrew on macOS, or Linux for that matter=
,
>>> like we already do for other package sources, MacPorts and Fink in
>>> particular.  This is useful for packagers, or anyone else who wants to
>>> control dependencies.
>>
>> Good.
>>>
>>> Suggested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>>> Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>>  Makefile         | 17 +++++++++++++++++
>>>  config.mak.uname | 11 +++++------
>>>  2 files changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 6fc322ff88..dbd2760d18 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -100,6 +100,9 @@ include shared.mak
>>>  # specify your own (or DarwinPort's) include directories and
>>>  # library directories by defining CFLAGS and LDFLAGS appropriately.
>>>  #
>>> +# Define NO_HOMEBREW if you have Homebrew and don't want Git to link
>>> +# against libraries installed by it.
>>> +#
>> Good
>>>  # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS =
X
>>>  # and do not want to use Apple's CommonCrypto library.  This allows y=
ou
>>>  # to provide your own OpenSSL library, for example from MacPorts.
>>> @@ -1692,6 +1695,20 @@ ifeq ($(uname_S),Darwin)
>>>  	PTHREAD_LIBS =3D
>>>  endif
>>> =20
>>> +ifndef NO_HOMEBREW
>>> +        ifdef HOMEBREW_PREFIX
>>
>> Question from a homebrew newbie, kind of:
>> Where do the HOMEBREW_PREFIX (and other HOMEBREW...) come from,
>> and what do they do ?
>=20
> I understand these are purely _our_ thing.  HOMEBREW_PREFIX and
> HOMEBREW_GETTEXT_PREFIX are set in config.mak.uname (added in this
> patch).

Right.

> I presume that those who installed homebrew at non-default
> location and want to use homebrew would not set NO_HOMEBREW and set
> HOMEBREW_PREFIX to the location they installed their homebrew which
> would be different from the default set in config.mak.uname.  Those
> who have homebrew installed at default location.
>=20
>> Running
>> git grep HOMEBREW
>> gives
>> ci/install-dependencies.sh:     export HOMEBREW_NO_AUTO_UPDATE=3D1 HOME=
BREW_NO_INSTALL_CLEANUP=3D1
>>
>> Whould it make sense to have a few words here as a comment ?
>=20
> Yeah, like=20
>=20
> # Define HOMEBREW_PREFIX to point at an appropriate directory, iff
> # you want to use homebrew installed at a non-standard location.
> # /opt/homebrew on Apple Silicon macOS and at /usr/local on Intel
> # macOS are the standard locations (and you do not have to define
> # this variable yourself).
>=20
> perhaps?  Similarly for other variables.

Sounds useful, but before this can become a documented feature it
deserves more research and refinement.  The current code uses what it
can find in an ad-hoc manner, and the patches just extend this behavior
to libiconv.  A user-settable HOMEBREW_PREFIX would require a more
principled approach, so that overriding it affects the search for
gettext and libiconv.

I guess that would look like this in config.mak.uname:

ifeq ($(uname_S),Darwin)
ifeq ($(uname_M),arm64)
	HOMEBREW_PREFIX =3D /opt/homebrew
else
	HOMEBREW_PREFIX =3D /usr/local
endif
	USE_HOMEBREW_GETTEXT =3D IfAvailable
	USE_HOMEBREW_MSGFMT =3D IfAvailable
	USE_HOMEBREW_LIBICONV =3D IfAvailable
endif

... and in Makefile:

ifndef NO_HOMEBREW
ifdef HOMEBREW_PREFIX
ifdef USE_HOMEBREW_GETTEXT
	# magic!
endif
ifdef USE_HOMEBREW_MSGFMT
	# more magic!
endif
ifdef USE_HOMEBREW_LIBICONV
ifeq ($(shell test -d $(HOMEBREW_PREFIX)/opt/libiconv && echo y),y)
	ICONVDIR ?=3D $(HOMEBREW_PREFIX)/opt/libiconv
endif
endif
endif

Perhaps the magic parts just need to check for the existence of
$(HOMEBREW_PREFIX)/opt/gettext and use that, but the current code is
more complicated for some reason.

Ren=C3=A9

