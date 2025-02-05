Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395141F473C
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797278; cv=none; b=fUjneaj7l4eecbT3U0UXPjRZ8nINo2PcSXEvivKJYxToRo9WKficTHqZEM8cCcED82tvraftjVxdmjIhe9nxIUAmL06egln/XsWdXmQIAKIBBiWdQtczG4RPp0ZV+5BzoBffZNLqa6qA2k8ROEAeL8z2UzbeYZHiEEJa2btKo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797278; c=relaxed/simple;
	bh=ijqYLFrS7+iWf6WpvDX4RvOOKyzNA8ewpY2tCmw6yvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BukoIyKn6/q73hqo5hmY1w0THpxoNRA/7Ckt4d615eX2KnZAatRIGrH11miZ0kF5ekGeDO6a3BnWQI6rcALfPK0CgJ/SL+xOk87uVOhWhfBOkaLn30ytou8rEV90NHKIthAqf6SzFHvVHY03/R8N0oUQtXDK6NHBKQsjm7m2W1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcM1QGMU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcM1QGMU"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467abce2ef9so90571cf.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 15:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738797274; x=1739402074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qv3EDEh3EqOIFaBoesb82UrfCGC2itTb7I6k3ro4zuA=;
        b=IcM1QGMULu0dD2OEiuyb5/K5VEXHZaDs/RI1+7iZ70tGmu4f3W6EDvhhYpDNuV9icQ
         BtU/xo9SSFB1pPJ0zzVTilzrBycIS3/7HHitbDvYFg9e7GAqalelWP4GQUymnjWKVNPh
         cPyGd2FiUwxq1y1MKy6NgxQ6GeRPgkJBe+vi1mk9JS3tYVDvz6SenNn06dZhmU5WSBJx
         3gfrVFaWYv6qWCsbDBqMw7O0/4ff3mEWPsmAAYE9dKrsAXQzit0bNYUEZkq25OaBaCUO
         gFEzecdn4hdG4r3eHLA/UdznRGIRt1uoULnrlqH9JqINo26V1zdIrzxHrLaDdyefmICr
         4mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738797274; x=1739402074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qv3EDEh3EqOIFaBoesb82UrfCGC2itTb7I6k3ro4zuA=;
        b=R9UN6DUO7hx3SI4qRt4muwq+eEupuCt04oymTjX/y86Zr7ko5dtjaP91GaNEna8CSM
         ZorTVQUT0EqbVVLGRIM0OvEnF1nsUizml9Tas2jcW7oFIohI8OvCsWDWF5TTyq7/Sonv
         i9HsvbA3dPgGu3cBZw9nsjI+g8Rm5p0r7WJXL6UPDCQccb26Edoqz7ofoXMsux1fCO82
         4hAcQrp7P/kaTMZ084Q1JR0eK+JvFA4PeP/nfvdIiMaRHRJoS0zsjpuJeJNRwKuxBOIG
         nc0r6dpUX/hhdTpUoqv5hJA64D3HGfs63OFIN7rxlmycjHRFLm3/TfrZM1ChTDZljzes
         pZmw==
X-Gm-Message-State: AOJu0Ywdza2tPLLj189brJmT54OmJn0qPUvce/oI9d5fRbIyJa3D8YkN
	OyjzsGfxAcXXRMz662PlDWPq1KtC36Y/J/jZDS8jeKSypJMOn3f3sRyBAFZ/XytEymlrdNG+HFe
	zqHXJCwRvqawm01PLSpPlekvWnp7yUnFXJKsMqCqagZX/6gpcsw==
X-Gm-Gg: ASbGncst0Ylcnm1MjTGNLt71thnMnb4Riv7hmJWvaMtDk/p844JjUUtf0z/SplVs7oH
	CJHvpBWmrsIFRhAwfefzu3rEYGfKNtoVs/U72acPQDW2nNxqVwKubcNpsL6LaLiQwZTe2ki+Vih
	ziqp7OYLMbdD8wWptZJQo2+1NlHtpRfw==
X-Google-Smtp-Source: AGHT+IFI2kzzZnU7X9kDGooo/3rdMKksMl+paH0JeXPEu1/1rdc0YF2W08a+CdFqlbf9bNzz3jPCquQoHwVDgZJ3Fu8=
X-Received: by 2002:a05:622a:620a:b0:46c:9f17:12f6 with SMTP id
 d75a77b69052e-471130d4e80mr132381cf.27.1738797273561; Wed, 05 Feb 2025
 15:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6CSc_vyGkn-ozUH@pks.im>
In-Reply-To: <Z6CSc_vyGkn-ozUH@pks.im>
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 5 Feb 2025 15:14:21 -0800
X-Gm-Features: AWEUYZkqVxaWAJzJY74e_YsOyZGg-40f12_pY85G4HSDx1izXcHJGRX-LMmwKjc
Message-ID: <CAJoAoZmJAM--FVmhxs_0sL1A8yrLwNBFULPDYFgV=AtFhn67+g@mail.gmail.com>
Subject: Re: Continuous Benchmarking
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 1:55=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> due to a couple performance regressions that we have hit over the last
> couple Git releases at GitLab, we have started to set up an effort to
> implement continuous benchmarking for the Git project. The intent is to
> have regular (daily) benchmarking runs against Git's `master` and `next`
> branches to be able to spot any performance regressions before they make
> it into the next release.
>
> I have started with a relatively simple setup:
>
>   - I have started collection benchmarks that I myself do regularly [1].
>     These benchmarks are built on hyperfine and are thus not part of the
>     Git repository itself.
>
>   - GitLab CI runs on a nightly basis, executing a subset of these
>     benchmarks [2].
>
>   - Results are uploaded with a hyperfine adaptor to Bencher and are
>     summarized in dashboards.
>
> This at least gives us some visibility in severe performance outliers,
> whether these are improvements or regressions. Some statistics are
> applied on this data to automatically generate alerts when things are
> significantly changing.
>
> The setup is of course not perfect. It's built on top of CI jobs, which
> are by their very nature not really performing consistent. The scripts
> are hosted outside of Git. And I'm the only one running this.

For the CI "noisy neighbors" problem at least, it could be an option
to try to host in GCE (or some other compute that isn't shared). I
asked around a little inside Google and it seems like it's possible,
I'll keep pushing on it and see just how hard it would be. I'd even be
happy to trade on-push runs with noisy neighbors for nightly runs with
no neighbors, which makes it not really a CI thing - guess I will find
out if that's easier or harder for us to implement. :)

>
> So I wonder whether there is a wider interest in the Git community to
> have this infrastructure part of the Git project itself. This may
> include steps like the following:
>
>   - Extending our performance tests we have in "t/perf" to cover more
>     benchmarks.

Folks may be aware that our biggest (in terms of scale) internal
customer at Google is Android project. They are the ones who complain
to me and my team the most about performance; they are also open to
setting up nightly performance regression test. Would it be appealing
to get reports from such a test upstream? I think it's more compelling
to our customer team if we run it against the closed-source Android
repo, which means the Git project doesn't get to see as much about the
shape and content of the repos the performance tests are running
against, but we might be able to publish info about the shape without
the contents. Would that be useful? What would help to know (# of
commits, size of largest object, distribution of object size, # of
branches, size of worktree...?) If not having the specifics of the
repo-under-test is a dealbreaker we could explore running performance
tests in public with Android Open Source Project as the
repo-under-test instead, but it's much more manageable than full
Android.

Maybe in the long term it would be even better to have some toy
repo-under-test, like "sample repo with massive object store", "sample
repo with massive history", etc. to help us pinpoint which ways we're
scaling well and which ways we aren't. But having a ready made
repo-under-test, and a team who's got a very large stake in Git
performing well with it (so they can invest their time in setting up
tests), might be a good enough place to start.

>
>   - Writing an adaptor that is able to upload the data generated from
>     our perf scripts to Bencher.
>
>   - Setting up proper infrastructure to do the benchmarking. We may for
>     now also continue to use GitLab CI, but as said they are quite noisy
>     overall. Dedicated servers would help here.
>
>   - Sending alerts to the Git mailing list.

Yeah, I'd love to see reports coming to Git mailing list, or at least
bad news reports (maybe we don't need "everything ran great!" every
night, but would appreciate "last night the performance suite ran 50%
slower than last-6-months average"). That seems the easiest to
integrate with the way the project runs now, and I think we are used
to list noise :)

>
> I'm happy to hear your thoughts on this. Any ideas are welcome,
> including "we're not interested at all". In that case, we'd simply
> continue to maintain the setup ourselves at GitLab.

In general, though, yes! I am very interested! Google had trouble with
performance regressions over the last 3 months or so, I'd love to see
the community noticing it more. I think in general we have a sense
that performance matters, during code review, but aren't always sure
where it matters most, and a regular performance test that anybody can
see the results of would help a lot.

>
> Thanks!
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/data-access/git/benchmarks
> [2]: https://gitlab.com/gitlab-org/data-access/git/benchmarks/-/blob/main=
/.gitlab-ci.yml?ref_type=3Dheads
> [3]: https://bencher.dev/console/projects/git/plots
