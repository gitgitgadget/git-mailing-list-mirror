Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5BB1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbcHXQAJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:00:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:50948 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbcHXQAI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:00:08 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MD9q8-1bM96e3vUi-00Gcdb; Wed, 24 Aug 2016 17:59:57
 +0200
Date:   Wed, 24 Aug 2016 17:59:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/15] sequencer: lib'ify save_head()
In-Reply-To: <CAPig+cSxeOkT7fLuCQrGJNabPfx1855+1-5pqcq0==22mzJk9w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608241759370.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <416659fa3df92eabf3265ec079a6ea8cbc17366f.1471968378.git.johannes.schindelin@gmx.de> <CAPig+cSxeOkT7fLuCQrGJNabPfx1855+1-5pqcq0==22mzJk9w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Jw/iXUY2m+XhgBWogBOUd1jaz+3F6yC2OjLXUtK0cSedh2IGp0E
 2eW4tw5xUtuOKNRl9csDyzw5eg7Ep5P/htqs/YkR9/Qro8a8u01LYUx9ijmt8Lt4MonLbFL
 Kiatdsvw4rIJ4U85JATc+xtRx08UD2Xs5c23pNbdCC2Ut5AmvWhQXgCJCERB90G3WjWp4gD
 p6uA83Ulj/PQkOY+MuJkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s+ROE0gNox0=:l93xn7qavPn+ENn8R9Jv0c
 ohobYgd3avQMrJll4idR977VVoaHXVyWJwkdJr0GUUCAPlzQUU3Ej78dZdzUdK8GQNjsvIMl7
 swd9V/XYqodQ/IzxUN/zZm4IpC7gNVV7/hoNMfy+D8sgTpXTAB8N5kxIsjanKgI/LBYpexqEd
 BGtPKq7Bmqzx5u8OjpJD+1EBwOty4Sr3E5XseAGtB+D68PMWX2fbxBFCpis5DuHd2UPCYfOOa
 ECOIYwH4Tk2EGvTzbj9Ejeccv+sKjFkBDQZzSLewEORuBz/QJCbQscWk2kIKfFeZqMfsPZKj9
 /Yxi8Dc1WRzTM89FEvYfm3XvUbY5xU6c91jBXjUa5r6fsyTQgOwSxjAvfuv99CAC12uihjar6
 UK/7xO2/p2NN8yxkzW8jnhilJkvfjbqfbe5xpWmpxBfpp5NwyFmCYXeAzdNbgrrvlPJY7b1Zq
 1TNHiJxklom9va0Dsh24Hvw5a+yVt13nM2GGMe5CGIPnirpmVJa9voJaah92N0MByAB/UOm6/
 /oHeDFeITiW/JUo9qlvyW6gzOhmOKNWKCnDPJmpTGfnkdtT9LF0npold80iZNZCZocI8tQFHp
 09tPtUC7dezm20gRJHWdRZYCNwnGX2TScNaU0gVMm/SM5L6YbndrM2EGmc0qFjvfSanIPxTO6
 088APyMTykTm4+R4AhozX431Y52C5vC5TiqKBoK593DeokMxZnMV8NdQ9wZomtVYPDplznrzD
 bAPQFIGH/a4aRQZFYpHLOQUG7gWVJXbcasSrbuzcOXwY/djqDvLaM2KDrr/e4SUiS53NZWtRd
 IaWGXQN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 24 Aug 2016, Eric Sunshine wrote:

> On Tue, Aug 23, 2016 at 12:07 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > To be truly useful, the sequencer should never die() but always return
> > an error.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -844,18 +844,22 @@ static int create_seq_dir(void)
> > -static void save_head(const char *head)
> > +static int save_head(const char *head)
> >  {
> >         static struct lock_file head_lock;
> >         struct strbuf buf = STRBUF_INIT;
> >         int fd;
> >
> > -       fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), LOCK_DIE_ON_ERROR);
> > +       fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
> > +       if (fd < 0)
> > +               return error_errno(_("Could not lock HEAD"));
> >         strbuf_addf(&buf, "%s\n", head);
> >         if (write_in_full(fd, buf.buf, buf.len) < 0)
> > -               die_errno(_("Could not write to %s"), git_path_head_file());
> > +               return error_errno(_("Could not write to %s"),
> > +                                  git_path_head_file());
> 
> Does this need to rollback the lockfile before returning?

Again, this is handled by the atexit() handler, as before.

Thanks!
Dscho
