Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8747DD57
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841512; cv=pass; b=Ntjq6geIjJNiA8E4X4S/yr6YlLV+8RsNZcXr3yK1NL5cL45gRXsf2Zl0GhJgEhqQ3S8bsxo8ZNbX9OBbiq5LG/zRe+YqgIGh05116nNMIdbW2HKEjFNpXeh54i8guBPFDHBAzUVfFvlfYTZYnAAgoxZHkJob2WKeqKR+lS5DuW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841512; c=relaxed/simple;
	bh=4V8Og5f+xc5axG0xHdYOKeGJ/zj4anzysxFc8GKW0Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/yQyHwaBlpWnbDpETxNdFYkY1TEFYn761/1TIOktizqKW0e2/cRb2Ua4qsVl2kRt4r7wk7evzM53wWUGEaAHcfzqihLjgCgLW7iqNzAAfGBWZfPGeVy4e3XAWQO+pdNP48OpQskMsNhni7lXO1GliYp5u6z4r/hoNKgbMl4r/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j41w/CAw; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j41w/CAw"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-527e352a167so5678231cf.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 07:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787841507; cv=none;
        d=google.com; s=arc-20260327;
        b=QnCH4j/5Zp+vUQ7XVISDfzh2ddcG03NPQlsVjr20m6/IiUzgNDXALBgI+8ge9Ew/bL
         QRJ6SMuz2XSC0YVByhId8nTxPvKAyHIP5fO9Bf98hEF+tp9p+dp9J68hLxUgQSVQvxQv
         Uq0h7M5ZXLv6N3bXS02iX9U+bMynRMulCWr3EjO4Lmbi4/o61PQw9uXN+lfYEo0VHckf
         NlYPgqB24AleNTl1eK1yz+I30nwnxutZRusUBEVKxAQVqudNA+32+aoxxvFVLm1KgMO+
         VvuzpTx/onoObKcNyFcbpNua2zDLOJ4asjzhFBuTRA4VHdtpWowiv9xWemmN7Z7S1f3L
         QVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hXPzzAqr/elZ3K1TUsgSbJISAPNAjByDq/enOUochWo=;
        fh=K0RkxTYkEIZr99R5yJBvDxFVSR5mRlt7EY65liQZsvw=;
        b=D5g6Ko2M7P9qOF6zWFkQnuL6fdKeQOiExGp2Vg8M1/D0DgXqJUHuERmWK2r2RmrM6C
         ZXU3d7sfhP/6bCfY1I7yU1cPx1211wzPyPg1U5fMc92Z0fIWk11VSgGlQoRtUUbr9wSt
         8t6JHO/NeoKdfMmcYeZdLVIc6Be65JH/96ExFm4IExDpsVpPGvMZGsUtZy0oDH/RWFUJ
         QbVn1gQ7YRBgT/5ffq3azMXPS+cNCGDPRNJihjfBH+7D6DisbmlLHkW7HcGx77FFIyhY
         KGL1QlRVX/SHxqm0POWjnjJrJrqskL7D6jbe6YIcjZbug1E7+sh/6iooxnSV8lQH37s3
         wx1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787841507; x=1788446307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hXPzzAqr/elZ3K1TUsgSbJISAPNAjByDq/enOUochWo=;
        b=j41w/CAwVSum49/vX7lwplUMk9Dh3NYbLVn3m9VwDk17HScXKzjI523yNPoXqICQiG
         8V6UsYb/2Qf/sE9oq1FeAH4AeTqFnJNAqyoikduyfqb2N6NxUp2ps+TiN9vnWKnbtOz9
         r6rBz5s6vZNZSDtmBZdNgjAnSH0XQ6v3p3obeXJv1IM9tw1pAY9E89NktDz04xohABgG
         1guE/M762BL+jI1LSo0r8prtEgkhXJL5VClXFsr3e/sNnjdsLQyHXtClRLhAW6JMuC8J
         qHTwZv0PjIv90QftChEC9lPn01HWOw1+NsWbRhK8Yxk+cCdMZ78oM4fdOdypT4spgV56
         VS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841507; x=1788446307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXPzzAqr/elZ3K1TUsgSbJISAPNAjByDq/enOUochWo=;
        b=sb5jZsDMt1M25YZuya9MDjiCK9nclr8MDrg8mTa30VcrOb5pAZKzxImOFE6QDHIxrZ
         cFDAblHWG4ECPzsK2qldit3O9r4CCJEEj68vNthSmGEiPVw1gNPDyeUtvd0ZZMD3ACRB
         ZpZTxqllIjrX2kwXmCpfruE7hLALOjWF/6bhwM0M9GMMPSNHb3JB2WB4Hy+yRkKp2vsN
         dlKXXAhxEFM8hBZkiqKmkijuZeXPnve5UgGEsN+qAaOePYjF3nOrnwQzDzfuJMCU5SJ/
         SpmAxE6o+ZXl5/ip85rqB9wX5rSfUjCq+7WMXuY+ccV6PgDaodse/JCaM04XDP76nI4T
         uh7A==
X-Forwarded-Encrypted: i=1; AHgh+Rrvqcs4iRUd52cXXmPdcT5Xa6qHDIH969yJU+QeOOZYQNQWTapAqBLZLfVusQe7rNdA5nw=@vger.kernel.org
X-Gm-Message-State: AFuF++mtN73hrrzBhVPYtOoX534J8HteblD1bpvA21xLibuHZ/Aakcy+
	GU1YOWT+PeoZ/cXRPqPINpNOIsbvTIRhY+v37rlufDuiyMjPCmrja+SHHMRk0/xSxgrrNHkpmk6
	ce/57fg3n4QE6sYNcMB+CbDXWWw0ShTo=
X-Gm-Gg: AR+sD11In+f1QHF6u/60PVah8GHHkG2KfGtYhkO6vlOlfpHD20xZgyEhXS/fqr3hCmS
	DF7/Yoc0HPSDtRwZ+GwRcZC7Lr9SVBq5Dk+7RcIBElGIDttPOz3IgTjzrq7LSfbjX1IhVpVJcPU
	Z3uS8WpiDrflbdD39I1WGVuaU9VvlnmpJgYI5nWYKAZMM+uQ4i0a01cEbxtZA6TqLb6KuCvnjYP
	FwklUPkVC6jKJl4uY4mYV877QpYAR0hEPm6VIj7LpjjoVidxESnaHdxLCqZQ7NZAts4rl6aX9oA
	7rTaOA2PZXG4WVByppTxrY08SxAe95FYxQd5kxtLZqNqkEGwyotuP39A1z/ddQy1yDAdprs/ojT
	sgsUohjWbkaC3GCdYaoZX/+dqGBi5rXpfHA==
X-Received: by 2002:a05:6214:311a:b0:90c:4fdd:c6ef with SMTP id
 6a1803df08f44-90cc79cc99bmr179909646d6.15.1787841506542; Thu, 27 Aug 2026
 07:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
 <pull.2205.v3.git.1787344586470.gitgitgadget@gmail.com> <xmqq8q5zyvwd.fsf@gitster.g>
 <xmqq4ignyv1z.fsf@gitster.g>
In-Reply-To: <xmqq4ignyv1z.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Thu, 27 Aug 2026 23:38:15 +0900
X-Gm-Features: AcwNN1VHGadvcZhOKIkGecUELsCe5W__kus1Dunz51uLocsvh3eWBxWibTuZdQ8
Message-ID: <CAF5D8-vocLWba-rvKxy3WWB1ZHTh1+eRcRWiMqv0M-CX56Y71A@mail.gmail.com>
Subject: Re: [PATCH v3] worktree repair: detect relative path in .git file correctly
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 7:21=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Among these three, the last one obviously belongs here.  Leaving the
> > relative path relative was the reason why we wanted to add
> > read_gitfile_raw() in the first place.
> >
> > But moving the other two to here is a bit iffy.  The worktree repair
> > job used to call read_gitfile_gently(), which means it used to
> > depend on what the first two did for it, namely, to make the
> > relative path after "gitdir:" from the .git file relative to the
> > current process to make it usable, and to ensure that the directory
> > pointed at by .git is indeed a git directory.  Is it correct to drop
> > these from the caller, which now calls read_gitfile_raw() instead?
> >
> > IOW, I am not sure if the two functions are split correctly.  I
> > expected that the only two things read_gitfile_gently() would do
> > after read_gitfile_raw() are (1) upon error, jump to cleanup_return,
> > and (2) otherwise call strbuf_realpath().
>
> Actually, I take half of that back.  If we pretend the leading part
> of the "path", which could be absolute, the result will lose the
> relative-ness of the original.  Keeping the tweaking of the relative
> path in read_gitfile_gently() is reasonable.  As is_git_directory()
> needs to be called on a usable path, if the relative path tweaking
> cannot be done inside read_gitfile_raw(), it cannot check if the
> directory is is_git_directory(), either.
>
> So, the change to setup.c is fine as is.  I didn't look at the
> changes to worktree.c, though.

If we were to keep the call to `is_git_directory()` inside `read_gitfile_ra=
w()`,
it is necessary to calculate the absolute path of the candidate.
While it is possible to calculate the path in `read_gitfile_raw()`,
call `is_git_directory()`, and then discard the calculated path,
I felt it was wasteful to calculate the absolute path twice when
`read_gitfile_raw()` is called from `read_gitfile_gently()`.

From another perspective, while the function name `read_gitfile_*()`
suggests its role is simply to read the `.git` file, I felt that verifying
whether the resulting path is a valid git directory went beyond that
scope.

I understand the desire to minimize the functional differences
between `read_gitfile_raw()` and `read_gitfile_gently()`, but for the
reasons mentioned above, I have moved the check performed by
`is_git_directory()` to the caller of `read_gitfile_raw()` within worktree.=
c.

I have moved the `is_git_directory()` call to worktree.c so as not
to alter the behavior when a `.git` file points to a location other
than any git directory, but I didn't mention it in the commit message.

Are you concerned about the lack of explanation in the commit
message, or about the functional differences between
`read_gitfile_raw()` and `read_gitfile_gently()`?

Thanks,
--=20
Yoichi NAKAYAMA
