Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84214C7C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728876569; cv=none; b=TJi+NW2UhOGZ/FZZcn5bjCIUHGlKD4227na/WgyqPvkWnX9MfW2g1UwZWLILQGjYU0LbQ+sK/HLizm/sBJh85VQr1lEOmQe7lj5gYb/eLoNwLAzTPBaSX8G3hK5G55yue+bQmvq/vKUmWci3l/4TSfatBcE1GVxjZ3ian+S0f/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728876569; c=relaxed/simple;
	bh=rCvOVYvTeUafl1BTFQFOBS439cdb3grQwxsrEqI8cOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue8i3KNpuqepUxf2mItY0gZZZ+vF+MBQWXBUA0iikLJPuzJewQIcIXfP8auPUaM7b9MMIUuVUrlDFbwohBUxhLFyawCoxkLpu/DSlbsGAjZsPYWBEwm2/ywk/xSyGCEs04gh53t2hDf0EuG66d3wGZ6hHc2RFi90uQKfe3QHhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwimIdJk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwimIdJk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cf3e36a76so2718625ad.0
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 20:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728876567; x=1729481367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+MTZkSQPIkxwuUJJ4iWuO0EWod2V2PvPhDBFF+Dzr1o=;
        b=FwimIdJk+NuXiqhVXEG+0vofR6aIxRQTgGWFJt5XyxBn7dQeEBIvTuz63Z+TUJ1DmT
         HIhaIZP3FGtDgAigjG9PxN96Na+9vdk/tCEVmbqqmTeYdI0jLZzlpQg8lhIlent5y3fy
         rzfUsi+cEW99qcDcGC4ywiucRDVrZ5EHcIg3elnlHWqLlqyb/vjdx1Ub52XEGBHf/5BV
         J3FlBjGLVJalSH37a+PC4kD7AMbh313F0Uh50qaVHkRGetMEfrG0ob47zTd9ojjBOhEZ
         FuXfXtRs8Eo5uAx8fupY5Dyk7hPxjAncPBcgMvPsJFv4LI09JIdiqrGQReP12qJ8IeNa
         vq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728876567; x=1729481367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MTZkSQPIkxwuUJJ4iWuO0EWod2V2PvPhDBFF+Dzr1o=;
        b=bWU0IPzGT/DT7OQhDU1KGi0ilIkhwaKGYDROz5srYL0mCQJqz6tSDi8KdWT9etiKLZ
         qPZDaJJdfUQp0Ak2iK51KJ9eRvsrRqUnY4SR/hNnxrqJgvZxRvNmtR9jeBaFEVptAKJs
         4kWqNEqv1MQurzM47wutI2JghnUY0xwChKuHHGKp34o2z6QgpFBdcPzKwj9h4Ixcq/nU
         3JwZ3NvZXtOh2sW6pL/wwtOKmCEsd255ODdvM+CV4sEvcjlbpHreXX+cVtd9ytQ0Qd5w
         tSDW2S63RNnAo3k3f12CQBrHkyqBj8viSgZ8hkauwBof78ZI9mkF2Dt6rcMcuDoCrLJj
         xuKQ==
X-Gm-Message-State: AOJu0YzxqWKNkvZ+DV+xXobaz72h2JqbrXKYJx1PcAPmn4MG9umwV9JW
	NzlPfmPDBnKgiIhFHSyC7PBMY+zpre9ggkqSlBkSlNuM5Hw/yM6O
X-Google-Smtp-Source: AGHT+IH0Im7DECIqiZJY/ZJwdcNRrnGrcDcoKTOto6PhDwOCMOEfuzoRgvSsIR7waknquq1iN4EDcQ==
X-Received: by 2002:a17:902:f545:b0:20c:ee48:94f3 with SMTP id d9443c01a7336-20cee489d9bmr30611845ad.14.1728876566823;
        Sun, 13 Oct 2024 20:29:26 -0700 (PDT)
Received: from localhost ([14.191.221.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad339csm56630845ad.41.2024.10.13.20.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 20:29:26 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:29:23 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: =?utf-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>
Cc: git@vger.kernel.org,
	=?utf-8?Q?imme=C3=ABmosol?= via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] diff-highlight: make install link into DESTDIR
Message-ID: <ZwyQE-BMTn3Fj-BO@danh.dev>
References: <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
 <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>
 <20241012205506.GA55242@coredump.intra.peff.net>
 <CABOUa4bqPiUM+=6dxW5TTHOdMzXiFD02vWoVJcgAQDhZs8DoXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABOUa4bqPiUM+=6dxW5TTHOdMzXiFD02vWoVJcgAQDhZs8DoXg@mail.gmail.com>

On 2024-10-13 01:41:06+0200, immeëmosol <will+developer@willfris.nl> wrote:
> As mentioned, `contrib/diff-highlight` is less like other perl contribs
> like `contrib/contacts` and `contrib/credential/netrc`, those two seem to
> be git subcommands (`git-*`) where diff-highlight is more of a "standalone"
> command.
> 
> My usecase was to peek at what the command does by making it available in a
> `$PATH` writable by a non-root user. (Much like what is mentioned in
> `contrib/diff-highlight/README#Use`: `git log -p --color | diff-highlight`.=
> )
> 
> ```sh
> echo '# Given ~/.local/bin is in $PATH,'
> ( export DESTDIR=3D"${HOME?}/.local/bin/" ; make linked-in-destdir )
> echo '# In another already open shell, try suggestion from readme.'
> ( export DESTDIR=3D"${HOME?}/.local/bin/" ; make clean )
> ```

Nah, it isn't DESTDIR's usage, it's prefix job!

	make prefix=${HOME}/.local install

> ---
> Make git's diff-highlight program immediately available to the command-line=
> .
> Create a link in DESTDIR that
> refers to the generated/concatenated diff-highlight perl script
> 
> Signed-off-by: imme=C3=ABmosol <will+developer@willfris.nl>
> ---
>  contrib/diff-highlight/Makefile | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/diff-highlight/Makefile
> b/contrib/diff-highlight/Makefile
> index f2be7cc9243719..84f6e65c730380 100644
> --- a/contrib/diff-highlight/Makefile
> +++ b/contrib/diff-highlight/Makefile
> @@ -10,6 +10,11 @@ diff-highlight: shebang.perl DiffHighlight.pm
> diff-highlight.perl
>      chmod +x $@+
>      mv $@+ $@
> 
> +linked-in-destdir: diff-highlight
> +    test -n "$(DESTDIR)" && \
> +        test -w $(DESTDIR) && \
> +        ln -s $(abspath $<) $(DESTDIR)

So it would be something like this:

	install: diff-highlight
		$(INSTALL) diff-highlight '$(DESTDIR)$(bindir_SQ)'

> +
>  shebang.perl: FORCE
>      @echo '#!$(PERL_PATH_SQ)' >$@+
>      @cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@
> @@ -17,7 +22,13 @@ shebang.perl: FORCE
>  test: all
>      $(MAKE) -C t
> 
> -clean:
> +unlink-from-destdir:
> +    test -z "$(DESTDIR)" || \
> +        test ! -L $(DESTDIR)/diff-highlight || \
> +        $(RM) $(DESTDIR)/diff-highlight
> +
> +clean: unlink-from-destdir
>      $(RM) diff-highlight
> 
>  .PHONY: FORCE
> +.PHONY: linked-in-destdir unlink-from-destdir
> 

-- 
Danh
