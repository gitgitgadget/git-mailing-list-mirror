Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DCFC1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 23:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934229AbeCSXlQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 19:41:16 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34700 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbeCSXlP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 19:41:15 -0400
Received: by mail-io0-f173.google.com with SMTP id r18so116869ioa.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vHIOmV1Wn+QZ5s3Do8rMmrCtTlCPB+FRLvI/pWc834I=;
        b=WNFob1yCXJ4ja9u2+zrGhmLqOIymgubbGm4tpUepsie8IhQf9BWzaNWAoaV5b/kXT6
         9ir9OdvYorxbWpZZySbBHJzN9c7QgtLgS7tH5FGe1+r1ZZ5i1Bk8zwew4oOAXINDg4hz
         3aHilAxh8sX59LqC+YqOpxrVkzkxcVQmLJ2cIab7DJ/HdLelzEpSy3dWbKLdt2SwrLH2
         iGXKUK2k5mODYozNFob7IPYI7h0LZZaPtKZHIwuQbErdA16Au1sTQHsJfIQO+174DaoZ
         hRTvyfnhIT8u/NDziWEHHdbJlyJEEb4PmNlbN/nAvj89YgVxgdluYix9hUG7vB3g7hRh
         St2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vHIOmV1Wn+QZ5s3Do8rMmrCtTlCPB+FRLvI/pWc834I=;
        b=rs0ObtMuCC3Xh/VIyjasJ1+gVjCgAfLMP0/kW70zK0eHXo373xzaYdSOueAvKkU6Y5
         JEJVGaVfnU6XXyrI0NyxRGFEX50DK4it+Xvozw8NjgMiFsn6ia7s4J/gJtA3vK6KVIAi
         AqecKgv1L2YxoJ8mHq4qblbxitY1QKsL7W9vJWGTlvGnd/uqGMpLgNGUT4uby77735Am
         LB8Ni6+pMLRLe3MlfOi14+BmEnDFJD8y8XsmPhVYGl6zggiBCyQLfQBwAmXI4bSk+OL2
         7P+OeTR5ENzbDAC+U46BrvZHEvKyHIx1rFI30iKvdC6qGE01MrXfIxmPHvEDuqIShmg/
         Ccvg==
X-Gm-Message-State: AElRT7GUhtHmbkSsDCUbEbWNsQeWrbsTgt8d+cqSbmo37Q93uyldcvQ9
        9Sm3CgYV4e9xNhI+XTy4uIEKk4SN7byx7ACrDt0=
X-Google-Smtp-Source: AG47ELt4k3sgV0bIJone3xG2VHlKsbJ8wbqDRuhYpkHk0e3eYGhfkkC+WP3KnYoDVltnFzhjKzivhEIRgbJ2BPHinkg=
X-Received: by 10.107.150.19 with SMTP id y19mr4143155iod.272.1521502874286;
 Mon, 19 Mar 2018 16:41:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Mon, 19 Mar 2018 16:41:13 -0700 (PDT)
In-Reply-To: <CAP8UFD0aQxSZVRfOHUP80H+677zoNWPU1pdg7v4Qk+gKXCG8eg@mail.gmail.com>
References: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com>
 <CAP8UFD0aQxSZVRfOHUP80H+677zoNWPU1pdg7v4Qk+gKXCG8eg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 20 Mar 2018 00:41:13 +0100
Message-ID: <CAP8UFD2j71GJsnrd8y=Wj3a+TrX6UQePOZXE1LFFiqjd3_a-0w@mail.gmail.com>
Subject: Re: [GSoC] Regarding "Convert scripts to builtins"
To:     Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git <git@vger.kernel.org>, Yash Yadav <yashdimpu@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 12:11 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Mar 18, 2018 at 11:15 PM, Paul Sebastian Ungureanu
>> First of all, I find it difficult to pick which scripts would benefit
>> the most by being rewritten. I am thinking of git bisect, git stash
>> and git rebase since these are maybe some of the most popular commands
>> of Git. However, on the other side, scripts like
>> git-rebase--interactive.sh and git-bisect.sh are also subject of other
>> GSoC projects. Should I steer away from these projects or can I
>> consider them?
>
> If you are interested in converting these scripts, you should probably
> ask publicly to the former GSoC students who have been working on
> these projects if they still plan to continue working on them of if
> they are ok to let you finish/continue their work. You will get extra
> bonus points if they agree to help you or maybe co-mentor you.

I realize that you were perhaps talking about other potential GSoC
students who are also writing proposals about converting one of these
scripts. If you care about the other proposals though, you should
probably just write two proposals as we will have at most 2 GSoC
students this year. Just try to have different possible mentors
interested in your 2 proposals.
