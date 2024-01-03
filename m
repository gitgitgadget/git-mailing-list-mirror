Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B731BDCD
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PA4ebe9r"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4283cd9bd87so1342601cf.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704300038; x=1704904838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFXzoekn5ZpLKCAo94L8SVgQ5SIf4BsClcmgUbxhnAk=;
        b=PA4ebe9rtYA27D4Cnn2EdFzLX9ery2jwBcU26z2zrlf+pbKvzEH//PXuRsXVXswL7D
         hb3ScW9+cn5fyhGrFXzjZrXRxmy6T3DRxWHz8LpSsFO1nhJW2oNBbWEL+R94x6p46RLa
         n64+BJ/MtLL/8okquhAwoRh1eVeAY7YnhSekOGiElavV7bULQQESm3P/nS4p/OQmd3NZ
         eCdDpV7G90a/0oh8OGOhWqEoolJ0UZeOJ8jtv/uA73sgd8BuJTe4O9QXnRfEXgUt39JZ
         jjeqox/ckNnjOp3JO8KhRzrdY095Z4+QJC+3UeCUyaK2dNE5AEki019IowQWbIfSHWKD
         liyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300038; x=1704904838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFXzoekn5ZpLKCAo94L8SVgQ5SIf4BsClcmgUbxhnAk=;
        b=V2IJud1d/YF8/lrddBr0daVTd7BoJo7spCfygi58DGSCBjuC7tXW0N7P1EGX/m7Tu1
         oVnVTPasCZZhwpgESasA392PE8xjYFNcfNY2rFsGYJIB9s4NY/CP1Q1Xp5ZJSX8pl+0Q
         rAx4WH4hxLxrsN2hv8JMr6iV4p1JjdGK3xoMNWHaNVXQKQKNh4Vzz/cLJSm5TvRVQArz
         E6lMr2+jrQ5E8susfSN6RCgL6pBJhROMpXAXOcad8eAUoKy0AuRAu15B893E0fmvZBiW
         se2p3r5D5RU9FC3TpW8BYObzgdon74f8zMCOExcDL/0mAvTjYFdeDzXoBk9HVx2UoQQD
         /ZGw==
X-Gm-Message-State: AOJu0YyrOKDPeOzdZ0i0aVVxPeCExCiEc3y9p4/UIxD6XZr2/43SJpQc
	njoISNnxiI43fDe9oUR+cewGUkpVToNwbw==
X-Google-Smtp-Source: AGHT+IE17VHduI3KlpPqq3PB85nziSSsPNrDe3RJDq+DTBxufNWxY2MjqejMrYonZqDcYV6LqyYMiw==
X-Received: by 2002:ac8:5849:0:b0:428:30f6:aae3 with SMTP id h9-20020ac85849000000b0042830f6aae3mr2601263qth.14.1704300038432;
        Wed, 03 Jan 2024 08:40:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ep5-20020a05622a548500b004282589b74asm2822442qtb.28.2024.01.03.08.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:40:38 -0800 (PST)
Date: Wed, 3 Jan 2024 11:40:36 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Subject: Re: Concurrent fetch commands
Message-ID: <ZZWOBObBmLW9Nid6@nand.local>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g>
 <ZZUNxNciNb_xZveY@tanuki>
 <ZZUWmy3rTjpBsH-w@tanuki>
 <ZZU1TCyQdLqoLxPw@ugly>
 <ZZU5s4LKQF1NLgnC@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZU5s4LKQF1NLgnC@tanuki>

On Wed, Jan 03, 2024 at 11:40:51AM +0100, Patrick Steinhardt wrote:
>   - `--append` should handle concurrency just fine, that is it knows to
>     append to a preexisting lockfile. This is messy though, and the
>     original creator of the lockfile wouldn't know when it can commit it
>     into place.
>
> Both options are kind of ugly, so I'm less sure now whether lockfiles
> are the way to go.

Interesting. Thinking a little bit about what you wrote here, I feel
like `--append[=<FETCH_HEAD>] would do what you need here. The creator
of the lockfile would commit it into place exactly when all children
have finished writing into the existing lockfile.

It seems like that could work, but I haven't poked around to figure out
whether or not that is the case. Regardless, supposing that it does
work, I wonder what users reasonably expect in the presence of multiple
'git fetch' operations. I suppose the answer is that they expect
concurrent fetches to be tolerated, but that the contents of FETCH_HEAD
(and of course the remote references) are consistent at the end of all
of the fetches.

Thanks,
Taylor
