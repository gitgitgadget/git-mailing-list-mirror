Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB7433D8
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544639; cv=none; b=jXCP5C+ChAougKdel8rbmj0pZm2+3WuXwzX214rgZhfLdvC6qg6D/ilJj2MjfyXIWqAFKlrXzd6JVtrhMmGx8cOP1rL1jML8vftukAG2ex4m2IplhxxZ3IZqLuMFnJ27hDLdptT9wze7YuSrYSq7NSFAgMjgf3pQmnLzmCnNYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544639; c=relaxed/simple;
	bh=xy6hPzgvIZgJeY93ZSUqyvUAbxN6CTzWiYRrIGg+XH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlCsLr0zL9E0zHwPyHdvzwlOXxKcZJSI8E0GF7nf669Ik5dJD0sxNqTBd5L6dsN3fw2J9ggt2qf1yqca4Wbd6IyHjBUonTekOZULOxujeq7BeHB7o0/aumwF10B8aw5QxbFqphKGdXBO/H3H5bYMPJ1e6aSuRXvH81dhQN21qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NLGIq7Xz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NLGIq7Xz"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso4448025276.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729544637; x=1730149437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AInEFZ7hfL7swv76M/DsYY1Gya1iHdJ1aDRKLI96r8=;
        b=NLGIq7XzNEREvL9nakYHPL0q0fI6zXOItShg+s/2UztqOnvGS2nYBOnYeLqsvu+vwU
         EM9Ekpl7n9JL7dVDZNOfKITh9oIsvssB+wfcyiw/XXYoTBsVCOqC3CPyIMhIJ9xytk/7
         19yqtltimP/X60l3xjJXmoRZq4f5iAjSVBA7pShW65AQvao3f7gawTvD20OE5ylVttNM
         ywcsCR9Ysig65n7o7eEFLYL4TpbC+vIFAeDBPKOF4mLcV6e5NIbaIxHNCO/+gPH7y1x4
         E2B9IXkuhCUTUXj6Yr+UAOuKSLtS84T1yAuhwDkQrBDR86KpJsbJc253GAwPh3dlMVvz
         j87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544637; x=1730149437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AInEFZ7hfL7swv76M/DsYY1Gya1iHdJ1aDRKLI96r8=;
        b=I+y6ZEaqP9TB2zKCC1cs85L5vcMx49+V9rgsepkinyrVgpntgXyEh1AArie9aMY2Qw
         HWzIcuu1lga/wAfEpSvEDmr7Tu6JfRTgGHecfCVgOUunruDZEyjdVK/k3tVybsDp2ixj
         HTM6MRIqx1rpSUe+GvUDr/fvUO54pPtmOxMSV9ETZ/WkBEh+vK4ReKDHAsgREL3Ijp/k
         PvCKY47eFFuCVDkqkLwCyC+W333XIdnGChjSgYdOIvgYQmWlbO98BZN2+S8TRC5DkWJm
         KViB18KqvjQ421MaX9uyy2gbPUxFEhzkqDBn+9c+vrYTSSaVeQU5aCS4dlRGAFc82MVs
         tdUQ==
X-Gm-Message-State: AOJu0YyCt1ZksXaIO8fXi/KoYU7yGJvyXOi6srVhFJ2n23xp5bD9tMNW
	LyD8nShBRiwDq6XalDDbK78djQkBITt7iLmF4ttcl92A699a9s3qUu9jWCqEtSo=
X-Google-Smtp-Source: AGHT+IEZlya4STZftp6ab8Gjnnmc8SUTTGzi5K5Nskhe+P1KYh1aA5/eESjXYqjLJrj1kHcK05MA7A==
X-Received: by 2002:a05:690c:6a05:b0:6e3:2c7c:3739 with SMTP id 00721157ae682-6e5bf9e59f3mr119070167b3.18.1729544636718;
        Mon, 21 Oct 2024 14:03:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a502fcsm8170207b3.36.2024.10.21.14.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:03:56 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:03:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/20] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <ZxbBuyhfq1sFKBIU@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>

On Mon, Oct 21, 2024 at 11:57:43AM +0200, Karthik Nayak wrote:
> The `packfile.c` file uses the global variable 'the_repository' extensively
> throughout the code. Let's remove all usecases of this, by modifying the
> required functions to accept a 'struct repository' instead. This is to clean up
> usage of global state.
>
> The first 18 patches are mostly passing a `struct repository` to each of the
> functions within `packfile.c` from other files. The last two patches move some
> global config variables and make them local. I'm not too well versed with this
> section of the code, so would be nice to get some eyes here.

I agree with the goal of this series, but I worry that as written it
will be quite disruptive to other topics on the list.

The standard way to avoid this disruption is to, for e.g. the first
change, do the following:

  - Introduce a new function repo_odb_pack_name() that takes in a
    'struct repository *', and rewrite odb_pack_name() in terms of it
    (passing 'the_repository' in as the argument).

  - Write a Coccinelle rule to replace all calls to odb_pack_name()
    with calls to repo_odb_pack_name().

  - Submit those patches without adjusting any non-obvious callers or
    ones that are not contained to a single compilation unit that you
    are already touching.

  - Wait until a new development cycle has begun, run spatch on the new
    rule to replace all other calls. Then optionally rename
    repo_odb_pack_name() to odb_pack_name().

I think Patrick (CC'd) has done one of these transitions recently, so
I'll defer to him in case I got any of the details wrong.

In the meantime, I'm going to hold this one out of seen as it may be
disruptive in the current state.

Thanks,
Taylor
