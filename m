Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691207;
	b=CiBQNrMty6rY7sDgyCFZWpvnq0FgVOvNZvNODEa7uqFVSZl5smsdgdmzVS6R9him1luv
	 WjAjVy3MbpCKk0bMCkqJ76nJ9HqjZrvUkyHZvJV4967NZvPhi3sB8yS1rhskg3OOgnuOv
	 1m78uIaQWBoybTGbb22bugxIszbdRhXTi9fa+UMc0BHrl2vngVrRjEYeVVg3lQCPClPRB
	 TXfOHpVOtkYU+cZljjq34GO5UQOQnL3gT8AzVsKO4Y2wKyNXQzlh+OTc7ZKTacMzwL1D2
	 XlIMs+rBYLVejnTaDI+sIlG7M3BC3YAFwi1egbLAz6KHWMPqGiaHYsKRrvSz3masXkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691207;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=ixoZG62/TNTA8sH87T4ifI+RWJdAJA9HDObiM6hezgU=;
	b=nKOA6nJxaza2qIk0MPbiQOBmj8szeE4I4WzM4svYP5IGp0iYrCEPBN9GNeBSOOYtxIH4
	 Ci8jl1XpekMs2iOBEkJ3QXg5LxAnrGJV2ik62hd0eTPRdl7NUmazpOcnBCVEVjiofmCl8
	 bUPdiAS3WUya4BBBB6L/MdV2eCy6i/GU0TJu3tf0uZhWzmuoLoweNhsJk1Vy7KO7BVFIS
	 xeaffMG7N/SXZvP5XiEUCciEF4lbFqQlWdjlaSWftSYQcB8tcUWZp0vva3EjLbDI0YjkU
	 nuH7R63iuX573SUQokTGdeUSM+jfa/DRHzWP7ODppBlXhEIRsfVZBGAZ5aZBDDdFzPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=V9iygSjf;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59661606A332
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59661606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=V9iygSjf
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A37XIwQ011072-6A37XIwS011072
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 3 Nov 2026 09:33:18 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xO91C-000VGt-4C;
	Tue, 03 Nov 2026 09:33:18 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 09:33:17 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id b2db6c10;
	Tue, 3 Nov 2026 07:33:17 +0000 (UTC)
Date: Tue, 3 Nov 2026 09:33:17 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: "Windl, Ulrich" <u.windl@ukr.de>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Q: .gitignore and asterisk "*"
Message-ID: <20261103073317.DATcL%taahol@utu.fi>
In-Reply-To: <xmqq5wyjxgyn.fsf@gitster.g>
References: <07b3498d83424cac87221724b371839a@ukr.de>
 <xmqq5wyjxgyn.fsf@gitster.g>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ex19-15.utu.fi (130.232.247.55) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlcSB1GHwEG
 DAQoHQMaRgwNSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=ixoZG62/TNTA8sH87T4ifI+RWJdAJA9HDObiM6hezgU=;
 b=V9iygSjfD3MRNDL+odI1fyHsgrIqXEJc17yk7txC419+kkukhA6AbkOR23ad/RfKNt9TeNN9W27V
	TAkOc7O8GoiJB6n5wTwS4Y1WiHGBAqmIW50Tzh2L2DxURcU6amav2OsCZmit6nSehVZQHq2opX1Y
	H21oVceNRx/bhIVyDlPG1iHD3S137RxNT0GVUXEBpNTFFD0Vgwafqagwmn1984XFfBhbhobAYApQ
	PbzHWVJexruV5qWx0DQUHlDIZj9/RqX6M1RP+DRim2m2vH07scap6kVD7Yin8aYPyUxAL4FjoaZP
	IlzC82JhTghIn+cBEgl02OJlxk/kGqO7otn59w==

Junio C Hamano <gitster@pobox.com> wrote:

> "Windl, Ulrich" <u.windl@ukr.de> writes:
> 
> > I think the documentation for gitignore(5) could be improved regarding "*":
> > It's nor clear whether "*" matches an empty string.
> > So when I have
> > foo.log
> > foo.msg
> > foo.sh
> > foo-whatever.log
> > foo-whetever.msg
> > Would e.g. "foo*.log" cover all the logs?
> >
> > The manual says:
> >        •   An asterisk "*" matches anything except a slash. The character "?"
> >            matches any one character except "/". The range notation, e.g.
> >            [a-zA-Z], can be used to match one of the characters in a range.
> >            See fnmatch(3) and the FNM_PATHNAME flag for a more detailed
> >            description.
> 
> Very good point.
> 
> The reference to fnmatch(3) may not make readers to consult the
> documentation for the library function.  The system they are on may
> not even have "man".  fnmatch(3) often refers to glob(7), which
> typically would say that a '*' (not between brackets) matches any
> string, including the empty string.  The reference to FNM_PATHNAME
> we have there is an attempt to refer back to fnmatch(3) that would
> typically say that the wildcard does not match a slash.
> 
> How about rewriting the entry like so to reduce external references?
> 
> ----- >8 -----
> Subject: gitignore: rewrite wildcard description
> 
> The documentation for '.gitignore' makes reference to fnmatch(3) and
> FNM_PATHNAME to describe how an asterisk "*" and a question mark "?"
> behave.  Even though it spells out that these wildcard characters
> do not match a slash, it does not say if an asterisk matches an
> empty string (it does).
> 
> Rewrite the section so that the readers would get a more complete
> picture without requiring them to know what fnmatch(3) and glob(7)
> says.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/gitignore.adoc | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git c/Documentation/gitignore.adoc w/Documentation/gitignore.adoc
> index 7979e50f18..671a5a4c99 100644
> --- c/Documentation/gitignore.adoc
> +++ w/Documentation/gitignore.adoc
> @@ -110,11 +110,16 @@ PATTERN FORMAT
>     and `a/frotz` that is a directory (all paths are relative from
>     the `.gitignore` file).
>  
> - - An asterisk "`*`" matches anything except a slash.
> -   The character "`?`" matches any one character except "`/`".
> -   The range notation, e.g. `[a-zA-Z]`, can be used to match
> -   one of the characters in a range. See fnmatch(3) and the
> -   FNM_PATHNAME flag for a more detailed description.
> + - An asterisk "`*`" matches string of any length, and a question mark

It's not unreasonable at all to call the empty string "a string of no length",
so it is still a bit ambiguous whether it qualifies as a string of any length.
I would suggest s/of any length/of length of zero or more/.

> +   "`?`" matches any single character, but these wildcard characters
> +   do not match a slash "`/`".
> +
> + - A pair of brackets that enclose characters match one of the listed
> +   characters, and a range notation inside them, e.g., "`[a-zA-Z]`",
> +   would behave as if all the characters in the range were listed there
> +   instead.  Wildcard characters "`*`" and "`?`" lose their special
> +   meaning inside a pair of brackets, e.g., "`[*]`" would match an
> +   asterisk and nothing else.
>  
>   - A backslash ("`\`") can be used to escape any character. E.g., "`\*`"
>     matches a literal asterisk (and "`\a`" matches "`a`", even though
