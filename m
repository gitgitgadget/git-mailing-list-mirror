Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476C54CF54
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113261; cv=pass; b=KX1TYiGXU3ST7I1tCagqFpw2VvnfcyMJgScnj3XsyvnRW31dvw+TrpESxH1hLtm2K6X7hg1W3GIY8ZBgO5vnk8nbumUB9u51WZVCA+eAzr4RMiPZP+3cPxGNLF2KBPJPKH5cA/HajO9XJJWcr9Tfx0BNpD4G2wxpFc0ZSqQZyEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113261; c=relaxed/simple;
	bh=62+NLEl+aQroiJ/a5iY6ckmaEiMvjMvqi7bqSlPYrPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTWD0CXjm1ZGCogJP9ZbyLx2O2JF0Q4CZYI/McYofBbVmcspH/hHq7ePFECkjcQ6Gxy4f2vIy881rw12OJYdhCbl0rs3zdE+OuX2rLklBiS5DcrRh1+1ZuiNDcVDZdUvtlD/Wm7c8p7WATe1RpRe+HxmfPv7ntX7NYjUZvNu82Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUEa1a3U; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUEa1a3U"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a67fa7a64eso503850a12.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 14:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790113246; cv=none;
        d=google.com; s=arc-20260327;
        b=h5aOBeNp1J0vPK0BGL8PbFMog7Fkzs08crJqMdqQjHItWpttRoLRkTMFR4GqILjJRs
         inTHpG/I1cVL+JwZ9DwCatBFc6f6Zdzhpd+KmW5JSqz+fdOBMaa/eQS6EPnR3z5fD0m7
         fZ4dU76of0bYCq72q8JrOKvX8Ca8nh3s11x2DjCiCa3MpUR33n8BnuHhgBHdt9d8FYqy
         H60HwFrRBb6NCVWIc9krkr8rU1SNSGr4K8ibF+ygZ66o0sqUBCkX2rHTzIsp2n0E7tUx
         pq6nZsxEnueDfaky+GBJNGfIgZmUg6h600Kiip7TU4dRzPwJH2KHBi9+Ej5eOD7WkEmP
         CEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FaiZ8uumRbQO7I09/gJxdT0glL1bpTPSNVUdo2EiHQA=;
        fh=3IiL5vZ5u7zvtPn7EVHV+VIrGaPdyWoHi6rw37Q169w=;
        b=pZf4EsB2Have5ebmpi0aftVkgcBOdtZNd1l7tVTeZgGx0Ivxi++5qNDpa6X1IDlZ0Q
         9ukLtMiKeB1kyGLX8JgQ9pe88T6XoXAtgYvlFZrjVLtSVJOT2LXcVaKyTm6Rd180YYlA
         AlR78oNQ0ofjimcOaqTGetYb1cOpLCzH2gNvd0FRGNmEV0DxmUMLZ4+sj8i3nCQDLTFQ
         HLgc+tN552Co9KBUuElqsoKy32gIeQAPvSYXf0t0G/TKdakQOLCZwsifbjAxZIiDoH/b
         DwQL5Q/TxMeZ8ZcaWQE+Zf7LIcaC8vc47TVaAdJbe5EQdlmLtKiKYq2WuTYnP+c8M7N+
         j3uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790113246; x=1790718046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FaiZ8uumRbQO7I09/gJxdT0glL1bpTPSNVUdo2EiHQA=;
        b=qUEa1a3UujMokgjHSiI6TupncHWcJcxYNDaSOFVeZlX3Q1eM58oF6iM4o1whO3ULrv
         2QSCQRaAQRalq8Hqqo5KsovklqM2LBb4z7lftauN/Pp5SoXOdazjlAANtQeEtFIhOcLD
         u6CDeQddJXYEguLjoGvBheemFiKcnclpxzlzcf+c3wsH4OX1SkJ+gePqXLn298CKDHy6
         yGAX1uOjlKGH9c2ULeF1X3ApUu4XWBvuX4AY1Lqkf6q+pQb43DVkotqA1ql49VqmA/tj
         ZTHvnhTR3wZhkGPl4sYPGk123SD+/m1ol3weS0zY3S7t682CkDk7EaDrsYFhDp19EJBl
         wczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790113246; x=1790718046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaiZ8uumRbQO7I09/gJxdT0glL1bpTPSNVUdo2EiHQA=;
        b=EzBhfx1bCa/iB+nXSy5G3lwRyyJK7LsuLwg0wNzRSnVrwOy4jWLKOVeCacXAu08/xP
         cxZJcilDURrU+htKbSabPLZgeLwLS/wc+UWdHpemJL1LZrcOHZQqYxrzR6jCKUKJ6+pX
         OrGCKjNBkCrHqjrlJROAEVlHmG8bX2eP49No7skkcP/8xXA0tE8b8nGAMuVUvgUiAUj9
         P9vlVGI+nQotA8/UOzHoQDZFq1dmNQyUshJCOxoDqJxlJMJofxDeWZJzEwr3mr/eX+KI
         lnHohW2v6UkzPaafC7uFT/GAmIUC1OnWbP/+DqpYgKv+kCEhfT3bkBofK7RF3eMTB9lz
         7jZg==
X-Forwarded-Encrypted: i=1; AKwUvBxJg89rE4S7dEd2aXzXbXzmass4IL4VQjRGFShDaVXZOlqrss73DyldtDfRXuDM7WpU/dk=@vger.kernel.org
X-Gm-Message-State: AFuF++livT/C4FiKMRLAOSFEJDbAxvME6ifE8nEA4D33RBzg+mdgylPe
	MLCQrXN1X+KOG4qGVWQm+gAqDF+uHPcjaMKGaJlmD2fsiUfLi9CayX8WAUXTKkBh6OlB3z8sjWP
	A7s9W7GzKHJiJ+GSf3OVUvmiej/p+NIA=
X-Gm-Gg: AYBFou08FfqIOOH+8swUHnor0dU/vzogN8hD1wN4gD1Qf79s/OchLj5/wX1YvXKZsci
	qsF91jRXfgamGGW+9WufLW3ESHfsobK9S/6RmuWUC6qEWDULT1zoCkIsAdcvXtyudtW/7ctDh7k
	R5qdq/WrPQWvH+8f1cKSHeHacUyUY0taMS9cW5TitAhwtrZVNj45BzoxsJhgd+NeVtHJP96Be1U
	2ERZUtqIEFX1y/CA46pEULCR2tPnjqKBh+SZV/iRrxFV47t7B5tSmzWnhbcf8c0nJTBjvIeI+ck
	ppFvglu46WDwRPSD5RRNw3WZFfBpu9J+pVmtZQZ+QbsaudbQBvTSTAk=
X-Received: by 2002:a05:6402:4020:b0:6a7:f25b:d281 with SMTP id
 4fb4d7f45d1cf-6aab3b05d33mr592438a12.13.1790113246241; Tue, 22 Sep 2026
 14:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com> <xmqqh5jhfbyw.fsf@gitster.g>
In-Reply-To: <xmqqh5jhfbyw.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 22 Sep 2026 23:40:09 +0200
X-Gm-Features: AcwNN1U9wXqjiiHn3ouVoKkrq2UOeoJIPGPzPMSENCLKIytMBQy8xhpvN7YCj1M
Message-ID: <CAHwyqnVwQRv3TKDtkZ2iAO3hNtOeC464qdv6GCxFYE_v-rLq6Q@mail.gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > I think the sparse checkout is irrelevant? It is unclear to me if this
> > is talking about a case where there are many branches in the remote
> > repository and only one of them was cloned, then adding a second remote
> > created a wildcard fetch refspec; or if there are intentionally lots of
> > remote tracking branches in the local repository and you don't want to
> > wait for them all to update. If it is the former then we should think
> > how we can improve the behavior of "git remote add" in a sparse
> > repository to prevent it adding a wildcard fetch refspec and instead
> > setup the new remote to fetch only the branch(es) we're interested in.
>
> Very good suggestions.  "Avoid wildcards" is easy, but designing a
> suitable alternative ("only the ones we are interested in") may be
> harder.
>
> Perhaps we want to have something similar in spirit to the
> "matching" mode 'git push' has, where the set of local branches we
> have defines the set of branches we are interested in?  That is,
> when 'remote.*.fetch' is configured to signal that special mode,
> 'git fetch' would:
>
>  - Find each local branch that has its '@{upstream}' set to a branch
>    at the remote we are fetching from.
>
>  - Fetch these branches at the remote that our local branches care
>    about.
>
> I said "in spirit" above, and I find it tempting to use ':' and '+:'
> as the special '<refspec>' to trigger this mode, to mimic what 'git
> push' does when using the local branches we have as the set of
> branches we care about.  But there are important differences:
>
>  (1) The correspondence between local and remote-tracking branches
>      is not one-to-one, as you can fork multiple local topics out
>      of the same upstream branch.  Maybe our 7 local branches build
>      on top of only 2 branches we fetch from the remote, for
>      example.
>
>  (2) Corollary.  Unlike the matching mode in 'git push' where local
>      branch 'B' is used to update branch 'B' at the remote (if it
>      exists), this new mode in 'git fetch' only uses local branches
>      as a guide to determine which branches to fetch from the
>      remote.  If our local branch 'B' builds on top of branch 'U' at
>      the remote, it is branch 'U' we fetch and store as the
>      'refs/remotes/R/U' remote-tracking branch, where 'R' is the
>      remote, and 'B' as the name does not get anywhere in the
>      picture.
>
> In other words, this is not "matching" at all, even though it takes
> inspiration from it.  I do not know what it should be called, but I
> think it would be a useful addition.

Very interesting idea! I would like to suggest that the default branch
of the upstream is always included as well, even if it's not the
upstream of any branch yet.

I run this on every repo I work with

    git branch --set-upstream-to=3Dupstream # upstream's default branch

and noticed on the shallow repo that it didn't work unless I first ran this

    git remote set-head upstream --auto

which was very annoying.



Harald
