Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413B3C109D
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311945; cv=pass; b=VN8K7AL7qIvS4qo9DDfzDFrxjynr/b8OlZYNchVGeorbh2k+zG7/54IFsZL6jX+vsjp9mIRmYabpGOWOWlHJeWeH01L9LA7CVo8wczCy6MbxQd5DxxNH+Y69bG3ve5FzHE899XbcpAN9Xs9TUFPmFEgcQsFMdQpBr+8t0nSQ4lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311945; c=relaxed/simple;
	bh=MMu4RBg4bUdQ63BtHtAoAVUk1c19RwXZ3k91dz5SGt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4qRrNt+KYlOyCZuZb3BbW7kzddLjOv8xNYTfKZerDlqy1J38jZ9P8pdZjQVbQo+jYj3cXYvddEAgHOIL+JZjbT1VU7UG8qP8mAfJCN+75PuKpD9quGtSkpF5icOeHd4lL48GGa4GCr2NPAc/3nG4yXCzcq7zVIXGMA5aGB+1B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Fr25hlTD; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Fr25hlTD"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-662b95934dcso1179536d50.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782311942; cv=none;
        d=google.com; s=arc-20240605;
        b=NZpC/YQZ+aJufiTVHwjZCXmET7ZCRy64yDgAz+Fp6JW7flvSqi7S/KiL12aGhxBs2e
         MpvKUsmKevCDP521cm0wiXfdlf/kRHNl59zQLMImDx74IlltJT2fKHfkLdqdQ9H09L3N
         GAEO99jLPYIADQ6SVDzwQEuB1upXqxBw9ajioxN1zH3RBBTsWP7K+tERui/9S30NvjCY
         eco8rirq5Hg580JkNfQumeKTAr9exLHqm38OBcV3be+UsOPdCjalGLjXcJi+g/2MOQ/E
         gHL56l7NcdGIStokCpR7H4SJb17P/MhHF91acWG55O15ETM85xS1LwtLosDaDJA4YdSl
         MylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MMu4RBg4bUdQ63BtHtAoAVUk1c19RwXZ3k91dz5SGt4=;
        fh=7ErhVB2j18EYSFrdDT+PKT7tK87rs3hpgfkWvCFCWg4=;
        b=QJ8MvZhtX+tkyjotsI90O7SaAy0Um+D7d4cIiq1rUEVYqBPsIq3kXTQ+pR/ny+bHAh
         AiudYret4rNwnC7PDCSgNAL9mIm3f9gTVzS6g9Qxc0dE23wasXWVTxbkPQ2rgUz8YVrj
         YYunJgLndMqnOI1zVVHTBaYPT2cvPJkt/fu8mjp1zmihA8F/ykbikFBtLIBxBj9L2CRp
         6gZbre6ivyECU9LrzKIol3BWnYTilPlj3x9cmT82Beqk50e0CZn91dCOn/3y6l5u7IW4
         wtZLlwf4Ikj4vygHZPW+zCepqnMdvqjwtXa17EMgPwj/+jkKVNrFDy32ohC5HvNhoefe
         5z6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782311942; x=1782916742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MMu4RBg4bUdQ63BtHtAoAVUk1c19RwXZ3k91dz5SGt4=;
        b=Fr25hlTD7ArivpYB+4RzyrNWScOGPsQarnsS8mp5YcfLjdysW/dsIe7DIwknEVrII3
         YUpFC7tdcbr7qaSW1TMBbcM0W46GSF4JEQSeqyun7dZDugfaZl7fFsv4gOvdkCAVFLna
         moVQ1PUt8stWC09DsSEVywAFflTXGbbnJKBjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311942; x=1782916742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMu4RBg4bUdQ63BtHtAoAVUk1c19RwXZ3k91dz5SGt4=;
        b=doLd2W+BfAFSnB5F7X/jVrzmdzhHZfs+UuNjWvf7nKrdcCfJWwcNc+FRs1sg5qZmFI
         qK3nZuwHL5cdZooH6bDSsHhRWyQqozxGSJbZYESK7Ud/9JPu89pgszUn3OWo2QDxzLGR
         eVWG+MroCTnLI7yvm3o2op4Ug2kpYYpogUDwMTGKf7WNQiqlZXnlFIkwTu+CUI3Nmc0C
         ri38puQmbadfiSVPnMiIbx7luoGPXakPhUALtpQxZYK2+DwfyWg4nHzN6ux4Ggn+iYim
         TFXTvqO+l/mwkWaIdBT33MK1+OmlttmLz+sLg1aEFbMHMD86/7Hzud22fP5kC3SPNJNk
         jY5w==
X-Forwarded-Encrypted: i=1; AHgh+RpwAeSJs9LxAruBbOIhYJsPLnrXLBqiFp9wM+eJ0QnTZgTVNl77p8hEu80mJYHyKayaQwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGrXeveSd/+28TuZrgEj002+UF5ZLXkCyrGM/IBX8fuwc0FG5
	BL2iUdkevxii+TYwr18yXwShztLuq9G8IH34mosRoYZ2Rw5EoF5x0Idtke5aAqLPjZHrcz9FwVq
	Qec9q9yf4VyO+uN5k+bTwy3IZ1iB1HBiiCUxHtgQnWBBaj6irEoLo9NI=
X-Gm-Gg: AfdE7cllWjNN57jdJULmzLfNYXVcjE+rGuxqu7V1GD/7TFcJIok48MpFXx+LUIc6Zbs
	LbK7WFC7/Sb+q3e/a38sattVxHp/f9Y3CX5OzCJir4rcWfUN2MDxDG7SEOugfknR5m9K1E3jMm/
	aY1GFIFAcDGUfRngghkow3+3DbLfL3sCUn+2gAM9vuduPtQpYGhsS1YSEI0qNsPMfI3ZS15MtU9
	H97oStzCQq82AUECTRDm6nM5IliYQ8aWvSwQJ71nLFmXnr9l6I+cPI0tra1yu3NbS0y5Vea/w==
X-Received: by 2002:a05:690e:1685:b0:661:1669:b784 with SMTP id
 956f58d0204a3-66359e1b367mr6785823d50.10.1782311941877; Wed, 24 Jun 2026
 07:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com> <f24edd45f0af1da64513164d5d720fe70c1decff.1782303254.git.gitgitgadget@gmail.com>
 <19639ad3-2d16-4f3b-be79-138e00144ea3@gmail.com>
In-Reply-To: <19639ad3-2d16-4f3b-be79-138e00144ea3@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 24 Jun 2026 16:38:50 +0200
X-Gm-Features: AVVi8Ce19KRg3pwZwmmESGmPQfy0CpnnWyesowWGk-NwsxDEY5o8Ot37IIUYDdk
Message-ID: <CAL71e4N88H_VLd8nNfEVGqegbjT0bjQBgRdBN-kp1Y_U8ejJYg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] commit-reach: introduce struct paint_state with
 per-side counters
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 at 15:54, Derrick Stolee <stolee@gmail.com> wrote:
>
> I'm grateful to see these changes happening to the doc in real-
> time. I know it was extra work, but I'm grateful right now.
>
> Hopefully future historians will also benefit from this effort.

It was honestly not bad at all, and I agree it felt quite nice to
see how the doc naturally changed along with the implementation.

> > +static struct commit *paint_queue_get(struct paint_state *state)
> > +{
>
> Since we are going to make this a more complete termination
> condition, we may want to make that very explicit with a doc-
> comment. Something along the lines of "dequeue a commit when
> possible, but also signal termination of the walk when we
> conclude that no more merge bases will be discovered due to
> internal state."

Yes, I'll make sure to clean that part up more, maybe also
rename the function to be more descriptive.

> You mentioned in your cover letter how the min_generation value
> can add extra termination conditions. It may be a good idea to
> insert min_generation into the paint_queue struct and make it a
> termination condition for paint_queue_get(). If you consider this
> direction, then I'd make it a separate patch on top of this one
> _before_ adding the one-sided change. The extra tests that cover
> the exact number of walked commits can help to guarantee the same
> behavior, assuming that some of those tests check a non-zero
> min_generation input. (It may be good to add such trace tests in
> an earlier patch to help confidence in this case.)

I think I might wait with this - the patch series already feels
quite big, and I think it has a natural progression and finish now.
But I can definitely commit to following up later -- it would be a
smaller series that is easier to reason about, likely a single commit.

Thanks,
Kristofer
