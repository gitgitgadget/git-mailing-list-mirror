Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31E3CF1FC
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.202
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567256; cv=pass; b=JlweXvxiuuY6Rutp17BAeP8OS5TcHwpKeLqedjQ40WpikZQ67er4mCNKwcNrXtE7YamJtvwqB4rn9F1Mcz+/N955eb2hR3sLAfDaelP0JqPDMpLzoxd1bfWcbvMJjz/AxXpvwe8Uf6N/euOtNCEJ7KWcIHb2OIeq+JUWyZXoL/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567256; c=relaxed/simple;
	bh=vKW5vbiE+eFE38N9MvgUTpjWsIenMBiENMb168kh7fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTLshEs4TqG0ejOhnVh9ksP1belcyNhscoTNrJ5/Bz29itFslecR5DAZEMCFZIcbk4uriAAsV/3kinmH38L3bUsy/+iRrOgb05vnl/A1bDr/HQRXLGu7PaqgCuDOivj382FeS6/4ZpuWFmjMghtlbkDp/psiTb66u26GmBhwQaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4+WhyJx; arc=pass smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4+WhyJx"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4fbb45fdb46so13588b6e.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 10:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791567254; cv=none;
        d=google.com; s=arc-20260327;
        b=FY2QjeXmjLRebY0J4xJlVsPv2Msm8ErR8RM+XJs0HM7ogck2TDXhgNtUgROBP7rgow
         nmNLagzegEvfGJEjKtfhLlFhCQwB6J/1CahRkgxA2AJ1iz+evHyJLRr6b30JelPAZmhQ
         lCO5LpxEkfaFmgtTdaoFQNvs9F+YNhIP5jxwS1dVk841KLu40ZBLdWnAAOdKdrrHyZMi
         S5QQj0VaX9tMmFh8MR47DnAuEYVphbDmBOlHXKlaN6aV9ZVhFSu+uSzHrdfhCLbHBXiF
         HH7/tIea4zXF8DNt4XonVvpMXSbe18YIdnXyv98DqV6AaPkUFnKbO0DvSz17YNfxrOY7
         HWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUoKWSOV/sXsW0hLz7CTB+tZUCxVnk5qeB8hRQ+43Bo=;
        fh=XdZeZrm5XFOwptHYry2PaZjcLyVLOgjRLTIeygiQVVA=;
        b=fFu6ZEB6pWEXRibrBckzed8nATHPQPbUf6lUbaP/+cOTSZUr1/vJS7O74L42gfgin6
         rTUXIct/8UCop78PSAfGoQhN1VvxrXuHktNc45njxgzgH+cKydYdGMbeQZJpmZ8spxzT
         i+Z2ZVrrpOzalpzcSDtFBv03ZqZJTsupXElzMyXTHWwa954CnNHtlMvBdIrzwYBaQM/V
         DlwdH62g32zk+LaVLqFRIy2ui0COwMw5f5EN5E7Z7Ivt0Rg3wDrg4cdnRPbzNnf8sQmc
         0pE5p/MVP5oy6Ut4on+keUk4UY+mSDYIW5aviLa8D0WBx5OcDzc6W9/Ond+BzV+Dt8zP
         t5oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791567254; x=1792172054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UUoKWSOV/sXsW0hLz7CTB+tZUCxVnk5qeB8hRQ+43Bo=;
        b=H4+WhyJxKFN+bKJhUWu7KYitZbjNBpVOLfJVrrZCbzzLHpMe31Jo2ha9S3UEH8HE30
         P702fmQQeN/3jArGIEBOlFBbYryszwprRkt33smebs9p8tgsi46vltAqLHw6f2WAC96z
         VRZN2ciF7x9hev747PpTSUl2kGuil/uuGi4DlA4Du6vsRZ4RDu3AH9xO3L6EAXuCUmln
         78n/s+tJWuF7gvPxPGHeCMTKcbN4lxEGqrMkLJqTb3rHlLJ4iZ97YvlcpjTt31mokQKD
         RgPj8zxaN4Bxd9dEkRCsX5zUJIhteZMTnBg08CYwDakOqEIZeIBu6YYhSKQ7yS6zzyCJ
         aKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791567254; x=1792172054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUoKWSOV/sXsW0hLz7CTB+tZUCxVnk5qeB8hRQ+43Bo=;
        b=i8z7IySSdhISGBuwVeJRTHlKpauleoMfx0J8eRtMdp+CwXYd7usq4JhpSCn+l6Wp8y
         blq7l16PnvsiooaouHmPgSql+dg+BMlHA9A05mZBr1c861+KoTUO5IjjObMxz52myzoE
         i9gQlb161F00ivW16v3r7+3jWkC/qaYWcXVWwS6ERI37KlQ5ijKhVVZBHOErt84yLRzx
         yQFLW/WK6N0JXezC8Gq49Cp9B9K34hCau2dlr8Yhk0G1EThtkEQVFkGGqNE+PaNBWiIP
         xwV3lCxQMAEnNiyzpoGBxZCKgWw9LxGtUH9KqxskJRJG3A0lNDsu67kfZl1EgfLlCg9S
         Hjsw==
X-Forwarded-Encrypted: i=1; AKwUvBxnWOL3pCyJZgJL1NWJm3hfog2DgDvLYxPFMgvssSQ5F+aPXj9W/+uhTqlFdWOVIAk4jNU=@vger.kernel.org
X-Gm-Message-State: AFuF++kopN8qTkdDOoy1owEtKnFRSGJZrjVNKqmBIHPWs612qayIyC8h
	fAKCWb6UVpfRLrzWVYcJCY8Ioojho50NVDK32M74T0o5cIdPkZ3cmjx2mSzH5QeT6BOruynI4rK
	gJNg5jwTBcB3fJjcj3glSj3FI4Scc/vsQAr2gtGAsRg==
X-Gm-Gg: AYBFou0ZplZCPLnuD1taBKTTF+4L6n7PaORGzAb+c0/1c8dSGKv/gODse4v87RUuoPM
	2Sc8LwVodOhfmwytVdqHR01gYkdm9tpC/sZ+tEtZESMmhjoqKgQ4fB9GsdWmhEZWD692L6wR/XQ
	oXJk3GruV+RRFT0hOc5GoH4tHZgXNTk2+CVi3zsbrTSd7PPHlrU+NL3/veb3jIi6O2emBu7cEaU
	FD3FOBE5nohe5S28LlUHStubaW7KaH4TNL3v+rKL5VNqqbVKM45NgWmR3Ex6+SASvlLl1fen4ba
	Tz4dW4/4UY3uu46xbSh7l85n6nu5DVTJLfns07SO0f2El4pW3ToYPKTQZXE7DznL9ZQ2cWnxw9Y
	7kl++KJHDR/eM
X-Received: by 2002:a05:6808:4fd4:b0:4e4:627a:e0a5 with SMTP id
 5614622812f47-50c56deebd0mr2013124b6e.40.1791567252892; Fri, 09 Oct 2026
 10:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com>
 <asNKZpxiuFhVkVQd@pks.im> <xmqqbj96g6zj.fsf@gitster.g>
In-Reply-To: <xmqqbj96g6zj.fsf@gitster.g>
From: Sphinx <sphinx9692@gmail.com>
Date: Fri, 9 Oct 2026 23:04:01 +0530
X-Gm-Features: AclHuK9CgGz0AADHnhtCD78mUDJu3m1Rgtj6O0_w4h25t1D6q54lr602Sv6rmO8
Message-ID: <CALfz8Qx+BMNqQsV0tVTFDQ++vkZ3NCLnN2Wt+KUSNDBRSJ6Prw@mail.gmail.com>
Subject: Re: Question: behavior when reverting a commit from a shallow clone
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you both. I wanted to follow up with a slightly more concrete
framing of what a safeguard could look like, in case it is useful as
a starting point.

Git already tracks shallow boundary commits in .git/shallow, so
detection is possible at the point where a destructive operation is
about to be applied to one. A minimal version of this safeguard
could look like:

  - Before executing git revert (and maybe git commit --amend)
    on a commit OID, check whether that OID appears in .git/shallow.
  - If it does, refuse by default with a message explaining that the
    commit is a shallow boundary and suggesting either
    --allow-shallow-boundary to proceed or git fetch --unshallow
    to restore full history before retrying.

Refusing rather than just warning seems appropriate given that, as
Patrick noted, the overwhelming majority of such operations are
unintentional.

I am happy to attempt a patch for git revert as a starting point
if this direction seems worth pursuing. Let me know if there are
constraints or prior discussions I should be aware of before doing so.

Thanks


On Tue, Oct 6, 2026 at 9:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Yeah, this can indeed be surprising behaviour. The reason for it is tha=
t
> > in a shallow clone, we rewrite the boundary commit (so in your case B)
> > so that it doesn't have any parents anymore. It thus looks like just
> > another root commit that has added all files in a single go. And the
> > consequence of that is that reverting it will then delete everything.
> >
> > Now arguably, Git could be improved here. We just recently had a simila=
r
> > discussion around maybe forbidding to "git commit --amend" such a
> > shallow commit. Your scenario is a second one where Git should probably
> > at least warn about what's happening.
> >
> > Arguably we should even completely refuse editing such a shallow commit
> > by default. I would guess that in 99% of all the cases where a user doe=
s
> > it it's unintended. And for the 1% where it's actually intended we coul=
d
> > give users a way to override this safeguard.
>
> Yeah, I think that line of thinking is going in the right direction.
>
> It is not surprising that these non-core features (read: as opposed
> to really core features that were already considered mature even
> back in Git 1.5.3) that had many years to mature still has rough
> edges even today around corners that practicaly nobody has touched,
> and we should not be afraid to round them further.
>
> > I wouldn't warn about an empty tree in general. But editing a commit
> > that is a shallow boundary is something that I'd agree Git should warn
> > about, if not even refuse by default.
>
> Yes.  Committing an empty tree, whether at the beginning of a
> project or in the middle of a project after you fed up with too many
> bugs in your early attempts and want to start clean, is a perfectly
> normal, if wasteful, thing to do.
>
> Thanks.
