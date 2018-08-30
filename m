Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A14D1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 15:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeH3Te2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 15:34:28 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51183 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3Te2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 15:34:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id s12-v6so2437394wmc.0
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oFB+jbYXnqXU9+CIgq3K0oxZkRKnMrEY3y37ZBcZbHw=;
        b=PQRSSPAUTchmpkb0l1S7UEBWCdTdEJ2iE1TVMut2kTpBu/Mss2O64EP8QBlAiqUCcr
         Auo8Ky9nVZ+2G6fZxwWogg3e+CXZuxXeHLoS+6s1qs+zKDJL4WP0YusVXApB+kSK/1P5
         /n5KSSLRZfmTaRDFdpY5HopIk9+Jzf+yBQRMwKKDRpQWPMyFcrowxVmrbYsMf3rzDtTa
         GBpkoFoxb6ylWgIA9izURz3rSGcVg8x5xf5j5IL8g8PajGbhgEZbEHqPGmp5EBEBmDKy
         nyLYuxJaJ6zfxcumqYTLtf7nBaQKGVKR5WHcgRFFUGrm9rlhQVFvwitR35+3D0+9e3P9
         loKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oFB+jbYXnqXU9+CIgq3K0oxZkRKnMrEY3y37ZBcZbHw=;
        b=dc6FHir3uhFtJL24SijLgAdb7MPx560h9Xy5U6owSi7DvAK2b0JZUCMiNaGKHOtF/5
         rlreYZccWzyiMn51btzp1ayUXhTgUK+HaR25IEHCPVKke8537XG91mBB9DHPI9zKm48Q
         KP7cWZCV7h4lnbU5N/b6Ih6Dkyg1WdHeZCPWPB25jfas1A7M5eFM7RDKf25nrdRB6qWx
         24EyBl339P2oGEyVdSNx69UPS6YoUajlPexyyTgYhBUz5nEQdj3zX2q2xwfsHa67RkP8
         urLZvsJfRBwVm3FUX0Jgn6QfTFlq3DwlzaTZK4Gv76o7/a5ex5cArXDO3U8df2WA9f4x
         0+6w==
X-Gm-Message-State: APzg51BSykn0Lb+Sz1zpxDLsf4nEj/B9DFnEwSFHwicg73xk/UKsn2IH
        T+TlEvSW1T3ej+jdm887bhc=
X-Google-Smtp-Source: ANB0VdYCDmHvaHV/mNA+g/GujkaYPq5FXbt6ERBfax5Eik6F7dLu3TBZ7SfMozsVUWWDQVZBfehi6w==
X-Received: by 2002:a1c:19c2:: with SMTP id 185-v6mr2187735wmz.79.1535643104647;
        Thu, 30 Aug 2018 08:31:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x16-v6sm11260605wrm.69.2018.08.30.08.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 08:31:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: feature request: allow commit.email config setting
References: <0f66ad7a-2289-2cce-6533-a27e19945187@rasmusvillemoes.dk>
Date:   Thu, 30 Aug 2018 08:31:43 -0700
In-Reply-To: <0f66ad7a-2289-2cce-6533-a27e19945187@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Thu, 30 Aug 2018 13:26:38 +0200")
Message-ID: <xmqq8t4n7twg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> ... I can set GIT_COMMITTER_EMAIL in the environment, but that is
> rather inconvenient, since that means I have to remember to do that in
> the shell I'm using for that particular project, and I can't use that
> shell for other projects.

We only have user.email and user.name because nobody in the past 10+
years had such a requirement, but I find it it a perfectly sensible
thing to wish to say "tagger.email and tagger.name are used while
creating an annotated tag, committer.email and committer.name are
used on the 'committer' line and author.email and author.name are
used on the 'author' line in a newly created commit; by the way, if
any of these are not set, but user.email or user.name is set, then
they are used as fallback values." at the design level.


