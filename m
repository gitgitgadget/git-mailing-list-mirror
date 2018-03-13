Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9D71F404
	for <e@80x24.org>; Tue, 13 Mar 2018 23:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeCMXai (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 19:30:38 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:46195 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeCMXah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 19:30:37 -0400
Received: by mail-ua0-f175.google.com with SMTP id d1so904946ual.13
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 16:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p8RW7Z/SfQ1nD2REXoxhsvSr7Ak6s7vRlOj9Rhpu1MY=;
        b=WpDAO0Jqth8se5swqf2sZZBs9Cu0F0BIRn+lZteB4WQ3IbafZ6W+fW4I0fRumRVDMw
         Fw5iaChRHJ5+uBBDe+RV0MXp7RaRiwNrQg/KBuKn+8SJBYlDMdFxYNm+1kUd9D0yNAdE
         XX+0UBc85D7ZQJxsN+4UKmvxG+3qyFYAQN70YcAf9bOOOyEhoj8BYpAOs+vsEpyr7DRd
         FPSW1mz+vaED+NvpE9C/u3ekxgh3egN2opMVDloYA6R5LIrygWzbNrFvlI6Ki3/s6a+j
         tsAO5n3+jqMPAAlhJz0UVSFyReKA0BBQImuCgTf0qTBM9F0Cw0har05wIZHd6cTT0h+X
         /mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=p8RW7Z/SfQ1nD2REXoxhsvSr7Ak6s7vRlOj9Rhpu1MY=;
        b=mwr2IdoAbfg1q9sG7L5GSD5hgpJhYyRUA8zSitNeLQheLH5iUBZSjEY7jm0w2yWMZF
         wZA9WLCRsJ8VkesUSXyWh30FGoCmbh2f/O9rj7ND2+QwRcNZbdMSIW0RY80Vc9giM0YN
         2WfQA+9ve009QlEgE9/ZEXTzMjixfQHs0fzU160CmJhr0w5evu0u016Bot99F7fEbZvj
         F1+30sikw/fN3r3JZdKEMwp3AyxabBUBaHdfx50Sn7RNoy1U6HGNhr2/465hJXm/riJK
         +ShXa5ag700WPkFf61o1lH4EUHw3doNMw8+IhBc1riE3R+uuRPtXiQXemVBFQ/crwNkZ
         MwIA==
X-Gm-Message-State: AElRT7GhY5N/3pGMtm1GgzPsMvfYCiiEhWaoAIyNR9BuDs8yvfwo4i3p
        4lxdz1JiYSswTy5DtU5CyEclyc8DWEVswa0BSfl3IQ==
X-Google-Smtp-Source: AG47ELvUbe5rcWZ/AXZ17eySLwm0s0NVEuA+ylYHzDVDF9xqM76rzy1ve7hrdiwiyUrlpqxfrX/BDiJL9tKb3uhB9g8=
X-Received: by 10.176.25.216 with SMTP id r24mr1906469uai.156.1520983836051;
 Tue, 13 Mar 2018 16:30:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.191.140 with HTTP; Tue, 13 Mar 2018 16:30:15 -0700 (PDT)
In-Reply-To: <CABPp-BE=D_TgjLZkhRh6-7k3UpnDDMfZB6vE=FMdwFT+mmp_tw@mail.gmail.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
 <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com>
 <xmqqbmfr1uj3.fsf@gitster-ct.c.googlers.com> <CABPp-BGXdBJSi5EUyeom0PcgRXvwNy4EBA71MP3FZK9xsw-jdA@mail.gmail.com>
 <20180313225639.GC147135@aiede.svl.corp.google.com> <CABPp-BE=D_TgjLZkhRh6-7k3UpnDDMfZB6vE=FMdwFT+mmp_tw@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 13 Mar 2018 16:30:15 -0700
X-Google-Sender-Auth: 1iuT_2TwPpvRkzUUtvio_LAjZzM
Message-ID: <CAPc5daUC+6cHpexXTO24p4mG_5eL1JmxrYm8h3UfdTh_FMka=w@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 4:14 PM, Elijah Newren <newren@gmail.com> wrote:
>
> Someone in the future might hate us if they use conflictstyle=diff3,
> and have a recursive merge,

FWIW I already always use diff3 style and see the nested markers,
and I already hate it, so you are no worse off ;-)
