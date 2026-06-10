Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094841360E
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105305; cv=pass; b=mrWaeiAvjdZf34jF3pZGB6V7JNepwOMmHeA94x7AONIYPx+Z+AFCuuvwJInOPKzfC/AF0oteHhYpg5H3farsNPv2ESsKSXDOoaliPaoRxDNG7nOs+8KdN2nGy5sfklrb2GEhii3xR/GafKGtfV1ocq3f6lJNiIJ1KRgDDMdVCSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105305; c=relaxed/simple;
	bh=9AYNQvH/u1q3OwReh3LTGR2ZZWVgawduRjVuQlr8mZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZum6hTHvVRe9sf+JyLyHy3rEwu0Q3hzGV6ZEKKvv91dQuEqQFabvFkz/62eOaa60ULnjgjoIPoZUYPHNU+UJ8DD2ihMQTRZ6PvXx+2vKuDCBaL/n5XQl8i4m2HET5XTF0Ywdy/kDUjsmGSHTHCOcROOwVdyllMzQ+T3294zk+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/u4lRWL; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/u4lRWL"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7e1916922b9so76776357b3.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781105303; cv=none;
        d=google.com; s=arc-20240605;
        b=gYLFak6ExMXQitWmZXhJdURFQejEqIwH52Nq85vWwsvzCtKy3vhoI9Rf3qDUmZaX2p
         AKUQoT4zSjVtE68nzW6cCLjRhkyJIly4tiHODxWbNbu3NvPjAGWE+vKVwJ4u1ZP5cIM9
         RzOJ6vaSDOTi/jgNiRXewaQpk/k+uecEI0IUHykj3L1JhpKnyMOoH1gwgg7usG3WgbKP
         yMFlMMyngsfkxWtBNUUVb30RIgDcSYFOnPP6PiTfd8aEDZDVK1Y+1i48DSw8BdVTvdiq
         xV+7oh5Nqu0cvoI8LgqcjsLjRsnyrnS4tRX1enUWJB9r8rxsKshEI+eSAOS5rip+9JgJ
         7ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/PHqIPdSgYkjfnqt7/M2Q99wXv5SJ0nyeARUiqTbEU=;
        fh=w+X3P60Wn7H6AyE8SU8rops3AXBIpMT6WTc9Sp4Ag5g=;
        b=iBW3xpSXdhHJUcYvkMinPGgFhnykmaoRhvY7joOfnHKrTNnp/XLI5h+QE/IXWvs9Ls
         OCNVk3aZM56w4+E45oV/XHqqbaB0ZkYJJfa5ecOMp05sBSI8vXbdnLb7ZweTbnFiPT/D
         ZjniR67UI45Wnhwb2tBjfkGt2T2tn2kjNoc4TOeBgBVaDXDdcBB+vGESJ59OWD0/a8WF
         yAteKAWt87zI1W/P91ZpSM7Cm1pebK7rednwsG6lLYEEeNh8mQc/n0vQDm4CQkAGDcoZ
         4yzT8ksnJWgE339/8DiuNx+Xpj2UkGFhhJoD541lufpbJGISXJ/ZBN4reJciXVdfze91
         gJLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105303; x=1781710103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/PHqIPdSgYkjfnqt7/M2Q99wXv5SJ0nyeARUiqTbEU=;
        b=d/u4lRWLA032SJcPah+/UBvTngNKq3U7uokNU6vjoncXfkxhqvjqklxwSwR7aOskgj
         tWMtwMtqvtdIR47kLefeB6OiZmlEOivQgopQusZH330/1EN6PGZ6gp7aQ6nFZXjqemob
         RSv/xoCHg4CdGgn0VzCyL/LhOpQ4+eRsxzbwu77/NJuXr6Fz11jAJjuttYAwThg17/6b
         E7+2/FSiVRzmWnl9ilhgAJAUDy2X5fLman7jqlIq1/9hq51hu59FeMBk4V60pD2h63TE
         0Z8B2fzg4TJnzQzfP3+iN4jHP0+SSVjwHZh+8+81+5hUfg4K2G+t991QLQ4SW+ZGTBGM
         4JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105303; x=1781710103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/PHqIPdSgYkjfnqt7/M2Q99wXv5SJ0nyeARUiqTbEU=;
        b=b4GPLDTwA/uqlkPW8ZVNHuah0DXYd8E7vCZRnKJzDT98Kk/j8nJuB8WvZWCnmlKD91
         x/S68p84j4+3SIuL/MKlgJD6A15rVdobGg+7YAHAD405ZYAtTjFExIqUlJ54Ek6uNBSr
         tQhJjJoVssrYPuWpxmmNXeASxebYLSUnVsPFepYq3iUHSndzoXUUIepabANANsRKd6B1
         SF2WH/Yey/vbPRquBaz/MVw2/UukTLJXSheiOg/QJZB6jEwAb4DZkodvBNcqJ5Bl8QRa
         /5/sKXzRoz5y4LgRoalSaC2PhHI9sv7kmCStx0KYKfmhkx+m1CFmCIiOazVk5/f6FPm5
         ZgJA==
X-Forwarded-Encrypted: i=1; AFNElJ/ADAtZ66X8wpx7yDlsxVzr3Xs+uOHlo1BkVsAFwD7b3TVYUx0Lh9vWGEqjybt4+QOJa5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31sFGiOKDR2n/h7bqnPzsJv7ijKJQEQZH0vtj+aRnR+HNhxSg
	Q58wgVL6eSmRQf1pv6GnR7NESOuGh84O/U0hgkjeQRiT9m6MtpIxr+3waq5brVw8yIYahCCBwOc
	XX5oUIP+iywKTTSd1GueQvpia8hlCosE=
X-Gm-Gg: Acq92OEdz6EZ3RrrsWc/ZhHaNsVE7agXbPO0zUn8608A/GpqAiq0HEYr/GUj+qfc7Yj
	SQrLZw4UKOnVgzqD0Qm7NDp81sHBDD9EGPCJRy2bY0518HdxvnpFNa4XuZM1eHRf7Cp3QDQJsaf
	muwyGJV07Dv11JGjuMW69m6ivvXUZZqGR0FocsVKsZcjQn/EX2gS/wWaGS6WUIn/wcKc4fKv78H
	CB2pZUX9gw1e3izfr7ExNg9cLBgBjh0qbT79z8/3R7O92aPUxm5+5IYb4Fb87mq7Ry5xJaDgZbb
	GdYdX7ic5FQfsc2o32kEefWnPJiMYWcjRLyWy470RraRbOr94kEicLYg1RDPLlgz50I8hhz4zaU
	l+feM371CbE5l0/MEXTNbAxlSrF0CxN5PQg1m/9Jaewf7GdHz7JlC7Nq7Mz8CsQCeXf6rzKSv2g
	wynbp1OjAEMmCw
X-Received: by 2002:a05:690c:710a:b0:7cf:d594:346f with SMTP id
 00721157ae682-7ed0c61a14amr247949017b3.3.1781105303434; Wed, 10 Jun 2026
 08:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
 <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com> <CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
 <2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com> <CA+J6zkTGgeNuH0eusTy+t8LO3bjygSz4svJB=K4R5ASmBdd0uQ@mail.gmail.com>
 <CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com>
 <xmqq8q9gb704.fsf@gitster.g> <CAN5EUNSFBC0+aoW1ceGjEiKWBRjzuzUEUjg8Xys5O9rDsJdkjg@mail.gmail.com>
 <xmqqcxxyxvyo.fsf@gitster.g>
In-Reply-To: <xmqqcxxyxvyo.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 10 Jun 2026 17:28:12 +0200
X-Gm-Features: AVVi8Cds_nONcWaf2K7zomJhZqL__-46Mq2HD8603DOF8_7pJ5XW4QGbgnXrf-8
Message-ID: <CAN5EUNS4o_SN61UHrGM-4eXDNpkHzYkVKtJbw_CBJGmfbA-Hgw@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 10 jun 2026 a las 17:21, Junio C Hamano (<gitster@pobox.com>) =
escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> >> > Do we want cascading or just a fixed indentation?
> >> >
> >> >     * A parentless
> >> >     * B parentless
> >> >     * C parentless
> >> >   * D1 child
> >> >   * D parentless
> >>
> >> I am late to the party, but I cannot get how the latter is viable.
> >> If "A" had parent "B" whose parent was "C" that is root, wouldn't we
> >> see the same output?  Or are we adding " parentless" at the end of
> >> the one-liner log message?
> >
> > We wouldn't see the same output because A and B wouldn't get padded in
> > that case. Vertical adjacency between indented commits doesn't imply
> > relation because indentation means that they are "parentless",
>
> Hmph, I guess such "the first column is special in that two commits
> on consecutive lines with the asterisk on the same column, if only
> that is on the first column, are parent-child, but it does not hold
> in all other columns" was beyond my imagination. And that was why I
> said I am late to the party.  Do others find such a rule intuitive?
> I didn't (and that is what led me to ask the question).
>
> > Anyways, having more than 2 "parentless" commits one after the other
> > is strange. Cascading is just having a depth counter and printing the
> > padding depth times, so I'll keep it as it is more intuitive.
>
> Is everbody happy with this version, or will we see an updated final
> reroll to tie any loose ends?  For example, do we need the above
> "vertically adjacent commits are in parent-child relationship only
> when they appear on the first column" given as a new instruction in
> the documentation to help users read and understand what the graph
> output is trying to tell them?
>
> Thanks.

Hi!
No, it is not ready yet, sorry, I have to send the next version but I
cannot get some tests to work, I should have it by this week.

Thanks,
Pablo.
