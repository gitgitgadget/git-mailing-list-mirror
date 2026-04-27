Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4052FD696
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293956; cv=pass; b=BIMC3HugP1A//JOj7hGAa++/o38QH8cVjVss1W0UFECEc/C8UmwT9u7ZJblyOjYzPYX9I6h/zezN/xYBVAPKOTaUlqBoJAwOrSWx/GllTcQPATbi3GVy0GeeG5L44yBKaZTTmo/wP6fMeKnp4lklJZlrlOelce0ge9IZAhoioZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293956; c=relaxed/simple;
	bh=ZCmOGWmSmYONxPBt5oIXhKqhuAq1DgHDewURApKWuGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ohth4dcjGjSNPdHwDQvwPpwJjab3ewNoRSSem58Z9FyW2VZ03uNyyKT+FHSSfdIOTRoiHlftgavwMLyZjPAC80TMZ8saiCPT263HnrdZgAVjOIVZzN6d+KG76Dwnoag0+TUF31HVpcq9MdunqZp9n2tiNIJnQpJymEuA1MlPqdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/KdVdky; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/KdVdky"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c8cc7a77eso4747014c88.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777293954; cv=none;
        d=google.com; s=arc-20240605;
        b=PPUZMLaVBl4uG1dYAoqYclYuL9cdOMDmpTPnlOukxNHQM3pMOxgC5GoXruqzI21iOj
         LV/6xt3C7cmGTzOijV70aMtqjnul5GfvWC5VHV66GPchX3GdGkaw5PWVfoO0ro6+D+s/
         SOcNbaubtSEcB0JvPE8IKo7V2GRH25+TmTTnSHcAq/Es7fLZFAMI7jhFQie6ElRCGSLa
         muPRdjPmgi0aCUJoPkpxy1nbynmxM/+D1FSGt9L837vN8wzgW+mjgbMoXqt1s8ymouvw
         O6mNG3aFeNUaejM91IFRAFSfb0xxUQ4R1fIgsZdLnjtXqFYenaoH15cffnt5fzQX4KfA
         J4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZleUmQZd426d2tICtxsTB74HB8VMOsAPbzfLofrxyMY=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=ZTbx9zztnYkFIL7TnXboAr1AZxzo/SDx/VTWxsrm4jRjqM8MhYNgaq/SbwxyP/WbpL
         HHzaJCLOgKxsEcAOKSO8xjUKaI6KZAPLUo8gVzXbSwC/hxvNdTkHU0ajJImFzDFp6cbC
         nlSjyqCCtBbmNW4it0GlXHZTfTgNbaV5WyUPKeN0iK599rew05XOhXt5hwthJ9iRvr2Y
         MwWID837tJ3QqCZtECPrC1Rf+7WNArgPDLrY0jWR+FILnwCb0AtgoRJMzyVyP3Or1xLh
         QuO4u/OCdK0ri2LrJCYg7wDn8LXvqCuGcp454sB/FVV/qimNzuozKW4zWFAFche2Cesa
         Db6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293954; x=1777898754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZleUmQZd426d2tICtxsTB74HB8VMOsAPbzfLofrxyMY=;
        b=f/KdVdky6E0V3r9S/hBt8SQXkUc0aYWUSNj241kctQMw7d0C22XwTRILW9UCChzKbk
         5mAIBUOUmplwKPEIctHE96mVe7UQZgLI3njxxw0UvZXXRgfP5yzY9a/i2ccDbEINbuWQ
         jxxkMXRlN9DTAlFjLR3+ZqZOiWaxKgi40Y+od8RzVq+7p1st/mFv2zjQvMdO0SI3UDZ+
         Enk/2Hdl4PfFo36DMYupWazcnOwAbXlqFUzQ4HFAt5Bc/Lbehhj4rqKo61imBPtyiVkd
         uqB1juuflj9PY5ZXeqHKNLEkET1tO+vayxgU6TowKfMQeK+/MSWV0OZRO5XScpCYykYV
         gkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293954; x=1777898754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZleUmQZd426d2tICtxsTB74HB8VMOsAPbzfLofrxyMY=;
        b=rh4fUIDWsChS+kMazrhyDeg48vx9CKjhPdcKSUh477FnCBaszrOBVGSS8WKXI/s/4n
         +Etk88OUfa4sN0humeJc3OqCarHD3lF0GCQl2fnnu44YgVCbkeiLZq2M5whjp2ARxUcj
         4HFXN7YXUjc+dN/7axI7mMDIxIGWECP8lzQmIF3U2DNzd7QTok/YmRpvJyCiQ4v1FUu3
         glszRNnnBp3llIqNRAwJA6mtbi2uJTCSn44qWLQumk8i1FxM0tTp6VxS1woozGM1hmQf
         Pc+nDpXp4dqBN+cJUtqQfFr1KWAFUD/mhAvqavVQzE/lfn514IrM0DRwX0+yLuURxNDG
         WFkA==
X-Gm-Message-State: AOJu0YySpeHvgrmM1+t+Y/Ip0Zu0anB++poyfBRdc1gMIbLGP6j1JV2r
	4mQ4n0WwkHNixYIHO5xsl9xSX4WAWWbcco8YQRj7fvzOdJAq4uSKvr/CtCorZRJyI75c0W6wdgD
	d2imCKy33WVmfZjU9/JHeRTzlpj944ixP+w==
X-Gm-Gg: AeBDieuc3BC6FyFaKjlx0sfoStMYUElf4ku8mvcwq3wmXijBpWMClJu8OGh8kgzdzNa
	xA12gQPjoedykkpAzpkUcUEShQok4W78OjlGmvI7qo/clDAJQ/mIBFQZhXHAeUukHYusg/vSYad
	/iqBzm8gfHvTtDpxfGJ1bJrfaQ7lfy4PKPkEaV0JRLmeMavwijlGxZIoxiZxH6mG8HwutREuwrR
	dqg4TTWgCpYm+hsVj8TH70YBvpCq5Bb4Sv/0m8S312TvsPoCFqOtcklBLsSy/KArAHc9N4sy+9e
	UVWE2Gm1ea2nweDThE6KABGFLYILg1f73piqYt1M1PWmv5ARTs1TDfDwa9Tin21uRKlREjLpV1x
	3AmY=
X-Received: by 2002:a05:7022:fa2:b0:129:1d25:f1da with SMTP id
 a92af1059eb24-12c73ae91a5mr19277580c88.3.1777293954006; Mon, 27 Apr 2026
 05:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-15-christian.couder@gmail.com> <acUk0vTuj8COlvgf@pks.im>
In-Reply-To: <acUk0vTuj8COlvgf@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Apr 2026 14:45:41 +0200
X-Gm-Features: AVHnY4I0YuiAVXrAMNa5QQzcgRL7ueDPUW_xf7hfEuqX1mj7Ob-hPRWZ0Z_MRcY
Message-ID: <CAP8UFD1dvys9nEF6tRudWaeHmmEFH0NGPqK5YM_mk5RQa2=ujw@mail.gmail.com>
Subject: Re: [PATCH 14/16] promisor-remote: trust known remotes matching acceptFromServerUrl
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:17AM +0100, Christian Couder wrote:

> > To enable such targeted updates for trusted URLs, let's use the URL
> > patterns from `promisor.acceptFromServerUrl` as an additional URL
> > based whitelist.
> >
> > Concretely, let's check the advertised URLs against the URL glob
> > patterns by introducing a new small helper function called
> > url_matches_accept_list(), which iterates over the glob patterns and
> > returns the first matching allowed_url entry (or NULL).
> >
> > (Before matching, the advertised URL is passed through url_normalize()
> > so that case variations in the scheme/host, percent-encoding tricks,
> > and ".." path segments cannot bypass the whitelist.)
> >
> > Let's then use this helper at the tail of should_accept_remote() so
> > that, when `accept =3D=3D ACCEPT_NONE`, a known remote whose URL matche=
s
> > the whitelist is still accepted.
> >
> > To prepare for this new logic, let's also:
> >
> >  - Add an 'accept_urls' parameter to should_accept_remote().
> >
> >  - Replace the BUG() guard in the ACCEPT_KNOWN_URL case with an
> >    explicit 'if (accept =3D=3D ACCEPT_KNOWN_URL) return' and a new
> >    BUG() guard in the ACCEPT_NONE case, so url_matches_accept_list()
> >    is only called in the ACCEPT_NONE case.
> >
> >  - Call accept_from_server_url() from filter_promisor_remote()
> >    and relax its early return so that the function is entered when
> >    `accept_urls` has entries even if `accept =3D=3D ACCEPT_NONE`.
> >
> > Let's then properly document `promisor.acceptFromServerUrl` in
> > "promisor.adoc" as an additive security whitelist for known remotes,
> > including the URL normalization behavior, and let's mention it in
> > "gitprotocol-v2.adoc".
>
> I feel like the description is steering a bit too strongly into the
> direction of a step-by-step instruction of how to implement the change
> rather than explaining what's done and why it's done this way.

I have added the following:

"With this, many organizations may only need something like:

  git config set --global \
          promisor.acceptFromServerUrl "https://my-org.com/*"

to accept only their own remotes. And if they need to accept additional
remotes in some specific repos, they can also set:

  git config set promisor.acceptFromServer knownUrl

and configure the additional remote manually only in the repos where
they are needed."

> > +promisor.acceptFromServerUrl::
> > +     A glob pattern to specify which URLs advertised by a server
> > +     are considered trusted by the client. This option acts as an
> > +     additive security whitelist that works in conjunction with
> > +     `promisor.acceptFromServer`.
> > ++
> > +This option can appear multiple times in config files. An advertised
> > +URL will be accepted if it matches _ANY_ glob pattern specified by
> > +this option in _ANY_ config file read by Git.
> > ++
> > +Be _VERY_ careful with these glob patterns, as it can be a big
> > +security hole to allow any advertised remote to be auto-configured!
> > +To minimize security risks, follow these guidelines:
> > ++
> > +1. Start with a secure protocol scheme, like `https://` or `ssh://`.
> > ++
> > +2. Only allow domain names or paths where you control and trust _ALL_
> > +   the content. Be especially careful with shared hosting platforms
> > +   like `github.com` or `gitlab.com`. A broad pattern like
> > +   `https://gitlab.com/*` is dangerous because it trusts every
> > +   repository on the entire platform. Always restrict such patterns to
> > +   your specific organization or namespace (e.g.,
> > +   `https://gitlab.com/your-org/*`).
> > ++
> > +3. Don't use globs (`*`) in the domain name. For example
> > +   `https://cdn.example.com/*` is much safer than
> > +   `https://*.example.com/*`, because the latter matches
> > +   `https://evil-hacker.net/fake.example.com/repo`.
> > ++
> > +4. Make sure to have a `/` at the end of the domain name (or the end
> > +   of specific directories). For example `https://cdn.example.com/*`
> > +   is much safer than `https://cdn.example.com*`, because the latter
> > +   matches `https://cdn.example.com.hacker.net/repo`.
> > ++
> > +Before matching, the advertised URL is normalized: the scheme and
> > +host are lowercased, percent-encoded characters are decoded where
> > +possible, and path segments like `..` are resolved.  Glob patterns
> > +are matched against this normalized URL as-is, so patterns should
> > +be written in normalized form (e.g., lowercase scheme and host).
> > ++
> > +Even if `promisor.acceptFromServer` is set to `None` (the default),
> > +Git will still accept field updates (like tokens) for known remotes,
> > +provided their URLs match a pattern in
> > +`promisor.acceptFromServerUrl`. See linkgit:gitprotocol-v2[5] for
> > +details on the protocol.
>
> Given that there's a bunch to process here, would it make sense to give
> users an example for how to do it properly?

I can give an example like the one I added to the commit message (see
above), but it might be too lax for some use cases. Perhaps in many
organizations only a single repo will ever require to accept promisor
remotes, so giving an example with the `--global` flag like:

  git config set --global promisor.acceptFromServerUrl "https://my-org.com/=
*"

could make everyone's config a bit more vulnerable than necessary.

I think it's better to nudge people to think through the four steps
above, rather than to encourage them to copy-paste something that
might not be very well suited to their needs.

> I also wonder why we require a new config entry instead of extending
> `promisor.acceptFromRemote` to have for example a new "url:https://..."
> setting. Are there cases where you would ever want to use the new
> URL-based schema with a different setting than "all"?

Yes, I think the example in the commit message shows why having both:

- `promisor.acceptFromRemote` that you can set for example to
"knownUrl" only in some specific repos where you accept external
promisor remotes that you configure manually, and

- `promisor.acceptFromRemoteUrl` that you can set for example to
"https://my-org.com/*" globally

can be relatively simple and quite powerful:

- all internal remotes (with URLs in https://my-org.com/) are
automatically accepted in all the repos,
- in certain specific repos, some external remotes (with names and
URLs that are manually configured in the repos) are also accepted.

> I guess the case with "none" is exactly that, where you may auto-update
> configured remotes. But I wonder whether it would be more sensible to
> split out behaviour of accepting and updating promisors into separate
> configuration variables. These are ultimately different concerns, and
> the interaction as layed out in this commit is somewhat non-obvious to
> me.

Let me know if there are things I could clarify more in the above
explanations. I am also open to concrete suggestions.

Thanks.
