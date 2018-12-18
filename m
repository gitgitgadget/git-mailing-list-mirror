Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553A91F405
	for <e@80x24.org>; Tue, 18 Dec 2018 19:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeLRTuY (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 14:50:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53382 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLRTuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 14:50:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so3859040wmb.3
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41wHDxklIQyAW45ZLJ7U/CPYY6rM2uX2tcmJN6uw0as=;
        b=sd1UbET4exflRXddQJUs5c6wp+dUS7sN3tQIFCO4e1dDu1uQpOAdTSNY+R/TdlUg/+
         +pncoES0v9rktJbKafzpbazN91U2ixjPBS3FaxB01AUJbYKgS9YNTDZxY58DPm/64kQf
         cnGQ9sKPqX3ayQiRIN3NkbFM0nJMPHjN6vSopFxDbFBJMJi8W2NQBbdCVgzjkLhaNZiO
         TMKxrP2AUn18A01Lr9aXZ62i+sDFNZvMlnmsQ+M3l0HqC+FKHvlC8RHcp0QJDz24VGLC
         f1gKj8Fod+C2tljTxAFu869uGKuZHXMjjNHIRpkimo/kD+I9ydDOnkMWTFArnzfS9Ntc
         PiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41wHDxklIQyAW45ZLJ7U/CPYY6rM2uX2tcmJN6uw0as=;
        b=ZBvqOGeOfilG7pwEPU48GQ0gNwuhTkP63bhHJF9PoFhuj+D7Ec/TwQm7sNbP0CrDYt
         Mh2+f6xs2aY9URNWyQjLG2AUk/ZwqWPeCkb9+0ZbfjdYPBYdGwbsh5icM+T4gONev1Bn
         B/NbDUnyfrzVXdvAJbNkXP5Lkr0vRnBSLb29W7kWqcuop+8sGaT7zqRCaek5vr77l1+c
         2+H3Wzo++R/B+A+PYKx9eVbGhSBMxJ7u6g0Z7bS0WEiTw4SCEJjeKB9zJgHMMWo2Em+S
         MwqDMHcSH6BDiZo02dqT5o7Rr7SeWXteMBFjAM/HYjAJi0Vm7VIPnMni8aJa+iF5mnu5
         8ZKw==
X-Gm-Message-State: AA+aEWYBO2bBNEFfLzb7Q5IB7Fb27pW5vdnnzq46GeQ98FxZpBfv1+ly
        gPQCmG3Ma5/L1YH2/Qhj93VSL3Re7/hos56lIvy4tQtK
X-Google-Smtp-Source: AFSGD/VG2dY3F5m9+3YpPaTAbDafVtMNUuZ6aj0kGdYPvjAbNGBxn7SlLVfOv0WDQclGAPn6rbAak2FlSoMi6RuIY+0=
X-Received: by 2002:a1c:1112:: with SMTP id 18mr4712274wmr.30.1545162621462;
 Tue, 18 Dec 2018 11:50:21 -0800 (PST)
MIME-Version: 1.0
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
 <1544922308-740-1-git-send-email-eedahlgren@gmail.com> <nycvar.QRO.7.76.6.1812181332370.43@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812181332370.43@tvgsbejvaqbjf.bet>
From:   Erin Dahlgren <eedahlgren@gmail.com>
Date:   Tue, 18 Dec 2018 11:50:10 -0800
Message-ID: <CAP_Smy0sW0-DiUQD1vKbbjrCDRo+6WchwHqGu+sDXH8fsbiYEw@mail.gmail.com>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently()
 failure cases.
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry Johannes for the repeat message, I failed to send to all.

On Tue, Dec 18, 2018 at 4:35 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Erin,
>
> On Sat, 15 Dec 2018, Erin Dahlgren wrote:
>
> > diff --git a/setup.c b/setup.c
> > index 1be5037..e1a9e17 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -831,16 +831,6 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
> >       return NULL;
> >  }
> >
> > -static const char *setup_nongit(const char *cwd, int *nongit_ok)
> > -{
> > -     if (!nongit_ok)
> > -             die(_("not a git repository (or any of the parent directories): %s"), DEFAULT_GIT_DIR_ENVIRONMENT);
> > -     if (chdir(cwd))
> > -             die_errno(_("cannot come back to cwd"));
> > -     *nongit_ok = 1;
> > -     return NULL;
> > -}
> > -
> >  static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_len)
> >  {
> >       struct stat buf;
> > @@ -1097,18 +1087,20 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >               prefix = setup_bare_git_dir(&cwd, dir.len, &repo_fmt, nongit_ok);
> >               break;
> >       case GIT_DIR_HIT_CEILING:
> > -             prefix = setup_nongit(cwd.buf, nongit_ok);
> > -             break;
> > +             if (!nongit_ok)
> > +                     die(_("not a git repository (or any of the parent directories): %s"),
> > +                                     DEFAULT_GIT_DIR_ENVIRONMENT);
>
> I am terribly sorry to bother you about formatting issues (in my mind, it
> is quite an annoying thing that we still have no fully automatic way to
> format Git's source code according to Git's preferred coding style, but
> there you go...): this `DEFAULT_GIT_DIR_ENVIRONMENT` should be aligned
> with the first parameter of `die()`, i.e.
>
> +               if (!nongit_ok)
> +                       die(_("not a git repository (or any of the parent directories): %s"),
> +                           DEFAULT_GIT_DIR_ENVIRONMENT);
>
> > +             *nongit_ok = 1;
> > +             strbuf_release(&dir);
> > +             return NULL;
> >       case GIT_DIR_HIT_MOUNT_POINT:
> > -             if (nongit_ok) {
> > -                     *nongit_ok = 1;
> > -                     strbuf_release(&cwd);
> > -                     strbuf_release(&dir);
> > -                     return NULL;
> > -             }
> > -             die(_("not a git repository (or any parent up to mount point %s)\n"
> > -                   "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
> > -                 dir.buf);
> > +             if (!nongit_ok)
> > +                     die(_("not a git repository (or any parent up to mount point %s)\n"
> > +                           "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
> > +                                     dir.buf);
>
> Likewise, `dir.buf` should be aligned with the `_` two lines above.

Hi Johannes,

No problem, I'll make those changes.

I'd be interested to hear the arguments against a "fully automatic way
to format Git's source code according to Git's preferred coding
style". If there aren't any then I'd be willing to take a crack at it.
Should we start a separate "discussion" thread?

>
> Otherwise I think this patch is good to go!
>
> Thank you,
> Johannes
>
> > +             *nongit_ok = 1;
> > +             strbuf_release(&dir);
> > +             return NULL;
> >       default:
> >               BUG("unhandled setup_git_directory_1() result");
> >       }
> > --
> > 2.7.4
> >
> >
