Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60C1990C4
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724923; cv=none; b=s2Xfoed5KD75EfgUu0FVKw0avOveLKhj5XIEj/8gd2hK+11XdN5Ogatdty2yESahvdgQMinAkrQoOEUmObKViBDP2oN70upeQ1pLxDdqPNMcbbIHj8EzD49rzPVYWi+UJtKCN3P6bb0V6G8RhNKGGkHt6AX59HGNB2bQV8YLHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724923; c=relaxed/simple;
	bh=PJUuH0A/nbEPiNJyRRil4P5xH4YOgHEK1b9r+RT3WLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyA+mrELp+sfgxBUftDXYvdqEVPfa3fUb7D61SzTQvD4qrumsj/TRfbW+aZNKrzPDPY+5HtVGPEYlWe+L0JBVBTBlVgMqBymLcgSO5uesJ3dV+KjwrUExde8Vs1eJxoXiN3xcJ4e0PCmuM2J0hbyMWUDhW80Lx0KJX0rc4ZuaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwOXYlz5; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwOXYlz5"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-718078c7f53so152363a34.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 16:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729724920; x=1730329720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7L6ZBDuwH7iqqUmOzvNiN0EaIKqPDD19kAqDte8ZCU=;
        b=jwOXYlz5cEw216qwOUsT/ylXsyUtv+8seFqhICNBJuAOvLg9BDl79IEuOE/U7zcOI/
         JuAf1jEkbI3y4N+UoVhxeFQjurv4XIohWaArhxA1Hg/QK2N7Tr9gia8EZqNJRXv6p1H9
         k0BDihPU86jes/Zo25H2XJ3LNbBX5Y7SLtyiX/evx4HZakYBiA4KN/1IR0UxbIVcFcWh
         PkCKbbhUxswKf8REFwsVSFo/pMWvJ9zbY5eiq7XdRFfBUx9bUBjEMuHNlEtoWxwQJxx7
         OeXLqdX5sgsIidg605C2apMGpVFj6Ok6+cDbQ+T3kNgQEn/BwTo4zl4x84e26WfizXeW
         8xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729724920; x=1730329720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7L6ZBDuwH7iqqUmOzvNiN0EaIKqPDD19kAqDte8ZCU=;
        b=jhwV+umlaP18cGLbwxlOQuVXOLC9CZ8H4xs9sqs38POk2qIGN0BG+/jgfaUmBn6PnQ
         n79o/e386oExcJ8+Y3toN7x2UsfOMjRQnvZhG2LiYP2t6PEd0shC6xc85Cf+LyAVmDdF
         R3H4AMANRiTJchcbDfSjZ4nICOkPgimSUVB+mTnhaHApMbK2ohpzB/POm0Zb2fCtSGR/
         QXyGupklU/gheI4um4qbOLXyJjuOZYWCMjAtzJ/YXp2ypjHXVqVe4OmeMQoaaZrq7DoH
         sFYgLpzOWsKjNxHk2RHsLN24L6H/HE5Vu3lW3TTiBS2+Hovj6R/wPIdzfhtpRHyNvvKx
         DTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE/aUXk5AWaAUiGtUbsRVTmyl5o6MjpEFlAsBB0XRsDjaCVIjsMO4VEc4VeEql03dt5nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykb7MWraECoi1I/jSo16TIYaGOpXD+cZCcgmvvi82Jup63eXB3
	x8mA5GyyGpmzNqQIZ5zBAfoMNkIkfjmb9fZh2pJZ5YGJdYXrcrkv
X-Google-Smtp-Source: AGHT+IG1J5OEAO5qnCfAeXHhWkgkoGwdjlzryvoeyur1ftmjuvoxXMrIZxZkCwJ51+ilsXmb/pLzbQ==
X-Received: by 2002:a05:6830:7190:b0:709:41c4:6a5 with SMTP id 46e09a7af769-718588c0821mr56698a34.3.1729724920231;
        Wed, 23 Oct 2024 16:08:40 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb22187sm1912518a34.15.2024.10.23.16.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:08:39 -0700 (PDT)
Date: Wed, 23 Oct 2024 18:07:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2] CodingGuidelines: discourage arbitrary suffixes in
 function names
Message-ID: <vshoz6xw3d3kghi7lsag6ldike6pdphkjbst5afxbuvjeyprxd@e4ectkxbh4v7>
References: <20241021124145.636561-1-karthik.188@gmail.com>
 <20241023075706.1393147-1-karthik.188@gmail.com>
 <Zxld62svV9iDCcJJ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxld62svV9iDCcJJ@nand.local>

On 24/10/23 04:34PM, Taylor Blau wrote:
> On Wed, Oct 23, 2024 at 09:57:06AM +0200, Karthik Nayak wrote:
> > + - Function names should be self-explanatory, clearly reflecting their
> > +   purpose or behavior.
> > +
> > +   The '_1' suffix for function names has historically indicated:
> > +
> > +    - functions processing one of several elements that all need to be
> > +      handled similarly.
> > +
> > +    - recursive functions that need to be separated from a setup stage.
> > +
> > +   To maintain clarity and avoid confusion, such arbitrary suffixes are
> > +   discouraged, as they provide no meaningful insight into the function's
> > +   role.
> > +
> 
> I'm still not sold on the suggestion to discourage the use of '_1' in
> the future, so we may want to further qualify this statement with cases
> where it is OK (in the spirit of Patrick's "as long as this is loosely
> applied" comment from earlier).

When I fist encountered the use of the '_1' suffix, I was also not
immediately sure of the intent it was trying to communicate. If I
remember correctly, there are also existing uses that don't really fit
into the two examples mentioned above. One such use I found is
`handle_revision_arg_1()`[1] where it seems we are just more generally
factoring out a subset of the parent functions logic, but keeping the
function name mostly the same. If this is also a usecase, maybe we
should instead say something more generic along the lines of:

"A function suffixed with '_1' indicates that a subset of logic from its
corresponding parent function has been factored out and encapsulated in
a separate function."

Regarding whether its use should be discouraged, if the convention is
well understood and documented it probably isn't much of an issue, but
for newcomers it may be another source of confusion as its meaning is
not implicitly well understood. I do think its a good first step to
improve the documentation here though. :)

-Justin

[1] https://gitlab.com/gitlab-org/git/-/blob/fd3785337beb285ed7fd67ce6fc3d3bed2097b40/revision.c#L2176



