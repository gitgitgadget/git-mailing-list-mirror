Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771561BF58
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953497; cv=none; b=An4udmFslOPQDY03mQyN06ckJxcsBVEfHjWNfWM0nOmaoSceykSbp7KAPjP8dblVpghmbAL00Xf9KcslzN7En39p2GUn2/gC08syR6v5983kgP86lp4EXN+COL8Zk1278ntBXPL5+SKqymevOCioHJ0fBEe95ipkA7neFbapqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953497; c=relaxed/simple;
	bh=inZ1r32kBFXM03PHRfiV4YwGsFVJRvNOHe1ik6uAyRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OovqOi9i6UxJ0uvKo915YKi03hjjueIn7Oryp+xfUdRE+dXfDfyjk8tbu2IpN1PI2n3TImvFEWz1gpQlNMR2Pje5dlYc7Y/Ma8wf5JvLaAztcyOkTrNQlWQqcXW/jgPxdGSv8kImXLXqfDXOOe4yeTNBUy2E/ieECIafvPNEpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so232568276.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953495; x=1729558295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inZ1r32kBFXM03PHRfiV4YwGsFVJRvNOHe1ik6uAyRY=;
        b=oFLR1sfB8iRFPXX9Pb1nHBJGHmmZKV8TZTGg6HymrC00SnNbcDq/ufRVVVz0aZ1VQq
         2WhgONIn+8tY3fYfcg01WIHNk7nKUtlUUfNjZAr9WCPXd2djuPAvZqkmSwg2z8BrCoTH
         UsB3Y+xnkCx1q+8UkTZl+92xsdebJqYUWohx2h0UXArGSXCJZnrXWlj3SPGMtjq7f5QP
         vx1/VqmW6sqyVo3h5PTSc9h+s7T59YzNb9EYji2FAQhf5UuE08WP/Q8VsgYoZu4vpycf
         5kygNUR/QzuCvkNo+joUns9I5tBtHz59CeuPemy9069SR8RXa1HGZJcRfmw1hC0FcZKb
         o2iw==
X-Gm-Message-State: AOJu0Yx+bHDtI8m4MWF/5K2ArOpcLlIk4mfKWbJkF+LYvk3Fz1I3Tsev
	OANkuxn/Y0daGTfT2OtIAQPiOyeSipxUp+MWiVzIhfDuXCu33Nf0/i560I4XS8sYgGolcP276Xm
	yhZx50fK6otkplMm6wRCgmSGyNcxy9Dun
X-Google-Smtp-Source: AGHT+IHYzRVkLZECg2xZ6ZYcfWgY4FZojrmHPGJFBj2yUeaq405FRcjIiiAhk+Py+40e4arM4OJB7Ib/bTib7FPpsyc=
X-Received: by 2002:a05:6902:2481:b0:e29:1627:d4d3 with SMTP id
 3f1490d57ef6-e2931bca748mr7197606276.41.1728953495188; Mon, 14 Oct 2024
 17:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014131346.3556163-1-asedeno@mit.edu> <Zw23K4zPN9e+JyNA@nand.local>
In-Reply-To: <Zw23K4zPN9e+JyNA@nand.local>
From: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date: Mon, 14 Oct 2024 20:51:19 -0400
Message-ID: <CAOO-Oz3eQ+fpWU3qLHtF5oCxj2ieoc6P4R+iKJTG3DoWrb6W3g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Restore support for older libcurl and fix some typos
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, sunshine@sunshineco.com, 
	asedeno@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 8:28=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
> On Mon, Oct 14, 2024 at 09:13:44AM -0400, Alejandro R. Sede=C3=B1o wrote:
> > This is presented as an alternative to the patch series from
> > brian m. carlson that bumps the minimum version of libcurl
> > to 7.61.0 [3].
>
> This conflicts with brian's series as you mention, so I haven't picked
> this one up in 'seen' yet.
>
> Could you summarize why you think this series is a better approach than
> what brian has posted? On its own, I do not understand the motivation.

It's a question of preserving compatibility vs ratcheting up minimum
requirements. Both have their merits. I sent in this patch set after
seeing some mild pushback to brian's series, just to present an
alternative. Maintaining compatibility with older versions can be a
burden to the project, though I think given this patch series, it's
not a very big one. Ratcheting up the minimum requirements can be a
burden to users stuck on (or choosing to try and support) older
platforms. At some point the burden on the project outweighs the
desire to support those older platforms. Where that tipping point is
is for the community to decide.

For my own personal purposes, I've worked around the issue by building
a newer libcurl to link git against, though brian's updates to the
perl minimum requirements will pose a more substantial problem for me
in the future.

-Alejandro
