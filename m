Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21361DA612
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163821; cv=none; b=D5alLDFb2nQeymn/lhzOd+EM9aiImkFcd4Cl6TxAAl6uIGX4kaZsAsgOkwUZKvJyHVyg0k4Ka2mfxuFI2EeMwpLfxW074zk3Kqen10hrGztyIkc6GdU4XjbIjh1t4eVXVuVt+jTE7xcpP+cHayn1Fdac32Fr+6JYGTkypZ2EpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163821; c=relaxed/simple;
	bh=+h9OmuKIh6v5nEWoge+bQKfWVP6eAhweBcWRAsUkX9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdmsuI/ODBhg8s/xBlkafHbRYqnMVcN3ZaECF1SNduPzAxIMgolbrgpo5iYUD1CWi2dKGZl24Bik3v9o6LDPqfafLb1zSzHhU8FV89ZV7RIxDWVc90wD0MSgOuf7plaBcPdE6bb7XeHl4UGCgWZa0VXexzV59UMk4IIQSvLFz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnQbJx7Q; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnQbJx7Q"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a47cdaf158so275201137.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729163817; x=1729768617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5b/lCt/Od3n8XIe19Jowv/ozuDnIe2pSozI9guk3lo=;
        b=nnQbJx7Q59ogH41Dnx3JpQLcknKaJx8jfOnzGwTGDKVUhr3WGdCA5kCBTiMDAWii7i
         MeNra6dOsTdywpu61RJk56m3eZZXUFz9xVWde4hVrE8fTQJIMzDTAUcpQl4PBJs20M7E
         dAdmPH3hSPZ9xi/mMH/Si5KnGPHcyGcNe0ze3MElNQT011NuIPXyC3pyyTmEE5DlBYUz
         5QBwYowk3xYdbEK2OKjCpzr3zcEcba1IAsLKzkT8BgwB/7UzAQ8bpPUezJisEtl9ZXOb
         5xwbSxhKHxUlGADrPyr30kXiiFptQqSmhzmiVjMpq4SfV3o6YzvUoU4x983tPiCbyOs1
         YBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729163817; x=1729768617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5b/lCt/Od3n8XIe19Jowv/ozuDnIe2pSozI9guk3lo=;
        b=QNhWIXALV5E8zmIOBCs5yEJqkNNtf2Gn7OJFEReZXGrIx/cgBbAH1HMrmRMFszv2BO
         fkqaMLXBGS1lVanoYwvVaPRdAzXlCEJ/sAZiFib1Hcr6h2H0khDmIWCWx/caRBpbIbST
         nW2Lsx5CmVx/I9tGlO8uWiVhjBn607CFQ6Mv4x5k/oFTUubXePRkDlp1H0yMi1raAk4n
         J/+yadqgcmofZvxj0v0VZNTBgEm7w6YfKAyDSD1okdYdg7GzOL7jjfq1VL/qm8W/k5MU
         gREIigsHlSN0bBTGDPxufNZtMxGUDQ93372dwjvvDODOW7FYLNuN1VBBK/+REoLAnS0A
         1H6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1CkpPVtrAZwtpzAl8RWPnGbb5OykDwBGTNE8j7lHpEPV4ZQ8sjy/w3+bEnwM4kROGt2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWyns7dd7ESE84/gDF1AnJyOW/jADUsgWJO4g5ciA5oY36Di1
	DQ3HwQI8s3I0vaOtz9FVNA/I8hYmrLYc6LyHkNMcnZ+ZcOByxX4K1ymhyh5w0rekPs/v+oB3rPX
	fm888ccjo5U6P0M+5LuhHa0FvKGNsXrT/YIk=
X-Google-Smtp-Source: AGHT+IHJEP5NjJDVaL0StsspvFg7dp0w/1RJnPHJyTX3a2q1Z5IYcR6uJ7PlWeFAM3mr8LMJagIp5cD8Ng5IA303iMI=
X-Received: by 2002:a05:6102:304c:b0:4a4:6cf4:3158 with SMTP id
 ada2fe7eead31-4a475f12a21mr14033395137.3.1729163816623; Thu, 17 Oct 2024
 04:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
In-Reply-To: <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 17 Oct 2024 11:16:45 +0000
Message-ID: <CAPSxiM9j50ksZsdd+mVYt7p5=5GQDjA3eXSgryGCF7QsDNEE1w@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:49=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Usman
>
> On 13/10/2024 00:09, Usman Akinyemi via GitGitGadget wrote:
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
> > and strtol_i() for signed integers across multiple files. This change
> > improves error handling and prevents potential integer overflow issues.
>
> This paragraph is good as it explains why you are making this change
>
> > The following files were updated:
> > - daemon.c: Update parsing of --timeout, --init-timeout, and
> >    --max-connections
> > - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
> >    tags
> > - merge-ll.c: Enhance parsing of marker size in ll_merge and
> >    ll_merge_marker_size
>
> This information is not really needed in the commit message as it is
> shown in the diff.
>
> > This change allows for better error detection when parsing integer
> > values from command-line arguments and IMAP responses, making the code
> > more robust and secure.
>
> Great
>
> > This is a #leftoverbit discussed here:
> >   https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yNZzdA=
aa5CGTNGFE7hQ@mail.gmail.com/
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Cc: gitster@pobox.com
> > Cc: Patrick Steinhardt <ps@pks.im>
> > Cc: phillip.wood123@gmail.com
> > Cc: Christian Couder <christian.couder@gmail.com>
> > Cc: Eric Sunshine <sunshine@sunshineco.com>
> > Cc: Taylor Blau <me@ttaylorr.com>
>
> We do not tend to use Cc: footers on this list. Also note that as there
> is a blank line between the Signed-off-by: line and this paragraph the
> Signed-off-by: will be ignored by git-interpret-trailers.
>
> > ---
> >   daemon.c    | 14 +++++++++-----
> >   imap-send.c | 13 ++++++++-----
> >   merge-ll.c  |  6 ++----
> >   3 files changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/daemon.c b/daemon.c
> > index cb946e3c95f..3fdb6e83c40 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1308,17 +1308,21 @@ int cmd_main(int argc, const char **argv)
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--timeout=3D", &v)) {
> > -                     timeout =3D atoi(v);
> > +                     if (strtoul_ui(v, 10, &timeout) < 0) {
>
> For functions that return 0 or -1 to indicate success or error
> respectively we use "if (func(args))" to check for errors.
>
> > +                             die("'%s': not a valid integer for --time=
out", v);
>
> "-1" is a valid integer but it is not a valid timeout, maybe we could
> say something like "invalid timeout '%s', expecting a non-negative intege=
r".
>
> > +                     }
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--init-timeout=3D", &v)) {
> > -                     init_timeout =3D atoi(v);
> > +                     if (strtoul_ui(v, 10, &init_timeout) < 0) {
> > +                             die("'%s': not a valid integer for --init=
-timeout", v);
>
> The comments for --timeout apply here as well
>
> > +                     }
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--max-connections=3D", &v)) {
> > -                     max_connections =3D atoi(v);
> > -                     if (max_connections < 0)
> > -                             max_connections =3D 0;            /* unli=
mited */
> > +                     if (strtol_i(v, 10, &max_connections) !=3D 0 || m=
ax_connections < 0) {
>
> This is a faithful translation but if the aim of this series is to
> detect errors then I think we want to do something like
>
>         if (strtol_i(v, 10, &max_connections))
>                 die(...)
>         if (max_connections < 0)
>                 max_connections =3D 0; /* unlimited */
>
> > +                             max_connections =3D 0;  /* unlimited */
> > +                     }
> >                       continue;
> >               }
> >               if (!strcmp(arg, "--strict-paths")) {
> > diff --git a/imap-send.c b/imap-send.c
> > index ec68a066877..33b74dfded7 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store =
*ctx, struct imap_cmd_cb *cb,
> >               return RESP_BAD;
> >       }
> >       if (!strcmp("UIDVALIDITY", arg)) {
> > -             if (!(arg =3D next_arg(&s)) || !(ctx->uidvalidity =3D ato=
i(arg))) {
> > +             if (!(arg =3D next_arg(&s)) || strtol_i(arg, 10, &ctx->ui=
dvalidity) !=3D 0) {
>
> The original is checking for a zero return from atoi() which indicates
> an error or that the parsed value was zero. To do that with strtol_i()
> we need to do
>
>         || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity)
>
> The IMAP RFC[1] specifies that UIDVALIDITY should be a non-zero,
> non-negative 32bit integer but I'm not sure we want to start change it's
> type and using strtoul_ui here.
Hello, regarding this. I used strtol_i here as ctx->uidvalidity
was declared to be int so, the strtoul_ui complained as it was
expecting an unsigned int.
My suggestion will be to leave it as strol_i and use this comparison
(strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity), what do you th=
ink ?
>
> [1] https://www.rfc-editor.org/rfc/rfc3501#section-2.3.1.1
>
> >                       fprintf(stderr, "IMAP error: malformed UIDVALIDIT=
Y status\n");
> >                       return RESP_BAD;
> >               }
> >       } else if (!strcmp("UIDNEXT", arg)) {
> > -             if (!(arg =3D next_arg(&s)) || !(imap->uidnext =3D atoi(a=
rg))) {
> > +             if (!(arg =3D next_arg(&s)) || strtol_i(arg, 10, &imap->u=
idnext) !=3D 0) {
>
> The comments above apply here
>
> >                       fprintf(stderr, "IMAP error: malformed NEXTUID st=
atus\n");
> >                       return RESP_BAD;
> >               }
> > @@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *c=
tx, struct imap_cmd_cb *cb,
> >               for (; isspace((unsigned char)*p); p++);
> >               fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
> >       } else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
> > -             if (!(arg =3D next_arg(&s)) || !(ctx->uidvalidity =3D ato=
i(arg)) ||
> > -                 !(arg =3D next_arg(&s)) || !(*(int *)cb->ctx =3D atoi=
(arg))) {
> > +             if (!(arg =3D next_arg(&s)) || (strtol_i(arg, 10, &ctx->u=
idvalidity) !=3D 0) ||
> > +                     !(arg =3D next_arg(&s)) || (strtol_i(arg, 10, (in=
t *)cb->ctx) !=3D 0)) {
>
> And here
>
> >                       fprintf(stderr, "IMAP error: malformed APPENDUID =
status\n");
> >                       return RESP_BAD;
> >               }
> > @@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, =
struct imap_cmd *tcmd)
> >                       if (!tcmd)
> >                               return DRV_OK;
> >               } else {
> > -                     tag =3D atoi(arg);
> > +                     if (strtol_i(arg, 10, &tag) !=3D 0) {
>
> To check for an error just use (strtol_i(arg, 10, &tag))
>
> > +                             fprintf(stderr, "IMAP error: malformed ta=
g %s\n", arg);
> > +                             return RESP_BAD;
>
> This matches the error below so I assume it's good.
>
> > +                     }
> >                       for (pcmdp =3D &imap->in_progress; (cmdp =3D *pcm=
dp); pcmdp =3D &cmdp->next)
> >                               if (cmdp->tag =3D=3D tag)
> >                                       goto gottag;
> > diff --git a/merge-ll.c b/merge-ll.c
> > index 8e63071922b..2bfee0f2c6b 100644
> > --- a/merge-ll.c
> > +++ b/merge-ll.c
> > @@ -427,8 +427,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_bu=
f,
> >       git_check_attr(istate, path, check);
> >       ll_driver_name =3D check->items[0].value;
> >       if (check->items[1].value) {
> > -             marker_size =3D atoi(check->items[1].value);
> > -             if (marker_size <=3D 0)
> > +             if (strtol_i(check->items[1].value, 10, &marker_size) !=
=3D 0 || marker_size <=3D 0)
>
> Here I think we want to return an error if we cannot parse the marker
> size and then set the default if the marker size is <=3D 0 like we do for
> the max_connections code in daemon.c above.
>
> >                       marker_size =3D DEFAULT_CONFLICT_MARKER_SIZE;
> >       }
> >       driver =3D find_ll_merge_driver(ll_driver_name);
> > @@ -454,8 +453,7 @@ int ll_merge_marker_size(struct index_state *istate=
, const char *path)
> >               check =3D attr_check_initl("conflict-marker-size", NULL);
> >       git_check_attr(istate, path, check);
> >       if (check->items[0].value) {
> > -             marker_size =3D atoi(check->items[0].value);
> > -             if (marker_size <=3D 0)
> > +             if (strtol_i(check->items[0].value, 10, &marker_size) !=
=3D 0 || marker_size <=3D 0)
>
> And the same here
>
> Thanks for working on this, it will be a useful improvement to our
> integer parsing. I think you've got the basic idea, it just needs a bit
> of polish
>
> Phillip
>
