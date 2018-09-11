Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FD01F404
	for <e@80x24.org>; Tue, 11 Sep 2018 21:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeILCWX (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 22:22:23 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38986 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbeILCWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 22:22:22 -0400
Received: by mail-qt0-f194.google.com with SMTP id o15-v6so29874419qtk.6
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 14:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75NqktisVELJH1FVykFWX+ek+ildj+W+XQLCVYQP8Y0=;
        b=sRFpAmi4Lgtypbk61dPv9zMwLxKGcXkZDyrmn0j4UAJFwrnIzCqSO4Os8IJjBDHm/8
         o2QUJ2sj/Od22GK7cKIth9djkTePDeoPuuIEDLGeoKke0ZsQNshh1vJ6NlF1qJVkO211
         uUrsYPN3JgysOPr/EJH7x99y+QlSz5T8Qa4RgZb184ozO3MRL0F6GaNZ4LrDaCF1HMKx
         1BF1RzDodZcRKnnL4o2JjwFLt+MTQCCg4D1iio50f5upZAYfoEX1Dp19+a6SVg/vCAkE
         W3rQSHXYkS3QfYsBvQvKqVWTrJtKWbFsYpYUE+NwruAjcK33acUWmbGjh07iuRxTSukT
         g2eg==
X-Gm-Message-State: APzg51C8nhuqp0tEQgvjjKAPgifsQonKUOi2qlv6r199Dij8WFogb2PC
        M7IACi0rJTK786n397v9J6P7DWEWuk8ptIyzJn0=
X-Google-Smtp-Source: ANB0VdZT+c1I9aWM0ltwDb/Tg9r+NckasgGzxTvkMvaoCEaGYzdwIaVJIU82Fk/AQBxBLNuDPfcFKCEqdfTiCIZUAXY=
X-Received: by 2002:aed:304b:: with SMTP id 69-v6mr20704382qte.220.1536700871800;
 Tue, 11 Sep 2018 14:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.37.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.37.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 Sep 2018 17:21:00 -0400
Message-ID: <CAPig+cT4HeX85SXZgyVQpAZarDFaafeBri7zLpExA=3O403qRw@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add coverage for 'git format-patch --range-diff'
 single-patch case
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 4:26 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In es/format-patch-rangediff, we added a '--range-diff' option to
> git-format-patch to automatically add a range-diff. We also added an option
> to write the diff as commentary to a single patch submission. However, this
> check was not tested.

It was an intentional (though unjustified) oversight. Thanks for
working on this.

> I discovered this test gap by running 'make coverage-test coverage-report'
> on 'next' and then comparing the uncovered lines with those in the diff
> between 'master' and 'next'. I have a script that automates this process,
> and I'm still working on polishing it.

Interesting. Does your script detect that the --creation-factor option
added by patch 13/14 [1] also lacks a test? (I'm not necessarily
suggesting adding a test at the moment. Even Dscho's git-range-diff
series doesn't have a test for "creation factor", so it wouldn't
necessarily make sense to add a test only for the git-format-patch
case. Instead, we'd want, at some point, to add tests covering both
git-range-diff and git-format-patch.)

[1]: https://public-inbox.org/git/20180722095717.17912-14-sunshine@sunshineco.com/
