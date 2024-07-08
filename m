Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A12812
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410689; cv=none; b=sTLXFJe8DnTBS4FTDXrthdArQJkMgkxw0dmD771KA4NeZaEZ5FxWFsncGGAblD850cMDDF7uEB1Gqk9+L5hbEB3pkP22/e/QXyi1hcMtt63QEEi9WjSEToKfwtki6ZFij5BmqLph6qsmYSjjyM9veFIi/XSfCmr4Pn7S5TsDL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410689; c=relaxed/simple;
	bh=H08E2eqg8iVGoZn0yXrKOyB7Socihith7CeIBhamkZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H41czhem69SqwJa6SvkqN0IMHF2LTVbv8lR/IEBl40SvbtzZ5kvd2gNLT6oyG0QCEkTA74OXbeQ+b7SU2ROx7hnkI3OABiCksCnFqXd2OOecf2sPhkDYhaGqqs0IdRcHTt2MmhG+vbQ175Ixnlmo2EvP5MELOJdGshWOWNge3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5da2730efso22251386d6.2
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 20:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720410686; x=1721015486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WO1MNwBmPYv26gdqFWCSkNIrTs/YSwA995w8Zc+dGo=;
        b=RtOqH4uM3r1V7ce9x8SZau6X6Tde58KEw9QObq93G3zyBTtZwWib9zb5XBGba3d7CB
         8aLC6hGmMS/Wh6R+yHBNg0YgPdkbADN4hrJ+ssXjtCHOx//mLWPonqAbPbQU+yBAMdAH
         v2DzkNPSKAzy324BiZqVZDkPpwaWIJHjnUaCWPBCLoYVJ1UEQ5uZtU7mXTNsPSk6QOIg
         5R7TVxFdcxTQnGXSCOxZgxBgNSX1LhFq1STbMMjXgOZOFr9wIpmaEc2N6fiIE60Yxw8P
         AR3YODMKjkC4j+iIVEmiBOO/OAJCG3pAOWmrMpLDqmr0gv19MpQTycTVglMPUhfsuJW+
         4WjA==
X-Forwarded-Encrypted: i=1; AJvYcCVTCRJPhyTbAGJZRY/ENqHDdPqxt+q6pn+t4ME8aVxIUt80XTTRBshzpjfIarASLXq0SGorFH8YpX/x+mqhCNyKdghb
X-Gm-Message-State: AOJu0Yz1+9AXLbUXsdSvLr3U4kfZ3ukwXVeXC1avCBZ+Fhf7gBG4z3WI
	mX2JQ23Mr5YBD3SQPjNaFda8ej9YDXcTLu5KrzkBJlQBZAxtn8KOA/+FzGVME1Aql9R59DwZmjI
	aL8wrSSWkl8OpW5UBAJFKm07E11c=
X-Google-Smtp-Source: AGHT+IEOXfeDcqrplyEz3mNQXwbJ/CYBz7Vjvp5Z/fzVQn5pLrujp8XNEyErN37zv+zqhaE/GquGou2cHl+0XZR865Q=
X-Received: by 2002:a05:6214:d6d:b0:6b2:da7e:5cb7 with SMTP id
 6a1803df08f44-6b5ecf8eef1mr147308566d6.5.1720410686653; Sun, 07 Jul 2024
 20:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net> <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g> <20240706231128.GA746087@coredump.intra.peff.net>
In-Reply-To: <20240706231128.GA746087@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Jul 2024 23:51:15 -0400
Message-ID: <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 7:11=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> My biggest question is around my patch 1 above:
>
>   - is it worth squashing in to Eric's patch? I didn't want to do that
>     without getting his OK on the approach.

Given the effort you put into the commit message and diagnosing my
bugs, my knee-jerk response is that it would be nice to keep your
patch separate so you retain authorship. But it also would be
irresponsible for us to let my buggy patch into the project history
as-is since you caught the problems at review time. So, squashing your
fixes in seems like the correct approach.

>   - instead of bumping the line number in the caller, should the lexer
>     record the line number of the here-doc to be used later?

It would be more robust to do so, but I suspect things will be fine
for a long time even without such an enhancement. But I also agree
with your commentary in patch [1/3] that it probably would be easy to
latch the line number at the point at which the heredoc body is
latched.

>   - the test harness in the Makefile strips the line numbers from the
>     chainlint output, so it's hard to verify those fixes. I saw them
>     only because the combination of the two bugs meant that the here-doc
>     had a "line 0" in it, which was enough to confuse the "sed"
>     invocation in the Makefile.
>
>     I did manually verify that it is OK after my fix, but do we want
>     that to be part of the chainlint tests? Just leaving the line
>     numbers in is a maintenance nightmare, since it depends on the order
>     of concatenating all of the tests together (so our "expect" files
>     would depend on all of the previous tests). But if we wanted to get
>     fancy, we could perhaps store relative offsets in the expect file. I
>     think it gets pretty complicated, though, since we print only
>     problematic lines.

Given the way the Makefile currently concatenates all the self-tests,
it would indeed be a nightmare to retain the line numbers. In the long
run, we probably ought someday to adopt =C3=86var's idea of checking the
self-test files individually[*] rather than en masse. With that
approach, it may make sense to revisit whether or not line numbers
should be present in the "expected" files.

[*] https://lore.kernel.org/git/CAPig+cSBjsosRqoAafYN94Cco8+7SdUt0ND_jHS+jV=
PoM4K0JA@mail.gmail.com/
