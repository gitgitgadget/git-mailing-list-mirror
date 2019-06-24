Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1174F1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfFXMuo (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:50:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36739 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfFXMuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:50:44 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so1047237ioh.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVX/ku0wh9+A8KOPOiiBzfNZLjNoQUIUjoyowtsYZdo=;
        b=pmmZSwx5FJduLdoFmCUo/Qj+2bj0iJ8TzllMjpoIx8EdqsbgfeZkFb6W8h/lpGRVbZ
         2ZaMrEP/YPPtDQgzQQk1qpKazytKQQaFhffrkz9VhQ76bR7s3kqgpIfQgud7mKPC2v3x
         3jDWmH3QckqJyA9H1aeKSc4h/Dg3iMQKkhMqMIgumTFy0+uG9pSQz/OCQu9TBdcFOENN
         //grNo4VinMRQwQCV2hIzhTYNXxdE3Ag6sCUloGBGM89CFaeqwTksJsqehbJpcHf1zLg
         tsMguXsX1kMCCAKdiOWgdVyChoPMYmXRFi08t4cNMxwEVEKPg0vhJZumZbNA39LnRFwu
         +Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVX/ku0wh9+A8KOPOiiBzfNZLjNoQUIUjoyowtsYZdo=;
        b=q/Rn+3NeRUvWh00Trm/TA5QVaHmKvOouY/Hasorl9Q6ztjiCaL4sGA4ooH2MF4fNUe
         GjZLr7WuGwTEBuw7DEPT7olVFoCiDhGo6Ut5k8IeXh9hiGgqRO+hFDqmdFwAICc6VQZM
         jk/M9He6WwriHgGn23ktwrcIqT5cOL8ES3SuvxjShKaVbVJNj/N6ZOPOgS5F/hjKmTls
         koIzdhGtBCekIVEBmB3oj5Fi09Km+pcFkkSlEqweBN69MijKjSMFhOTDmD1CpV9ZA4Ck
         8FRWBLRCegQUuWEJoY3YYaieqeVJLM6rMGinuoCY6gXwJ3D2L0pL+7NUxxfAqN0eBgLC
         hXMA==
X-Gm-Message-State: APjAAAXnhKMvXkRo1+zGC1R8CN9ECR1wcCzcuIHO6ukP7hqnRkKnIbmV
        ZsVbX20Izpva2YJEUcVmEi7BD/xu5m9o+ERH9m8AnA==
X-Google-Smtp-Source: APXvYqzagN38aFchNMQOywl45+p88YJcQXZaD+yqg0h/efipNVJ7GN9qVAkhEJfWNqLEipH6jiFM74K4YF7xPqV43Cw=
X-Received: by 2002:a02:a07:: with SMTP id 7mr32090905jaw.65.1561380643261;
 Mon, 24 Jun 2019 05:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619095858.30124-2-pclouds@gmail.com>
 <e3b8d7bf-486d-d52f-9a33-6a7ff837552e@gmail.com>
In-Reply-To: <e3b8d7bf-486d-d52f-9a33-6a7ff837552e@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Jun 2019 19:50:16 +0700
Message-ID: <CACsJy8B7j=G2VdYPU8W4eoGJhmJ=7r5gK0FV2QQ8twjzNQQzuQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] ls-files: add --json to dump the index
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 8:03 PM Derrick Stolee <stolee@gmail.com> wrote:
> > -     show_files(the_repository, &dir);
> > -
> > -     if (show_resolve_undo)
> > -             show_ru_info(the_repository->index);
> > +     if (!show_json) {
> > +             show_files(the_repository, &dir);
> > +
> > +             if (show_resolve_undo)
> > +                     show_ru_info(the_repository->index);
> > +     } else {
> > +             struct json_writer jw = JSON_WRITER_INIT;
> > +
> > +             discard_index(the_repository->index);
> > +             the_repository->index->jw = &jw;
> > +             if (repo_read_index(the_repository) < 0)
> > +                     die("index file corrupt");
> > +             puts(jw.json.buf);
> > +             the_repository->index->jw = NULL;
> > +             jw_release(&jw);
> > +     }
> >
> >       if (ps_matched) {
> >               int bad;
>
> I see this 'ps_matched' condition at the end, which is related to
> the '--error-unmatch' option. I added "--error-unmatch foo" to my
> command and got the appropriate error message:
>
>   error: pathspec 'foo' did not match any file(s) known to git
>   Did you forget to 'git add'?
>
> This was sent to stderr while the JSON was in stdout, so this should
> be appropriate to allow both options. Just pointing it out to make
> sure this is intended.

--error-unmatch only makes sense when you specify pathspec (like
"foo") but that does not work well with --json at all because we don't
do filtering (how do we even filter in extensions?). I'll just make
sure that "ls-files --json <pathspec>" is rejected. That'll cover
--error-unmatch.
-- 
Duy
