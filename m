Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DE2BB17
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756621245; cv=none; b=l0fq9lciDhrDKMe3Gh/WsX4WsXXXp0U2HZyQXVofM0j8u8Odt6yAQwErvfpsocfIeGZAondwiDkTLUSOHmH2qYxto1KaN0v3yCs5DyP0kg79e1cv+17utPd427GAQc6eW1BGPnw90HZh5oqug6D27R9w/sGFTijuy4eodY3nmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756621245; c=relaxed/simple;
	bh=4owTSKechj1aLPP4nlXs9HXoUhW3vLj3F/D2aQ0T6Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elw+IDHPXK8AgX4PwUo0GETXRKteh3VKwffrTsFzpAVcOQf4pzmJCwaMhrlwTPZWda80oRXvSNtuuDGJlmLypTnqCXydZTGmKzW8OgszvanEMn/8U/UcYc6YX30cQrbdysfOZuSqvu3r/CSI+YnwOT8h4MMfXt63c4EI0mnBfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKeNvkXS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKeNvkXS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445824dc27so29777435ad.3
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 23:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756621244; x=1757226044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4owTSKechj1aLPP4nlXs9HXoUhW3vLj3F/D2aQ0T6Xs=;
        b=kKeNvkXSEkgfxBxfAS8LM+McAiwdZdH4bwxxq8DEV8FvJfD5QyJLaZvIg6YtD/JpDL
         rknZJ44vfIfwKFYjJqiwh1PFYTqKv+0yZAvUAY68wVFsJ8V4rv6MH8h163e6+umgHUwR
         HIb+v1f29d8V+0lLzJvxjGafiBdF2L8dvC4pxupdYqrMA1/A/RuMLujS0dSYScziaNfx
         2kIyeSHbwXR/svw2CHLNCzC2kg0WQWtkAR4SVFOd1xKEtR8WI8/phG+mlle9IP1kOl4H
         itRkPGqWYmbHJTJkosQSi/+7SqLyDxon/Gc1QPxwRhDiDCC5XHWawv3M1cRUm7cq8sCV
         pU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756621244; x=1757226044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4owTSKechj1aLPP4nlXs9HXoUhW3vLj3F/D2aQ0T6Xs=;
        b=IRcmDgt6/R6m1bbiA10325p9KRB19OBZTXarTBu31L4JbdiaFEP1DJOO/fiqt3UvWW
         fCJGZ3uWXiRV2S1AH0EQP3jGx+HplY6i753AMmctswQwZn+eKVWLFSjGGNqGqZFDNN54
         owgVWVo0hKjdBNmuVTPIhgp9y7NjbRWG6HAHh+Uuxznc/cyMr/esLj9L5h2JWlZHFg+9
         h5nzY4vj61428S3rBSLOINhPlLcdu5w/5bk1g0NM7qb4NRcdNWL8oaf1BNy+rWL8Reo0
         8ElxWLmqYeJzk9/Tn4duoYu1Spt/Ab87mnBiVYtOcONDqdAopPQbfWhjN8XGTmeNztlb
         lNtA==
X-Gm-Message-State: AOJu0YzIYRGCo5wHCretivx6c84SkgrdRYb+ZAvfkxw7V0qxC8geOwCr
	YUCaiYNyoyPUiZpJ0c5NgOLA2tjOL92yDFDmaSiZH0BZLfgkNU0Np2T4ZKun13whB0OdzTS17Ms
	/FElwOsBmsIF8SVP4ArvGn5KEjEjflSc=
X-Gm-Gg: ASbGnctIjhBmwug3xhDuFLbAPKf9GuPFApFsnbfMBfQBF2ey91IVO/DwdT1booIl+Wf
	TRHqFCdMoI8WjMOHVYSX3c9fqFRXBo0n5C7ExVVPRFtc/CnDBh5YPwf1GZokxfSX9Lsp87injn6
	9aD/8et/ZhnUutwTztoT6JKm8kozz0c8Ni4vzL28Z5tCNFpEV6diDHNd46bWpZRj/yCjq3Hf2bg
	Cd7+P3k
X-Google-Smtp-Source: AGHT+IHSKAQSiMGg8TnIxk5JoLqWzqYWJ+dS7tCrChsu/UXzMqcC9pnJxqhINcazHFonTW7/7BjsLabuBYEJC+FCOi4=
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id
 d9443c01a7336-24944870a4emr64795495ad.3.1756621243624; Sat, 30 Aug 2025
 23:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-6-meetsoni3017@gmail.com> <aK3QOtQzUFsGvmyA@ArchLinux>
In-Reply-To: <aK3QOtQzUFsGvmyA@ArchLinux>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Sun, 31 Aug 2025 11:50:32 +0530
X-Gm-Features: Ac12FXwnrPZMXLPXK2uTtjdIrpfoWymwezlZdEg6ajtbNMRaRlex3FiZC24KMuc
Message-ID: <CAPhwyn0r11owkcSLXDALfPjKe1QvexC0uH6F7B=vktwfAue53w@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/5] t: add test for git refs optimize subcommand
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Thanks for the review, and apologies for missing your email earlier, I just saw
your comments today.

On Tue, 26 Aug 2025 at 20:48, shejialuo <shejialuo@gmail.com> wrote:
>
> On Tue, Aug 26, 2025 at 01:06:45PM +0530, Meet Soni wrote:
>
> > diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
> > new file mode 100755
> > index 0000000000..c11c905d79
> > --- /dev/null
> > +++ b/t/t1463-refs-optimize.sh
> > @@ -0,0 +1,17 @@
> > +#!/bin/sh
> > +
> > +test_description='git refs optimize should not change the branch semantic
> > +
> > +This test runs git refs optimize and git show-ref and checks that the branch
> > +semantic is still the same.
> > +'
>
> When reading the description, I am wondering how this test runs `git
> refs optimize` and `git show-ref` to achieve the goal. Should we simply
> just say we use "pack-refs-tests.sh" to ensure the compatibility with
> the `git pack-refs`?
>
You're right that the current description is too tied to implementation details
(git show-ref). The intent of this test is to ensure that git refs optimize
does not change branch semantics, similar to the existing pack-refs tests.

I'll update the description to focus on the behavior being verified, not the
specific commands used.

> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +GIT_TEST_DEFAULT_REF_FORMAT=files
> > +export GIT_TEST_DEFAULT_REF_FORMAT
> > +
> > +. ./test-lib.sh
> > +
> > +pack_refs='refs optimize'
> > +. "$TEST_DIRECTORY"/pack-refs-tests.sh
> > --
> > 2.34.1
> >
>
> Thanks,
> Jialuo

Thanks,
Meet
