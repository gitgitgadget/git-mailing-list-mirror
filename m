Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967B259C9C
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787790123; cv=pass; b=G6o1p+yF91rvG1jiK6g48i+taQ5PL84vj/x+CnNrIULuJkVsdjOEYk4owCOBOMxAMSxiRMP1/Lt+JY8xw0sNojCeGsdoSuJYDceEQx7730Xlc/XLVGTg28dC98LoLVBUXEBlL5HPNuFUfpzFeDHG3JtUGug4XZcHMSrJW+NHHUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787790123; c=relaxed/simple;
	bh=sh0EIdvvs6OgV2dJp91aXph5mhF7mcD+/qHU6Xg31NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frtjqONxXiOVVwwblDaVvSFJDSPaZt7x+7k4xjYKhoGvZ9RS8AGA7rd38m7cLnjYJd1T1JnVruSqDOyHorD1O2OCOu9oscPy+09t82kyM0w33zR8A9IMrsM/UUacbdPev0cg1mUlasnnFjieAtFEfihtpiUVCLWGZwIaJRyNctw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILbHlB3x; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILbHlB3x"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4ab47c40e7eso72593b6e.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787790121; cv=none;
        d=google.com; s=arc-20260327;
        b=fe4OI/gvgScaMhnarZ/fasn8vA5evFZMpIVpLgnR4RPLzkf0939GzaDqx4rbfRw1vO
         koyLNLguQC6kWY3xnoUznS0j0LjBmUUQMxEMllXDipONghU2mhZjQlWXo/qGSz9tn0j6
         SUvRRK+mVFy/k5nyxVKTSDnXDiIaIeWBv0lyeS2sAAw/proraH9b2EYk+0UHYucSiab8
         oeVhF5W1aoIynhbpIioG+lMGQOHGtbeG6PBEfvuiFeri0s3o9ePCLhxi1eYiBH+D69KO
         Z/XH3EZfmV/4C/UP2x1rfrBOerfvmnY2h6GSek/FyV8fAbekPSw/A5ShcJ0oZoLoOmC+
         awog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dwS5K+cLXfmB1quEM42agKZW5EtLMPvKSLCkzHda0KA=;
        fh=e3ITgC0XzphPp0NSqgaRpAmAW52qKR11b8vSu9Onx3Q=;
        b=AsJLrvw+tMMfczx8rOywNK+OERBkcXW6qqSVRIwaGEnO2M2CaKc5SLuRL5yqyxOHM1
         OJVqdRgP+mZTzylzC9nOWYYuhGL3MZY2pJKV1Eoc6q+JS1aTqQ0syDjmTgvKekLmtME5
         ZBC8BnA2wFWWdmBFpRYRUcwjImul3VHUSI3TFFTbqyw1PNo0c5lGDWFE75ZVA60eABRT
         lUQJ9pHFXCLpAgZEsAcTyLK66ljPPbfOalkq9KoU2MqJMnymt1/DsRv1wTEeU5h8mnQp
         eYhMu5PXMskf3iZup/gB71kk7IczYj5MmmTCGef0S5fZ5twoCRE4mmS9qjghw0lIYgv2
         oPJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787790121; x=1788394921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dwS5K+cLXfmB1quEM42agKZW5EtLMPvKSLCkzHda0KA=;
        b=ILbHlB3xltV55/bDqOhxvo2Ee9zxV2iuM0TKz38e7NKJzPYS1Xpap99QIemsnt4cfz
         P5m5ad7YYSEzEZu+yP6BCGGStTniubZawOWt5e1T4xtIv8px+OBaTGLIG2wloITv6sNI
         2ARw+IvDw0u2w1K6lf57FldZNoIt60pAcunQ6SWcVRE9xbJEoadp6MrTHBDHIozd05z/
         gRENk/wv4wT7FO781b5rfslZre7tVJmDyb+JgZjzrg8aVPb07EsJo1saRGX5Kk6GDle+
         zGKKXGJpmoy6Ak0b5c7jRL+qnxxH5LhvYC7jMeug0dMi3E3AzkSOR3WXAKtUHTmYTX1m
         fXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787790121; x=1788394921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dwS5K+cLXfmB1quEM42agKZW5EtLMPvKSLCkzHda0KA=;
        b=SYxwiKTrSu7831g9yVjX56JFFvnz8SjdGGr7OLJnybQU/nhekf1bww2gUgl+Dx2MHr
         4fK8P6JAmrN7d4bpdHTh2BA5H6IO0PRFC3KEa3dzxCA9s/oB/lO/1xdvWM9/cJrxiUIK
         WKeLgCdcCYian9OeNuxOJZUcyVZRL109yxccxvRummTIpI0qJwgQcqk5VztaH+eloJg2
         EmTWf9NJpziDwJcLmNnl2e4Tm7xJqwXXXxqKNUCBuxstt4rrJBYyobKh/K9e/nFH7K88
         +4TP35CiGTBOk8OqDCczoZfK7boGlycTl7dgZyATmZnzqS0bmhxnh3SVBbvdN/r/Th+A
         kFGA==
X-Forwarded-Encrypted: i=1; AHgh+RrjTO0Q0XhShvciHInOEONAhoFBDVTV0PtGPkAUtvBs4B/k9deGlf04IUMvl7HnhCKGgfQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k8HnoQp6hc7pAx6C9axzDonfas+sJwhy8Frp4pk3YV7I8S+/xm
	dplR3VJYTqNQy+W6WZUYhUYat4PjTqcJXZ89/+V1nMEGnYVtFLZZRh8YP/+6ZERMMlha4k26wVq
	7U8V6bfJC8nsuDoXA7702fSaCSaUp/Wk=
X-Gm-Gg: AR+sD13hwW1iH6uWBpzV2kDDwHv0R2v/uW2t8yKbQs/RlePJrzhh03aTZ1JWfhJuZDE
	BwuvffphrMqgfrkcK85Idyaf8hi2enj3I5gAOJPe6Oq5ZtLMVIBhCtRt9R03fjEuE6hSFbg7kz4
	9KnHAdezNMBcoD8Q+4Mz3R1jDGJmlotDgsLriYyePRCvw4HE8Rc5khFq6iG8AwlOR+6hPgsgCdl
	lrxMtcK3thZVWSVzsPk07ddnOzcCfdaHENLleU03yw+9pmIKO6mnpS0LYDGKsqAEGJCoS2DRoa5
	B2sBdx4RiIfTjML7QY5ETbzxqZQePa5wQp5DPPDu38IPFyOxa+UUOW7FHB3aau9H8o9dgdLfWcs
	pS4HkFOjHhGPNNTbFijCOykovZHOYQXk21ShN6Z6UMXkM4t35uAHI7Ws8mbbOPg==
X-Received: by 2002:a05:6808:678c:b0:4b2:8d89:6a40 with SMTP id
 5614622812f47-4b36695ccf4mr12856630b6e.7.1787790121369; Wed, 26 Aug 2026
 17:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com> <4688ee19-b782-456a-bed2-8cd2a4415736@gmail.com>
In-Reply-To: <4688ee19-b782-456a-bed2-8cd2a4415736@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Aug 2026 17:21:50 -0700
X-Gm-Features: AcwNN1U41zdDpZ_xNu3lytNhj6Fmc3B1sUbJI_BUIsllvRSnv_9RVfx9rA_5Ngo
Message-ID: <CABPp-BHx7H5mF8tqs3JkK+Rqjn8hMSjXhohT9NW=NmPsU1by1Q@mail.gmail.com>
Subject: Re: [PATCH] commit: refuse to amend during conflict resolution
To: phillip.wood@dunelm.org.uk
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 6:56=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
[...]
> > @@ -1336,6 +1337,46 @@ static int parse_and_validate_options(int argc, =
const char *argv[],
> >               else if (whence =3D=3D FROM_REBASE_PICK)
> >                       die(_("You are in the middle of a rebase -- canno=
t amend."));
> >       }
> > +     if (amend && whence =3D=3D FROM_COMMIT) {
> > +             char *applying, *apply_dir, *stopped_sha, *amend_marker;
> > +             int in_am, conflicted_stop;
> > +
> > +             /* Check middle of revert */
> > +             if (refs_ref_exists(get_main_ref_store(the_repository),
> > +                                 "REVERT_HEAD"))
> > +                     die(_("You are in the middle of a revert -- canno=
t amend."));
>
> I think it would be much cleaner to move this check and sequencer
> related ones below into sequencer_determine_whence() so that we don't
> have to hard code the paths here. It might be worth checking for "am"
> and the "apply" based rebase in that function as well.

Moving the logic makes sense.  I was a little unsure about putting it
in sequencer_determine_whence() since commit has its own
determine_whence() based on keeping the merge handling separate.  I
kind of wanted some function for ongoing_operation, so I just made a
new helper, and added merge, am, and the apply-based rebase to it.

> The logic looks sound to me

Thanks for taking a look!
