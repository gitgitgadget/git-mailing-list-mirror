Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A51D0426
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881546; cv=none; b=b1NBzjk+5Yacjfsttq/i1vIDOs8LR4G3AGZeLr0y0TiDM5dc+4fgYiW8PmlBpV3ezZcgKzfDBFskUhXE923ep1wWphXKdI8AUN5jppd7Ujsa9+ZQ6xHmKKusW2HRKP9nUzutLHEtqBrVdg6m4KVhoL5T7LJQ+np3H3DW2EoW034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881546; c=relaxed/simple;
	bh=cBXWcq3UZx/wr7EipZPjYqYmxROYiwgw3Tf3dn7Ydp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxFVoY4o0heMVRXJ0E4/j5Q4Z4u8oXtgUTaW1AN82+BdjSYMHTUFmOErwatUxMimAFpJn34s9qMrrGX5fBSfnd3IvllluN3ZgtwpBND2wnXDo8s96gNxRDCROsNQeP3Qu0AwDNYdxYb7oPwLzIJeetVnhE+/PxEtXPqQXxQRS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JGJJv0lk; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JGJJv0lk"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso6252334276.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727881544; x=1728486344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUNSrpvUsgE56ZohP/ymeEhgkLu1RiRl+w8m1ZoAfZg=;
        b=JGJJv0lkVS28kjIDkvdNmMDmnDMLFbJOTEFc0BE7QSMiGXUCZ9kd60Q/oiDx/6TVRc
         jPlhE/A2/1MH/7pE5BTgvNPzLmUxmXvw/cUTCCfy6ThsRepalprPyBPrwBB17NsyXVsj
         KTaFRypVYUrofLPs8nr+ZxVylAnUnhNB6bsBNjI8egANCb7EBMe74W/rllJ59xo8+KRX
         vTH2J1p3uRS/Y3Rfu/qCX02gHcsBw1n+R8W84PEWpgc5zkr1Jpzrem9+ErhjvI50/L+B
         B2iJnmXIPBBCkUdl4kaqsXwLhUC/k9wQV6vUBwzSndtJtHFt69qkp/uPoR0t7my0pTi/
         0+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881544; x=1728486344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUNSrpvUsgE56ZohP/ymeEhgkLu1RiRl+w8m1ZoAfZg=;
        b=jWyNJu2NdGj2Xf7ovA88luYnOrvVlVWKk2zZhnANTkImlQeVPLB/U9r40TMEmQ003X
         ngHiqnk9tWYvUqM6SFzRie9S5flcF2Y4HjDQMxdrHm2KgzNqzFzZDu5pQQnPADUQHz+8
         GPePsz5sTA6HW5azZ4PPRLYoOdAijDwsWC+J5vFFK/afXNGM5oW9hMkXw1lMtmkgN256
         VukMVCWmNo16tBwUuavriZnTnmG99MI9dC9CmR1Fn5fO1jFIrmc1nBv2lrooxKr+8CQ8
         ZnNIqvbkkXq/pW/xr6k3c+JX+FrCOr3Jj9pWIlA00yDdz1TvNvxenujUMB5XjX7RlgC1
         oqaQ==
X-Gm-Message-State: AOJu0Yw9y56ukS1RLXPuyin/5wSvdAht8aFnk170qpAC9QWY7jfOCNvD
	ONUfy55PVpj4zQKtne2igXsC8ZymDmzxcnHQUa9kacohN5Hth0qEkazOdnNafjP6FMbnuT6YzlF
	t6S4=
X-Google-Smtp-Source: AGHT+IFW9Y4qQY+sWYTsHSpFMOZGlc8/YL/prJhPTy0TinMxVJ/0Z82BGouqTVskDPd44zSwGOxkvQ==
X-Received: by 2002:a05:6902:2601:b0:e1f:fe35:6224 with SMTP id 3f1490d57ef6-e26381a3c5bmr3178025276.0.1727881544314;
        Wed, 02 Oct 2024 08:05:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e6c314f0sm3935744276.54.2024.10.02.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:05:43 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:05:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: mention the amlog in
 howto/maintain-git.txt
Message-ID: <Zv1hRnLO9TrIdd1O@nand.local>
References: <xmqqv7yd548i.fsf@gitster.g>
 <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
 <xmqq8qv84xkg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qv84xkg.fsf@gitster.g>

On Mon, Sep 30, 2024 at 02:54:23PM -0700, Junio C Hamano wrote:
> The "policy" part of the change may read like the following.
>
> Thanks.
>
>  Documentation/howto/maintain-git.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git c/Documentation/howto/maintain-git.txt w/Documentation/howto/maintain-git.txt
> index da31332f11..9b72d435e6 100644
> --- c/Documentation/howto/maintain-git.txt
> +++ w/Documentation/howto/maintain-git.txt
> @@ -35,6 +35,14 @@ The maintainer's Git time is spent on three activities.
>  The Policy
>  ----------
>
> +Because most of the lines of code in Git are written by individual
> +contributors, and contributions come in the form of e-mailed patches
> +published on the mailing list, the project maintains a mapping from
> +individual commits to the Message-Id of the e-mail that resulted in
> +the commit, to help tracking the origin of the changes.  The notes
> +in "refs/notes/amlog" are used for this purpose, and are published
> +along with the broken-out branches to the maintainer's repository.
> +
>  The policy on Integration is informally mentioned in "A Note
>  from the maintainer" message, which is periodically posted to
>  the mailing list after each feature release is made:

Thanks, this looks good to me, and I added it in the latest version of
this patch, with your Helped-by.

I moved this section to the end of the this section, not the beginning,
since it seems more important to first discuss the mechanics of topic
branches, next, seen, master, etc., before getting to the nuts and bolts
of the amlog ;-).

Thanks,
Taylor
