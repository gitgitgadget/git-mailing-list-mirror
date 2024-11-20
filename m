Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6861BBBE0
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132019; cv=none; b=I3/f2UsiY6uBFUN3LQIrtBa7Jo69gTl2YPOsGCiHhaNydLMrOdte7nc/WjUtfDGFx4vru1Srs/cCn5TBb1baxdw/jGN8t0sm70t/tIU0oyWroKaL9x3wD4Roj2yCOLCv4IQDBd4/UXpYdE2cWYxeHiiH+e2+hFducbHEfh2pisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132019; c=relaxed/simple;
	bh=3wwe5IA9qd7D+y2idP6rtwXZd/wRBKx1/VHgiyzQc4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff21cVrHf1rAOmqtavbfk+2CWS8rCRQKC1NwK/noNoMObUrgEv56BKYYNtWqVeYoanfDv9Wq5poeLVGkHMsHL8X1A0WiQXSGxtjtmiJmWE6pWVKk2V/HO3EPYKJw+0ejMr3Ok6aSso+FvsxkQik3vdZvtMieA6qRM9iN3DEU/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R4Edcm4w; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R4Edcm4w"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e9ed5e57a7so259487b3.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732132017; x=1732736817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6FzbxkW9/0oLCiX+v0wYqbx+UDnqNZp5R/svhlMzQE=;
        b=R4Edcm4w9wyPGT5u89a9yEKd4aekHbbv5iP3Azc2aZqscg95FUshQpji7leQWbqODg
         m4lzsKrkSJmtsi15SBwnuxD57Zf9OhjliztXxv6wKJgLIryqF+DCz6PXiwc0qe6LoU08
         p7wJl30/mdKI19qXQe6u+TEbyX9qfLTbF4wHxgP5UjbaxobytSlORW8aXsqQVQiAxzIL
         xPV90y8BpFa8nEBi/hAQFynmsRp4n3RH1RYDPQsEiO3xy86S96/zzBQZV3FvUmZeDtoS
         tS1oCHkvwzb6UHFPHZdFp+TfEidIPjUECD+0u0kYfhhZ2HlEH3HZ3TviD9AHCMsq1c67
         IKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732132017; x=1732736817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6FzbxkW9/0oLCiX+v0wYqbx+UDnqNZp5R/svhlMzQE=;
        b=XgAuOMLg6xqPHc9RuYDy2X1cRM/qQTpIz/6TmKRRWkLjEG/QO2aW4lucXx2BILpEVi
         CnS1gJ6YN4nXN7WAyNmhkCJstcTaCeZzANghI9ltFMR/HVim1zGIbqABQ433fibniAP9
         eeqSAnGA1pnFFNbSxHgxvg/LcLYexyClJx1wQau2WgTmC5sVeEkrSISmeU2o8TaE21Bj
         nUhmeKGx+eeAbRtXJYiX7yX0i0VYZB5egywyB2rOlX21cxgvOCy8CJ9VEHb6psK/wndF
         oA4IucO8yVemmjMgNE86yFu/+CL/KOs3OhwLbOTIlz9o9Lz8o4l30LbZ2nAzXeZwYuSX
         cpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU32VIkbSyISp6CWFSo0A9LHxUDzbz/D8a2lQ1cmJVfEWr1k+C/ap+NS0vCYH5vzMLWeME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTSWAmxXp5uO4F3jgxY5vRhxJBC+B65AXFM84YUnkWhZ0H6Uw
	VYwmRdTHepvzPyCxxzIp7plDCcVDHhievS+fZsuNRqLPwdW+wNOgtGVORedpf8I=
X-Google-Smtp-Source: AGHT+IFcm3KF0fSKh/nqBlEO/lvUNKNmq5y+/dqk/i7gKIi1gZVeQ4nt1nYFJVldUqdAxdIfYp87SA==
X-Received: by 2002:a05:690c:46c1:b0:6ec:b74d:a0ec with SMTP id 00721157ae682-6eebd125b28mr45963737b3.20.1732132017218;
        Wed, 20 Nov 2024 11:46:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7129b472sm23669037b3.33.2024.11.20.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:46:56 -0800 (PST)
Date: Wed, 20 Nov 2024 14:46:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Richard Kerry <richard.kerry@eviden.com>
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"ps@pks.im" <ps@pks.im>
Subject: Re: [PATCH v2 03/10] midx-write: use `revs->repo` inside
 `read_refs_snapshot`
Message-ID: <Zz48r6ZZcol6TQaF@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-3-e2f607174efc@gmail.com>
 <Zz3dAZGAG3BupQqE@ArchLinux>
 <PA4PR07MB74069403837F36FD07D075EB9E212@PA4PR07MB7406.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PA4PR07MB74069403837F36FD07D075EB9E212@PA4PR07MB7406.eurprd07.prod.outlook.com>

On Wed, Nov 20, 2024 at 02:26:23PM +0000, Richard Kerry wrote:
>
> >> The `read_refs_snapshot` uses the `parse_oid_hex` function which
> >> internally uses global variables. Let's instead use
> >
> >Nit: s/variables/variable
>
> No, that's fine.
> It's plural, so ends with 's'.
> Unless it should be "uses a global variable"

The global variable in question here is just "the_hash_algo", so I think
shejialuo's suggestion to use "variable" is correct, but it would need
to be "uses a global variable" instead of "uses global variable"
(without the article).

But I think we're being unnecessarily vague here, and could instead say:

    The function `read_refs_snapshot()` uses `parse_oid_hex()`, which
    relies on the global `the_hash_algo` variable. Let's instead use
    [...]

> >> Also, while here, fix a missing newline after the functions definition.
> >>
> >
> >Nit: s/functions/function
>
> Maybe.
> But it could be "the function's definition" as it could be seen as possessive.

It should be "function's definition", as the possessive is the correct
form.

Thanks,
Taylor
