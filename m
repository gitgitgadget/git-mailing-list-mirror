Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC192047F
	for <e@80x24.org>; Sun, 17 Sep 2017 20:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbdIQUme (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 16:42:34 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38708 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdIQUmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 16:42:33 -0400
Received: by mail-io0-f195.google.com with SMTP id e9so7288384iod.5
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zSKzGxuyuNFWbKCPjMTWyb17osAs3AbIqnzsdD26SSQ=;
        b=YZ4R4rfw4zBzpB8trhhjaO9yCGNcpYdJkmtfyRWugIrpQjq4M0JRsh4omRW00JXh9l
         MYW2WKJgV19BF+x0UmNzFIEMLae/dAhOKncxxSmGnT4YgiJ3Bu9cqoOenH6mO26l4o5u
         8qAg1wfa//HZGeIkBnDQx4Dd5bhddeDLdW9sj+C6FrZVEk/wx4MlB04c3JDe4zImGrQ0
         EeicGAgyjyglFNspqGSJtd6cewdBU34j/UCOMJIv5hvz4rnPifOeTo2PGkQuilidJMgm
         p0EPX0Dvh92yFv69ezt4MmteDB3h85xV4dh4/GaO6/DaxqRtMM+lDa6y0kkRLFOeuVGy
         r9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zSKzGxuyuNFWbKCPjMTWyb17osAs3AbIqnzsdD26SSQ=;
        b=hX3QFlODbhqRKvNy2E/vEJhCGuoLx909EPWT5hKkndeSxXTeD+iZfxysGRxP3bxAtp
         juUVe9I7WLsDqDEBgLxnzJJZt8NChtv2u7vjEABD2QtefTMwQarLAPWl/DNu2w+Rk8bZ
         XYpM3LTElsOq2zD824yto0YiCbiA/M54irsj7ZyjXcD/hA117E/zVv7K/zPNe1nyTMQT
         Xo74jNCy5PjN/NDQtyDN8M2Y78IdKMC10uIp/RTUpaqqnknS7HnzIs6mvay0PFQwJBfl
         Aa9R7CwBc02uDUvqaA5C9z3dqOWUgJtUQmcqtZ6RDpuR5OGnWEa+6IjbWO8wATBCl9Yq
         YfgQ==
X-Gm-Message-State: AHPjjUjaCU5EFuubTakXcUdl5LdA69sHF21gSeZFUenYGC78j4Aa9h6h
        p2YyRog0j5QjUmSHn8+4VG5VRJvK8A3TU9MmRvwhcw==
X-Google-Smtp-Source: AOwi7QDFHrWQZqh7+zoce9TyVP5ZOS01RdUmG8EHqHvT9VEJKqz8fjWJxmG7RkmXyXM89l9HduRSZpg+p5jFhEmFA2A=
X-Received: by 10.107.147.8 with SMTP id v8mr2521786iod.45.1505680952448; Sun,
 17 Sep 2017 13:42:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Sun, 17 Sep 2017 13:42:31 -0700 (PDT)
In-Reply-To: <1505679467-20720-1-git-send-email-bugosip@gmail.com>
References: <1505679467-20720-1-git-send-email-bugosip@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 17 Sep 2017 22:42:31 +0200
Message-ID: <CAP8UFD2f3jXkRHb_S_dK7TDfhBwXQ+O63cBn0J7iQQA-5ysVMQ@mail.gmail.com>
Subject: Re: [PATCH] pack: make packed_git_mru global a value instead of a pointer
To:     phionah bugosi <bugosip@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 17, 2017 at 10:17 PM, phionah bugosi <bugosip@gmail.com> wrote:
> Signed-off-by: phionah bugosi <bugosip@gmail.com>
> ---
>  builtin/pack-objects.c |  5 +++--
>  cache.h                |  7 -------
>  list.h                 |  6 ++++++
>  packfile.c             | 12 ++++++------
>  4 files changed, 15 insertions(+), 15 deletions(-)
>
> This patch makes packed_git_mru global a value instead of a pointer and
> makes use of list.h

Please explain _why_ you are doing that (why is the resulting code better).

You may also add [Outreachy] in the patch subject to tell people that
you are applying for the Outreachy round 15 program
(https://git.github.io/Outreachy-15/).

Thanks!
