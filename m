Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031C311C22
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465005; cv=none; b=MsvcU2Pdgg7vNVPdXiI8LkJPGvjjZaWyb1Bpw797ZzNwI/shEb0wF9GMs2jz8dzu/azf8bpaj1A5AaZVlHyFnxj4Lv8v9VbKM4tWZdwWdZt3jW/94g5T9RNROUQokIiAMw3u2XkozkH6X0/qTAEy/f7CGQaWYyM/baO/GrlXCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465005; c=relaxed/simple;
	bh=ljid0EZKgIFnXab2toMbmiqsjcMlwYDlAu0tcWpMlNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpDBPfyQ41hmMfkJJpqbDGulZmz7JxHAIo+9/P+3tUHPotP3Wh0KD0U2dc+tKZ6DBnRfgS7zJxV8Qxh+D2X2D2qaHZGejfNeqFTXGmZiN4b+QWXPTS33U+NRjB/yTdSV8a7zTT0I7dDet25vM4HCTw6MJNrP6uPvZou8YIl4MNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1hErc8b; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1hErc8b"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336925ebb8aso14087691fa.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 03:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756465002; x=1757069802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfJTynh6p0p7VyOGV2BmQwoXr7Cx6YCUHtxdde07SIU=;
        b=C1hErc8baUlS8ngzpu+s1sL3EtJ6OpV7lXe6EbAR5hZzW4+nf6+AzFHoRfBxw84GNG
         1soL8u7FYUvBup7FNmVzlhMyo1HA9fRVnVcgLReFVl//Jd5nI79yZDu+LnXdl3FElk6u
         BvGRCJpaQxMsJdD5SvyfufJJnOM21o+xeNt5nlDR2YH371F6VYXaVYtceQLnEsO7c5nX
         Ok+eim3k0LjALdnz9Nir3uvhpCA3uhn2EAwv6zKSbuT8tyMeFz7+YdP5HXiydEbKG1cn
         zroXK9XFxsvNM3OSWUZ3rxLlRrDAwu8OrLiQgE11I1m3fEsIo8al6hqhDFXYDeRgaSAQ
         BhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756465002; x=1757069802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfJTynh6p0p7VyOGV2BmQwoXr7Cx6YCUHtxdde07SIU=;
        b=o21fRH17yWylTRF7DwMmOcahv/3vNh3XqFy3qDwOhKRw1lVmHvGqVvPIbMmzswQk31
         gV7dtWDqi2yo9WzsX3RHa2KLzUlqrnwOl1wl6kR6z6hItA3zHgRAaXmlHV4aa4wI9xQP
         5AXvRqKcX7M0VXnE6Fi95LDeo6r/dKLP5Ta54UAHNlxjryQT6IoT1gJDXwgMeUv/Pem/
         j/vnGxeXpHdrMoOYIxJ6KGqgxTjTuCIUhI0LZgboeE+NasBxSeKldQny1CGjmGM0YEnw
         FqcWbnfbcnT5dypH3c3pvut/eLx0f56Obm+gKisEoAp6iaBfOIY/YMDO9fJdpH6xJmAw
         EuGA==
X-Forwarded-Encrypted: i=1; AJvYcCXTeXeTgLobENBRdDXQ8mBAbXjMErzOxy5R4/jsqfj5BkG7d///ClFEJf4wMA8ZgqY0FaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSUpHXxQo+AvK/QZF5PdPXrm5vTWkWYvMzMErC91E7HvwFoK9z
	n3/+4DnSiOlG1F5cQ1/GtnL3kdwmPWrUh9yBSnR0XvjLd3e8gsC5KTl0TeR7m7rtO8wynoOSzk3
	KpI+yNUSvi+getjiU65AvfzVRxRdxKYg=
X-Gm-Gg: ASbGncsoJ+txTL3gClUqpEiPRnXCUz1zPMlYrvHi3Pck8xxu5pbC+d0ZcGhr4IwpE67
	RPFO4Tv9bPLKSYCysT47aIp1YCzZV+iHodaRPHXoyEZ8pOMegMJw+jP33po1TjditjC7UqEYeux
	lDyIOy384T+3lSyiQFgQ8WX2Ew/zEiAJ/5dDB8KB27rwYBO6S/qrbj/0N7+puNoDD1wzUMHNoie
	f9Zk80j31n9NZB7
X-Google-Smtp-Source: AGHT+IGb7xtIutfe/U8EaUb0HmYXMZpSWKwzsuRl5O/crPVWlH9QR/itL86YItSA9UZvpoM3b8WUKQrTNpcf31fGLpc=
X-Received: by 2002:a05:651c:154a:b0:336:a8e3:b80f with SMTP id
 38308e7fff4ca-336a8e3babbmr13873451fa.5.1756465001587; Fri, 29 Aug 2025
 03:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
 <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com> <ec5dcdf9d00473417b1f0b676a485f01076ce075.1756370289.git.gitgitgadget@gmail.com>
 <xmqqa53jxyiz.fsf@gitster.g> <CABPp-BGRHajFf5z91CvvKvahpknbt1KraCR3_rOmAjvxz36_Ag@mail.gmail.com>
In-Reply-To: <CABPp-BGRHajFf5z91CvvKvahpknbt1KraCR3_rOmAjvxz36_Ag@mail.gmail.com>
From: Paulo L F Casaretto <pcasaretto@gmail.com>
Date: Fri, 29 Aug 2025 12:56:29 +0200
X-Gm-Features: Ac12FXzpN0orrmXQDBvV3qlP6AVF-88cwhB5QaqnY5KLyh1Ent3WoIutzrNveWM
Message-ID: <CABEf2MkN0BNVuiA4Q0SrP=vFb18tSEKcD09qDzs40CowHjO3rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] range-diff: reorder options lexicographically
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, pcasaretto via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	pcasaretto <paulo.casaretto@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I concur. I noticed these were "out of order" when I added the
new flag but now it's obvious that there was order. I'll remove this
commit.
Regarding the name problem, I've checked and I do have "Paulo
Casaretto" set as my name in my Github public profile.
I fixed my local git config and apparently that fixed it.


On Thu, Aug 28, 2025 at 7:12=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Thu, Aug 28, 2025 at 8:24=E2=80=AFAM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > "pcasaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: pcasaretto <paulo.casaretto@shopify.com>
> > > Signed-off-by: Paulo Casaretto <paulo.casaretto@shopify.com>
>
> Same issue with name here.
>
> > I am not sure if "lexicographic order" fits well in the context of
> > "git cmd -h" that spews out many many options, shown with related
> > options together in groups.  I find it aggressively annoying to show
> > left/right-only far apart.  A user unfamiliar with the command would
> > look at the list, find "left-only" sitting in the list alone, and
> > waste time and break concentration wondering what in the first range
> > is so special to deserve such an option, until they see "right-only"
> > further down to realize that they are symmetric.
> >
> > I'd rather not to see this "lexicographic" change done, but others
> > may have better justification (note: "for better organization and
> > readability" I just disagreed is a good justification) that may make
> > me change my mind.
> >
> > What I would change, if there is something suboptimal in the current
> > output from "git range-diff -h" that deserves improvement, is the
> > lack of the grouping header before the options for range-diff
> > operation (i.e. creation-factor to left/right-only, before the next
> > "diff output" group begins).
> >
> > Thanks.
>
> I do like lexicographic ordering for unrelated options, but I prefer
> options to be grouped by intent/use first, then by lexicographic
> ordering.  And here, not only are--left-only & --right-only related as
> Junio points out, to me --diff-merges and --remerge-diff are a similar
> grouping that belong together.  So, my $0.02 is that I'd lean towards
> calling both changes in the patch a reduction in organization rather
> than an improvement.



--=20
Paulo L F Casaretto
