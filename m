Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A9E2FC893
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770328539; cv=none; b=nIrseohhEPEkP3zP5VvTtrNvzCAeQOhlWU4v877S93ah9uc28kLXTB3HTrnpFqEpXqnxVC9d1vsLc+Q7FIeZ6zTmNwDi4pIbpe1Miti+oQjy9IqCbARwBaFHINg98Rt76JLCABCKTqlGzZY/jMLRAQB202sYSg36+FiQ47u/9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770328539; c=relaxed/simple;
	bh=Z5Kf7hdLq/rOmiMqmgddZ6ZWdXpsnZYvRBTVyJUtnHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aWjiDhxhI5lNrbTLhG756Vkb9ZP20GK+fAlAV29+2+BvkWvz1ts6k3TDuSRHtuq5TipZp6c8gqErs1ESe0B3sbocaJcNORhMM64XACYpXSlnshNLwNkhLoVvoaaAohYbjmgvWNcR7ba1vvZsprBbqwIeo5MOD1XdmkxHyJDUMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP2Bt22i; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP2Bt22i"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124566b6693so43033c88.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770328538; x=1770933338; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlJuwPNy236fuzZZASUzwuJ0euYxUbcPJ8VZWRoWXgQ=;
        b=fP2Bt22iXqapaq0UwyJTjBkPrJ3kTg3ABEnNm93SBZMq8mq+TfYFmenOS55vBlpuPs
         wVWsrhK4c574UVjRej1PydX3lTzMlBdDuwHUtetItnLa+M/V1w5EnwJ1KLJotHsusSsr
         bp9JZIIjnazV/kwXo2Pv1KjAwDIUcrqvEWovf5HPndCoddobQIWCC5NhDlPXHLu/G/2m
         /6vpy7QqUiooTO57nBUWeKs55fvqk+gc9ZOE2Xex9n1z1fff0gVkg2Ye7j+/PmcbIZuB
         6TX9pGAy3jVF25Jfeazhxh1AuxfzYpgLvnOW5UI9ORCW3muo157P2MnfcHFN0L1oOyA9
         FYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770328538; x=1770933338;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wlJuwPNy236fuzZZASUzwuJ0euYxUbcPJ8VZWRoWXgQ=;
        b=SAaSf6XHtIPkL458V7+FInmK/twnZXrpobWeenm5t18hxnSj/QACswEZYlOxOEPEFn
         juR5aJoMJC6IJOUUj8X0Rfu46YpiUOH58+1sYMsD/L1833kAh5aY4PkY0Tzg6JfuzxTv
         1F9msSyKOpLCnt7esZeAe06wl7e+ukyNw5p55CFp2AdjS1GyWQjNEvteW1sJelNWvCGU
         JB+g65JRzWzRIKVNjbBhVD83fRc5D29FK552Us6gDZ92ITW1xHCKUKE3KlQh38rSyUaC
         fbYHF7m/aHOh5Bn4JDLTgVd6speVEvnolh+Qy6bUHZ/mOo6Ue67w5d9pOSKK+RD/qV1H
         gMPg==
X-Gm-Message-State: AOJu0Ywo1y22wezRYKt7L7VwStLarrWrfbo97/pYIROR7Bi6MV3jH6LW
	BEkDYmacsMpIQx9ayvk3x2+qemFV7o2VHuZzS5/3sT/1oRRYyY3q34u0
X-Gm-Gg: AZuq6aKksshw+OLrl92txbuB/5dX6ZNwgbjeNWvoQOQoVcsZeWSYwMxxKEY1Ibcb+Ll
	yV1rL4mIzLNzb4jamr1h/n0xuy45iqRvi32qzvaX+dQPB5DCpYWDzVix9KphVGvdisqLn8/03KB
	MLscLnn8Z3zapXNeTL54A164342javbvX/uuSsCYx6BmIqtBD63C43d+cEtFxLhgWCXG8Ow7Wcn
	6Mf3v0ZC9ulkGXFgTVOg6yss+YaBagXuYxse+85YiPXvIvOkl8ftSt7zHEP3cmvmlY+4oRg705W
	llswkJYKidnO8lY5eviRj9JqgSnLNrnpQJfCJBTWHotNmQWxRnB9Oy5KlYEQ3EwUisybe3ZY4s1
	f/cQPm6b6sWpkMFsfKekiJC1nuDY5peP09+E+ytY1ISHL7/qBGfZY/Ux4XmenL4WSpdRz
X-Received: by 2002:a05:7022:b86:b0:11b:9386:a3bf with SMTP id a92af1059eb24-12704073ad7mr377558c88.42.1770328538423;
        Thu, 05 Feb 2026 13:55:38 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270433ae42sm357818c88.10.2026.02.05.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:55:37 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  Colin Stagner <ask+git@howdoi.land>
Subject: Re: [PATCH] ci: avoid ubuntu:rolling in most jobs for now
In-Reply-To: <xmqqy0l6khkd.fsf@gitster.g>
References: <xmqqy0l6khkd.fsf@gitster.g>
Date: Thu, 05 Feb 2026 13:55:37 -0800
Message-ID: <87bji2c0ti.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> We just was hit by buggy uutils dirname in ubuntu:rolling.
> Avoid breakage caused by being on the bleeding edge.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * So here is what I have near the merge of "let's test contrib/
>    stuff as well" in 'seen' for today's integration to avoid getting
>    hit by broken dirname in ubuntu:rolling reported earlier in
>
>     https://lore.kernel.org/git/ef128e1d-dd3e-4573-bfcd-6a98a0a1f394@howdoi.land/
>
>    Until uutils used by ubuntu:rolling stabilizes a bit more, we may
>    want to keep a patch like this in our CI jobs.  Or we may offer
>    ourselves as a guinea-pig?  I do not have strong preference
>    either way.
>
>  .github/workflows/main.yml | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

If you would prefer to keep using ubuntu:rolling, you can do something
like this:

    $ podman run --rm -it ubuntu:25.10
    $ dirname --version
    dirname (uutils coreutils) 0.2.2
    $ apt-get upgrade -y; apt-get update -y;
    [...]
    $ apt-get install -y coreutils-from-gnu coreutils-from-uutils- \
        --allow-remove-essential
    [...]
    $ dirname --version | head -n 1
    dirname (GNU coreutils) 9.5

I'm not familiar with the CI, so I am not voting for either option. I'll
let others decide. :)

Collin
