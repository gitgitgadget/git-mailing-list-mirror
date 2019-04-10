Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8379820248
	for <e@80x24.org>; Wed, 10 Apr 2019 09:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfDJJgc (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 05:36:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43398 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfDJJgc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 05:36:32 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so1492030iol.10
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2pLY7xFS5B/eWVx54QQFOdNfN0Dt3Tvqc1mp/r1KKI=;
        b=BU1pc6CRFiadNCVof02eNQbX+24KcuHew8kDkogt+Y4Zc5hpvsUyrYQFliKlqvFFLG
         y7ZySANnP3sOTrLyposVbRZ24xA+b38XNgRd4CdMZrx1/CHY/hzBF6TZlJuu6kh54OyM
         +48VV+DFpFDb2l16GjGMGqqOJng91d0VxCyPhJOEs3XwxwzXb8HNnXHLDJkgHQKTauv4
         vSOKPe2FjeGqMG15x0re6sdrqGM/9as9T0onayfb4lKW+uq5z7A/ie0sKLGinlkmAMTZ
         L30cqvx3Zsqea4i7YbO9dBILqeh/Y3cShd8VaeNppCbWoTv1fl7u77gm8mXebGShPkdj
         4BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2pLY7xFS5B/eWVx54QQFOdNfN0Dt3Tvqc1mp/r1KKI=;
        b=E2L7cC0yyyIxSey1Dlv5Wv5/oOpNrI0fPWnuF2fSM3nBh9HQCrFRBWsruOrqJYwle3
         f7qd/+W6kRZQjZQG+p8YbFxZT/qd5THxF0UrjJF/QhXfFZ6giNF3meSg6Y+028taAHeW
         E+bujg21OzRO/iIzHFUW/zuR/FY2Cv5TjNWcWBcYqeEFPAMkSLx2N9NBvvkm9coLy4fV
         9fSBkOTMPv/UtqS2nhi0miv0gQnzbEVhNJx9djRyt2gBlMVjbRhJ4l2OcSMBaNuVUcgs
         ssMTGUPEh6vwRSvkyXCWd4O/RG3ITqIGKqOvR9ifVl8XQU6k/+Ng9Z4j2BJ34P9GNGbr
         WYaQ==
X-Gm-Message-State: APjAAAVe7uDMOx74DXOHrjysJ1vRbvTTY3qRo+gRQwCbmPUN6fX93hAH
        VLEZa6g0TmGNK+LFH5lT0o5WVYr95B/OgeFHeis=
X-Google-Smtp-Source: APXvYqyOQG9gpNDEBvURZNUCjWJ2xqXjYkQLbhG25lznk8thhuaV7rpzq2J8ZrDMz/U5u8iiyxRq4DooGgCAXvY6dW4=
X-Received: by 2002:a5d:840d:: with SMTP id i13mr20391544ion.186.1554888991542;
 Wed, 10 Apr 2019 02:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com> <20190409102649.22115-1-pclouds@gmail.com>
 <xmqqh8b75s9l.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8b75s9l.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 10 Apr 2019 16:36:05 +0700
Message-ID: <CACsJy8Ct6A7a7FzzH7ZUv9R2+k=G6qhzZ8Yjq8GUDBdTr_QBQA@mail.gmail.com>
Subject: Re: [PATCH] Introduce "precious" file concept
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 9, 2019 at 6:31 PM Junio C Hamano <gitster@pobox.com> wrote:
> > @@ -193,9 +203,16 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
> >
> >               strbuf_setlen(path, len);
> >               strbuf_addstr(path, e->d_name);
> > -             if (lstat(path->buf, &st))
> > +             if (lstat(path->buf, &st)) {
> >                       ; /* fall thru */
> > -             else if (S_ISDIR(st.st_mode)) {
> > +             } else if ((!prefix && skip_precious_file(&the_index, path->buf)) ||
> > +                        (prefix && skip_prefix(path->buf, prefix, &rel_path) &&
> > +                         skip_precious_file(&the_index, rel_path))) {
> > +                     quote_path_relative(path->buf, prefix, &quoted);
> > +                     printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), quoted.buf);
> > +                     *dir_gone = 0;
> > +                     continue;
>
> An attribute is given to something that can be tracked, and a
> directory would not get an attribute, because Git does not track
> directories (there is a reason why skip_precious_file() takes
> &the_index that is passed down the callchain to git_check_attr()).
>
> Triggering this logic before excluding S_ISDIR(st.st_mode) feels
> iffy.
>
> But let's assume that being able to say "this directory and anything
> (recursively) inside are precious" is a good idea and read on.

Hm... we do allow to set attributes on directories even though we
don't track them. I was under the impression that an attribute set on
a directory will be propagated to all files inside anyway, so this is
more of an (mis?-)optimization.

But gitattributes.txt explicitly says that it's wrong. One would need
to do "path/** precious" to achieve the same thing.

So yeah maybe doing this before S_ISDIR() is wrong. The definition of
`precious` also only says "... is set on _files_". Maybe best to
ignore attributes on directories? At least it looks like that's how
all other attributes do.
-- 
Duy
