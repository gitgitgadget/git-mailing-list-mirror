Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4D47FAF1
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725118; cv=pass; b=aHiOa/GbnqU+Wa/S+XATM5c6tveFEy27VNYxixuELqRuFLi/51sUDEbAa9N5RKxkHeRau6zp/QY7bwhp3zh42i3bnSb7MH60p3XtLkghiRmueP+DG6z/4ZjVjvOSxw1Mp3MnRgzRraGlSyAy+exWtVVvR0CEhCVl5OD6L0xg9mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725118; c=relaxed/simple;
	bh=DP/YARy0JQxLM1wKL37xbVzA83YXa1pWKrrMevoSH7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU578WLPC7sf8yj+Hqj8vDQ7T9gMaglQA97jwV7W71hSmRcWAPBOoP27TD5LidD6YxBXSXL+L1rvVtQSmtuDFUfNR4cjXFRYVkhOyl6AwmMKJHEdajs6vpeo/4tmw8c302hQ2R2IZEFIsA5MwrttDxIoZWpq3gaSSxEGCgL1/b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9883BaK; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9883BaK"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6ac83a09781so1485579eaf.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 09:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786725116; cv=none;
        d=google.com; s=arc-20260327;
        b=d7QZIptPPRJbW1NC55/fCL8PPdkRdeBcNbjfvQ0K9duh28Ce3VEwCmjS/MlwEeaacI
         81Px/T/Z0fEN4W95wMKZGtg6z/TFCZaqKYHNqBW3JKY6TK0Lws6Luu6A+jSMCH1VefG+
         wuOmKBW14bWcqU13GtBgYFl1GsaiQLKF/U1no3SL0DFQqm15FWqb4/qJShQIVfhaDFdP
         vyIluGmj3O+pw+p7lPZ4Wlj7lXPi/eYVJMnfl40n86PQroN9XmpBFbH8spvj2+0kMhUw
         Mo1k/UBl/16BmpTT6lINvlLDAm4+jmeU/Ld7fO49youhQlszRpJ3ghQ1L9vnoxcIUIKY
         EDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cq7d3hMzO81k7EgP023wSUw9zOlO/caUwqBrUmHOMto=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=GFjgOV1po+UReh3wlA7YBpWm0L4PLmioG6IzIjExcstmDzmJfHRFxDiEWYZsKDsCP/
         AAnzFrD0lGKSmVLxBKNY5d0Cu8EbFW2qDP7QQm609LRWll0unW/JHhskVxHdV0tbN/Dn
         x2GvmxBc80gd9nvwi3zCLKl+WD14Q/Zmj+hut7OAksZSqHzNFWPWF+9/SK12N8sZQ1ex
         qby5Eqh9gRe51svdQbziE1VUzA5HUwyDZhA/HY8J+09Iir9JIiflLsYKXn/wGtUyls58
         UDGSyGNur60sL7SkFpZrMnnDph1xra+Ikg5IoMfcOlXmUXAz709/aF/+8mG+a0KUxOnT
         Y9YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786725116; x=1787329916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cq7d3hMzO81k7EgP023wSUw9zOlO/caUwqBrUmHOMto=;
        b=B9883BaKWC8UsGC8EkVAxVi9X2gpRa/KIXrFb+MkDoEshn+OxIk4BooIPi0ZsnRArL
         YlHcDV30PMzioGgyxnG9l+8C+GRw5PH5e4e3q/FrWyHvN/MxnY54FQAgYkMA5qQOQsaP
         Tq5BEx3uu8IDGgOP5iza9aIKY2ulipsJ9twuKqQNK/Fz7sdGBifKJOOkj2EQErqdzKfi
         EJFEns0R9VT1djHBbiHkigXw+8msWscUtm0OLmkw63k/y3S0x4hfeTTKaWlBx4UchWiw
         QMoQC7+emVddl2vh8RovrLTNWJgqHpRMzHg41+gTyMVpWs+S1ASpQ0NbqOmtUD5FinjU
         askQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786725116; x=1787329916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cq7d3hMzO81k7EgP023wSUw9zOlO/caUwqBrUmHOMto=;
        b=pe3y8Z+Q8yI9lLopjGZiH8rFgxGhkpLz/WSOoLjwQyl5SvVrBmxpvHnHYpbgnsRqwK
         I7evX6KZTwyXhu3snM1xqCKWug3ajyGqChh8ww6yuiCjT9hfQxVRT6RIYykzDZMUBjv/
         XJe5A62j2/xOrTqPGNymCJfTQ/s4YPu53PBhYlTMN8fxRAF7v/1fhOfDcYLgZF9b6CMv
         WibIZrbNaweCQZm/rhOs72fzGEKklCOQJYeXe2US6Ia6m2CN2tKHO9qpaYBIFPFjOxmr
         HujfkSolGL0aplryRZPtS6Euwx0u4WSrXW0daktgbAkywlW+3OWopYU3Xsva6eOwEiZq
         jgyg==
X-Gm-Message-State: AOJu0YzJkSdTn1rRk0v7W55ALp85l6c8Fki9KH19kXw+5U6ga2Sbx775
	gm+W8zEaAF30jqcbcKfBDZlDJI88Crc45+BNELhWZPLHYti01I5bciOJVY1IEMUnuZAXNaBQsIH
	wxZ1KUPXoEaCs74YE3xpVIxCVvAyPHUs=
X-Gm-Gg: AR+sD136l7zrtMdqkr3aBtWooBMQemgFtnTPvBBmGL5YL1Jl7a5yR/PZASbw69nF+/k
	IzGg5HFN96NKA8MOGrX98/4bIC1PpHRkLmIj6ouX+6o0e7KMNDsSjZ0FFQmJyxffV7hV147BzOg
	jucX5LAV6SixYPwR4OnCN/HRZXtSsYZ4nOVa7XwndwxJ9F1HgWMo5a4zTPx3KI8fAW+GHlJGxzX
	r4NuDy2juqMPmeUOcqThA+f4WwyTL4of3Py9vyXZjuDhOaWx+xvSeGUcy9s8VuHsJqcjd93KgZ1
	Xe0cy3L9X37/dU81Ul2tAJmo9FI63wHgXIUTftTTqLKhEhF2qJvhwvACA7Eu6euGnUb2M07t/YS
	pTCohNezhh6nxI4S8pTdk+admJOSKKiTZARuA0WcDg8P2hSX4JOCYTV0T3kDK1w==
X-Received: by 2002:a05:6820:4d07:b0:6aa:e7f9:fa68 with SMTP id
 006d021491bc7-6b0d7dde466mr3786586eaf.11.1786725115880; Fri, 14 Aug 2026
 09:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135511.1818458-1-christian.couder@gmail.com>
 <20260813154748.2378747-1-christian.couder@gmail.com> <xmqqy0e9rcd9.fsf@gitster.g>
In-Reply-To: <xmqqy0e9rcd9.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 14 Aug 2026 18:31:42 +0200
X-Gm-Features: AUfX_myQzrXCt3HqtPWT2hDr_Kxpa_N_nO7LeU2pqDFQ0OXMKn08UW6JI-4mZic
Message-ID: <CAP8UFD0Mr=6KkJShU+7hfWGZEyi--B=Y1aamPSXO7z97sbTBmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce 'uploadpack.lazyFetchTrusted'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Recently the "promisor-remote" capability was added to protocol v2,
> > allowing servers and clients to agree on the promisor remotes they can
> > safely use.
>
> I do not know what you did, but it seems that an attempt to futz
> with the thread structure i.e.,
>
>     This version is also sent as a separate 'v2' iteration in reply to v1=
,
>     instead of being threaded onto the previous "Introduce a
>     'fromAccepted' option to GIT_NO_LAZY_FETCH" series, and it now
>     contains a 'base-commit' trailer, so that 'b4' and other tools can
>     find the right base and the right patches.
>
> made the patches totally unusable.
>
> This [v2 0/5] has
>
>     Message-ID: <20260813154748.2378747-1-christian.couder@gmail.com>
>     In-reply-to: <20260807135511.1818458-1-christian.couder@gmail.com>
>
> which is *correct*.  It is a reply to [0/5] of the original thread.
> However, [v2 1/5] says:
>
>     Message-ID: <20260813154748.2378747-2-christian.couder@gmail.com>
>     In-reply-to: <20260807135511.1818458-1-christian.couder@gmail.com>
>
> which is quite wrong.  [v2 1/5] should be a reply to the cover
> letter of the v2 iteration.  [v2 2/5], [v2 3/5], ... should also be
> replies to the cover letter of the v2 iteration.

Yeah, sorry. I tried to pass `--in-reply-to` to `git format-patch`
instead of `git send-email` but it looks like they don't behave the
same. Maybe because I have no `format.thread` set, so `git
format-patch` defaults to `--no-thread`, and in that case
`--in-reply-to` applies to every mail, not just the cover letter. I
should have checked more carefully and not tried to improve too many
things at once in my setup.

> I have never seen either plain vanilla send-email or GitGitGadget
> produce misthreaded series like this one.  Do you have some custom
> settings to send things out?

No, I just use `git format-patch` and `git send-email` without special
configuration.

> Here is _one_ way to create a thread of the right shape:
>
>  1. Develop this 5-patch series.
>
>  2. Run
>
>     $ git format-patch -v2 --cover-letter -5
>
>     to grab 0000-cover-letter.patch to 0005-builtin-upload-...patch
>     files.  You may also want to pass --range-diff option.
>
>  3. Edit 0000-cover-letter.patch to your satisfaction.  Do not futz
>     with In-Reply-To or References or Message-Id yourself there;
>     the tool will do this part better than manual editing.
>
>  4. Run
>
>     $ git send-email --no-chain-reply-to \
>       --in-reply-to=3D'<20260807135511.1818458-1-christian.couder@gmail.c=
om>' \
>       000[0-5]-*.patch

Yeah, that's pretty much what I usually do. I don't use
`--no-chain-reply-to` though, but I will.

>     This will make the initial message (which is the cover letter of
>     this iteration) a reply to the named message (which is the cover
>     letter of the v1 iteration), and then the remainder replies to
>     the initial message, which is what we want to see.
>
> There surely are other right ways to do so.  As long as the end
> result would look like
>
>     * vN (1 < N) cover letter is a reply to v1 cover letter
>     * vN patch M (0 < M) is a reply to vN cover letter

Yeah I should have checked more carefully before sending. Thanks.

> things will flow more smoothly.
>
> HTH.
