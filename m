Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E423A4F3D
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582645; cv=pass; b=d2aAC1KM4OPzJd9TwVuTR1guQxK3L2CRxbW87yCgcJCVicXRg+ycYpcB9F40cN7nQ/qRx8xLs6aWP34u4PopyjDfxXcezlN/3nPwrpJZusgnEZvARQtLDZbjTTVrw6v5FF5Few6CPUMueEYkbJA4kZzoW3/HGD0R+YyjqxFkZ8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582645; c=relaxed/simple;
	bh=LBCrpwo1orrCRgq2ixohnMi7mHFm5bYFQzHF7VD4TSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3vjnqJMuCIvCp2VOA1AmkAF9oVmc6+lwq2+TnEVs1wqf5MH+RHacmah9H31Ng/rM2aapYUopIRf1Kn3BYCa/tSiKqAT6CoOxY/iB/bZ7UJTBMdFOiyFxfUCCwenlcuDZW1jF9ZF8BVGUzMqkohZytpMeWLqm2PienpUZas14vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frsp0X3z; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frsp0X3z"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-667b0ced2d3so11904960d50.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 14:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784582643; cv=none;
        d=google.com; s=arc-20260327;
        b=OqIzAApZqQJIx8UhPHeZPqU4maUf51MEuXmo5gqgYvUt5QhSsOkCkopYkqBQDKgE4h
         +kG97SWUjHB8vmwV8s5bjx2nMggT3bfsZLy318nRaC642vfeKjtzwp3TrE+9GY1wBqnT
         9ykZ5QVGbjaee/2/b/8WQXQd9g6iqZMmJePBTC32h17hevDtBdOZKh0lcy6v4d7gbdau
         QXrQiNeWLuK8LEz7dxsoX2FyUTs92ccBImJEm87+CWMcDLr5WmVz97ctFYfhwnBEj9ri
         2xEH9yCZFWq/a9skwPKrA91bBwwQe3UX0c3i1ey+kZ+7sBghjH+fmbdDZJI/osCPtjJW
         Q9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PdiTyRKJuFnHKnqhFi5g0nIjSQVLQHuzu8QAEFlk8g=;
        fh=uyKh0YuD0Zem4nCyO976Ua8t3UekMIQjq7TwH2jQTR8=;
        b=pjRfXfNZ3LqNqkjf+q57aFm4hMvFd6UU5bwetlL+bcQlP7MEp9P56xVfeFQgca8A85
         H4obFXDtDCmGs+1MM2guJqZxYbTN3Zg7d1KkCc/Z7tYplabLtZ+gvJmE2xXGFX/vCPvP
         sdioGqlXeJTunwQ/a4X7bc+6IQRqYdgYFY/k44VZa4NukM/+ExpD+evJIDNTVtuR/sPS
         SyuXjf6PX/LtP0cUNsDFlLo5aRQGF1HxKzJVhA9y7l7U4r/txmzP4gImb+wd63HNRCPF
         CcM7wpF0kZxVUgyCa00AO0BK/a4GG/HkDcad4d5HKqVOW5Pn8DWJrwx9fkYWPGhJ/46a
         IRiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784582643; x=1785187443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1PdiTyRKJuFnHKnqhFi5g0nIjSQVLQHuzu8QAEFlk8g=;
        b=frsp0X3zgGdKyw5wSc1Yn0X+0/firQcql7efsf3UGyIccNzDXPJqMlo3xM9sXo4sYz
         Kw8iU3Ujs8Gi02PeVWQEPtU8AMybK145CZmMhJAA+VTfpkTATzXd6HL6bGlXmPzCuOmI
         JWMRRPNRu1MKWR0QeU77cy7czkbceaGLjK+JhwcQ5I+Qf4pCiXP57HwrkO871Y6MoXg+
         3I5UctSFYIaanDN4XRkhbKBMja8OW7TD2ERFqzE3sxnsUr3PZ/x2WyKs9NS2dV8zPgTd
         KW+LBKanyTmFaz3QnBrSykx7BoGJn1G/pn0JsZqsG5U6SLpW/Tr/PdQNCj1VNgOY1e0i
         hgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784582643; x=1785187443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1PdiTyRKJuFnHKnqhFi5g0nIjSQVLQHuzu8QAEFlk8g=;
        b=e8ZVd5JzLoZEXsiEf3bLqXDxavdFwQH3tZzdJoI8unqwlm8eN7vuoTxMAGYBYbLFc7
         MVxYjyCkXz9pw2Icbx4wvjoEhrJ0hvQpiuyFoXcuyYXUXcGteZetKnaBmmqJl5Ub6x8q
         17qwJiZNycjbzc52YnQVrK8tr7bvy//a/pQ3cNhn7IhKY/WfsnuvwIslHsiyZOo+Qfy1
         nHc6vFHh9rhpdk9yJBksZLAIjqSJQ7f1rf9EO9udq51a/GljhKKXPhj9VPim9Mff9jeB
         SeeKUtUu8l7ExQF8hvdcPxAJ19Osmail3YAb+5lrYsXovEYeCf/ly1djNdBXFJDpMeBl
         veMg==
X-Gm-Message-State: AOJu0YzDFi5dbvED2mqZHm60Jzj/Qo8jfvCfTvp9X7kJJaE1OxU+/gs5
	L/oLYTThFko9erX/nEkfpLE4yMr3w55g54C75URKd5/+IMG65r+o04K2GOvB3R2husS1OXQIKQl
	fF1YU3wGm9kE6mwWOIpTUUcxxNzvrVHk=
X-Gm-Gg: AR+sD108zx7VozDS/mULthVYSSF3IHe6UZp3dppDoZ/+/U0+q1dyfEdx6S2IJbLeelZ
	LM8FrVTquGX5p1iBuAFaEmX0fgmdORzo89bT/ZtDlQ/KnVlypi28+2OLYKdQXiEUvQBEMsB44CT
	8z9qiO+dV3VcAzmZm9EoLBXgqJmgI0BHkeV5rzTA2Ah17pctkkXluub0aAD0+gZ8DPGk6psngFg
	Pr5t08PoJsRo9QdXCYINM4E0SDgdMWkdugACJvvlQFJPnrz/YKgTCvY63MA6X8nSEhBlfikdbdO
	l1oq0+ZIiGSNx5Ka
X-Received: by 2002:a05:690e:441c:b0:667:8b90:3566 with SMTP id
 956f58d0204a3-6683bd099e0mr2342238d50.88.1784582643470; Mon, 20 Jul 2026
 14:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFOYHZBTAGiugQVOJrc4kJQkuhcSDiT1ruim7A1+6EW1iKAUNQ@mail.gmail.com>
 <xmqq8q75izpk.fsf@gitster.g>
In-Reply-To: <xmqq8q75izpk.fsf@gitster.g>
From: Chris Packham <judge.packham@gmail.com>
Date: Tue, 21 Jul 2026 09:23:52 +1200
X-Gm-Features: AUfX_mwFOXeHrZOxDHx-sGZp_DXPdU_9id1cEnCli8JkmFo902QLaeMIgNlScLc
Message-ID: <CAFOYHZCFqcrG0Z8UdbYss=cTJRso3fjpxNsdqKKKKqhHJqibBQ@mail.gmail.com>
Subject: Re: import-zips
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 12:59=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Chris Packham <judge.packham@gmail.com> writes:
>
> > I wasn't sure if there would be any interest in taking the changes
> > back to git.git/contrib (or if the use of AI would rule that out).
> > Anyway it's there on my github page if anyone else needs it. If
> > someone wants me to turn the changes into a series for git.git I'm
> > happy to do that too.
>
> It is wonderful to hear that a piece of software that has long
> been abandonware now has someone who 'cares' much more than
> anyone who has touched the 'git.git' tree in years.
>

'Cares' is a bit strong. More like 'wanted to use it and had some
spare AI tokens'.

> I would rather remove unmaintained pieces of software from the
> 'contrib/' directory, and optionally replace them with a pointer
> to the location of a maintained fork.  So, no, I would not want
> to be a gatekeeper for that part of the 'contrib/' directory
> when I do not have a particular need, interest, or the
> expertise to properly maintain it, if I can avoid it.

Yep fair enough. I guess you can consider this a somewhat maintained
fork (as in I've updated it and used the result once). I'll see if any
other users appear.
