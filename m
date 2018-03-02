Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3661F404
	for <e@80x24.org>; Fri,  2 Mar 2018 20:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933031AbeCBUd7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 15:33:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:59343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932960AbeCBUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 15:33:56 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lug4m-1eixSO13Fw-00znAb; Fri, 02
 Mar 2018 21:33:48 +0100
Date:   Fri, 2 Mar 2018 21:33:46 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 01/12] sequencer: avoid using errno clobbered by
 rollback_lock_file()
In-Reply-To: <CAN0heSpCiHxGDnWyafTQU4+++73JGRW9w0Bq1nd2LcqgMqOnzA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803022133320.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519680483.git.johannes.schindelin@gmx.de> <8ec3a73dfdc76c503d50e34e5fc8b8a3d5ea7dd8.1519680483.git.johannes.schindelin@gmx.de>
 <CAN0heSpCiHxGDnWyafTQU4+++73JGRW9w0Bq1nd2LcqgMqOnzA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-710415295-1520022828=:56"
X-Provags-ID: V03:K0:L0CmHmY4cWdBdzTb06hQtx7/TMKwn1e9cPmu4KIzleK+SV4tzyX
 G6Ypa0QgXStMeJPrKGw7PJkG3xpS7Gz35tUFLGCClcBouM9/9SYrm07xNY0gv86QyLn1vNM
 a92rlecSNXB+yP0daH6q17YqB4mKkYZmUc39FKQ0WGJt16Qsu60STo8F4Kx1CIbDMoVDxhp
 jUZnxtfqs5I4E932M7GEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:16k8N3SI0rA=:auYichW+mfRSvladBVmH7k
 UrhVawJPaASV9CJude51Go2OtdJbRwVAGwYnO7H8dRMasbpqjz3BaVCeT8KFxbZRadZIB/jqt
 q7HvTLKYS0J3Zl4FZJXAh1Jhe6KVbpoctukX/bI3JRFdZxZyuD+o/R27XVh51maDNI1xo2V5G
 2UCdeWjAP4mZ2HFBG8F0JHajTi+xSq6UDQmF8zuF8iLVNJMPARxoZoTT0hvNgqkp7zf4VDFYt
 cLyBVkFi4govPSgaENtAogjpc6rFcYQfnqDUKt33AU5hb6je3HdFRYTOVfSSMmoajGQIoD0Om
 UaSNbrQeQNRZoXOxul11sWv8d+rmj8/Cfp5brfafToQSyl9v8lj/w6OLYGMjHGEXJIy+MyWw1
 x8Y/jY+QOCx76l0aQK8zh/6zmfIVKGCVMEvwp8VdZzrCKym4JjikFakN36AzY5Ji2SlHlsBq3
 MHOSxXPVBOQ5pA+FPTrXpbDBNIKHbNz5coS2DdUP6P+7uNhP8V5Mcnd9Hh0DcVOAXOmdppxol
 iShTpieOWw+i9RAnLFVbWLlAIlyOw9j95k3YDTexoS7Vtkzae7VFhKv6X8OsD9745uO/yAhqU
 YmOa/LXuzgZ7IRJAQlS55fXNxa/yXdDG+VS+/d8Tg6K6KuR7jTv5SLrMceKJP6z12R7dXh13p
 Y/aooGICAyk+khD4EHgeTk3nkog4ufn46GU3G5cN9XQX7+xyYELf9n3duBG08c7pLC5WgY0I9
 7hGRGyHydSYfM02wfGt1He9Ye9kyfPOmMqZkMNhO4oRt2W8vB3WGeVem4308hnzveVnJDOuqi
 CjIMDW/PU0cBWjSlIGFnwo3opI57dI+OB1W8REHxL9uiSQgJMCPZ9nSV3SoYmIYNkMahIy5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-710415295-1520022828=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Tue, 27 Feb 2018, Martin =C3=85gren wrote:

> On 26 February 2018 at 22:29, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > As pointed out in a review of the `--recreate-merges` patch series,
> > `rollback_lock_file()` clobbers errno. Therefore, we have to report the
> > error message that uses errno before calling said function.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index e9baaf59bd9..5aa3dc3c95c 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -345,12 +345,14 @@ static int write_message(const void *buf, size_t =
len, const char *filename,
> >         if (msg_fd < 0)
> >                 return error_errno(_("could not lock '%s'"), filename);
> >         if (write_in_full(msg_fd, buf, len) < 0) {
> > +               error_errno(_("could not write to '%s'"), filename);
> >                 rollback_lock_file(&msg_file);
> > -               return error_errno(_("could not write to '%s'"), filena=
me);
> > +               return -1;
> >         }
> >         if (append_eol && write(msg_fd, "\n", 1) < 0) {
> > +               error_errno(_("could not write eol to '%s'"), filename)=
;
> >                 rollback_lock_file(&msg_file);
> > -               return error_errno(_("could not write eol to '%s'"), fi=
lename);
> > +               return -1;
> >         }
> >         if (commit_lock_file(&msg_file) < 0) {
> >                 rollback_lock_file(&msg_file);
> > @@ -2106,16 +2108,17 @@ static int save_head(const char *head)
> >
> >         fd =3D hold_lock_file_for_update(&head_lock, git_path_head_file=
(), 0);
> >         if (fd < 0) {
> > +               error_errno(_("could not lock HEAD"));
> >                 rollback_lock_file(&head_lock);
> > -               return error_errno(_("could not lock HEAD"));
> > +               return -1;
> >         }
>=20
> I just noticed this when test-merging my series of lockfile-fixes to pu.
> This `rollback_lock_file()` is not needed, since failure to take the
> lock leaves it unlocked. If one wants to roll back the lock "for
> clarity" or "just to be safe", then the same should arguably be done in
> `write_message()`, just barely visible at the top of this diff.
>=20
> Perhaps not worth a reroll. The conflict resolution between this and my
> patch would be to take my hunk.
>=20
> https://public-inbox.org/git/cover.1519763396.git.martin.agren@gmail.com/=
T/#t

Thank you for working on this!
Dscho
--8323329-710415295-1520022828=:56--
