Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEDF3A718D
	for <git@vger.kernel.org>; Thu, 14 May 2026 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753958; cv=pass; b=TM9EKORg46NO4Wu8QJTwT7tM2/lWdrvIGiPY6X2Fg4dOTKXKied2XpLtw6ZjpF/jOFD/Ln//bI2D8t1psXY9wZDp2IlRn+pDqayZVpNwaMYF4rvgL/FIN1r5I0RLX0rNmtHviGqxcKgfR+7M9Hjkf8Y4Xcpg5u5ALlfzJWtOaV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753958; c=relaxed/simple;
	bh=lwqSxHhE1O9A4jJLcd3KWemxhEwN94Pz2KCfN0v18p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXx6NrHaRgNcdtemoJM/m9Kn4t7eM8rgrGjXlsUKqA5BZ/CS8m+ewQt77p5LQgwCn/pSB3xyCybRpEPKMrNvhnz/wiZ3+pVcToHi8mvv4jlgEi9/k8RpvJfWXAMADv4viCxcXAQGkT2R6FQg9dQVf2X7xE32hSnYAszIjXC6Vns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el02Q3HN; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el02Q3HN"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-651c366f7efso8977372d50.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 03:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778753956; cv=none;
        d=google.com; s=arc-20240605;
        b=fHrjFRnPdBnPLcLWZteuHjXy4AKfXxKVhd1PYFYdU1OwePdOVRHmynxHv+kbdrX2uX
         yKr9WtXGslnudqswLDWFjSsgLnyXPG3Ek88KbJn720kyeFqlTTEFTKYqrdgKT6e2UW8w
         2kecaRKhq3SrCuzPh9p29XWrLLkiPKe7bB78wTpdK4jbPH2SAVqX9UQ1snStzf9Bo7oE
         f0nF+ASUjYzN34qTyQbCcSorLuiuwC7esmt1eIGDOIFEiK1rz1tGhQXVWLuvGhvMna1N
         +d9+W58pjZy/ntiF07So73s29bOOq0Jru2Leu9ZuJptH0ZTeKzmV7MvZ+fIy/WMu2s+m
         cCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=weVZIqNamE2IIBN5n1+L0eSIKomlBpdq9L4tqlBn2Q8=;
        fh=cZu4o5Fz4CunmJcV9r1dfL9elQMf0d7pWtHf9fuHhHM=;
        b=VjL+UlJZvTVq+T8frd7VByHmRnm1Ts2Hb5xEiYlqsoIC7fAi4/gBBbjQ2Wucitv5fS
         tiVjzuvcRUo8QIRGGxxxR3apMhzQf5cz/tn9LZ5+8YeGZzzYfpkCqMmyX/Fbc+j3Ows5
         CvAmsXVYizHvIfQdYr9aw3WT9pNk2Pfq2AC9iBppILFh4VTRvT8+TEneLJQX+agnmuex
         Lp5AwPJ0vytVZT3UCf7ifuMBQZjZkXon1WhATP8kh0FKnHtmhcehIaHBWcslgwMyEmaF
         3UhY57p3JzBI74hJgD3xhd9Pjq3cu+ZcH/qovSYT5EdcS3rMFMgHXwFdLKUzF/7yQVo+
         59+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778753956; x=1779358756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weVZIqNamE2IIBN5n1+L0eSIKomlBpdq9L4tqlBn2Q8=;
        b=el02Q3HNxzoMX/sFX1+Mmttm/0FhgaShb6TIujOChJcjP7as3fwE8IbWymrUtCYN2g
         HwQ97OzWoNdDDz5y2pF3K+DhS7IVrdSDO7sib4t4o9Qq1y6KSB3haE1Jdf0srzJvah9a
         /KhFkmOZAzR/itiaSaye7pwQij0fcSz8TWKvz2PQiI3QVZHL8eJtAw7LHGXcCX2Kfkpv
         K/IgJr9WqYUpFZkMl0Tl7OiDr7Hpz+hqRWKeCA0jBk+eBwmTFN+9ifrlJ+17Z4+pxyv1
         7O651uLPGBeyzwiwlOD0dbos6d5blxOgMEA0wo9tNZ8SX0LOgXmNjyv7iFPJksZq++CM
         qeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778753956; x=1779358756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=weVZIqNamE2IIBN5n1+L0eSIKomlBpdq9L4tqlBn2Q8=;
        b=VGBofktmXoyNs99eMoNuU6XfUsbz7sCOLQFdhZgDDS9LpFppd5Eei3sgcAD7R9Htxg
         Bj2FjYO6cjofEMnbSY9Ar59wuBeDxSL1P1XdEXZPsZo02n3SN7RHYw4QQppgoWty3S4U
         ur6ETQxnt4yAlz8KBY2bkTHzUdKllvWOuXPVOxPBWQ9bkaY2r5f/Pv7l3UfNEQpTP4ML
         uHSa5zKDbKExS1/iiEo6gENENFJ8hRYWPNEeFEG4wZem+cf7uDHsKscN4kzHZ/dcUt1G
         4OxwH5o5dEKBxkvjD8XaO4nm7wwK8aHfkYkYJ88qenRp5Znd75aTAHvXMEbHO6MvEsEp
         THmg==
X-Gm-Message-State: AOJu0Yyyt+oezWYzlqOKBEx2XdAc1NTYAD8VMkWktptD7uazrtftX3vy
	nHvWegtwzVKUJIb2UrmPwjYTzAP6JGangLZnP5L1v5kYTO8Ju/h+r4MmwNBx6AatdI6Na0NvkYo
	NS8AClOiIugEBnlxw1rP46uMgETCKisA=
X-Gm-Gg: Acq92OGej9FaaeIz5WbrxThygsTFyOsXB7wXK18n2MwGxDr9leheoDyyOpOV6IKsSj4
	9CS4p1CyLDRgMd4HitXw1woEFxdbx6PUVSHBbTQV11u2+SDCS4VUaGb9VA66NAdOmNZN93BrOvG
	GUfWJjcH6HuelMA1iKhN5zvWLofhhq1tRTz0HCEamumG14GXUsNNcFJd79tWIqvYfa1EgKai62U
	AtuSL6pPs4jUAEmra8i4H6Kdh6WwVQQhDTD+ZlTA3YiiVFRjhpxA+JTDH7ooy5WTuWGZRwxcbUY
	aN1YMUrJRE7u17Mkj8L6k0Ts1e8b/1bZ6TXnlvloZgs4eYkK/z5VUdSnYggjB047qxocJluo7p7
	0fAMlYjrkv8PmEESYgUEVsDkWxVfHMWSRS71tNzegF9uBv2RHR0iEv0RDeqnY4GBTePVgx9SpQY
	aU7NDFEmeesnQAE8de
X-Received: by 2002:a05:690e:4419:b0:65c:391:571c with SMTP id
 956f58d0204a3-65df6343bcemr5526269d50.49.1778753956263; Thu, 14 May 2026
 03:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404092425.550346-1-pabloosabaterr@gmail.com>
 <20260427102838.44867-1-pabloosabaterr@gmail.com> <20260427102838.44867-2-pabloosabaterr@gmail.com>
 <20260513230216.GA1378627@coredump.intra.peff.net>
In-Reply-To: <20260513230216.GA1378627@coredump.intra.peff.net>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Thu, 14 May 2026 12:19:01 +0200
X-Gm-Features: AVHnY4L6Qkx95vFns5Vp9KTbu-Zt7vy7myc-exzoCwnA1R9ebcC4U7pVp2IR7FM
Message-ID: <CAN5EUNSxyT5EyTf8b4evbW+JbDeRms91zQEn_JgiinOgvpe6mQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v3 1/1] graph: add indentation for commits preceded
 by a parentless commit
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 14 may 2026 a las 1:02, Jeff King (<peff@peff.net>) escribi=C3=B3:
>
> On Mon, Apr 27, 2026 at 12:28:38PM +0200, Pablo Sabater wrote:
>
> > @@ -1135,7 +1227,18 @@ static void graph_output_post_merge_line(struct =
git_graph *graph, struct graph_l
> >                               graph_line_write_column(line, col, '|');
> >                       graph_line_addch(line, ' ');
> >               } else {
> > -                     graph_line_write_column(line, col, '|');
> > +                     if (col->is_placeholder) {
> > +                             /*
> > +                              * Same placeholder handling as in
> > +                              * graph_output_commit_line().
> > +                              */
> > +                             if (seen_this)
> > +                                     continue;
> > +                             graph_line_write_column(line, col, ' ');
> > +                     } else {
> > +                             graph_line_write_column(line, col, '|');
> > +                     }
>
> I haven't looked closely at the patch, but Coverity complained that
> the "if (seen_this)" check here is dead code, because this whole else
> block follows:
>
>                   } else if (seen_this) {
>                           if (graph->edges_added > 0)
>                                   graph_line_write_column(line, col, '\\'=
);
>                           else
>                                   graph_line_write_column(line, col, '|')=
;
>                           graph_line_addch(line, ' ');
>                   } else {
>                         ...the code above...
>
> I don't know if that just means the continue here is redundant and can
> be removed, or if it's a sign of a larger logic error.
>
> -Peff

It is dead code. The behaviour for placeholder at
"graph_output_commit_line()" and "graph_output_post_merge_line()" is
the same, if it's a placeholder print a padding instead of an edge,
but I didn't give it a second thought, graph_output_commit_line() can
have a placeholder at its right (that's why it needs the continue to
avoid extra padding) but post merge can't and as it is dead code I
didn't notice.
I'll drop the dead code.

Thanks,

--
Pablo
