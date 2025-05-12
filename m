Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204281DE4D3
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076096; cv=none; b=ReaCswmT6sMnTd3BuJPb9lEkA0RdKEfhYLluhAVhiQ4rl5p2fc2EGcJEWvJz10bwXQQQMeyAt871+EGNlX6/E6lNAyFks/9EkS6Y0JnTCTCnxqATUATF14pGRLfrxgvOmoNFeJVrgbllSKC9QwFXTAGl+6CI8HolM34UzIz+7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076096; c=relaxed/simple;
	bh=CCAV2HgzvpH7GHx4zchHaUhpgZZromgHkVrvpMbqJsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fjlts9k00by3HhIhpXPTK21xiRieR7oHwwJeOjWEsTPw7kUPaUyIfRoHH6YVxwM/aCWMvgRqdM2Wp9jsAGWu4Sm6TckWJC0qLhOH62BgqC6/Hop2bYASoBMNfsdFVexag+7Xxnuhy36sow3BAjiWWShaO6URfgGqe8CcEhs9b18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f54a3e512bso8216156d6.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 11:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747076093; x=1747680893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTJa3LjqoCcKn6ARSKlVsqIWaY2qgIdmqt6g0zMCUMw=;
        b=Bkyw8kVC+Ec4GDLWDa2LDzEo3uAvfuq/tIOOh5ZkqjhUU3F6CHA+r9pzdQGefa/oT9
         i+FHc0Y3fmsmiW5yI/KEWV3QmhGqXvLOtYtdj3LV85nYs47CCGY14dYbsbF390SaKmfh
         9ItsNq45011pcj6b1yHHUDIsJx2pASmb6ZDwgMldzMtoMlfFpwL1kKSNZPvaa2mVQDh4
         dcGLFE4Tkx2i6ySQ6vXWQv7cKWXulJOSMNqUxzvaIBOfazm1YDPlZyhJUgTF7am5RV96
         rENCEc7EupGGdYeMoqASCCM4RPr/BXT5F90QTSPVhB213sXZuk4HB9mOTNuestxcKU6M
         D8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXrFP59iUtP5YdBCl0oaHvsJvUUTyftqyfI2h4ZcYHGrC/8TD8paphhraGxFxN4l74eLOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8YQMjofbH49ptn8eo6+/aO909UpWpbZ5oU+xjL4hv75FKToZV
	bCZIEGJ9gv0emY0QxNvBgjfGhxHBQiNPyVycKVEJHALmoU5PbEGTroKtPLdp1e0uAJucAfVCVhs
	QigxCioWBKuMzabfjFYXGeMxD2bcBYg==
X-Gm-Gg: ASbGncsCiDBsszOHBEjQ2gIXzULP241x+qyXbPkpuOz6RrOV6D9f/FBfsAKUtjtGwNR
	FT1G5V6sweLG9kX817N1/sAIVLGHXWvh4q+5ykXjSmwP1XiC2WZuM80oYB+wKp9Ui/FR6lSlt6l
	TlHXi4WgcihlLA9V8pag/BgKKnVjL45wUhpf8lfqQCDg==
X-Google-Smtp-Source: AGHT+IFSfkLkqDd4GN3HaEurR1xFPxaeKWwcHO5esafgtfTZ75jFdMivLgDUfszt39p+elGMVHQNNhUFC5vsJT5ce2I=
X-Received: by 2002:a0c:f945:0:b0:6f7:d0b9:793b with SMTP id
 6a1803df08f44-6f7d0b97943mr5174086d6.8.1747076092914; Mon, 12 May 2025
 11:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
 <20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com> <xmqqtt5psor5.fsf@gitster.g>
In-Reply-To: <xmqqtt5psor5.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 12 May 2025 14:54:41 -0400
X-Gm-Features: AX0GCFuSOlOI_M-El2J950koySAwUzhlYElji6BHdSepuAdRCJhDNG2WUy7gBgc
Message-ID: <CAPig+cSbwGdhq66tSk_A5oNGXqpbqFA=ZO5GS1E-ENb+_rY70A@mail.gmail.com>
Subject: Re: [PATCH] stash: fix incorrect branch name in stash message
To: Junio C Hamano <gitster@pobox.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, smacdonald@kaimaging.com, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
> > @@ -1404,11 +1405,20 @@ static int do_create_stash(const struct pathspe=
c *ps, struct strbuf *stash_msg_b
> > +     if (flags & REF_ISSYMREF) {
> > +             const char *tmp =3D NULL;
> > +             if (skip_prefix(branch_ref, "refs/heads/", &tmp))
> > +                     branch_name_buf =3D xstrdup(tmp);
> > +     }
> > +             if (branch_name_buf)
> > +                     branch_name =3D branch_name_buf;
> > +             else
> > +                     branch_name =3D "(no branch)";
> > +
> > +             head_short_sha1 =3D repo_find_unique_abbrev(the_repositor=
y,
> > +                                                     &head_commit->obj=
ect.oid,
> > +                                                     DEFAULT_ABBREV);
> >       strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
> >       pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
>
> Funny indentation, and branch_name_buf needs to be free'ed after use
> but other than that, nice digging!

This change should also be accompanied by a new test to verify the
fixed behavior, right?
