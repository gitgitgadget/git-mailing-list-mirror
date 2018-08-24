Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FEFB1F428
	for <e@80x24.org>; Fri, 24 Aug 2018 23:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeHYDAh (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 23:00:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38606 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeHYDAh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 23:00:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so4238718edb.5
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIdTQHN14xDoS/A3tI/pnFOWvgXErarRBzihZcrSmhM=;
        b=Dn1UrVWAoiGJHBU45qDXYAjW5aREyapVpfjOH16T2KBPjfYrWfM3k/zwaGvFJXg0wJ
         oQgWToWcqVqWyVSsL3uFLcYsNqYAeI5fWO3bTt8pEsCEtRYJwJ4uWTJOK/vboxMk5b4L
         DU2kc0Ca39FurISV7dlAtpMaLSzRWe9f7Bm8lmpbV+QaC4qVRC8Mk1Zb5cq6CzVOUFia
         GX+JieGGCc9MY7JuHxAjyhLmghgHTI2FBol0q7RfIfTBqqPZjySkWEPbtzE1lZoJiczp
         ZDstHZUCI2EZ4/gtS8CnRwz2ZF0oEwM6K6lH+btbEm6XrZAwBy0lbTFiyoDZcMgA6mXF
         7FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIdTQHN14xDoS/A3tI/pnFOWvgXErarRBzihZcrSmhM=;
        b=C22Wr7AH23JU9BgsqJVHxNSldi4vJbBOgP9JAAywL6hs6ifqnvUHsOScZ176d6rrzv
         kvLBEA6ulEgpEDN8B/KCTGxChGAr/eAntdqKL1Ueo8+R6iZWdTDxYoyIXWCZvLlfXW7H
         DtDU3f+xrr+QzwteYnyBcLRT/v23Aryu+gMGF+5MCnYnhpC0TEG9nXH62cIhpol5y3TS
         ogWcZN7RpxW3GemwCAt65k++cEGDfDZXbv62m1/5AigqeZ4k/0j6kIkCSZ/1dmn7tVuN
         VfwwSmcd3wC4MLHNDs3AzQvQnv58ILB+J2Zi1f54w6MWAaKpZuuKkGUgmR7k7Pxlo0NP
         RbXA==
X-Gm-Message-State: APzg51ACilWLE21AMX7dyePioRaQTncIHwP4l9KF8zZMxmcDerVA8wG/
        KD3BVhMX11v8FR1mC/dEfk4KW15isin1eTDigY4=
X-Google-Smtp-Source: ANB0VdY7DGtOSpFVI2y11BCUPwN+IL2hxp4feYwAUq3wEqFE0ppkTOXvNM4lmb4a1JTLnlZ8hIc2yjO/O/iqsPWjSXU=
X-Received: by 2002:a50:8c45:: with SMTP id p63-v6mr5073022edp.84.1535153031077;
 Fri, 24 Aug 2018 16:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180820193007.GB31020@aiede.svl.corp.google.com>
 <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
 <20180823021156.GD92374@aiede.svl.corp.google.com> <20180823021547.GE92374@aiede.svl.corp.google.com>
 <CACsJy8DdZLxdA4XSVVBSpeZaF+q6=81LxecYea2JtJ6-Krnk-A@mail.gmail.com>
 <xmqqr2ipje5i.fsf@gitster-ct.c.googlers.com> <CA+P7+xq3m8PXo9wYu1L7p4uG4hf-i=uwQdh+e=0QJXG1cBi04A@mail.gmail.com>
 <CACsJy8AenCeoEmEZbYwgAA_U53D1cPXC1Ob7G-6MsoGQ_U2D0Q@mail.gmail.com>
In-Reply-To: <CACsJy8AenCeoEmEZbYwgAA_U53D1cPXC1Ob7G-6MsoGQ_U2D0Q@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 24 Aug 2018 16:23:38 -0700
Message-ID: <CA+P7+xqcjDACwBkB=TQEZqgyQrGzQiK8fk3C78vvAuRSHkPqXw@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 7:42 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Aug 24, 2018 at 5:02 AM Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > On Thu, Aug 23, 2018 at 9:28 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > I think the above example forgets "-a" on the final "git commit"
> > > step.  With it added, I can understand the concern (and I am sure
> > > you would, too).
> > >
> > > The user is trying to add everything done in the working tree, and
> > > "commit -a" would catch all changes to paths that were already
> > > tracked, but a separate "add" is necessary for newly created paths.
> > > But adding a new path means the index no longer matches HEAD, and
> > > the "commit -a" at the final step sweeps the changes to already
> > > tracked paths---failing that because there "already is something
> > > staged" will break the workflow.
> >
> > Right. I think this would need to be able to understand the case of
> > "different only by new files".
>
> OK so the rules I'm going to try to implement is, if the  version in
> the index is not the same as one in HEAD or one in worktree, then "git
> commit -a" fails.
>
> The unwritten line is, if the path in question does not exist in HEAD,
> then the first condition "as one in HEAD" is dropped, naturally. This
> addresses the "git add new-file" problem, but if you have made more
> changes in new-file in worktree after "git add" and do "git commit -a"
> then you still get rejected because it fails the second condition.
>
> File removal should be considered as well. But I don't foresee any
> problem there. Resolving merges, replacing higher stage entries with
> stage 0 will be accepted at "git commit -a" as usual.
>
> Let me know if we should tweak these rules (and how).
> --
> Duy

This seems reasonable to me. It might trigger a few issues with people
doing "git add new_file ; $EDITOR new_file ; git commit -a" but... I
know I've accidentally done "git commit -a" and had problems.

What about "git commit <file>"? That's another case where I've
accidentally lost some work for a similar reason.

Thanks,
Jake
