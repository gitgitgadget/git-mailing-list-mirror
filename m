Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3841DFD96
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025796; cv=pass; b=f/6uxJMZXI7/ZOHgdX/bzY4anKUCyGTwaId73wHnDcqYqX9yYYD5qnQb2Dsh37I9GEN5Y6vu/Qa/DLZ9KNxTb8FhQlf5ZrZxN8jfrZaMLrsF37UTLQ7XW8rT3xLFFk045Q9Vw6TdDnBQ3cCvWYAk4wjiOkT25FCbJzNpk+DUFMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025796; c=relaxed/simple;
	bh=0do5J6cG6u/sGatkKIfettf131ckm7XWSwBMFRDF7RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0oznhmHNagxlvNoKLcUYZMzEuHlLIKy9CGYz6fRrbSoo5OOqQQ85NoraVkLtJu8oJsNtAKt6XDfHeDCr4vi6ZvgA4DD+j8P5aeCL+B3ig1D1NT86XfiXpLcMARc5b6dcVVYRNWeaAgxqHmFGvKW4apUfkJScdCttHUYMNU5IOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF8P0IZg; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF8P0IZg"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-352e2c59264so189845a91.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769025793; cv=none;
        d=google.com; s=arc-20240605;
        b=O60PdVdDa7pzOcGdT5R+HKbdYSu/dcED+MPnwz8AXxkHqzQsGc1ftcmXp88+k3acu9
         H7rOilgf/OYWvZ3kQBbz0qVSUuEtdEqjoPmU8PogBd7kPhkDZu8HD5+1JXN9fzKRGXy0
         ptI4hP6mr83AIr0hfPf5GiQCamCxVUj5L7OsBFwEbM8B2/ytD5SAazq8Gd9NZB91WNt9
         vsSK5PVthPoTJ6zjGA/dON5+VNXVJCLHQnRmpp84Mc9vsX9R446ZTKotXUJX6sbLYYqU
         QvKcyjULPhmbmgAXEem8Iw5ORpriSAeimO16ol26ExXDdmMjBAeHLkDiq6ZLcjaAdVqW
         xqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4jtWahp8Lz4W77MSAwnOFantMHUX+Ta4sh++1GBFwyE=;
        fh=LPqsDF/TO9MwTWfm5Dnor+Fss0SGPFMDt4mLprwkfag=;
        b=MOcLy9/4zpBGxQ0lLZ7AExLuj5qZQ5T+8R7YDYyRB0Q3hmnM2lxxg5BefVH/b8/b7d
         D7UcXjU1m+al3UjUU5iy7kDwB8bwWpH2/t4YdQfCcTf8haJFjS1KAlFYOddStP5CTj/b
         Or+dXZcwtsCSs4xLPre7pGoKHG8UKpLD+bfswNMrPm8lCBS91NTGP1SqdLbaBSvrZjTz
         iKslEKSUW1IYv1N6z4w04eNZIeIxn2Ce2bWkf9Uj8+NqP950XK952LY6VHMXxiatr/uL
         Q8AqZkG9jh7QwFAJST+Pd2WpkcEFYQ9RQwBdfRfME8zr9KOZCRts/EBenU/g4s95e2Kv
         KajQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769025793; x=1769630593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jtWahp8Lz4W77MSAwnOFantMHUX+Ta4sh++1GBFwyE=;
        b=aF8P0IZg5BtouuBmC/JNkRdbwzAH3Qsue8SVsKBPBBUFmZNnRxZPYvdKli6q/ELP7o
         gpKVKmJGYXdy7EAlfPqIRZNjppcj2JI+6qefa2QCNL1ZKdPLqwM2/0yMMAccpJRyM0yI
         0MfjqvCA+M3JMO1jGth29Z75EHxE6MocuihhaEvoh4Kg+FhIXzPQNWmVc+mdjCFbVWwQ
         wpOpqlcxnG4pP6k/E/ApXZFvOdQOvkVw+TIQTjiicYJCxEAkGOrsl+YhTubpNOIbut29
         piA+JkE6ukcSV6nlXTZVcdbZBdT39yowcpCPTLk8iIda09CutGrrKanjeNSS9WyXRj1r
         vSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025793; x=1769630593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4jtWahp8Lz4W77MSAwnOFantMHUX+Ta4sh++1GBFwyE=;
        b=JWO9w48jyWXD5xxgVGCt25aUi4X2P+xyemmRF2fUj7swwAgIleQY1SxaINRhIA/n5w
         7g0V7zV+sB2fXHhoWifALKMcBTay3Vfq5Y/mjhT/I3CKKznsYy8ePC+TonWleYE48xXR
         AxlrtTAVJfQCtmr3KhgZJJT2X8YDcYPOLCgRsRSt3po2RAOK7eDTCFxHseOw3QoJ6FKV
         9ePSPDqvojfTJqWvPrIhTlFE3MdsKe6NKo1qr5wef7qLeb0vecky3k3LqJUKU+hHYwOH
         jy8CBwfXyv4qKgR9Szu8Npa5x+H19BUw0DZQSJqPML3gOjl5nPrBRC//2rA0pfaRqfZ7
         EMHg==
X-Forwarded-Encrypted: i=1; AJvYcCVqqbCtJ8i5XOGTTErGEk6XBsBadHs6BNz0Ckat/z1ya4dVrfMBFM1jpWduqGcXUHYHr8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZHh1oOJWXLCbKfAr6evPkbyfXEROgqUnKoft4W7GxiOAR714
	siAL7vSjPxJ8wKwUxCbSa/1H8KHSzfPzJrJYJuk2H/qX/SRA4tj/v9fHpixw8yfrnr8aM5lWo1R
	/z9CzSfMVdycGAqXeK8F4yhNtof+cCzY=
X-Gm-Gg: AZuq6aINkkolhgjrG6U4L7gF0TrXOc1GPy1WXnSs8GEbT+B5U1MZBUs0mP5wot0hN0C
	cOAg6YeQREjdr3sUxRnK8VZXt+gXhiDKAxFCgDYxSxBrqp/Y4OCA+nd62hfo3r56GVEaj0EE4un
	yzWrv0t9i7MhMjxomRpNB3pAPLW7ClS/Iyfd0GUwvgnAZk5oCYr8wO81P/AVm81BF1sFNZc08B+
	aLwiiBbd6rDszIRX+tdPq6szEGJ7oQwvDj/NB771tCNYZPsf7LPsO9EGUhup3ENGMcGHg7k8rlF
	BQLYcW+9XTbjSqVLdLKqZBSG9vhpAflAComcfeRHm4L+FnHGj9m+jgdP4Mb7PQSjdnmD4kjCuEr
	uqgw=
X-Received: by 2002:a17:90b:240e:b0:353:3934:1449 with SMTP id
 98e67ed59e1d1-3533934709amr153706a91.12.1769025793268; Wed, 21 Jan 2026
 12:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
 <xmqqldht2fgd.fsf@gitster.g> <CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
 <xmqq5x8w2t3o.fsf@gitster.g> <xmqq3440x8da.fsf@gitster.g> <xmqqy0lrx4l2.fsf@gitster.g>
 <adfdcc47-470a-4424-9268-31699decee16@free.fr> <xmqq8qdrvsnj.fsf@gitster.g>
In-Reply-To: <xmqq8qdrvsnj.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 21 Jan 2026 15:03:02 -0500
X-Gm-Features: AZwV_Qi8MklLzqZzZyNnbZoilevyXfr70orrxuxOfuF4SInmGCgWZbBweqLxlmE
Message-ID: <CALnO6CDGan9k7pfrHcNG09hVLCrvGrJv5=G2O3Wgp4AT2i6reg@mail.gmail.com>
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 11:26=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
>
> >> The original comes from f81a574f (doc: test linkgit macros for
> >> well-formedness, 2025-08-11); its author Cc'ed for better ideas.
> >>
> >
> > The initial motive for this script was to catch malformed linkgit
> > occurrences that were present in the docs: stray git-foo[1], without
> > the linkgit macro and misnamed gitlink:git-foo[1]. Not knowing what
> > would come next, the regex was coined very broad, with the assumed risk
> > of raising false positives.
> >
> > The issue here is in handling the ifdef macros which are block macros
> > and are more easily detected as such. I would reject preemtively lines
> > with '^ifn?def::' instead.
>
> Yup, that is much cleaner.  Thanks!

Thanks all. I always forget the documentation lint target. I'll try to
send a v3 this weekend, but travelling, so responses may be delayed.
