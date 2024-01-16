Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C681D533
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433250; cv=none; b=X8HylimJXwD1bMpG/9s8KacI4mXJwTb8USHJ9lwNSPzXXFOE2KVRWClOX/Mx1GeMKq48GhJZVvBcjYBXdtG1p29BjyCpV037D0bVG3dR9PrnIBrSdar90FI7swqu3bRrExdmeO/nNJRMiNiQ64hOG5A4DlrcK6hxygU/Rvr2qzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433250; c=relaxed/simple;
	bh=ohFmE6A0oK2siq/jqo1ZTaSV53GYM/0qBnNSHPADor8=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=PklnjzVv/JbOv0h72E2p8xRrfHyVRtLp9ud2HZrNY3tDgz0Ee2A7NSTmkmYxs6o0oypnStdvQ0jrW06Hwz9IdYUAFspy2sNAEXu4e+kYbEXmvSjhYH7NF3ly/kaZlb9C7zgUmnIOigtS3dcYHjgO1A0mDp3nQH1YT8g2OC43G7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wo2CGjme; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wo2CGjme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705433236; x=1706038036; i=l.s.r@web.de;
	bh=ohFmE6A0oK2siq/jqo1ZTaSV53GYM/0qBnNSHPADor8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=wo2CGjmehoZVmQG41hZ+y2GNYUHX8Omnr4jPo5b+j5ttp3u9lAQRNRzhzHxaPHWm
	 OzH8x26zDIuf8esHNX2rvZaSdAHl7iAvGtiLUXPOJnRiGpl5M5Cpsakuz9Gv3jCRf
	 sx7uu+UjTguUSAmjlmLlivL0JSf+sQI7j2JUhBIkEInVt+oZ4VBvP8kcq0f7HHi5N
	 +KXyT/bTrxtCMimaYF9lsWwe77LpGhGOAMJSbsg5yDH3xlBcmB0LQRjn84o+NRn6t
	 LI4+9hdjbBFYWfMEvXl4BFvjyD6j2YWVyA61k0SRbVRgb7EoYDRziON4EtReGqDD8
	 or7uZOAGJEUqKfSbbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.146.177]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzeZ-1qwF211rv3-00h0AA; Tue, 16
 Jan 2024 20:27:16 +0100
Message-ID: <41cf1944-2456-4115-a934-aff2306a26e5@web.de>
Date: Tue, 16 Jan 2024 20:27:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH v5] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
 chriscool@tuxfamily.org, christian.couder@gmail.com, me@ttaylorr.com,
 phillip.wood@dunelm.org.uk, steadmon@google.com
References: <20240105161413.10422-1-ach.lumap@gmail.com>
 <20240112102743.1440-1-ach.lumap@gmail.com>
 <0d18a95a-543a-41de-8441-c8894d46d380@gmail.com> <xmqqply147bj.fsf@gitster.g>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqply147bj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:89o1vLVI4Ir4HslecTEsIW34/W9M1MUnUqRUU9jz7DARJLcJtjw
 tkMVcNtHm9Dw3ckuYqyR03Csvvn2/E566L278PqfUVBDDMY1S/ZBot+PGTOQ769nD6DKMNG
 X7o5HZcjdvTN0o/bC9juT5lG95PxJsIVCU129LES/FF5o6OBnHvr94lhy23bBeznAvEPON0
 ol5UBoI8SdHNHed95IOGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iq8SGn1gGbs=;35cHTY0pjFGBVz98OT+0zRETEWT
 po3f1OBK9jpnnCWFdGWKoSen1dkEsOQK5cavoZatqS56wAwI3a2ikt+85sGDCyDCI2JzfcaUN
 v2gM/Smsx6qU3F9W48btJe7YfRzEOGUvkMaqIY9hLwt1bvpujphDnXTzzr4MSzhBXekm6QY85
 u2bIr/bifgIP5jr8ghxmwInfYPY4MK3Oh7SYrXOnThCXqGAwhR9dYid3nl3j31Z61X7yDhc5f
 HIRuSmh9+EJWHe6xmE6lKeeYbo6V37GPML7nWSU/ffwXInKZRNmclYd1B4rWPeUa/9Z8vxrtg
 KBU5MbW+K7Y++W/xh26RNjzTuWe5uXsBCYXwmZitI8rcULoOWuLO9u0tn0YdL9FQMl9gKXvel
 T8DZhswQA0qRdJQUQ+fDNsKXLPV4m+Y7h5cDuO0JtUs/tbvGV+puJ2Gr0YfBwiEvGkyQwM9kO
 v8bE+VCBCru6vYY/LZj0l0AZokD4qPNrymfyNgag6lpm2IMkdvOfWcD8MjcU0CvZLnwgk3I8v
 5BpzUsnQEMgUueA0A4h5LgWDzXcJVeWlIV3ElEMnldbgVvbLcSgMygbQxNowdRcddNmWQkqJk
 e8L0z11AGokvqYjP4NtWrav9tyBiq7lA5Q5+7ghYAW2hwKGm4IfOqq07BGj0AaFUX3tNOtKAD
 9fo2ZyWcO/sCyk+KNYY6h9HJvicuhsQxEsdVXaxd3xJWCP4XZKdNGupPgLh2HZYHLTtJ7YvCK
 PsNji2By2oiBF6MR+192oCE2VsO+SPYGgiZTdCEAGmRRQNTYonus0VQIqOboLXBp/pGuwrEBo
 ERYNctLSBIAMMQKGKDz3Qx1bJEyLx9K7I/yIMxj9C9Dig1W2OBW4HHah5T2BN4arnfTGZFKEf
 vICEGmxlG2+w2jBSvq6IbaxMrHNXkoaB3jcc0oCkUK/e8Ul0Y5klg5DUjrZHzaCS2J0Nni1PF
 hpKu1g==

Am 16.01.24 um 16:38 schrieb Junio C Hamano:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Thanks for adding back the test for EOF, this version looks good to me.
>
> Thanks.  Let's merge it to 'next'.

OK.  I'm still interested in replies to my question in
https://lore.kernel.org/git/a087f57c-ce72-45c7-8182-f38d0aca9030@web.de/,
i.e. whether we should have one TEST per class or one per class and
character -- or in a broader sense: What's the ideal scope of a TEST?
But I can ask it again in the form of a follow-up patch.

Ren=C3=A9
