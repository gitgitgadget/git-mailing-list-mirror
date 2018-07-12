Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1AE1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 17:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeGLRu3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:50:29 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:44603 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeGLRu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:50:29 -0400
Received: by mail-lj1-f173.google.com with SMTP id q127-v6so21998961ljq.11
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KUzUKpHaZZnT5qs8hUeTfDCEq1aJ8ikLW1W2+DdkhI=;
        b=F1BDAVYG8zGaraFEayV2NCbAcwlPlCCOsUWGo3B6z4FHQI8GBrLMcfE8F5+mb9DnPp
         qAqEXwn5wDDs9ROQUdX/pzrWY/gX9j/tv78KyKaDPUT9DXHXZllK+rJgCp5t0+FvVCiW
         7I6H68caFaLCV/KpufoUmhUKwgh3kflLxS15lV+JLL832K2LfbAfDOlC2OIjdkfgrfzi
         Ydq9URfC3leL016VcVZ9LuS/PQhiTVt7nSrLz2I+H/1D1eWi0J3IzREk8JbG8jcHymZU
         ebCcPKtVwofJ4ZozA4zBPHjQ9oExDz9Rpd7KQqNI4GwRf1X74RVMebV6DFot/DSE44BI
         kE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KUzUKpHaZZnT5qs8hUeTfDCEq1aJ8ikLW1W2+DdkhI=;
        b=JXIiJ1rd3Lv0qDpnfVc6s9JdKFkEbZT89FxRxQZxfLPQl0S/l6kikOqlsfOJf1kTo4
         HT3bhkdcUvRrHZbPTdStDz9undgjsqZ+OCzhYBqjXuvNSuUpT2c1W1IVm1KXpYyxZa2+
         jyiBDcyHHYq4FOoCMK6HyEynMQUtc9P+gMqwPr5vhO63nsMo2GTcNKUtzFjjHNZRslGn
         d9fOiTqF9gZzeo7HXGnpwUBFBuJ+uV0vEgzoHAJV1ACK3JDJ7h+vHoAaDmewT+T/KGNR
         nTmQEc3opLVt8BwaxazMHuwNrp1EGNd8Lloh8HbBFWZ8kqNgkpWqVnrUGQEaXFHE3LEk
         4xSw==
X-Gm-Message-State: AOUpUlGHZLwAKJBrtVn5zjC+UIiQySf861BlV58fEKXyKnr01KQBrG/L
        AlBKNycS7KrlthHCwVYwEhnVwFE2hBaMMDuu15I=
X-Google-Smtp-Source: AAOMgpeySgthV5DEg9tQK1mXfYRfRyPCJDEKV/H+Nfe6SqqG4VOD13a9GRRtXY0/oP5NA6WJ1EqDpGNM4pocylj+4AY=
X-Received: by 2002:a2e:96d8:: with SMTP id d24-v6mr1198222ljj.50.1531417193769;
 Thu, 12 Jul 2018 10:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
 <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
From:   Vitali Lovich <vlovich@gmail.com>
Date:   Thu, 12 Jul 2018 10:39:42 -0700
Message-ID: <CAF8PYMhGWi-Tkzde_G_ifcz=wmaAO3Ppwfy3kbiypgX-C_suvA@mail.gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 8:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Vitali Lovich <vlovich@gmail.com> writes:
>
> > Repro (starting with cwd within git project):
> >> (cd xdiff; git rev-parse --show-toplevel)
> > ... path to git repository
> >> git rebase -i 18404434bf406f6a6f892ed73320c5cf9cc187dd
> > # Stop at some commit for editing
> >> (cd xdiff; git rev-parse --show-toplevel)
> > ... path to git repository
> >> git rebase 18404434bf406f6a6f892ed73320c5cf9cc187dd -x "(cd xdiff; git rev-parse --show-toplevel)"
> > ... path to git repository/xdiff !!!
> >
> > This seems like incorrect behaviour to me since it's a weird
> > inconsistency (even with other rebase contexts) & the documentation
> > says "Show the absolute path of the top-level directory." with no
> > caveats.
>
> Does it reproduce with older rebase (say from v2.10 days), too?
>
> I suspect that the above is because "git rebase" is exporting
> GIT_DIR without exporting GIT_WORK_TREE.  When the former is given
> without the latter, that tells Git that you are at the top-level of
> the working tree (if that is not the case, you also export the
> latter to tell Git where the top-level is).
>
> I suspect that "git rebase" before the ongoing piecemeal rewrite to
> C started (or scripted Porcelain in general) refrained from
> exporting GIT_DIR to the environment, and if my suspicion is correct,
> older "git rebase" would behave differently to your test case.

Unfortunately I don't have an older git version handy to test this out.
