Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459AD1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 23:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKOJV5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 04:21:57 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45938 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOJV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 04:21:57 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so5146068uam.12
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 15:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aZ2XCbmw4J4bD/tBNy7d9sOIvtXUwALWKXpWMy7h4qM=;
        b=CjSj/jv3isdNqp+YVARFjIE3FlZJyxrKK6C3EtJ8uMScTV+3fYa9cpwkkMpXt136cH
         sA2gzf/PvjW1l2Gvopkn8qNWR7MegQQiMtzKXK0tEMr6hvh9ApVpZhYV62OqTTXRLr2U
         LJd8n38Q9+Mrh0ys2nSfQfg7uYdl5pDl2nYUuOFnsdSBzV35VExoGoUI4SFIN2fcLlX9
         WDoAWaNL72e1YIGtE/nd/KRCl3GJO7s9YoX/Kn1WFWwxeCY3fdKG9a7A9U1zkKipkMOQ
         Vw05u65+zjpwPD68oz6DzH8WbcIpZR9gZ8B2+RIVJpH/sBOsPVlFym5azW84KhrnlPT4
         35rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aZ2XCbmw4J4bD/tBNy7d9sOIvtXUwALWKXpWMy7h4qM=;
        b=px1qSZ0EIRN2/IjWNtXifOKiPsqggtSH2Mi0/LrUeSd682q1YYbOOBqErxgPZ0rCb/
         awmGn/fMZqQKztnx4ciB7GFVrk0C9XDlIaqV+gBW/g0X77tNQLfC2vY2OiAWrd1UkMUs
         4OCzcl7aTKUQmq1q4Jg1H9GXikrBBGO3tl5plVhjrcLYpSzlkf46tQ1dXDyRU2Y1cbW2
         Q/khboBt7F5XftSkDQm5EPN/8B0jfVyXyLBU2iRzNpoBxgvqruWRAfvdwiPu5r+Wb19T
         sYHM7dmfkLY/Youpm7G0xpYAOIbfWeD2aB7cVC/wBT96woq1IikyWR374+YPobDWXPXT
         DG2w==
X-Gm-Message-State: AGRZ1gKwoy2YF5SQRbnp05BPn3KCEYuIp8wR81uNbV7Manfi2GPTiE9R
        QgMxNaUKXjKtYRG+KSA4LSbNyiYpaRD2yucLaCV0Rw==
X-Google-Smtp-Source: AJdET5fAxRXzN6YRAmOvBhdX8gS2+WXZJ2LVEdxzVGATvudchVUm2EpWxoOZJ8jmMWlDZHEnDmkUUQNOdi8sHpo7tcQ=
X-Received: by 2002:ab0:2314:: with SMTP id a20mr1802381uao.130.1542237396429;
 Wed, 14 Nov 2018 15:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20181111062312.16342-1-newren@gmail.com> <20181114002600.29233-1-newren@gmail.com>
 <20181114002600.29233-9-newren@gmail.com> <20181114192758.GK30222@szeder.dev>
In-Reply-To: <20181114192758.GK30222@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Nov 2018 15:16:25 -0800
Message-ID: <CABPp-BGqS4KgSaJ85Kku1xFaFw4Cq0UsVDkk389EC+VLtU__3Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] fast-export: add --reference-excluded-parents option
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 11:28 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Tue, Nov 13, 2018 at 04:25:57PM -0800, Elijah Newren wrote:
> > diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> > index 2fef00436b..3cc98c31ad 100644
> > --- a/builtin/fast-export.c
> > +++ b/builtin/fast-export.c
> > @@ -37,6 +37,7 @@ static int fake_missing_tagger;
> >  static int use_done_feature;
> >  static int no_data;
> >  static int full_tree;
> > +static int reference_excluded_commits;
> >  static struct string_list extra_refs =3D STRING_LIST_INIT_NODUP;
> >  static struct string_list tag_refs =3D STRING_LIST_INIT_NODUP;
> >  static struct refspec refspecs =3D REFSPEC_INIT_FETCH;
> > @@ -596,7 +597,8 @@ static void handle_commit(struct commit *commit, st=
ruct rev_info *rev,
> >               message +=3D 2;
> >
> >       if (commit->parents &&
> > -         get_object_mark(&commit->parents->item->object) !=3D 0 &&
> > +         (get_object_mark(&commit->parents->item->object) !=3D 0 ||
> > +          reference_excluded_commits) &&
> >           !full_tree) {
> >               parse_commit_or_die(commit->parents->item);
> >               diff_tree_oid(get_commit_tree_oid(commit->parents->item),
> > @@ -644,13 +646,21 @@ static void handle_commit(struct commit *commit, =
struct rev_info *rev,
> >       unuse_commit_buffer(commit, commit_buffer);
> >
> >       for (i =3D 0, p =3D commit->parents; p; p =3D p->next) {
> > -             int mark =3D get_object_mark(&p->item->object);
> > -             if (!mark)
> > +             struct object *obj =3D &p->item->object;
> > +             int mark =3D get_object_mark(obj);
> > +
> > +             if (!mark && !reference_excluded_commits)
> >                       continue;
> >               if (i =3D=3D 0)
> > -                     printf("from :%d\n", mark);
> > +                     printf("from ");
> > +             else
> > +                     printf("merge ");
> > +             if (mark)
> > +                     printf(":%d\n", mark);
> >               else
> > -                     printf("merge :%d\n", mark);
> > +                     printf("%s\n", sha1_to_hex(anonymize ?
> > +                                                anonymize_sha1(&obj->o=
id) :
> > +                                                obj->oid.hash));
>
> Since we intend to move away from SHA-1, would this be a good time to
> add an anonymize_oid() function, "while at it"?

Since I already need to add a cleanup commit to remove the
pre-existing sha1_to_hex() calls, I'll just
s/anonymize_sha1/anonymize_oid/ while at it in the same commit; it's
not called from any other file.

> >               i++;
> >       }
> >
> > @@ -931,13 +941,22 @@ static void handle_tags_and_duplicates(struct str=
ing_list *extras)
> >                               /*
> >                                * Getting here means we have a commit wh=
ich
> >                                * was excluded by a negative refspec (e.=
g.
> > -                              * fast-export ^master master).  If the u=
ser
> > +                              * fast-export ^master master).  If we ar=
e
> > +                              * referencing excluded commits, set the =
ref
> > +                              * to the exact commit.  Otherwise, the u=
ser
> >                                * wants the branch exported but every co=
mmit
> > -                              * in its history to be deleted, that sou=
nds
> > -                              * like a ref deletion to me.
> > +                              * in its history to be deleted, which ba=
sically
> > +                              * just means deletion of the ref.
> >                                */
> > -                             printf("reset %s\nfrom %s\n\n",
> > -                                    name, sha1_to_hex(null_sha1));
> > +                             if (!reference_excluded_commits) {
> > +                                     /* delete the ref */
> > +                                     printf("reset %s\nfrom %s\n\n",
> > +                                            name, sha1_to_hex(null_sha=
1));
> > +                                     continue;
> > +                             }
> > +                             /* set ref to commit using oid, not mark =
*/
> > +                             printf("reset %s\nfrom %s\n\n", name,
> > +                                    sha1_to_hex(commit->object.oid.has=
h));
>
> Please use oid_to_hex(&commit->object.oid) instead.

Yeah, there were a couple others I introduced too.  I'll fix them all up.
