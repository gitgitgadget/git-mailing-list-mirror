Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663F11F462
	for <e@80x24.org>; Mon, 29 Jul 2019 05:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfG2F3q (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 01:29:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39489 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfG2F3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 01:29:46 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so117368169ioh.6
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 22:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShcdPT7I3s247PduQixjUolyXxoFSryyggyHRz+/N/0=;
        b=UbsYIvItEc7rVmjifWt4IATvmDjIwgHaucq04oZSprjAA7GoyL7BxLTIhAROfWoqo+
         7oFc22Xj0gDVPVUDhePlgTqBc/9bLEF1NFg+HykWpEf4yDP9yJc6X4SsIpp+tg0sRfgc
         o3TN4Cn6//sSAIB44fRXGHDAfVWFD+bGIoqeQvfrJ6xo0tNXxJPl2Ut+fuPxA8PeLrAK
         OpyjmoKfKFqWJ+kBPzUyFcDnwEv4UkS58/0Bp35GNXRFs9b63ZmUlmg8pBI5LseKwQiZ
         OD/HlGsqOe7ek61t2isjIckEDjyQh+y+jLt6UAjlL/6y/RqIdCKuUGjwZAGw9P6DNT5y
         VhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShcdPT7I3s247PduQixjUolyXxoFSryyggyHRz+/N/0=;
        b=QcIaXbDVQb4H1OXTZJJJ5aHIKUVtM1u+wO03MszbDOfsNI9htCT1SzVBYRmlLR0pGc
         1IUr2LUTJCWrMrtXcN7h4uwBZ2XavEEt/6ESTbUzuHXKNr/QvKRkBF3kJzsmBbQGjiAW
         HddI+gO80ahPQasqhR+SrE/G3cdDgdLAXH2839Fdq3ePR3bFvF0VJuH8HusHaLMk8qyy
         0nrOC1jRye21+cAviWqciBs5n7p+V4GI1OYAvwdiGkR+kuuN11ydWPy8dG8cqT3llsul
         ROIlFovksIC35d4V5JMzYAaSJthiPHKZdYTponkvwfFkEg6oOQ8w7/2zVkJT4W2LJrSH
         eHhw==
X-Gm-Message-State: APjAAAU7cZtqJQa9otisNS47Os00wgNabWy9NMTgAwUV+dRSDcvyjQBk
        hSB8EjtMVBkS1VARtQrVTlFzCTS/3q1nGs5os9nbveRIpYc=
X-Google-Smtp-Source: APXvYqySm+SMl3hxhYaPdt8DOJSiFTCNqjC3YNIoRH56NKhL+uziWGs6pj5hELlaefsipjQcZL5kpUZ6C8YprumGg/k=
X-Received: by 2002:a02:662f:: with SMTP id k47mr111211314jac.4.1564378185308;
 Sun, 28 Jul 2019 22:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190728235427.41425-1-carenas@gmail.com> <xmqqimrll9ow.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimrll9ow.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 28 Jul 2019 22:29:34 -0700
Message-ID: <CAPUEspiwTi2WfpTK_kxTEuKZrKJF2+_KZHsiaGmjctKR4BbtTw@mail.gmail.com>
Subject: Re: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 28, 2019 at 9:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I am not sure I like a config-only knob like this,
> though---shouldn't we have a command line knob to turn jit off
> first, and then for those who gets tired of having to type it all
> the time add the configuration to flip the default for them?

are you suggesting to add a --pcre-jit parameter to both grep and log?

guess using pcre.jit for the configuration makes sense as far as
it is documented on both man pages, or would this imply this should go
instead into core?

I was expecting this to be set system (or at least global) wide most
of the time like
(ex: core.ignorecase, credential.helper) neither of which I can relate
to a command line parameter.

> Other than that, the feature itself makes quite a lot of sense.

should I target maint/master?, next conflicts because of ab/no-kwset and it also
conflicts with other in fly features too (some not even in pu), which is why now
is based on pu and depends on ab/pcre-jit-fixes

Carlo
