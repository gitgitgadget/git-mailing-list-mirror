Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586961F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427769AbeCBR2U (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:28:20 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:42764 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424524AbeCBR2O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:28:14 -0500
Received: by mail-pl0-f50.google.com with SMTP id 93-v6so6052358plc.9
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JKNjJQLMmBYftEooP4AB4NM2IrAC2UnIUqBYkWsa46I=;
        b=LPtAeEi8fDC9Rnl6gE34U7gtcPRmuGRA84vQgK9C7dyYoIEqcxKbqBdTjwOYWWXk9M
         01yw1Bpj9cmEiO4K3qEGGf2uhdcIIwfYYjt6S0dbmMEHA74O+GWXcAH2AB5eFX0qhleV
         4BlcpopUWxv14H3VQihD70cDR7jiUIigRRe0TajYxRIbLTBPr2yU7IUxY1VLABTvfm1q
         r4r17JiZi+EIiRNzgTW3HxUWqyOsyQGh9bCX/MIyYhr1esh5+gUTIWbx/jZ8C0yA9fUl
         MBTd/tOifU/YSjhI/F9WSThSf9fPLzqKoys6+8b7fiOBTWlEGIoKcrCOLa1iwYm9BXK/
         NQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JKNjJQLMmBYftEooP4AB4NM2IrAC2UnIUqBYkWsa46I=;
        b=pjlsgJnZ8YY18O5aB8KvYAtdnIZWTu1McU1msBlGtKJTmJXZ69gAh6X1uCDgXHX0Me
         Pv/tnbjMxgOUV7nCRuUMJCPbaEleB59aaw/EOgMOXDLK0SZ3xfJHCQbz3qmZp6IM8aFu
         dT9daF+VJxpKRwPkJGYOsLGwFwpvqvecXRWbFaNPFcepS4vUYWjpd0ywb5yrJFdBmz9S
         eNfoa4dGeTCkv2NB1RwKtEnyp8iyUOT5aLXrEzOtovZ8IfkYUdUdGwAoXjwDa/3eEnWj
         PQweYd/JWBSzvcbDWy2T92PVC/ZSDrJtMsDaBUt17nPDsY5zB7rtiWSdmVJZj4JRX1zM
         VJJQ==
X-Gm-Message-State: APf1xPDcJ9kFm/zkv7nMJJj9+rBqfxGalx1S0RS/OOZeuMEkwF/wqQd5
        FGl+CIDn8p4vJgm1IoKzdHGazbmCtypMzgEjTEo=
X-Google-Smtp-Source: AG47ELtNFqHS+dMa0To2PqFc77tKSNX1zMCnJDw9R5TYR6b8SUALQi8VUfu1WFusUruysmc61AehypP1vn4e86ueaEI=
X-Received: by 2002:a17:902:5203:: with SMTP id z3-v6mr6008854plh.392.1520011694265;
 Fri, 02 Mar 2018 09:28:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.137.23 with HTTP; Fri, 2 Mar 2018 09:28:13 -0800 (PST)
In-Reply-To: <20180302070434.GG238112@aiede.svl.corp.google.com>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
 <20180302070434.GG238112@aiede.svl.corp.google.com>
From:   Sam Kuper <sam.kuper@uclmail.net>
Date:   Fri, 2 Mar 2018 17:28:13 +0000
X-Google-Sender-Auth: Z7zk-_ddfy16d2uhJitFS_a1XyE
Message-ID: <CAD-Jur+juVNte7vJOi-iJYwPhbkoQOne9PTyRLD+skL_1=PgCQ@mail.gmail.com>
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/2018, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Is this reproducible for you?

Yes. It seems to occur consistently, given the same input.

> Do you have more details about how I can reproduce it?

Unfortunately, the particular git repo I encountered it on is private,
otherwise I would point you to it.

I haven't attempted to create a MWE. Am I correct that doing so is now
not needed, in the light of Jeff King's email below?


> What arch are you on?  What perl version do you use?  Can you report
> this using "reportbug git"?

All perfectly decent questions. For a modicum of security/privacy, I
would prefer to avoid answering them unless necessary.

Am I right in thinking that these answers are no longer needed, in the
light of Jeff King's email below?



On 02/03/2018, Jeff King <peff@peff.net> wrote:
>   3. Your invocation in particular is a problem because it uses
>      --word-diff, which will not have a one-to-one line correspondence
>      with the bare diff.
>
>      add--interactive handles pretty-printing by running the diff
>      command twice: once with no special options, and once with
>      "--color" and piped through the diffFilter. It assumes that the two
>      match each other line for line, so it shows you the "DISPLAY"
>      variant, but then ultimately applies the "TEXT" variant.
>
> And that last one is the cause of the errors you see:
>
>> Use of uninitialized value $_ in print at
>> /usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 74.
>
> The "DISPLAY" run for your case generates fewer lines than the "TEXT"
> run, and we complain on trying to show those extra lines.
