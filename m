Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B059207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1039177AbdDUM1x (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 08:27:53 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36304 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1039170AbdDUM1v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 08:27:51 -0400
Received: by mail-oi0-f54.google.com with SMTP id s131so6295117oia.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gwL/hRfvhBVwJDRgrEjjkLll1gEQgN9PJTPhbnTp0sk=;
        b=bh20epJ9x65tLcp0vckrnAktwTSh+o3dvTHMhKdRAFTb7STkgoM0kcf12LYrER8WPN
         fSTErXn835IerF+rZLnLLtRZe+UU2NhGKmxy/bjSZtKXig+Q1gFKps5dMyB4YdVcz87i
         BT+2oAdxx5rJvk5ACneH1c8fe7YHGAEKItiXSbhq4HvY9Bgz/6Ou5nGwZurGZT280E+M
         +kL+OCLg4LriU1om5DyMPyCjXAwV7EGzc0A58tAdrdBMcadt//d7l9bihhobW5b8PGaI
         blUGzgwJ+C6RuZdU5ctxidTGIWJOXI4WOzVt3g+KV6lsmMUUPHwa9GebP40YK61+5JWu
         Ngfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gwL/hRfvhBVwJDRgrEjjkLll1gEQgN9PJTPhbnTp0sk=;
        b=R50T1ywqxOpyq3OHcMnsMveFj4uVCo7xZg63rgKT90KslCDFj+dtzlsNEl9egHz7uk
         usth8Lpgb7s5Ita08cKZZwbPLPS5oVTWyH+LMqgLIYnMAVC4aMCT2gQFW1DKcpXe98YQ
         t42DOdU///sbDpCo0lEfk7AwxDJfDa4WYp9mu8nmLC+gqiXSkDN4Z0DCoLYVYYoA/zx6
         Tr9JVqLrCalvNSIvKmyg/fjMpFZgD98rrK552Q99Thwa4kqRsFj5QyvYL72mzc4RLFmM
         8zQCYmfIaAb87icghGpI9HWXNk5wuOZXUeCODZKjAEtllTk9E0sn28iJETZa1r7KAFAA
         JQLw==
X-Gm-Message-State: AN3rC/6BSQ98nrt9vW/OJ912ZmnH4bLqGxjLiLn1pk8VBamddLda0F8J
        OImIN7NnJMeb38N/3eKYh49yTHfUoQ==
X-Received: by 10.157.61.163 with SMTP id l32mr8608461otc.28.1492777670917;
 Fri, 21 Apr 2017 05:27:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 21 Apr 2017 05:27:20 -0700 (PDT)
In-Reply-To: <CAPc5daXPgEFibr28-EZjk9_vYrrO2qt9VLXW6PepmFXUChpk7Q@mail.gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com> <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com>
 <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com> <20170421062915.he5tlgjqq7kj5h32@sigill.intra.peff.net>
 <CACsJy8D1LuH6qVp15MSkCM_oQphVUUK0r9SeKC5AzX+9Xi2dcw@mail.gmail.com> <CAPc5daXPgEFibr28-EZjk9_vYrrO2qt9VLXW6PepmFXUChpk7Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Apr 2017 19:27:20 +0700
Message-ID: <CACsJy8CCW+gQ6n2VOC4nmRBukHSLyxYizQhowQoNOc8weZzJjA@mail.gmail.com>
Subject: Re: [PATCH 00/15] Handle fopen() errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 6:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yes, but (1) we'd need to be careful about --quiet

Yeah. It's a real pain point for making changes like this. At some
point we should just have a global (maybe multi-level) quiet flag.
-- 
Duy
