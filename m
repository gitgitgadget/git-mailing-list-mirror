Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28001F4F8
	for <e@80x24.org>; Mon, 10 Oct 2016 09:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbcJJJpe (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 05:45:34 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38714 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbcJJJpd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 05:45:33 -0400
Received: by mail-it0-f44.google.com with SMTP id o19so74336287ito.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=86NaNXNAyrqoMG+rB5GWZX8ETcDfGaeuK6L8kQBRGbU=;
        b=UzHaFwKpYft3QNxBUBOhYZnysAD0D6OBP7acDdpdqsxMHa9BxZKOmbWDli7b48Pxiq
         AwqxvnSuqo8DkmsDxB8bYt3oRCAoGmC5sbJrL2ntmpNA15zQc3XlEpW5dzEndcp4rpE5
         iOMtRNZQ4TNNTPozCzANBeFXGvhS7sIhBDsrYHoHm1YhqPEftrkEeuO7by+uARyPjiYO
         sqLk9GkYGQUuUHLcoKJO2RgBwC11UPlEbMzcGf8Su6s345WmbGdzvAhkTHO11gdEfDWA
         cF9mJ4/1Y0DTZs/Wa4NW0qSiUANC/xMonAo3hieAcxQHi4qhqeF0Kg+H3NXCKmp/pg6c
         c7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=86NaNXNAyrqoMG+rB5GWZX8ETcDfGaeuK6L8kQBRGbU=;
        b=jctoRIXNa/EOIC4Xwr4VlnrLd82/7lhf4xCBSEZdrZS9MymfCGhOnWb2ypAzquCf3P
         okLRrunkDxJztaIaSTG3Qiu8y7wo030ce9FXyInfXVYZufgATSoRo7B5ghaefatRya8y
         i75Mxg4Zxxo7e+pHmUGKmE2Xm+dfbe7UMuaMCIYEBdKns+ccWlEaEhhD7RJjVqdEwJyQ
         48mNJQSyO/+7JD8M/lw6NHklEJ1O7VhEoFBRoznXIHVb2caZoUUjVm9BHFWKzJxY+m+y
         18jkz0sKbdQDLdmfeeX/OGL6H8qP7MSBMCOP6+InfE1pJuQDnqbONImqzj9Ij8+CKRtT
         X9kA==
X-Gm-Message-State: AA6/9Rkzkj9YSVPMwbAdPcZi3bFF5YEHgUhmaWl/X7n5x/34rME3BXjzK2ente5AFUqDhPQtTo5jf1NWacLEuA==
X-Received: by 10.36.70.142 with SMTP id j136mr2772298itb.50.1476092732348;
 Mon, 10 Oct 2016 02:45:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Mon, 10 Oct 2016 02:45:01 -0700 (PDT)
In-Reply-To: <CAOi_75+Zoeeq5FD1HKgG4MjeL9LkBshsSfdrMOTi8m-Mt-OQNQ@mail.gmail.com>
References: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
 <1475999513.7410.8.camel@kaarsemaker.net> <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
 <CAOi_75+Zoeeq5FD1HKgG4MjeL9LkBshsSfdrMOTi8m-Mt-OQNQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Oct 2016 16:45:01 +0700
Message-ID: <CACsJy8DMKWeZ+DuQ0uoY6rdPfusq8D1SfBCkPyn+6X9S589ncg@mail.gmail.com>
Subject: Re: Bug? git worktree fails with master on bare repo
To:     Michael Tutty <mtutty@gforgegroup.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 9, 2016 at 8:42 PM, Michael Tutty <mtutty@gforgegroup.com> wrote:
> Dennis,
> Thanks for the great response, and for spending time on my issue.
> I'll try that first patch and see what happens.
>
> In the meantime, it got weirder...
>
> I created a brand-new (bare) repo

Elaboration needed here. If I create a bare _clone_, then "HEAD" could
be detached, or point to some branch, depending on where "HEAD" is in
the source repo. If source repo's HEAD is "master", I got the same
behavior (worktree add fails). If it's detached or points to some
other branch, it's ok. If this is "git init --bare" then I got "fatal:
invalid reference: master".

> and was able to git add worktree
> /path master.  I was able to do this repeatedly, even using the
> worktree to merge other branches to master.  I didn't find any
> condition or step that caused some kind of orphan master work tree,
> which was what I thought the underlying problem might be.
-- 
Duy
