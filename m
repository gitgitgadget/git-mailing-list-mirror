Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC20E1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 18:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfH2SAK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 14:00:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33542 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfH2SAK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 14:00:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so4394950wrr.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eML6dvXJw4W2RegYT/blAy2AfjMKA46E0kGD7uzMY+w=;
        b=aMmr60O9iUemBf6nMOZMAFQoeoKDYxjvkn09mnH5XsNJKZkAQzA3zpVzaqJ9Ho7o9y
         kwPEUNj0Sa6PZxzwYAePXl8ABuHZRyz563WEss6sOaz0SA89kejElDOvCV/LHOZuBgRl
         vnsWNSmFrsQjCZlIJKS+1XQgUN0R8tZA7tzURqcgLH+V5yXSELfFjPWKxwcGfOCQcvyo
         TcScgFROTTQ/7uf9ODiDJWQwkO9GgKGD2RUwH5V4JWMyE0MoLtfJeWdjXkSaUzbn2OVf
         OGdHUfgD+VK97DSEjyD3/v6zVd6Lu4vTbFc7XxsUVbP14rtR68bo89G933VNlIfZNdPo
         DfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eML6dvXJw4W2RegYT/blAy2AfjMKA46E0kGD7uzMY+w=;
        b=ukOw2DxXadYGotsQ9C+yWFV/6M70RXnQUEETK2tR+lguTnUDort9GiNMWDDD3eMrQp
         ZEanzzWAW/tqoWvCgzUo/N6lfQOQx6mL+nF4JBok2Irn4CySug6LqISeTB7jPnptnzty
         jHqj3FlMLsThSkq3SZhEHf8tMfGhRAv8WUSGOJ2EXXDruZsI/eFXvDP8t57Ywks9m/Ay
         zCbQAAjs9kQmQlZ3abCSCA+/H4msX6xtMEhAMmF+l6KOkm5uTr9uyH4eme/kNsEm0DL0
         8XSWyJElAZ02UHDBBLFUFEgcH8CsdiTTXWq51JqHY5YHSDavivWLogWl3WWmOfaZTdm1
         ObbA==
X-Gm-Message-State: APjAAAV0zVIncfGfPc3exfsE2ryA7VghpWOMJIWQ0O5BbvhqFabyMDuc
        3apUWPUTOTyjv566zz6YlQc=
X-Google-Smtp-Source: APXvYqzIzBq5jW1aFqL/hMmnvqN2cvPWBq/jAq1nE8HraHfRGALDCqkxZJ8eldaAvMyS/wu2lszKXA==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr3687718wrr.291.1567101608370;
        Thu, 29 Aug 2019 11:00:08 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id e6sm3716700wrw.35.2019.08.29.11.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:00:06 -0700 (PDT)
Date:   Thu, 29 Aug 2019 19:00:05 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] merge: use refresh_and_write_cache
Message-ID: <20190829180005.GC48344@cat>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
 <20190827101408.76757-3-t.gummerer@gmail.com>
 <CAN0heSrs42hL7gmqMuugGLNOV8Vd9gxPcUiLA5oTXnhPEM-9qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrs42hL7gmqMuugGLNOV8Vd9gxPcUiLA5oTXnhPEM-9qw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/28, Martin Ågren wrote:
> On Tue, 27 Aug 2019 at 12:15, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> 
> >         struct lock_file lock = LOCK_INIT;
> >         const char *head_arg = "HEAD";
> >
> > -       hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
> > -       refresh_cache(REFRESH_QUIET);
> > -       if (write_locked_index(&the_index, &lock,
> > -                              COMMIT_LOCK | SKIP_IF_UNCHANGED))
> > -               return error(_("Unable to write index."));
> > +       if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK | SKIP_IF_UNCHANGED) < 0)
> > +               return -1;
> 
> I wondered why you didn't drop the `struct lock_file`, but it turns out
> we still need it further down.
> 
> >         if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
> >                 int clean, x;
> 
> What you could do, I guess, is to move its declaration to around here.
> Probably not worth a re-roll.

I'll re-roll anyway for the things you spotted in the first patch, so
I'll drop it down here while I'm at it, thanks!

> > @@ -860,13 +857,9 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
> >  {
> >         struct object_id result_tree, result_commit;
> >         struct commit_list *parents, **pptr = &parents;
> > -       struct lock_file lock = LOCK_INIT;
> >
> > -       hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
> > -       refresh_cache(REFRESH_QUIET);
> > -       if (write_locked_index(&the_index, &lock,
> > -                              COMMIT_LOCK | SKIP_IF_UNCHANGED))
> > -               return error(_("Unable to write index."));
> > +       if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK | SKIP_IF_UNCHANGED) < 0)
> > +               return -1;
> 
> Here you do drop the `struct lock_file` entirely, ok.
> 
> 
> 
> Martin
