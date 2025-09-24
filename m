Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D22FD7AA
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726665; cv=none; b=mO5lfvVL1Tv/Utwpof3lgEL1nOirjZngJX0yel8Iuml9QC9lvv1aYYnm+GPz2zhli7gtSxcaI6hvT3GR69vaIp/tuybMbAhZsgYFx6lypjOXv/YopeX0mZyOtSDSOzpJzU/TaA15xD+Dcp66C6vcwE0wxV2AoHuWI/KjZkGUQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726665; c=relaxed/simple;
	bh=Y4VG8bVzVZObAnL4Pa5QrLqXlEEYd707iFnvaG3XbQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCxCwKgceyaIJA2/6ZR6TSmKZO7yxvogyIpzZj4TePd2UBJjIb3gAml7ltJCz0/OHIyDSEyttnG4p+cI2x1TUWpV4kt7Mgbbb6tKA5A7H6eQDBUMQttXWJKyw81lOvPW7zTCjRdIWYHMAheQ1byRvVzliqLk4SebhiOmf4LZi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga2p0rAB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga2p0rAB"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so65640531fa.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758726661; x=1759331461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4VG8bVzVZObAnL4Pa5QrLqXlEEYd707iFnvaG3XbQc=;
        b=ga2p0rABBfXfTFnD/DAZv0UKvim6vwXnOmZLogd55upH1VWOq4/qJOrGXdA3wSR+oc
         5mKZfeGaivEyEZt2yNGYzp8LDNvWwrL9ItIlSjntqUwZyz9O0irKUmC8xzHeHe03J+x2
         k9skYcVHcnGXyca5rDAQDTDcgSVGpp4BRHlM61Wa/K0RbFBw/eTqTleyGk64f+OTCbvz
         82ddE34yEaPjh+K1GVF5JPgBxbUjvFYvXGvf17E9UPVCz3hShS8YjKYwXNI5p4duvQ5P
         nf8soJiXKZiaNOLhExvRRR5XzRp0PbltoYMtsrLI3K9Suf+jpwi0f/XmcfvcBQVcNB+z
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726661; x=1759331461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4VG8bVzVZObAnL4Pa5QrLqXlEEYd707iFnvaG3XbQc=;
        b=ov7+YJeAUkWr6/ouOW2y5W3sBfI8SLyvXoSzwljxJA2o9iyUdmcjtFz7twOuN7mjPB
         iQCZ/eitBquHDUlTCG+h2H0bmHc29xhQIw1JOB7OXLs2B7zG/IsIEdOPdy9av3hs5XJ4
         b/NxDJ+I3kmOT5yd3kXMsGgV+smiQqIju6XgbKYGnY7OrwcGxwtiYi3U6aQu8wfsSefD
         kRQFkHp1XxkkfmrKCVPZVuK/1HaQWqa7AqR3/LGF1Dcxs6o+NrqPx+iR225LPT1GRERF
         Xm1iU7EWM+tm2b4D4g+OOw00eVn3ZHGkeFPkAV6/IhgVftMdvg7gAgL5JiO9DLoIjgoH
         gDgg==
X-Forwarded-Encrypted: i=1; AJvYcCVA2uSjzy6qQSjVaVGr63Dbja9sk5a1lzEH9sP4IzUu8Q/GrnU2doIwToyQduWqdBgmWAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yr/fwSO8P+zsU1rM+oqY73PS9mXUP17r9mpNBHEaQ1hc+6LO
	G7xnA2fLmJtTYH4eFL45eSh2hsWk3HZd5ibOUoOuYI+PvB3R1a86J9iONAAddODzH7x3WQcws7x
	6wkp9oZCn0HANCdRvSfU/n0pww4zgi6U=
X-Gm-Gg: ASbGncskaiOo+M85z5Ulr+AJMmhF3XB5//ODE7T0+kMOaysjXIoX6uaZmc4J2UbYQ/z
	G10wVy2ZmKUZNXhez7SyddhwF4su3hex1tBlIewe/uAYLY+LCu7X9ywTb44B6XV+1XtlN2whF69
	CHq3p8agPZ1Zz8K4YAF4NfaFkaz+REAp8dywLU3I7DiB3uPZKvPeNd3QvtfXfW8YRsocbmHhpcZ
	V5QTNfp
X-Google-Smtp-Source: AGHT+IFoUpQ3hccdpJ0C8xoVJgtsJXlpZwpb9Sr1Of4M4WGldo49GOW4ESBAPCzLO8lCaNEpn7yTwbVv/lgoQcU+nRw=
X-Received: by 2002:a05:651c:25c8:10b0:336:de45:1d9e with SMTP id
 38308e7fff4ca-36d150a62bdmr21107031fa.5.1758726661384; Wed, 24 Sep 2025
 08:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <570ab9f8983d7507cd8f1937176f3268255da416.1758662670.git.gitgitgadget@gmail.com>
 <82ee55d6-f8ae-4a88-84fc-47c6ce18139a@gmail.com>
In-Reply-To: <82ee55d6-f8ae-4a88-84fc-47c6ce18139a@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 24 Sep 2025 09:10:49 -0600
X-Gm-Features: AS18NWCWoBiKymZWT0T9VoQkwLUvU8snC3d2qDH09UGwkRPzkk6mVhnNgYh8PCw
Message-ID: <CAH=ZcbA+MLbyNp3f7RbMFA6vrDZC6yRKVh7ryVer1Ozg3d4oSg@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] xdiff: rename rchg -> changed in xdfile_t
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:21=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> I agree "changed" is a better name but the commit message should explain
> what "rchg" is used for so that someone who is not familiar with the
> code can understand why the change in name is desirable.

The field rchg (now 'changed') declares if a line in a file is changed
or not. A later commit will change it's type from 'char' to 'bool'
to make its purpose even more clear.

Something like that?
