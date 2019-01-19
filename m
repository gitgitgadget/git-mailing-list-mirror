Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CEA1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 21:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfASVTD (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 16:19:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44020 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbfASVTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 16:19:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so14457466lji.10
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+X3fJT5iattTO1C9mmIQtnHdy15yWUBNvRsoALdUtk=;
        b=G26f6gk5nBk8AtE/109O1WhqjRu/AfBoOFSwyBOcI/y/eAwTqoHBS623NrY+j2nWqc
         6PoazvJCWTjCBY3OKZWifmJMEiFkT211NK03VYkIrS94d905hmVGme0jaXKmFHaFQKHh
         3DRS3ur36aMoziNO8XF91wfeSx29guzrt3OW6SMR/9dOAY8QqTyuAam2I1XhyoWeVMMf
         epdg87+tmzlz1YVA4ptbgxE/Ki4djecwC7z/cfcGHePqglO6dpEPD/JuulLrTGE38oIU
         TODeLz77Wdjh9hzCHyRFquGtKCu35Z9YI0fZmz5xrY5p3euqhZavqlEx3oyUsfvl9BVI
         A55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+X3fJT5iattTO1C9mmIQtnHdy15yWUBNvRsoALdUtk=;
        b=dQqDdkZkXR7lFZSK6hOAljZWq38e5ou3BVEms3IWcazxl+34nQODgVItuDWPR6JVtH
         UlllA/VG09n6B4+Bso9g3ujmb/vJYhE7Hdl4HJd9GPzKJTvNXi4TaOZCTPYT7EFxq9U8
         33nwGfNcTM6GCh1+U8yY7EeNfBXarw/KEt9dzrKFMxGPOv7fjo5b11edAJb/EMtI97Zw
         8y4iEZvjoYNjVKCq23yL4aLDOYHh0B97kQc+Eeb+cz/ciSuZH9cGNPgu7BZJQbjRFYyi
         oEyEQaZu4FWkxrAGMjVvRvx+IC7ZGYIJgY+DzppwwYDgVAQE5MWpeAO4IylrUBbiTwMO
         hc4g==
X-Gm-Message-State: AJcUukfu31x0TiLFV6H6jGH0QPHu2dZZ2FM8OTOzKegXFtXIjIpAze76
        xu7dO4unxEjkq3vyuLoSZLm/qkn0sRYcZaCo/is=
X-Google-Smtp-Source: ALg8bN4cVx3fnv5PnWSFEHGwNIHFmoffwLWVjoeDRKJF9151X7wD5cUo3+YjY3gFtYhC+JohvyCMOwPLMUwmrLjUKms=
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr16225566ljb.106.1547932741033;
 Sat, 19 Jan 2019 13:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20190119033530.4241-1-brandon1024.br@gmail.com>
 <20190119154552.12189-1-martin.agren@gmail.com> <CAETBDP5Ve=85Jtkb55=htPO1eiZQmqG7deUX_BF6ih259gY-XQ@mail.gmail.com>
In-Reply-To: <CAETBDP5Ve=85Jtkb55=htPO1eiZQmqG7deUX_BF6ih259gY-XQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 19 Jan 2019 22:18:46 +0100
Message-ID: <CAN0heSo7CmuAYJGK5RjRkT9TX+RUyNDk-Rp_n-OCN8q1O6xNzA@mail.gmail.com>
Subject: Re: [PATCH v3] commit-tree: add missing --gpg-sign flag
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Sat, 19 Jan 2019 at 19:05, Brandon Richardson
<brandon1024.br@gmail.com> wrote:
> > I looked into this test in a bit more detail, and it seems to be quite
> > hard to get right. Part of the reason is that `git commit-tree` requires
> > a bit more careful use than `git commit`, but part of it is that the
> > tests that we already have for `git commit-tree [-S]` right before the
> > ones you're adding are a bit too loose, IMHO. So they're not ideal for
> > copy-pasting... I've come up with the patch below, which you might want
> > to use as a basis for your work.

> Just finished adding in the changes you suggested, and everything looks
> good on my end. I based my changes on the patch you provided.
>
> > Or, a bit simpler:
> >
> >   oid=$(echo 10 | git commit-tree -S HEAD^{tree}) &&
> >   git tag tenth-signed "$oid"
>
> Just noticed your latest email. Do you prefer it this way?

I think so, yeah. (But who knows what others might prefer? ;-) )

The use of "" around $oid is perhaps a bit subtle, but not too much so,
I think. The "test_line_count" version was probably a bit too paranoid
and verbose, for no real gain.

> If so, I can amend
> what I have before I submit v4.
>
> When I submit v4, should I submit the patch you created as well, given
> that my changes are based off of it?

I think the cleanest would be to submit a two-patch series, v4.

Alternatively, you could submit only a patch of your own, but it should
then be based directly off of origin/master. So the test in it could
be inspired by my patch, but yours would not have mine as a parent and
the context lines of your patch would look like what is currently in
master. My patch could then go on top of yours, as a "the new tests are
more robust than these old ones; let's rewrite them to the new style".

Thanks
Martin
