Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D82EEE7E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100574; cv=pass; b=T1ysELXF5+6V+xDVK7O+/haNRdKyZ9gAo2uiH51spw6Xf8HIb/P914ZqhD5goiRLS7c20cx+HUPnblQT1hZLKKob+y9w/CdScYTat8jTAHoWPQb/BCARzQvUOyYFXZMZhN1MMtX2dfuO0Hup10kXjkFNaZT8XnOh+r52WrkR2dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100574; c=relaxed/simple;
	bh=8EZ7vt6TN7KAFpVDuD7AxisY/02tMcWoqxVRLiQR4w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2OsVnLg5u0Z1Gd0a5g4oueWIL4f3yFAUNPL08v9tw+g+3vl1foL5l9gnA2/JG1JjD7faurjZzAUOxcuv5QvbMIJK7nI7TWEl7cyetB3GHFoP0CrL/vbrHJsEppkFE3FvVxQDAXSVmlJMGTfvfS3lbeuMYSq2UJC8yI6obftf+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ1skAZV; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ1skAZV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf27856f9cso40596985ad.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 04:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786100572; cv=none;
        d=google.com; s=arc-20260327;
        b=awWFdwL6SY12KxcSgMUIbz7VtzVosOiO+/mFBMlWoKKHy/AWgQsNAlvuk+gQoKoekV
         LhuaakRFqhKVkKSmHoV/ZSycnO+G2y/BHv+6w2xbMmE+rVREenQxhIarpY9Ab5h1JvGo
         B8zxYbqjeHyRSdeC9foF+J0KsBY7tV4mxxHY0KNUGCfI0alclvMT/Bga48yivc4Hyk2A
         KaUoNrAHB3wXUsV4wJyyR0ROW3D59YHl8gfD1xLv9pH7liLGo6t0DlzMXdPTawOG6N9W
         MhDVHBURvAaac7vZ1zFKpReVDPLRhPMtitKgS7XUMZZOyMVi2/ZDruBx0pG/uV6KD54M
         q5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqW2HcjJuDOLPHIHNrwGP9NCuIRHc1/zFjX54Tx3mS8=;
        fh=NU7o0yG4D7p5TwgORj2GD2mgCGNQzXhM+pTqyVp7sf0=;
        b=XA4WS3P1lluFG5fjv8gnLZiEku7PYIkm9ci+9TbhqePlL6oTeGXvKp68ScSQQKhzZI
         t9tAEDLvIdeb3NrNOhcWfy+BhKHpNEuEBMnihIhJlVqsu/v7NwLAi2KRjm4UVEaXSzXr
         HNYyf5PHl4xtxIlRLMslNaCgynug/aUK/Cq6yDPdOPuOio3+LyXq5VhwUH4bUrwv7DNa
         ud1IvDnGayBSFYj6PWt4i2F8J6Nrpipi1UELYY3ffJ6f8tyKstLKJ9FDoVoVzRtHBil0
         YRVoNULC44sC5HpnKId9VpIWoEcBGlXRej4TGL+unpsFHi43xzFBAd2vZ7JXRdGIydRi
         uGyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786100572; x=1786705372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqW2HcjJuDOLPHIHNrwGP9NCuIRHc1/zFjX54Tx3mS8=;
        b=TZ1skAZV7Hc8RuCAtCXiu6rOYZJ1cy98mn/cNIPmdYzrjSsoTbzSrdNah+f3D2nhJP
         omHFjaoekxVLnIlDslp1lPnAOrjqaIkX3OLrrWQxG45IxY2wpR07DZvKic4pwFEhfIzW
         T1VF0Y5xM1NJy80q7ActBjqLnPXOzA1+VzcoYRCl5KcArMu4gZ+PZhSHxA1iOvxQKC07
         2Eo+Xb63/igI8kzVRrVHK9pW7TK0xHxyTiYBxu76J/gOOJ3sMs+Of8mVJaHYvJ2yARec
         srLvWIQovP27Yr85LrENDumntkUl+/Y2M3tcruaL1p7iIPKs/nYNgZnnKopf0vETxwFu
         y8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786100572; x=1786705372;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqW2HcjJuDOLPHIHNrwGP9NCuIRHc1/zFjX54Tx3mS8=;
        b=sf0oWR9g0K7+PW/JAvADgy9HrpfvQyZqDoVxsN0uisWbN5I+DnZWhwsQWc0Jo5WhID
         ZfsHY6C6EtgLIKEUFWSh94JOv+q0aXWMQeMWx9FxVTFcfbXKdtsLzrgbg2MP6Vzb1asw
         RwPplT7w8muR8jqv833a8xJzv5E+ejCO5QJvjBqkelw9m8YmQ32TxOQ3TFjZz/5KTDbm
         NFWR3AXEmyoHWPa3ox74Z1qiVjMCod2seOTOTF2E9PK3uWHJtmBev+nl1gzqDHjnxmTk
         UtgKZnu9BZD+TKpm+JcU1ZBGwnAw98ojGrdSebVQ3aSZz/vOio1AnUkJ2Y7a5fHLh/CP
         AgQw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/dMR/58HjBS7X8GuyLtfkLlg+N2pUbA3wfdc6CRUaUdRYJVtqFirxvwdrT5qN4EqvebM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQF4KDnnWx8fgxiamQzfjD8eMqQF7ph5nkLdtZSLvftG5p8JJ
	gMIv2a3ChLmnbMJXHnIMZwf6hHGmiKFe+63ab1SBN2v1i3lygBdyR5/VxKHjd9Yt/qICilcOYNy
	x2zGvUG+56KcKMjNbh2FpZbAgGt43amM=
X-Gm-Gg: AR+sD11KlxZHYYOXxJlL4N+BEdw+QFrPjJBZrj8zJ2o/FZm0Pcs1+gYcBetjBZvAew1
	mvW6KVkZILxVvPUdHZXi4AcL19vovQOMlbUDEV/hFKhT60TUr2qtLr9HAx0VZT1638GvozdMPcR
	bpE9XImh83nE7sLXvPOrpI2IuTJwXKdiWFcvnPczkRH2nIeg0M7FZeixA3yi8HLncNWisrEIShW
	BDtdZ4soHtuXhkmm68r+G9X3aFBS9mFTkF1fKa4s1c8CmLYceaLfhzzV7+rBoGmypIazAuOoQWE
	vuGPej8dgwO2LrGgAUzdTGQfVxX9lKEuysOvANyMo2ALD6QTeDnhNuXp7LaDuWlgiAfrYcpwNyA
	tE7kW9h+5L6i1wu2NDLSVbHtFLwy+rhl6j0PW4Eq2oHbY1hcojSsaTffpq/ws7spM/UVspeqRXq
	ynp5XnlH2CsvpL9oqnuw==
X-Received: by 2002:a05:6a21:1fc8:b0:3c4:397a:69ba with SMTP id
 adf61e73a8af0-3cb85ef8666mr26350736637.28.1786100571956; Fri, 07 Aug 2026
 04:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260807013830.698340-1-gitster@pobox.com>
 <20260807013830.698340-3-gitster@pobox.com> <CABPp-BEAtpT208afwSNoBbR-Nowss8OsLsL8ynETuBfN_xvWag@mail.gmail.com>
In-Reply-To: <CABPp-BEAtpT208afwSNoBbR-Nowss8OsLsL8ynETuBfN_xvWag@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 7 Aug 2026 07:02:40 -0400
X-Gm-Features: AUfX_mz9JEdyjSESthw3zY_JXCDdPV1P1hLiu9FEh8pXplJAyhpwxDPThPWu3iI
Message-ID: <CALnO6CBdZT3nVco+AREz-SVj7QG2P3Q24Hov_HJ2rAzELFm10A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] completion: complete tracked paths for 'git diff'
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Britton Leo Kerin <britton.kerin@gmail.com>, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:18=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Thu, Aug 6, 2026 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > When completing arguments for 'git diff', _git_diff() delegates to
> > __git_complete_revlist_file(), which only completes revision
> > references.  This is good [*], as mixing both revisions and paths in a
> > single list for the user to pick from is simply too confusing.
> >
> > If no reference matches, or if '--' is given, however, _git_diff()
> > leaves COMPREPLY empty.  Bash then falls back to default filename
> > completion in $PWD.  This fails when 'git -C <path>' is used because
> > $PWD is not the target repository.
> >
> > Update _git_diff() to use __git_complete_index_file() when '--' is
> > present, or when revision reference completion yields no matching
> > candidates, so that tracked paths are offered as candidates.
> >
> > This changes behavior even in the case where '-C <there>' is not
> > used.  The new behavior omits untracked paths from suggestions when
> > no revs match the prefix but matching tracked paths exist, which is
> > more useful in the context of 'git diff'.
>
> I'm looking forward to using this.  :-)
>
> [...]
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index ccd3b2a372..845fd19f70 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1981,6 +1981,10 @@ _git_diff ()
> >                 esac
> >                 __git_complete_revlist_file
> >         fi
> > +
> > +       if [ ${#COMPREPLY[@]} -eq 0 ]; then
> > +               __git_complete_index_file
> > +       fi
> >  }
>
> Curious; __git_complete_index_file() is documented as "requires 1
> argument", but you pass none here.  As far as I can tell, it works
> anyway, but feels like an accident:
>
> 1.   __git_complete_index_file CALLS
>       __git_index_files "$1" ...
>       (Here, "$1" =3D=3D "")
> 2.   __git_index_files "$1" ... CALLS
>       __git_ls_files_helper "$root" "$1" ...
>       (Here, "$1" =3D=3D "", again)
> 3.   __git_ls_files_helper "$root" "$1" CALLS
>       __git -C "$1" -c core.quotePath=3Dfalse ls-files
> --exclude-standard $2 -- ...
>       (Note that $2 is unquoted, and since it's empty, it disappears)
>
> It seems like it'd be better to pass an explicit "" to
> __git_complete_index_file than to implicitly get it.

Good spot. All the other callers pass an argument.

--=20
D. Ben Knoble
