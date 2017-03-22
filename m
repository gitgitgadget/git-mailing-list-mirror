Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F1520323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759821AbdCVToX (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:44:23 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36429 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759488AbdCVTn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:43:57 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so111609087pge.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BVMxi73PYzODuS8ilYGdNBz4T5j70uhHcZF7zxsYnh8=;
        b=gNnQttL8MskXAHIcEGRff53RT9tSt25xkztEk+reX+8cSVgMfkoKNaNUkgMyBXQtMq
         B6wBjMDDMMhuPI8w9q72dnpG08Rp0/K/NA4tZaS8SYhiAQJ4odLgom+X29TjK6o3Xx2Y
         KcQCybSVAj8wnoe2Ry+YHmb/5ROEvERFwyQ2Gk/YUfamxDWJJHQWyVt6oHbdM6nYdvqP
         Iup4JsVBYy+bJGNs2oVrG0CApFW3gqpQFWw++HdILUrtTGUHgEM+BLmxMcoKgS4N7zgB
         Ap4ZgWatMHKM1ZZTdxXTfPhXOZUq3z/ULLZBHXomT0XB30KOqZWUwIya9Of+0X5S4ECg
         zB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BVMxi73PYzODuS8ilYGdNBz4T5j70uhHcZF7zxsYnh8=;
        b=SpO8kxSY+B+513aqA06JVqU0uI+KGMf/DxoI1Tts55/n8O8ePwL3hy6mNC27ihWYQ+
         aWE5fzNJMMsUsy9+UZEnL2pTwz5EtulbA8xvdG0Cq3d8jIwadcG5uRIQ1XMqWCOYUHIs
         AmJpTFxh53WTqHvyKICer2aRooQqu6KQRCeAozXayTs5Rpmi4DpogGb2Lv1TUc1zhZsY
         EfgwAPIPM7yNiKhSmOu6sb1uDFVAShvQx9XBp0w+ZOwhW1bF/jUjRxpsqakYvGUSHip+
         HAUuLQ5DCV3IVcey3eqSKRGxx8H7goNK0o+gdtLu9PDs5bgcyUkrsXYtnufQfQTsyYgt
         HKOg==
X-Gm-Message-State: AFeK/H2INz3u4jQyyuqkZmP7swFuQNbYYHTRRWnwQH4JlRhexxfqGFdg3d9uVuW9BI0SFXIxbrra4UpyP7Z9sByG
X-Received: by 10.98.101.7 with SMTP id z7mr19704652pfb.81.1490211821931; Wed,
 22 Mar 2017 12:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 12:43:41 -0700 (PDT)
In-Reply-To: <20170322192340.elg2gpvcshhk3jq3@darkstar>
References: <20170322192340.elg2gpvcshhk3jq3@darkstar>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 12:43:41 -0700
Message-ID: <CAGZ79kZ+BGG6yj_rEvjDNf3gmV5KPgvOvLfH94VdPudzbGCkyA@mail.gmail.com>
Subject: Re: Question: xdiff and "pretty" (human readable) diff output
To:     matthew@giassa.net
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 12:23 PM,  <matthew@giassa.net> wrote:
> Good day,
>
> I have a question with respect to how git generates "pretty" (ie: human
> readable) unified diffs. It's to my understanding that git uses its own
> (simplified/minimized) fork of libxdiff, simply referred to as "xdiff"
> [1].

correct.

> Which tool/library is used to take the xdiff output and generate
> the human-readable equivalent that is rendered to the console?

Git itself. Have a look at diff.c (it's only 5k lines of code ;)

Maybe start with fn_out_consume which is a callback (for xdiff)
that is responsible for pretty printing the output, i.e. transforming the
output of xdiff according to Gits configuration.

> I have a
> program that I'm maintaining that currently tracks changes to a couple
> of "sandboxed" files, and I wanted to add a simple console UI that
> periodically shows the changes to the files over time and/or dumps the
> "pretty diff" to syslog.

> over time

So you could use cron for that?

>  "pretty diff" to syslog.

So you want to modify the "pretty diff"?
Maybe that can be archived by a custom format
(see the git *log* man page) and doesn't require hacking.

Thanks,
Stefan
