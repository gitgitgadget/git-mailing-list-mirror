Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4513B791
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082240; cv=none; b=uaeV1zNm9WCqIBKlu/GnjhSeCjmi27Hc3cc99v6LzHwVHB5c9cLPwXjBqIGkCAWVBBw0lwCfqAeJdOagPLpy+9LLCEFtgWvwuk+zbTb5j4c98ljjCkPyWZd0tKmLCOYqIOhSlwyl9/aiFW/58z8K0P0JRU5O/TgqIg3nS6vEMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082240; c=relaxed/simple;
	bh=fXvHejQ64RCM3VVODNlhW3RPGmgxha1TliujOCPoxxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UClZUMXua26Y4bD5sqcyaO0a3bBun2FxFELNo0YZ3HxXGKqsavL6lDqmGK+k9ztez0vRuN/2mzprdM1SU96Zect6H2P/rvYe0C9JC/GPHrKGiFjgXy8cdlfxBcYw0bnF70wxvQLFrRkFfHHfnwpQTs3dyxh1y0GrLe2jBa/4bS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uV/E7mf3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uV/E7mf3"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447df43324fso61731cf.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721082238; x=1721687038; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NSd9WOI7fBiA36sTYKUGIO+lA0qHTzal6SXhIZQBXE=;
        b=uV/E7mf39dc7DnasgaynerSEZH/vH3pmLq4qB7Arl8xgktIqDb61M0RHhsB2fnHGf+
         Ph145NBNK4JuWNA8GeU6RtkrvsAZItW/AcXcKU5pjYl7Mf+bgo2LfuOD0TCrS5ajYNC1
         AipuyhK0Odm+h+DinzJlrAXynnsLMg1FcT+AwpxYRneryFULoWIFl5vs3u6+iyeeCBim
         GnHrDKUYiQzvoeN9waz9BrZYZmTm1qi7LbOkFfqRG8OFLrQoUv8rsvhuUjMASO6EkLWr
         vsb4rF6aEnrxrR1JGwaxgEdyPoxg+PEwJMrqGDFcAtJAxC2eFbdJJdKUpMf/scUNd7iH
         yWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082238; x=1721687038;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NSd9WOI7fBiA36sTYKUGIO+lA0qHTzal6SXhIZQBXE=;
        b=Yy769dKzMXH6FIBAMroyMJ0GKOQnUXyRdjccb8S0+y5ytYIhyV+uemWMz3USuQALmg
         yCNQww05L9g+9ZS/Iz3bCTKtmKKRTzll5qhaBWRPD6SsyrwIC+ebnw3DCGV6qxFLAHf2
         8IpRnjFNh4Zh6m13g5IiBOCU+ypIAbsE2RCGXmLysrt/BHl5Yr0+RNKEq/Y1JqJGZHFK
         pM0P4pd1lCPa1J4al9ilctnaDC7IHGsQ2zI0UuZwGK+WpOmo5OnZ9K0q2SqQO5NlI0rP
         W5enTGY81Tl0pXFOeVj8K54qxjv4er0058kXzR085yUtV+4phlTkaCIzV9gZNbyaoA+5
         yc2g==
X-Forwarded-Encrypted: i=1; AJvYcCU5FG68vTgAl+/iP7QhjE/1NlzmseSY6X88QLdDziTjTvHzI2Wgx7hGcSIvP4voDuf1yadtNRdbQ2yzTAjkQbEuNimV
X-Gm-Message-State: AOJu0YzQ2wqbCJJbdfsy6awUJNY3iIgZEPhng4tifRn0PML8OYePVNHZ
	47JfoCamtpUHrjGqyYNZDHl4RpCS1CxkKZtS8GfyHMiPm9lo29kkHeMMvvRI4SK1wrbL7qAbOJI
	f7k4p7yfk3oQBExGa2yokqS+eaNx1mf9Jyj/S
X-Google-Smtp-Source: AGHT+IHpAk+e4ytPhhox55LXAocD1psy4Rg+VWO/C6hyQc3zpYI0uRDsyhO9ASXT1N/gSUp6O/G3rw/9mHOuEdI8BhA=
X-Received: by 2002:a05:622a:4203:b0:447:dbac:facd with SMTP id
 d75a77b69052e-44f7a74192bmr1019131cf.24.1721082237929; Mon, 15 Jul 2024
 15:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net> <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
 <ZpBbgXYQlpHZa3xR@tapette.crustytoothpaste.net> <CAJoAoZn+R3qhoVA=av8NMcCAJyRHOe6QTXV=pyjs80JmV0mVzw@mail.gmail.com>
 <ZpGFHWZTWAQUXGCe@tapette.crustytoothpaste.net>
In-Reply-To: <ZpGFHWZTWAQUXGCe@tapette.crustytoothpaste.net>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 15 Jul 2024 15:23:46 -0700
Message-ID: <CAJoAoZmgXRT3162bWkCpu4R4JME9XydPnvuZn6L8fs5G68Bbtw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Emily Shaffer <nasamuffin@google.com>, 
	Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:33=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-07-11 at 23:15:35, Emily Shaffer wrote:
> > On Thu, Jul 11, 2024 at 3:24=E2=80=AFPM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > Some older OSes require kernel features that aren't compiled in by
> > > default, so containers are out.  For example, CentOS 6 won't run on a
> > > modern kernel because it lacks whatever the predecessor to the vDSO w=
as
> > > (which can be recompiled into the kernel, but nobody does that).
> >
> > Is this hinting that we should mention a minimum kernel version for
> > Linux-kernel-based OSes?
>
> This is actually a feature that still exists in the kernel and could be
> enabled for newer kernels, but because distros don't use it (they use
> the vDSO instead), they don't compile it in.
>
> I'm not sure a minimum kernel version is helpful, because most of the
> LTS distro kernels backport features, like Red Hat backported getrandom
> for example.  In the interests of getting to a useful agreement, I think
> for now we should just punt on this and having a 10 year lifespan will
> probably do the trick, and we can determine in the future if we need to
> apply more stringent measures.

Sounds good, thanks!

>
> > > We also don't really want to be on the hook for trying to support OSe=
s
> > > Ubuntu is still derived from Debian.  It is likely that things which
> > > work in one will work in another, but not guaranteed.
> > >
> > > I mention Debian is because it has a large variety of supported
> > > architectures.  I absolutely don't want to say, "Oh, you have MIPS
> > > hardware, too bad if Git doesn't work for you."  (I assure you the
> > > distro maintainers will be displeased if we break Git on less common
> > > architectures, as will I.)  In fact, MIPS is an architecture that
> > > requires natural alignment and can be big-endian, so it's very useful=
 in
> > > helping us find places we wrote invalid or unportable C.
> > >
> > > The reason I'm very hesitant to require that we run everything in Git=
Hub
> > > Actions because it only supports two architectures.  ARM64 and RISC-V
> > > are really popular, and I can tell you that running even a Linux
> > > container in emulation is really quite slow.  I do it for my projects=
,
> > > but Git LFS only builds one set of non-x86 packages (the latest Debia=
n)
> > > because emulation is far too slow to build the normal suite of five o=
r
> > > six packages.
> >
> > Does that restriction apply to just GitHub-hosted runners, though?
> > Would it be possible for an interested party to set up self-hosted
> > runners (configured via GH Actions) that are using AMD or POWER or
> > whatever? (For example, I think it would be quite feasible for Google
> > to donate some compute for this, though no promises).
>
> Self-hosted runners on public code are very hard to secure.  You're
> basically letting arbitrary people on the Internet run code on those
> machines and make outgoing network connections (due to the fact that you
> can push whatever into a PR branch), with all of the potential for abuse
> that that involves (and as my colleagues can tell you, there's a whole
> lot of it).  GitHub has taken extensive pains to secure GitHub Actions
> runners in the cloud, and while we use self-hosted runners for some
> internal projects, they are absolutely not allowed for any public
> project for that reason.
>
> I would be delighted if Google were willing to do that, but I think
> you're going to need help from teams like Google Cloud who are going to
> be used to dealing with abuse at scale, like cryptocurrency miners and
> such.  Unfortunately, there are many people who act in a less than
> lovely way and will exploit whatever they can to make a buck.
>
> I will also note that the official Actions runner is in C# and only runs
> on a handful of platforms due to the lack of portability of C#.  (It
> might theoretically run on Mono, which would increase its portability,
> but I must profess my complete ignorance on anything about that code.) I
> also know of an unofficial one in Go[0], which I'm for obvious reasons
> unable to endorse, encourage, or speak about authoritatively in any way,
> but that would still exclude some platforms and architectures which
> don't support Go.

Do you think it's worth us linking out to some helpful doc (like the
official one, and someone who doesn't work at GH adding a link to some
unofficial Golang thing)? I sort of feel like since "you can also DIY
a scraper that looks at the mailing list if you want" is included, the
gist makes it across, so I'm tempted not to go into a bunch of
prescriptive detail here.

>
> > The appeal is not "because GitHub Actions are great!" for me - the
> > appeal is "because most Git developers run the CI this way if they
> > remember to or use GGG, and Junio runs it on `seen` all the time". If
> > there's some other recommendation for self-service CI runs that don't
> > need some careful reminding or secret knowledge to run, I'm happy with
> > that too. (For example, if someone wants to set up some bot that looks
> > for new [PATCH]-shaped emails, applies, builds, runs tests, and mails
> > test results to the author after run, that would fit into the spirit
> > of this point, although that sounds like a lot of setup to me.)
>
> Yeah, I understand what you're going for.  If there were some super easy
> way to get everything running in an automatic CI, I'm all for it.  I
> think CI is the easiest way to make sure we don't break anything.
>
> I think it's worth trying to get CI set up for whatever we can, and if
> CI is a possibility somewhere, it becomes a lot easier to say yes.
>
> > Should have a reroll in the next 30min, it was ready to go and then I
> > got this mail :)
>
> Sounds good.  I don't think anything in this email should affect that
> reroll.
>
> [0] https://github.com/ChristopherHX/github-act-runner
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
