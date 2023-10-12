Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA0CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 05:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbjJLF5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJLF5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 01:57:46 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C25A9
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 22:57:45 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697090264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9C+4gpNHQ5rNCV5dKq+qFPOwhNpjYndasKiEsEl26lQ=;
        b=yKzrIcqoA9a51Ptc8ljdGg0+bVmKFZGaCMw3Ee1QoPJMG2gYSCQa7g5Gr7dD6ezW0yuKjE
        MpQDdFVxSYORy3Bpc6VzBRstDpQ26TCgj/VF93JWKQLiz4KPWg+DpNbrxRbiZRRN17LKUH
        Y4+T9x9G8rqz/zSpjcNZuNTrLVwKT54HOZazLXyGRWLCxcAniWUiA83kl/WgN9hQVXsGpy
        TSH8Sm6yY7xQurFZjczNjFr2qIrlS5IQb8v9sct/hnvLmHKXC5D5+TGkqWWqi18vMtWlhM
        3yrlP67A2Es2sh6kzEfKuHzQaL425Yuwzr8SqDF+7qNjJC79UI6Pdk7fp0qdHg==
Date:   Thu, 12 Oct 2023 07:57:43 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <07bf5744c7d123635740c62a940999e089339fa4.camel@scientia.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <07bf5744c7d123635740c62a940999e089339fa4.camel@scientia.org>
Message-ID: <1ef5b918d54cc1444c4a5b8df3a340ad@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-12 05:54, Christoph Anton Mitterer wrote:
> Hey.
> 
> Just noted that the popular bat utility apparently also uses -X to make
> -F work (but also mention that this break scrolling).
> 
> But it seem they have a check, an if less is version 530 or newer they
> don't set -X.
> 
> https://github.com/sharkdp/bat#using-a-different-pager
> 
> Could be a way to go for git.

Let me repeat that the described scrolling-related issues are 
misleading.  I use this, configured through $BAT_PAGER, and have never 
experienced such issues in a few years of using bat(1):

       ├─bash
       │   └─bat -n --tabs 8 --wrap never message.txt
       │       └─less -R -F -X
