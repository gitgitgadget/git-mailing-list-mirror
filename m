Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701A120248
	for <e@80x24.org>; Wed, 27 Mar 2019 06:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfC0GhE (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 02:37:04 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40613 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfC0GhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 02:37:03 -0400
Received: by mail-it1-f195.google.com with SMTP id y63so12673014itb.5
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/H084qsfQ5vGM3t220f2HCOfOotIAytRSfltsNCwaw=;
        b=Fj/XPaWCjIxaobD6JbX3/WTFcZdRzso4MwQtyQcpCI4sv+stAwmrLeMdzVJtJQ7j7e
         zka1vMihHzLwvaGBSYsWNRJluQLh7QzPMmALhu0RuDADnVhUnaDqV02tPGflcu6d4ewW
         z+YKnIwh2elqqpGqfyh5dUdWgF+nPIb60YdswRXTLfORg1Ko9QI7qkPjpvd9eFto+RLt
         CD2t2RbL/dF+5A4FL35UlA3s84Oslknz+DZ3akZGTtPjsw4QzNXd+xYXRGank6t4rbZv
         6uyXBuBOnqQiJS2OiSZ6GDyWUFLDxPliXcWF8klW6SIJhZr+9oXnPWO5YtEalsqZYxw2
         LlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/H084qsfQ5vGM3t220f2HCOfOotIAytRSfltsNCwaw=;
        b=jrXXgjcQTDNrKAQTURxFwiPbHBhrxgfGaFx3967gih8Ap19hZOCYLNTjuwOINEeojP
         4hjOQJ241MqumTnGdyaBcQ9vcCkIKfxM4rI4LYvxnEjVfFltEIeoOs6xuIWjw+00phZ5
         Kkjg250MFXo4uekiNjx9Xz5jAY/emrvAWLKuWcJ3Pnmft94t45PvdPslFDQSz7ju6b+0
         ekVw5Q6cUcgrYr+82O10XSEStgMXwzq7T0b8pdYhh6jQYRMugN/OFyvf+54GAyYyXjeh
         AJMw91VtLfb9ih+3eSbS0EDc0BjQVQk+CCsjzCDLf1x0GXuJeb11AhEIE/YbTasDx3jP
         fY3A==
X-Gm-Message-State: APjAAAU5q5LLNkhoZxMfQcI5l9PDeW0oxvoZMl0DehWEof/Py5kFmhdF
        6TyuVn/xYTQvX0N8dYSvhWEa+p1IUCN2SOSlqmc=
X-Google-Smtp-Source: APXvYqxHR9n9uyQE2LBCPZpxZuCCgtMEtDW/9VI5IuNxaORd2VDY/m3vOK8gqW0YQqqt8ei73gfuche2rVWOrhAvT/s=
X-Received: by 2002:a24:7542:: with SMTP id y63mr2263887itc.70.1553668623063;
 Tue, 26 Mar 2019 23:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190324235020.49706-1-michael@platin.gs> <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
 <b077afed-d143-506e-977e-6edf2492f75f@google.com> <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
 <20190325233516.GB23728@sigill.intra.peff.net> <CA+P7+xo-AHmB+Wv0Z+dpgshhmqSLEb41T-JP+NKJD8DAFARA5w@mail.gmail.com>
 <CAJDYR9RVz6ZKQ-vdC8O3LYZnGeBcGHCRtL0m6UoRrKDBsUoFOw@mail.gmail.com>
In-Reply-To: <CAJDYR9RVz6ZKQ-vdC8O3LYZnGeBcGHCRtL0m6UoRrKDBsUoFOw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Mar 2019 13:36:36 +0700
Message-ID: <CACsJy8D8yBK9p9Rgy+wk8cMfPLG7qanvGA-LcmmHmjbaMnvBLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Michael Platings <michael@platin.gs>
Cc:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
        Barret Rhoden <brho@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 3:27 AM Michael Platings <michael@platin.gs> wrote:
> I think it's really important that we make this dead easy for everyone
> to use. The ultimate in ease of use would be for git blame to
> automatically pick up ignore settings without the user having to even
> know that it's happening. But that breaks the principle of least
> astonishment. The next simplest thing I can think of is to add a
> configuration option blame.ignoreRevs which would have the same
> effect, except the user has to opt in.
> Barret has implemented blame.ignoreRevsFile, but I think the world
> will be a more consistent and happier place if we dictate the location
> that the revisions are loaded from, in the same way as .gitignore.
> Deciding what that location should be is one of those bikeshed
> arguments which is perhaps why Barret dodged it :)

And bikeshedding. Another good place to keep these revs is git-notes,
which probably could result in faster lookups too and can be made
visible in git-log. But that's in addition to --ignoreRevsFile, not
replacing it.
-- 
Duy
