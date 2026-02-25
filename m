Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7332765ED
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771985899; cv=none; b=UP/mhTiYNgKKXofLp2cmMAPTADMIOiKFRof2hQYQD1cXGCCWsLnw7AfwuJBAuaj/yHbpHzfz+2hhbXcvt7DN/u4r+u8DTYKtvLVosCL3dYGd3nWQpZffYuyRrAtgCrdrBLDqepElv1tnMkb9Vop8lMIGHTRpKzxpASG9DoSrcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771985899; c=relaxed/simple;
	bh=T+ROTNH9r2HKqLTOXNV+y9TctF5IlZaJa7kRtn2aBhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+2ew0IXjzXbLRibLc8aZfv3rcDyAo0ycz3cw5WCNr8sQkHsreZgEgFHiR6Zwsr6ZOvsImb9MWKSsjwwBXB06WdbeiK6vkO10E3pD8eEZUD/T9U/cD1RTgD+vVVTjLMXPEb2S8kN/pba+N6v5s3BjcC1jqSqVeWSLOXsu6hAx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnnBTu87; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnnBTu87"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4807068eacbso48036505e9.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771985897; x=1772590697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqRloZUWm1YX8Y2GvFGiW+CWFq9B9c9r/iJQhisOJfI=;
        b=RnnBTu87Fm974yLRxfkwW18WaKoD5LLrvXVc+r7fiY+3IkUD3YmgWa2RS7RUiqkVJI
         1NUfx5di3znk84C3LSUN2JKru/6aEzp8bNZ0yMWFNhqdDDyOuUNZf/BV7BFEgOJAqG9M
         1yIYIQA6+OCG3EOcLNy+iZ2NBZYgtCHhjsfcO6XHRfPO0nEqLLZDthUmPPByFStmDgIx
         eAknYDg5WoSpsjyEE4v8pHD2cQuJKcxuYp7WeplYSmHo4VFbXiFc8K8QejlsWajypEfJ
         D6iUWzr3Kxj0/YoBISyn+7xVmZ5PpuhFmy1RkE4AfXGS0DZ9hyt7h+vGuB4w6Cxifztx
         6TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771985897; x=1772590697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqRloZUWm1YX8Y2GvFGiW+CWFq9B9c9r/iJQhisOJfI=;
        b=REgWfabIPevOlf2WNt0gk1j+FMKn+g+5ENkMql/HpUWyiKNsnGPcilTINzE+AUHC5K
         20cLtjqp4NNaJJDJI3OD3+2Boh8jBrpOL3KAn46k2e88vBK8IP94IZY29Uo3h6aOgiH/
         MpieNyJUZHe6RhI6ZAkJWSMVswXF76M11qoUIavwWtBBss7G016uQINY2jhee0W8O1Ry
         IDggL9hRlbtZ9QfuhUm58zfBHMXvqk0SQuRGNuvQCpgGraD/ZuUUOFb5iYYIly4kzJcr
         lP3X2/G0g+1GR55Jr36LARyiGiJdzmGwS8bbss+VrVt8C8OHzwMY66FslQB1SAnY6IE7
         FDEg==
X-Gm-Message-State: AOJu0YxhKIBsrlBcWPCmv6cDRQvCLt76sgDDElKnV5btYdn79fun3dIU
	LsAmujPIJDH1Ne1IoKpw2Xt89e2fsXDN5qethaT/wnCDU3GTXFqpxmiJXn/5dQ==
X-Gm-Gg: ATEYQzxW3zd4QZbK5WNqybZhBgtzlVQ1wRa59iZTrkDnY8xYGN9UEvmQTqTpCNMsvzw
	dg5OfNGqKU65fBJXzlu+MKPn51GDeo0rA/CLnDrV04d82fJUXR2KjH3575noHa4SoSeT7TqSVyu
	ORNGG6Jp4JH4nMyaM6xoP79nOWA3aDiOuRJp4bLJ2cYUf7ZyS9NnnxRJ67h7nlZ04izuzq2KVay
	ZFl0B0j5kN7p4ZuP8/5FEtYIkgsEX4MZ0fQJwSi3GuLospfLWRl/3A26e1P1sttSlj6gp6FBgNk
	1CQWleYbGMIub4HnFwYRl9APRr0nHPFuhZ67Z9W7zEmAlsGVdw4f685U2NxGU7p7bXuoYdZ50E9
	4Koa1XAirPZ7gNgNdv7JLnz7I7uHRTJ6lf1jADjdZmPk9FiCbJzKHTsCMW60yeFaqCOGMZ8SR7s
	GyABkkS0mz2MKPhHMr1GKu+hIxVmFgNN5h1rA=
X-Received: by 2002:a05:600c:4589:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-483a95deea7mr246546675e9.21.1771985896590;
        Tue, 24 Feb 2026 18:18:16 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfabb84esm1109515e9.0.2026.02.24.18.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:18:16 -0800 (PST)
Date: Wed, 25 Feb 2026 03:18:14 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 2/2] t4074: add test for diffstat width when prefix
 contains ANSI chars
Message-ID: <aZ5b5spGgHdMPmH-@lorenzo-VM>
References: <ce251505932712839dcaabffcd1762760439edff.1771895921.git.lorenzo.pegorari2002@gmail.com>
 <xmqqikbmk86b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikbmk86b.fsf@gitster.g>

On Mon, Feb 23, 2026 at 09:43:56PM -0800, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > Add test checking the calculation of the diffstat display width when
> > the line_prefix contains ANSI characters.
>
> Hmph, who stuffs the "line_prefix" and with what?

Yeah, I should make the commit description clearer. Will improve that.

> > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> > ---
> >  t/meson.build                               |  1 +
> >  t/t4074-diff-stat-width-with-line-prefix.sh | 42 +++++++++++++++++++++
> >  2 files changed, 43 insertions(+)
> >  create mode 100755 t/t4074-diff-stat-width-with-line-prefix.sh
>
> Do we need a brand new test script only to host just two tests?  Is
> it too cumbersome to modify existing test scripts that already test
> "git log --graph"?

Mmh I guess the test could be added to "t4052-stat-output.sh", which
"tests --stat output of various commands". Do you agree that this the
correct place? (btw, t4052 seems to me like a quite messy test...)

> > +setup () {
> > +   rm -rf * ".git" &&
> > +   git init &&
> > +   git config color.diff always
> > +}
>
> Why?
>
> > +test_expect_success 'check width with max name-width' '
> > +   setup &&
>
> Why?  Shouldn't something like
>
>       test_config color.diff always &&
>
> be sufficient?

This is sufficient, and the setup() func makes no sense now that I know
this. Thanks for pointing that out!

> > +   touch "${FILE_MAX}" &&
>
> Use of "touch" when you do not care about the timestamp of the
> resulting file is misleading.  If you only care about its existence,
> do something like
>
>       >"${FILE_MAX}" &&
>
> instead.

Ack.

> > +   git add . &&
> > +   git commit -m "init" &&
> > +   echo "text" >"${FILE_MAX}" &&
> > +   git add . &&
> > +   git commit -m "text" &&
>
> OK, so we have two commits, one adds an empty file, followed by
> another that adds one line of "text" to the file.

Yes, these are just placeholder commits. We need at least 2 commits to
create a graph with "log --graph". I will make them "--allow-empty" and
"--allow-empty-message" emphasize that they are placeholders.

> > +   git log --graph --stat >out &&
> > +   grep "${FILE} | 1" out
> > +'
>
> Use "test_grep" instead of "grep" to make it easier to debug when
> things break, perhaps?

Ack.


> It is unclear what we are exactly looking for.  What's the failure
> mode and how the miscounting of the width of the line-prefix
> contribute to that failure?
>
> We have two commits, "log" without "--reverse" would give the
> creation of an empty file i.e., "file | 0" first and then one line
> addition to the file i.e., "file | 1 +" next.  We only care about
> "${FILE} | 1" existing in the output and we do not bother checking
> what comes at the beginning of the line before "${FILE}" or what
> comes on the line fter "| 1", because we can detect the breakage we
> expect to see only by looking at the middle of the line?  How would
> that work?  The test deserves a bit more comment to help readers who
> wonder about these things.

I will add comments to explain the test better.
The goal is to have a file with name that is just the exact length so
that the line in the git-log output which includes the diffstat will
take all the available space in the terminal (if the diffstat width is
calculated correctly).
Then we test the diffstat width calculation with the terminal being the
correct size for the file name, and then 1 column short.
If the file name is fully displayed first, and is then shortened by only
1 character, it means that the diffstat width was correctly calculated.

>       Side note.  I think I know the answer to these questions,
>       but this project is not about me ;-) but other future
>       contributors also would need help when they encounter this
>       test and want to learn what it is testing.

Thank you so much for helping me out without just giving me the
solution. It must have taken longer :-)

> > +test_expect_success 'check width with longer name-width' '
> > +   setup &&
> > +   touch "${FILE_MAX}+" &&
> > +   git add . &&
> > +   git commit -m "init" &&
> > +   echo "text" >"${FILE_MAX}+" &&
> > +   git add . &&
> > +   git commit -m "text" &&
> > +   git log --graph --stat >out &&
> > +   grep "${FILE_LONGER} | 1" out
> > +'
> > +
> > +test_done
>
> Instead of doing the repository construction twice, you can see the
> same effect by running "git log --graph --stat" on the same history
> with different values exported on COLUMNS environment variable,
> which I think would be easier to see and simpler to debug.
>
> Something along the lines of ...
>
>     COLUMNS=80 git log --graph --stat >out &&
>     test_decode_color out >out.decoded &&
>     test_grep "^<RED>|<RESET> ${FILE_MAX} | 1 <GREEN>+<RESET>$" out.decoded &&
>
>     COLUMNS=79 git log --graph --stat >out &&
>     test_decode_color out >out.decoded &&
>     test_grep "^<RED>|<RESET> ${FILE_TRUNCATED} | 1 <GREEN>+<RESET>$" out.decoded
>
> ... perhaps?

Didn't know about this. Will use it for sure.

Again, thanks a lot for the through review Junio. Just let me know if
t4052 (described above) is the correct place for the test!

(Sorry for the double email Junio... why does mutt not automatically add
the mailing list to CC while replying... :'[ )

