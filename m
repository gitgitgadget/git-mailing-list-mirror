Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3C5028C
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479798; cv=none; b=Xnuw2cKzJPOXz/WhbGYrNP1EfWqGPlHY+OsI7Pph5Irpg71n+nbV90WRN0l/YoaeQ0p9qAXuSy6oz1BtU96hpqOI3FBaTQAvNZ49NY2LXpeRQvVb/lM/S/NZHXXrNlbQOUATQmO56oe3S068JYGoBpBmzczoGY9v1O0PkCB/q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479798; c=relaxed/simple;
	bh=TtCHXemLXACuWZ65TmyqvcBcxQr+scPeRDHKIKLax44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI61S+klnbEX2YRAuBDwS1bLMPuHXVkrT+0pKavAUDK541OhgIkImVRX7qDVjXUw7zVkeF+CJUTEVd3CqfV53AGWw4FZ0LcHWDVUF9Wk9qCPvcDlG30hiOmJmWp9+FqDicFruGbxtZMw9NzKBnHQ/iYUe3wgloLJQqC3MRIKsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=lQXz+oHB; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="lQXz+oHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737479787; x=1738084587; i=tboegi@web.de;
	bh=TtCHXemLXACuWZ65TmyqvcBcxQr+scPeRDHKIKLax44=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lQXz+oHBeNHzXEHD+eHO2Hu5Sdv48AFDmbY2uqTD2ovxVLtuVXg+iCBerCjp+jTI
	 Adz0tmez5pOfsfixloP7fTYYnNwSgRG2pNnvnE9TTyqDyUgK43azh+TmPfFs/D/OT
	 rsmVXlZd7Wz7PCzzc4FrcrMrJSEs9nKC931vbRmBX+oKIuL8RaMnWhfchKpkcwUwO
	 +jMuNoPzrhbEI/k2FYUAfBxs3lJ3bk5q2ImhfXAY5g5QpD7RUs9KNuRgzQft0cy6/
	 zR+aNOZGBzRGZqVUFuvNjOQeGkgCry1UGCf6Ms4w63NO3WRoODnJ5etghsI7nkGn/
	 Qg8WWYYz+k4cI0Ewcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtsj-1tgehu0Sa1-00EzYp; Tue, 21
 Jan 2025 18:16:27 +0100
Date: Tue, 21 Jan 2025 18:16:21 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?L=EA?= Duy Quang <leduyquang753@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: `git add` with unmatching case silently fails on
 case-insensitive file systems
Message-ID: <20250121171621.GA4932@tb-raspi4>
References: <7e5e2f26-deda-41a3-af46-79c42435b3c7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7e5e2f26-deda-41a3-af46-79c42435b3c7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:/wdaaLFYwvAKRSXwd/mW11rWwx3z38mHUrMcELwVRCYS8OaXPN4
 GiCDkLxede/4icmi+OK5smJKp5ZDVmZ9se3Vkuh2+OSZ/SYWBB4cKe0MXwcXomg6REQqdqK
 bj0smc2aKiZjU4LJHLOUYVXZ/5yPpbzXEt4cIM9m4L3DdqKLTVBC1o6ZK6SeMrKfFOCX+eA
 WdW/9q7Qhe8cwnZd9TSbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:60RniWcNUKQ=;N0N511ZgOsiOAN6iVfoix+Bq35I
 20kpamtpFuU/0E5jyqRPODqFRffUKvUB/dtN7Oz1D/NBmInHyOGtYvhlXP5D2w9Zm8AAraCbo
 phMeCxbhrD8nHbLSXDTFW4BWBz0Pb0Zh7+3ZaxLgJZLf+VPl6JgbtvPIZTXM6qXfC68uym7uY
 bVHGgNHKjSs6HEV7f8j4VOAs80ZBwx+f0v21BnUl00XHMLVhTI/10ACOpXb5RWfiu+E8jxYkS
 LK7LO7KgHTxq5P6zapKWCpfQ++Mwf4vn42/g5ogLjr8PT11YKzVn/OZNc0wr0hnIG4RNdEz6a
 putqXuQEyK7zTQvkGfSGOCCr8AYfVRAZLbK3yG2BWAIGRmrscC4Uag9/AtObXJBlaLH3V2gqP
 bkoIYJhahtbc/ftiCOHrxWdAMdm983SEqvHJliSQvKA2JCFzNqmrJFhJWJzqltQ+fG2FKxuqV
 /79MI5Wv3P4WhEhOBo5IzdeghhD2R4etOEkng45LxTtf02h/9b6Idv1WqktM1VYwU4dhzj0er
 38wxp3QqftcvkdJMcw9UMaq5Toct8R+MwAHjlrgbM62skXNH0BuzK3nt7NsY6sAyViVMraBTm
 Cgqv1HArVTo5m6ahcTLvKpV/Yo0P3ZLwccMAVMiCnwn5YpKUA5k5xvgXSx0DevhbW2Up0bXcm
 qQbpmX4alYVuAGXAKsW6K+4FcsH81jfHqS0k8lZHMmAcc2+M8AtLBpW361LboOuPe5SmRFzKm
 6+rzgt/cRUjbWH49SHU0PkHBpXLVu8RLeYqgSdA83NAPW8B5kXE3afJq6d0Nd1akv2udmjo1r
 5xHNVoBDTLM/+dAv6MZsVhKU/onQzTdoL1BLUvgZbxWKNyS+ngrxXJcAn8yAtADJrwZGuCjOd
 emZrYHtFRpjcF47PIt3ijK8lLFPSviYoWAYTHRIdIQN37/3J627KjuQkn8gcDy3hvFCNtRSZt
 r4GcMnDUcOriFmcRMv9OvY4Vi1wJybw1po8H32zUhr0dApWTZslWOm01MrPqOA9NTt9XdGDM6
 g1yys85WQHaUfOXfQJdKa7f+/XSXbxCvLY5kjRxkmsRV7CMNGFr6rtKqz87sbTpsoqNuwfqKf
 RNwlf2V/vcDJv6c8vOZnJ3L41Tl6vNYDm8Emnj4JB5DPc/rohFjXY7iKbX9sHMXMLEOnbp3Pg
 t0Kv7w9H2xvDk9L90tb/yhosZBVahFFg8FqX442t8Qw==

On Tue, Jan 21, 2025 at 02:52:09PM +0700, L=EA Duy Quang wrote:
> Good morning,
>
> I am using Git on Windows, whose file system is case-insensitive. If the
> working tree has a file called `SourceFile.c`, for example, and I run `g=
it
> add sourcefile.c`, I would expect either (a) Git stages `SourceFile.c` o=
r
> (b) Git errors with "fatal: pathspec 'sourcefile.c' did not match any
> files". However, none of those actually took place; instead Git did not
> stage the file and produced no output as if the command had succeeded, w=
hich
> led me to proceed to committing without realizing I had missed the file.
>
> I would like to know whether this is intended behavior or I have bumped =
into
> a case-sensitivity bug.

The thing is that Windows tells us sourcefile.c is there,
even if Sourcefile.c is there.
So that is why neither a) nor b) is happening.

You can call it a bug, or a not-yet-implemented feature.
In any case, just to be shure,
git status
is your friend before doing the commit.
