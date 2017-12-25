Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3D41F406
	for <e@80x24.org>; Mon, 25 Dec 2017 19:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbdLYSpL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 13:45:11 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:43094 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdLYSpK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 13:45:10 -0500
Received: by mail-wm0-f53.google.com with SMTP id n138so32557635wmg.2
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 10:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MirILfRAmewA+YIqyWSJcs0PcRFhOnEx4dJElbd0xeU=;
        b=Xona8/GKV2VgPoPzyAJTLdKoZM35jJ2fH5eou6tql4ccy270BfZbbZLB8j5u8Bj4yH
         IaVdvRQQI4DgCvv3ZwfUScHqUIq7sSCrsnRmwG52/PwnPbBLMShEQxGj0RnnN1soMjDZ
         Inq2pj84gPyDrymL6pKiN2SMYwHvW/h5QvEsT2nD7HWGqTd2AHlOofc09BVoW1p3tt/Q
         LM5DRi52KAxmJNs1jYtKRbzkxRv3wiUM7o3LT+exkOYYNx/PywqdBJ0jU9ictz0tf/ug
         NA7JIyq9GdOGaBzeg1jbv+SN9JZt9D9eZXLBiXu8hIKBNaUF3dxx85bJsBlxAUBbsFvW
         3MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MirILfRAmewA+YIqyWSJcs0PcRFhOnEx4dJElbd0xeU=;
        b=AtIlEByv1ML5jNyEZrWvrtpLQ9SFbnKRLBKmjnsoIs0eBpNIkjXvga6tyWxyhn3iVp
         IgKy2dTwSKF0UwDbAY5LnjX5TYFDoAIj15UCMrsONutIpnDUoseRSpK+Up8Xjiy/2stY
         PIeBlIYilwwTKkOqfQE7ota8cxNOkfn0+vVAwJPEpLHtCV5UTm2uwLFJg0bIZpg2Uo4c
         pO0T0hKRFbZXDJiKQEyYkqv+vifczhr6dqN4DIfkR5kDGqc0y643X8mO76qEyTbm5ceb
         Fm3ZKazyTMauUm51xZMtcxtPg5yO2QF12GPGmYPYCtdKNjHGK+ZfP/rjltkWM/V6MpK1
         bI1g==
X-Gm-Message-State: AKGB3mKmHdeeRUiELz9TrQtHNqV4bk8N9Z+N/jKDGjUpENqounhjDJXe
        Xnwfl1epmckhkTcxzAD+tXlf1c1P
X-Google-Smtp-Source: ACJfBouvlO6Pi7ehmwdNmupDbcaOcxy802ZQDVqzOKpC2waX7Xui7+oP+wbydgVRw3yrlnE6FuOg7g==
X-Received: by 10.80.182.5 with SMTP id b5mr27748460ede.227.1514227508264;
        Mon, 25 Dec 2017 10:45:08 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id l9sm20406946edi.58.2017.12.25.10.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Dec 2017 10:45:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache bug
References: <20171222140032.21180-1-avarab@gmail.com> <CACsJy8B1FNpq-AYJdcs_gVOxdPSnh-kNaeVykLSSDL1+EW9YjA@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CACsJy8B1FNpq-AYJdcs_gVOxdPSnh-kNaeVykLSSDL1+EW9YjA@mail.gmail.com>
Date:   Mon, 25 Dec 2017 19:45:06 +0100
Message-ID: <87wp1ar6j1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 25 2017, Duy Nguyen jotted:

> On Fri, Dec 22, 2017 at 9:00 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> The untracked cache gets confused when a directory is swapped out for
>> a symlink to another directory. Whatever files are inside the target
>> of the symlink will be incorrectly shown as untracked. This issue does
>> not happen if the symlink links to another file, only if it links to
>> another directory.
>
> Sounds about right (I completely forgot about dir symlinks). Since
> I've been away for some time and have not caught up (probably cannot)
> with the mailing list yet, is anyone working on this? It may be
> easiest to just detect symlinksand disable  the cache for now.

I haven't yet, I wanted to see what you had to say about it,
i.e. whether it was a "do'h here's a fix" or if it was more involved
than that.

Being completely unfamiliar with this code, I hacked up [1] to add some
ad-hoc tracing to this. It has some bugs and doesn't actually work, but
is injecting something into valid_cached_dir() and checking if the
directory in question is a symlink the right approach?

Although surely a better solution is to just see that y is a symlink to
x, and use the data we get for x.

I also see that the the untracked_cache_dir struct has a stat_data field
which contains a subset of what we get from stat(), but it doesn't have
st_mode, so you can't see from that if the thing was a symlink (but it
could be added).

Is that the right approach? I.e. saving away whether it was a symlink
and if it changes invalidate the cache, although it could be a symlink
to something else, so may it needs to be keyed on st_ino (but that may
be chagned in-place?).

1.

    diff --git a/dir.c b/dir.c
    index 3c54366a17..8afe068c72 100644
    --- a/dir.c
    +++ b/dir.c
    @@ -1730,10 +1730,13 @@ static int valid_cached_dir(struct dir_struct *dir,
                                int check_only)
     {
            struct stat st;
    +       struct stat st2;

            if (!untracked)
                    return 0;

    +       fprintf(stderr, "Checking <%s>\n", path->buf);
    +
            /*
             * With fsmonitor, we can trust the untracked cache's valid field.
             */
    @@ -1742,6 +1745,7 @@ static int valid_cached_dir(struct dir_struct *dir,
                    if (stat(path->len ? path->buf : ".", &st)) {
                            invalidate_directory(dir->untracked, untracked);
                            memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
    +                       fprintf(stderr, "Ret #1 = 0\n");
                            return 0;
                    }
                    if (!untracked->valid ||
    @@ -1749,12 +1753,14 @@ static int valid_cached_dir(struct dir_struct *dir,
                            if (untracked->valid)
                                    invalidate_directory(dir->untracked, untracked);
                            fill_stat_data(&untracked->stat_data, &st);
    +                       fprintf(stderr, "Ret #2 = 0\n");
                            return 0;
                    }
            }

            if (untracked->check_only != !!check_only) {
                    invalidate_directory(dir->untracked, untracked);
    +               fprintf(stderr, "Ret #3 = 0\n");
                    return 0;
            }

    @@ -1772,6 +1778,28 @@ static int valid_cached_dir(struct dir_struct *dir,
            } else
                    prep_exclude(dir, istate, path->buf, path->len);

    +       if (path->len && path->buf[path->len - 1] == '/') {
    +               struct strbuf dirbuf = STRBUF_INIT;
    +               strbuf_add(&dirbuf, path->buf, path->len - 1);
    +               fprintf(stderr, "Just dir = <%s>\n", dirbuf.buf);
    +
    +               if (lstat(dirbuf.buf, &st2)) {
    +                       fprintf(stderr, "Ret #4 = 0\n");
    +                       return 0;
    +               } else if (S_ISLNK(st2.st_mode)) {
    +                       invalidate_directory(dir->untracked, untracked);
    +                       memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
    +                       fill_stat_data(&untracked->stat_data, &st);
    +                       fprintf(stderr, "Is link = <%s>\n", dirbuf.buf);
    +                       return 0;
    +               } else {
    +                       fprintf(stderr, "Is not link = <%s> but <%d>\n", dirbuf.buf, st2.st_mode);
    +               }
    +       }
    +
    +       fprintf(stderr, "Falling through for <%s>\n", path->buf);
    +
    +
            /* hopefully prep_exclude() haven't invalidated this entry... */
            return untracked->valid;
     }
    @@ -1783,9 +1811,12 @@ static int open_cached_dir(struct cached_dir *cdir,
                               struct strbuf *path,
                               int check_only)
     {
    +       int valid;
            memset(cdir, 0, sizeof(*cdir));
            cdir->untracked = untracked;
    -       if (valid_cached_dir(dir, untracked, istate, path, check_only))
    +       valid = valid_cached_dir(dir, untracked, istate, path, check_only);
    +       fprintf(stderr, "Checked <%s>, valid? <%d>\n", path->buf, valid);
    +       if (valid)
                    return 0;
            cdir->fdir = opendir(path->len ? path->buf : ".");
            if (dir->untracked)
