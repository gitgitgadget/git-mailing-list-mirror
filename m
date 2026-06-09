Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FD436365
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015506; cv=none; b=Z3JiDRFbJ73DuQwTtjYk+KeqQ6OPfIY0+cHUOco2xsvn917zaw/D+Q7C9s5u4S7ZKu3m9Bv1/rJsobMDkjG1RrowPKd9NTy27u9k0EJU5pX/dQP39uXyr8B5uNhnoYKbg/MsnBX4G+Im5QhL3wzdftdr1CkshrwhVJnegSCBbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015506; c=relaxed/simple;
	bh=kx2tNsj7IKM2GLpQBbPG5O+sS3ojiU8K8e3NQCNzGgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT6lZgONMoHgTkMiJrelmTbOxky2VT+W41kCCtinOpPMCyWCzyat6ezYivL65Xfxm2y3/4YtD8dQqooBiLnMKQfTrNWS72LYseKxNCKKDEeMcfxnao1tdrFgrJoRvBJ1R85JKUqxKkGt4hhV1SRIMPdwSrbWjA4n2UhKwGu5NN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCosEAOh; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCosEAOh"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69e98c0516dso1484128eaf.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781015503; x=1781620303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsuUo3rWAAnPkarInrN06DCkqpOlozCWS4551VvghU0=;
        b=DCosEAOhbOkjRuldXpKtk50bAXVii6PmsSOysMAqwf5VO8yFj+Cd1EIgCXfwveXMUO
         wC0KVOHpRcWox+T68bpT3th8IRwt6tSVYEH5W1k/ONit6PyTDUtbj1xrwogXXEXjs6QZ
         b7eH+SgoAQMl887+FRluBzS6VL/myc+N+uPuGygoWYRYsyV1kQQ7LjPga8EISYtjDcPs
         FVKLPyAsDuyeF0I1z3CLqRl8RrCUAwVOjwoqA2OZpRqFyXVfSkTcB70vEOrc5YkExTbV
         I06uDzmAmKF1YKQ+dbzLwhy8u0oYXcFbqZVlqkas+dRt5Ak+w4ujwZNKs2Fe1j7Lhmqy
         QMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015503; x=1781620303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsuUo3rWAAnPkarInrN06DCkqpOlozCWS4551VvghU0=;
        b=e6UCc1kAEVQuu2MwbQJnlD7m8xP8KrL1Fx5OiOiJ1k/S2Jh2qUFoW+7WhQNs6wKVN+
         U7u3AAI5tdvvMeW1D3KQ5mKl23Cq0JMo2rsvESrFQc1YW9EOsP7steUlRUaWjQLwG7HD
         wJ7l04DCZa+7TmQXHyxhi/OR/hCRVe590nwSkXq6/AKPGzbjqUY2+SY2snyU8QCUrvW2
         mrGd1KKM5SDBXlw4deF7rv7HF9dsQ9NAJOimTM5A3+xNZMY5MKGRAR7N2Pw7qPZHDAvv
         7PHIB0SaK0TM1vNVBorvlLVieWqUuNmwbR5aV6d2xzfraCAOduAX6Solth1o10uuWpAd
         o3Kg==
X-Gm-Message-State: AOJu0Yyd4Ewa3H3MGg8AcR++G8qdvF7EOu7I/wOKuLpJQ4vNcR8cWrHa
	WhqbCf0u//vyEa7n/7OB0LB/zNnpDkCQhvEXIcpnDW80g5ZWSMjoHegd
X-Gm-Gg: Acq92OENXpW/cJfAnaonjQf4sZre8Ep1r4CE9QqqYoXLTaUMAYmMZWUZqP5Y2nmCL97
	Sx5H7SLpZefraezmbBdkj3+mEy4Iwdctdmi3UEg2kxT+37oeR/zIRlBSpc5iHyDxXDu8OAoQgjS
	bw0+woHVKldlFZdCcaRCGG8gJIT2cwZJuq0c/vlgcPG90TwXwO9wRuQepv76jtY05tPHgTaaC7X
	46WxVoJj1xG+zDpu0t/Z6wquGEJMZ+TF4C32duvFI/Q84Suy1X3UU5c3Z5rhKv4oJvD92ng3OAr
	fHntYI7sNJYEPnm79GD0EtWAMlsRLarVhaBP3GUXjhgX4XYHKzhl3IHNzzOotgAKFl7MY8Nwvns
	7Lvq+i5sOqgwTiE7cnwwC7KhMr++4nBaUVbPBnvUIe0f5FwsZeslrCqrufgeiz5IdIYZKJllAfi
	hYnKAdyXiwHVYwHElIPUcyHeejUKw=
X-Received: by 2002:a05:6820:1687:b0:69e:264b:cced with SMTP id 006d021491bc7-69e68c3c09cmr11835603eaf.41.1781015502877;
        Tue, 09 Jun 2026 07:31:42 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e46450223sm11976158eaf.14.2026.06.09.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:42 -0700 (PDT)
Date: Tue, 9 Jun 2026 09:31:39 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, phillip.wood@dunelm.org.uk, 
	sandals@crustytoothpaste.net
Subject: Re: [GSoC PATCH v2 3/4] repo: add path.gitdir with absolute and
 relative suffix formatting
Message-ID: <aighAZXRtLaz6sg8@denethor>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-4-jayatheerthkulkarni2005@gmail.com>
 <aicDOlJdUrgMi3sA@denethor>
 <CA+rGoLdpkuigWXqNSk3bS7-uhtzCizkPx2GGtNaTyy5J1SF7Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+rGoLdpkuigWXqNSk3bS7-uhtzCizkPx2GGtNaTyy5J1SF7Rg@mail.gmail.com>

On 26/06/09 10:11AM, K Jayatheerth wrote:
> > > +     struct strbuf sb = STRBUF_INIT;
> > > +     enum path_format fmt = (arg_path_format != -1) ? arg_path_format : def_format;
> >
> > hmmm, so `arg_path_format` specifies what the user-provided format and
> > acts as a sentinel to signal there is no value provided and the fallback
> > format needs to be used. This feels a tad bit awkward to me.
> >
> > I wonder if we should introduce a PATH_FORMAT_DEFAULT to the
> > `path_format` enum that maps to one of the existing enum values in
> > `path.c:format_path()`. Here in `print_path()`, we could then intercept
> > a PATH_FORMAT_DEFAULT value and override it to the specified
> > `def_format`. I'm not sure if this is ultimately that much better
> > though.
> 
> You're right that the -1 is awkward
> it forces arg_path_format to be an int rather than the enum type
> itself, which loses type safety.
> 
> PATH_FORMAT_DEFAULT is cleaner in that regard, but it pushes the "what
> does default mean?" question into format_path()
> which currently has no notion of a fallback.
> Since the fallback is call-site specific (each path type in rev-parse
> has its own default),
> I'd rather keep that logic in print_path() where the context lives.
> 
> A middle ground would be adding PATH_FORMAT_DEFAULT to the enum but
> not handling it in format_path().
> 
> ---
> enum path_format_type format = PATH_FORMAT_DEFAULT;
> 
> /* ... */
> 
> static void print_path(const char *path, const char *prefix,
>                        enum path_format_type format,
>                        enum path_format_type def_format)
> {
>         struct strbuf sb = STRBUF_INIT;
>         enum path_format_type fmt =
>             (format == PATH_FORMAT_DEFAULT) ? def_format : format;
> 
>         format_path(&sb, path, prefix, fmt);
>         puts(sb.buf);
>         strbuf_release(&sb);
> }
> ---

Intercepting PATH_FORMAT_DEFAULT in print_path() and overriding it to
the appropriate default needed for the specific path printed by
git-rev-parse(1), as shown above, seems reasonable to me.

But I do think that PATH_FORMAT_DEFAULT should have an actual default in
format_path(). Otherwise we would have an enum value that requires
callers to explicitly handle prior to invoking format_path() which would
also be rather awkward. IMO, it probably wouldn't be a big deal to just
say PATH_FORMAT_DEFAULT is treated as PATH_FORMAT_UNMODIFIED when passed
to format_path() and document it. In practice, our rev-parse use-case
would always replace PATH_FORMAT_DEFAULT with the appropriate value
prior to invoking format_path().

-Justin
