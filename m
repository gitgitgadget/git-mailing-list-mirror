Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65492145B11
	for <git@vger.kernel.org>; Wed, 13 May 2026 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640474; cv=none; b=KWo9+jjUJHQkvYQTZKGP+HIZiEeY4spaR6ZfnsMYUO5i0f8e7OSFl1gG9c7Ja/dZOc98zvX98kr2OjEPUPqaiAg3f/Y95cij7tEAJ6zwOmXFKAkNGlKT2xI3JNZhy3H8FTjBdaLwps/vLA0ghTK+X0c6F+2IqifL3OLx5ujOy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640474; c=relaxed/simple;
	bh=gYZIroZfuOkp6sfhoZxF1OAf+STuGEKfGgqG/ZPSQlw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:Mime-Version:
	 In-Reply-To; b=P+cAYhHs6mQ0Y+9FmqmrEa+K2RnMEnqtQr/Fl4dnzwwJqZh0n2O3UjI6OFpHHsEkQDX2h29RnceO9RW5i0pF1BkwKyGFunBdVOm1wyfobbDuCqavvXXiupOKU5twUZukd2cVFpeE1E5csrN/dCCj0v6uDwLrstDGgDwLZ8HZ+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-362e50b4641so3843643a91.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 19:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778640473; x=1779245273;
        h=in-reply-to:content-transfer-encoding:mime-version:from:subject:cc
         :to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u0VjmPB1kycl2ZIwL+HPs5tzdaciK62CWnABZGtsauI=;
        b=Cb8JyJI3qU9lWsR+oHsslbWpRUdNsvOicVK8KyfZTHKS/atgwm805A6KYUf/rUFnFr
         6EmByosULwDxq9Xjle9jLzvE7E8+abjY78cuYREFZQs3jQyiUNd+c3G6DYgGZJHW/8iC
         tFYRk8F6z0uHVVCf52Bt6y3nGSIdyTwll3l+/y5WKZcIlJdMOW/aknhpCbqEM2aGnyAD
         YHcNyGancyv7At4iZVPQzvOUZsz8CfNPsdB4vc0XZ2Fe2896fmqf98akcjCCzbJSC8zL
         PaufuiV/72uqg5CAK+Q4loTtnRUyJUkClOpDskCPfDC6JH/0ro2Kf7iKyLj4XQ07Cpv0
         9TDA==
X-Gm-Message-State: AOJu0YzziWd6YottK51a4GJWMhef+RkAjMSk+koBZQ/ikyJaRKTb9oL7
	pzi0nBlhhMp6+HBQatUljeKB/5HTk0Qp9IlvKctGenOKK4S1BhXm7XWunfLdtIlJ
X-Gm-Gg: Acq92OGzqthgOyXM7jqaHzC3a0kYAZCsO6l1TgRcH4VQ2OxD6T3EC8JQIpgRhmKtp6k
	CklAeUmVf0rfhdEfJvhqYR4SS5RGLh88qIyUQvmp9Nycq4Iw8URSvX9pJsBp6+tsrfeRadGYhDK
	jRlZ3Nd5g03w516OvWmTFqNdj0UNaFTtfrVObMwLhIxqQEHIJ2iZyZ7UnqwXapFwcIVETWw1JaF
	Cd49MFTQr2Gw5X52uoJ6FbSDkDFeStj0prK48LlQnEBEsdjmNo48Sx1HZnI8i7+tzPNPmaJtEgA
	8n3MJBhff7Y9rWJ0kcgozul6taALtZuvhQLeAEpTcgt+Vag8K2bWZj0mJHxI5V9gCCt12jxz66L
	6jz/UkNz/nF5qW8ojwR1MiF/enpOs7mdIEgCQbEVYW/qOLjpRnHstPs/Ib5yuuA8xpoj4fO3EW8
	D0LTKn5q6/qI3gH9YlbDXY5Oyps6GtB7IgFHsFb5NeAFePmA==
X-Received: by 2002:a17:90b:3a8e:b0:367:b819:2214 with SMTP id 98e67ed59e1d1-368f3d25578mr1625075a91.13.1778640472578;
        Tue, 12 May 2026 19:47:52 -0700 (PDT)
Received: from localhost ([218.33.109.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ede2007fsm1257864a91.2.2026.05.12.19.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 19:47:52 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 May 2026 10:47:48 +0800
Message-Id: <DIH7FB91JHU1.3OOTDQ6QEZZJZ@black-desk.cn>
To: <ps@pks.im>
Cc: <git@vger.kernel.org>, <gitster@pobox.com>,
 <kristofferhaugsbakk@fastmail.com>, <me@black-desk.cn>
Subject: Re: [PATCH v3 2/2] config: add "worktree" and "worktree/i"
 includeIf conditions
From: "Chen Linxuan" <me@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
In-Reply-To: <agLTO0amktCWMsiE@pks.im>

On Tue, 12 May 2026 09:14:03 +0200, Patrick Steinhardt wrote:
> On Fri, Apr 03, 2026 at 03:02:29PM +0800, Chen Linxuan via B4 Relay wrote=
:
> > ...
> > The implementation reuses the include_by_path() helper introduced in
> > the previous commit, passing the worktree path in place of the
> > gitdir.  The condition never matches in bare repositories (where
> > there is no worktree) or during early config reading (where no
> > repository is available).
>=20
> Right. This is because `repo_get_work_tree()` would return a NULL
> pointer in these cases, and `include_by_path()` exits early in that
> case.
>=20
> ...
>=20
> This whole listing here is the exact same as we have for the `gitdir`
> condition. Can we maybe deduplicate these into a common section?

Sure, will be updated in V4.

> ...
>
> Just because it was explicitly mentioned: we might also want to have a
> test that verifies this works with early-config parsing. We already have
> a similar test for "gitdir:" in "conditional include, early config
> reading".

As I wrote in the commit message, this is not going to work with
early-config parsing. I am working on the fix. But I am not quite
sure that this is a must-fix issue or not.

> And should we also have a "nongit" branch where we verify outside a
> repository?

Sure, will be added in V4.

Chen Linxuan
