Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726992;
	b=CbJl0iye+5fIceqaBXnnJcSTu7VWebiTokdHhPTIhWKVSkmlTfUz3v7Bj12H7DemNPyZ
	 F1Pm/uRvmzlLRHybNLZueJEfM99rguP3QAlc0ubYX+H0JP4p7MNgv4xPK73PwwsTi7WYY
	 iBv33EJWigUbv4T0znHqLUFZ5R/DKG8gN982bLyXJexexh/h7SU6MZU1CQ4+NnvsWx3/9
	 VCc1CfbaW14yP7MK49IoWAGgEUpGuLPWBZVbqpSfc6DXY6/1StF6o6WpNUx68xXOZAXBE
	 zqxCZbPw4oZMBHA9bRuHPVYHkgcxg+vZ9csM2ouO4XIc6r6XxtXQOEySZMoo3MUOX/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726992;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=qsyJCAM0gdLCi4al8232IaiY7SC64pTyyxU4PbKo0Ko=;
	b=rpaau8oi0YHOA8RuArqtrtVF0tUtnUaW+jwluNkQ6ZjPj0oaVjKL9XaqFjChYEvR0iAT
	 PuYFy9ObeYFYwFa5wmRSVGZ1zSzf/sN9e/A8yaYInE48zEBfYLiEX7st1cbdth4WyJoX8
	 8zRLmRIqAX7OPH3SJy9Wu0XJ9ozraOHRV+smUSBMeW3c3X09wj4RyxOFBYtzd2lGMrEJB
	 3oruY+KtzSKs6UfEaxNgt1q7pBuzHIW5xnGhlyR6nGeCnx04/9lMTOZ1xUyL/3mM8wRdu
	 1aLNTsl/rjq45zVRTGFv1iajHcOH/cEHuqtjRha0TytcuWz7mpaekxrz3YzdsgPTocA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=fKUfYKhP;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28F606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D28F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=fKUfYKhP
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A3HTiPj004243-6A3HTiPl004243
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 3 Nov 2026 19:29:44 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xOIKO-001cDp-8M;
	Tue, 03 Nov 2026 19:29:44 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 19:29:43 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id cd0e2c86;
	Tue, 3 Nov 2026 17:29:43 +0000 (UTC)
Date: Tue, 3 Nov 2026 19:29:43 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: "Windl, Ulrich" <u.windl@ukr.de>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Q: .gitignore and asterisk "*"
Message-ID: <20261103172943.DKwn8%taahol@utu.fi>
In-Reply-To: <xmqqzevpald4.fsf@gitster.g>
References: <07b3498d83424cac87221724b371839a@ukr.de>
 <xmqq5wyjxgyn.fsf@gitster.g> <20261103073317.DATcL%taahol@utu.fi>
 <xmqqzevpald4.fsf@gitster.g>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-15.utu.fi (130.232.247.55) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZXEgdRh8BBgwEKB0DGkYMDUhY
 SFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZXEgdRh8BBgwEKB0D
 GkYMDUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=qsyJCAM0gdLCi4al8232IaiY7SC64pTyyxU4PbKo0Ko=;
 b=fKUfYKhPqELWA5ci1khzHvFCcojsutcv38tE12yyxn/iuCgZ7rLqvtC5ZuXhoxhM6nekcKb3n+Vi
	XsnDIKYDO5epRpj/+nG4b0UvXYzFIm0B6EFxd9MG7s5fwVkAp2IAXon4A2Oq4T0HbIp6cDi7A5eG
	4+wUYCTBQEvd1CzCjqIB/mFPjW/I3UlkB57NECTychBPxrKdbOX63eEeaO/SEX/354kM32CJKDFP
	3f78czY3b0JtTubYHkcecLhwpUIMsmpFGe92q3tHWRQVCAzkG82qsHJ9Xc8YLqiUE94T8gcqKHw5
	Hv38GTs5fkPRciWKg0fHcxiRwbbQFK+NT2hUQg==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> "Windl, Ulrich" <u.windl@ukr.de> writes:
> 
> Please trim the lines that do not have any relevance to what you are
> going to comment on from your quoted material.
> 
> >> - - An asterisk "`*`" matches anything except a slash.
> >> -   The character "`?`" matches any one character except "`/`".
> >> -   The range notation, e.g. `[a-zA-Z]`, can be used to match
> >> -   one of the characters in a range. See fnmatch(3) and the
> >> -   FNM_PATHNAME flag for a more detailed description.
> >> + - An asterisk "`*`" matches string of any length, and a question mark
> >
> > It's not unreasonable at all to call the empty string "a string of no length",
> > so it is still a bit ambiguous whether it qualifies as a string of any length.
> > I would suggest s/of any length/of length of zero or more/.
> 
> A string of no length falls within the set of strings of any length,
> so I do not see any ambiguity there.
> 
> "A string of length of zero or more" is a roundabout way to say "any
> string" as by definition there is no string of negative length.
> Perhaps that is good enough?

As you wish, although I would like to point that both Linux and BSD versions of
glob(7) are quite explicit in their wording:

	A '*' (not between brackets) matches any string, including the empty string.

and

	*  Matches any sequence of zero or more characters.

(Just thinking aloud.)
