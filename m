Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BBBF1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbcG2AhK (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:37:10 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38303 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbcG2AhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:37:09 -0400
Received: by mail-it0-f44.google.com with SMTP id j124so95767931ith.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:37:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uqw+UHLBKp83ARawgSTVNKIeZ8wOPTOiv76tV6eZZSs=;
        b=a2wpYStQKfWW8MC3Qq/fg6JcRslhdYDSofYXihZmxjgFm5FMIv0U/hrbi2kV2B0yg7
         Iu+9A5mqJo2t/YOj/aLWZKj8N834czTGuTm1T1jjJrOs577XEhOi3mqHJWAs1yj+J09J
         reYZgjI6Sanhkx8nOxTtyj4KBUSEs1aLJR2wSkR/hDqYZd69lQxk55J505GGYt7rAP8j
         Whph46r8EhQcYWWNRim4fOxj26FCEMU1u5xOre7YY62BDSllD1dtgaWHi4gwbQjUXTYb
         OYKhWbeeG1UjIJ/SZsyWUyIgCtvs3Aoe/GTURBiwWMNrMP/wDGu2Sb15l3YK/VofzqGW
         PZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uqw+UHLBKp83ARawgSTVNKIeZ8wOPTOiv76tV6eZZSs=;
        b=idEn/pywBaQ5k/ZwpehZcmJgAcsPS22+j+pX+lv76MrogKBNr7KpwSKSr7GDSiDLG1
         UaKihF2Mh5evyKzhLYIp45CR0k0YChh2BLGr15D+1s7KpwheeOs9XuqtZZHGc8GK/Kzt
         B6KPuICQWz/KyixxDxmV6RpnZxrgTAWBPq+1CQyMgbClNgO0x5oKefd9KXMJL+iTPRtn
         xS1oHkhovyB7Qb/DZpcbgCu5KMyX3WhNA60EW7zM0b1ITE037E5ieBiqQJBaZ7Atz/tw
         T+cSFDew2oxnahekHm5sbiDVqk+q0G5QTE53lMHMx311HV+ijhcmayMI2Z8AvGJg56rG
         Fghw==
X-Gm-Message-State: ALyK8tLbj3+FkHjbjpWsnlOyFMGPJtsJMJQ9ew6Ki3B1DoaTKUuJA8BysASTnFtRa1duNalui9DQwVDiNM6Qqg==
X-Received: by 10.36.228.138 with SMTP id o132mr103513736ith.49.1469752628921;
 Thu, 28 Jul 2016 17:37:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.230.134 with HTTP; Thu, 28 Jul 2016 17:37:08 -0700 (PDT)
In-Reply-To: <20160729002902.GD9646@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com> <20160729002902.GD9646@sigill.intra.peff.net>
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Thu, 28 Jul 2016 17:37:08 -0700
X-Google-Sender-Auth: a9ZZKzBzYHldC46FLhgRepK_oc8
Message-ID: <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 5:29 PM, Jeff King <peff@peff.net> wrote:
>
> I guess we want something like:
>
> +void reset_ident_date(void)
> +{
> +       strbuf_reset(&git_default_date);
> +}

Looks sane.

> and then to sprinkle calls liberally through builtin-ified programs when
> they move from one unit of work to the next.

Maybe we can just add it to the end of commit_tree_extended(), and
just say "the cache is reset between commits".

That way there is no sprinking in random places.

           Linus
