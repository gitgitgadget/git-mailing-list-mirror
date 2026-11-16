Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857015;
	b=5ApUY2TBskgqGtpfYH/Ms0sNAb7yYYkqW3nJAtCEbVBxTtwbukqg2N8Rl2QL9o/u2Sd4
	 bzwirq2Nf+Q9xdaO5pfeb0O1O1ka4//5rfdUsv91axCo/Hvs/8oTZQ5qyCL/DDN53E2XC
	 joRTVZjP5m0av03UD3jJ6hIG10coZD608YYF8DXnWTqwfaEVLqRmqgp6PTegyZBaDX88I
	 IWY+v+A8CfLrrSIT8FhJy9Oq+q+YLjtbXFB8B8xGU/Ch9TTIE9CoJvCreU/4vOlCanjPl
	 XHDYakks1NXjCGiqfBtwNvPEAI86ZoSI+bSxJfz75GIomFsLJXDQ7YH6RWZZFj3y0Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857015;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Mvo2dXsb8iUKx7G0nInX6YkRU6pW2XI3of1zG6K49vg=;
	b=34PeLS+ykGE880Q6mjx+FiURRz5qPZFxxnS0zN3wT0FeyksR5UJU/TUQ+yCjTefoQbyp
	 nEtICExb/+ve4sRRczkG2wJQgG36fqugcQQf8enHoLSCI4YIii0Dhez/qBa5s1YRgPa0T
	 Yzr9V9slhYJjpZAnnBoSrSXshGSv1PLDSI1E/JfkrGo0VhnSqfuSYVoLR6SYet7mIQDSL
	 neyquekvKKYE2avjnL1L13bkBuaEppn7ns9bPxmZgJe061uUFq7/KhzJyBSYbBlxcmdtr
	 hOvQQpn7yagNXXGJMyrMlTfuCDBO7qi0F7z0DQsl3RroMkZyzyDI4LfxrmCGUIOe9nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=vdwaa.nl;
	spf=pass smtp.mailfrom=vdwaa.nl;
	dkim=pass header.d=vdwaa.nl header.i=@vdwaa.nl header.a=rsa-sha256 header.s=fm1 header.b=GLCKwd4W;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cI9BsQlA;
	arc=none smtp.remote-ip=202.12.124.141
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E110606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 19:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E110606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vdwaa.nl header.i=@vdwaa.nl header.a=rsa-sha256 header.s=fm1 header.b=GLCKwd4W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cI9BsQlA
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 585AE1302A30
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 14:23:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 14:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdwaa.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794857011;
	 x=1794864211; bh=Mvo2dXsb8iUKx7G0nInX6YkRU6pW2XI3of1zG6K49vg=; b=
	GLCKwd4WBkl889aFZBqkGG6nngq7iP1CgS8Yl/XOpytdeYWZU+gPnW6eWl7LJVtP
	4Io19xQvdN9/3YFZ9z4xZw2xy+RmK2NvfUBqr1dm2o5REaxnxDsf6SRL8dkVM+e1
	jajMWTCjStAUTPFrwlbWmjqim0C3LccWn1aPaXX3QyUFhcvLN8+4o2vkF1fpxGwP
	Y+mMs/BlgVlDydl+1bvOTUBGAakwAoQjOK03fBN3N+LPgTDdtuGcKvsRkUhD8Irh
	yBRwuAfBb6Elh3CqbdDdRFxwQIhfx45rM09TBbeJzByvBAm4ZCLHs2BSV8/Ak27r
	N8I3a6LgQQudmRgr42GjHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794857011; x=
	1794864211; bh=Mvo2dXsb8iUKx7G0nInX6YkRU6pW2XI3of1zG6K49vg=; b=c
	I9BsQlAPW65RxlT8PmLYPW2pjmQPCn6s/xzc9qzh+pMw1Oa0StO13Sc8c2Tbgoi+
	fXdMRIYbg3xujfoVCMSmuAzr1ARNB5EnjA0/ArQeZPQjAorJbu1gP/P/wVzIy8r6
	rHKAfdZMJXsMChaG8aXioPFNed6yDNQfSj4WHbIFThmmjNDsZNzSaI/pr7JM6Liu
	OloomtzE0FCjFPnQmOJZuljVoi5ddZxEe/VuE69SljBEslygIT+lg7jnOiPSL0E3
	7Q5FV9/HIHkowKeRazAv/TF5iIGvAMHyNVDrqyFH7a0+BcsogizDzVjMNi56CZhM
	CJjmCIvPAn9eR9ZoSABbQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=vdwaa.nl a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794857011; d=vdwaa.nl;
	mf=PGplbGxlQHZkd2FhLm5sPg==; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:STbKIBmskvgeVoPndzjlVlraq3U/n6fkoAcqz7pyw2ZNyxp
	YiSKA0BjuuTZPhCzo+v8e34GYmUed3nPwtP827gVnpV/YQIiWbPUYqNX4Xa9IjbX
	wYbED/XeALEiBzGAUlZbx3sCNQtZ/G+nsR0XZTh/4Ye3dGKQk+FewNUZ7hZn8dMn
	ESIJDuevfZhWUR1QV1Rg+oluE5gFe8CGU4UyRmFF0TSEq130tg/4bSo4iEdqSEmw
	A3i3W3XLEAWNskC1Ru7ZDue38IXelvfa/+UeBX6K2YdrKebSWFvbVJIPZbMO7xuS
	nVcjLXbnfAs+wCXYb5kPd3K/VspQxNjATY5K3BA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=15;
	hn=autocrypt,cc,content-language,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DdKlzrIgC9zL31+GTExDSNC93p6f284rF2kesB1QAKY=:FfZYP8Lxe22Ork1Sl8p5Gbd6OaKR30HPApYIbcneEK0=;
X-ME-Sender: <xms:M1j7amd6UJr4w7GRQg4h5nxGTY35ryWwByTPYuFlJaj9ju1km-68bQ>
    <xme:M1j7alJdvTjiAnyIrIY8I5ws0PCwlO7xPFKiUZHM98IHMbGXzr4Uk-sQNTKLXrjFU
    EQuzJVZatpH2jP768wH9A23b5Me6hb7xihZxCzFQUDFCB0SpPnF55c>
X-ME-Received: <xmr:M1j7aryXkO_qApzWH_eOIuat7hKeV6YroeDoQTXN1AIJllPRaGXlS8unYkU6H7rf1wpnE0avvbH8XhaNej9Es6q0J_jTYg>
X-ME-Proxy-Cause: dmFkZTE23i8rvsPaadukeJpvoLI1Ctlv42GWlVOm/SboEt9kFP6X2GN/xuJFr2eP8AsXYU
    37DQ9IWC5A8GUP7VG2JzjRd9dZ93rbMWXx18jg1gxN/gdCpfx/7NKYaK6Fob/4tIFbdt2f
    3pbUdAWcZLMOAkvO4v+j7dMJ4ixA+9GBb50loT9f3KQnd+WR8+X0IjDVSeO/8rgndxkU09
    500Nj4MBlMSWo3RYAVB0kNJ3wOjxEGbOc/P/IMgJXy++48FToDB6cz0yYRzepEKuqmP8sb
    Yr5bi9NIOzWSDKB/4mfMQ3o6T26wtQBeY8bFJcHGQ51EplhKuLiD1xVd34PqJt3bQ9gGrL
    a44BaqaR716RimRPqUcTUOQPqTHd+QZpnYAK7KxJ+gBSrI4Pkd4Lac9M2cUoQPiMuXQ/fA
    OPBqWLFwEUjYG0GBKex161E8QkNPdc33bb8PE2DwTvtrDEueFTbyNf5mW+MNChpQ5w1iNU
    5PdisAfKzzo5o6cFjxR48bxKmtNtbpN9MRevzvINgRJi0DNlm6eMFbJq3pJ8TugB9lrm96
    Cc50Lj3PWaPIUydUPMmLCSGz+YqodqTip4GzcSBgaZZvhBxU0RCQRBD20YYA1tPxdwt8jm
    v/MZIZ6vlzr1W6cJ2yOz9TgBPnUHVj3LnQjrGhirThuR21M02nkH7ZkB89lw
X-ME-Proxy: <xmx:M1j7ajs51eN4NpYNBMygksjqGH_evp1KVYH3x9e25OSeZOuUPclVLg>
    <xmx:M1j7amBcn0iOhhUSTkv6RzBp5g05n_pWidccwxJGLL4TRJmqetjygw>
    <xmx:M1j7atF7JPmuwNI6G_opoF1gR5BBY_SEBlnY_izeYtBl4omPl7vm_w>
    <xmx:M1j7auC2GLJHVTLrrv9o52nSin8KAkE1vzFqpZnQmPmZ_0ywxmkAow>
    <xmx:M1j7auE0ORZZhhceyuxw7jzJ7QN5BDOWiqofzXiKtV05BuPXI2YTEmR0>
Feedback-ID: i2d0446dd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 14:23:29 -0500 (EST)
Message-ID: <734e2ca8-e01a-4204-9cd3-a09a8d097f64@vdwaa.nl>
Date: Mon, 16 Nov 2026 20:23:27 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
To: Ben Knoble <ben.knoble@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Harald Nordgren <haraldnordgren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
References: <CAOLa=ZQowi+fepj+RNegTZhK_Jy4G8VLE_Af2UdsO8-rCdviJQ@mail.gmail.com>
 <53CA2747-58F6-4A7C-81EC-33EABF0000FC@gmail.com>
Content-Language: en-US
From: Jelle van der Waa <jelle@vdwaa.nl>
Autocrypt: addr=jelle@vdwaa.nl; keydata=
 xsBNBE6QLAIBCAC3O6LmF+GKvOh7IV00TG+EKAQHAwjESnHGJOW58lKK7eAYn62ZM1uy0+6h
 yCMu5PD7+ND6U1gcgTTHYwNK8AaJt7yY4FRssgdcJk59uJBwROZtllotClJ893CuB6Wgr68b
 07gIRbENYrB8rEoGfpUG//8/ep7sY8PS03jnFb4ll6mPlUE2oQVdYOlXgF4f9qkkIi4SQeE2
 MTuERaOrDuUNDlroJ7Yfx3J/rL5Qjn578/TKCAxg0pns6VIA/P9spRGmLhT4zP+OxZXeSZme
 IxcwFdJJXHr4oGaZvqe1yHlMmKR98rrIfPWhkw2Ls/XIZIxf6prT0XyczbzBnC2y1JyNABEB
 AAHNIkplbGxlIHZhbiBkZXIgV2FhIDxqZWxsZUB2ZHdhYS5ubD7CwHsEEwECACUCGwMGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJUX8WhAhkBAAoJEMBghjN8UHc+mFwH/jjN+Qob4O36
 YiieajRwVLGuYdUDt9Z655oQYU8V4qbWf2tjUtqTYXrxLnaY6xQoYouRz9yFbh9dIKZb67ir
 7AeVgCOtWVesGxAlGH6EY5JBZcsN0v0ScsivqQAv/Mv+4HK+XM57YlyRagD8tkprYskioWHg
 OwQfXAO6nlm4BJHWO9bHJUMgiGs7I190IKQG7iLBnJuGjsOFuy5KTLpnv+w7twmz0H+pkUPe
 jVHfJlJWdN4v1PigpgpjOR6ZepSIggMk7dHsa6GNLUOzi61yYVFe60+EGXhwyJIqSt56a4oR
 jMUcXaOugGr+JwC8Eq7Pg2+aFk+8fbe0oUzZJucHGnDOwE0ETpAsAgEIAK4Usb7B00WRxCZG
 HtM973F7V4OhOKv4kZKduxtu71bVUZsTuzn4h+m8guJ51uY/I2icUrN9gJG5aEzRqPuQi2L7
 KmZUjs3pscZWgUgiT8UZFDR6RuQ4k3CcWobsRCjYZdSblSZ8ccrLJE7xSbwKMXjAh2PEiaQT
 lS6wQbn6mHv4y3H9QVHs7+jXbmfHCxnVcwLqRmpuegSmezDaL5TlSc102voiXinhrWEZUvAB
 KDh6VuJ/60Y6zelCXVsEjRaApz90iXY1nifLhkHM8B2wG7Pum3V3X0Y0QTVD+z3EL1iq5mFu
 epKp//IOeeJN5iwHcRSJGy2s1oOzjRDyPv6v1AUAEQEAAcLAXwQYAQIACQUCTpAsAgIbDAAK
 CRDAYIYzfFB3PvDuB/0dI13hSYHW27c2Rq8BaGbIhXYYETtPD5B25/P1JJ5OQZkPmVq+vSHw
 uzUaDZHy3ZcwE+xFXzlkwXGdWos07JUGo74zV3HfeZxVEPv0HB9ACqQVU/JKjLZNj2SfhgzL
 4F+O4Zgdsf0YaZG09F5PbMvbhoCZLfAaKWz/4fLEfhrDJLhrphUyPDXosn0UxPkDv0iiixn4
 V+bEZ5/wd8dRWi58R/iND+gRGsBREm5SpzdhnsarwoX6YdsQ449379enDNUN7jV4C3Gkon2s
 VwI2ZZbS10cY8rFSAV/CJA2E9daRoz40DI0tgXgLBAVhy7y5HWZJsDZexU0HFKJfkDi7RUPj
In-Reply-To: <53CA2747-58F6-4A7C-81EC-33EABF0000FC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/26 18:15, Ben Knoble wrote:
> 
> 
>> Le 10 nov. 2026 à 08:13, Karthik Nayak <karthik.188@gmail.com> a écrit :
>>
>> ﻿Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>>> On 09/11/2026 12:43, D. Ben Knoble wrote:
>>>> On Mon, Nov 9, 2026 at 7:06 AM Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>>
>>>>> My preference would be to make this (current patch) default behavior and
>>>>> not even have an option. I don't see a disadvantage of having the diff
>>>>> always being shown and it definitely is a better default to have.
>>>>
>>>> When the diff is extremely long, or if the user has other means of
>>>> obtaining it and wants the editor to open quickly, it may not be
>>>> desired. So I'd prefer to still have it optional, personally.
>>>
>>> Another case where we might not want the diff is scripted editing as it
>>> is much easier if the script does not have to worry about the diff
>>> getting in the way of its edits. Personally I'd be happy to see this on
>>> by default - the history command is marked as experimental so if having
>>> it on by default rather than following "commit.verbose" proves to be
>>> problematic we can always change it in the future. If we were staring
>>> again I'd also make "commit.verbose" on by default as well so maybe I'm
>>> biased.
>>>
>>> Thanks
>>>
>>> Phillip
>>
>> I'm on board with this suggestion. Plus, I see 'git history' to be more
>> user facing and it's always nicer to have better defaults for users.
>> Showing diffs and verbose information seems to be inline with that. We
>> could add an option to disable such output for scripts (but that can be
>> done later as you suggested).
>> <signature.asc>
> 
> I can live with opt-out as long as I can turn it off via config.

It seems most of the replies agree that "verbose" should be the default 
with a means to opt-out.
git history split, reword and fixup would turn this on (as drop does not 
have an way to interact with a commit message).

I'll spin up a new patch which will drop the --verbose option and make 
"verbose" follow commit.verbose and make it the default for git history.

Thanks for all the feedback,

Jelle van der Waa
