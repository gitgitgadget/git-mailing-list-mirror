Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C2173
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144064; cv=none; b=EP0aTyMDYO+YdCt/q9usQDWHY8i84aRiRHn1kkB3oG+uMW3v0Y0FKcg5vyhD6U3YrMOhHbyYGeKZTmqsyAQ3J56Od/CE+gX5cTwPWYpplsVJwZFfRLIobPj2jV6JcHkpNl3RCeMgytvnek+geDDfjXDoC8BVgWn54j8v9x7PBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144064; c=relaxed/simple;
	bh=IRjheIymkwsT5uJKy8IUoeb+zCk0LU+iNKn2jZXKdcU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=B9dnz7knrhjiuMtPhdskYGpXmKX+mCNsJlRrjewwvok7ltWm47IhxUX0wI2XSTC4cnivH2/Sca2W+K1JqDye4+1Q+CZ+PJbGe6nrE3bvK0KXuUEHMmBnkgJ8rYKqdiipUHyKXmX4op3pCFYFrEGF/ILQCRQKxFI19OCurRTTy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGdgj4QP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGdgj4QP"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7e0093018so76288567b3.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730144051; x=1730748851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MU4ky7oR/KTcIHjYY0KS9CrPSpSWxwmuQ6UnIp9FLkM=;
        b=ZGdgj4QPQ2iMIt60eluXICy/CFaaDaV1IL1FjnrO27S1v3emRShs3jcPRifstVQl1x
         GYQBnwxN+NToGguMskV2WT28yoDKZX/HN2G8aoGBzqYSTtOhVQcMaKgk2wcCTNeA9+T1
         plIdbkvaaJ4RSFMyjKjCe1vIstjRLU5iJ2SBgqysEgsCZOACY9snggHZZs2oJPik+OMH
         ihf/cd0cld4WUnVPdtBDWmh8sP1LaN/pF6Ez1WXwooYDrwyI3ymwu3pw4qKptpWZ/sUR
         3x66wAnJMGiu9FFzQSclm+mRBu62eCn1+8JEGGx+a78gDrpQxYufgFA/oSN6Lwt4l7lH
         K+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730144051; x=1730748851;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU4ky7oR/KTcIHjYY0KS9CrPSpSWxwmuQ6UnIp9FLkM=;
        b=gYNsKQTfeKIQXbUdcAorjp0OxrBb+gQ/K6xvQM2DQHdPtd9NmS1aVEwg3uI0Gr7A7K
         lWdFgDrjZYj3kJyuujSv/uTXwjMuW+8IvxUf4RdtG4DUVjZjZiWrHAip0tXBxeJhA1nX
         fhaymCzKUoShhXnhBKITCOcuOh38vRtXJfqPKyPMKFQmlrCgU3T72c4qhF6nsbqUcOTe
         R5OHAOLKI5bBsJtgrMPVh73U0ZBtM65Z35a3Wr0UST9Xvwfczs0QCQ7utnpJhww+xuj3
         wwiinflZkZHyw0gtk12YvYYKlPEobvUHuoZREhpzuWiPQhMRfIsJGo69v52JyRhqErW4
         n12g==
X-Forwarded-Encrypted: i=1; AJvYcCWKw8zyI5vyy0Lx9pHuIdteY5wBvc7hzCUrcHvv73qd0t/Hf5n1kSlw2yoOUERrJb52ytA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxggThRHoLJXkQCgpTHKU3OoFclRdZfHrrdbvOBWm3rhEciuesF
	Ltkkw2x7vMKn7csvRQtxMXDizXauzL6pQ8t8tD17EJs2d8k1ivUMwJOwXsRM9RC0liq1/RQ+u2J
	f7DKihVsevOndJOvEVDpT7eGDA23qBA==
X-Google-Smtp-Source: AGHT+IGSFflvQTIjNDwHu71ykVsokeIZaAs+szkZeQVjcO16eeBcj/N/TaAdJqXGsWTXPzOAwTwU3eZAvJSNtxeJ9Rk3
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ba9c:8d0f:d4f8:e6ca])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:6913:b0:6e3:f32:5fc8 with
 SMTP id 00721157ae682-6e9d8929a14mr5206177b3.1.1730144051350; Mon, 28 Oct
 2024 12:34:11 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:34:09 -0700
In-Reply-To: <Zx7bEq5DVG4CmokI@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028193409.3648734-1-jonathantanmy@google.com>
Subject: Re: [PATCH 1/5] pack-objects: make variable non-static
From: Jonathan Tan <jonathantanmy@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	hanyang.tony@bytedance.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:
> This patch appears to conflict with ds/path-walk, which wants to read
> the exclude_promisor_objects variable from outside of cmd_pack_objects()
> (but elsewhere within the builtin/pack-objects.c compilation unit).
> 
> Is this refactoring a necessary step, or just cleanup? If the former, it
> may be good for you and Stolee (CC'd) to work together to figure out how
> to eliminate the conflict from your two series. If the latter, it may be
> worth dropping this patch.
> 
> Thanks,
> Taylor

It's just cleanup. I've dropped this patch in my local copy but will
wait for reviews before sending the next one (probably not worth sending
it now since it's a relatively trivial change).

I've also looked briefly at ds/path-walk - will reply with a few
comments on that email thread.
