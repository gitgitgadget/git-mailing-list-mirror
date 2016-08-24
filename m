Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD2E2018E
	for <e@80x24.org>; Wed, 24 Aug 2016 15:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756452AbcHXPxN (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:53:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:52816 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756405AbcHXPxM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:53:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lpspj-1ay30216xz-00ffAo; Wed, 24 Aug 2016 17:52:57
 +0200
Date:   Wed, 24 Aug 2016 17:52:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] sequencer: lib'ify write_message()
In-Reply-To: <CAPig+cSX_F-vQ_zSrTU6BQSfMeU=5V3krE7xgmBL=g=Jr8i2MA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608241749190.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <6dc5e927cbdd1847db5b6cd75041609dd1e1f76d.1471968378.git.johannes.schindelin@gmx.de> <CAPig+cSX_F-vQ_zSrTU6BQSfMeU=5V3krE7xgmBL=g=Jr8i2MA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mNMXxt9PbSa66ph+wuPo8B/ujY9crZ/sOLPVgTJ8NODpDg7lhbp
 RAfeFSApbM1VX+N9O5kZ3RtmJbXRFxImu8ivJZU9zP715eeHvmTN787ZS+SGsilX1O9OULx
 4OWgjOIJ60Le2MfMYl0leDVpHqvtFERTTMEWoC8JQQ/qrlblaNjZnZSVK7Iapj2JZLpxg40
 gN/ePqYw5lmit2DP+yeTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5jFn9J4HsIc=:emFFbTp0LWcmTOuhNN9sNp
 Z2E9fQuAGw+XsVGABMT6jm0Nw4q1Tp5Y5zB9mOoGfaGA8TkJXiPbh3xbhPwOBVKkd143iPu7a
 D4H6/z5vq69S5svk7DH7HnN3TrJqUnE96wjUsOhJDnSuMhwy6KDjlaNagPHYG3fa0qg1PAYQx
 cxAQAOml7qlGn4zBiRp/X44CjxVuuv2UVeMs7PaSIGA2ZBLHfF6vVHySojbqNZsKsqeWIQDBe
 qL0l8stL9ihwTJ2Zdn/J4PED9ITiVwKs+eu4dXL8CHQ3XxFDHY76TV2xTdPddMkJ0bxcin4EJ
 f54SjPfJcOITJVHDSCe3VZVWwkpFPixMdTNeGOv+wtY2OWEXrjJbW+Y0NarZ3/XNUFnqZFwiv
 kvvCvSk1FUY0dJrpCKZD43LjVCiepuIuh7KgajX2kCKkj+gU+Ba4d8ln/vbUNp2fJdg+xuCcu
 ODq/rTo1pb8/tKaye5EZKChueRR7qLV7xMSKwUBIrXAWRKEIpXmtGMy1JCRfPkEFzoMsny6Fm
 HRKvFQxsAKfzdaP6ckyda6jkOvt6nRBDzMvaLGdQwoxVJxYKUsimIYhZtGwWm81skiFyYvPhM
 o5xvOCyaeQLP8XDm+7PkTTuGMRArGvg1Jh+YdqKW+BTZELDX5cYlnFkNZ5Jt4pj2nxw3vqzPh
 yutoml9DMJ/MGiU1B84Mj986jylkUoc0ZE3kPyflca4VsiR00hLM2FXnizB0zM/GzlXnxIxKC
 faNOU13wWToOhysd2i3MT5fPRtWp5WqnoAVRGdd3jHWyM1iV7B9KuwdP1S3j5at3LXmKvd6Ju
 GejClcY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 24 Aug 2016, Eric Sunshine wrote:

> On Tue, Aug 23, 2016 at 12:06 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > To be truly useful, the sequencer should never die() but always return
> > an error.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -180,17 +180,20 @@ static void print_advice(int show_hint, struct replay_opts *opts)
> > -static void write_message(struct strbuf *msgbuf, const char *filename)
> > +static int write_message(struct strbuf *msgbuf, const char *filename)
> >  {
> >         static struct lock_file msg_file;
> >
> > -       int msg_fd = hold_lock_file_for_update(&msg_file, filename,
> > -                                              LOCK_DIE_ON_ERROR);
> > +       int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
> > +       if (msg_fd < 0)
> > +               return error_errno(_("Could not lock '%s'"), filename);
> >         if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
> > -               die_errno(_("Could not write to %s"), filename);
> > +               return error_errno(_("Could not write to %s"), filename);
> 
> Does this need to rollback the lockfile before returning[*]?
> 
> [*] I'm not terribly familiar with the lockfile mechanism and I don't
> have a lot of time to study it presently, so ignore me if this is a
> stupid question.

Not a stupid question at all.

The way lockfiles work is that there is an atexit() handler that ensures
that uncommitted lockfiles get rolled back automatically. So it happens to
work correctly right now, because all (direct and transitive) callers
simply stop doing things as quickly as possible. That means that no
subsequent attempt is made to write to the same file.

Technically, I agree with you that it may look a bit cleaner to roll back
at this point. However, this is outside the purview of this here patch
series, as it would actually change the behavior (the previous die() would
rely on the atexit() handler to roll back the locked file, too). So I
think if this is to be changed, it has to be in its own, separate patch
series.

Ciao,
Dscho
