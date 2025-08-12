Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013F2D7391
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035888; cv=none; b=sKkmXvblMKohfOqwQmeZgz3bYxb7fOJ+IuPvAEBv9OkPxed3pws9pkGXn5By3tgDbCV/kPTOnbC1ONLdpvUyPzHLNwf5I9IGIIzRfxusyOjMjApkqRkzFuljgM1LQPXOpGCMmGonasj8ebiKOTf/gZ6cAb9WRCEGLMwTSskNa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035888; c=relaxed/simple;
	bh=aMXwI5Tb05Ozruxmf9LGhEKQva/ekDnhM1Vlc7Fbg3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnAGPGbAV9yNe2ZcJO+6RlgvKj+1XsjxusVQoDwlI9fiWqu26CnlVSfWhtkA88UsniBT52GS9jdWLAcR7D3D7zApRGyYYb4KX4Bl3Dv8wJAz0q5UJ6WkkobZW8M4MU/x8HZxkvewrfFDI+wiwaklpjRSyQz8UC0GM9TcRX/lq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dJlMupQC; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dJlMupQC"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso16737335ab.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1755035886; x=1755640686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=41BD9I2ToJiWg1Hcqit3muqxnWZstO2IWXbQoSGYgdA=;
        b=dJlMupQCRbIj7/qJWEpJ522w5V6uTtaHrJcXjTrG0XKgygSVflMrBhdppbftbtR2ld
         aIsUU8OhFW1LaazqXCwo/BcJaBShHwqfWfxsiWA+VwClz+U1ChWPZmRRgrif9bJUw7kB
         9LdlweQUKUw0BxL5GfA57bqW+sq703WFbR2U64/ISJKTeqvqZ40rZyvk6jp1jHUjhQQv
         7bLLTCASILVY3rtBLIoyb9O36f43ouaf5+eljxTGcliNDX1teUyCrOqgfDamGo2B2wV1
         O1fnnC+LjWr30+txq28utaVdqVtphG488/pDFkB2CMhWhXa+uTf6MrHbqUZKOub4tmfh
         ZA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035886; x=1755640686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41BD9I2ToJiWg1Hcqit3muqxnWZstO2IWXbQoSGYgdA=;
        b=c7TIquAn96qae/GTk15C9GanSNFlURDVUPWT9vm1Lk5Q/Kzt/BV2E+C+sK9x8tS92Y
         MhaatUytFasm53XhFEA0yxuwE7TqXX7VGMXKEtSSrjcqocVFKllbATGYT6XXPicMFlC5
         v0I1fbpC6bTgcvH8loceevfcaMfZRyb7z5rJxbgWPJuGRPRNaCUjYwxOTsbmWeIev7bX
         53bKqs77BBlhYaBkk8rV8d+s9O/rwOlen45lUj7z8tQnE4g5++b+UAm3Bv1VVZ5BSC4D
         PzD24vd+ubO5JAp7kpZTaIAXK/KuhzDQQ5U/wMa8JrPlF2WxktrMPM0POamGWX/18ZiN
         3DkQ==
X-Forwarded-Encrypted: i=1; AJvYcCULGHIR/C/hW5WgknFCbzrGeQ6pUXhjrHsSBx384EJ7ut6aTKgJMu5ppzySUGqJHIzx3d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHli7we5AQ2xRlKO6egYeuKz0Iva9CX1hK6NYdUhMM0xju3iHr
	KMHlkGqFY4kVL1SD8JP4CZin+x7Gyv4lWaAKN5ysA8s7V1KxL+Xogsxfyk94vAXHbcw=
X-Gm-Gg: ASbGnctbS9pVzO1ZvpJbvXxzzAm8Csgnea3RJzjWDX71YmhF9ohyy4DlGS1yaHIUP/X
	4n2yVwhruHHG+/GMCcmQSfRwX9l+U1XNrSeN0qst0BoWg00R6/sObp2pxQduTDqnY2IwViT8bMA
	e1Gtm9KNOQQ1JcE01LV6CqF3cFxK2ZfMy/l+LUuJWghXiwqX8y/a7L0TKPh5yWul6RkRNRbkfeA
	6/03VLFLjujFsOIeNkg6jRKZ5WJCqeFsYcN6rMJQEXkJw32lASZjhhJOqnFvPwPLkinTGjozSMA
	BZGjtxlBptgP1jZ3k9x6Ya5RTxpkqcYEheh7XXF06kigIx1a2sbhk2Uizc5sR+qgVCqabO64Oho
	+2OOrC4s47o7iOz01X6PsBv4zGUY8lylQZiEDWw2cC7cUJJEuQs7GfsUz+GsBVNIIPxx/cg==
X-Google-Smtp-Source: AGHT+IFDujax0PI9nTCnA+grgvVzw7hRb0g271ltcX10jw1/+l4scG+UmfC5nn7Vvd1hG5/P1VmIsw==
X-Received: by 2002:a05:6e02:19cb:b0:3e5:4b2e:3b02 with SMTP id e9e14a558f8ab-3e567260ed3mr12713655ab.0.1755035885918;
        Tue, 12 Aug 2025 14:58:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3e53e6f897csm39455265ab.37.2025.08.12.14.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:58:05 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/7] odb: track multi-pack-indices via their object
 sources
Message-ID: <aJu47MsB/69MG8Z3@nand.local>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
 <xmqqa54umwlb.fsf@gitster.g>
 <aIHoAiakZr5i2psM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIHoAiakZr5i2psM@pks.im>

On Thu, Jul 24, 2025 at 10:00:02AM +0200, Patrick Steinhardt wrote:
> On Wed, Jul 23, 2025 at 02:22:08PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > Changes in v2:
> > >   - Changed the base of this series. It is now built on top of
> > >     a30f80fde92 (The eighth batch, 2025-07-08) with "ps/object-store" at
> > >     841a03b4046 (odb: rename `read_object_with_reference()`, 2025-07-01)
> > >     and "tb/midx-avoid-cruft-packs" at 5ee86c273bf (repack: exclude
> > >     cruft pack(s) from the MIDX where possible, 2025-06-23) merged into
> > >     it.
> > >   - Re-explain the split between object databases and object sources
> > >     to help readers out a bit, given that this is a rather recent
> > >     change.
> > >   - Rename `struct odb_source::multi_pack_index` to `struct
> > >     odb_source::midx`.
> > >   - Fix some overly long lines when looping through the individual
> > >     sources.
> > >   - Drop the patch that guards re-loading MIDXs, as we already have the
> > >     guard via `packed_git_initialized`.
> > >   - Remove some while-at-it changes to make the diffs easier to read.
> > >   - Link to v1: https://lore.kernel.org/r/20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im
> >
> > Shall we mark the topic for 'next' now?
> >
> > We haven't seen any comments on this iteration.
>
> Almost all of the comments on the previous version were about style, so
> nothing significant has changed in this version except for a couple of
> renames and style fixes. Which means that I'm fine with the comments I
> got for v1, but I wouldn't mind waiting two or three more days until
> this gets merged down.

Sorry for dropping this off of my review queue -- I read the range-diff
and the new round looks good to me. I would, however, like to hear from
Stolee (CC'd) on some of the `--object-dir` behavior touched by this
series before merging.

Thanks,
Taylor
