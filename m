Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5113033DF
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965903; cv=pass; b=Fwrq+CMCuuO/fb8zCS2NqgwRYRWsB0ULVDuNVPQ2x+2Xo6ElE7Bpq7Plc3mZLC6FdtK/IDi4pH0BvVGPoxwsoKiShSIXdH0C4h2qx41AP/n8m2vaFhQn38gKPx7/1NRFgKscJms8ZyNBJLaFz2aN7lbq3AZTyredwHyaHg4pQcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965903; c=relaxed/simple;
	bh=ixTlUvv9QVlvh2uEPk/WeXBAmdXuZYJTKCwudkxRmiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/zsLqpN9DwduEhEoQgfi0NEYIlYt95E/KhDnCOOfXaPINDq7QGJpU8XRfi35W9fTECgE5NnY9Vc2awC1kckbHFkIer0EXiE8iiRHO6iuPrCwj3Ps96nW9PODou33flF2H44zoJpCxUvIlQSbby/vCrbalieSYZnSyHvbD+LZnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZXIgEfx; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZXIgEfx"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69486849135so1618010eaf.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 10:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776965901; cv=none;
        d=google.com; s=arc-20240605;
        b=lZSrKmBoUajpXX8c8B+xoFNBbIfpBtqrQoy7qbFAbGcEegAhjCscErhtBRMR+iQYWz
         R9B6UXOsEPyxhBr280+u/g5kFOF55iQrowcasyN+//j5QZZibODO84YZdmb52o0yhWW6
         mWj6EBmVauWBMAzMiyTV01N0PTruk9mBlkagZLhfatZG+ue9SkC+RhNKeXb4lE5Au6Fk
         xWp8zSp9NTwNgMLNUcLwLtP2Uv9Tc9m1UgZNE+TrBDxzQG9fJGAr/4ChX3GiMs2UpdFv
         a76pyHcPqjbKNUFjAi2hKWPOZ9cVPTgf5mkOjSPUQ7nGjVYs6dQWX9aOLUrJ58yzUjdq
         KQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AMHksb38saQ1a650B8DxSCPUGKeBApnoqAUeQytJgEQ=;
        fh=tQot0S9BvixeB1XFVNnTBx9Edn3T9Wx7f8vDsX/UvP8=;
        b=XzeRBkY1eIaDVYP9E3W/te5L6RbuxBVae/+juZ8wylI0OpKnNMmMACHCF57zJYqdlk
         P5iwgw4bpYS4KIEeLmuxUEB6LIodEW8D3BqcxIdcX3VhNDSlhoiUgh3wtXDtguxftvzh
         x7sLqobymC7EnLOkFH9h5DcOXncrYczzFVYAirdoFplgn0hKkhOpdLt9+KCUeh+7CZXA
         HZoiRQdC36QniZU3ET6oq6Ynqjcq99RZpePtrXkQkSt125wBUq4TLgWnxzx4anJbWnKi
         +cyz9Pzd/6fzsOQUf+0MZ/IQ92RkHDSBCdy880vxsGX9mk0l2eXCh3HMXcFj9EWi/ERw
         9KxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776965901; x=1777570701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMHksb38saQ1a650B8DxSCPUGKeBApnoqAUeQytJgEQ=;
        b=MZXIgEfx4owdWF4+lVmSjwxK04WeQ165g5taaVnnHUORA0bR8AzP0u0JNokD5HL76U
         Y7hDIKVUeAobsRoelJp2a5kVp0s0lCBkoZ2cG+a/UBDQaVzcEDyI9QdYjyjjA86R0NJi
         J8G78OsK3LocFMnreloMJQKl8g+qr0PwWPjzQEkC09PvxxpDITK/PetYO/zbT6+Iukke
         feRsjLlZgU8ZKShf3rb3OMRfzKtW2FXO3BdE0RcbmgupddxCD7vTXu5XyV8ArnNe55h9
         gol//1vOd5mOrEIkaEAFrCmlDMZVE+Pu/93sqbsoxr9L9JHbZtOlwbMNa4AJOlzaA2fR
         CYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965901; x=1777570701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMHksb38saQ1a650B8DxSCPUGKeBApnoqAUeQytJgEQ=;
        b=NcbtuC+CEWnCCBw4JJFJX6C60zM8kA6+SD2mhrm6NPh93JsyhW4JKaIEsUCJnCSHwo
         gFEmDRjAeGTdwhab76wYIn3+L81X2ve7rBGX0u4XfRRwwcIiBwzpJVKR72G9NvVs1lYm
         3PREHiXz3Z5PJxMQfyVdDyNJhTRiSW7fbfhfe5UEAZpJDT5gsk+P50lhhrz8FbWuF1fU
         qU+zcXp+sV3tzd2sSGMMCyFHJrmdrCW6YTIi1a4nmTNj2wbT4LsRR+6RMj1NRJT9dfRh
         m5KHvemo4x6+tgypNRTt9M2X00veqVfj89QZSS6O7kMexvs2kau3vYxM2+hXJruFENRF
         VS7w==
X-Forwarded-Encrypted: i=1; AFNElJ/6tM+PanShjzr4Q6DCoxYx+fqUxNZyKOCn3NG2VW49wyakCWYiuPX2bq6Ph+q/wcHs3Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5UxLmZygY10IS44eWOrQm8Stj672sBBgURcZP9Cl2M2WSzBH
	JNLMlT7O8/2SinrlrelxwhKbj0ovlO/U3KiE4lbNamzLw4hSIGzh4cDP4ivviJvpPByY25husnx
	A8YttOCnAqhOdqN2gz4QhtiZmcBmUoIE7dQ==
X-Gm-Gg: AeBDieuqM+3ArYhrbeFa7hqVvKxtHBhFwPLMqLy4c+e4HmBGd5rm63DpTCBqmJTBz/4
	V0OQ3iQni+KWzdg4/sInASEoVjEQMkIBTaFRhYWrhcvogn+Mvn2QXi4MCH2JyOpnygiQFIbapvB
	2T17flEQc6RU+6sXXyNE8KFk8BtoquUMhABBWrbY2L5O2csAY6Gspsls4RHgJgEskQfQvIJvH+m
	USNpesd3iwd8VKUfN6qi+jgHFOg9N4QMoaQdV0BdY91EqFmT/gj4kAIyfIbGcdEMV/QIuAr6Rd5
	ppMi47/XRoR/2ZyfGsWWX6frIoG8ST1UsKYYbsadY0cGqUBNg+ZO/QhjFVu4aeg7BQfcogBhQ3e
	ymht+t6qPHdtYzyozjsoNlPLZu+M5+5DppBgR
X-Received: by 2002:a05:6820:629:b0:696:1a25:fdc9 with SMTP id
 006d021491bc7-6961a25fe95mr1998631eaf.28.1776965900838; Thu, 23 Apr 2026
 10:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com> <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
 <a010a4ad-403a-4b6f-9a92-a33323eca0f2@gmail.com> <CABPp-BF4woakYQ5RZ32J8SzDs_VpvT2Wv+Y2WaHTnFnM=96Kzg@mail.gmail.com>
 <2abdc8ba-e361-492c-88b7-0c807ee9fb4d@gmail.com>
In-Reply-To: <2abdc8ba-e361-492c-88b7-0c807ee9fb4d@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Apr 2026 10:38:09 -0700
X-Gm-Features: AQROBzDM6MgkrJzIio4IP7c_z9LTdP5d3cbwKshnzB_-1XcI6ZtZnpGwe__VRlk
Message-ID: <CABPp-BGQkN0ZeDAR4NzuyBakJHLM1AuqkdSGbb0YQfgWh2dWFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git cherry`
To: phillip.wood@dunelm.org.uk
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, Apr 23, 2026 at 8:15=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 21/04/2026 22:28, Elijah Newren wrote:
> > On Sun, Apr 19, 2026 at 7:04=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >> On 18/04/2026 01:32, Elijah Newren via GitGitGadget wrote:

> "--reapply-cherry-picks --empty=3Ddrop" is certainly more efficient. When
> we're computing patch ids do we do it for every upstream commit or just
> the ones that modify the set of paths that are modified in the branch
> we're rebasing?

You are correct that the patch id computations won't look at file
contents of commits unless they modify the same set of files as one of
the commits in our topic branch, but in order to determine the set of
commits which modify the same paths as commits in the branch we're
rebasing, we have to walk the upstream commits and do a tree-diff for
every one of them.  Yes, commits and trees tend to be much smaller
than blobs, but the number of trees/commits we have to look at may be
far larger than the number of blobs.  The biggest repositories are
constantly pushing so many commits that they are at a size where even
a merge-base operation can start to feel expensive.

> It is a shame that we don't have a config setting for
> "-reapply-cherry-picks" as it is easy to forget to pass that option.
> Unfortunately it is not supported by the apply backend which makes such
> a setting potentially confusing.

Indeed.

> >  The omission of
> > a --no-reapply-cherry-picks option in git-replay wasn't a lack of
> > effort or oversight, but a deliberate choice where I'd rather hold off
> > (possibly indefinitely) on implementing it.  So I'm a bit reluctant to
> > make the performance hazard less visible without also asking whether
> > we should even be doing that piece of the operation.
> >
> > I only implemented the git cherry fix because of a specific customer
> > situation where the operation was already baked into tooling, and
> > prefetching at least makes the worst case tolerable.
>
> I'm a bit surprised customers aren't complaining about tools that use
> "git rebase" being slow.

Are you sure they aren't complaining?

The merging parts of a rebase operation do have batch prefetching
already (up to 3 batches per commit; done that way to minimize the
number of objects downloaded because sometimes 2 or more of those
batches can be skipped entirely and trying to combine them into a
single batch would only be doable by downloading far more than
needed).  But, as you're alluding to, the --no-reapply-cherry-picks
part does not.

I'll note that GitHub tends to focus far more on the server side; it's
just that in this particular case with a special customer, they had me
dig a little closer to their client side operations.  In their case,
they were using git-replay rather than git-rebase, so they'd have no
reason to complain about rebase.  git-replay shares the same batch
prefetching for merge operations that rebase has, and doesn't have a
--no-reapply-cherry-picks behavior that can even be selected.
Honestly, I think the main reason this customer was also using
git-cherry was because I didn't get the drop-commits-that-become-empty
logic in the early versions of git-replay.  You added that to
git-replay (thanks again!), but after they had already built their
tooling.  This is only a guess on my part; they may have other reasons
for actively wanting git-cherry, but I think it might be worthwhile
for me to ask them if they can upgrade git versions (to get your fixes
for empty commits in replay) and then drop the calls to git-cherry.
However, I didn't want it to sound like I was pushing them to change
their workflows at my convenience, and hence this patch so that things
can be fast even if they keep the git-cherry in there.

> > I don't want to
> > hold myself to doing the same for the cherry_pick_list() path, but I'm
> > fairly confident the code here can be re-used for those other cases
> > and I'd help review a patch from anyone who wants to carry it forward.
> >
> > Anyway, you are making the right connection, it's just that my
> > personal answer is to let some other interested individual do it.
>
> Fair enough

Thanks for taking a look and asking interesting questions.

Elijah
