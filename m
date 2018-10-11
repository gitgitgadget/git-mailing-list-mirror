Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18DE1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 08:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeJKPlA (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:41:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32825 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKPlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:41:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so8606038wrs.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mto/bao0NUaIS5cYZmVQLCHYp4FUGskW/4WKbu/YRgI=;
        b=Pv5jh3V9thYGZ0VsuJBN6/TO/w/qGsqVlGBDrNrK2zu0WHj8BxzjPuKAbUBQb7dXPA
         dfMiiERtqQcJUd3/+xs4gqV1T7gI2wejjx0oZxBpgS+B59xQtGK8Np5wPNGEh9GJUtVh
         MWfaAXhyz9CVK4N9m4RGrg4FuhqgVLFuARqpl21CWixFo3a2QRtqnVqN+yiimB24Urcj
         WSN7yexAt+3Ei6EICeEAzQFV+90mDGkCqLMJntb27LvsGN7oI5q6tT2jtrnvjJVAQJvk
         UCWTjou3ato9abQ0XMycNo3eMVnm1TPyLDfJKoKCOGTnY14TLFcKGdR9LaNdhwacu8zl
         Nmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mto/bao0NUaIS5cYZmVQLCHYp4FUGskW/4WKbu/YRgI=;
        b=NghEB+ABbe2Hs+Mz0lraqEuVjMCXMBlACefEaOFSBV4RV5ZLsnGBQi9YRygbI37BB1
         cwAG5fRm6pKZUVsHx3FfN5wDpnhDmSENSfsjE8DHjUHGQWe0/WlVJLLuD1BSvK0e+zVF
         JttZsscGfr9i0lFZ4kz0e7iYej1JBzNItbvunlUwth3+wGFh+N4kwLO2De9q4gHv6daQ
         Es0dsyQ0xibhDVNDgaQAHOQ/Ux3OgWVtbT88GhAiNGmIKmt3W80UwwAafjah/WPTQaZq
         /ReLZ84Bn7zH65Etm20u3LvwpCLAS6QdRv3gH+fogdgJlqorOsTuWmSQS8WDXc3wkYTB
         VYUA==
X-Gm-Message-State: ABuFfogs2A7o3kMi0ihqO0+4ZoVXCzvz6m632Dd+gL8rSnUfMXFccSee
        zQaEDe1nK+/kPqZ7kxf3fJEfRPk6oIvupZ/Va3leAC+4
X-Google-Smtp-Source: ACcGV61BTtpOXmJwSnzMkOc5BV4GgkckqkBvsiXQu7Cb3+uKVcpTZYFHAcdxacZ5pxwaIipMM9dK7tOAWJF+fk+7x3Y=
X-Received: by 2002:adf:f44b:: with SMTP id f11-v6mr539909wrp.305.1539245689073;
 Thu, 11 Oct 2018 01:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181010150916.4295-1-lucas.demarchi@intel.com> <87in29dj55.fsf@evledraar.gmail.com>
In-Reply-To: <87in29dj55.fsf@evledraar.gmail.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 11 Oct 2018 01:14:37 -0700
Message-ID: <CAKi4VAL+qSObOABeNHVXGytE9aB3sUJtecE5jYF6_ZfDA+J0ZQ@mail.gmail.com>
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
To:     avarab@gmail.com
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>, git@vger.kernel.org,
        johannes.schindelin@gmx.de, t.gummerer@gmail.com,
        sunshine@sunshineco.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 12:42 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Oct 10 2018, Lucas De Marchi wrote:
>
> > Do like it's done in grep so mode doesn't end up as
> > 0160000, which means range-diff doesn't work if one has
> > "submodule.diff =3D log" in the configuration. Without this
> > while using range-diff I only get a
> >
> >     Submodule a 0000000...0000000 (new submodule)
>
> I'm not familiar enough with this to tell what the real problem is
> that's being solved from the commit message, but if it means that now
> range-diff works in some configuration, presumably that can be reduced
> to a simple set of commands that didn't work before but now does, and
> therefore a test in t/t3206-range-diff.sh.

$ git config --global diff.submodule log
$ git range-diff

This produces the output above

$ git config --global diff.submodule short
$ git range-diff

This blocks forever in a wait4() call and prints this when terminated:
fatal: exec 'diff': cd to 'a' failed: Not a directory

Lucas De Marchi

>
> > instead of the diff between the revisions.
> >
> > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > ---
> >  range-diff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/range-diff.c b/range-diff.c
> > index 60edb2f518..bd8083f2d1 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const cha=
r *name, const char *p)
> >  {
> >       struct diff_filespec *spec =3D alloc_filespec(name);
> >
> > -     fill_filespec(spec, &null_oid, 0, 0644);
> > +     fill_filespec(spec, &null_oid, 0, 0100644);
> >       spec->data =3D (char *)p;
> >       spec->size =3D strlen(p);
> >       spec->should_munmap =3D 0;



--=20
Lucas De Marchi
