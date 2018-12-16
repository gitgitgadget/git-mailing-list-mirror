Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7552A1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 01:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeLPBFQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 20:05:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLPBFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 20:05:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so8864794wrs.8
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 17:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fFhDV35hJQuNdwLNqnbW2XcXhWEFqq7TwaFWxWKdXM=;
        b=WBpstiJGl23aF+JRhfhrPaKGKDyrl85LRuheDNp0WEW8LfJKmGW+Q6pGf/wqfYNMDL
         ck8R8l/fvoFtcXMUGR2TB44hiAJLPIvhzsbBhNEUsxnFVQiKIuibyhrW7Qwb478usjHq
         KE23JxoBEv5udcm9L1xrpZmTnvg4sWb94ICF8BnwiHHc4ayIJHueN6qNyvv7b9v4gspM
         VWGE/Oz1B0kf9Hh9lu2IZu50OJmRazTk24/cHVca85AkT72TtKo5cQPAWDF2FaG+qUJN
         BnCcAD1Jx5ue/KsXixYTcEQSzhgOjy7LBWM+qs3qCFn0hKuy/g1InTa8aantuzMWPzZR
         XbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fFhDV35hJQuNdwLNqnbW2XcXhWEFqq7TwaFWxWKdXM=;
        b=U9bEbRzLYbCHR7E3FQqL21Tn5a0n0cKplJebW8JYtOAnesQ7llWJcvVjrQbTGIqfQZ
         QeoKtmviAdO6vc9E8OLrQf4b/tLVJRzSPoL9ej+gHPk0AEZfYv3l7+h6QvTGIxckzvHd
         sTWLTf2fMahE/QPQXvxYQD9YJ/FOfncmgKMogqZ69VDvydc4fwxPdJW+V/wBaT4FMY/7
         UQmERZOH3s3u+lZO3w96dIr05wnrbvBiNkWYuePwrmd59ZGntUiJW7TThQHBRJKmf6Xo
         xehDDGdKC/3JhQyWMrfy+Nk/mdWzTm/dk5r6OkXBgAxAQyDpB+JYnz8OKfhfI0XnEewJ
         lKKg==
X-Gm-Message-State: AA+aEWau9FBqHsHNTL5vd16G7UY9u4pxoe87gP23v9m/ubsE8n2y237t
        wTcM5kAEw27hi3QrUrRCCY6Jb65e12+Th1LFRSbTLg==
X-Google-Smtp-Source: AFSGD/WOpb+Q2N0KX/MucI9HpidZV6x5b83pnBBpBAAr8yG7aNRRsMBfzSBhnCg0mAjap9D1oqI4DEAkyvzqfH1gQg4=
X-Received: by 2002:adf:ee46:: with SMTP id w6mr6787948wro.261.1544922313005;
 Sat, 15 Dec 2018 17:05:13 -0800 (PST)
MIME-Version: 1.0
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com> <nycvar.QRO.7.76.6.1812141130180.43@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812141130180.43@tvgsbejvaqbjf.bet>
From:   Erin Dahlgren <eedahlgren@gmail.com>
Date:   Sat, 15 Dec 2018 17:05:01 -0800
Message-ID: <CAP_Smy1q4kdZTX-38XvG47PA-HOWJZk=kmT4yS+swprC-5q4rw@mail.gmail.com>
Subject: Re: [PATCH] Simplify handling of setup_git_directory_gently() failure cases.
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 2:32 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Erin,
>
> On Thu, 13 Dec 2018, Erin Dahlgren wrote:
>
> > setup_git_directory_gently() expects two types of failures to
> > discover a git directory (e.g. .git/):
> >
> >   - GIT_DIR_HIT_CEILING: could not find a git directory in any
> >       parent directories of the cwd.
> >   - GIT_DIR_HIT_MOUNT_POINT: could not find a git directory in
> >       any parent directories up to the mount point of the cwd.
> >
> > Both cases are handled in a similar way, but there are misleading
> > and unimportant differences. In both cases, setup_git_directory_gently()
> > should:
> >
> >   - Die if we are not in a git repository. Otherwise:
> >   - Set nongit_ok = 1, indicating that we are not in a git repository
> >       but this is ok.
> >   - Call strbuf_release() on any non-static struct strbufs that we
> >       allocated.
> >
> > Before this change are two misleading additional behaviors:
> >
> >   - GIT_DIR_HIT_CEILING: setup_nongit() changes to the cwd for no
> >       apparent reason. We never had the chance to change directories
> >       up to this point so chdir(current cwd) is pointless.
> >   - GIT_DIR_HIT_MOUNT_POINT: strbuf_release() frees the buffer
> >       of a static struct strbuf (cwd). This is unnecessary because the
> >       struct is static so its buffer is always reachable. This is also
> >       misleading because nowhere else in the function is this buffer
> >       released.
> >
> > This change eliminates these two misleading additional behaviors and
> > deletes setup_nogit() because the code is clearer without it. The
> > result is that we can see clearly that GIT_DIR_HIT_CEILING and
> > GIT_DIR_HIT_MOUNT_POINT lead to the same behavior (ignoring the
> > different help messages).
> >
> > Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Erin Dahlgren <eedahlgren@gmail.com>
>
> Thank you for working on this!
>
> > ---
> >  setup.c | 34 +++++++++++++---------------------
> >  1 file changed, 13 insertions(+), 21 deletions(-)
>
> Nice! It's always good to see a code reduction with such a cleanup.
>
> Just one thing:
>
> > diff --git a/setup.c b/setup.c
> > index 1be5037..b441e39 100644
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
> > +                                             "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
> > +                                     dir.buf);
>
> This indentation would probably be better aligned with the first
> double-quote on the `die` line.

Hi Johannes,

No problem. Thanks for your time discussing and reviewing!

- Erin

>
> Otherwise: ACK!
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
