Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8B91F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbeHMVC4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:02:56 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:34968 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbeHMVCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:02:55 -0400
Received: by mail-yw1-f49.google.com with SMTP id s68-v6so14270645ywg.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrxvyaqXKFdQS2e9EGXdNHKedipeUObvXjjHo3IKqTk=;
        b=ZQrJ0dwjONwqyiqGnKSutKUO5wROQBx0vavGlHJBnttoph8kO8+eue+i0TnNxj/DKm
         n9YSY6HnQH8WQqLC7W+4idHd9J6qtJ0dd9PpWWOjCFQbeWH9VVP0gpKKkDE3AKSUeOVK
         UVM0/3mZVenEcw6Ostit/F1Rbhax56vvTmeAD5Q3vsCULh46TGGjspwU4pWQ2scp0Pey
         voY9hZa0wmd3ahwaRXGarOxTn37X4arWp5w8ToLW26rY27HVLvPLcYn+rVan5DcB+/cH
         CMWTbvjL5nCS3JA4dvOG9m79lHq10c6lSohAv636pXI1EFWKKcVsCsaqef+2vJrDfLRx
         hkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrxvyaqXKFdQS2e9EGXdNHKedipeUObvXjjHo3IKqTk=;
        b=VEGpVqGgip03OsUkSis1my7aL8oZaJFwbsFlrooGKTbhGk+CU8po2ObUSc4TjU37hz
         nbSd0VtSBjUCvd1FHO4FC9vF/ELuHj/yrXOxWe/lk/VnQR4rrf+4er3TYh8d5MYM6cwx
         S4Tiwa5eRzwH7nv0eO+B9GMxWMJcnIb/kfScWsMiRwbSFV1A9MlaigNO9tR5ev0hdyt6
         g1pj4x8OSA7TeyvppoOVATZBQAEmSo8KCwMDB702/7bV6JlwY2bHAGMjJrOY9W9paJQP
         SzQ+yyjloEgJa+iEG+8VLFmKUyLoLBsiNjq++qs4GwIGOHSJ4ZaQowwwI071XeQIIA7I
         g7ng==
X-Gm-Message-State: AOUpUlGEDyap7fiHU8AfoXmyqts4horU+NqPgn9DjG0RFI34jo5qTDET
        eB4I232x0INEDCOEvrooSoraR5AdkEDEx/MwO01pPRSF
X-Google-Smtp-Source: AA+uWPwpLcCc03akaraMLEnfDeVUoJ2BKtDXCfLhAtYcLM/Yi3GCg+nbVp7I0zxnrZQ+CfoV46RhtO35iuPJKUuiv8c=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr10646067ybm.307.1534184374740;
 Mon, 13 Aug 2018 11:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-2-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131340420.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808131340420.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 11:19:23 -0700
Message-ID: <CAGZ79kY8-GEWjK5TjkAzv1VoyLLXBD9t-B48UwPcWkogvD0MFA@mail.gmail.com>
Subject: Re: [PATCH 1/4] diff.c: emit_line_0 to take string instead of first sign
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 4:42 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:


> > +/*
> > + * Emits
> > + * <set_sign> <first> <reset> <set> <second> <reset> LF
> > + * if they are present. 'first' is a NULL terminated string,
> > + * 'second' is a buffer of length 'len'.
> > + */
>
> That does not make it clear what the role of `first` or `second` is. Could
> you clarify that?

For now it is just "first string" and "second string", where the first is
used for signs and indicators, and the second is allowed to have '\0'
in it as we give the length as a parameter. This doc tried to be
neutral w.r.t. the purpose of the first/second string.

> (TBH I am not so sure myself what roles they serve. Previously, it was
> kind of obvious to me that `first` tried to specify the diff marker, if
> any. But now...?)

Originally I thought we'd split the line into

  "++" "line"

for a range diff, but this is not the case.

As the next patch introduces configurable strings, we'd need this patch.
I consider changing the next patch to allow only giving a single character
instead, such that we can keep 'first', which indicates the sign character.
(So maybe I'd even call it 'sign').
