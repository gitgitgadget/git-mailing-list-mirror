Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E33D0939
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427379; cv=pass; b=uDG/j1B9H0aPUP/i5inNTMy1kGKvu9b5A7AUxQvUJA38IEFQK0owh7+RqmTrC6h6D5IXoitzDEbhuKInhJfQbpZo8BI4M9AeaPM5aZB6X4/GhOKR2HYOZdnvuPdAoCTawOspkqEjRb1btzEJanJ35r/AfAWc2u5f6OmrPlPLZ2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427379; c=relaxed/simple;
	bh=Q01VJdXU7hu8In8YwwCgMH0lfW8cBJy7Xq0oJgYeGVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0w6Wg/CjxJQmjafJuPqWN8RyarPP2x6dezrB1lcF5M1f+G8r46D1meDEJq8zwR0me8KlMxNWrhTGtXndj9RFojMt2aGScltV129gS7ai5L/RAe4NRarZo+Jq+zmN5aTq8MEb6sXN7EaBPp1ZYoM+p5whpGmHX19hxaJWja3x9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oX1b1sWx; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX1b1sWx"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b383347fa6so640674b6e.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 02:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788427371; cv=none;
        d=google.com; s=arc-20260327;
        b=Ze45eRjx/d6nuRzJJ0qoBP6eWWydcD97PU8lZpiOLSVCQAL0gbYkruyXQdLtNdTX6L
         7gyOA5tvK72etHMF7bpNB093JKIUna7dbFKY8ojzp47xPp2FrE3clYao0lh/bkJizyEC
         aJoUqAeibaj2g+bLnpepQEoQ2CM5PIqXG8UDV7I3RfbjebPR147oGlr0JiOXQLki3PSC
         Aa1tlO+iiwjEMYs9AEI2BKBq2lEdKUBQns7QT6UZllFIkyeVJDpKLeJU/Me55SVHim71
         yoUvjiAlDTzn38CyCoVQ2TudX+TqdTBKu78NEPOWdX18Bm4NJIx6El5V/E5siRsB9H2+
         CsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LxjGRin7H78cFPIs4mBKk38MtmuL8GPwtbGI3bI2/s=;
        fh=RJLyHhk6XYmGRKacuJHFt80xqW2z1572kN3rk6ia4ts=;
        b=o1kZUO3Nnnp9k1n034GCENjV9gnp75vALu5Y537Zp9kmp6GnbLr9SLPoqyNhn+NyK3
         ln4Dkp18thkZelN+KeBOwqKeGoPqYECra2zaF17knmgv18kpWGqmiyK1McsFGptrejgV
         I0w7N/lBgrczFDw/Kcj1/u/9D3kETq3R1Atv9vkql3QsUOag4v1cyP54yySY4WfVrfCI
         XhKNyjXF1gdhXnpbGKcEo/HWoJJu8+zfhvbtgYlQdClOs7CO90QKGSjcY8WkxNQUfBoS
         0qgTXvcNKw/XT1fiPMD262aceUhQfbudoFMMQb1nzmrf8htOZypH0jzNTJYXTIoUpqrI
         wD9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427371; x=1789032171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3LxjGRin7H78cFPIs4mBKk38MtmuL8GPwtbGI3bI2/s=;
        b=oX1b1sWx5G/olinz+3ZwKOCr0VewDvx2XiZ6Rrconi13oi3dZD3jRmvY5LepbqsZ9t
         Fo6cvwZKKLoR0UY3N89+JrWxjCwNq0lsab3RENgq/wMJGF1VzrfE7A2V7xwGwSuzkz/m
         uicIO72EwpyeYyiG0KjIdphhPyJpckUm1bRpqiN6Yq0O9ACic7QqPuhoWpAxv7pc48e+
         kQYDzzJ2UNACYU8CQg/2390SGdna26ZoDA9o9H4ZkLMapCNBwokjKmvGY3TAhTM2r2x8
         h4hz9ilPxxGjd5UMk3yobUcnG0ePNS2rRz/9n9rqabds78qrYfQTfFnI+S5TTrANZFMs
         foOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427371; x=1789032171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LxjGRin7H78cFPIs4mBKk38MtmuL8GPwtbGI3bI2/s=;
        b=HPKxODOWl9uWGqvmcojhyaydbBO0WIjwIg4pItJ9QzqM1js18NviV/b9jFoPLzLd2j
         65x2/ygudC4EUB+cd2SSdta0Sd+qKuzjLhRIk+VgMUzzUnvnO+V4tjnPW0sg/X3cwZGQ
         GaAkVubRO0ba0xIn/VVoWdjN8F3thTrO74A5OieJzZDn4z21ImN9mc0UmqDlcTwoYxUV
         Xijg5nRZsanzOw7747GW2Gjkat/8E2NR21pKPUOMvxCsI714MPxXduRq+Ku/w5QuOCJs
         kn7pJX4qikPmlTAo4723sN9OdWXKzNWguApyatA4tUiZ2vYLOz1QeuGFiTdJCB11ss3V
         K7WQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3TZ08gDm825Ffi5+DWtG/7n92poPa9ieB//DI+Fxuyz4kYf68yH7WzORF3CPBwRSS4gE=@vger.kernel.org
X-Gm-Message-State: AFuF++nej9bNOStIzrrOHEzcnZ+cT3Dw2aZgoO4Yyh7/ybNsQstXGcZX
	Nq153jLbXaoriY4yAR1Ml5o+XknKQxuGUX88A5CQDwfO/zBZfeysnXbv6XeVEM4FHW1datu3p1Y
	FeQtnPZMd4tiWqYktJmuOJ0AzeOmDJYg=
X-Gm-Gg: AYBFou0XQnkrBA5SXKhi4uGp7Ok9EYaCfBlErZbUuTjNpZvPeGqfSsWyUEkdV9YlZ5V
	QQ2gKTM6Wclvdu1kGMqTQLW0W6kpclRM5hgVMXUse4kkKXgwjkaUlAVOBIEVt3pbpqQJKofC1pc
	hKaGUK/38J66BiHA3PB9dILNTh+BX/O1XceGEU1YHpUwgFUPyFcFtrmAek1jWDOEtVhUo+nsacr
	Bo+sDcAtUIEbTWpqHrGEz5JgSykQD/4S2852QngCf34uZDR+/6SVzv4rN4uaQRfxNBTGjwU5Mht
	lGfx/YtPWx7qc0NZtTaPIHmln9kTBG1yz556Ms1pWw8e0qH1+eDsR5ZCr+YeuKu0EjPqzWJUVB9
	N3REmlYDilqv+2rUkGmyaHK51rMThvk6RbUi+JJKP7jj09VCQQUPfC7gKCyIg1GQQATso+uF/
X-Received: by 2002:a4a:e90a:0:b0:6b4:117e:53a with SMTP id
 006d021491bc7-6b58679127dmr2913043eaf.20.1788427371097; Thu, 03 Sep 2026
 02:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
 <pull.2208.v2.git.1787684776048.gitgitgadget@gmail.com> <f9de9449-2e32-483d-937d-45b847143b29@gmail.com>
In-Reply-To: <f9de9449-2e32-483d-937d-45b847143b29@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Sep 2026 02:22:39 -0700
X-Gm-Features: AcwNN1XfZfnmqaUdXRgy-lZXOlikiK7MLK5lLIEpPgdSg1pdioOB2PrQDoKXoFA
Message-ID: <CABPp-BFi5xCg+cV-udwaq75QsV45mHmSu07ZGxTwp-1GP3YN0A@mail.gmail.com>
Subject: Re: [PATCH v2] send-pack: avoid sending the whole tree when pushing
 from a shallow clone
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stolee,

On Wed, Sep 2, 2026 at 11:23=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 8/25/2026 3:06 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When pushing from a shallow clone, even if we only have made a small
> > one-line change to a tiny file, we often push the entire toplevel tree
> > of files.  For large repositories, this could be gigabytes instead of
> > kilobytes.
> >
> > The reason for this is that the push likely lacks the commits the
> > receiver has advertised, so it walks back to its shallow grafts.  Since
> > it doesn't know that the server has anything, it sends the entire tree
> > for the graft.  It would also send the parents of the shallow graft,
> > except the shallow clone doesn't have those by construction.  We thus
> > are forced to assume that the server has the parents of the shallow
> > graft -- if it doesn't, the server's receive-pack will reject the push.
>
> I was ready to assume this patch was fully correct, but then I asked
> an AI agent to review it and it found an interesting subtlety that
> puts the entire approach in question. It also presents an alternative
> approach that is much simpler and helps improve things immediately.

The bug you found here is a really good discovery; thanks for sending
it along.  I think there are still some misunderstandings, though,
which I think may significantly affect the resulting conclusion.

> The gist is that we can attempt to push a shallow object to a remote
> that _doesn't have that commit or its parent_. This gets rejected by
> the remote as not allowing a shallow update.
>
> The problem occurs when this shallow update is attempted alongside
> another non-shallow branch being pushed that also has some "new"
> objects reachable, so the "assume the remote has the shallow
> commit" condition leads to novel failures due to that other ref
> update not having full connectivity.

Ah, I already had a similar test ("does not over-exclude for an
accepted ref via a rejected one"), but this is a different variant I
overlooked.  Good catch.

> Here's a test for t5538 that the AI agent generated, and I
> massaged into something more understandable/readable:
>
[...]
>
> This test passes before this patch, but fails after.
>
> As I was working on this test case, the key step that will fail with the
> current patch is the test_grep here:
>
>         test_must_fail git push --force receiver A topic 2>err &&
>         test_grep "remote rejected.*shallow update not allowed" err
>
> because the error that will be returned instead is more of a hard failure=
.
> This failure "at grep time" is something I added. If this line doesn't
> exist, then the 'git rev-parse --verify topic' fails which shows that we
> are able to break the receiver repo with this push, as the second ref
> update is accepted even though the packfile isn't complete.

Isn't this self-contradictory?  Saying "git rev-parse --verify topic
fails" means that `topic` was not created on the server.  Saying "the
second ref update is accepted" claims it was created on the server.

Also, I'm not sure where you got "break the receiver repo" from.  When
I re-run your exact testcase against the v2 patch, it is not broken:
  - git fsck passes
  - `A` remains unmodified
  - `topic` was also rejected
which seems to be guaranteed by 52fed6e1ce07 (receive-pack: check
connectivity before concluding "git push", 2011-09-02).

In particular, `git rev-parse --verify topic` failing here is the
*safe* outcome which means the push was denied.  So, the case you
provided has no corruption.  In fact, all that has happened is that
this shallow push caused the pushes to fail.  A simple re-push of
individual refs by the user seems like the natural next step.

However, the error message returned for this testcase is inscrutable;
by my count the potential error messages here are about half a dozen
depending on the exact codepath that is triggered based on a few
tweaks of config settings, and the unpack-objects ones are
particularly bad.  So we really ought to make those error messages
better, and perhaps provide a hint to the user to just retry pushing
individual refs as a simple workaround; that'd point out to the user
that does hit your usecase that there's a really simple "recovery"
path for them.  I've got some patches to fix that up.

> When I asked the agent to implement something that instead cared about
> whether the remote refs could reach the shallow commits, it deleted this
> method in favor of having your push.shallowexcludeboundary setting enable
> push.negotiate when the local repo is shallow:
>
>         repo_config_get_bool(r, "push.shallowexcludeboundary",
>                              &shallow_exclude_boundary);
>         if (is_repository_shallow(r) && shallow_exclude_boundary)
>                 push_negotiate =3D 1;
>
> That was sufficient to pass the new test, as well as all other tests you
> added, except one. I'm not sure if we need a new option or if we should
> recommend push.negotiate in more places (plus these new tests).

Yeah, as noted elsewhere in this thread, there is a flowchart of
reasons why push.negotiate=3Dtrue will fail to solve the problem.  You
have since commented in that thread, so we can leave that discussion
over there.
