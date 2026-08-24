Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6E32B132
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601834; cv=none; b=rK8CU/4iV+Pg9UC6slmNTLSKl+Ph3NQaZoB8z7PYVjg7pEBH6HFzm26UuMT9LKThBztbaMDQbIVQszVszN/HkMW1+Ny5cxY9e9sVxnmV4gqIzhWv+odevlpZaFWKwjscvOJWGvJc9IH+0DnV7bNOew3ApZSxQkoxTydTorIf3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601834; c=relaxed/simple;
	bh=fyT+XmVFBsqBOgskEPEyBc2uyqJCjT2LXi4vdaV5ql4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1QtdOjGe29CSa0YtuBOQpUrAkTVFXR8zgfe8AIv7VDnJRg1rx4a1uO3nt9uwcOpFFYRyoQsfun8tbF5BWDuLMf/s3gD/EGlD6F8+RtRlejX+g7AeyvC1xR+jFvkaBlKS9ceNGwul0lfBD0eJthDEHFpM40M05ObsmoNj66NiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=sw5bIlxB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="sw5bIlxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787601830; x=1788206630;
	i=oswald.buddenhagen@gmx.de;
	bh=fyT+XmVFBsqBOgskEPEyBc2uyqJCjT2LXi4vdaV5ql4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sw5bIlxBddUG7Cnmihm74RTrTnSnl+1v0JgfYJiaa40nxCfMXTy58ZEhv+1yJH+N
	 3LCn3Uq4AQJmoUey/X34WvcEFVe3yLN6mdfGz3y14z1nuwy3gOrrW6NZuxkUaaCrN
	 ADWq6tPNDw36YTSnNCD0k4gQ611W1+R1W74U53K+SVu183iGW2zckBsClbEyQ1fR7
	 YrWii2viGiz93+ApVrUNpXsdLr2lfjKNuO8FiCXypTI142EqaAQjgIoHTPPRuvwQ6
	 7eCG4OAw1W0Ulfm73yu2GM37h/nNzdSopbZkdBTkyFAhKxxGBsG2DCqO2CD3sfCyc
	 QC5zWx4rCiJBA7bO9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1xMpsE26Dw-00TfDI; Mon, 24
 Aug 2026 22:03:50 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wyata-wOU-00; Mon, 24 Aug 2026 22:03:50 +0200
Date: Mon, 24 Aug 2026 22:03:50 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <pks@pks.im>
Subject: Re: [RFC PATCH 07/14] odb: gather the odb sources under odb/
Message-ID: <aoyjpmBXUhj_PPck@ugly.lan>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
 <20260823171915.2662373-8-mmontalbo@gmail.com>
 <aoxQaSGaDwqkP7Tb@ugly.lan>
 <xmqqjypfshnh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqjypfshnh.fsf@gitster.g>
X-Provags-ID: V03:K1:qLAyzcLuSXtpgNOiK3OoT0Bm1NFkc9vQXVjN3dfAlhaclVQh0qo
 MQQXINbWk9xfJpUZL8QCi3R/5Ez+FOfWXy8zCr/Y2UJi79nkOJRgBfVzefucVOJ0xgMsOhx
 +WtTg0dwb5khDUTQOgxGPhusZ16s8uJmzWRRSVZoiws2eb6Pirwjs4cjcM6nGUv1YHdvj1W
 9OTUxWrDVASHBALIU6djQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UOcbxcZtTRM=;DKjk+1BKOmrAlN4PGMwJYfADjUA
 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
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 07:43:46AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> On Sun, Aug 23, 2026 at 10:18:51AM -0700, Michael Montalbo wrote:
>>>Move the 23 odb C sources and 26 headers into odb/ as renames.
>>>
>> i for one would go with lib/odb/.
>>
>I do not agree with lib/odb/ suggestion,
>
why not? it's hugely beneficial for the comprehensibility of the build=20
system and discoverability when the physical project structure follows=20
the logical one.

>>>+++ b/builtin/add.c
>>>-#include "object-file.h"
>>>-#include "odb.h"
>>>+#include "odb/object-file.h"
>>>+#include "odb/odb.h"
>>>=20
>> that's the wrong include style here.
>> it was already wrong in a lot of places, but as you rewrite everything=
=20
>> anyway, you could fix it just as well.
>
>Do you mean they should not be quoted in a pair of double quotes
>because the behaviour of such includes is implementation-defined
>(instead use "<>" as we use -I<path> on the command line)?
>
yes.
(actually, i don't mind relying on the popular interpretation that=20
""-style means relative to the including file's containing directory. =20
that mostly implies that "" is ok for in-module references when headers=20
and sources live side by side.)

> Something else?
>
everything else i can think of would require more context, so it's a=20
good first guess to assume that i didn't mean it.
