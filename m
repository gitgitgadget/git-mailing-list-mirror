Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD5396D0F
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613893; cv=pass; b=Berjs6/+DxOUEh/GWYksDbQYTKkqiWEeMXkYz0SC8d1yPuPFCcPbUHMleSkNUnkhp6PdKZHj/v6iW7ZTQoSSF1Boq4iv2ucC4lSxHRB31v4yBrrZUudgtY6rnu8PqPNS0ivcjQFoi94n2J4XGPoK0aYB0LQ/JX70o4cR/ljMwuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613893; c=relaxed/simple;
	bh=CPuzMDAKQdMIs3qtw985frTbN6a7zGLedVoPRbu9p7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMdyacgOIc/eCm/kADiHumb5zPME04D0XO7cCd1OP7FgKd4uF0iM/gToLMU8pvvXk7GHfUhULzwaLCH9kx/oeo0K14qJGSrDPjGfAhnykzwWM4/6FYVKnS+2NRGZN8cVVSbcuOF+2da2cpFPbQKuPNUQoFkpEUq8a80B1qrVXf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8DaVAuY; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8DaVAuY"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12732e6a123so880397c88.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 05:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774613891; cv=none;
        d=google.com; s=arc-20240605;
        b=NRIJD6wOjrzQ+amTRKncPT7IQHax1HLBcMMgV0IfHjEe8IC4odOKjwfb3ZJ8qKnX1t
         1bq1Gc7OLKhFJJNR/kwtrTZgRYqea+Hr7UEM/7Re47ZIeWjY2K5OfpmtE/bKs9ZMtQtp
         88oYBIrLpN49J5hz1PIw0IWE2+Z3EkmnaBb5Qi3Xrt+b+prhw9qeqauKSIMfKZhz7gUN
         wtvHEaUoXbmv6xnb4wxRUVlowTFzppHHBGhN7nAp1W/2h8wOAX1NV+JK8erOsHCEAR7s
         xz4CvfRFnuLnR6CWUW0mV25GMn0lVNI2qKrWM2auEGjWekf3/qv/k0WQwc3z7HFHrMYi
         jpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gPZ1C9Wa9d6ORfqmW6KoSZJ2j4b7y7X1X13VWScCdQI=;
        fh=9YIIsTdqbn/IOwcwD19p2Nqg09YwnvZKB8q0RTDKXEQ=;
        b=laGnfrE69GTDI6jIQIe3X2shtZhkgEiGRHHMmb1zEoF9X1VUFHEbHbs3qOEjmoYFk6
         GRrZUmVRfCs5z9dsOre/xAuoXZ5ubColr4roT2YPN4Ouu5WYoBONFkykDSJcM1QDPmNy
         In201cAxcIuaQRLrfyyBII0JRnQVcKYJ4880ffitA/Kh4A09W2HBsOtTBY/T3ntA3lFS
         SBe2R66nc2dEhi7GVVKKgLCkw3BcZFzrU2F6nBAEo6qiw4Dlr1PmGzG0r7NHgfbWlxJb
         X1Sz2aSXSgk6F3UOL9FclpZ416g2x3A4JbNfO13ELDFx/DnHCyR7393Rsd82iFddKJiW
         656A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774613891; x=1775218691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPZ1C9Wa9d6ORfqmW6KoSZJ2j4b7y7X1X13VWScCdQI=;
        b=R8DaVAuYS1nokxe4lvbneRGq5KwEJ/sIQZGQAt/nOUkABsk7LHZN+5Rust4FP8+h5z
         4el2bQrVrH3xpVO2RuZejkKUoBINRskmappHH5CjwMZ4VrJ/5T/lZfaKxarsSSKeEpEO
         7A1PBbU0eXWtVK/rRnoZavVmbocGPCSy9NyrSmXpSi3PDmenpkX/vZXUtg+X03EOa5Vv
         H8tlHG/r0WIZURBzyaeWd1Itll8XYDG2OqdVeR5rWCgIBPL/ipkXVMQnf68kP/YDR40k
         XURn+BBoTRLBl22mmq7uJWZJGbfWQSkhPc3cgNz11jagyhDGSZ0UP9jD227BlKpskXvT
         en+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613891; x=1775218691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gPZ1C9Wa9d6ORfqmW6KoSZJ2j4b7y7X1X13VWScCdQI=;
        b=JyDs+HONzdGdt2SFESxN7nCT0Juke7HHEoVbq4nqDCFUlQFZGc02wbEtmIwwg7mSjc
         2+oCGnPTgIrmrVhf2KoOkrEfHqT0o0DLFUVdff6QVj2E+umtXik/iol6OXeaVBSN02Ra
         E1mli4RIBY/o+cQcFWHKIAi7dZqAuepPYgR1a+6DlKpn/vpoaQ2HqRo5qAuAJZTmwXk4
         +JQVlSNaAVf2OWbIva/sAs+SRYgNyqIoQ04oI5lVX38kzycNfmEQK3Oef6qPppD8UzO1
         2nqHXn/8934TX3SI7xT/u+bs+cBh4xp6vqe2ir6DKRDFWEcS1dHLoZEyq1AlrDkIs/lP
         aE/A==
X-Gm-Message-State: AOJu0YyYn8QZUHYb129+dm0CAhHxxgdytO91dF5X0zHN8WZg5QsyId5A
	a44FCaaOg+XuLp3EKGy7mUGJ20Q6CEC49edhTMxNsvKFFGVzX1eQvYBsQqxks1of+X0uLXgqDRN
	5Sq3pBQDiPCsC36AOz9ZfeAsL5GzbCuc=
X-Gm-Gg: ATEYQzwSG6cVYZUh+U34hqI6vPAYnjV+lbmNcZBRFYVpqAGyhP3AjCOBPIPtKzq+IOq
	s3AEQkUgTRrvsSsiiMoHjfO5wrEAtwaxbnLznZSTrOuflPPVbiPKmujqPBXlN4KZ/NRDhn5JfqF
	wMuYu9KSVIC/RXJUShZwDrxtHh+ZEXnQrvFZj2bJfihek5n4A6/HduhigreLJdQIepcihZEaRMS
	inp0kDq/KUzedB6FKp3Ssf0NcmqtFoiYyJg23SFDVODrzZegqK+kQZN7dLFhGjpQ+Q5I+CxFOLS
	dxiE9R7yZqsWgruMOgkoNA5P8aREsuLaSXI8q4ADdHM+GAcQtM5ehfzUo+3vr4WmM8mE
X-Received: by 2002:a05:7022:238d:b0:121:dea2:d54d with SMTP id
 a92af1059eb24-12ab2912758mr1414271c88.20.1774613890938; Fri, 27 Mar 2026
 05:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-15-christian.couder@gmail.com> <xmqqzf3y4bsg.fsf@gitster.g>
In-Reply-To: <xmqqzf3y4bsg.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Mar 2026 13:17:59 +0100
X-Gm-Features: AQROBzDqPQTvXiJeksv5qHZ8yN_3SWj-58C3XilkF_39cSwj6ZWDDYm3KvlelqA
Message-ID: <CAP8UFD2vAK_khTkJMP4QBfhYA5iYVW5sfB3i-vnzhf71BvwQ=w@mail.gmail.com>
Subject: Re: [PATCH 14/16] promisor-remote: trust known remotes matching acceptFromServerUrl
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > diff --git a/Documentation/config/promisor.adoc b/Documentation/config/=
promisor.adoc
> > index b0fa43b839..6f5442cd65 100644
> > --- a/Documentation/config/promisor.adoc
> > +++ b/Documentation/config/promisor.adoc
> > @@ -51,6 +51,52 @@ promisor.acceptFromServer::
> >       to "fetch" and "clone" requests from the client. Name and URL
> >       comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
> >
> > +promisor.acceptFromServerUrl::
> > +     A glob pattern to specify which URLs advertised by a server
> > +     are considered trusted by the client. This option acts as an
> > +     additive security whitelist that works in conjunction with
> > +     `promisor.acceptFromServer`.
>
> Between the first sentence and the second one, I think there needs
> to be an explanation on what "trusted" means in this context.  Is it
> trusted so that the URL can feed random configuration variable=3Dvalue
> pairs for the client to blindly apply?  Or is it trusted to do very
> limited things that other remotes can do, and if so what are these
> limited things?  Without knowing that, the end-users cannot assess
> the security implications of setting this option.

Yeah, in the current version, the following is used, which is more explicit=
:

    A glob pattern to specify which server-advertised URLs a
    client is allowed to act on. When a URL matches, the client
    will accept the advertised remote as a promisor remote and may
    automatically accept field updates (such as authentication
    tokens) from the server, even if `promisor.acceptFromServer`
    is set to `none` (the default).

> I am guessing that the client would behave as if the existing
> promisor.acceptFromServer configuration variable were set to "all"
> when talking with a remote whose URL matches one of the patterns
> listed?

Yes, that's the idea.

> By the way, some people may suggest "white" -> "allow".

Right, I have changed all the "whitelist" instances with "allowlist".

> > +1. Start with a secure protocol scheme, like `https://` or `ssh://`.
>
> Is there a practical reason why people would want to use schemes
> other than the above two?  This sounds like something a small amount
> of code can easily enforce.

The main issue is that some remote helper schemes might be secure,
while it might be difficult to maintain a hardcoded allowlist of them.
(Different implementations might exist out there with the same scheme
name but different security properties.)

Also file:// and http:// for example might be OK in some corporate setups.

We could add yet another config variable (or env variable) for an
allowlist of schemes (on top of `https://` and `ssh://` which would be
the only ones accepted by default), but maybe we can do that in a
future patch series.

[...]

> >> +3. Don't use globs (`*`) in the domain name. For example
> >> +   `https://cdn.example.com/*` is much safer than
> >> +   `https://*.example.com/*`, because the latter matches
> >> +   `https://evil-hacker.net/fake.example.com/repo`.
> >
> > Is there a practical use case where allowing '*' to match anything
> > that contains a slash '/' is useful?
> >
> >> +4. Make sure to have a `/` at the end of the domain name (or the end
> >> +   of specific directories). For example `https://cdn.example.com/*`
> >> +   is much safer than `https://cdn.example.com*`, because the latter
> >> +   matches `https://cdn.example.com.hacker.net/repo`.
> >
> > Ditto.  The above two points sound like excuses to keep sloppy
> > asterisk matching logic.  Yes, retroactively tightening rules always
> > have risk to break existing deployments, but if existing code paths
> > of urlmatch do not have any good reason to allow '*' to match a
> > string that contains a slash '/', perhaps there is no fallout.
>
> I probably should caution the readers not to take the above too
> literally.  Forbidding an asterisk '*' glob not to match '/'
> anywhere in urlmatch will obviusly break existing deployments that
> does this
>
>     [http "https://example.com/*"]
>         var =3D val
>
> and expects it to catch any URL pointing into the site.

Yeah, the main reason for allowing an asterisk '*' glob to match '/'
is to allow something like:

git config set --global promisor.acceptFromServerUrl "https://my-org.com/*"

to be all what is needed for most internal work in many random orgs.

> But I still do think the matcher should be more intelligent than the
> current implementation to avoid pitfalls like #3 and #4 above.
>
> Perhaps if an additional rule says that '*' after the scheme:// part
> before the first '/' in the pattern, e.g.,
>
>     https://*.example.com/
>     https://*.example.com
>     https://example.com*
>
> unlike '*' that appear anywhere else, never matches a substring that
> contains a slash '/' in it, it would cover plausible mistakes that
> the above #3 and #4 are trying to catch, without hurting any real
> world use case?

I agree that it is better security wise, so I have implemented it in
the current version. Now the scheme and port parts must match exactly
while * match any sequence of characters within the host and path
parts but cannot cross part boundaries.

It's not a panacea though. Users still have to be very careful.

The current documentation looks like this:

--------------------

promisor.acceptFromServerUrl::
    A glob pattern to specify which server-advertised URLs a
    client is allowed to act on. When a URL matches, the client
    will accept the advertised remote as a promisor remote and may
    automatically accept field updates (such as authentication
    tokens) from the server, even if `promisor.acceptFromServer`
    is set to `none` (the default).
+
This option can appear multiple times in config files. An advertised
URL will be accepted if it matches _ANY_ glob pattern specified by
this option in _ANY_ config file read by Git.
+
Be _VERY_ careful with these patterns: `*` matches any sequence of
characters within the 'host' and 'path' parts of a URL (but cannot
cross part boundaries). An overly broad pattern is a major security
risk, as a matching URL allows a server to update fields (such as
authentication tokens) on known remotes without further confirmation.
To minimize security risks, follow these guidelines:
+
1. Start with a secure protocol scheme, like `https://` or `ssh://`.
+
2. Only allow domain names or paths where you control and trust _ALL_
   the content. Be especially careful with shared hosting platforms
   like `github.com` or `gitlab.com`. A broad pattern like
   `https://gitlab.com/*` is dangerous because it trusts every
   repository on the entire platform. Always restrict such patterns to
   your specific organization or namespace (e.g.,
   `https://gitlab.com/your-org/*`).
+
3. Never use globs at the end of domain names. For example,
   `https://cdn.your-org.com/*` might be safe, but
   `https://cdn.your-org.com*/*` is a major security risk because
   the latter matches `https://cdn.your-org.com.hacker.net/repo`.
+
4. Be careful using globs at the beginning of domain names. While the
   code ensures a `*` in the host cannot cross into the path, a
   pattern like `https://*.example.com/*` will still match any
   subdomain. This is extremely dangerous on shared hosting platforms
   (e.g., `https://*.github.io/*` trusts every user's site on the
   entire platform).
+
Before matching, both the advertised URL and the pattern are
normalized: the scheme and host are lowercased, percent-encoded
characters are decoded where possible, and path segments like `..`
are resolved. The port must also match exactly (e.g.,
`https://example.com:8080/*` will not match a URL advertised on
port 9999).
+
For the security implications of accepting a promisor remote, see the
documentation of `promisor.acceptFromServer`. For details on the
protocol, see linkgit:gitprotocol-v2[5].

--------------------

I will work on the suggestions Patrick made before sending the v2
(which I may split into 2 patch series as Patrick suggested).

Thanks.
