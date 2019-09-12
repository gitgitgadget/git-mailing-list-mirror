Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A9A1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfILOKw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:10:52 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:45544 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbfILOKw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:10:52 -0400
Received: by mail-io1-f45.google.com with SMTP id f12so54826229iog.12
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rug-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mox9iqNVe+LZx/tXZ0r8RmtTIYb5LOvNdHc/JwsaZUk=;
        b=Li+WETLPGy+z/1x6+uAkxBSqgHmVBgHbyiYlkxIXOcCOBzNadiqt1VmLF9+A82KiFp
         epsjP7PgN+1gRkQLSa0R/J7gTVTX8a9Crc/ABdu1sWqh7xRGmYRK3wfeoUVVCeWDnAjV
         OIL4AS66hjU76JagBfwddrFoS+4bNuI7Yw+ud7NCmvyKI3cUErrVjfII1psyB046Kkvy
         k92xDatUVGKH16/w5xSSRUu5uBtvwDyjW4Vb3HQpcJmUOuGt3KtJbyOcVntR4Waq4KhU
         y18xZja+5zzaJPauWbiSaMcgFYsriRm2MCF0KGVT3O+NUOMDbBjLrXwaXyt5775DKoQG
         7rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mox9iqNVe+LZx/tXZ0r8RmtTIYb5LOvNdHc/JwsaZUk=;
        b=iUnWP5pPypaTjdFoeL23+SR4GbR2pwXzN1GdbKX+zfc1Z1hPauikRQTjG4BhU2qTV5
         q3x2WDeQo8tWRup2TKJ4kxSMYM11J4KlINwZQ4W/Q/rfh+kAj+Kk8QMEZTxVr8BR6trl
         wG0sP/Hh05hrIx82Qvvlfr7cjZpQwo2nrCfyH44puL+DDNH1rXgIa/a/xvGOW2WgsUnk
         komxHz01WUnvn3OzujgTq5FxbIJ1GCV5ruA5qyVBj6YCzGlo7sfU0XaYixpiuo9+Ra81
         atuaTw7ZKOqCJpEQg1e2m0ZnFR+lXkZc4dmIEVjxVCwvD3k3m9ItdJpG1+BZT6RbJ9hV
         X4Gw==
X-Gm-Message-State: APjAAAWDYdfB2DAcDm7/RcfDJylQNh986zLFaPCI9vR6L91viD2E9N6m
        MTL6Vss2fnORXPazf6vJ8/t9f9TXrgHPGOM1BgfsdA==
X-Google-Smtp-Source: APXvYqyKCSIgTEs5bH32ly+LsR337Ki1ti8EWRMEKPph4azJqTU+cXeVvRtOI+AMcIM4MktSzv1WaRhZ4DIho3/OehY=
X-Received: by 2002:a02:a792:: with SMTP id e18mr648270jaj.125.1568297451309;
 Thu, 12 Sep 2019 07:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMr8YN58q94bnBkdfxrBR-Vw5Mk4akHzn4c1k2HjMQCXKWdWsA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1909121044250.47@tvgsbejvaqbjf.bet> <CAMr8YN7aa9yK3TSqVhQjn2DG7vU_zJs9SHvznPefay+Mxs_Qsg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1909121327450.47@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1909121327450.47@tvgsbejvaqbjf.bet>
From:   "Castro Alvarez, Sebastian" <s.castro.alvarez@rug.nl>
Date:   Thu, 12 Sep 2019 16:10:40 +0200
Message-ID: <CAMr8YN5ifdsjbwszeXXwJZYZs=diEpj5xaLzPV9HbVwGam4=9g@mail.gmail.com>
Subject: Re: could not fork child process rebasing required
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I will try to check for this. Thanks a lot!
best,
Sebastian

On Thu, Sep 12, 2019 at 1:29 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Sebastian,
>
> On Thu, 12 Sep 2019, Castro Alvarez, Sebastian wrote:
>
> > I have tried with both versions 32-bit and 64-bit, none of them work
> > for me, I still get the same error. :(
>
> The most common reason for this, then, would be an overzealous
> anti-malware.
>
> Ciao,
> Johannes



-- 
Sebastian Castro Alvarez
PhD student
Department of Psychometrics & Statistics
Heymans Institute for Psychological Research
University of Groningen
https://www.rug.nl/staff/s.castro.alvarez/
