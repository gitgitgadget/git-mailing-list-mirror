Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E6137930
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776180; cv=none; b=eCMa0YFY8HOFTUFBHXzS5nFsx+XGTkYabLz5v5ev/TGpWJjd6LkpdDzHQGVyxtK5LQJuYPs0eCeH3qjZGmNhtyu542jjtJpx+hH5kFZQEWx/t1R30A6uabQyf5a/12LbMMvEafbhVmHXCb2Ku2Q07GNyJmlXGWuaOUp5m2N8b1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776180; c=relaxed/simple;
	bh=IfZbnyV2KcMeaKWsSEAGRNlQS8YWdoJGpPRG6qVAwNc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dd5caYhVlbPx6kIb2g+9UNejIEapTRnh8GFOL94ykTwS+BjSrwe2B+vl+W3VY+63OWDSG4TnIiwPs8UJ7cttocuAxxCg2dinbM+tBbiJYf9Gp5ZLHUXrhsXlDyHBODUA8KvFd7al7/NW48XJoldxqGhTFlzv2qs+TLd45hwrj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJsq7+jy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJsq7+jy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216405eea1fso16305275ad.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 12:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733776178; x=1734380978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f4KudUTtGu55XGeSuep4QGl1LQdyewF9aCamGHvAZfE=;
        b=fJsq7+jyWUErnQJmG3ow2bG7J+9HDYKgMHhiMg+QCR3OprolKkYqNP6eu2Iuu03pVp
         XT42yvXlNdPF+/9d4DYNe2XuGSEmXhFrxUdXBtUQJFr/nU/wyJA+n5GKxs6J3Dooajky
         X2Tzj0Y91GxoARnR/lwo1pTIGfVGnHOOb6csywYXOCWajyPeUEqVhnW/zPKcsPYK4C6y
         cF9cE7f8r/a1P1Ehn/sVfsWJzzPl3/QTrSb5Jl/0GqSv2W9Z61hAfFJfWm0+CuUYwXAz
         ZES6MoIrtpHJLrCNrMYhh81xYzs7DOd35Gg4zHdDzldKBpVAnHSCe/CuJ4yo4VGVbnEF
         8qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733776178; x=1734380978;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4KudUTtGu55XGeSuep4QGl1LQdyewF9aCamGHvAZfE=;
        b=S+JFptCAUo703bFfgYUVUL4fDfFPaIrLPIBgMA9YMwBpWnBAHTVuN+ULRN52LfkHL4
         m4uG113usQyYnTUavSOD+5mhKUqvVi1E9IPnyXeMGAj/blvX8fIeiEWe+pPWCpzUAeq0
         DH/kQAB7Tl3/pZefvnlyE37MybgGLa1ymeYmAV081zG2x+O+5PAs4smjNqkXNaz0Qknm
         Bhb5CZistNj1Zx+wfHN1Hvx61fZX6Zh3ZFyXVZurw0J3bkC+O9cnVbCLMY9S+e6QFx+P
         QF2hGQCXx6ro0NddXsNaoEfXmhv9eyjdOoHL1jFxWPMFFet+wTVz7pF06gftUAAfs+uo
         EeyA==
X-Forwarded-Encrypted: i=1; AJvYcCVqP8l35a9f7FvmKKqUCFVMvtCqEYYposCsNX+iExRKCuyNGuBObgMp8fGfD4IVdNyIxAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEqRmVId4I/tKDRb6vzvKLnmuseZ06XCeU9zQcLwISTqRXbq8
	Ww41eCYDZc4pixI3bLJfgJepvPp6QjTeHlkqKe44qpUVugBfeju3LNM2Q1uZ4TayLI1p+XMeCYl
	vOtxTmDfx+eEh9wkvN+0L/cJPSciSZw==
X-Google-Smtp-Source: AGHT+IHaK4mGJFGQI2fhWydvDqBaTtrugU4VKykxfWrlhdp3xSfQj5sqSEcP4Ew6SM0YzaF1pvTGyo9IizObQwlKvbIt
X-Received: from pjbqn14.prod.google.com ([2002:a17:90b:3d4e:b0:2ef:95f4:4619])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8e:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-2ef6965469cmr20572282a91.8.1733776178447;
 Mon, 09 Dec 2024 12:29:38 -0800 (PST)
Date: Mon,  9 Dec 2024 12:29:35 -0800
In-Reply-To: <xmqq4j3k70x7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209202935.799059-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/3] index-pack: commit tree during outgoing link check
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> >> > However, it is also possible for
> >> > the server to compute that it needs to send S and not O, and proceed
> >> > from there;
> >> 
> >> If O, C, and S have all identical trees, then wouldn't such a test
> >> work well?  At that point it does not matter which between O and C 
> >> the server bases its decision to send S but not S's tree on, no?
> >> 
> >> In any case, will queue.  Thanks.
> >
> > O has a different tree from C and S. I will add a note to clarify this.
> 
> No, that is not what I meant.  "If you arrange your test so that all
> three have the same tree, then would't the reason why such a test
> would not work you cited disappear and make this fix testable?" is
> what I wanted to ask.

Copying and pasting the diagram for reference:

 C   S
  \ /
   O

I looked into this and I don't think that making O, C, and S have the
same tree will make this fix testable. If they all had the same tree,
whether we check S's tree or not doesn't matter, since that tree is
already in a promisor pack (O and its tree was previously fetched from
the promisor remote, and thus is in a promisor pack). (We are checking
trees in order to repack them into promisor packs if necessary.)
