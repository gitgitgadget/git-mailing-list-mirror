Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D4136E3F
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728257075; cv=none; b=O4kEbQ/dfJtTNdh4wdWimsflI6tYYE3IRNc07mFoIPYO59N4a6dwq9A8T48qdwd6VTP9pRskNTc4CPN32hjvZlpFLZE+XojtHsHS+68cVntO11GJZDeSTS8N0bBrYRWxk/iJqg/RXEEBvWwdZpSMIP4I8O7S22AV43mRO9o9HDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728257075; c=relaxed/simple;
	bh=wK8o46TpmdGn20y4NBCChTCAAGelkORwEfxw1VRtU0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eso26n3EOaNyU5WIhxpoxzWv9Aur6VauOupwFQVkcabOazwnAjhuiSi1agK7d0gVqjhjRD7YU8k6ozSAAhJxJtkx9Zwi/1YNvZePi7ngtQXGnpP2Pgj1vS/MPj5LklufeLH4MYTaEI7KtlNxLW5OJFbfshtVvZ4guo97S+BUTfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb3cd42eedso6543306d6.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 16:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728257068; x=1728861868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK8o46TpmdGn20y4NBCChTCAAGelkORwEfxw1VRtU0Q=;
        b=F/5ESf14fGutp1Vydy04Fyv8YkN9xqvre/UxkFh2h6kdnaACAoRtyAK6ZWKIoZrF7g
         o1vcBhG0VtPdAzb684bofHsEd8rkUfnV2kLruSSFTmwqVeyn44RLJjBWg6Qp9CJYheaO
         XDzxf+kXaW+adrB25nmFkhIdxYj3VbNvlsejcV16ZzPGGJLZf2xLN0PK7rlt5HyUY7xq
         GuFU0w59dP27BDy47TYDkh0pWBfv6ITCxxiu5BLUtP6cUMt4XwoTfbcOnkW59bWufkTI
         /nfGvZHyO7Pm22DYvmidVfat69tTXFEEMAMDu8KBmxuaFnDh8x3qVdFxm8rtjRsfkix8
         7NhA==
X-Gm-Message-State: AOJu0Yz8UXPV4kmb21Hm+kxHrY6pjvbfzci3iH+h1t+t/g9XcWnyi8YO
	crzBdnxSPU/MJtmtu0vJmYkEm0o9mMQZnvT6Keio7VcqTBi7ka/btiS2WzmA2TO5n7ntXIZDbTz
	cBtFyQ0on4G1ag50TojzXkXZUTHYkSfTy
X-Google-Smtp-Source: AGHT+IEchEQsyv+DLJBJEPnK5hHZ/ek7GIL+TvVRlVi+fI4jr3NGm+7dll7z2ewWf5FCp+q+7T+STEgvRIrO3zew8yc=
X-Received: by 2002:a05:6214:240a:b0:6c3:6d25:2578 with SMTP id
 6a1803df08f44-6cb9a4eff93mr74737736d6.8.1728257068141; Sun, 06 Oct 2024
 16:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-5-cdwhite3@pm.me>
 <CAPig+cSdVVy4huueVQpiO_Gvn4SAXAiQj-uVnuScgfOOFJ6h0g@mail.gmail.com> <VKrLGkXtD_CWHlQJRx_JqPn9sFsjKL88fRnGvA2UcV_gvQxyv8kmIx9M6BkPRfAx9paB7KrjkL9XAE8P2P2EPJnciBN4F6LAAc176NzLh6U=@pm.me>
In-Reply-To: <VKrLGkXtD_CWHlQJRx_JqPn9sFsjKL88fRnGvA2UcV_gvQxyv8kmIx9M6BkPRfAx9paB7KrjkL9XAE8P2P2EPJnciBN4F6LAAc176NzLh6U=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 19:24:17 -0400
Message-ID: <CAPig+cSqWomvpgAGUCCaxHG9UTy+JecRndM9ynwdBgUoLYAXTw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] worktree: prevent null pointer dereference
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 7:03=E2=80=AFPM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 06:24, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > Critical questions: It is not clear why this patch is needed,
> > especially coming at the end of the series. Is there some code in a
> > patch earlier in the series which might call free_worktrees() with
> > NULL? If so, then this patch should come before that patch. If not,
> > then why do we need this patch at all?
>
> When I was working through different solution for the 3rd patch, I
> encountered this issue and this was the fix for that (granted, I
> could've handled this on the caller side). It turned out that I had
> to go a different direction and this was no longer needed, but I
> figured it wouldn't hurt to leave this in which is why it's the
> last patch. However, I can just drop this if you want.

Reviewers are a limited resource on this project[1], so it's ideal if
submissions can be as reviewer-friendly as possible. Extraneous
patches, unnecessary or unrelated changes to surrounding code, etc.
all make a patch series more onerous to review, thus are best avoided.
(This concern prompted all the review comments I left on this patch.)
So, let's drop this patch since it adds no value to either this series
or to the existing codebase. If someone needs such a change later on,
they can resurrect the change.

[1] There are far more people submitting patches to the project than
reviewing them. For instance, according to Junio's latest "What's
Cooking" report[2], the patch I submitted[3] a couple weeks ago to fix
"git worktree repair" to handle manual copy operations is still
awaiting review. (Since you've now been living in the worktree code a
bit and have had to digest the "repair" logic, perhaps you'd be
interested in reviewing that patch?)

[2]: see the "es/worktree-repair-copied" entry at
https://lore.kernel.org/git/xmqq7cancmoj.fsf@gitster.g/

[3]: https://lore.kernel.org/git/20240923075416.54289-1-ericsunshine@charte=
r.net/

> > Although it's true that this project has recently started allowing
> > declaration of the variable in the `for` statement, that change is
> > unrelated to the stated purpose in the commit message. True, it's a
> > minor thing in this case, but it causes a hiccup for reviewers when
> > unrelated changes are piggybacked like this with the "real" change
> > since it adds noise which obscures what the reviewer should really be
> > focusing on.
>
> I didn't change this originally, but then the build process threw errors
> that I had code before declarations (because I placed the if condition at
> the start of the function). I could've moved the if condition past the
> declaration, but it seemed weird to need to declare a variable if the
> function is just going to immediately return due to a NULL pointer.

Since this project is still following older style rules about
declaring all variables up-front, it's not unusual to declare
variables which don't necessarily get used in some code path (even
though it might feel weird for someone who habitually declares
variables only as and where needed).
