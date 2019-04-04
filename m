Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE58320248
	for <e@80x24.org>; Thu,  4 Apr 2019 09:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbfDDJNV (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:13:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54898 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733232AbfDDJNT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so2131341wml.4
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4rnVFTIgiqBKyRez23307x1pnAxQGO4DYmBv5I1+/XE=;
        b=mfhMMr6ddAUBMWMy7+udWiB7zkfqJMqExewNPTFuQrEiS2XGzij9rAbcACu45cxLlk
         9CV76E9z/u2RA8IrIX15airygXmXgiwNEvfj2pV8tfklWcleQesQpTd9Z5ZnVzuZEbw3
         Cb/BsBZ0JB4gM2XYlxU0EBCcSaCHNub+dVAuSEpWg7mWxtlWI2IvhKo3Ztz1K9fxzIei
         6pKxVrMJdHBrHQYw7aFbWQ5FSKUQyuJ1jYWc/GGo1tteLLT/VF1tXE/Dg51aHUDYKnIO
         T6fUalke1Qr6meTmu/Af+3mQ8l+IBw2UeJgIgvg2g6koaL3WlMOnv1ZIrR9P2xSdDGgD
         1jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4rnVFTIgiqBKyRez23307x1pnAxQGO4DYmBv5I1+/XE=;
        b=RtgXCuIH8iMKqsmUOZJ7POmvTlCnvxCvz6MrYeir48N/tLuDDx6nPKB4hiwXjPoxfW
         xFjOBZ/Hk/ObI3VjkU838rtNArv9RBxIbKkGsgGj2eXfbpCo0/cQJMXi0mTSzVdIZnAT
         t/vQFffW/LOHsm9+WcTHNjufbGMtVF1I9qPUu7Nx+Q2J/fN3PuU8VxjXpDUwX+lDeIqj
         AGT+X8gUubEog5/mfl+3HT/moA3YY7+mjslTIpB/12q322ovZqyWN4ZbEnx/omn2RQzq
         TTX+fUWj0poUMtgXJHjjC3aumNsZdr4Cuw5bMVJ9Mgvw2b8qvXO/L5gABP2fXfymCja6
         j4sQ==
X-Gm-Message-State: APjAAAXsPYrVqKmTZeLUnf/EMVWjA9p2sHdYRdXuEcctowveqNlpAwrl
        nafW+mKjU00J6RImQFjJmZAMRZiKjXw=
X-Google-Smtp-Source: APXvYqzYt5qKUkZ+wEdw797dvi8Q16DBlL0QLIpFORulMtREWze8M3SOCoztiz52E99q+KKxvj+qew==
X-Received: by 2002:a1c:be13:: with SMTP id o19mr2989127wmf.19.1554369197193;
        Thu, 04 Apr 2019 02:13:17 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a6sm13533650wrp.49.2019.04.04.02.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:13:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Feature request: Add --no-edit to git tag command
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
        <20190404015744.GF4409@sigill.intra.peff.net>
Date:   Thu, 04 Apr 2019 18:13:16 +0900
In-Reply-To: <20190404015744.GF4409@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Apr 2019 21:57:44 -0400")
Message-ID: <xmqqo95mf80j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 03, 2019 at 09:38:02AM -0500, Robert Dailey wrote:
>
>> Similar to git commit, it would be nice to have a --no-edit option for
>> git tag. Use case is when I force-recreate a tag:
>> 
>> $ git tag -af 1.0 123abc
>> 
>> An editor will be prompted with the previous annotated tag message. I
>> would like to add --no-edit to instruct it to use any previously
>> provided message and without prompting the editor:
>> 
>> $ git tag --no-edit -af 1.0 123abc
>
> Yeah, that sounds like a good idea.

I am not so sure this is a good idea, especially if the plan is to
do this alone without necessary associated change to make things
consistent.

The part that bothers me most is use of "-f".  The mentalitly behind
"-f" is "I am creating a new and tag that is totally unrelated to
any existing tag, but since the command refuses to reuse the ref to
point at my new tag, I am giving an '-f' to force (1) unpointing the
existing unrelated tag and (2) pointing the enwly created tag with
that tagname".

The proposed change still uses "-f" but wants to somehow take the
tag message from the unrelated tag that happens to sit at the same
place as the new tag wants to go.  That breaks the mental model a
big way.

If this were a new option that is spelled "--amend", I won't
be complaining, though.
