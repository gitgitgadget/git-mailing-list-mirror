Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA23019D6
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467607; cv=pass; b=E+dKZTV7DheD2+iMp8qXEaJbPOhMLnqcxTX2Zkudi44eOdyjN81vSx8BS/9RtuDPP7k3/pXI0afyFInkV2//NX0ttkhat497DM337D0mRtOQDrwCjTHELzTP7mQLxkgfFo5NFV2jIr/EiDsrCLou0ImHMtAkEJnVrF80/pCHNIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467607; c=relaxed/simple;
	bh=fokNH2mvKDx0uuqV5zlhjhQmR6piPRLVjpklXpmwuQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl+2rnLmE3dNjxAvrNJh4lQbhi49pkcQuj7LtfkZ1mTKjjGIPZsUCSWX+mLBTMUpmB1x2JiYuFTaQ5BTBBMxm+geD6SIuh4USkF5BglJPIptJ165FP3kbFSc4FnYBNGcf0YKxTO8/jLyubZFR85z/B3py5V+xVACGLInST/H7L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej5z14GX; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej5z14GX"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b16824c0fcso702852a12.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 06:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791467604; cv=none;
        d=google.com; s=arc-20260327;
        b=PIgbrbZtijTLsT+gl5KooXIRp1jN21hCeqWlixxkjikULAmrzYy8EJOfGdgv4624SF
         uBZs1BnPkxl+tI3EPq7G0XdPLyWiidJjjuvlK++MT0IUXEATSk9f+2zrR2rmcCIAcCDc
         /UHVHBcVlL3hT6C+MK1rIF4P29W4170oTt1Odmyf+GSBOu04Ab9TSKROeIJJhZkvhBIi
         o06lD3z1+M8tdRMqDqjuyp9UVFt61iCBYIEPnI4znwaczuzZBll8gJRL8BlHOI9ThaU+
         CknsnVbf3kNR1gHyjOXIRUehg9rqzzDRlmaFpRs2zmH7OBJxGscyyTw310xV05Pq+nu8
         ChVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d2cHz/mTjiqTZdKy7oFQihnsVKggSZF5bJQIJqbMa7c=;
        fh=Bwembv9g3I6lImp0Mqr2Rn4B5Tuvflk6W/VLzAwPGtI=;
        b=Qb3UUTs2a/yyW03gd+y71a5xzGKaSydu/DCn/pCRtzbpk/Cx+N75qGe18Tm4qJhCNM
         bDSaoEnq9cF1COBnaQshBHWTbGTEQJm0CLBVEXQf1rr9UAJ59vrPtisHGXiqPLIo8vHt
         ZF3kWA422zQGr+Kzoaya4eTPxPF0FRDdwY8/6uH8lmrtF+HndvcLyU44OOGooow1o2c1
         dVtguAbr5ZZxtp4HaAw3k7Z/64HmW+WotOzrLnlqq+2OANWk5bndGNy+uM4VxXmXfME/
         8Ec3sbw/igfjgdyrda/JyLE5rKdVp9CEFJbc6VpL8WsmvdvbLK2APG9PJarWU0v8IGCX
         onHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791467604; x=1792072404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d2cHz/mTjiqTZdKy7oFQihnsVKggSZF5bJQIJqbMa7c=;
        b=ej5z14GXjlkxrfqLJF5mZYBh4uY6b0aH0gs2FwjxM8tTBTNiaK5GskySDpAW/gQtbp
         wHPYmhNyY/W0pl6Ic2lYfTdfVViNMuLQyXDKGML+rfPXj5bnIRehus2pPtwioVrmPTs4
         MJRyyAQcSX7w8rHBsFlNPih0AidEVX+ecCQ2595UlZrdq1esvRfeQ04DQSQU6lt7jfIq
         aalKmywWWSGtcihP8EVDF0xYzZZxEq+WNouNVnVVOqAebGycE8xMZH9HpTnXk6A4uTem
         O6fI9h8guAkKVA6xFEEdcYAQ0GRRbj8nywPT6mW0hNVPc81KMvg4W3T/CZ2l59ET6vzb
         H/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467604; x=1792072404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d2cHz/mTjiqTZdKy7oFQihnsVKggSZF5bJQIJqbMa7c=;
        b=q+lpeBJrAngolkjAIuhcqsrkhtSS5N5WEtcItgCfg+qZoyO1UTCvzxfCW2GixqQlzK
         lFLdpsoGOfoXz2WU2z33ybHr5cVFGmYLfUr565aWAJLceZFhE8W55nyRu7p5usiNwmOZ
         tWd0F0nHoxIcJjbCyoRreAyO9lN7nuRFq2uIyhkGXD29It3qrv62qBsZxC3dwKKltzcM
         QRhZ7CjJeXsakZvrE8vVo5UByBqOjGmB8WbAAaYdB02vbrNTgurIiN/V7Ih6u2qa/5K2
         T4nZ6gnfYcH7dMZOHMCRLPszwM9yHrwL2mYoVP3tFyDe91n1lLZDmmPOnkUe63DmCB8c
         QI5w==
X-Forwarded-Encrypted: i=1; AKwUvBwTES2eOO71Xp//xJUF61qZ7fIzANktjsORKfVO/zVsIfOdXh8klgATE8ISjVpM7xP+bmM=@vger.kernel.org
X-Gm-Message-State: AFuF++nDO4IXc78MbTTLl4EdqNYuoa6JPSmH8tDQCJ1LyN9K5uIPSHjD
	idw98a0mXCtPtTzq2iu1pGX1f7DoAC66FEloZyin088033Qs/swlYQoTPYKZTNM4tM4nNLpgiPT
	Gv0va/vm8apbDlJyT+6DeY21ZZS2M5I4nn4IZtGxZOZDc
X-Gm-Gg: AYBFou1Y3bQKGv9CRGwXwD5G1D3gU47FdlB9k4V8VG13+0kjwmzuTq8QZRaToDCeNpI
	rIIrt2YKQp5x95Xea0eBByd7nyP8v1cDJa8MZo5WUxfTlG7s3EGKXwAI3JiHz/rh11N0XACcfRU
	NvH7O+CCM3qXYc9Q20Am2KYqUxH/aVDSPlw5Y1JatEb37PWcs+e3v2+TCkK+SFC/KcVm7qSOE7z
	JBCO+shRVkVb5svnhVtZxO/IbdQ3VgkFISpg1+xMz8Z+MFoNt6dQj6S4olbgronKIYdK4iUw4VD
	COMlNqHHKBXVeDtIju1emtUdibV2EtNLQM/uaPmSHh2/CPAhTuNXyM+gwjcMfFkgwQr97uSdPtn
	OGk7w6JGBrw+piHDwkLzMhg==
X-Received: by 2002:a17:906:dc8d:b0:c2e:378c:8cee with SMTP id
 a640c23a62f3a-c317bf5bc3dmr590366366b.34.1791467603730; Thu, 08 Oct 2026
 06:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007142954.31761-1-scott@gitbutler.net> <20261007142954.31761-2-scott@gitbutler.net>
 <xmqqcxtl3zda.fsf@gitster.g>
In-Reply-To: <xmqqcxtl3zda.fsf@gitster.g>
From: Scott Chacon <schacon@gmail.com>
Date: Thu, 8 Oct 2026 15:53:11 +0200
X-Gm-Features: AclHuK9gRRvO5VdhelDA88K6YD1imjgyjj-DN75oI1wideJAX1dauNUwhq3kO78
Message-ID: <CAP2yMa+o7zv=8bzHUa8FRkTaU46BQ3w_ZAr6zQ=rFC_a4cg2yA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI assistance
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 12:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Scott Chacon <scott@gitbutler.net> writes:
> > As an example, an OpenAI model was used to help me research, compare an=
d
> > craft the appropriate legal language for this policy change to help us
> > match the modern, legally reviewed approaches now taken by peer GPL
> > projects such as the Linux kernel [1].
> >
> > [1] https://docs.kernel.org/process/coding-assistants.html
>
> That makes it sound as if this is just as legally sound as what the
> kernel project uses.  However, the only assurance we get (unless you
> are willing to act as our lawyer, and I do not know if you are one)
> is that an OpenAI model produced plausible-sounding utterances.

Well, honestly, most lawyers I know only barely produce plausible
sounding utterances.

I read the change and edited it where I thought clarification was
needed. But this is different from, say, a blog post or emails, which
I personally never write via LLM because I don't like the voice.
SubmittingPatches is supposed to be dry and factual. Legal guidance is
supposed to be neutral. I've found LLMs quite good at producing
correct legal documents. Again, unjokingly this time, better than most
human lawyers (and I deal with a lot of them).

It's not unlike a code-based LLM contribution. I had it generated with
specific guidance and context of what I wanted the change to be,
because it's faster, and I spent my time reviewing and editing the
result to get the text I was looking for.

I would love to have you pass this by the SFC, because most of the
guidance I gave my agent was _their_ guidelines.

> It looks, at least to me, that there is not much that can be
> meaningfully enforced by reviewers and followed by contributors in
> the above text.  It seems to be little more than "the world would be
> a wonderful place if everybody behaved this way."
>
> A violation of "concise and relevant" seems to be the recent trend
> of much AI-generated slop, so it may be a good suggestion to give
> today.  But would we need to update it once the trend of text
> generated by AI tools becomes "concise and relevant" nonsense that
> merely sounds plausible?  What if an "AI-assisted" contributor lacks
> common sense to tell between plausible-sounding nonsense and a
> well-written description?  What if reviewers get too many such
> "contributions" and cannot allocate enough review bandwidth to sift
> good contributions from plausible-sounding nonsense?

This is a fair point, but you'll get unreviewed crap either way. I'm
sure you already are. However, I don't think people who submit
complete bullshit are reading the SubmittingPatches file in the first
place, so I'm not sure that opening this wording up a little is going
to make much of a difference here.

My recent patch series converting the sha1dc is a possible example. I
don't understand all of the code it wrote. I read through it, but
there are some crazy tables and complex math in there. The first pass
did a weird Rust to C machine translation rather than reimplement it
in more idiomatic C, so I had it rewrite that - so there was some
approach guidance, but again, I wasn't hand crafting the code. I did,
however, spend a lot of time and resources testing and benchmarking it
on multiple architectures so that I was reasonably confident that it
was fast and correct.

But I hesitated to submit it at all because I knew the policy. I only
sent it so that if someone at GitHub or OpenAI or whatever wanted to
use it in an internal fork so they could save a ton of CPU, this would
be a way to get the implementation. I was aware that, although I
believe the patch is quite reasonable and valuable, due to the
conservative AI policies of this project, it would not seriously be
considered no matter what.

My point with this change is to open the possibility for AI assisted
change that is reasonable, similar to the Linux kernel's approach.

> > +The <<dco,Developer's Certificate of Origin>> applies unchanged. Only =
a
> > +human can make that certification; an AI tool cannot sign off on your
> > +behalf. Consider the origin and licensing of generated material,
> > +including any third-party material it reproduces, and comply with
> > +applicable license and attribution requirements. A tool's assurance
> > +that its output is original or compatible with our license is not a
> > +substitute for checking those requirements. If you cannot certify the
> > +DCO for a contribution, do not submit it.
>
> Again, this is a good aspiration to have, but I doubt that anyone
> can practically certify that the output of an LLM is devoid of
> content borrowed from problematic sources under the rule the text
> above gives.  Would it not be more useful to help contributors by
> defining what not to do more clearly?  Our current text says as much
> more directly: you cannot practically certify, so do not send in
> AI-generated slop, period.

There is a good section on this DCO issue in the Red Hat article on
navigating legal issues around AI [1] where they state that "the DCO
has never been interpreted to require that every line of a
contribution must be the personal creative expression of the
contributor or another human developer". I think that this suggested
paragraph in my patch is a fairly clear interpretation of this stance,
but I can give it another pass if there are more specifics you would
like covered.

[1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-=
navigating-legal-issues

> > +Disclose substantial AI assistance in each affected commit with an
> > +`Assisted-by:` trailer naming the tool and, when available, its model
> > +or version. For example:
> > +
> > +....
> > +     Assisted-by: ExampleTool version 1.2
> > +....
>
> I thought the kernel guidelines instructed us to say only "LLM"
> these days, to avoid giving free advertising.  On the other hand,
> they ask contributors to also list non-LLM tools, like coccinelle
> and clang-tidy, that were used in their machine-assisted
> contributions.  I am undecided on the merit of specifying the
> exact model and version, but listing non-LLM tools alongside
> materials for independent reproduction looks like a good idea.

The kernel guidelines do say "LLM" only, but the SFC guidelines (part 5) sa=
ys:

"Part of the contribution process should (at least) include a
disclosure of what LLM-gen-AI system was used, its version (as these
system change over time), and a brief description of how the system
assisted the contributor. This information should be included in a
machine-readable format in commit logs."

I'm happy to go back to the kernel guidelines, but since Git is an SFC
project, I figured this is what they would be more comfortable with.

> > +Maintainers may request more explanation, testing, or information abou=
t
> > +provenance, and may decline contributions they cannot confidently
> > +assess.
>
> The text of the kernel guidelines appears to give maintainers more
> latitude (cf. https://docs.kernel.org/process/generated-content.html).
> They can treat it just like any other contribution, reject it
> outright, or choose any approach in between.  The proposed text above
> does not account for cases where reviewers simply lack the bandwidth
> to even think about what explanation and proof to request, and it
> makes it sound as if declining a submission in such a case an unfair
> rejection.

I mean, no matter what this says, you can pretty much do whatever you
want. I'm happy to change it to any amount of latitude the maintainer
has that you want to convey. Or remove it entirely.

Scott
