Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097611F406
	for <e@80x24.org>; Sat, 13 Jan 2018 04:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965436AbeAMEzA (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 23:55:00 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:42077 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965422AbeAMEzA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 23:55:00 -0500
Received: by mail-oi0-f48.google.com with SMTP id o64so5267726oia.9
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 20:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G9Z6cPOAFEy6MS/D0FHSLrQPMKa6PkM55QTZ6yi+2S4=;
        b=dZ14DZk0ZsxranmjOuVBs5dbk8Y7p3068JTO3tk901CS/izR5pYXSvICcNve0loX6J
         NRQfOtWqoP1uSA/SlbIEoN6Hth/5tRZPHGN+266eB3EAYt/dSs1NwqQaQRmEpj10ZT4B
         oebXqzqjJzzBLqwddq2Cc6L7QyIch6xk3iiTejBBfj8TbiG/eXoAhDbf2w3qQPsS7srl
         rfOfTgwlVtY+JgDvBSUZ2AyjMJqrdsKuct4zdIovKlf/2kA57TQlBFoGJIaalRhFoqmm
         g7+X8IHX710cZwgWpn6NkFjlhRAQ72/mfH2oNdczgamTGJlxOmxM3/12HfUGea7BCzCM
         QhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G9Z6cPOAFEy6MS/D0FHSLrQPMKa6PkM55QTZ6yi+2S4=;
        b=Nc8mLEAdkMZSKfzXSRi5BPG26MZ4m4zz58B5Zu0JONRsmopPRQdsQIlYynvpq0NB1d
         76NrL/SB024fmMAhgBH7QowF4r/qlR0pPh+eBOcE80Mgl9LIfhwre/zd1lDcEQCgXq2C
         TFvNjpmS6M4itbfMu3/Xgfd252TeXIfsqk1xM0KaQryELxXHO/IGXJ9HhuDu3J/B3Pmu
         C4op9ESoo+kD3HQUEygTHBCgqw58WcI/le+wsyeK+Fzacn4NU9ZUpU+hZJ+j7MPtzvG1
         WNrRIlfQtr3UuckqvqA094bWd017ogxh0m04zrklWRlu6ekTJv2a1fH5zhSoLQPwi+14
         vb/Q==
X-Gm-Message-State: AKwxytddalK4ikBLcnM/sJz3eoPN2KYJg+wwB0Gn1krzPuGdyQ7zjgZV
        iSkYmcYN8hz+NOlWn1blevHYzIGKSDcuhu/edRk=
X-Google-Smtp-Source: ACJfBot2Fz+cRlTYb/7lebSrPDC/ZtWx/8zrocu48HgbgwZ07aQmh9JqKI2+l0MrQ2MUKv4ThYJmVftgruDwLXY4YoM=
X-Received: by 10.202.102.156 with SMTP id m28mr4188169oik.252.1515819299449;
 Fri, 12 Jan 2018 20:54:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Fri, 12 Jan 2018 20:54:26 -0800 (PST)
In-Reply-To: <xmqq7esmwuwn.fsf@gitster.mtv.corp.google.com>
References: <20180111094712.2551-1-pclouds@gmail.com> <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-5-pclouds@gmail.com> <20180112133355.GE27499@sigill.intra.peff.net>
 <xmqq7esmwuwn.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 13 Jan 2018 11:54:26 +0700
Message-ID: <CACsJy8CeYY34G=JjwHWqM+QbBG41pkW7VP+Aowak26rdM1qpPg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in trace_run_command()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 5:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I also think this is a special case of a more general problem. FOO could
>> appear any number of times in the "env" array, as a deletion or with
>> multiple values. Our prep_childenv() would treat that as "last one
>> wins", I think. Could we just do the same here?
>
> Perhaps this should be squashed into the original 4/4 instead of
> being a separate patch.  We'd probably want some sort of test, I
> wonder?  Not tested at all beyond compiling...
>
> -- >8 --
> Subject: [PATCH 7/4] run-command.c: don't be too cute in concatenate_env()
>
> Instead of relying on "sort" being stable to sort "unset VAR"
> immediately before "VAR=VAL" to remove the former, just pick the
> last manipulation for each VAR from the list of environment tweaks
> and show them in the output.

This is not enough. Imagine we have GIT_DIR=foo in parent env, then a
sequence of "GIT_DIR", "GIT_DIR=foo" in deltaenv. Because we process
set/unset in two separate loops, the "last one wins" rule does not see
that "GIT_DIR=foo" wins over "unset GIT_DIR;". So we might print
"unset GIT_DIR; GIT_DIR=foo", which is fine even if it's redundant.
Except that we don't print that.

The problem comes from comparing with parent env. The new var has the
same value as parent env so we won't print "GIT_DIR=foo", just "unset
GIT_DIR;". This is wrong.

I'm tempted to just get the final child env from prep_childenv() then
compare with parent env and print the differences. It will not work
with Windows though, so Windows gets the old trace line without env
delta. I hope some Windows contributor will jump in at some point if
they want env tracing works for them too.
-- 
Duy
