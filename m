Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C763199920
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444869; cv=none; b=e9YzViSN1cO+bgeLxn3QP2LhhK94FamVEZRq6K3kxN/pfF2BNoqvhTa9vbJjDdj0a4usNsvnCWx4qtD0lTRImhvA6K3rtV3PAhxtNo99YXZcyrSWoOGseOLk/eDUGqo7bCsgWPemLa2gJYU7GkuK2eSI7PPAmBgOZ7L+MYRkmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444869; c=relaxed/simple;
	bh=DsR8nVmIGWTHM9v4ZPuR6Z2roXFK6OBAw8i8K+aRP3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0YvZHEPh6dTBWhpMi1sKQna+RPpZRz2Zhz5xXzcpDKgeJFIz7A3YWqY+/uM0YEqpef7YZ1hb6iMf0EkkuqDGchSUlvJovk7b4Dg7h2PCY0kQyAQ8Y1PTye5wI41AjsuFBn0EPYn2ZiP0Ts8fFkl23XE6Ec6j6891IDHvGtCwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHuKOr4N; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHuKOr4N"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d19d3c7208so192147a34.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 12:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771444867; x=1772049667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju56bbsuNKxldruL7wuVqQPxE1je4ADeELa3jfDDIh0=;
        b=LHuKOr4NFhHFBJ01704tMIv9BZRm7bg5BYm1qFrIGMGfkhu64JWTZMke0Z1nq3EKQS
         2QdPVrtS+bjTRYCFix73ND0G5mapuyvYFyAPWAEHLiMt0DDeiStkBQIm/Rp9HII7V4X5
         Gp9ZMBe7tpr5b5JYJ7GcpqYkAqLnlIjT+D+XFeLjfyGrS0TzsUuxjAXPOUz81PvlfCV+
         oIzE5TLCyKjpray9IoSGqKKhvhnwexdtqt6X+bEM3O+KMmUUTtXsLrzuHUb9g8mb5HoS
         HsP6P+pddlKAMd+Gtrp2H3r93mz22+ZedInf5toIVRE+aPs+xb2JVAa17Ueis2kd+KS4
         oe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771444867; x=1772049667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju56bbsuNKxldruL7wuVqQPxE1je4ADeELa3jfDDIh0=;
        b=Bl5WEkvQO1Y/fsHHOJvjXdYkXX9Y18QY5AmYUiCL7tgtrkSHid0qHpp5ofyy215VHf
         BTI9EnqxrcMAoXkViDZ7iFogavENsE5JQ42IZe0xIY3xfKdXFZBPiZ/gqyOgJuHwLLur
         9FzY0KsXXT8QuK/GSfHAyiV7cNu69OESvzNIyCV6wzow5H39u32j5xZZstxmR4/RtN1Y
         ENySB6hYpYiS8I3K94eERLxCdC0yc1CqlpembtDbljq0yNYTlMi5Bwr2Pqk6GnFjtnpt
         r+sq827MeDL1cDg1ecpHgN277O5WUpUQWXBgtQsjuOp5e+ba2OzaStPuoZmgSPh8F5Zf
         GYPw==
X-Gm-Message-State: AOJu0YyDEtWuCLJKBkoM04FqdIVIHWoVRnfPFmx/tj2or9pWkn7CDp7K
	e0ASBb5NiPaovfDFQPymb2AUeo/pBMZKjFRz9pqgbnhHL69BApdinIVaU/XyMg==
X-Gm-Gg: AZuq6aKh7HS3LHidMBrnySwBGdUrrXoCgl5h1fvpTyEpXl8Q5Vyo5qT8vpjekim2O3y
	Ml8tThiJpB0e0fP5UQN7b3Swnu9Q96WIKNStKl/5M8qyq8Uao532msaQz7a/fTrDkF9xkYJJx4E
	MJRL4f1ahKT6qSMzANROsFqAC3exFswRiJHS/PxRrajaLi5XXAPmYWR8CMM3WZa1gsx+GsZwIkh
	yL2ayTd4uwUAAp2NJm+NmXRdOkQkHZReajO5aY/+oGrXt/JnHYYGiQaomf5Ge+373Pt4TwyzF7V
	IlwniqQxEqXCqmzXcbpzTskZD57OQcjcpiqGfnuv0N79U1138TPYDhnKwCTpV8G3zVlI/4ElqXA
	CqBU9Gc7/e93VvD1vUnZZ2mm2VjyAThR1my3He6xBA+wdUWh+ClasmCkXwHIwUP9Fs11CMhbTvr
	AqsY4KBAdba3n4oIsk
X-Received: by 2002:a05:6820:160e:b0:662:b892:40c1 with SMTP id 006d021491bc7-679a742b704mr1598855eaf.52.1771444867202;
        Wed, 18 Feb 2026 12:01:07 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679aebf54f1sm256491eaf.5.2026.02.18.12.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:01:06 -0800 (PST)
Date: Wed, 18 Feb 2026 14:01:04 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] builtin/repo: collect largest inflated objects
Message-ID: <aZYV0o9Xp-v5IPL1@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260203221758.1164434-3-jltobler@gmail.com>
 <xmqqv7gdqwei.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7gdqwei.fsf@gitster.g>

On 26/02/03 02:45PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > The "structure" output for git-repo(1) shows the total inflated and disk
> > sizes of reachable objects in the repository, but doesn't show the size
> > of the largest individual objects. Since an individual object may be a
> > large contributor to the overall repository size, it is useful for users
> > to know the maximum size of individual objects.
> 
> Hmph.  It is true that a byte is worth the same amount of money no
> matter what object it is used to represent, but comparing the size
> of a commit object and the size of a blob object feels inherently
> meaningless to me.

I certainly agree that comparing max size values between the types
themselves is not particularly meaningfull. I do think though the max
size values by themselves provide insight into the extremes of the
repository.

> It all depends on what you are trying to learn out of the stats, but
> having many small blob objects that add up to 1GB and having medium
> number of medium sized tree objects that adds up to the same 1GB
> would give the same number in object_stats.inflated_sizes for both
> types, indicating that they are costing you about the same.  But the
> members in largest_objects for these types would be different,
> hinting (incorrectly) that one type may be costing more than the
> other.  Would that really tell us something useful, I have to
> wonder?

Ya the largest objects and inflated sizes you can not really gain any
insight regarding the distribution, but I think it still a good idea to
showcase the extremes. If I see the max size values are "normal", that
at least gives me some insight into the repository usage patterns.

> One thing that is related to "largest" that might be useful is how
> spiky size distribution is.  Among many medium sized blobs, if there
> is only a handful of super huge blobs, that is quite a notable thing
> to know (as opposed to the case where these super huge blobs are
> not so unusual).

I agree that showing a distribution here would be quite useful. This is
something I plan to explore in a followup series. :)

-Justin
