Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658321D3D2
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750514274; cv=none; b=ddGazXnjAhF6n8LOQRWS20X2pUITXgS5n2WedgCRgbuNuyZ1uXZRjhg98HF7uLui3FRpIYFIXcQZwoYDd2sVdODrLi2HykZvfk24ZFU8+xreHKw9KrqAVhNFhOppWoXJs5So6C+w4SCkJQ6nZ9u7X1Qvt5xPAS5Rid0HTLNCADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750514274; c=relaxed/simple;
	bh=jCx2G2W/mNIMnLlSbSlvSVjlOzVn58YeiUi2NfGA6Po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdpTThJdgOfy7C5FWrC8H3PEj1wTmZv+9atA8izT+8TOV4GyBQyCvSmFxp++PSh4tnwBioG07WLlVbbnfgUsTJvrB+h1aF4dgjNqMOlY9HhkJhjqQq+RugU27OmbjAlt2OLPwfEfDqQV+Qy862duai7/JSXJ4kgpSfSygSjMH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=NxtStVoT; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="NxtStVoT"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uSyiz-002kQ4-KR
	for git@vger.kernel.org; Sat, 21 Jun 2025 15:57:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From;
	bh=qjJtBJlTaNZNX712mGabcKmJUjU/tGpRtdhqrKWI7r0=; b=NxtStVoTmuc2hdCRtQWtBujm0G
	dU9kpWcQa4Fhz9Y+0pEnjb84+WaNnUjza/ikwgEjQ2L7M2CtH0+GUv2QzqTNEaLPywm3lLMhmQvI7
	QvU0esu6f2CPN/0XedxqTv6HawwicJ0ikRHpXRwl/E9QPdRydDWVjHqeHkhDnqEk1kNvDTUSxLBq1
	yArB7xOq1DH2vyoPjrfQJkAVhx6mjAFo6KuDwhGv6ojKdDSu8+dPZmPS8kdBeGAIq1tyHAFC9pEav
	WazCsLUhWPIIPP3Vd3OhGV04HYRq3n1RJUOxBAaTyhvu/xvkEu/DvCm5ZrUuj1IFW0nvKjldbmLWT
	SsoNJ/tg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uSyiz-0003yy-3A; Sat, 21 Jun 2025 15:57:41 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uSyih-00Dl5v-FO; Sat, 21 Jun 2025 15:57:24 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
In-Reply-To: <87pleyijbg.fsf@igel.home> (Andreas Schwab's message of "Fri, 20
	Jun 2025 16:22:43 +0200")
Organization: Guixotic
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<xmqqmsa27cdn.fsf@gitster.g> <87pleyijbg.fsf@igel.home>
Date: Sat, 21 Jun 2025 22:57:18 +0900
Message-ID: <875xgpgptt.fsf@terra.mail-host-address-is-not-set>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jun 20 2025, Junio C Hamano wrote:
>
>> Do we know symbolic port names are always limited to alnums?  Or on
>> some systems some byte values in the fringe, like "_" or "-", are
>> also allowed?
>
> Valid service names are documented in RFC6335.  Specifically it allows
> hyphens, but not underscores.

Thanks for the reference. I'm thinking at the moment to improve the
check for a valid port using something like this Scheme code:

--8<---------------cut here---------------start------------->8---
(define (port? port)
 "Return the numeric value for PORT, else #f."
 (if (and (exact-integer? port)
          (positive? port)
          (<= port (1- (expt 2 16))))
     port
     (catch 'system-error
      (lambda () (servent:port (getservbyname port "")))
      (const #f))))
scheme@(guile-user)> (port? "465")
$14 = #f
scheme@(guile-user)> (port? 465)
$15 = 465
scheme@(guile-user)> (port? "smtps")
$16 = 465
scheme@(guile-user)> (port? "unknown")
$17 = #f
scheme@(guile-user)> (port? 120000)
$18 = #f
--8<---------------cut here---------------end--------------->8---

So basically, try to call getservname(2) on a non-numeric port. If this
fails, the port is invalid, else return the port number.

-- 
Thanks,
Maxim
