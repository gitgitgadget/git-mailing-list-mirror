Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6143B2D14
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888017; cv=pass; b=J/FvBzuYj4hATGFPa3Ublc5Sya0RTEZonnfn44ZzpiWmuGRo49SCht0P+3qLufQm+hMWxnLkN4JCMoEIBiDS5DZ6BuDnIrwIRak9u1Si1jmWwPCTC3We/egUa8lZmqzl8bFJc1VQT7KOlwF4Kj4TjRB1z6XVp/3juZk6dHYhcBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888017; c=relaxed/simple;
	bh=ZyZMcPeG/DtAEcvGc8aSYY2t+tGjMXR8ZVlfpa3uvf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxEPJYwELiBTn3dKvEmx0+cDHHgywzv56vBwkKQJs61S1lODCEOA04XhFp2xVzjZ75ueDo+eYW9jEbcfHnRuWx4NjaBNlOeiiyvjIZ+6jtpYFET0Zj2iP6L/AD0wsQS8fUrurr3aJ1Ad4UjtBu/7SHF085YPIopeLVVi6IQjLWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDrAvNV7; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDrAvNV7"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a377223171so748036eaf.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 13:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783888015; cv=none;
        d=google.com; s=arc-20260327;
        b=cZ5ry73b3H3jPJkwLvq+tcTqrxI0FKZ/lOL9MDBZMWDvG217/Y/wwRgPWAmsjHHWj9
         IOkSMXjmk7goF87ROEEZbsYGu1mfF5TMLhtTr+tRZ/o9dKRt5SNeVgNiMt3/HVYAKWgE
         NAkixKme86gLrSULcztHKslHhE94uRYsWQDSQAGNqWScICLacv+97Islmhrn8euHzQdN
         ErQe8zkvmBNgDkwQwWLKFHCKs7D7gJFv8DQRkzgiMRHPD0Pt6C79zcXx1JInpMzqP1D1
         wBpfcympkKyMQ/zKQ5Wlm4qCvDhEXqWPrndNYMft92gWnBB1bgtv8wU/eil9bowwdkKQ
         48ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wZkE0zQVWT/Gb+Mz6MGzCsA/8G8fpQG0FJznQsBdoTE=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=NIRuSf3GxGBVKlQC7YXBxfk/17iQG+6MXwiPiPhwr7LhYAgjfm4eO2YIcjJmfQufhZ
         9LXFXavDCgRm/3cbq5rocaS96eB0eF3YnTlcQGDcyOkDohqs0qkuR/DCZ0OrN2Oh2Kef
         Od/jij3z9itb3pa23BsfCUgk0mPdls2ujOEfERKRbffLxA+ug4bw81vbn22LwRhnJait
         +Ucvi/B+MWXnSVcI+0CukL6iZfKlHWd8hxWNXYxhdQaRM25Umid3hSlTiAGNJc9iz4oI
         YHVRVcH5bZ+QTDmhHIqrStLhq2V5QSe/g6gNWIteVByNTzJMH1OxpW2PjOUX1tJw+bP7
         is1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783888015; x=1784492815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wZkE0zQVWT/Gb+Mz6MGzCsA/8G8fpQG0FJznQsBdoTE=;
        b=DDrAvNV7ZRxDbjbSvBnrtp2qnZTKow4+VpgsGH8n1/lCJfT8gLB8mTWzxEXIuzHsXg
         MK8kTF85Z6MNS390jG8+ygmTZh4IwPJTdaOcQPHb0eesD2PP0JhqbZ1Q4W6TrybyQAi3
         gkiVdchCRCV+WRDjLdPxmxdz9m6qZAge0MnFuCLqK7vUcdgq1BQpEpGk0PoXd9DtZTb2
         PqB3wyTugQIFinSqbTUsZPYFrZ2NgMfNQglhccf1y3l8XztE4t1iOCBf+ptrxfA3I2Eb
         P00GUG7B6hf/fToEzWgYY68pXROXPJC2PgaMqLqmZgN5KIcQmpWwQuc2Nup2fCUlftC9
         joJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783888015; x=1784492815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZkE0zQVWT/Gb+Mz6MGzCsA/8G8fpQG0FJznQsBdoTE=;
        b=gADy0XHfTb76cvDFBbq+QEeLcWs6rwRBY9TMD87BdYbMGaYoWpC8OVbIP+h83SYaN9
         iun59Hif+d61HY/N382jwz/EfxbsKph+qO0ThoKpasjvvCDw0Dl8Fxa1mW/Z2GiXqr7e
         10QLvI116uCj6N1Q7ZDIR3m1BFJxSu4OvBuoqL0YlHYI0w4ZlzbjiJr98vG7/phfCkk3
         hrF4Fv2WRIueFZyxI2JqcPoCgI04s05XpxqkXyjPzOswIY1Gxiqq1f5/4Xc1FNZbc5tk
         lToD1xepptYfpWJR6HAMHnsWtNzkJR1GB0z97pT+izXV2SVTAxRCy14+KZAxeW5OM+Nr
         hQyA==
X-Gm-Message-State: AOJu0Yx5OsQxC6bdr/L9FeB5Au3iHXr/lHioFZRRVA+86zE7YaPZ8uyS
	7RRcYt+LrYf+QISYMkt7/nD4pZrPOVXVdpVNa7HnWkg06yzsa+65ag9ZwUDOtMN9hl3Y8FKVC22
	7Y7D+RJCSDHkR0+7Lgkse0OjikvTsD8/P4w==
X-Gm-Gg: AfdE7cnoc5RtLTi3CPgQHQvGZHnlB9MJGmFaD1fW3M9JcEPIYMW1rupKKgKLJOlDMb+
	Ej6e5o1scGjepugHWTzpfjQRmKxIszD9EOFe78IB+0Y4eK+q/IyQr7e4QwGgr0Ck+TU73IrjTDo
	7P0NqnEXUsb9RrLQ5CZLCn8ynyMjK9cFuj8g3/QpIbZezIrBcap9OS0LWT9LHvWDEaYdH0dIT8p
	OEosl1xur9FudNA/RDqEDA7+bn2w59Nk+szgP2gVpMvPqrDq3MVrupgDnfystKdURkEGIre/WRE
	4m98ZQoD8T+QSn8KcG5bytsSuqUQ38+0lqfe9X+zbjKmxddh9DoNWyrdFESKATbKNeYi0JeMnsH
	aR1cyW1hubnT078w=
X-Received: by 2002:a05:6820:290a:b0:6a3:92f8:969f with SMTP id
 006d021491bc7-6a39a55c161mr4036988eaf.9.1783888014625; Sun, 12 Jul 2026
 13:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711192650.2417665-1-gitster@pobox.com> <20260711192650.2417665-2-gitster@pobox.com>
In-Reply-To: <20260711192650.2417665-2-gitster@pobox.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 12 Jul 2026 13:26:43 -0700
X-Gm-Features: AUfX_mxsHUIcw6fTGrrzjZgl7Dh0TZpSkpRFPgDkwKgjbAAETUEQXogId9YtqG4
Message-ID: <CAC2QwmL05MbVS=jtk7ARj6jJUT461Ws7BcYqUAUrywvDDXjJqg@mail.gmail.com>
Subject: Re: [PATCH 1/6] SubmittingPatches: clarify expected structure of
 commit log message
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 12:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> +2. **Solution (The Approach)**:
> +   Justify the way your change solves the problem.  Explain why the
> +   proposed approach is better and mention any alternate solutions
> +   considered and discarded.

Slight reflow suggestion (answers the question "better than what?"
and is more concise):

"Explain why the proposed approach is better than any alternate
solutions that were considered and discarded."

> ++
> +If your change only addresses a subset of a larger problem (e.g.,
> +handles directories but not files because of characteristic Y),
> +explain this limitation.  This helps future developers understand the
> +boundaries of your work and whether it can be safely extended.
> ++
> +If the change resolves design or viability concerns raised by the
> +community during prior review rounds, ensure the message records the
> +resolution, explaining why the chosen approach was accepted over
> +alternatives.

In the spirit of paring down text, this last section seems to overlap with
the prior "alternative solutions considered" blurb above. Maybe they can
be combined?

> +
> +3. **Command (The Instruction)**:

"Command" reads a bit awkwardly to me. I think something about
"Implementation" or another phrase that distinguishes between
the mechanics of the change and the design of the change
might be more clear.

> +   [[imperative-mood]]
> +   Command the codebase to change.  Write this in the **imperative
> +   mood** (e.g., "make xyzzy do frotz" instead of "This patch makes
> +   xyzzy do..." or "I changed xyzzy..."), as if you are giving orders
> +   to the codebase to change its behavior.
> +
> +#### Formatting and Style Guidelines
> +
> +* **The Subject Line (First Line)**:
> +  * Keep it short (50 characters is the soft limit).
> +  * Skip the full stop at the end.
> +  * Prefix the subject with the modified area followed by a colon
> +    and a space (e.g., "area: subject").  The area is typically a
> +    filename or identifier (e.g., `doc:`, `transport:`, `t5601:`).
> +    Run `git log --no-merges` on target files to see conventions.
> +  * [[summary-section]]
> +    Do not capitalize the first word after the "area:" prefix unless
> +    there is a specific reason (e.g., `HEAD` is always in caps).
> +    E.g., use "doc: clarify...", not "doc: Clarify...".
> +
> +* **The Body**:
> +  * Explain the *why* rather than repeating the *what* of the diff.

I think collapsing the "Formatting and Style Guidelines" section with
the above would be clearer than having a separate section. The
content prior to this section mixes "content" and "formatting"
guidelines so maybe those concepts could be explicitly delineated
and the advice in this section could be co-located with the commit
message component it is related to above. That might also help
eliminate some redundancy (i.e., another reference to "why vs.
what").

Some more general feedback: maybe examples of well vs. poorly
formed components would help distill the advice for a reader.

Overall, I think reducing the amount of text a contributor needs to
read in order to get up to speed is a very worthwhile endeavor, so
thank you!
