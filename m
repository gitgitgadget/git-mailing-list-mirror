Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56611200B9
	for <e@80x24.org>; Tue,  8 May 2018 00:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbeEHAor (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 20:44:47 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:40636 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbeEHAoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 20:44:46 -0400
Received: by mail-wm0-f51.google.com with SMTP id j5-v6so18424081wme.5
        for <git@vger.kernel.org>; Mon, 07 May 2018 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9HU7yqbuvW44f0om/EwhMlKfp7Wzsyw7vWgs23rcvR4=;
        b=kvD3ZNyU/T/2bxObsfMkIiitokz4ql6IF+06WsU5ThmMzczruW7BvICg/XCVcEsV6e
         515dU89Qa4LPlKgqVbTOLcVvZcnQHgG+mMbaKQx+tR6XDPgnvxKZ+R0ymSdpuZTJIoIQ
         UnaydCbMhL9WKe14SXXYtRwqCEP8nSZz73uzYpSgx+UAQiBJGY2tVFSZRAQ5fcTTYixk
         bClunWOzpirUeuzt42i3CTAjbdIodqkH6kOLpq40yBnPXOxh9hYzHkOpc18n4m8kNvC4
         +QySo35++8L0zZeRm7Jc0HSXEs1iYs/afge/QpLBVUUzCFqXUVFlmcXnxT0Y4SgVy4+6
         mvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9HU7yqbuvW44f0om/EwhMlKfp7Wzsyw7vWgs23rcvR4=;
        b=C7OWm5GYJMn01l2XR9+NAnoB0SjTGJ+SlwH3kuyK/ZNaYTv3OC6ZD6PGXvHc8oUttP
         n4Pgald8+y3FxzHGv6hnPXjqHiS5WsNZplRoXSN4D7OP9nX0zShwQu8bTliil4lIsAsS
         zjpZpjEJetUzXC2lcqzLyf/FCwP5/2eMGJWjAo3/arIx3M5McC0FE8A+oTHVeSb6O8O/
         4h4f23QJNHC2ErDt+9ptFEFrl1+AhtgU5C7DTkP2SEwTtXvfLFSOiWWQNdWofF36Zzlc
         p6CU1UmDzfemaCE+HQOShb+H1SNfIBBtLlaYke6ASOEaIKxRcaz+enuSE6ewk5ZbYL01
         AsPA==
X-Gm-Message-State: ALKqPwdiss67cF5or4KsxtO5SsH46jwjnBId8OmbKZxiqKbEimdCI36g
        W7O6OPIZ4n/bp6Sku1YULZc=
X-Google-Smtp-Source: AB8JxZqR9I3xNA61CRoIPwle+7AhTHs8FMNQhReZW18h+vS4BwQncmgVPo68UeUsXHPWKIO4otkeiQ==
X-Received: by 10.28.197.136 with SMTP id v130mr1808835wmf.135.1525740285195;
        Mon, 07 May 2018 17:44:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m35-v6sm25302477wrm.51.2018.05.07.17.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 17:44:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #01; Mon, 7)
References: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
        <1bb666a1-ce44-3eb0-e63c-a6a9e2a675dd@gmail.com>
        <CABPp-BFyj7SCfUbJzfjt==abORdUtfgRRywyjf0V73rDnygHGw@mail.gmail.com>
Date:   Tue, 08 May 2018 09:44:44 +0900
In-Reply-To: <CABPp-BFyj7SCfUbJzfjt==abORdUtfgRRywyjf0V73rDnygHGw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 7 May 2018 09:33:56 -0700")
Message-ID: <xmqqo9hrnfgj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm actually curious what the "Will merge to 'master'" and "Will merge
> to 'next'" are intended to mean in general.  I thought it meant that
> the topic would be merged the following week barring further
> discussion, but that hasn't always been the case ...

These have always been "eventually in some future", not "next
week".

A topic with potentially high impact tends to cook in 'next' longer
than a trivial typo fix, so that it has better chance of getting
stopped by the community dogfooding of 'next' before getting merged
to 'master' and bite the general public.

And the commit-graph thing certainly is a bigger beast I'd feel
safer if people tested heavily while it is in 'next' before it hits
'master'.

