Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59444209F2E
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751321695; cv=none; b=a89DzewirIhlMhMKUmiRB8r7dI3H4zcD2LfgaIUxKa3bIZCfq4ItKXtwhFt7r3J7X47HgagPFfp+0oVEhqONwOTsDgpt/pq0FSfwHi49xH+EzCUMq5u/tFMX04AxffqVYfs04TVGvWvY+hUuIY2N/gIBCbZgJ87ycqUZnIdT++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751321695; c=relaxed/simple;
	bh=xUeYKxQLHpP4VBTgKY59fj9X/Vdk6+loP4GlAHKCQGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tidlE7htPdeAjBuVcVvgdlO5V0caxZ5rP3Il1VEi6XIqD+O/6d8fhwAatQXBkw1lRIsZXRM3uPOa641Td5hsio0P+FNVS953EvCpDI4kSC1Qjs5x7zrI93We/jjgWIlbHeIpu39huuy57C9MAJNmwVqWEyrmz/YPHUDePwIf1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8bDx8Fb; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8bDx8Fb"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so3636893fac.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751321693; x=1751926493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xxus4/Cr4lDEx5rWSzloSe/jJwqqN7+2Ehyl2a1TWSU=;
        b=R8bDx8FbY/EtGuNAaU86MMIz8dwoU8iCVGafiQ35Ue0pzDOUvFVPRgjb7r26DMxVWh
         G60U8vby2MxKNfykVPBnlu89cX2GaXa4s6QzDt3votxnsB7CFz6tHII4aHvILBSeni2y
         26pM4RVTrHo6ToCsMc2fKcJtKYV1eow8ZiXQagQaqWJwdSXJiTk9ZCNe30BnqozaqwSZ
         kI3nS9P3tFLBOc4LgNSowgW9jwNMmWzUObxLzCzpIuXV23S9ihdRqJf2MM7G7xQgn1gE
         sq6ZZ31tlYT2lIbKp/8MA/G6pwq6A15VnzDAclTBjWPu7C2rNy/QZRyDAq57CNd1KkuW
         Bxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751321693; x=1751926493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxus4/Cr4lDEx5rWSzloSe/jJwqqN7+2Ehyl2a1TWSU=;
        b=VQjAi+60XoqfTv933ZhLNrWTMxM4hXN485E4db8G1Kuw1VxC7ZyUy/1w7grTskuGpU
         ot4mvBNLQbbFUYvOST3afh9jlrRkw+swVDi5JtL6pSvdy4ITR04Wj44CJhYZMc6FouiH
         w3XAQNJ59BFmhktWmm0I6/TcYcLHmhcAhW4j+WPK2x6Kg7bpAqJEYkTcNmcwlhfn5UAn
         +8Hcx/6h7V4EUxNzf2kZWKjAoiqJMTa3B045I41+PWH4J6j/gafZSdv/FOLUV/QsqcaE
         a3r2OZ8rpRT/24lnmrkTVEs+uHdv4Py+WCY5g+oJQ7ACb2//VOztbJujOKBPRM6jXOq2
         s9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4j/qv5EabgbrTWuO8i4aEQU02aONyNxaXO9yt6a+l6e2rln4ij+ptNbFmEuR7cRcNDBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYc4KtsoecrBMDIROcdzAXFmMZ6HGRHAH+069S/Z5BLRk/JrkP
	ywcQxTU90PGTpbZmw4m+hGQ9A+14WIJZqLGFrlSE7wV8V9dSb8+FvLBrhGsbqi2j9ywWcWrM3c4
	3sRTf1tNWaeKdeNPoSBjwZjvqO37oauE=
X-Gm-Gg: ASbGncsduOLHfh2Mgoho2f0yiLW5R3jYlYbIQKpGKe7ZVpzOJIPZF7MiM1Ay6cycp7H
	ymiEDKzmbb/89M+BfQVfaDZ3CxPoMBa0qzdsarbllOEJ2Q/DlxR8eJAHL1dlqYNQDrfnS2zz0gN
	svpLUhZLlaukDGpD1UWHdCAMR+uh5x7elvyAzKW2OiHg==
X-Google-Smtp-Source: AGHT+IH5orKrmIS2AQnUlvWdWa8Xs16D6mzcr+Pr1PidDrmYYbhOe5ghc4bPWyHPNpFJ+M8a8Iyd7sKh25CkAsBRWfo=
X-Received: by 2002:a05:6870:a448:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2efed4b9862mr10910085fac.12.1751321692771; Mon, 30 Jun 2025
 15:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com> <xmqqfrfh5mis.fsf@gitster.g>
In-Reply-To: <xmqqfrfh5mis.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Mon, 30 Jun 2025 15:14:43 -0700
X-Gm-Features: Ac12FXz5GcNc9I8CTCJa_bjFbl2abL77LK8BVV3Ix8Xhcc79JJl3tkxN3arbWNM
Message-ID: <CA+P7+xo29ibqM7uXNuWyNy39G1Lx=8+6p4BxvQw7=PR7PjVW8w@mail.gmail.com>
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:31=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > Commit c8009635785e ("fetch-pack, send-pack: clean up shallow oid
> > array", 2024-09-25) cleaned up the shallow oid array in cmd_send_pack,
> > but didn't clean up extra_have, which is still leaked at program exit.
> > I suspect the particular tests in t5539 don't trigger any additions to
> > the extra_have array, which explains why the tests can pass leak free
> > despite this gap.
> >
> > Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
> > I didn't check to see why the t5539 tests don't leak. This leak occured=
 for
> > me in a day-to-day run with my local git build that happened to still h=
ave
> > sanitizers enabled:
>
> The other side may tell you about objects you _cannot_ fetch from
> them, but if you have them, these objects can participate in the
> common ancestor discovery and reduce the size of the transfer.
>
> If the repository A you are pushing into use an alternate object
> store B (i.e., created by "git clone --reference B $URL A" to make A
> borrow from another local repository B) for example, the refs in
> that alternate B that point at objects not in the repository A are
> shown as "extra" objects.
>
> Perhaps we can have these tests push into such a repository?
>

I probably won't personally have time to work on extending these tests.

Thanks,
Jake

> > diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> > index c6e0e9d05186..61486e378cab 100644
> > --- a/builtin/send-pack.c
> > +++ b/builtin/send-pack.c
> > @@ -343,6 +343,7 @@ int cmd_send_pack(int argc,
> >       free_refs(remote_refs);
> >       free_refs(local_refs);
> >       refspec_clear(&rs);
> > +     oid_array_clear(&extra_have);
> >       oid_array_clear(&shallow);
> >       clear_cas_option(&cas);
> >       return ret;
>
> The change looks obviously correct.
>
> Thanks.
