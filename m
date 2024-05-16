Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907114D45E
	for <git@vger.kernel.org>; Thu, 16 May 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875228; cv=none; b=QTz4vOBj+dE5hxrXhg8wHnka0TdBlZgRsi+e60OIemaSMILrwqi++FDd8RZ+MiWpm34mp0pm2bdv8v15KUsEzPuJ2Q0Svd7alDotj6YQeLxnGrYEXkSwhroJsMldFV64a9krQ6bYZ81PIK/P5f2sK0S8TfsOVPDAYcHEZGEYvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875228; c=relaxed/simple;
	bh=y6WaA9/Uy7jF/wKVsXjBd+Lb2bgwkbO9pZBguulh6xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fdrq1fcLHCT+jQhunMB4rLX0zMn4bz4rZrhjUtqCNJu5OKRdSHZ45R8Bp0vCivXQz44ANvtoTlXNbg4oS8zrouskP9WlLGM48tIZ6Nl30JgdqXH1OyascIC5DMoMb2Jagd1DztBhUTeBwlZoy/6etJX6I+pvLsjBtNFBOsotPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BGUtu31H; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BGUtu31H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715875213; x=1716480013; i=l.s.r@web.de;
	bh=9XnaOL/FoPpHzZkxt7euam9FLu/0vQyLYlgxpH8hFcA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BGUtu31HDGWNi7eC0H7I2k6fLWbK/kJP4dXYNINdOJzMP9z1eOFenqRGgyiiFaSf
	 2nqCpr6gIHD0xL07bZbwnLx7kcJs72VfK4l4oCtKg2ej6ToAXAhIkTCna2Boyspw/
	 qm41O1uMZnTrYGAR8WUZ84v0yxXy/VmP/6Ey4GEbFdCLY0Kr4l2XaVDGZLT3LZihe
	 q6kvXlHXdPEr7eOx2kxEEJG1rieHJTsier/AV7KyJbE0A2solMqsz/OvJ973zreno
	 ErhsdcpQZyjtdvb0dC8ixFycGliFfwmccNBp6VsFHIRS50yREmfhDMH0nXwMGU1jk
	 rz+gpLEII5kdKFUP9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmvd-1sqY8A3iL1-00mK3r; Thu, 16
 May 2024 18:00:13 +0200
Message-ID: <17ca35d2-f9a5-4e97-9562-82ab83ddf995@web.de>
Date: Thu, 16 May 2024 18:00:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (May 2024, #06; Tue, 14)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqcypo47p7.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqcypo47p7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:afEh1/SD8C5qxtRRmqaok9tjZAaBKZ/N+v6Ab/TJdgEJoTI7AHP
 3g24HktYjmOH7GxqYDWfp/CiEZ72JqT4lskwob67KFjCZxbTmEDFBr799VluYqs4OrLJOWc
 To7mmkAr+p9v5cYs1OCz+Zh4RlTQOHTWfa1XsXyxVq+iooni7+hZxpd5BfLPW5oc37Kwmsf
 0HQjw5H72Bt/E9Xg7V52w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eBEhVBt05v0=;gNVYZ9oHYX/h6lfWtau83B13aB1
 2pCvizkoKO1g5gYubQ9Cv5gepXGBQzKgndvn+Z3vazHFMyoK17lzS2jzOEE9bpNyjQLL5QSGl
 2ngR0MwpiGE/9Z53hPLLBfhTtmORzxPzvpYhIo2//OpIyWS6Mi8DJ2lC1IHNgncNf8IhuKJUf
 Oau5+uJhwQH8bxaXLVmOzZ25hCy9YnRFROCtA29mE+8/kou73zrZX6BMXJi2tm1ZVnBNsZOqC
 wNJGGP7T4JnQFRAJUTlHWNuyDLgJpxQs2rL3ZYvUNvvPvSgd+/oCF513nZOUr1s3hH+vZHuUQ
 /hYG8MK+RuPQ4lFfwQmgdbpxULnuDLy9XQPWqz6lJnd8Nm1ExTcOzcL6+2ZaLHb6x3iKrDS6Y
 1/2xX3FiiPTYaOE/O/rmG2Bzc/CluCt/B3TcKndfHj4sPvJMvDPuermfhzwLRoYO4VbgJYXiT
 DmG6ir6Or71q16dJOCxSFMmJHP/GOwuh6pAfgoO23Zu1tMqrH+gt7j0/XvIu8K5qX1ZW7QXbt
 Wsx4CycKH6BhzVUIWe7hSRrMH8xHNH0NVS0PLn1NdrybqotrzzVjhyaKudpL3tOWYNwz0h5/T
 6rELwo4ZpDDIwJK1mV3qNG7hlIUuwAxPT6jIDv/kwhYUZJumvYjX+L4dZ1nfDiWBQWhXkc/mx
 WZflkU5SNr9JxQLuWDStlCjbJFaAAerN8k0qo+R75sM+pMnrF8a6XwfKiENUDXpixG0qu6KXm
 g8xQESG12PjP1P8X6kgUbbmOzy5INJOLXR0ff7mD6tD4H63vsN7XGCwv9dlbVTBSwq2ykedyn
 qTqJYZIfCUOmwXIowbUvRLt7p+Gz53IvaosUHUCpbO86U=

Am 14.05.24 um 19:36 schrieb Junio C Hamano:
> * rs/external-diff-with-exit-code (2024-05-06) 2 commits
>   (merged to 'next' on 2024-05-08 at ad5fee3cbf)
>  + diff: fix --exit-code with external diff
>  + diff: report unmerged paths as changes in run_diff_cmd()
>
>  The "--exit-code" option of "git diff" command learned to work with
>  the "--ext-diff" option.
>
>  Will merge to 'master'.
>  source: <82561c70-ec33-41bf-b036-52310ffc1926@web.de>

Oh, and it already hit master while I wasn't paying attention!  Patch 1
is fine, but 11be65cfa4 (diff: fix --exit-code with external diff,
2024-05-05) is flawed: It assumes external diffs write to their stdout,
which is not documented and not necessarily true or practical for GUI
tools.  Could you please revert it for now?

My current understanding is that we can optionally let external diffs
report that two files have no meaningful differences using exit code 1,
requiring no further config settings or output piping.
t7800-difftool.sh disagrees, however, and I have yet to look into these
test failures -- and write a bunch more tests.

Sorry for the kerfuffle.

Ren=C3=A9

