Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87B173320
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728253188; cv=none; b=c4MybYLDKLA2sGEzsTbTGtyRkZO2lPOyNmiyPQQrned/q/AFB2Kd1vCCNzabBT8fBW69+elxk4qXWD4/47jCYOElQH8bQabYolCUB0JCLHYTPml29W9DLnel+DDRtzCJWqm9urHhVSMItNjBAbcbejMoFXFnWmmk1iYaCG9CR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728253188; c=relaxed/simple;
	bh=ASNd66yu9kclyrJ8TKX6qD9f/uCGu7omi1G0QuXZZkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8nuhr3ZI1JPovGxPj/QYahirJlzz1sETLDp1yvETsBybm49PahBxg0FMe8O+goKonoM2Vv4BiIrIo/xKfCyduYxbmDE7D95Qdug3xCYKfl2h620GiG+3NYggcAW9C8Yu8PmQlzAemykkViVvWiKQOeIFKgs1myDXv57K2h3ia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb3d95ce6eso2846366d6.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 15:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728253185; x=1728857985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASNd66yu9kclyrJ8TKX6qD9f/uCGu7omi1G0QuXZZkU=;
        b=Iqlxkw16/iZDlRUwUSAo2k1AlsNTkuwCDuYnILrJkBJG7ONhxOobBlmETW47FCViL+
         /yneJLYkKoJw0Hdq8QJ29CoBwWLbrUghHPqNIu4GMCPvxb0l9kM8lStLGTy1Letko2jm
         xePB1C4B5/PJSDWaIgyHUR8qD8CX9y5A+qVEwMobGuf/PSs/lCt3cFa3FqNV8ARtV4G+
         K0id12EmH2ie1Omb4sEU2XSKLrBOue/jWYHuXjc3TIVPMBIehsTlxY8O+eQqfctcjaxl
         13jqi5BbFdwmbv9WdSfijHp2mX0L83FHgWwL+UYRFJIkJYsaMrgat8Qv3IyzB7yYKSPQ
         e1nw==
X-Gm-Message-State: AOJu0YyluvmG4b4KE9IMcglibYfiIupYgOOhCr5qT18PPH5OsB98F1kw
	+xvjb4onQHS7VHsUs/cRBH+deCXmQRw61lxNS1FBP4NI/ajTTNnuNSAvqrwEfFSpcHSSNFRaIsr
	Zdq5+xoAD4o594pwYbEvL4OCG5GU=
X-Google-Smtp-Source: AGHT+IEElDi5ao0WZ7Gd7hTBid8CgZ+nWJZ4bVn9frIhLQN/q732+CI8Z8Bo3UoeNw0+E4po306MRBsiHPnPXt4hPRU=
X-Received: by 2002:a05:6214:20cf:b0:6bf:6d90:c084 with SMTP id
 6a1803df08f44-6cb9a2f28acmr71342156d6.3.1728253185537; Sun, 06 Oct 2024
 15:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
 <CAPig+cTVbXVffSeyNAV3c0zuSUozY7giWtMw3GpHs+xVEpaNvA@mail.gmail.com> <gZ9_OcXpHKqABP0c_FH7EVpjzCD92RASyYoDkrhhrxzrbKvx5duIaXIrVOK45bmglyrLHrQ6SR4YVtMwU6BGqw1_TWs7rHk_lNderVONljY=@pm.me>
In-Reply-To: <gZ9_OcXpHKqABP0c_FH7EVpjzCD92RASyYoDkrhhrxzrbKvx5duIaXIrVOK45bmglyrLHrQ6SR4YVtMwU6BGqw1_TWs7rHk_lNderVONljY=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 18:19:34 -0400
Message-ID: <CAPig+cS06E1xjM6asqF9-5KSSgGaVQgF2_QdYSziSPJ-5mRSBg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 6:01=E2=80=AFPM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 00:11, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > Also, since you're touching infer_backlink(), see [1] which makes some
> > changes nearby.
> > [1]: https://lore.kernel.org/git/20240923075416.54289-1-ericsunshine@ch=
arter.net/
>
> Thanks for the heads up, what is the best way to move forward on this?
> Should I base my patch series on that topic branch or bring in that
> particular patch?

If that particular patch impacts your patch series in a way which
would require Junio (or any reviewer who wants to test your series) to
make non-trivial changes to resolve merge conflicts, then it would
probably be best to base your series atop that one (rather than
bringing that patch into your series). When composing the cover
material for your series, be sure to mention that you have based your
series atop that patch.

> > And you might be interested in [2] which may indicate that there are
> > some holes in the tests around worktrees which might need filling.
> > (Since your patches are whitespace-damaged, I haven't checked whether
> > your series succeeds or fails in the way the series to which [2] is a
> > response fails.)
> > [2]: https://lore.kernel.org/git/CAPig+cQXFy=3DxPVpoSq6Wq0pxMRCjS=3DWbk=
gdO+3LySPX=3Dq0nPCw@mail.gmail.com/
>
> I just ran through the scenarios you described and everything works as
> you would expect. This is because internally the code handles both
> absolute and relative paths, and the worktree.path has been updated to
> always be the absolute path. I will make this clear when I rewrite that
> patch's commit message.

Thanks.
