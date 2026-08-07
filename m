Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71440371880
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117747; cv=pass; b=X//6QX/1ZRSGekwFzUe3gnwpilat92nM6zIR5HZPsg1ZYGbFYg2nXqYQiCj+WwA8lBN7sMelzyF49Zi15FWQ9MtwS3Msu1neqFOyT46j/3Z7PsUQsavJHb5FSR3MgWNNgUp6s7jlVpcTW40j1SZeAvpMOSuHUQgC6OYWv9Pw1ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117747; c=relaxed/simple;
	bh=BmzdAWLXIORZyhluSp07kUY39SOdokHGd5u8bKvyALc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/pAIde2iqGylbIU6aWAYvbpOSsxqfWDtUr/lEthe6x+s4od2tNmx1lOwIx+f9uHSLSG9cPrVHU+XznkmJvJlsM5xe+bVnOLg0DDt3wKCNXOKm2AFBXyEABbvf3hK5yXU9DV6ScEo+FOsw7E2pY2m5bQwEiMF2NlCddhgKkIG58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwWNlJzm; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwWNlJzm"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6acc15016f1so2145557eaf.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786117745; cv=none;
        d=google.com; s=arc-20260327;
        b=f2DQnSi0/X50To6qbhr8XVJPxlCpHmpxFpa2Ngltwk6BT7pAHToqHGYSKyOIFxsCeO
         L7eIDL2Z+3lWRiQGCYRZCcpS9r/9Ju9l2t4YVtmhfCimv8MVBl78OYRtjKpwSf0C0eM/
         BVfcFeIyHe8uux8Ik2rDh64mGOyTdUvYZBeQDKfZ1qi/8viTHBN8Kqsi8aV/N/qe4qIW
         +C1wDBbS//Rf5g7ueYt0dEbuzcIW6psX5ZLdr2Sa9QQ5xeBAUiZBXy3SYTK9F8yn+6QT
         9z5pHpKX4tODD/XuW9N/Z+YTCR/rg/0uptvF6n7xDPI6xzFpa6H6nfl+VDO5+wjF9Pb0
         Q7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JjC3Fs1Phgg45Ozw7CR70bRaI8dgSm1l4cQ7ylYi9RA=;
        fh=6GtIQO80bQumahWgb2CI5Q8adPxEIwz8Zrvm9WY2c90=;
        b=DdkgW6V5KgVw37k4o3X7mv1CDXSOtiFPLSwGX+XnA0f8RjKKogz0uuWnjn8oXIN1V6
         dMTw0+eGtYI2EKs/nwW0k2JN+ItYQ//k6HeSjE0nxPVvSEV+xakJ7DVonmKPPAt+YE5X
         YUHfkeMR25reCkj6bCC7poqj3HcD7mZwxJw9DtHtgekdtIwZdQW29eZ0hiw53xhgeywu
         leUBbVkKYVV9u1poblmOnZHiGXMO3Z+AGLMNANZ6wIDXkqIvZUZVQLjAB/c7lNST9xpp
         2Z0iWZXrO3O1U6ePCP/qKnatlq0FpxsqptO3MnuAR9EgSgBYBFQpufOG4jSvTnUFSswN
         2JYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786117745; x=1786722545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JjC3Fs1Phgg45Ozw7CR70bRaI8dgSm1l4cQ7ylYi9RA=;
        b=pwWNlJzmc23UcEDcmXIfwR2wxTx2KpREaNo4DjkEtEXmtS1hroHWd0ObIeapWdmWWG
         LauA5Lb0AyaRGO/KoBbyrcLQETO19WWEV46+pWZ+U3nviH2qIARMmngNAtGfwO0OSLmt
         ubj5GldvItErdRBkIWVVoXk5h4A0t/uaCic9xNpkJNYU/RywA6MDbPF1O53dMrfYAv53
         Zf4bbowDlTWSdlJczZPKDn43LIE0zkIxD4LeIynDbFCcCKRtUQvgczGaq25pzssIK6sL
         1tiKLKuLqDvKHVB7Hx9zL6qMCk5hsuWXf0j9xBpo3LdP9i/WNWrW4dm3n0fiN3c1+TbP
         9klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117745; x=1786722545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjC3Fs1Phgg45Ozw7CR70bRaI8dgSm1l4cQ7ylYi9RA=;
        b=I5nhmpsSGQ/ShW2UxYo5yTiXO9h/N5InI6h4wd12B+drKPCTtK7azElXiIAkX5W4NE
         pZgMH/BTUdsBepLFHkNlhzUajHx/Rj/715vh6M/pXc1IwKp0YxGHnaWfURquJeobcbn5
         /YK9jU8GYlTj3ZQWtt4p3UOUr9lJjBiq/xkKlz3uzRhEyTPh868N/5XVZIy90LpU+LTm
         JJZQyJH9BtDaxf2dvOgH1IDZ1tWKS/RlRZmgGnzuFDwHfMHnX1LjjlNpXWhQmaPUe4gI
         B64y7M+bJw6mYwkl6NdSDzHCaNNm9CPmqk2Stxxapfqq1cdjKzI+luaXmYn9kLxHvaiS
         9YWA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8PS5OSw2xFGsI/0grzORDrYAIFi7+TDMxxNbEidS2ec7GO/sGJYhPLXVURfpXaor0N5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rrQPxBJGu1FxxkVbwIjyltApcBMF/te+IQ9ldnePtceL0Wjz
	1gS+A37Cy3pbAxjk1QzrF7apg8UOsCaUnuDTNaSGT8z4msCpJiHPmzlMKJuNBq7aO2LwVDly3z7
	/hWW+OIGP9Qbbo3veqfMUTNzD8AX5+WOkVg==
X-Gm-Gg: AR+sD12/L8zmgH88YlbxJ9iiJfMczwPjxEK6BQDdn75Qj5y9Iq+QYTOMf1nXWEsTX6l
	rDXK4R+R0WTHXpzzNF17rNTaHEqdClVvU5bkF3yjLBX/EXd4E0sTmMwmA9NFfaETbJ/sslxmPM3
	BJHZ2zrDQLRMkOuHpFXdNDEo7UebcgFjXb8FjF9K1iwCZD36xMygi5QZNcGUH58zZHV6u52IcKB
	sEwIjYjYJ55epAFPHYqeKwliE5rw3shHTPiVm+UTey38ZPoL5xvI+hWhl+lkR2w/GUuQqOmz8BN
	kaUxOuenFjzUK07K8Kz7WL0HYhf4rJphJLPcjvt7GOdD8b578kt/n+JM7a7qW+Cz13PHPK/KRbt
	BsCuNoW4YRIYZnVALI209tP0WWnBytKSa7gQxdfhH2Z8m2TOdZLYesrzn+NJZwWo=
X-Received: by 2002:a05:6820:2084:b0:6aa:a1e5:f596 with SMTP id
 006d021491bc7-6ae96c1005dmr11846351eaf.3.1786117744861; Fri, 07 Aug 2026
 08:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <490be76befc4689d463d472829c0271351b69a43.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BHLHGQxuG3gO+nCa-FPFyOFEU2rk_oxLtFjekLqENvQUw@mail.gmail.com> <CAL71e4Opn3u6qYG9xhhkB1qqYj9ZLk6_=fxznyFzSFbrh2BMTw@mail.gmail.com>
In-Reply-To: <CAL71e4Opn3u6qYG9xhhkB1qqYj9ZLk6_=fxznyFzSFbrh2BMTw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Aug 2026 08:48:52 -0700
X-Gm-Features: AUfX_mxg8K0JsnORoerqvD0Bj0sqYjJid-ZDZC6iBsyRWJTKKC_ai2GabvJY0N8
Message-ID: <CABPp-BHE2KwjcVc14heMhpBLz64eEQ8y6qu56vzXKN9VK12qzA@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] commit-reach: add trace2 instrumentation to paint_down_to_common()
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 5:34=E2=80=AFAM Kristofer Karlsson <krka@spotify.com=
> wrote:
>
> On Fri, 7 Aug 2026 at 05:03, Elijah Newren <newren@gmail.com> wrote:
> >
> > > Add a step counter and trace2_data_intmax() call so that the number
> > > of commits visited during the paint walk is observable via
> > > GIT_TRACE2_EVENT. This provides a way to measure the impact of
> > > future optimizations without relying on wall-clock benchmarks alone.
> >
> > Ooh, I like it.
>
> I will need to credit Stolee for this idea to count steps instead
> of measuring wall clock -- but I agree, it comes in very handy
> here.
>
> > > -       test_all_modes in_merge_bases_many
> > > +       test_all_modes in_merge_bases_many &&
> > > +       test_paint_down_steps 45 2 25 3
> > >  '
> >
> > Whoa, what?  <Digs around for a while.>  So, this is really confusing
> > at first to a reviewer; it makes me think you are testing that you've
> > already written the optimization and that some forms of commit-graphs
> > provide a speedup from your work that doesn't land until later in the
> > series.  It might help if you point out either in the commit message
> > or a comment here that this code is just relying on pre-existing
> > optimization where a min_generation is passed and --all is not passed.
> > (In contrast to below where --all is passed, so it has to dig deeper
> > with or without the commit graph).
>
> Yeah, the numbers are a bit hard to understand here -- I could
> add a comment saying that the min_generation floor optimization
> kicks in here and this is how it behaves for:
> no graph, full v2 graph, partial v2 graph, v1 graph
> (in that order)
>
> So it's not about the new optimization, it's adding these
> counters to existing graph tests.
>
> I am not sure what the best approach is here:
> skip these step-asserts for graphs that already use some other
> optimization (min_generation floor), add a test comment,
> or leave it as it is (confusing for reviewing now, but perhaps
> not as confusing long term?)

I think a short comment in the commit message about the new tests in
this commit triggering the existing min_generation optimization would
have dispelled my original misunderstanding and made the review
easier, and would thus be worthwhile to add for other reviewers or
future folks running across the commit.
