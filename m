Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228591F404
	for <e@80x24.org>; Wed, 11 Apr 2018 00:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDKAoX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 20:44:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54740 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeDKAoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 20:44:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id r191so681993wmg.4
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 17:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BQon8FA6ugF9v4Z0YoeUHZcNoE95AkQ11jfo+OWvEFc=;
        b=s1qRO1X1Yoysda3LRh52ae+o9aNm+n0D18jB4CQUByw4NvT2N3houuyKMiySDJg7ov
         Dz4D0DKk8dzLq/xhnySl45HDoBtkNeJUh4b7AoTONVFK/+4pQKTyk21G8owXM6pkMfkc
         zaBgwPo0GWrKosukEnHNOpoW7kSjSXkkjHgFeZzt+PKdBixhjo8eGYPGTEycTbrdPAVm
         /31zSDtwgvuNggjYRyl/2e9HT9vfDWcaV2KZcw3UF9CyMT8NiERIohd+q5BjCL2f1Jb0
         f1UyojMcwGYFyHVpbQRpl1lqzu09hEvqUazsuDGqF4lAAH/wAFiQhT+/28hSFpG+QZua
         gTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BQon8FA6ugF9v4Z0YoeUHZcNoE95AkQ11jfo+OWvEFc=;
        b=IuOYyFiny1xoGCNuOxZe/4bL9IayD0EV1FL7Qhqn4l0aewno/XVllqUg7iQW9N+Lm7
         kcASJqV3Kn1RwFjmwfcxOlocUnF8dnqiiSOzLkEBWGAW5Cp4nZhr24xpWtu0ZwnvbazA
         6py50fWUHVOez+OjMn5xW1eCISuxutoSdeoYeuCe/GOU1noBga7om7zx/Zn6sGeglLj8
         8UtPRizGoq0cj3JIiwhzeDh376NkWd3lkon4Ih0JXt786lVXS3IoftE+KgBvfCI7/sEj
         +X1xEEYY+OFsHLOj08RFCYSvC8dg9ihD1cFuvRoVmvmI4dPDIC6RaUsTKRtzsVHj9jPp
         obdg==
X-Gm-Message-State: ALQs6tBThai7TtJN4Gjmd5EILNZrFojZaR1rKO5HEwpTe82E+N1nI/uS
        FhTmLUxgA92fjB/IRMI7tcA=
X-Google-Smtp-Source: AIpwx495+msB0oLNHF7d7fD4cLfDZsYR9H5xjLCDEJ8K77y72yBHUxeCpEldBgNWjkf6oIrE95u6+A==
X-Received: by 10.28.236.76 with SMTP id k73mr915965wmh.122.1523407460860;
        Tue, 10 Apr 2018 17:44:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 71sm141508wmg.11.2018.04.10.17.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 17:44:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Chris Maes <chris.maes@macq.eu>, philipp@gortan.org,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        philipoakley@iee.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git-gui ignores core.hooksPath
References: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
        <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu>
        <xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com>
        <87muyabpuz.fsf@evledraar.gmail.com>
Date:   Wed, 11 Apr 2018 09:44:19 +0900
In-Reply-To: <87muyabpuz.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 11 Apr 2018 01:31:32 +0200")
Message-ID: <xmqqy3huzi58.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Isn't everyone involved much better solved if we come up with some plan
> to split these off from git.git? I.e. I think if if git-gui, gitk and
> gitweb were proposed for inclusion in-tree today I don't think we'd
> bite, and instead point to things like [1] or [2].

It is actually the other way around.  gitk and git-gui had active
maintainers and they (not Linus nor I) wanted to have their own
release schedule and versioning; they started as eparate projects.

The arrangement was pleasant to work with while the subsystem was
actively managed.  People can send patches to it just like to other
parts of the system (and the change rarely if ever needs to touch
both core and GUI at the same time---otherwise it would be
impractical to split them out as a separate projects), reviewers
would give comments on the list, and subsystem maintainers would
pick them up just like I pick up patches to the core part.  Then
from time to time, subsystem maintainers would give me a pull
request to complete the cycle.  I do "pull -Xsubtree=git-gui/".

It breaks down when subsystem maintainers go quiet.  Even if I were
to play a patch monkey backed by volunteer reviewers, I'd still have
to pretend that these are separate projects that are occasionally
subtree merged, with my own pull requests to subsystem repositories
that may never be responded, just in case the separate subsystem
projects will become active again.

If you split git-gui off, it would just die, unless somebody steps
up and takes it over.  And if somebody steps up and takes it over,
we can keep merging from their repositories without any problem.
