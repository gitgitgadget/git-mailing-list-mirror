Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15F01F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfH1P2C (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:28:02 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:41628 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfH1P2C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:28:02 -0400
Received: by mail-io1-f50.google.com with SMTP id j5so309789ioj.8
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKXrWUwBcD8omyd7aNLjUK1kZltGm77xmhremr0wINw=;
        b=uuvlTfykPv5Js6L1Fueb95iWzKP/gBEwluhF9KZgwq05oALZc40gpprdR2EASkFz5c
         vpMOSnAiFlr5+FtEFHUbSqRrZ0IfS/h3Svj1KG4LfNny17rQvvZZOG9QHjVO8WOUDvJa
         8LCxjpDcNFqK8f1mPFg8GRkvpgzqLW04bm26+F9089Y1e6fOZRveMFxbqxPt9GTf/qRr
         dYB4q2h4VbCFCLghINkOsuW4/4LWQlyuMd6D3ypYv5DsrKJD9RzbcVfaFzumIUKUw/Cf
         9I/vCe5WuGE47YF2QIdy4Jqa1qHuk5slfoZogY4EaR9PX/vHczMKH/rdtDHPLrSu2pmV
         8lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKXrWUwBcD8omyd7aNLjUK1kZltGm77xmhremr0wINw=;
        b=WSXPXl5cvB+XcCLjEKUAeSD7NuCNQsN8eO8KL2DtXJNzGMO5t9YqlsbsVT7F8QuHzb
         tpa/Fm3P3OU6sWjaT5YZfmR/56QlnXiqJlGicZ7/zKK0uHkvQMbYdc21ugAncrY/WoFY
         rmDQvryE7YL6NW3Fr/yQvi8rSZkwmsEQh7NvRHK94khMz/HkCoVBPupyKt+1+uMQ9axd
         c1Dw1WJ3qzixXVRxkaHZ35wnNoS57+JYDfJlUHWUYM02Vn7q8Ujo6N1iaqdMtN+l+9Gd
         qLN1jYE7jx63+SS2HlDNYMu65PEMcOIzrYXMwKawyBYQyrwr4qj71kNFKXRm4wOw0RtY
         CEgA==
X-Gm-Message-State: APjAAAWkCMASv1hvnZfg9bAPD7ds2U/SA4/74XhRxxyv8YPN6l0bte0G
        VSkBb4GShI4mY4q1hXqPd5iiX21KQOuKVHq/Rkw=
X-Google-Smtp-Source: APXvYqwRfzYQKYNytGZtYDhpKk8aS5c9Ggx1PZU6zrXzQ3AVLaH1S5P8r5HddcAuT2G9pgIw+UY4aeDg4pIztf9KUzQ=
X-Received: by 2002:a5d:9b96:: with SMTP id r22mr5195893iom.17.1567006081782;
 Wed, 28 Aug 2019 08:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
 <20190827190509.GB3150@sigill.intra.peff.net> <664344cb-f9e4-d4fc-fd14-620e3e10157a@disroot.org>
 <20190828150530.GD14432@sigill.intra.peff.net>
In-Reply-To: <20190828150530.GD14432@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Aug 2019 22:27:35 +0700
Message-ID: <CACsJy8CnaYqKSs7oCpCVSiVeferb9KJS6Fvu791BH8nBYKt6Jg@mail.gmail.com>
Subject: Re: Support for an interactive confirmation prompt when users can
 possibly lose their work like some UNIX commands
To:     Jeff King <peff@peff.net>
Cc:     Vipul <finn02@disroot.org>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 10:05 PM Jeff King <peff@peff.net> wrote:
> > > Note that there _are_ some commands which are not reversible: mostly
> > > things that drop content from the working tree. So "git reset --hard" is
> > > one, and "git clean" is another. There have been discussions and even
> > > some patches about storing the lost in an "undo log", but nothing has
> > > been merged.
> > >
> > Seems like a good idea. Are they ever gonna merge? If no, why? Or, it
> > will merge in next feature release.

If people are interested in the backup-log thing below, they can
reuse/refine the work or the idea from that, but I'm not going to push
it (or anything else) for merging.

> I don't know the latest state. A quick search of the archive showed this
> as the latest version:
>
>   https://public-inbox.org/git/20181209104419.12639-1-pclouds@gmail.com/
-- 
Duy
