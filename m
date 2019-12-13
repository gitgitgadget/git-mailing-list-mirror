Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7F4C7CFD8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A1247E5
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfLMRpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:45:00 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:39042 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfLMRpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:45:00 -0500
Received: by mail-il1-f172.google.com with SMTP id n1so93654ilm.6
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 09:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vB/0K0CtlrHWtCB2XZoQklTVzCu/2cm5LTjlM3EeGg=;
        b=k8gnfhoXzryMzsXmxhfWFyZMrus86riEKWGb8M9oZG9n79LmeX0Z5YNuHnNzs0j+bg
         mYMC1+zqTPiQVprA7wu0EH74F37ftdDluqmJA+47Samp5e/ukI+ROKA2NcCiknucpTDS
         /FTN1hB5WtTHcTzfK5wYRgeI03gtCbH7jE+NOCuuDNf7km3epG15D4kgCp2WWNz+TK6o
         pWOqzdClSRcB/gVvEDpH+J4j572/JcIkga0URdA/svgQahS/YQemWUAqqsIeIk3p33mG
         yny7jMn7en0r4RYeEaJrgT/0QxnUYKOLJTkkDYEJAYXB/7+cYsbRygSZNezqpB9oFhHK
         1nkA==
X-Gm-Message-State: APjAAAW+RThODWeiIQX7zUH/wGrhoPlHSAx5rt/ydPnR3HukSfp7KES3
        VGhwV8swbLA3PjLgcfqCnNHTKAWM9UVkoftaIc0o6Jt2
X-Google-Smtp-Source: APXvYqyRq6ov/b4zEpUBGodOfq+s+/+g6eqRsYOkASwDQsNDZ1qQPNNP+4GDzIIpl8yAHdJbvW1jv2Lpw4f/fRUIWTQ=
X-Received: by 2002:a92:bf08:: with SMTP id z8mr444173ilh.11.1576259099594;
 Fri, 13 Dec 2019 09:44:59 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com> <CAPyFy2At-OjdKusxr9FaZmncjrBKWrVjs5REV0PeHtQFcYy8Ew@mail.gmail.com>
In-Reply-To: <CAPyFy2At-OjdKusxr9FaZmncjrBKWrVjs5REV0PeHtQFcYy8Ew@mail.gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 13 Dec 2019 08:58:34 -0500
Message-ID: <CAPyFy2BuWJJzC7F=H2KGgwANYdMNjisJ0ozK6VNqXui3=-=bBw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Dec 2019 at 08:38, Ed Maste <emaste@freebsd.org> wrote:
>
> On Mon, 2 Dec 2019 at 09:16, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > * ln/userdiff-elixir (2019-11-10) 1 commit
> >   (merged to 'next' on 2019-11-19 at 6318918ba8)
> >  + userdiff: add Elixir to supported userdiff languages
>
> t4018-diff-funcname.sh is failing on FreeBSD with this change,
> fatal: invalid regular expression:
> |[@:]?[a-zA-Z0-9@_?!]+|[-+]?0[xob][0-9a-fA-F]+|[-+]?[0-9][0-9_.]*([eE][-+]?[0-9_]+)?|:?(\+\+|--|\.\.|~~~|<>|\^\^\^|<?\|>|<<<?|>?>>|<<?~|~>?>|<~>|<=|>=|===?|!==?|=~|&&&?|\|\|\|?|=>|<-|\\\\|->)|:?%[A-Za-z0-9_.]\{\}?|[^[:space:]]|[<C0>-<FF>][<80>-<BF>]+

There was an empty subexpression in the first regex; just sent a patch
to fix it.

(It'd be great if we can merge .cirrus.yml and enable FreeBSD CI for 2.25.)
