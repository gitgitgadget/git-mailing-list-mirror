Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497E359A90
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806924; cv=pass; b=f1hX5/FamUIXEwd/SK7/9vyQD8fnBjmjzkGk6fRF8Cxh0s7lnz5B+ER9EyEhFOTVUK9zU085dQS3F9nnO5QX/pFlDxXUDmmpSzR7fJwP8DrdukLnYBFvvUnnUEkMtN1q0UEO8KEHAHr9Mj610jMiKN+YbKUlnfwg687gFVm5KLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806924; c=relaxed/simple;
	bh=QHWQTK4uZJRJIXaCHu568Ga3WJ+/+X7gtXNhonikvWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6cdneSnRgWPN6+ruRTuwmhKOu1Nafbw5pBay6rJrwFrMWfQOiuAgLWxt1+AWg6GectDKEonz7gm13bq5FRBe0wDO1jawqJCUF+gA4h4dRTDNjDo+Vo5IW37zch50p8iRiiWMsiV7/fhZCeALUf4q6P4f0W79aQpIxaS4CloJkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6Qt2G4J; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6Qt2G4J"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-673ee2a98b1so2596364eaf.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 14:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776806922; cv=none;
        d=google.com; s=arc-20240605;
        b=KAYRmnAyWaOo3QQOD921+5EO4M0BVWueLppRACav35H2cSCg41lqO+5NOXVewvemJ2
         CiA52tctwUeAoteGYPsh24qlaWewSzrXk0qOuL1J/SzZHbbzL+a2hofRM+2YiJ4XWREE
         juG5MClF8SLYYOCCvaSDpsOvKrpR+1qfE6vCAE4pb908NV8aDzzGiWQoSeL9bWkn1iKi
         T3FJQEpx2qBYNt3UtEuTPOeqUwPYXy4nlwDINASSyCQi7x+Bir4TM38xHcOSJfUa/HL1
         P60cNd9qJ0eE8sJHg5X/6FaWJuKQhbuxznsQSP6fQHbz2lg6lYudYtm/7N5AhTX3kSPo
         ue+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eALGwJ8YaHAQyhQTZUy3kE5IBxekg0ZIi65Lk67U0/E=;
        fh=jzY6moeyBaGqSHtRq49HUos/AS3aAs9QhLhmRUDr2PU=;
        b=Uv7kN+d1fOkKyDN4LcqOjeTUJwg89MnE9D+YtXGwqQMWdMkZekgKzThujMbwWdTJBM
         xM+rE6Q+627O4bYSIZDmFB2bwIQT8lhNbH/6l5DQCMw66Q/km4QRALTV4sRg8kdCywlh
         IYsr4hTZyLgPkqCdi6TpFkGXVvW6ah+0uhKvm2B9QQ44ciZ17Eyo6uKN0/RtnA2ykWZl
         e2pOaVhXJkzproXNnUm2PTSXzrvXtfz7k7JaaQCUkU+dFABP8+4rPxeyY14j9a9eiRcc
         acF8J+vti1/Eo42AqkWq/6cgcn8Z/XcO75GgfUKP03alH0LjCgG/xmFokvJ1ZgGJ+PFX
         2MPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776806922; x=1777411722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eALGwJ8YaHAQyhQTZUy3kE5IBxekg0ZIi65Lk67U0/E=;
        b=m6Qt2G4JaLoLWdYAv2LBEo3Y1wIvcSiTg4v/x4lCD5LVUNBnWuswQWc0NlKOQkAkTN
         hgQILXsZ/f3wCnMFQKsJFxcegsj3RzhBRu04/dPmQ0ECPN/WlgtImj4RQg3gDc2CK/od
         znaFWm6Otzg/i7n9j466IoyRxF+oD63iGltmfZgTE5j1d3wDkJ2NGEed1t7XJOaarMKl
         idE3qYubCZMiYIOKi9Rb/peHDvhVVE/hJ1sTQrPYaiBGa3yxvW9XMs2Ru15FjVYRnSq7
         U1iKPeqTHkqCWlLyOCCrTN17J5dZG+xSQeDakT1ElVlSdbfbxcDmqwEInynmjMpLt2P9
         1y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776806922; x=1777411722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eALGwJ8YaHAQyhQTZUy3kE5IBxekg0ZIi65Lk67U0/E=;
        b=iR5xXsVg4tJdf8+hutWdTJfZ64F8nYUPPmVAUWg2DaZOd3n/pBLIBd4IViEBmzltPW
         iPY275ni8KupN5UNNPWVUyu3CDNJNQo16a+dCtlEkQonwGJScfxFhS4+wCu+65RwNflj
         68igg0mSXTNSxpheLVB7qZmbUWY2FyPaDMTfrDAvZw8vntFFBtWnfaJRW1L6f5XD4+9V
         Kof0Q4Jtjl6XiIw0l/Bt3HZ2+pLpK6uxKaYH3ors3PwWROE3katGuejRSPUDRbCrTLz1
         A3+2tmCb/Ac/zgCKe8+EL1xcAVgxr9D0Pf7NJrPskrO0njGukh9I4lBeQbt7lDmAOaaz
         vJrA==
X-Forwarded-Encrypted: i=1; AFNElJ9LqY/OiY2RxqwMC0XoMCs2iH7EBzhFzi8QPO0JiwoxnMANRJAdmjmqzmhpJ48UrOS+hBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/Tjc8YjZNTw1Rjj9uTQT+0O9qHaIQPy4wivujJm+nVynd8O2
	ix7ZYYF+ZItyfEklDUMYzUpx1CYFIrGBy0vN78gi9QNY1/VjPbr/lvMa4keG+o8Dz9RPokHlrH5
	kxOZkwdMbt8uccpHoin6nfDaiqz732VswmHwf
X-Gm-Gg: AeBDietIhZ53H63dbXuQK+rrofaeqBB5SlpmqnviBh8LdvkoNZbXyoIbgvA7UirBg9E
	HRKWtoM9WJx+Z93Uf9YjWYyN+8toawSVvzgnRRuhfET1YUTtYFpHanhEAP6GeXUYhepkGz01sMy
	PJZ3UXMATlBIATEjsMqVV+ITJ5YbratiE2KPjoh7aYYbF8DqSW8+IaHfH6srl6WgxlIH+lTOX1u
	61Ytb94eOtpk4C3Hm/9y7WLGdR+pPnJqMWqqP1EyRfXNI8RmN1PepSTu5qbi/EDXY2FBzURhz9V
	/3n74d/zr7z8wcXp63eR2Tq+HwLPP9fl9dFxg/+YrXFB9pb8WZRyCTXIRI+iduF7oMG1i/ARNM6
	s8QbeDZDXBF4wUFBUXZIT/VbYl974XmTOUsJR2g==
X-Received: by 2002:a05:6820:610c:b0:694:9ea7:7aa1 with SMTP id
 006d021491bc7-6949ea78057mr1073364eaf.5.1776806921571; Tue, 21 Apr 2026
 14:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com> <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
 <a010a4ad-403a-4b6f-9a92-a33323eca0f2@gmail.com>
In-Reply-To: <a010a4ad-403a-4b6f-9a92-a33323eca0f2@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 21 Apr 2026 14:28:29 -0700
X-Gm-Features: AQROBzD-s6sia3BuUiMQ0wu4muV7BPxd7eqk5HdHyvKyZCYDe4074JyMde8PB-g
Message-ID: <CABPp-BF4woakYQ5RZ32J8SzDs_VpvT2Wv+Y2WaHTnFnM=96Kzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git cherry`
To: phillip.wood@dunelm.org.uk
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Sun, Apr 19, 2026 at 7:04=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Elijah
>
> On 18/04/2026 01:32, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > In partial clones, `git cherry` fetches necessary blobs on-demand one
> > at a time, which can be very slow.  We would like to prefetch all
> > necessary blobs upfront.  To do so, we need to be able to first figure
> > out which blobs are needed.
>
> "git rebase" without "--reapply-cherry-picks" suffers from this problem
> as well as it does the equivalent of "git log --cherry-pick". Is there
> any way to share prefetch_cherry_blobs() with the cherry-pick detection
> in revision.c?

Yes, you're right; git rebase without --reapply-cherry-picks and git
log --cherry-pick both go through cherry_pick_list() in revision.c,
which has exactly the same shape as the patch-ids loop in
cmd_cherry(): build a hashmap of one side via add_commit_patch_id(),
then look up the other side via patch_id_iter_first(). The on-demand
blob fetches come from the same patch_id_neq() callback.

After poking around, I think the approximate scope of the fix would
be: Move collect_diff_blob_oids(), always_match(), and
prefetch_cherry_blobs() from builtin/log.c to patch-ids.c and expose
the last one in patch-ids.h. In cherry_pick_list(), between the
add_commit_patch_id loop and the comparison loop, build a temporary
list of just the lookup-side commits (filtering by
SYMMETRIC_LEFT/BOUNDARY as the existing loop already does) and call
prefetch_cherry_blobs() on it.

That said, I'd rather leave this out of the current series. The bigger
picture is that I have reservations about expanding partial-clone
support further into this area. git cherry, git log --cherry-pick, and
the default cherry-pick detection in git rebase all exist to answer
"has this patch already landed upstream?" -- a question that, in
repositories large enough to need partial clones, I feel is rarely
worth the cost of computing patch-ids across arbitrary amounts of
history. The honest guidance I would probably give for users on a
large repo is "pass --reapply-cherry-picks (with rebase) and skip this
entirely" or to narrow the range under consideration.  The omission of
a --no-reapply-cherry-picks option in git-replay wasn't a lack of
effort or oversight, but a deliberate choice where I'd rather hold off
(possibly indefinitely) on implementing it.  So I'm a bit reluctant to
make the performance hazard less visible without also asking whether
we should even be doing that piece of the operation.

I only implemented the git cherry fix because of a specific customer
situation where the operation was already baked into tooling, and
prefetching at least makes the worst case tolerable. I don't want to
hold myself to doing the same for the cherry_pick_list() path, but I'm
fairly confident the code here can be re-used for those other cases
and I'd help review a patch from anyone who wants to carry it forward.

Anyway, you are making the right connection, it's just that my
personal answer is to let some other interested individual do it.
