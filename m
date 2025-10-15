Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7730507B
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565781; cv=none; b=PtaruXL+/HAQ1voUVE5I7At0IJ/eivDMVKe8lBSEgchbrHrfLSGhIJUXYpCykcdMqrURe/QTj6gFyAQFwmLKTdPeDIQywcy57r9QrnLaVOcl+6mhbBjNzyQxKkC1TbPJR7j/yhNR+JvxSTf7gISIdMkchLuM0eZca9MAdatXd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565781; c=relaxed/simple;
	bh=UCxe2vpY3CG1HizJl50djaEExQNCwTfUEuq2Q5AleY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS0To4ljxEyKBr80/+4oK5CQL5/v2pqSAumaMPpJNLGGOQ3sqSa2QKzWmt3XMAhzCV4vgEE4kHvbZI8c2zQeRd+tm6ZvUkAI7GbrvhKkpSQQpAHFOXfrcaOYPi08OnVB31FR3FJ4UKGzC73Km4us6XdGvJ0TsiosHZCLhZnknww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDHUivmH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDHUivmH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27c369f8986so698985ad.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760565779; x=1761170579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYfqg6v22A8cDRSahKDcezI2Ppu4isHralnhJtU8tTU=;
        b=PDHUivmHej/Wh4r6Xnia1Nckn55fgocKlroLl/Qgo01g0OxsVAXamSPGgd94fHX5f6
         y8f0boCC6sUqHEZmxKL4kXN/QcWPAwRh25ZslkGbOV7EygGSg5aRGXRhxvHeaijmpuZ6
         Nwj9B76H9FnJrS3bgc/U2AhAUC0wbajR8oeW7E6hEPZuxvPcPNcXNCEpmB0OxnJwYp+7
         6r5A5RqeAMOGoRBWELI7W34UjWJMpt0XBsxUjSEnjd7yXhgAwabqhXUj8AH3raYKs5U8
         moztcR5wibMxVAF3UvFusep0B++QpvJbP4jpX6VF97ZWKkt3SDOGqm6MNcgGTCgZdNwR
         3A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565779; x=1761170579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYfqg6v22A8cDRSahKDcezI2Ppu4isHralnhJtU8tTU=;
        b=BOZ8ywPkcdeG5X4on6KJTkegSDPI3Mb2pmpBHidu6eCTn4tbBv8jqDu5hDxdEnCMc1
         cr/blGZit2Yytfu3lY8GHU5FUegJVc+7zwUTyXsrByx3mXFZlXcfa8WTeVE4NOG8hrJO
         lS1jN2YfBa5jXg1rd/oMSD6Z+yaizvjn3J0xtSZ2LAtOuD2ehk+XEdD72U291/OtlMLC
         cbwxQds3nrq8h0Uex/1G/IqRLSKxgIQiPznIX7TVDUUo+2YGW6ohLFsv8iHRwuAPB+sm
         Sg+DiPqSH7JGIdsYS/LL77ahm41ISbSm6q0UmjRW79dBKqw3xngC2DG/E3GD0aKOXrZh
         wosw==
X-Gm-Message-State: AOJu0Yzuex7pZ0wo0LpM1w8CC8XDy/j8PNBBFDjHDT5gE4ELa0+BTrN5
	qegT1C3ELfGlYRCCICx0RVIVbUXQBkWWR00jD/dBQFuG47/bi3aDtaUiz366OBCRxOT4j2PtJfu
	8mpQzSYlcoVlnm9CQfcSMyTpmztxnZg4=
X-Gm-Gg: ASbGncuREjStD30aP0eomnbEJQBto8GYMpyMoHXftmC1KxvPuPwiyDw1lLHbwjYY0Fk
	WEg9jEW4z2N4XkbVROKmDuTddkI5aH26w8d4maA8OHxaF2pxB/7CdJrfjRbE7V9y8ci8rHZd6jM
	9a/KcKuueHOG99x1Ie9xQCLPlHgNK9W7+GrRRqgJd89EXQofP6kVR+51wVspC9Llkj8kDOLLXOv
	K9DJBHLs78fHuIvuhsq+jty8e1+Hh0Imo4q10pvaKynA4W19SZI76eiX9TQ9Cti
X-Google-Smtp-Source: AGHT+IGi3irdCiPKF7prIlvuFAiR+Ynod0/2rkgPm6sbDrXZY+xZuTCK5TbxfrkkM5z3KzNZqakrQ9/KtWsaO5fWsfc=
X-Received: by 2002:a17:903:246:b0:24c:9309:5883 with SMTP id
 d9443c01a7336-290273ecb35mr394624285ad.28.1760565778760; Wed, 15 Oct 2025
 15:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760490943.git.belkid98@gmail.com> <d1c20c911637870c3cacfedf763ce508a641710f.1760490943.git.belkid98@gmail.com>
 <CAP8UFD3zu6DJRRBcSMOQsPQDQcgzSOsqsrMWJH51=VeBkWs+SQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3zu6DJRRBcSMOQsPQDQcgzSOsqsrMWJH51=VeBkWs+SQ@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 15 Oct 2025 23:02:59 +0100
X-Gm-Features: AS18NWAysswbATV8aZ4Ms8TkYy4MNpTlaNHW6DGDC2MP7cz4O20uj9KQtI5ToA8
Message-ID: <CAD=f0L90FjPs1R_s70gvbOMqG=H45wVj9n6g9vGTq_Xvt90E3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] [Outreachy] gpg-interface: use string_list_split
 instead of strbuf_split
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 at 16:28, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Oct 15, 2025 at 4:19=E2=80=AFAM Olamide Caleb Bello <belkid98@gma=
il.com> wrote:
> >
> > get_default_ssh_signing_key() gets the signing key via the pipe_command=
 and
>
> s/the pipe_command/pipe_command()/
>
> > stores the output in key_stdout.
>
> It's not very clear from the sentence if the signing key is the output
> or not. Maybe something like:
>
> "In get_default_ssh_signing_key(), the default ssh signing key is
> retrieved in `key_stdout`, which is then split using
> strbuf_split_max() into two tokens."

Thank you. This is much better. I struggled a bit to get the right wording.
>
> > The output string is then split using strbuf_split_max into two tokens =
at a
> > new line and the first token is returned.
>
> Here also it might be interesting to know that the first token is
> returned as a `char *`, not a strbuf.
>
> > This makes the function lack the
> > use of strbuf API as no edits was performed on the split tokens.
>
> s/was performed/are performed/
>
> > Replace strbuf_split_max with string_list_split for simplicity.
>
> Here also, using "()" could help a bit as it would make it clear that
> "strbuf_split_max" and "string_list_split" are functions.
>
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>
> > @@ -884,19 +884,15 @@ static char *get_default_ssh_signing_key(void)
> >                            &key_stderr, 0);
> >
> >         if (!ret) {
> > -               keys =3D strbuf_split_max(&key_stdout, '\n', 2);
> > -               if (keys[0] && is_literal_ssh_key(keys[0]->buf, &litera=
l_key)) {
> > -                       /*
> > -                        * We only use `is_literal_ssh_key` here to che=
ck validity
> > -                        * The prefix will be stripped when the key is =
used.
> > -                        */
>
> Why is this comment removed? It's not clear to me that it's not valid any=
more.
>
> > -                       default_key =3D strbuf_detach(keys[0], NULL);
> > +               if (string_list_split(&keys, key_stdout.buf, "\n", 1) >=
 0 &&
>
> In the commit message you should explain, like you did for the
> previous commit, why "1" is passed to string_list_split() while "2"
> was passed to strbuf_split_max().
>
> Also I think that, instead of "> 0", the tests should be ">=3D2" or "=3D=
=3D
> 2". Or, if an output that contains no new line is valid, then that
> should be explained in the commit message.

Thank you very much.
I will make corrections
>
> > +                       is_literal_ssh_key(keys.items[0].string, &liter=
al_key)) {
> > +                               default_key =3D xstrdup(keys.items[0].s=
tring);
>
> Thanks.
