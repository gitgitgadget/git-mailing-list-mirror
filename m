Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YYQorTIB"
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9A193
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 13:09:08 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-59063f8455eso1276704eaf.3
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 13:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702069748; x=1702674548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcrKtuBxZvWf6Ry4c19X1NX7UIj8PCOGSQRlbb3Nxpc=;
        b=YYQorTIBSxbPgxZvMQaMMX9KIoZ2+BflDdLJR2Cg7IexKr1z9cOyTqnSBONDHo3wco
         tx0IIS6SyT41SKzM+A8qH359nHob9D/HjS0K1blR9etmvFZfNWk9LcKin3hYkUbWGWeb
         jyu5pMPUaXuyB/IWydkyy7t5g0ByUqTgbJ3UUjVVqKy0baWX6TjcXkTA8ubhCRK6Akyi
         hkLQcc/+TTXNOSV2J42oTnCam7jDDCxNSRcTv9W5MktQQbuQtYDg6te2x0TXAFei0hvP
         fVpMBM06bLe4OnLFfppIWHHpQCAATMhMr4AWzzCEghzrboWzZruTqnJ75zkBqUBsrVqn
         Y07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069748; x=1702674548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcrKtuBxZvWf6Ry4c19X1NX7UIj8PCOGSQRlbb3Nxpc=;
        b=os52fhItLPv52VxovLQCh74BxhjJXeYY65r37UiZcZpPphrin7MzBhZBjj7xhwzn8O
         o40Nd4b5a0PZX8iCaqyKz0pdVE4uKQEJlwseWW8+0Tp3OzlAUTz1iaxI2U+/NI05hppa
         jagy7Gp+sWTvv3qmOcdfb1AwQv+Th3DQxLvBh/3L/OzHH2E6iDf28KoFIvUPg0pDC6sM
         maBpxBuz2WMQx6MynLfGGnlC293VPNxSo4hWUEPMyPBh9IANyxz3+/m8eq3tgfFGwvcj
         vbESPQk0lnBJv7ir2IUXmpSBvyB2tP76DZyrKmqjJOlme/x0DZ+XWaUtl0obVTpFEyde
         pYTg==
X-Gm-Message-State: AOJu0YwP0qGUev6RFdj19f7e5CkrjXzFsVLxHxJgF5RCZVeNIx7VaehJ
	b1eIc7DVInt4oV3B1XemsNJOJtUQxjmFwQ4UTGs=
X-Google-Smtp-Source: AGHT+IEpKuHIKJvJpaZBivMfiw9+11LMHrLxvOh971QdtDMxwMoHKP0YOI7gNLYdpKN+spNI8u1lUg==
X-Received: by 2002:a05:6359:294:b0:170:17eb:2056 with SMTP id ek20-20020a056359029400b0017017eb2056mr541880rwb.63.1702069747732;
        Fri, 08 Dec 2023 13:09:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w5-20020a0cef85000000b0067ac1806881sm1090803qvr.85.2023.12.08.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:09:07 -0800 (PST)
Date: Fri, 8 Dec 2023 16:09:03 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <ZXOF75NwxI187QDQ@nand.local>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
 <ZWethlRRtuQLDRlJ@nand.local>
 <20231206210836.GA106480@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206210836.GA106480@coredump.intra.peff.net>

On Wed, Dec 06, 2023 at 04:08:36PM -0500, Jeff King wrote:
> On Wed, Nov 29, 2023 at 04:30:46PM -0500, Taylor Blau wrote:
>
> > On Tue, Nov 28, 2023 at 02:04:46PM -0500, Jeff King wrote:
> > >   - whatever is consuming the embedded repos could "mkdir -p refs
> > >     objects" as needed. This is a minor pain, but I think in the long
> > >     term we are moving to a world where you have to explicitly do
> > >     "GIT_DIR=$PWD/embedded.git" to access an embedded bare repo. So
> > >     they're already special and require some setup; adding an extra step
> > >     may not be so bad.
> >
> > I hope not. I suppose that using embedded bare repositories in a test
> > requires additional setup at least to "cd" into the directory (if they
> > are not using `$GIT_DIR` or `--git-dir` already). But I fear that
> > imposing even a small change like this is too tall an order for how many
> > millions of these exist in the wild across all sorts of projects.
>
> I dunno. I am skeptical that there are millions of these. Who really
> wants to embed bare git repos except for projects related to Git itself,
> which want test vectors? Is there a use case I'm missing?

Just picking on GitHub as an example, my copy has a fair number of
embedded bare repositories:

    $ find . -mindepth 2 -type d -name '*.git' | wc -l
    279

That might be an unfair example in general, since GitHub probably has a
greater need to embed bare repositories than most other projects. But I
think that we shouldn't make our decision here based on volume of
embedded bare repositories, but rather on the number of projects which
have >1 embedded bare repository.

In other words, the cost of migrating a single project's embedded bare
repositories is roughly the same whether there are 1 or 279 of them. So
the effort scales with the number of projects, not repositories.

Perhaps I'm over-estimating how difficult this transition would be to
impose on users. But it does make me very leery to make this kind of a
change without having a better sense of how many of them exist in the
wild.

Searching just on GitHub for `path:**/*.git/config` [^1], it looks like
there are ~1,400 results. That provides us an upper-bound on the number
of projects which have embedded bare repositories, so perhaps I really
am overestimating the burden we'd be imposing on other projects.

I dunno :-).

Thanks,
Taylor

[^1]: Searching for "path:**/*.git" doesn't quite work, since GitHub's
  search doesn't match directories here. So the search I actually used
  isn't perfect, but it should give us a rough approximation.
