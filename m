Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C769E20248
	for <e@80x24.org>; Sat, 13 Apr 2019 14:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDMOAa (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 10:00:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38839 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfDMOAa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 10:00:30 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so20330878ita.3
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Scy7zfvX+9ll0qfWgSVmz4ZoEPdyw/UrpqqJtAOoRk=;
        b=IEEf+vMX/LIUI4xlo+9WJApbMwlNvZeoY6ise31cjm5khEILhICa8b9SwPZJV8zs6c
         i2lNpc4Akd9knAvKuK/Tgly06p/JBFwSch/Vr0Si9A8L0aCRmd9p27buY9KRqavdcm5+
         xiFNtCmgiR+O6ZTveeDM0JxHvb1IXteODmK9Vn2h1CKo4ke/WzBfHONwqpGZCNowijyZ
         XwmMkr7q6fOO+jsADqMhdxixj7w594/wdj6LUGSMiMxnbHbsmhtEJSbHeukGx0Vmdcrx
         AGEIy4HLUjmaMhqsKrN2B+eJNOm05dJIXmuxMkfeFawmdDfIhZjRwaAMWYPC3FW7UCEm
         g+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Scy7zfvX+9ll0qfWgSVmz4ZoEPdyw/UrpqqJtAOoRk=;
        b=nLvRqxle28sPnqQ9tICAQG3+RrFhXQICs95Oyk+wTp14IjTjfdwRKYim8BbT9QmgCI
         99r9T3XvNLKvTu0+oEA/OE+3leLLNAXOtk4FzTiONh9w7v700NvyMkOx+xuXpcdh5saL
         jEeQbObZVonqj0GECuKXC+Z3I+Q8mSZ8JU7vY5rsmUyyTmyUo6LNr7Cr/Rkt+yYaRRW1
         WFtFB5omocM/lzl/k5zFg2PUnkJbwRjl/bEcGpsujK0xGSXV5RdDdcCbxXDeByb4jmGy
         VBD8myQC1LWL2NB0/YDVSaY/FAD2EoAOK7OSXVlL3TMaWzXT/bZIgHVViKldE3+pfis9
         oIKQ==
X-Gm-Message-State: APjAAAWEFuEzIBEuDmullqjqISdddOSpeE5mRWqtEwxQglFyeI7yWlh1
        YqXr55sxeCduY3ArUcNUHB/+0Kc2qppitBB2zfE=
X-Google-Smtp-Source: APXvYqyCslUd48NOvLqZnERYR4cPcc4+yemSOFJvLE6h72ln0ckLnlKyYcbr4jVjsti1vr2OVSh3FOMwvoB3BSq+7Sg=
X-Received: by 2002:a24:f8c7:: with SMTP id a190mr17180047ith.72.1555164029245;
 Sat, 13 Apr 2019 07:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190403113457.20399-1-pclouds@gmail.com> <20190406113453.5149-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet> <20190411205146.GK8796@szeder.dev>
 <20190411205857.GL8796@szeder.dev> <20190412001730.GM8796@szeder.dev>
 <nycvar.QRO.7.76.6.1904121624160.41@tvgsbejvaqbjf.bet> <20190413121432.GB15936@szeder.dev>
In-Reply-To: <20190413121432.GB15936@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 13 Apr 2019 21:00:02 +0700
Message-ID: <CACsJy8DxOV6qSFPNZd_zvbnOiTETqnnK3NS+u0fhNLnuesEQhg@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 13, 2019 at 7:14 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Fri, Apr 12, 2019 at 04:25:08PM +0200, Johannes Schindelin wrote:
> > Hi,
> >
> > On Fri, 12 Apr 2019, SZEDER G=C3=A1bor wrote:
> >
> > > On Thu, Apr 11, 2019 at 10:58:57PM +0200, SZEDER G=C3=A1bor wrote:
> > > > On Thu, Apr 11, 2019 at 10:51:46PM +0200, SZEDER G=C3=A1bor wrote:
> > > > > On Wed, Apr 10, 2019 at 10:56:52PM +0200, Johannes Schindelin wro=
te:
> > > > > > >         ...>}
> > > > > > >
> > > > > > >       @@
> > > > > > >     + expression c;
> > > > > > >     ++expression r;
> > > > > > >     + expression s;
> > > > > > >     + @@
> > > > > > >     +-- get_commit_tree(c) =3D s
> > > > > > >     ++- repo_get_commit_tree(r, c) =3D s
> > > > > > >     + + c->maybe_tree =3D s
> > > > > >
> > > > > > I think this is wrong, and admittedly I had the very same versi=
on
> > > > > > originally.
> > > > > >
> > > > > > When you have an arbitrary `r` in any `repo_get_commit_tree(r, =
c)` (as
> > > > > > opposed to `the_repository`), the conversion to `c->maybe_tree`=
 is most
> > > > > > likely incorrect.
> > > > > >
> > > > > > Therefore, I don't think that we can do that.
> > > > >
> > > > > So, as far as I understand, the goal of these 'c->maybe_tree'-rel=
ated
> > > > > semantic patches is to prevent "generic" parts of Git from access=
ing
> > > > > this field directly, as it might not be initialized in a
> > > > > commit-graph-enabled repository.
> > > > >
> > > > > Only three functions are explicitly exempt, while this last seman=
tic
> > > > > patch in question implicitly allows a few more that assign a valu=
e to
> > > > > 'c->maybe_tree'.  These functions are release_commit_memory() and
> > > > > parse_commit_buffer() in 'commit.c' and fill_commit_in_graph() in
> > > > > 'commit-graph.c',
> > >
> > > ... and make_virtual_commit() in 'merge-recursive.c'.
> > >
> > > > and after a quick look these functions seem to be
> > > > > rather fundamenal in the life-cycle of a commit object.
> > > >
> > > > Erm, not "commit object"; I meant the life-cycle of a 'struct commi=
t'
> > > > instance.
> > > >
> > > > > I think they deserve to be explicitly exempted, too, and then we =
could
> > > > > remove this last semantic patch altogether.
> > >
> > > And it would look like this.  Yeah, that's a very long line there, bu=
t
> > > I don't think we can break it up.
> > >
> > >   -- >8 --
> > >
> > > diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/com=
mit.cocci
> > > index 57c8f71479..fe814f313e 100644
> > > --- a/contrib/coccinelle/commit.cocci
> > > +++ b/contrib/coccinelle/commit.cocci
> > > @@ -10,20 +10,15 @@ expression c;
> > >  - c->maybe_tree->object.oid.hash
> > >  + get_commit_tree_oid(c)->hash
> > >
> > > -// These excluded functions must access c->maybe_tree direcly.
> > > +// These excluded functions must access/modify c->maybe_tree direcly=
.
> > > +// Note that if c->maybe_tree is written somewhere outside of these
> > > +// functions, then the recommended transformation will be bogus with
> > > +// repo_get_commit_tree() on the LHS.
> > >  @@
> > > -identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one=
|load_tree_for_commit)$";
> > > -expression c;
> > > +identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one=
|load_tree_for_commit|fill_commit_in_graph|parse_commit_buffer|release_comm=
it_memory|make_virtual_commit)$";
> >
> > Hahahaha! That's *really* long.
> >
> > And a good indicator that this should be hidden in a single helper
> > function (`set_commit_tree()`, file-local of course) that is exempted i=
n
> > the cocci patch.
>
> Note that this is not only about line length, and consider the slight
> differences between the three approaches:
>
>   - Currently only direct read accesses to 'c->maybe_tree' outside of
>     the listed functions are forbidden and transformed, but still any
>     function can set this field directly (thanks to the last semantic
>     patch in 'commit.cocci').
>
>   - Encapsulating writes in set_commit_tree() and adding this function
>     to that list would prevent other functions from setting
>     'c->maybe_tree' directly, but still any function could set it
>     indirectly by calling set_commit_tree().
>
>   - With that loooong line only those few listed special functions
>     would be able read or write 'c->maybe_tree'.
>
> Does the additional restriction of the long line variant bring us
> benefits?  Well, not sure.
>
> The root tree of a commit is needed in many places, and in the past we
> got used to it being always initialized in any 'struct commit'
> instance.  However, with the commit graph that's not the case anymore,
> and any read accesses to the uninitialized root tree object would have
> bad consequences.  That's why there is get_commit_tree() helper
> performing lazy-initialization, and the protection from direct reads
> in the form of the semantic patch.

And I think set_commit_tree() is a good way to go. Basically
"maybe_tree" is not safe to be manipulated directly because of traps
and pitfalls. If we have one entry point to update maybe_tree, we can
handle all that in one place (even though I don't foresee any special
handling when updating it). Keeping commit.cocci shorter is just a
side bonus.
--=20
Duy
