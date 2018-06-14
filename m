Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0701A1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 16:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbeFNQWc (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 12:22:32 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42423 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935116AbeFNQWb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 12:22:31 -0400
Received: by mail-ot0-f195.google.com with SMTP id 92-v6so7733051otw.9
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7x+fXN3A3qkSXwtJMxfTvbQZP/v7VCzcTpoXFYggfc=;
        b=c0MOZwEBl59LtPsIebRVcUBGxMMuGKvPEnyh3uxPtjqN5JVRKdYaP9e/RkWV6mk/xS
         nI/3yh6z0sE7oOMQYvGirBHexAT5inehRPrmyhoJsv8aPgDEtEW7E9CzFnffwS3uDh69
         PqE6IqbcXKPVqT872x1K4P5A0ImR9GuDTXVKJRrAzxhvaUP9wBQ0vQLsP09BPW1z4y8+
         ODTHAOBxvsixDGxGMv6N1uFUS6lS1BAgZfv3hcXBNq2XoTcNKDZJ2FVZc9rYNJqVe+WP
         XmXOM5YEKeHSH502GJQldI3b0tF+WvzoLg3Dqs8hFRSgUENq215OFldn2aZ6O8yIwbfS
         DBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7x+fXN3A3qkSXwtJMxfTvbQZP/v7VCzcTpoXFYggfc=;
        b=CrDxdgjYSr0YIPF2JWmDVKya8sBnp2VWqeA/RMxwlrOSSCWgKjkfxboJUNhTk6ce9T
         TGcyFzlaNkUMClNtM63BeSbIX1Bk20jS2EDUMqIQIIhzMpYmSAoh9n++t1H+xwRpumcH
         gENi6Pcy9iZ9c64b4TN4Ny0U7/GXBwSjCljohCUzeJYVKOIvYH7sHD3UQ5k0WhO72LSy
         KZB0NIjMLUsTvpcWYuI0EsXdPKh6DAf/wPoGfIpisJ9v1snTrQmlhsxPPcn52/+qbki9
         XFmtVMq7zNkuUewAOpu5mc5iEYFvnPBHBupXl0EfNTm/+t1d1IKJHIUckU5vEp8IJ5Ou
         VXRg==
X-Gm-Message-State: APt69E1LJM5lQrROOIRVGFB3o37qnkrthlBx4+CEXBGEcHuhPUXNQO9R
        Ke/tw5Imxzxza3hkemxd5bTXmzDQqFSLKoUihSw=
X-Google-Smtp-Source: ADUXVKKcYJQUYQTLNA2fWqsqm43ic7KysdivrjDHfQtOg7zALO2PtNNyvcC5G78FoANIvXs1+CrJCwWZwCAMJfzttz0=
X-Received: by 2002:a9d:124:: with SMTP id 33-v6mr1854302otu.65.1528993350442;
 Thu, 14 Jun 2018 09:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180530004810.30076-1-sbeller@google.com> <20180530004810.30076-11-sbeller@google.com>
In-Reply-To: <20180530004810.30076-11-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Jun 2018 18:22:04 +0200
Message-ID: <CACsJy8D2JbeWvBg9F69tAJgq1874=ROFBG-QKfCHeUMZwcY-VQ@mail.gmail.com>
Subject: Re: [PATCH 10/35] commit: add repository argument to lookup_commit
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 2:51 AM Stefan Beller <sbeller@google.com> wrote:
> diff --git a/shallow.c b/shallow.c
> index 9bb07a56dca..60fe1fe1e58 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -31,7 +31,7 @@ int register_shallow(struct repository *r, const struct object_id *oid)
>  {
>         struct commit_graft *graft =
>                 xmalloc(sizeof(struct commit_graft));
> -       struct commit *commit = lookup_commit(oid);
> +       struct commit *commit = lookup_commit(the_repository, oid);

This looks wrong. register_shallow() has struct repository argument
'r' and it should be used here instead.

If this is a mechanical conversion, I will also be happy that the
switch from the_repo to r is done in a separate patch.

FYI I noticed this because I'm in a quest to kill the_index by passing
'struct index_state *' throughout library code, and sometimes I pass
'struct repository *' instead when I see that code uses more things
that just the index.  And I have started to replace the_repository in
some places with a function argument.

If some of my patches come first while you have not finished
repository conversion (very likely), you and I will have to pay
attention to this more often.
-- 
Duy
