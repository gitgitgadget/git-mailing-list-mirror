Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8828F1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 07:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeJDNw6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 09:52:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44252 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDNw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 09:52:57 -0400
Received: by mail-io1-f66.google.com with SMTP id x26-v6so7052410iog.11
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wt8VEeKwSNwMuqNht4q9X9idSKv+JyItzTJuw+7ydGg=;
        b=XIE/KoFjcjYpMlUXNQEtTZRPV4reSaozbYmNh6uqUSGdk8zRHiKUXuRy62OZXpFDjV
         GDk1Fn6/aFYGWkegHw94VKgvOgnO1VVl8tbuCBmT9w4ovSOIzvR/PVpse25UUUlV7DgI
         xmJHfZxKMY0+Qs603ThfejrIi1ARQV6IrlQG0RTRcqXni4kT8O0ai/5lUrDmy2VIMeF8
         bxONBI2iKoQ36qLxMjxv2ikyRW6YvFsDTNdEQ2jwOjAqJ4NNv1OYpHgTn1E0ASkln+/L
         JlqePomum1fo1rAIvOD3ewpn1TRpxWkr58/TjqSPkJkU11Byl76ZEbaPqt3Auv/hrN0N
         CYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wt8VEeKwSNwMuqNht4q9X9idSKv+JyItzTJuw+7ydGg=;
        b=L7aKYWQuXPzr99DYkL0qLyw8g4eZGR6WPcLYAs4eqVaQ5/iLeGZM+jlNw1hj6l9Cqn
         4ymqMvF6DddvXkV9+vFV0pTumXJn8RwBhic9qK5Nk6iyXVowxopUroAFZuajJq19NAd3
         eHUactwSRCKT9j5vZrctVITMXsrGz0lrfulom2UreXJkS2Xk6dFJ68mVirovUKRCT4jQ
         pp6PPy+p2jFSCZqkq89GT1lsLhhm2atVCOIKlc1ew3bFViIfp7xoHEdqd0lZun1Ks2ev
         foiVhJYVPTZ1nHWH8bRpXhsEX+aGvRsPTo5Y9LcPXIzeEodL9Mg7p/xNsHPtmDLgyYhP
         jQfA==
X-Gm-Message-State: ABuFfohSDhmt9vja3AVmTcRndHm747EcCk/aNaWEOVAqVv/qqeHFWjZS
        SQsjit8Lx0sLRND5mYl/RHQNiYpsp2gR+ZZE7l4NWA==
X-Google-Smtp-Source: ACcGV63j7Qw/vSaAWnPMyBYyVkbAod1Xy9MvHemynJ0CTnnZoaglt8nO7Qds6lv93sanCSKBEqNNvLzjzrPjQpeQF1U=
X-Received: by 2002:a6b:6f0f:: with SMTP id k15-v6mr3001189ioc.236.1538636470043;
 Thu, 04 Oct 2018 00:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
 <39F9931A-B297-4525-A131-736B900F37AF@gmail.com> <CACsJy8AScp1v+R62vXWuP-45LLLYwfSBNaZJfR02=d+2CzDqhg@mail.gmail.com>
 <20180926160938.GA15312@duynguyen.home> <xmqqpnx0mbos.fsf@gitster-ct.c.googlers.com>
 <d876e0af6a860621ae80fde71069c5e2e6a71878.camel@gmail.com> <3F40923F-B596-403C-900D-6F411A0D1CE1@gmail.com>
In-Reply-To: <3F40923F-B596-403C-900D-6F411A0D1CE1@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 4 Oct 2018 09:00:43 +0200
Message-ID: <CACsJy8Ck8wnGFA2RT_fALHUe0mRO1fAOX9JpmSf6BH949ej=sw@mail.gmail.com>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a worktree
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 4, 2018 at 8:55 AM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
>
>
> On 3 October 2018 00:13:06 GMT+05:30, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> >Hi,
> >
> >Sorry for the delay. Got a little busy over the weekend. I seem to have
> >found the reason behind the issue in the mean time :-)
> >
>
> Oops, I forgot to mention there's more comments inline!
>
> BTW, is there an issue if .git/HEAD and .git/index are owned by root? The owners seem to have changed since I created the worktree possibly due to the cron job. Just wondering if it might cause some issues.

If the files are still readable by normal user and $GIT_DIR has
permission to delete/rename them, then I think everything still works.
-- 
Duy
