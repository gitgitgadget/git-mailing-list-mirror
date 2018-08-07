Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36501208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 03:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeHGFoI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 01:44:08 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41702 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeHGFoI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 01:44:08 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so4425647ywg.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 20:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gixDEyHirDbq1hC4DBgJ5mhXohJ8+IRcRUO7ksyhUcs=;
        b=JpdKfzuRaq//aAveljsBGxlwJORYLpRamJJ5+nElUWqmD2XTd35b8I6WLY0KU7l3gS
         HopR9cmoSWMcceK+ixDeM7/1sTrq6BXeLRifeM+A8w0203swTh/zzLiV/ZemPysYoFLz
         +F+LwzH6gvewif/Ub+zxnQ5pkoA5GlbugZ3HwpfxN5e1kEUUocIwJb3GHVegbv4eMSXo
         zz7Prv1geDuNkVjqsVRkR61k4NBLHuZKoN5RafBOuwLySQI0lW/ny2wlXVqs6UiIZVZA
         7Ykl0mtMU2QasyECufHMnrJQXetB5fIvF/E2jn5sX8OqZIMj/fkQeDbzLRLE2q33Nt8K
         Xk9A==
X-Gm-Message-State: AOUpUlH+e1xDb+5f+DwXOucgA6bucx58Eke8fU9lDTMlknJaViIxQNuQ
        cYyxlL5tdbHa9iYT+BCTHZ6w9AMFQujnkrDTptE=
X-Google-Smtp-Source: AAOMgpeUjJ/2wNmILgh0XA7jszsmxdqsX7eBIsnVoPyJO81Lx2OJ2lhy9y4kv3Raz2VIKfaK5uNhRt3lAU3GmrIZlN4=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr8787919ywr.16.1533612713769;
 Mon, 06 Aug 2018 20:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <CAE1pOi3oeBEyD8skwfLAd7JviGYOUZaZwj3u9pznM4eLAR7fDQ@mail.gmail.com>
 <CAPig+cRe1R1YWpLaXVtTmwhaJiz2dONU83qtn_+XhaRevjn2fQ@mail.gmail.com> <CAE1pOi3+FW8itk4AHhG+r02TGyGTeoZpq7S6HKXkQtOVqigWGQ@mail.gmail.com>
In-Reply-To: <CAE1pOi3+FW8itk4AHhG+r02TGyGTeoZpq7S6HKXkQtOVqigWGQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 Aug 2018 23:31:41 -0400
Message-ID: <CAPig+cT0ATgRMY-mhttViaburFW37G352BX=mj-Cnr2_wZruaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 9:20 PM Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> But your suggestion did make me think about what behaviour I would
> like to see, exactly. I like that Git removes commits that no longer
> serve any purpose (because I've included their changes in earlier
> commits). So I would not want to keep commits that become empty during
> the rebase. What I would like to see is that commits that _start out_
> as empty, are retained. Would such behaviour make sense? Or would that
> be considered surprising behaviour?

I, personally, have no opinion since I don't use empty commits.
Perhaps someone more experienced and more long-sighted will chime in.
