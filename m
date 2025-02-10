Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329A264609
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220996; cv=none; b=UVCYybOsqYndPg5wzq/JkCSju0Koeu3Vs/c1JkWuFNOAun/eCFVodgKJe1g8pAXkuxr3hI3IYJALbzz6adHJMY6EN9K0Lkp1PN4yKZ47gW67Ds1hsPfqFiVCEGPKLGo5fgH7ImqbB1s+r2Z3UqbwdrYNXs9SmYOwLntoJ5ZrPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220996; c=relaxed/simple;
	bh=vHWAAsCcltAMAzEUSDOzEb4Q9d1DRCP08rqpxQJaDmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H42eptmAZWK3x2XTpi8i7V6HlQDvZRxyQsyYtagAXRQ6RsjRp0LOoxR69sjj5r1qFgCwMe+KrIgCjcJl5FG7q1DE6BgyoLYeeWFA1z8JOGoDwNRJ9px6Zrl38vWAb+M6x9C2zaaQCKaZDQXu9rfZSUVKkR4p/p2oX4LkwfNDAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2HoXsON; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2HoXsON"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f55fbb72bso57307195ad.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739220994; x=1739825794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XYjbunQYzcoTfDXzpAhMlzbVn6+8hfI+0zCBaflzrc=;
        b=Q2HoXsONNYsBuzoPuuQSyOreJIV3PQQVfHN1mpW5wxmsBJHPB5insXGKOYTVJDQJbZ
         V3Rmc8zfSvsEPaGzy3KJ2ZpnEFEfr6hqnbFQooRL8yiNZyEUNFhAwVSS3nwjeiPHE6jk
         8jUGBN9GXhiZdzEficNrrAJW8sp29mvBTDZGc406ML5sQEj4Q8IGBoRBAK4AUhWJUGVv
         tjjPQGBsxYPcpin+WbIilwnKRoi6hdin47avEKfcO4omobDgWM5FYUwpNvxw+J/ss5RI
         ZO46ePflDw4zWaJr5vV6fMRQOeTVHdCQ8qxx/NoPQuKZvQRRauGO8MpT5xeCEXUd2xu4
         phcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220994; x=1739825794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XYjbunQYzcoTfDXzpAhMlzbVn6+8hfI+0zCBaflzrc=;
        b=t9vgUTgp4J6p4czc1tDfK34xTInK2QAuHxE2A5cA3y5GxzFVrPl6I0Fvc7INS24w3I
         T7ybLuzEYgi5pkwfHvF3vOAeUgMn01nc33Djt3v2zbtwquVoqmfZe3nezjLLpfAiPlm7
         rLla0kS8HoBrH1jI8qPfPYUNNXL532iF41VdnL5qRiJWr9Q7W8Uur7wvhWvEGgoKOmVQ
         jf/2nTB6sL7QIf/awjyM1S0aO4hxnpanCGQyTVyDzgGByAYE5vMdg1j+fqEaSqay4VqA
         DxeahxRriRBZSaDRbPgtjrxwc1Lo2t8XdZ+lVoZcyc/CmnlXG7ZLpFVLCmtViCDynTfA
         G9LQ==
X-Gm-Message-State: AOJu0YwCFRdi/xdlZvNQIf22zusf/cti9bG1QBImYs4UCaa889+45DBX
	R5bYzIC7jXrLkdUC7wAfcTzDFon16fWDBuzUMSesaImVIWH31ob+j7lrjdCw1dNhqQuf6hqiFyd
	lH2ToAywyOnOGaptWG50XKVBnYwg=
X-Gm-Gg: ASbGncujjFdwer2WCH+6IDhvIlHsXv283RRbXwBDj21j7HLu4DR0md2dEdzddZkDVYf
	sZ7FvWiRB048cC8olw9H78gwxABOVOuIbKaAsJFqjgjuPKqBhbGFcrINU7IiHrEi+YhYxm5yenD
	oFmQPChCiZhucz5OjSeu9BxxqfOfI0FA==
X-Google-Smtp-Source: AGHT+IElFh667GosbegagNE4VNpAFdkBPUS4R7A4iXoG1hVo+ZWEwL4ErvYo5NklIudAZxtSQab/CAis3i/AMD92/H4=
X-Received: by 2002:a05:6a21:9211:b0:1e8:a374:ced7 with SMTP id
 adf61e73a8af0-1ee03a5b269mr27407739637.23.1739220993697; Mon, 10 Feb 2025
 12:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208061702.88469-1-forivall@gmail.com> <xmqqtt91dbzt.fsf@gitster.g>
In-Reply-To: <xmqqtt91dbzt.fsf@gitster.g>
From: Emily Klassen <forivall@gmail.com>
Date: Mon, 10 Feb 2025 12:56:17 -0800
X-Gm-Features: AWEUYZluXG81d_6xSDmwTAGnqhEu5D1F3WkNPRH-lsjziIW_deZfsJgqxI3Od0I
Message-ID: <CADY4h_o_wfUpjSBhWa9TPU_G-G8qpENpUeOKGQDY8dq6Zb2+qg@mail.gmail.com>
Subject: Re: [PATCH] revision: fix missing null for freed memory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:02=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Emily M Klassen <forivall@gmail.com> writes:
>
> > Subject: Re: [PATCH] revision: fix missing null for freed memory
> >
> > "git log --graph --no-graph" missed cleaning up the output_prefix and
> > output_prefix_data pointers. This resulted in a segfault when using "--=
patch",
> > "--name-status" or "--name-only", as the output_prefix_data continued t=
o be in
> > use after free()
>
> Rereading the title, I cannot make sense out of "fix missing null"
> and guess what it wants to say.  Is "null" here used as a verb to
> mean "to assign a NULL to a variable that points at ..."?

Yeah, this was meant to say something like "fix missing null assignment aft=
er
freeing graph data", and I didn't really have the energy to think of a bett=
er
summary at the time.

>
>     revision: clear graph callback upon "--no-graph"
>
>     "git log --graph --no-graph" first populates the .output_prefix
>     member of diffopt, which is a callback function, to compute
>     "--graph" header, and then discards the data the callback needs
>     to compute the graph header but forgets to clear .output_prefix
>     pointer in response to "--no-graph".  At runtime, we end up
>     calling the function that we should not.
>
>     Clear the member to stop making callback, and for a better
>     hyginene, also clear the pointer pointing at a freed memory.
>
> or something?

Yup, this works well. A small bit of rephrasing for readability:

    revision: clear graph prefix callback upon "--no-graph"

    "git log --graph --no-graph" misses some cleanup: handling
    "--graph", it assigns the .output_prefix member of diffopt, which
    is a callback function to compute the graph prefix when displaying
    a diff. Then, when handling "--no-graph" it discards the data the
    callback needs to compute the graph header but forgets to clear
    .output_prefix pointer.  At runtime, we  call the function when we
    should not. It also passes a stale pointer to the data, which leads
    to a segfault when the callback is used for "--patch",
    "--name-status" or "--name-only".

    Clear the member to stop the callback from being called, and for
    hygiene, also clear the pointer pointing at a freed memory.

>
> Other than that, as I said earlier, the patch looks good.
>
> Thanks.

Awesome. I'll also add a test before re-submitting, as mentioned in
your other message.

Thanks for the feedback!

>
> > Signed-off-by: Emily M Klassen <forivall@gmail.com>
> > ---
> > I previously reported this a few hours ago, and ended up digging in and=
 figuring
> > it out. I'll make sure to bottom reply in the follow ups to this patch.
> >
> >  revision.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/revision.c b/revision.c
> > index 474fa1e767..84cb028e11 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -2615,6 +2615,8 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
> >               graph_clear(revs->graph);
> >               revs->graph =3D graph_init(revs);
> >       } else if (!strcmp(arg, "--no-graph")) {
> > +             revs->diffopt.output_prefix =3D NULL;
> > +             revs->diffopt.output_prefix_data =3D NULL;
> >               graph_clear(revs->graph);
> >               revs->graph =3D NULL;
> >       } else if (!strcmp(arg, "--encode-email-headers")) {
