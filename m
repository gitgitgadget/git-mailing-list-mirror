Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC5377A98
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187427; cv=pass; b=YlyF3VifGTtPGC78Gwi1MQ487REzPsgYdYCAgR76Pjd/WdsQCgJSGlTuJ+P/hSh2Y9enTtEuFJzVgEIiw1A+amNx843KXT3Bbp2EFstr/3yJOMELr7Y7FbYM3WOZNwJ2nEUdY4Gzgw5as3KyF1V/wIMY2I3TasFCa7bt5u6aGk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187427; c=relaxed/simple;
	bh=QXB8MQSxgkeVc7yFJf0O0kqjn6njiZjVKmkgnkm0rco=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbo3K5Akzsh2T5Gpg3aVUv+D8Vjz85jJUsswbp4Z7pyWlTlXQKcrKkydI9RT/RkTG+tZSpAJ6NIRnNmzJG6P6f0gbjZUrdivQY1DwOa4zfShPzO6PZIxxNZ61vR42lTUTioFxkrXPjtVVs+jcMJlszD57pM/NSvtPpM4YMa3BIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6jguMww; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6jguMww"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8a83d2706fdso10271737b3.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 01:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791187425; cv=none;
        d=google.com; s=arc-20260327;
        b=kax4qXIzqTg4Tzycosi9Q/CH8IC+w6ZxIxbnKlVwBAXt6kR5ephFf8DlUKpk4kEyjN
         9fsWgaqOrmfCeh5RRP3lpxt/j8jmOLhUuOzZhXVqf0V+6DllWtnEq/I6NtV0agA2VDEL
         My5e0AHcDnPkUSPZ9EBmVTewwNAp/PjE2jH0RubGtfG1LlEygOR/0NDS/aUJixWrG/wU
         1DT1Hbin4KtGqE98pbHO2nf+Yz8uo6OTKqeNuVSyAZGCoaV6UrfgCPK4o0hCDQVZZ+Vz
         f40HaIIZzlRmSXP8okR/GfGlm3eKZJKHI4sUXY1ygcslA0kyXJoBcM5UqBk4h+n4F9Pp
         tl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=QXB8MQSxgkeVc7yFJf0O0kqjn6njiZjVKmkgnkm0rco=;
        fh=jGxuR2e7AO/J0sq2RAuqTiKiid/8c9HmDdwsrJEihSQ=;
        b=gTRoO3EWpfGtZtnxPQscBtNZiI76SNLUEFZHlgzqRUcVR21Dx1PD/7XVKn460Dgsq7
         qB4MMB83UO86BlVdqlXSRLPnDMV1qixrFVe7AXvRNvm/eKBzg22l99Tfpa7oq/Sus/Sx
         +yN68xGx2SedVLtsc5EhVCOtEwEpJMeDFTvJkaoOB6ejb4pwXYZD2RAn6acEzebDQPb5
         AMkfxCNsqnfU+vjCkGz0T8imj45eBhwGPWI18WOq+fbGIGWZqlXWvZ/6oz4c946CYg33
         ZPNoKoufnIuWWCZVpcDPlLzuhY1xEK5cI9vNJlA8zXaGjexAkaTQr97KfHvH++3xa1oh
         BFiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187425; x=1791792225; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXB8MQSxgkeVc7yFJf0O0kqjn6njiZjVKmkgnkm0rco=;
        b=P6jguMwwo+c/EMO986cswa+V2yIX24Tj6eQBT5NA+F0jZh72XsVXl9NaD6MxJsiP8g
         0yPviNqJZkp4g0bijSxxIhp6FvMUcQTvkLV3yHB4u81pjxOvUxOzIK0qY3D1fU1nVnqZ
         EADDptVWL9p+P6xyWO7QdCtstHq1lom0Pz7YH680y0krgVD2nA0BOHHfIfDWjZU4kxdh
         Gz+XNiz5uGO6b685O72hZkBZvoJodqAzO/WIxHpfnmZRjWNp2kapCAwT/IpgxE+y1Ud5
         +OXQ4qJ735umvFuW+svMKWYQlGJOMQDMmA1chmOmMmWyJb4kbSiPNpP56Px+W8xNXh9p
         8nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187425; x=1791792225;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QXB8MQSxgkeVc7yFJf0O0kqjn6njiZjVKmkgnkm0rco=;
        b=FjrunhQYnw/7akGZZkGqNz8g4rJyUN53VnD1DCRJwnyUbQT1NonsEvgqBlItHOWoP5
         4jZTZTmNqFw42WPAHudBBVNSCHPH3CrR1/MFPWInv5GrAihbfg6PGU2ydVttEHmFMYFZ
         oEpALSHFFgSDsEkz5I9UcFPghAzvZFBC3X32bXQED+EBVjhFxjytTvUj1YDRioHJMNZJ
         OD2jduyjcWLc9eSqUhspSpbRHUW777ul2gVLs8LJ7wg3r5+D9OC8iKXzQGv9rH35arXU
         u04h87ZgAq67Jg21jmBakFoVOnVDCrbRx+mqsP4dRCvTQR2YVj5O/xJPEbYSUo1jSesZ
         lSAg==
X-Gm-Message-State: AFq9FYKxmqD0iG6BG+IR32YHxkXJKpLv2aylJvR3tcg6korSKocYcTig
	lWqd1qlEBrX2haA0c4OTb35XZVYCvD2kpyrFL0tR49XkdkC8F+s1GmE4qd/NGszq9mIUlYY+HJ/
	BYQmUC1VmdZ9sef1AIDKLS1COSxVcfHkDOg==
X-Gm-Gg: AYBFou0qFrLlF+tmhFZ2j8Zaf3XjVq2eSzgX2Rx6WIBCrzOyA7LxH0Pm8v+TB/6GL0W
	xR3TuuH0gk9t0y1V/a7oYdijhmWF2SQ48f84XDoqGyX/8i7rGLE6yoXYEWD26m+V6yPjnZgLUPy
	w8ItrJyZ3hjtFaQZ1/NqwnjabYVv9ZadxiClQRtzEW5l68EznkH/fU6rM1jhmuOyjBAz7iV//ng
	xxkjUX4QTcQLVLdfpsWZTac7LhKW6RcBB6fDuZf4RmLWYRwY2xgbFt4cC/cwyeT8X5LAOLohCcr
	dKHukb8euv2Ue6R2fpK5gjNMSdMlQRcIwL6+jKQxk+qxelzNkxuIXXOf
X-Received: by 2002:a05:690c:c386:b0:8ae:68d9:cef6 with SMTP id
 00721157ae682-8ae950fa1fcmr18580967b3.76.1791187425060; Mon, 05 Oct 2026
 01:03:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 01:03:44 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 01:03:44 -0700
In-Reply-To: <e1635b9c-bc03-4835-805f-5fa52f09364d@kdbg.org>
References: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net> <20261005055337.7579-1-hananarshad619@gmail.com>
 <e1635b9c-bc03-4835-805f-5fa52f09364d@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hanan Arshad <hananarshad619@gmail.com>
Date: Mon, 5 Oct 2026 01:03:44 -0700
X-Gm-Features: AclHuK_-3hgOe6uiE40hmNsoHCrX76-RR8wMTR4FK5_Ir4w6ZepdWKws9TfnihI
Message-ID: <CAKPibBx6364BcB2nqyQ7jhTaQMaUuR2TNKzZ-9H8VopcRjXbZw@mail.gmail.com>
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through remotes
To: j6t@kdbg.org
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"

Hi Hannes,

Thanks for the feedback.

I agree that stashes should remain short-lived WIP and that this
should not encourage using them as a replacement for branches or
normal project history.

The use case I have in mind is narrower: temporarily handing off an
unfinished working state to another clone or developer, without first
turning that state into a normal branch workflow.

The motivation is somewhat similar to a Perforce shelf from a UX
perspective: the work is still temporary and unfinished, but another
developer may need to inspect, reproduce, test, or continue that exact
state.

I also agree that Git already has the underlying mechanisms. In fact,
that is the main reason I thought this might make sense as porcelain
rather than as a new feature model.

Today this can already be done through existing refs and stash
transport mechanisms, for example with git stash export, git push, git
fetch, and git stash import, or with the direct push example you
mentioned.

So I am not proposing a new stash representation, server-side storage
model, synchronization mechanism, or ownership model. The intent is
only to make an already possible operation easier to discover and
perform correctly.

The question I am trying to answer is therefore not really "should
stashes become collaborative objects?", but rather:

Is there value in providing a small convenience command around an
already-supported stash transport workflow, so users do not have to
understand and manually compose the lower-level ref/export/import
steps?

I also think your comment suggests that keeping the scope very small
would be preferable. For example, rather than trying to introduce a
larger shared-stash subsystem, an initial version could potentially be
limited to a single publishing convenience and leave listing,
fetching, deletion, etc. to existing Git commands.

Would you still object to such a narrowly scoped porcelain wrapper, or
is your concern mainly about introducing the broader concept of
"shared stashes" into Git?

Thanks,
Hanan

On Mon, 5 Oct 2026 09:47:20 +0200, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 05.10.26 um 07:53 schrieb Hanan Arshad:
> > The revised interface I have in mind is:
> >
> > Publish one stash to a user-selected remote ref:
> >
> > git stash publish <remote> <remote-ref> [<stash>]
>
> I am actually not very happy with such an interface. The premise to have
> it is that stashes are something that can (and should) be shared with
> other people. But this is not the case. Stashes are strictly personal,
> short-lived, work-in-progress-not-worth-to-be-committed states. If you
> use stashes for longer-lived, worth-to-be-committed, sharable project
> states, then you are doing something wrong. You should be using branch
> labels instead.
>
> >
> > For example:
> >
> > git stash publish origin refs/stashes/hanan/fix-login stash@{0}
> >
> > If <stash> is omitted, stash@{0} would be used.
> >
> > Internally this would reuse the existing stash export mechanism and
> > normal push machinery. The original local stash would remain unchanged.
>
> There you have it. If a stash is worth to be shown, then do take the
> long way via `git stash export`, and push the ref. Or just do
>
> git push origin stash@{0}:refs/stashes/hanan/fix-login
>
> There's no magic support needed (nor, IMHO, desired).
>
> -- Hannes
