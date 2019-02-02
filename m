Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E5C211B5
	for <e@80x24.org>; Sat,  2 Feb 2019 11:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfBBLGp (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 06:06:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54816 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfBBLGp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 06:06:45 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so13633604ita.4
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 03:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Az6FhZqY0H1AfOgPeCGMuyFPwY34GSADbUbZOHNGlE=;
        b=f4/BLzqVYQ5hyOCoqSaqYBMQ6MCI/RuHkzg9NGHJFJtgXOdGTvMLX8of550sj8eUd6
         sGY9r/tXfNiY6KYkb+LdMT4ePQy5rCF2NXF2+FUUySnL8gVbcL7/3hC4kDh/L6wNcIMX
         PdRmLODj4yoFRs/pLLneUoRAju4idG2uJGdnLXqcEQTYrlbo3G71cCh01Zcr/Q8yClBq
         rC0mYsvh7f8rYsFdBfOOU5Au8kWDFmc7DsslR2PFOmguN6Sy3Wp1c74Du7beBEBjYTf6
         UAI0d6Tb/qbAFJMiiwdPFXaPJYQVTL8aPb0kYCh4f403V+gyDnknjj9djQUqnpUIuXya
         sq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Az6FhZqY0H1AfOgPeCGMuyFPwY34GSADbUbZOHNGlE=;
        b=MUGW2JbQUQq4TsWo0rfSuubPycOVPL/aRu1c4swfE9EDnoNn8rtWsSgCBME5oUBRm0
         xdramZRM5FsNDdA+YvaLyS64db2YWXNZqeHAEl/Bxes6mGsRXsChDs349QufSOZ26Xe4
         M6ipY7CarudTQyZk3MOZVhEX1sA+XrRIVtQ2wX/qIcS3aII36cfpNaK6WTMO7s35KFnj
         TQ2I9aI845/i04pG+M1jbMIWOo4ROLjlO4FKa6MzNZNToa2EfGhmG+rddf+QedGpnDBP
         Io26oqYkj6d7QlsJg//fQlUmDPnln7cOplLTk2lRL/ZCLQ2b1Oz3OwuYFjWL98mpdWNV
         DlyA==
X-Gm-Message-State: AHQUAuZSB1Q3zWDC4PasCFI7lwUnVHGy8PsE82t93ij3XrxclK+kKS6b
        xha18AsvzHymQ+KuqtaR5CXI9jza886ppiwhCb4=
X-Google-Smtp-Source: AHgI3IZq+kizLTeFJOwr2U5IrMNx6lGDpmlUOY+UlCdfXuDolmoy0+QS+BW5mRc/mRPzePA/nZZmedD5otC+UslUOPE=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr4144271ith.123.1549105603967;
 Sat, 02 Feb 2019 03:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190131133731.GK13764@szeder.dev>
 <CACsJy8A7TjYWJsxXETUU31JzZL-aCXcr+rHsQ23Ec1ujeMcQTA@mail.gmail.com> <xmqqk1ik3cvi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1ik3cvi.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Feb 2019 18:06:17 +0700
Message-ID: <CACsJy8D6+X7b842D4ZDgsLiYHt9+akTPiVtrbjcc8zxJw38TUw@mail.gmail.com>
Subject: Re: [PATCH 00/19] Add new command "switch"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 1:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> Adding '--soft|--hard' from 'git reset' would go in the opposite
> >> direction.
> >
> > If it's about the confusion, I think we can avoid it. If it's about
> > the one-command-do-all, I think it still fits in the main topic of
> > git-switch, which is about switching. But in git-reset case it's
> > switching HEAD, not a normal branch.
>
> I do not think "switch branch" should update HEAD for the branch.
> Let it be handled by "reset" (or "branch -f that-other-branch").

It can already, it's simply a shortcut for "git switch --force-create
<current-branch> -f <commit>" (or "git checkout -fB <current-branch>
<commit>"), at least for --hard. --mixed and --soft is just a
different variant of "-f".

> I personally did not have "it is way too overloaded" problem with
> "checkout", but it turns out that many others found it so.  You'll
> see the same happen for your "switch" if you do not resist
> temptation to add unrelated things (or things you may find related
> but you see others find unrelated even in this early discussion).

The thing about git-reset is it's also overloaded with updating things
other than HEAD. All the pathspec form is the same as checkout/restore
(except checkout updates both index/worktree while reset is more about
index; but restore can cover all index/worktree combination). But yeah
maybe just leave it for now. While trying to document the new option
in switch to replace reset, the verb "rewind" (the tip of the current
branch) seems fitting well. I might revisit this topic with git-rewind
or something.
-- 
Duy
