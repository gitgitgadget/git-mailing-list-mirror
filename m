Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906261F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933676AbeGIRXt (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:23:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33183 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeGIRXr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:23:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so2887611wrp.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGjAEbXSncSAWs8aQX58aDb+IBo9CoBXuZi6/pwIRB0=;
        b=SVIfHxvScgyTlDMicUXtpuDgssysl34b+XZ2C1RvgSbNgS0ZbzMI4QlSNZlboDt/5f
         l0SB33wj9WTP91MELjZAFEj/mEPSvwtJPVjtlUSDNX5WrAAmdQLc0xwptM+exWsrp+WJ
         I61vNBVKSFlKJcDuuBjf7rNT+OmtM30TfTmkJj6z3XzXQZj2f3HEV/sdjQqDwEr/Bz65
         XHrCyVeLHFl/9Maw7KIQSPHRQkqmvn/jbJ/pcBWB6+yXDs4HTzE7SBJK7ofmDg2QXw7Q
         y1kM1oVexDNmmJo2zA5CiTjnvmLzRsXGnScmrtHZQFuZzGTMJN/Rt8mLqpux1J96B9+W
         RBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGjAEbXSncSAWs8aQX58aDb+IBo9CoBXuZi6/pwIRB0=;
        b=SQQdeDABh9V24eJegknupmnZ4/fC2PtR+aLV5JOSLpVNJ91pGeuDcQ030BeqnE7YWt
         uiJp6qWuGKkenIXcVXyDcSXxBNj2s9XQK6yRW/zTSQ+IfW5YEgpcTIH0yH33sFQX1Odf
         SLvoy8VSBHXxO+IKuIzN2uJSlG79QTxYcQi3bbXLGv6Q7HRTinBKtTNKdXpRS8XQ5jVN
         EJZWiUgQJMYOPYJd+b70s4WPJoROxCkmRE7at+872uBHNWtkcBTaypk4J+TuaO5Qs6BG
         lBcQ1w7tOrVTd0ZvqVPyz+EVVFGY7MCVIjR/fPZ0kWZq4NCFpfN2rD5PBTSawNscAWfv
         JRtQ==
X-Gm-Message-State: APt69E2KpZ0mV7eOxlzhlO2BA674t7XoVVqbjgFJKGhjVJmSvqGxqq8c
        WaTkQrRY4GeZ6sNy/7c3sw3sdzuqXLohBUFwAZM=
X-Google-Smtp-Source: AAOMgpc6nWWI37sbaHR/HEIdACY/ChDkFcTUiF3xUkRNXmCeoAeValuMNOgVmgeb0bYmTIhYK59F/RQ76nVY4eJwqTU=
X-Received: by 2002:adf:d08c:: with SMTP id y12-v6mr15988372wrh.152.1531157026291;
 Mon, 09 Jul 2018 10:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com> <20180708180104.17921-4-predatoramigo@gmail.com>
 <nycvar.QRO.7.76.6.1807082315350.75@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807082315350.75@tvgsbejvaqbjf.bet>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Mon, 9 Jul 2018 23:08:35 +0545
Message-ID: <CAOZc8M8YmLwJOzG-1jyz8ft4W_tJMwNs6kSV8inX1q_zmDW8Sg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] sequencer: refactor the code to detach HEAD to checkout.c
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
On Mon, Jul 9, 2018 at 3:16 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Pratik,
>
> On Sun, 8 Jul 2018, Pratik Karki wrote:
>
> > diff --git a/checkout.c b/checkout.c
> > index bdefc888ba..da68915fd7 100644
> > --- a/checkout.c
> > +++ b/checkout.c
> > @@ -2,6 +2,11 @@
> >  #include "remote.h"
> >  #include "refspec.h"
> >  #include "checkout.h"
> > +#include "unpack-trees.h"
> > +#include "lockfile.h"
> > +#include "refs.h"
> > +#include "tree.h"
> > +#include "cache-tree.h"
> >
> >  struct tracking_name_data {
> >       /* const */ char *src_ref;
> > @@ -42,3 +47,62 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
> >       free(cb_data.dst_ref);
> >       return NULL;
> >  }
> > +
> > +int detach_head_to(struct object_id *oid, const char *action,
> > +                const char *reflog_message)
> > +{
> > +     struct strbuf ref_name = STRBUF_INIT;
> > +     struct tree_desc desc;
> > +     struct lock_file lock = LOCK_INIT;
> > +     struct unpack_trees_options unpack_tree_opts;
> > +     struct tree *tree;
> > +     int ret = 0;
> > +
> > +     if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> > +             return -1;
> > +
> > +     memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> > +     setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> > +     unpack_tree_opts.head_idx = 1;
> > +     unpack_tree_opts.src_index = &the_index;
> > +     unpack_tree_opts.dst_index = &the_index;
> > +     unpack_tree_opts.fn = oneway_merge;
> > +     unpack_tree_opts.merge = 1;
> > +     unpack_tree_opts.update = 1;
> > +
> > +     if (read_cache_unmerged()) {
> > +             rollback_lock_file(&lock);
> > +             strbuf_release(&ref_name);
> > +             return error_resolve_conflict(_(action));
> > +     }
> > +
> > +     if (!fill_tree_descriptor(&desc, oid)) {
> > +             error(_("failed to find tree of %s"), oid_to_hex(oid));
> > +             rollback_lock_file(&lock);
> > +             free((void *)desc.buffer);
> > +             strbuf_release(&ref_name);
> > +             return -1;
> > +     }
> > +
> > +     if (unpack_trees(1, &desc, &unpack_tree_opts)) {
> > +             rollback_lock_file(&lock);
> > +             free((void *)desc.buffer);
> > +             strbuf_release(&ref_name);
> > +             return -1;
> > +     }
> > +
> > +     tree = parse_tree_indirect(oid);
> > +     prime_cache_tree(&the_index, tree);
> > +
> > +     if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
> > +             ret = error(_("could not write index"));
> > +     free((void *)desc.buffer);
> > +
> > +     if (!ret)
> > +             ret = update_ref(reflog_message, "HEAD", oid,
> > +                              NULL, 0, UPDATE_REFS_MSG_ON_ERR);
>
> I noticed that this does not actually detach the HEAD. That is my fault,
> of course, as I should have not only suggested refactoring the
> `do_reset()` function from `sequencer.c`, but I should also have
> remembered that that function has the benefit of *always* acting on a
> detached HEAD (because it runs during an interactive rebase), and
> therefore does not need to detach it explicitly.
>
> In light of the `reset_hard()` function that you added in a `wip` (see
> https://github.com/git/git/pull/505/files#diff-c7361e406139e8cd3a300b80b8f8cc8dR296),
> I could imagine that it might be better, after all, to leave `do_reset()`
> alone and implement a `reset_hard()` function that also optionally
> detaches the `HEAD` (I *think* that the flag `REF_NO_DEREF` would do that
> for you).

Yes. I think this will be better. Thanks.

> Alternatively, just update the code in `do_reset()` to use that flag
> first, and only *then* extract the code to `checkout.c`.
>
> (I could not resist, and made this quick change on top of your
> `wip-rebase`, and together with a couple more, obvious fixups, this lets
> t3403 pass. It still needs some things that you have not yet sent to the
> mailing list, such as support for `--skip`.)

Thank you for taking the time to review.
