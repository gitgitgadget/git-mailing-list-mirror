Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFD34F247
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016293; cv=pass; b=PtpP3y8UvbcnoOrQEdfhzC9D2b0xYk8t/dAjt2+myrKS9ELXGKmTVxCLaPvTJH4Ty+taQ7vhSqQWDlBmO/pmS1DHdRplivGgxdOVmqgEszz1y6t2uCEDOgr4Mq/hLyokgTds7EBk2MObVUJ9jhXqjLFlFe+hzqi6qU8fbhaH8tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016293; c=relaxed/simple;
	bh=3XsrhgadncTKMTCN/1cvIbfu3N5WpfSffKRIVfPdres=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWJtwX6T6lPcOwOlQCYtMJMSHzBvsclH+431jx6hgpniXrzqJMck5/oet8x1X9mq85LQRjKTQReCjQQOGIbDfWWMXczgeJTvcMydyPGiCmG/f2+a4nioZpXnhtvh7QyOHRaAKHIRcqJa2wWwRsdD+uh8doCgag1P1Ml79PIPvmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyAGbK9Y; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyAGbK9Y"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68dbd44fso5785340e87.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 07:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781016290; cv=none;
        d=google.com; s=arc-20240605;
        b=OQB8rGXoUftbApdBjkoO0xbmUPZPm7oEM0oF7eht13XYoHIFtportR75OBJskvlFuO
         Pt8cPDdKMMRRXUJxPqHL6hJ+kjuOb4ve2mBZ9noflUO1o7Z5+Z/fYec6KTCTsL0kkq8g
         1MxidZlhI9Rr9G7VMk/G0J4ltjJyk6Dq9TgcYxThcC6PuIWI/RdfYDMpwu9dn2hObuff
         K4k7fKEdf/4eqqqpmHr1G/4Uq0tyFZBx9L/dr/jtEYhFD+30w7GTmtlXuAn/3BCa/H6G
         /FCHxZMRC4XocwPXcjyiF+i7yp5fnMus57TAvlhmgA+NRWPIYj8Kf26jG/KFKcRg8JmA
         yZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IT4EEy/yZpXnJsnw0H05vQVlkzbr4lQmyCBBwF8Vlms=;
        fh=sy+DerBYfta3W3SETWwiVkc7siwvmgNWaIJCXrSBo+Q=;
        b=dxQ0j1gi0NqWngcaxiIa+6h4BA51OMO+i4/cpIFPlGa1MZAXxcQVoRjMcVoDIUk/zn
         60igK4RD6hHYPD70Vk4ZYeS37sB54IzfW53pDiYM9A/1M/WwsZVCx/vKJjxlLU5JIJTk
         LSVNizxfKgW7ZURU2NrSBcnYccy88klFN8zCOk/oKEF378LxwGYD1IQnHORYgISuCQAA
         2NWo6hez/JJ7MrHC5LYyPViRc9QqKlPLyjyCRlfirp2Jqk09/mdEZ02sE9GKaLbxAZ28
         yg+ghwr8G9mcAgp1A0BPvTkY+vP70guhYnlTPEvkHqwYb9+I1iez3oegA9kpKudQQNES
         SGHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016290; x=1781621090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT4EEy/yZpXnJsnw0H05vQVlkzbr4lQmyCBBwF8Vlms=;
        b=iyAGbK9YYV3dgrVcg60U9I1/pmV09tloNR9Nw2ouAe5UzWKDpqsy+ck0c43UodCfYh
         gjO9uTk9KVLek1M8s1Ltnyq27dKssgXO14rEXMfJBdOlHdB9nllb0AKssGjnwncj734a
         jzCnsCFx6t0XLtnzJpoPhspbxgWS5vSNu8+ouNLsnGe50OSRWb6ugKwkTNA3jIxEJFxj
         LHALhXiK9opF8Hx4bozzkWRwTqhSNa1nWEIux4RnnROCVtB6UKcir77joWS+U1y7Hdt/
         slEFUeDe4Oepu8eaVx1TEnme25Phsug84MQel0HIgduM30l6bHdx7wIPk52/46ES4r0G
         XN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016290; x=1781621090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IT4EEy/yZpXnJsnw0H05vQVlkzbr4lQmyCBBwF8Vlms=;
        b=cShc+PGcP/EOdF8ZEzsK9SDTr2y1SSLtvQImFhflkwo6P3jYzu8BvEk/3d79hZPw8s
         YIjPcS6vqlUyYaI+yMJw9u4l1lDU0RSHBNgzaRA0WW2Uyb7X0NgMlb1NyFPqVJnB2jXU
         rtqmgSEJ/BZIUsc8oqd8a2SIDTa5AmlsB8OYuLXwy0gBU1kretb9sXkXiRJ/Rdg3gAeZ
         xKY0yIyCQC6DFZJL7WWR5d19nB6eQZj8xr8j1KzTLYLgud54A0rjjvmWjuFYS1DKKN2n
         W8stskyTJZ/uqOT6IddNlxUKJ7gKHfkPUmTKwqHTH0tZnIw/l5yJZJ5GorrM6z/Ys7d/
         sVfg==
X-Gm-Message-State: AOJu0YxKFBA+iAHP6C6AmcuwbWAX3HuO9Xd+OWU53pRn8BuXvL6txmK1
	7W70T3uy98p1YiiXIgpcda+IDnBjB24yfyg2dH64wXL2xzjuDI7K2+uyTlF9+RtjpIigqcTlEpY
	9MG3HJSCS7jPrSDIeGUi7c+zr7zXpayU=
X-Gm-Gg: Acq92OEXFeqMYtRUmGa/N8sCEfb4NjuZALv2FrRXH6sbjmOt+sm7+/40adBIwE8VbKa
	16rI8uONydXEmrHuf71F2umz1BVL968nGQ9QECrtoQYkblH1s17kZhDnq7wVdqq4TOlV0pRrWpW
	6+zI3y4N6fPWN7hlj/kwYL79oDSfwoe0I2mAiM9v/UVDomrsSwm88oh3DAPScG6j5Ne+KKmr1l+
	Kn0x/1JFXcQk+OTlG4H+lDF6Q09xpeM0bNWHvjk9GhtRwJ8Iw73oh14hNHW7gglg3ku7qDfDpKt
	405EQCHjMXy/f/NH5CKU6SuBI1mKkF1tsGzDCpBPWIF6mDFMvoX7o0BScmZnvSAlFOQb+gx2UgU
	igbptWEAQVCfTVA8v71is3ZXk2swRZl7OGUXo5g==
X-Received: by 2002:a05:6512:124c:b0:5a8:f03b:a406 with SMTP id
 2adb3069b0e04-5aa87b5b614mr6040211e87.16.1781016289442; Tue, 09 Jun 2026
 07:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com> <20260609110957.GB1509396@coredump.intra.peff.net>
In-Reply-To: <20260609110957.GB1509396@coredump.intra.peff.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 9 Jun 2026 10:44:12 -0400
X-Gm-Features: AVVi8Ce6DL2Exfci7-03jYa3Spw7IE9bnEP3UG3TDV8muVlOVTomGrxirUiPz6g
Message-ID: <CAJ-ks9kz5JGFSF21aOhuXfgsJ+5aa5xE69RPT2Vhn-CRGyHZ6A@mail.gmail.com>
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 4:09=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 08, 2026 at 07:32:14PM -0700, Tamir Duberstein wrote:
>
> > The benchmark checkout had 120,532 refs, of which 330 were tags. With
> > `$repo` naming the checkout, `$commit` an exactly tagged commit, and
> > `$parent` and `$this` the two binaries, I ran:
> >
> >     hyperfine --warmup 3 --runs 15 \
> >         --command-name parent \
> >         '$parent -C $repo describe --exact-match $commit' \
> >         --command-name 'this commit' \
> >         '$this -C $repo describe --exact-match $commit'
> >
> > The results were:
> >
> >     Benchmark 1: parent
> >       Time (mean =C2=B1 =CF=83):     171.7 ms =C2=B1  18.5 ms    [User:=
 23.9 ms, System: 133.6 ms]
> >       Range (min =E2=80=A6 max):   142.3 ms =E2=80=A6 198.3 ms    15 ru=
ns
> >
> >     Benchmark 2: this commit
> >       Time (mean =C2=B1 =CF=83):       9.9 ms =C2=B1   1.1 ms    [User:=
 3.3 ms, System: 4.7 ms]
> >       Range (min =E2=80=A6 max):     8.8 ms =E2=80=A6  13.1 ms    15 ru=
ns
> >
> >     Summary
> >       this commit ran
> >        17.35 =C2=B1 2.63 times faster than parent
> >
> > Both revisions were built with -O3, -mcpu=3Dnative, and ThinLTO using
> > Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
> > (Mac16,6) with a 16-core Apple M4 Max (12 performance and four
> > efficiency cores) and 128 GB RAM.
>
> This patch looks fine to me, but let me pick a nit for a minute, because
> I think there is a broader conversation to be had.

Just to say from the start: I appreciate you taking the time to discuss thi=
s.

>
> Given the discussion in earlier rounds and sibling topics, I assume the
> commit message here was AI-generated. And it's OK in the sense that it
> is describing what happened and I assume is entirely accurate. But as a
> human reader, it feels so much more verbose than what I'd expect, as it
> is full of semi-irrelevant details. Why set --warmup and --runs? Why
> bother with --command-name, which just means you have to show the
> commands separately anyway? Is the amount of RAM in the machine
> important for this test? Surely it could be if it was absurdly tiny, but
> in general, no, I would not expect it to be.

Well, the details matter in case some human reader knows something I
don't, or wants to reproduce the findings and observes something
completely different - they aught to be able to reconstruct my
environment.

The command-name flag is needed; without it the output of the
hyperfine would include local paths and would require post-processing
to include in the message.

>
> So while it is perhaps reasonable to document every detail in case
> somebody later wants to verify or reproduce timings, it is a little
> overwhelming when trying to tell a story, the core of which is:
>
>   In a repo with ~120k refs, ~300 of which were tags, running:
>
>     git describe --exact-match $some_tag
>
>   went from ~170ms to ~10ms, since we no longer needed to iterate all of
>   those other refs.
>
> That has _way_ less detail, but makes the point succinctly.

I don't disagree. Ultimately, it is a matter of maintainer preference,
and I'm happy to follow (and instruct the AI to follow) the
preferences described in this thread.

>
> I dunno. I am not trying to pick apart your commit in particular, but am
> more interested in the broader use of AI commit messages going forward.
> This kind of verbosity is quite common in the output (from my limited
> experience), and I think creates more work for reviewers. Should we be
> expecting contributors to make things more concise before submitting
> (either manually or through prompting)? Or do people even agree that the
> shorter version is preferable? I could be the only one.

The AI does what you tell it; in this case I was telling it to follow
the precedent in the repo and to ensure its claims are always cited.
I'll tune it for succinct output going forward.

>
> I have a few other comments on the patch itself below.
>
> > diff --git a/builtin/describe.c b/builtin/describe.c
> > index 1c47d7c0b7..3532c8ff22 100644
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -740,6 +740,9 @@ int cmd_describe(int argc,
> >               return ret;
> >       }
> >
> > +     if (!all)
> > +             for_each_ref_opts.prefix =3D "refs/tags/";
> > +
> >       hashmap_init(&names, commit_name_neq, NULL, 0);
> >       refs_for_each_ref_ext(get_main_ref_store(the_repository),
> >                             get_name, NULL, &for_each_ref_opts);
>
> The code change looks fine. It creates a bit of a subtle dependency
> between what's happening here, and the filtering inside get_name(). But
> I think that's OK for the scope of a single command. It _might_ be
> possible to simplify the top of get_name(), since we'd no longer see
> non-tag refs in the input. But it also may not, since we have to strip
> out the prefix anyway. It can certainly come on top as a cleanup later
> if we want.
>
> > diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
>
> It is a little curious that we add a perf test here, but the commit
> message does not even show it off. ;)
>
> I ran it myself here and had trouble showing improvement, simply because
> it is already quite fast! I guess that's because I'm on Linux, where
> warm-cache filesystem operations are pretty fast. Bumping $ref_count by
> a factor of 10 made the "before" case 30ms, and after is still sub-1ms.
>
> > +test_expect_success 'set up many unrelated refs' '
> > +     ref_count=3D10000 &&
> > +     git tag -m tip tip HEAD &&
> > +     for i in $(test_seq $ref_count)
> > +     do
> > +             printf "create refs/heads/describe-perf/%05d HEAD\n" $i |=
|
> > +             return 1
> > +     done >instructions &&
> > +     git update-ref --stdin <instructions
> > +'
>
> A few things come to mind on reading this.
>
> I have mixed feelings on sticking synthetic constructions in the t/perf
> suite. Part of the original point was that we'd run it against real
> repos to see how they perform. But that implies that people running it
> have some clue about which tests may be interesting on which repos,
> which is hopeful at best. So we've turned to this kind of synthetic
> construction at times (and this is certainly not the first). It's
> probably a reasonable tactic here.
>
> I suspect the resulting state is not all that realistic, though. If you
> have 10,000 refs, you probably didn't make them all at once. And so in
> practice the majority of them would be packed. Sticking "git pack-refs
> --all" at the end might give more realistic numbers.
>
> Bumping to a larger number of refs shows the effect more clearly, but at
> the cost of making the setup take a long time (since we have to take a
> lockfile on each ref!). We could sneak around it by generating a
> packed-refs file directly, but now the test really would be
> backend-specific. Probably better not to go there.
>
> And finally, the loop can be written a bit more succinctly these days
> as:
>
> diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
> index ed9f1abe18..b365dc67ee 100755
> --- a/t/perf/p6100-describe.sh
> +++ b/t/perf/p6100-describe.sh
> @@ -30,12 +30,8 @@ test_perf 'describe HEAD with one tag' '
>  test_expect_success 'set up many unrelated refs' '
>         ref_count=3D10000 &&
>         git tag -m tip tip HEAD &&
> -       for i in $(test_seq $ref_count)
> -       do
> -               printf "create refs/heads/describe-perf/%05d HEAD\n" $i |=
|
> -               return 1
> -       done >instructions &&
> -       git update-ref --stdin <instructions
> +       test_seq -f "create refs/heads/describe-perf/%05d HEAD" $ref_coun=
t |
> +       git update-ref --stdin
>  '
>
>  test_perf 'describe exact tag with many unrelated refs' '
>
>
> Probably not worth re-rolling on its own, though.

The suggested changes seem reasonable to me. Certainly I am happy to
make them, and re-rolls are cheap. Do let me know explicitly if you'd
like that done.

>
> -Peff

Thanks for your time! I really appreciate it.
