Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1C189906
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763671228; cv=none; b=GyeMCVu7O+7FsE0vJ1CaoXzjBQJPGp26ZohfxOVUeYe1Y7bulAhLbjZ+NEPGOc8FQTZxKkx6m1CsfdbBSuQ0UhMS6Jd1Do4uCd2oMFjxbvNAFt/6td/rWQESwO7ZBM2rc+LLSE21yR3WnK7GV4LVGuVQeFxWpQqLZQxnZclzGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763671228; c=relaxed/simple;
	bh=dEaTd70PCuVRHJqqXj9RCB8JE4B1eTJpZ5h2qYRJIB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGsma1/B1XsNrR7GIx9jYQ0Qll6pFWrWEAV3/q46wL2XKdO3FRJ+frbRXQi3DFg8cH2H1vduM0jDevOPv6B6MbeHH5p09tV3QiajciH+LTt0amo5WX5l+md6+o6yFG75vSyajni1fgW2lzSE0JtgIWSfAFQQOCm/O7qjxbvYu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGrmdjMC; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGrmdjMC"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4337076ae3fso6825285ab.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 12:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763671225; x=1764276025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDzKKjatWRes6DfzlYXBGWLxqx8nYEAyQrvtamOzXNY=;
        b=lGrmdjMCEqXpwF3MeK+vzAzhy1z8xjeEnm9slLa78kY1Y5Vz3ktpmmvnFz+Je+uEwT
         wzX7Jw+tUP4o+8XTAtPlxtZ6JRqXGttfKw2V91mr/CwUj3SJJ9c4reUuw8bE5v+BGa+D
         mfk4aaUMxeHYoX7BawBxvRAzS0wy6fFFWuY8sc1LrsLSMvkS1CA3SE4ooKhRZnMUJphm
         VEL/Cu/GI7Dygg5JHy46Rq914i4ROcH0OgDks+OYg9B5o1hWVQ/00pexm3wEKZNbgMaj
         9skJbIJpzVJq0mq6k9nynAAcjoPeLe4R5kOOlobk1Vre1d0Zf42tmQnD0IMCMc89t3yZ
         VMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763671225; x=1764276025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDzKKjatWRes6DfzlYXBGWLxqx8nYEAyQrvtamOzXNY=;
        b=jR43WH8cCkswpwx2sXxRlKnIb6XB+HGvYnxzuZh6gFGhDrNxL0SA0n0/Pqf8ItMdC2
         nCDvg8QfqWfiAUCbBgRxNZgHdY6WM6Z9YbFPPpTKxBqyJfvmOAyzQQ/i5selLpKUlmZS
         KaYPYqem52/Pv5tz/dThDkm6Y9a4zUy/xaSEZyfawkCvWtonByjH1qTziE70KOmIrbEX
         XiFFrwON9yG6wmWnC1Fz/TtAaVN50pVolhbrxZO3Q10r/nOz37y1kxOHMzopGlQXFkTo
         Yk+1DBWoQGi0iN9LztJD3ipfpMwdW/v1wvijuk9LqguAv77bCW3uV4P4wceivP/rrGFM
         bLPA==
X-Forwarded-Encrypted: i=1; AJvYcCXF9B5c1OULfQogIdG18j0YP1SLA+5tEebLd9jJyrS8sPm2+J57S1rekS0hybNMYFxYbRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1w9uRNXgmPMiIaHNqfBCoUxLzVXfADoLs4Ty48wv4zo4PhLRw
	zb49feTHmyR/Mq/QYClMK3G/dQ0WaQOmczn1h/5b+SJaDNEpju9O5A6dlakNAi5cEKq1OYx/LEu
	Z7idV1lEYIKrpnKzGW+d/8I4PsEnzKc4=
X-Gm-Gg: ASbGncuZ6XgRPpruFlc3M9GP8pmk+nZf7s+KDahWftrsJd3MRd65S3g60Ixe8ksBMhY
	KJ+hkqGBgJYiD6FPvFj5iNQ94g35qi4Wc2xdcx0VS/pTXZvpr0zp/MhAFxUpiC98ypYX2PcT6TG
	bB1mDhLTwp3VdMSz9zz/kmEWkZJRjXnQrZ3A3n2Uoy3d++gRqTOWJqoQOU8jHhbn/vEF/1kZEPz
	iEknYeM8vSX7TkHfctAnEIjraIeJThU2Absre3z7KOExO+xoYf1SVp9yxVg4b+cuZvxAbuVuPM7
	1nEooaB1gqtxjnnrYuX2EAMsZ3ap
X-Google-Smtp-Source: AGHT+IF/cX5PfeKPxmLzhvjIRhn930/rOYhRcpomABMrpCNNvdruepnHuYhJaJ9jRsIl/DyVLo6bLJaQ6O8HSx8Vjx8=
X-Received: by 2002:a05:6e02:194f:b0:433:58b2:65f1 with SMTP id
 e9e14a558f8ab-435b8e59a0cmr444625ab.15.1763671225487; Thu, 20 Nov 2025
 12:40:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com> <xmqqbjkw78jj.fsf@gitster.g>
In-Reply-To: <xmqqbjkw78jj.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Nov 2025 12:40:12 -0800
X-Gm-Features: AWmQ_bkrfNVbfASDCAs-EQOV-MDUQTKOVUVHnbjPX-z3xGyoyEvnVZ5Hd7SrXx8
Message-ID: <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 12:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> This patch series is a starting point for such a command. I've
> >> significantly slimmed it down from the first couple revisions now
> >> following the discussions at the Contributor's Summit yesterday. This
> >> was my intent anyway, as I already mentioned on the last iteration.
> >
> > Sorry for taking so long to review the series now that it's based on
> > replay.  Thanks for working on this!
>
> With your comments and Phillip's, it seems that we are very close to
> a good stopping point.  Let me mark the topic as expecting a
> hopefully small and final reroll before getting ready for 'next'.
>
> Thanks, all.

I'm a little unsure if it'll be small or just one reroll.  Some of the
changes for patches 5 & 9 might be big (but straightforward), there's
also a couple design related questions (single branch, HEAD-centric)
that might bring up bigger usability issues to address (if a commit
being edited is part of multiple branches, do we just rewrite all of
them by default, or error out unless the user specifies how they want
it handled)?, and a potential gotcha on patch 11 (how can you preserve
the index and working tree if the user edits the patch while splitting
a commit?) that may require rethinking or restricting that feature.
