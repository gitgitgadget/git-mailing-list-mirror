Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842BC3B52E2
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777826; cv=pass; b=qBPvw3av5IaR40Sb+i8O303WKSM/Sx4/6T87smM1yiy/JJI7KRbgK7e4cPVII4q/G/AS00eQjTMfUPC4QM5OJYIr+AEqD8hhyVXeb7BnCe9eIg+kXFsTXCpTZuOKIDqUAb06kj5+jTid35txQB/pnX8744HZS0YQ9MEvlfDSRAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777826; c=relaxed/simple;
	bh=cKuTBNKHexONpziNpSWuOx11To2R+K6c9rJ7FgHZdJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwMyw+MW3+2rSleroXci0huwh9IHHIh0oCWBFjV5w+CIl0rNc+VRQpB+gKYNqE+toFpHCbas18GgIVwtFyjaFO5/PM3AAsLu2PbBVfCjeBPMYx3EtJ+/4wfMiavxkT7oFUlasxSCCrzwkSPVn8DmYwmrUrZqG5Q/D7hvXcTm/sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOHScj3t; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOHScj3t"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381b831d535so4127782a91.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 10:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785777824; cv=none;
        d=google.com; s=arc-20260327;
        b=sUXEQGbAQlRtcwJJ6G+awQ4DN5Oxgdh8miiwBjKd+jWnKiU+CfnNUHqNrE4+TemxH+
         7+PDSdCkaf01aXQX+MUYSbPgFA+WDz7gA0OCXHtQ7ySUgoea6TtnnmAPcAF6a1RWLbTc
         uxxj8hsoLv+DTseGxiaVIaC65FHv8UWzvfaYbLDRw4f7geiO6NXHWMIoy9fGg+NjPk8R
         xwkTMAXAI+AhxpUgQIAwz7oReA2XOPh+1WEIKEhDw0TBOWkb4AzlKkzHh35Vcu4EciHp
         lLycbamZ6y/LFkLTtSfyOtT+uYHWfb5cVvNO69W8eIBfEhAnKzghhsQfzorz3lKE8yC3
         tT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J4XeNmfh5G35EeDCpNcXBoMz6emUBIDIa1v517JRXNg=;
        fh=xj50WnDjhkMZcgqGEX8buhQcZkZs0GQjw8JpZg3oSSs=;
        b=h0tlSbs3iQ6NwIPHGX0dQ8QOMnseAT45H22fM9az8ZbehjaNBzj/J/tRloGDLGtuC/
         bkGMY2jedE2XTYlEVqAT+DDOxiPcB+jlabdBwFCDBp1oQ2VbhNjRWxCIN/b1fMTOpICD
         eTj+k/Cf2o3Sy4K6oB8O3ZkmqMMCSz3SWOf+UJhpUbLlQT4g0X5+aWdk5RIwTV5/nsul
         WgiL/dMY4+U0cgVhqr1k6GP8VqGckO8C57suFr1pDzarmCmvSrpA8F/DDUavjSVPytkz
         VMgTXFV46rbtWZDXpZ1DwnEyLD1zuMTlf7fI//YdZTleFL/YWVFOQ5RLjz+dlMQFNgbr
         IKDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785777824; x=1786382624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J4XeNmfh5G35EeDCpNcXBoMz6emUBIDIa1v517JRXNg=;
        b=cOHScj3tmUSOIV3zOdaJ+19sbUJV2aBUEP+T1eOGJ1uviauZO1xWi7PYGnosPOIuzc
         ejfH9Lj9Lf6BGN4L/EGPqhgtICvIBkMuLX69dmDe+N09/5mAF8TV7LARn7lZfNNMC5mw
         jzlHdEovfa5hIL4kiYx0ykFqWigoPQzA/Y9JoXODEb7/p8A2pTe3Lqm1BDqaj+dpURpM
         aZNYVzVRXhUHfnjvlo+zlaS8h4NewopHt9qJhMBRqfSWfHuBY2LKCRwwT7k+4HD/wmkt
         LJWMbKI+Rt+URweCip3Cps8rbVxtRDYT9DJrylw0oxJzZihkidvkF3Au4dmP4/aWcm1Y
         9AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777824; x=1786382624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4XeNmfh5G35EeDCpNcXBoMz6emUBIDIa1v517JRXNg=;
        b=cZeCdiT3FnmTfSqCqiQSPv4/0wG1ATV+Ptq1xJ//A5lr/OZYPFW7IdKR9957RbNph0
         va90Z5KPmrxKXmwKqTWRyITWsKzPZ+caQvWdoTIJtLuVmQ7b1PJx6zpWkfUkeRE+cps1
         mJBpC6SwUjKEVrKWuwM0HTop5iQrvgRQ0jWu1Iz2aBTJDrpOwisoWFMoCjSp12MctbAn
         xRMJULEk2f2PmX+cYLJLdMIsPGVOrIQoAoOgI7jm5D93p9u418AlelSY/RNdUHkNVorq
         td2JZp6SV+nIn5aU7UkGw75MYSOeBR48AlcSt4Z9mGrv+2m4AVkfIl0FzRYVOn5yvRyu
         PgXA==
X-Gm-Message-State: AOJu0YwNKi2ej6qbfREv736uHrg01hq33DRSNdUPfroCmdWKRaJadJkA
	LR/GAEkywsDo3mWNXM1X2Z+XPlwXzJM3hYHKi9BwoAUTe/yQUEv0zyKhNEC1lfDfwyCh75MEeov
	9mENpa/YPd9ARfkDYIo+Y939NSfmOZWI=
X-Gm-Gg: AR+sD12UoW+357b2JxrT73QXTgb7GBxZV1ImchF2w6foGWEKtHorJc2ljgvfbHRMkfz
	mll5IPspfXzzj9DSfdreYIaZTeJk1GYvKPV1KoNv3U+tgkg4ZqnKDOC3Ss9ngR1ulepllWe1RqQ
	Zt/RIVHGrLylkMfyb18Vhm3zvHfFuocG73xSVoU1iFdLbcoZVsIiKs1Z/kqf91RQHlC7CSQC4wM
	547+M3Dfu6cOUDk5b54mWRZY2mdVltDRj22sVjwvOdcZEqAmdxXPsUuaBRiU/lnn7EFz4Pkvnu2
	sJ1bdlgC38N42OpiV/9wPSvgG5hJtsMnumIM48bQWwIwMpyQfcn1Qc0ltFFsx472Jx2CR3hT2RA
	6LTYwiHMdRqv5LdDtp4luOjB7SoOljZpB6qfmadV/
X-Received: by 2002:a05:6a20:2583:b0:3b2:924c:567d with SMTP id
 adf61e73a8af0-3c92a864f82mr10208589637.46.1785777823757; Mon, 03 Aug 2026
 10:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260716165517.433849-8-christian.couder@gmail.com> <xmqq4ihyehyb.fsf@gitster.g>
In-Reply-To: <xmqq4ihyehyb.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Aug 2026 19:23:31 +0200
X-Gm-Features: AUfX_mzEEzBnvua_t8SbX963JLN5hCQ_Bf7-uVcG6Wym_3nzRbsiA3Y5wAzri1E
Message-ID: <CAP8UFD34vCini03OokPT-arcfZRE1KLocb5fVtB3zsHePT2O7Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] fast-import: use struct option for usage string
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> OK, I am a bit torn on this.  On one hand:
>
>  (1) I do agree that it would be nice to eventually have
>      fast_import_state_init() (or some other helper that groks
>      argc/argv) use this options array to parse the command line
>      arguments.
>
>  (2) I am sympathetic to the position that doing so is a bit
>      outside the scope of this series, whose focus is strictly on
>      "git fast-import -h" and nothing else.
>
>  (3) I suspect that when fast_import_state_init() does start using
>      the options array to initialize the state, the parsed results
>      will not be stored in the variables this caller currently holds,
>      but will instead live inside the fast_import_state structure.
>
> So in that sense, the huge list of unused function-local variables
> above are merely throw-away placeholders.  When the real code is
> written, they will disappear, and the references to them in the
> fast_import_options[] array will have to be updated to point to
> members of the structure (or global variables).
>
> Still, seeing all of those variables left uninitialized leaves a
> slightly sour taste.  And because of (3), it would be a clear waste
> of time to go through the motions of initializing these throw-away
> locals.
>
> Perhaps we would end up in a better position if we bent (2) a bit.
> After all, my hesitation likely stems from the feeling that this
> series stops short at a slightly awkward spot, having already
> completed 90% of the journey.
>
> For example, instead of inventing a local, throw-away
> "pack_size_limit" variable, wouldn't it make more sense to refer to
> the existing global "max_packsize" variable from the options[]
> array below?

Yeah, this can work for some variables. But anyway I have tried to
fully move to using the parse-option API to actually parse the command
line options, and I hope to send the result in a v2 soon.
