Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81B920A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 21:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeLXVYR (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 16:24:17 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40603 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXVYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 16:24:17 -0500
Received: by mail-vk1-f193.google.com with SMTP id v70so2752145vkv.7
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxNxwMGO4rYbG71Y/Y7NsW92FFZ2JYrMFd0LyA0uZSI=;
        b=l9LaRvw0P+/zthTBfFMJqKoYehhT0VDa+YzqBTr38tvjWBwHAV7ya3UU93rpC0gYQe
         5j5/QvxhJ4G7wlYOGLZ4jSboXnWtElM1CFVPTcUWoz4n4vZzlEH0lCuVRT1V7PC2rVv+
         JM11EEshRWnAQJoXOXA0P0GgrB4CkbKfxRKTXbRPRuvKMG3pUuuC3zQ88HBucuelwtS3
         I7xQspponeLQw3IWDGBmwpQap48F/7QPpnGE9QPabSf4R4aCXgc7fOpJrHvCpGbuTRav
         mBNRBX+hojuqlB5BF16Rg4AmtDmTXj74+TKzjzEN1D97anIk2NDQeLEON9fcFki0xbRI
         x37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxNxwMGO4rYbG71Y/Y7NsW92FFZ2JYrMFd0LyA0uZSI=;
        b=X3Kuf9wSKQy0UuGGIJJ8X988mwXymbpxPCf8fpBaD0d9oIbYWOaU7lWgXwB6LPZiqn
         tlLH41Jd+osuNffWgUWZcZU+ZRLpIVcelBUkYNIm1YWtz0vsExpABF1CiZyGvklG61Oi
         WhqGj/ZGQkxEYYh+6YRZtiEpBmSq3Go107jXgRNATq20pEM8jv3qKuNpFOk+RVM3yRMV
         DhCGdS+w5yi7PLhDfmwjLWd/ojm34vxMtAvCCxvx6Uc+zNe2G8zat5HI+5WWEQ6j/vm9
         9mc+muJqlCMA4uyfgQ6gCZz3lCkgZmPAlpUOGNO36W2WoBkj7nx6dWGm3oxL3R4XMV7w
         GBKw==
X-Gm-Message-State: AJcUukfK3AynqMaTmIOtbCS1/pvJpRheDelUge6QS8mYZFk5FdIccX4o
        YGGwB0vtdhLyfrEV1DVeZMrXk2IoDxtVzBHIBCE=
X-Google-Smtp-Source: ALg8bN579bJS3gkkLNaCGiRCssUHCEBzrHfTMywNTxEHAYBIiqPXuFo02oGk1vM/ZcrwYZYkmAka9khh7jMkYFm+Tbo=
X-Received: by 2002:a1f:95d1:: with SMTP id x200mr5270164vkd.78.1545686655798;
 Mon, 24 Dec 2018 13:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20181220214823.21378-1-orgads@gmail.com> <20181220214823.21378-2-orgads@gmail.com>
 <nycvar.QRO.7.76.6.1812211708010.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812211708010.41@tvgsbejvaqbjf.bet>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 24 Dec 2018 23:24:04 +0200
Message-ID: <CAGHpTBJ1bs9Ob-PXQaV0rhxPnSN=x7TZj-evO85k41ERaDAfmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, Dec 21, 2018 at 6:12 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Orgad,
>
> On Thu, 20 Dec 2018, orgads@gmail.com wrote:
>
> > From: Orgad Shaneh <orgads@gmail.com>
> >
> > Signed-off-by: Orgad Shaneh <orgads@gmail.com>
>
> Feel free to steal the PR description I added to your PR at
> https://github.com/git-for-windows/git/pull/1992
>
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index b5c99ec10c..78a09dcda2 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -530,6 +530,7 @@ static int run_specific_rebase(struct rebase_options *opts)
> >
> >  #define RESET_HEAD_DETACH (1<<0)
> >  #define RESET_HEAD_HARD (1<<1)
> > +#define RESET_HEAD_RUN_HOOK (1<<2)
> >
> >  static int reset_head(struct object_id *oid, const char *action,
> >                     const char *switch_to_branch, unsigned flags,
> > @@ -537,6 +538,7 @@ static int reset_head(struct object_id *oid, const char *action,
> >  {
> >       unsigned detach_head = flags & RESET_HEAD_DETACH;
> >       unsigned reset_hard = flags & RESET_HEAD_HARD;
> > +     unsigned run_hook = flags & RESET_HEAD_RUN_HOOK;
> >       struct object_id head_oid;
> >       struct tree_desc desc[2] = { { NULL }, { NULL } };
> >       struct lock_file lock = LOCK_INIT;
> > @@ -636,6 +638,10 @@ static int reset_head(struct object_id *oid, const char *action,
> >                       ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
> >                                        UPDATE_REFS_MSG_ON_ERR);
> >       }
> > +     if (run_hook)
> > +             run_hook_le(NULL, "post-checkout",
> > +                         oid_to_hex(orig ? orig : &null_oid),
> > +                         oid_to_hex(oid), "1", NULL);
>
> IIRC there was one `git checkout` in the scripted version that ran the
> hook, and one did not. The latter did not run it because it did not
> actually change the HEAD, but just switched branches.
>
> We could imitate that here by extending the `if (run_hook)` to `if
> (run_hook && !oideq(&head_oid, oid))`, I think. Do you agree?

Not exactly. That's what I thought, but it looks like I was wrong.
Returning to the branch is done in sequencer.c. The 2 calls to reset_head
happen on fast-forward case.

On fast-forward there is a call to reset_head with "checkout",
followed by a call
with "Fast-forwarded". I'm not sure what exactly it does, but on my test it sent
a null oid.

I did however miss the `switch-to` case, which I now added too.

- Orgad
