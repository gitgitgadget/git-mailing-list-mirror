Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6F3FB3B
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720365730; cv=none; b=lZikz8bYUgXEefkpzpWe8I4lAn1Uov+Hc0wRhvpdr7OwF7AnxM282S8WvxOac2kXBK5f+xmfDs/y4oIkogv3PRvER7AZUO5R1mp74m8xPdoPxtE3STcG6DZc3L4n8sDUHRfLIw35iSD+7lIDn42+DEFrH2pYjiZGhaasm3bmllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720365730; c=relaxed/simple;
	bh=BR980aCaCxqC1fM4Zj1YEJZ2am8CTU/ukeJvALed76E=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qz7oOww1mNdXl4GaxABZX+8iPdhAQQXaOc7eaUGdj+Reo/BWvmaEvUUQ341UDan6aZo8fk1xon+g6d8nfcOqNbF+x8Y1Us8b7/3eKX4wuo7F/FxmP5hpnCHzFG6MJjIRqnvmrqoWFEi1hfrfsWgCQ9CVVIOWOW2O1wcJZNzrTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 467FLxSC3021953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Jul 2024 15:22:00 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Doron Behar'" <doron.behar@gmail.com>, <git@vger.kernel.org>
References: <mrn75pj663u6ikkwfnoq6c342l7w5plfeju4ji7norsmlzx4jn@3se3fmuqes4p> <87cynpnv8m.fsf@igel.home> <e4ylt2rihvm2uc22irsxbeid57ijblioekit3o4xpufflrqwal@5t67kr2a5ahq>
In-Reply-To: <e4ylt2rihvm2uc22irsxbeid57ijblioekit3o4xpufflrqwal@5t67kr2a5ahq>
Subject: RE: Re: Remove your ZSH completion in favor of the completion script distributed and maintained by ZSH
Date: Sun, 7 Jul 2024 11:21:54 -0400
Organization: Nexbridge Inc.
Message-ID: <0a3501dad081$69a5c0c0$3cf14240$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL7tF1k0V28wHRF5oLd/wh6gizLyQIyMDKjApaegdqvg1L+8A==
Content-Language: en-ca

On Sunday, July 7, 2024 10:47 AM, Doron Behar wrote:
>They don't perform any version checks as far as I can see in their =
implementation.
>
>Almost all commands that the ZSH team maintains completions for, don't =
perform
>version checks and the maintainers of the commands themselves don't =
bother
>taking responsibility for that and usually users don't complain. If a =
ZSH user notices
>a new command or new option missing from such a completion function, =
they can
>submit a patch to the ZSH project, and setup a workaround until there =
is a new ZSH
>release with their patch included.
>
>Besides the option of living with this potential version mismatch =
imperfection, you
>could also ask the ZSH team to remove their implementation and start =
maintain
>their implementation here. However, they might object because not all =
distributions
>will accommodate to this change in both projects...
>
>I personally think that Git is a stable enough project that the =
commands and
>options don't deviate enough between the different versions of it, So =
it'd be easier
>for you and for the distributions if you'd let go of your =
implementation.
>
>On Sun, Jul 07, 2024 at 04:15:53PM +0200, Andreas Schwab wrote:
>> On Jul 07 2024, Doron Behar wrote:
>>
>> > ZSH completion is almost always distributed with every distribution
>> > of ZSH, so there is no need for the two projects to maintain two
>> > completion functions for the same program :).
>>
>> How do they keep it in sync with the particular version of git
>> installed in the system?
>>
>> --
>> Andreas Schwab, schwab@linux-m68k.org
>> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA
>> AEC1 "And now for something completely different."
>>

There are frequent updates to the git CLI. Freezing ZSH completion at an =
older version may not be useful. If there is a version compatibility =
error during install, perhaps take this up with rpm or apt depending on =
your package manager. I am curious as to why ZSH is overriding git =
completions.

