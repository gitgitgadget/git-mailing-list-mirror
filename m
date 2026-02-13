Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981823EA85
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990130; cv=pass; b=r1gbHJM2Z5HrZ3cNVZLqArkc2xw5dQvqIkzghKETKSzYAOSE9viOJCp4vjxloGe/Ke+6hLWuKxy69JQflT4IISyzjfNjvEh4rMYbAmtYweSexQFcWQmTpHcioFIS6r+8tRm+YEAGj7XwdlEXpyKf4vxF7iZB6IC74nkmfbnGt4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990130; c=relaxed/simple;
	bh=zFmPA5BOZNrUvbJiYT/D8uMQl9Jh6KOtf+dBGOlKAt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEneylyVEPoyGPEYy+mjQOMLYAIhs4BUJ0IydNvM0uybF+qFSU25GZ5RwwZeZ92CtzW+9abVQm2UmNwlWfdldb/Sq/2oOA6Vi1c7gN1IJqZDqvej20+wNSMSk41N+i2qMYPvYFGHdArSRgyCCRmh2pME6PE4gF+gLFHKewelyxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=WluZWkT/; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="WluZWkT/"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38709888abeso7469371fa.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:42:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770990127; cv=none;
        d=google.com; s=arc-20240605;
        b=TH34hth7GJX7fhbeIU2/YgXCzAHaMblRcuHOXaVJArLDx2E78PzLC4c+wICdFcml5g
         YLMExL+nEQgkP3duHWpUNmbsGHeTWNHen0CLURzUuVMPEr6xj3rWFLH3XKim031V5Qop
         gYy9ZJaijDlgUu/UnW+AboxPW/iLwcCPlteLrBeVnwiOKv2P3++55S8pc5pZn95xIKwS
         GyM8nC5edn9rmhq8J+XHWil17Ynsch6zkXeMV8+m3qV0fdWLvI1HAnVHlKIFFoOno1fA
         pgBa/x+efUQhqWaZDZNLt8JJvhry4pmor3L2n9AL+oiIHtUNv3ypyTOHDzgIchtPFoPX
         RmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RqrniWO5UgInZE2zhUt1zATliRJMupjvBXu+G4CyQc0=;
        fh=ixFrjK453DVOawTiHnv5diTuDiZdwkm/MsNkP7iAL/8=;
        b=DlojBuhkWReHsLSZzk7aXid9u5q2cildctbCtcyaLM4neZSUmTdALcRNeHfyQOiNIe
         FdG5QsmzY4sYrsVhuOgNl7nZpd2DVv+TEamHo/XzmW+jzWeLn1EhNoyf+wLLZew5q8GG
         Vg/N1+w4GeH1gnAgE1p/7zHqif6E1/dKcnhDVXJCjzog3PO6ApmL5eG+ZwYq0p3KIghQ
         eNYO6TNgc7cMnwfrCnvmT3IVD+4xrFIENEZq2T6XjHK85I0Vy5yLjSp3G82BuLJxd3GJ
         ihOcAO17uHZVACdYb03FAMJSD38izIPBRZluUGE5g4fU3bemu8MctwHWarwwIlY0Ok+v
         IvJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1770990127; x=1771594927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqrniWO5UgInZE2zhUt1zATliRJMupjvBXu+G4CyQc0=;
        b=WluZWkT/RQH6S1MqLXCoTxl2PM2LCfK+f7QvwAaC2XbJx4NFrI1cy9WosuDoIdiZyH
         VAjIOXYPBceZhTtvuFDIaujZn0wm/0sVkGslUI4zNcVQBKP25ENZbaC53+F0AmWsV44u
         vkMmINpnT3QZ2wnGliQTlkgakCQkjaSEgnxeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770990127; x=1771594927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqrniWO5UgInZE2zhUt1zATliRJMupjvBXu+G4CyQc0=;
        b=UsD3xG60pa5UPM7pNSYUHLN92sLg0zdMBrnelh2Hr7amT7A7Y5m38+Adfd7sQpYeO1
         Cul3ZiPZWTHLYgnYhYlyPlfu9rdIwhI+YitNyVp79tefo299fakBMjwesfsYZzoLsct3
         rIeblLLqlJu5V0IXOH39t5H5imL/xn2mZNJ5sELavsD4elo6NTCl+hwSVxILGHyS3FLF
         /NSdmI3zWYHH6/qEjdhEgQlnufKhU3Mr67Bu6zUgKu9aW6oF871Ch2aS/iERKlsfxhmK
         2UlXQYCMpiOoHneGgPsn+ETwpNAeVDn7ScVR/7n4jGPCZ0hkXWrBOlBnJi5B28fJNJkZ
         By+w==
X-Forwarded-Encrypted: i=1; AJvYcCVOCWItEkAiCW0KNjFdO562QplZazFvaIRx5kNqKbgCC+cBjEV7ZnIO5Mt1NdB3eohe4uA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Pfvr10C29k2pmR+sDkmPaP8AQHUeYZ2piRvvlvt4w2e+EAy1
	Jlpz34DAuEoO1S/pkWQU+HEVoX1F+BmV5zDVUbUh4BpFZ/yRBn/hKew1eoEb5BFGGYpTCEgzAOC
	WnGDjM6B4VaELAaVcahQcfs0SXbtRrzIdiXPpxjXUK04S6A7KEZBovNo=
X-Gm-Gg: AZuq6aJGvsdV8Kdl+m9boRJa2uc8uOvLtVB0BgwmtQKUGrzo0vX4HebbyixXdTt7YOv
	fGzIqpVjcp8myFDyqnZ81K4JNbJQrcGXl3QaJxoj3wbz0dWP/Lw03NIt9d+RXgU4uLgBbI8QFFY
	RidbTN4ScXoD8OmYxaL0FuJzzwsZ/yNBC2CL/+vhKBjI6ZGlqpQmKTPY4giK7HT3I/sGvWemiBg
	K1UZEKbgXVoIki2m3vUSaw7efBQhwYgifPLYikbd3Ve62jQ4n1ODdFVbu7NWpqgj39w70ZPQCzs
	oJw=
X-Received: by 2002:a2e:bc08:0:b0:385:d1a0:6be0 with SMTP id
 38308e7fff4ca-38810538629mr6346681fa.19.1770990126861; Fri, 13 Feb 2026
 05:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com> <d80ce077038bab96aca26b0b0ad706c91ea1d8a8.1766069088.git.gitgitgadget@gmail.com>
 <aYvV2W5pcvqZig8S@nand.local> <20260211091333.GA1868492@coredump.intra.peff.net>
In-Reply-To: <20260211091333.GA1868492@coredump.intra.peff.net>
From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Date: Fri, 13 Feb 2026 15:41:55 +0200
X-Gm-Features: AZwV_QiWWFH9l6dFdzjV8VXWOfoa1mQXXVY21TXU_KKu_ZDdh7j1XRM9o0fct-A
Message-ID: <CAGjQmDMhWFx32M+2DrZ3cF-mt+T==LNEzXRO4z=R73RjZnTQPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] http: add support for HTTP 429 rate limit retries
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, 
	Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 11:13=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> Yeah, I noticed that, too. And all of the parsing actually makes me
> nervous. Surely curl can do some of this for us?
>
> ...studies some manpages...
>
> Ah, indeed. How about:
>
>   curl_off_t wait =3D 0;
>   curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER, &wait);
>
> You can see how we already dig out similar info in finish_active_slot().
> And more extended (but optional) info in http_request(). It looks like
> CURLINFO_RETRY_AFTER was added in 7.66.0, so this would have to be a
> conditional feature at build-time. But that seems like a reasonable
> trade-off.

I'll add parsing with libcurl under conditional feature.

> Most of the details of this active slot stuff have long been paged out
> of my memory. It's all _so_ messy because of the desire for the
> dumb-http code to handle multiple requests. But for smart-http (and I
> would be perfectly content for this feature to only apply there), we
> could probably just focus on run_one_slot(), I'd think.
>
> I.e., what I'd expect the simplest form of the patch to look like is
> roughly:
>
>   - teach handle_curl_result() to recognize 429 and pull out the
>     retry-after value, returning HTTP_RETRY
>
>   - in run_one_slot(), recognize HTTP_RETRY and if appropriate, sleep
>     and retry
>

This greatly simplifies implementation. I think following similar pattern l=
ike
auth handling does makes a lot of sense. So, instead of sleeping in
run_one_slot(), I think it makes sense to sleep in http_request_recoverable=
()
where HTTP_REAUTH is handled.

> > I may solicit Peff's input here on the remainder of the test changes,
> > since he is much more familiar with the lib-httpd parts of the suite
> > than I am.
>
> The lib-httpd parts looked about as I'd expect (and I found the use of
> custom URL components to encode the retry parameters quite clever).
>
> There were lots of uses of "date" that I suspect may give us portability
> problems. "+%s" is not even in POSIX, but maybe it is universal enough.
> But stuff like '-d "+2 seconds"' seems likely to be a GNU-ism.
>
> Using "test-tool date" might get around some of that. We even understand
> relative dates like "2 seconds ago", but I think only in the past. :-/
> So you'd probably have to do:
>
>   now=3D$(test-tool date timestamp now | cut -d' ' -f3)
>   then=3D$((now + 2))
>   test-tool date show:rfc2822 $then
>
> or something.

I was not aware about test-tool, thanks!

> -Peff

Thanks, Peff, for the review!
