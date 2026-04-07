Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732325CC79
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567796; cv=none; b=Z6RzMGNn0xEf7bKLudcS+JDcFqAQa3EBJ0MCB+pY01n5XMiBIX28SpVNEDXbaTYP/r6sEh6TaggQToF/Y1Aps5Rh9f9nQvyfAjS3BWHl0Kzq1wWvi19zrOuWcLYRp6ApTpUvqqJn0fZBNkBDkl3FT8KlwwyaNIaqXBnEgN4QsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567796; c=relaxed/simple;
	bh=NBi/4euOTxE+9UOaC421aObAaHYYzvPqGmDRL4XUaZI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=TsKxRNOyAAbilKNY83AYXZNHQ1ApEFHnrXiLwo0lsmAZA3C0ej3lSuqljuJhZ4Mkw90hFpUfBxmKu514wSQzzZIliWE8irR/+uwFPKIdMEQV/qNXysH33P6FaV9wiN+dAI4EeZKllr/i0/QkTg9F+O6wlt6GKtoASHWK4ze5KEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schwarzers.de; spf=pass smtp.mailfrom=schwarzers.de; dkim=pass (2048-bit key) header.d=schwarzers.de header.i=jesko@schwarzers.de header.b=hmEdm5ff; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schwarzers.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schwarzers.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schwarzers.de header.i=jesko@schwarzers.de header.b="hmEdm5ff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schwarzers.de;
	s=s1-ionos; t=1775567793; x=1776172593; i=jesko@schwarzers.de;
	bh=NBi/4euOTxE+9UOaC421aObAaHYYzvPqGmDRL4XUaZI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hmEdm5ffSJt660IAQGcNwFP3aOdEQ5TXujn5r8THj2Q1jPQRAbeTkV2CkdRRqNP2
	 wl2j7pdLiO1VWQBUR53OLJ4N7MFxIjOfNs1vrH1qNTLd+pRY7+J8XG9dJuc4FmCkj
	 6a4/FhqikAwCVTUerYyHHL/RpAYTyl0amiA1HC6VdpyCDiWiCKuiEwOUWm9BjSHAA
	 sZxcH4nrbThyafBVG8gdsHTJpzx+a8EY/JSrNZH93vMSehYdAzbz/BSKi0mSDVfz1
	 UmoDtNqMk78xUYYkjja2S7szFE1aAJ01mkU/EJk6QjVjbxVFe7KTd7RHYHIejxXZG
	 Wb7qs8MXPPF4cq3UXw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1MqK2d-1vflSV2wvD-00ncqJ; Tue, 07
 Apr 2026 15:11:20 +0200
Message-ID: <956b1bec-99ec-4d28-8229-804eb14e6d3a@schwarzers.de>
Date: Tue, 7 Apr 2026 15:10:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Jesko Schwarzer <jesko@schwarzers.de>
Subject: checkout: clarify "up to date with origin/" uses local
 remote-tracking ref
Cc: git.vger.kernel.org@schwarzers.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:64c1R6/h8nexDV5BavCTDmoK5O542bo6JVz8MbGElLkBDWOxyUy
 BAqfbCs+taLhY3k4URccdGaU0qZLVheu5AYwv1JBplNK8CrY39LD08tem7o6xlU3d4eFz7n
 8a5tPq6wnPB9jw1m8NeiXr0ptVLvlSfArczeUnCH12up0mcY5oUg/NL6eRPjntsiKb3bLbK
 /UyV/j1f9RDowVHR2O4yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lQnmF9SoTQI=;7zUNWDYHxyDuK5m9J+az3eC4JGW
 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
 VTCpj3B0wVEDgw7k9Y2b7Y6pvzKr8=

Hello together,

this is my first post. I am using git*version 2.43.0* on Ubuntu 24.04LTS=
=20
and have an UX proposal:

When I run git checkout master on a branch that tracks origin/master,=20
Git often prints:

Your branch is up to date with 'origin/master'.

I naively read this as "my branch matches the current state of the=20
remote repository." In practice, origin/master here is only the local=20
remote-tracking ref; it is not refreshed unless I run fetch/pull. If the=
=20
remote has moved on since my last fetch, the message can still be "up to=
=20
date" while git pull immediately brings new commits (fast-forwarding=20
origin/master and then master).
So the comparison is correct relative to the cached=20
refs/remotes/origin/master, but the wording is easy to *misread *as "I=20
just verified against the server."

Would the project consider one of the following?
 =C2=A0 =C2=A0 1. *Clearer messaging*, e.g. indicating that the comparison=
 is=20
against the last-known origin/<branch> (or similar wording that does not=
=20
imply a live remote check).
 =C2=A0 =C2=A0 2. *Optional context* when available (e.g. from reflog or l=
ast=20
fetch time), so users know how stale the origin/* ref might be =E2=80=94 i=
f that=20
is technically and policy-wise acceptable.

I understand Git deliberately avoids implicit network access on=20
checkout; the issue is only that the status text does not make the=20
"local remote-tracking ref" semantics obvious to everyone.

Thanks for maintaining Git,
mit freundlichen Gr=C3=BC=C3=9Fen/Best regards
/Jesko
