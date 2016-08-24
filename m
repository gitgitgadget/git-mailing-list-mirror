Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCC71F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbcHXQFy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:05:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:63044 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbcHXQFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:05:53 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MPDaC-1bYCxB3lUe-004TAm; Wed, 24 Aug 2016 18:05:10
 +0200
Date:   Wed, 24 Aug 2016 18:05:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] sequencer: lib'ify save_todo()
In-Reply-To: <CAPig+cQ2xH1ytsTGNDeDZiHTZpnp28XUJoAY+W-+iw+85gMbtg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608241801030.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <fff4cdfa36355af7917a06be9f67b50b56bfce99.1471968378.git.johannes.schindelin@gmx.de> <CAPig+cQ2xH1ytsTGNDeDZiHTZpnp28XUJoAY+W-+iw+85gMbtg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zCGHsT5zkub1+Pekh0saCGs89OxanYs6BS7f4j3n3CDG3Utua8w
 1rzakgUY/QDYzx7JA5+ZDEhlWEiUvGuWIFPOyJcpFWNA4r9M4OlTHoOvu6HH5Qnph92Tueg
 pfVznVX/+40Xq5ax1gdG2m0azmuBtpPc9F7zq8To0pVtiOoKA/iTpJwHp+pcMcS5rhyUMQl
 x44aQsIYcAJ4EKenJjw3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OV3JL9W03LU=:+X26n8nMn7uZVFAoQJtg4i
 QyHGEUTN60sgDj/xznGCuI2iGm+Bq6rfaEU4zcHar9AGG+WosTmlebBdAuLJybFwMvOYqgHLH
 ztrbxKnZhZYOAgxiTNDSdwQ2EoOsRjDoFm4jF5Vw05XCnqkLCmJlPA8fiMeQCULLbH8oWf1ql
 +hwCmLfQxpy2tDs/RPnPbM1bs6Pw2JlgMipxpPXzZuHhNXHUjx70oE44c+sZ5tNmiHFEdFCU9
 RRVwCaeNLoJQ2BLsLHTtExwW4FYEX2EVoBSKEnMJ+BD3hW9cOfqxe53sN9HHyip/ji/1lVr+k
 kovskruA86nQUzJTjw3eEBR7BHjdc7+vJpSGnOrQWL9sWCqua3+d1k+nvz0w0StTrs9DkBv6y
 gNWD8O5CoqHbHQ+pOCz2JlJPbPuLuQhgMp2pJti2f5s+OIq391L3Au+1pykUow3/jiXlcI8mj
 Qoh4PY9sRlwNjWEFj3WP2zDJtLDNbDtVm7TF9Ybiezw5YcOLQptL2wGwXhFL63fPluc9GyBqL
 tmIL4kuJDBWLpyhNWarReMNzSzqFxfSSHH+GJOzcCYqvFgpdnQC1Qbli3N7ThTKC9AYVFQSA0
 EGuaj3a6RUEPAZcgJ7nmdVx0q4fBi4BiXDYVeS7maMKSbxQ/qUG6Wm+PML114PRpH5vEDNGlR
 2ZMPAmZR/HUufHk2nLLWjvRS1Cb2QvpZzKcPPxkqjFzfvbUiGn5ZyJ4p8KinQdp+8FZfvzAAt
 VcWCbeNUbaTOExraD2DJRJU1tCL81YB1j6PiVY3cyjMmYNDXWQV0EgoPju0HA29qv5GyxHBHo
 1urXA7K
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
> > @@ -929,24 +929,29 @@ static int sequencer_rollback(struct replay_opts *opts)
> > -static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
> > +static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
> >  {
> >         static struct lock_file todo_lock;
> >         struct strbuf buf = STRBUF_INIT;
> >         int fd;
> >
> > -       fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), LOCK_DIE_ON_ERROR);
> > +       fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), 0);
> > +       if (fd < 0)
> > +               return error_errno(_("Could not lock '%s'"),
> > +                                  git_path_todo_file());
> >         if (format_todo(&buf, todo_list, opts) < 0)
> > -               die(_("Could not format %s."), git_path_todo_file());
> > +               return error(_("Could not format %s."), git_path_todo_file());
> 
> format_todo() doesn't seem to make any promises about the state of the
> strbuf upon error, so should this be releasing the strbuf before
> returning?

Yes, it should. Thank you!

> >         if (write_in_full(fd, buf.buf, buf.len) < 0) {
> >                 strbuf_release(&buf);
> > -               die_errno(_("Could not write to %s"), git_path_todo_file());
> > +               return error_errno(_("Could not write to %s"),
> > +                                  git_path_todo_file());
> 
> Do the above two new error returns need to rollback the lockfile?

As before, atexit() handler to the rescue ;-)

Thanks,
Dscho
