Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2934A1F45F
	for <e@80x24.org>; Tue,  7 May 2019 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEGLCm (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 07:02:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51550 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEGLCl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 07:02:41 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so13428534itk.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hduXHfZK2DMf+SHdhWhnUX91YNxbGmxsbv1ojJ4yOn4=;
        b=ptBccLIuA2zahc2lszTa/FWW5CS8xFCszaM2PXt/oqJSSeJ0pjBQzplU2SsBXTZ1RC
         MQy/rKygko+AAXuLJHk6zqNDYB+cgjqrR2HGJ4UBBFCvxaDakYtJjhWIAnAKPVYyXX/7
         vvNcJ69HdAfgSXgiyBannxSXSg8XRMeFaZ0e5fS6J0SsTz2yeT177VDlElJKpoHY7pYW
         6cn4xJdRfOyiBy3fwHreCgHmmtuQS0fQh14AqmovSKWUcPy98/GYJg0K54cg2/T/T8uB
         JDwuN+6dGSSzbGQuViLv8Hh03G+NY/Jh1xlXIvPrVcgS0A7kZ10fRaeecVQ880uFj04M
         KxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hduXHfZK2DMf+SHdhWhnUX91YNxbGmxsbv1ojJ4yOn4=;
        b=ek+Vd4UJ7JkS0+jV4gTWLbEbFxGFtOKIa/mjnZCQIcE5ZW5aLeNsxme4cZlhbxyel6
         vDQgwTgG3Kaoj39FZTB2y8LAW97DGiQhJVrG7jRezvBE5iY65H57gQnDMaa4AvKVL+Yo
         BduHV2MCv2QQ0zog6IcDecY4Xjn0vRs5xB5DbUmFDgcZ9XaTJfTB3RfRSZxO4W12euHJ
         ebBX0goeMjMoSYO/hGtusDhHVGOzAF1oJdOEZPUOa6bL2pFP0uY8aObcgoiAQw5iGokH
         3nRpxAOsLl3Isj682bUpAfC4s2Lrm6X7JRZxNMDkuN5MhFTxViBLvVezLD2l3HGWxk5e
         ju8A==
X-Gm-Message-State: APjAAAWXnlzL8oWyYvyVSMwAIyLB9zD0DC/8PklFhZz8y+3XtzSx2BHB
        9rRPdjW/2+rSEAJnLnGQoyvghJ1IpoSkVNAP6UY=
X-Google-Smtp-Source: APXvYqz6XXJCt/+VyTYCk05gIw4nQpQAt0JwrD7faPu8dBnLe/gQYHYl2hLbthNud6hggrD6uOU/9fAY0M3gUAvX5vA=
X-Received: by 2002:a05:660c:34e:: with SMTP id b14mr1173118itl.10.1557226960872;
 Tue, 07 May 2019 04:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190501101403.20294-1-phillip.wood123@gmail.com>
 <CACsJy8CNUEBXmBcQnRHqdeFJtTvBuZ9thP7QPAw-ZOD+2ty3VA@mail.gmail.com>
 <d4c36a24-b40c-a6ca-7a05-572ab93a0101@gmail.com> <CACsJy8AAj8cRAc+PnS4OJy8M=K7FjCHUsL6Cx-6+RTAbTA_1fQ@mail.gmail.com>
 <994d4687-39ed-91b9-cdf9-d4be39cbb2ba@gmail.com>
In-Reply-To: <994d4687-39ed-91b9-cdf9-d4be39cbb2ba@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 7 May 2019 18:02:14 +0700
Message-ID: <CACsJy8A+EjymUsSHD8Wj3y3=SfCkaWtfYhjqv+OyaXpkrQXkVg@mail.gmail.com>
Subject: Re: [PATCH 0/2] read-tree: improve untracked file support
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 7, 2019 at 5:02 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > My (biased, obviously) view is that "git reset --hard" is very
> > dangerous and I'm not trying to change that, especially when its
> > behavior has been like this since forever and I'm sure it's used in
> > scripts.
> >
> > Instead "git restore" should be used when you need "git reset --hard
> > HEAD", the most often use case. And since it's new, changing default
> > behavior is not a problem. Which brings us back to git-restore :)
>
> Does restore clean up the branch state like reset? It's tricky because
> you only want to do that if there is no pathspec (or the pathspec is :/
> or equivalent - I can't remember if restore always requires paths or not)

Nope. git-restore cares about files, not branches. Yes git-restore
always requires paths, just in case people type "git restore" and
expect to see help usage or something.

> > But either way, git-restore or git-reset, I still don't see why
> > untracked files are more valuable in this case than tracked ones to
> > change the default.
>
> My issue is that is easy to see what changes you're going to lose in
> tracked files by running diff. For untracked files diff just says a new
> file will be created, it ignores the current contents as the path is in
> the index so it is easy to overwrite changes without realizing. There's
> also a philosophical point that git should not be stomping on paths that
> it is not tracking though that's a bit moot if a path is tracked in one
> revision but not another.

Ah good point about diff. If only we had "git reset --dry-run" (that
shows the diff, including untracked files; or perhaps --diff would be
a better name for that imaginary option)
-- 
Duy
