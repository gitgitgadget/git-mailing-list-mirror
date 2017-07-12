Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62C120357
	for <e@80x24.org>; Wed, 12 Jul 2017 21:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbdGLVzp (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:55:45 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33437 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754446AbdGLVzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:55:43 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so19329130pgr.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c3ihHNT1/Enj5GqfRchm//twIG/D3Y2DLrRqji95+I4=;
        b=OnEB+c6qBnLZILDYkcBa1PKBTDIU6jH6eZ7H5sVsRjOUFARRh9Yo47kl42ugO63DSV
         fsTixeO8U67B7Eb5mn8foxwT5eZK6nuwn3NJeBSqhcZU+sq3sINhh0m8JfOTu0vEXkMG
         TvxZb0FgQ9rNw+rs2BIKtpHTeYVnRZ+RTzwqO/Mvq1OGMGi0TjktZ9909zw7vROyiwDd
         JSIE9I96q7dzkrqDzXbJv+yQqqGGBcvGcUZG1NdV0WZUq68R8PWSZv+Rj4BCn2Rf3lMv
         tDiobCkE/WApJsEx8lPZRTpW3Z1TcCICZJo9O2Zdx8ywL2/YXHvaySO8PbhbVDPNXfun
         u2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c3ihHNT1/Enj5GqfRchm//twIG/D3Y2DLrRqji95+I4=;
        b=kMT+1z9EIdRssvBxnUBtBxmPgu9zjDiX18O/geFmJDmoyQyCswhUdBSJ5kxrzs45vD
         m7hOvBsphQP5sfm4e3BfvTJ+ngP6/p5S6BDJD7jHnF5b8HXcYaBycDEpx1V7RDtGUB/o
         NqsSaCVeELurQ1X2z+JrRIdg20jtKiE+o041nwnrG0d5IW9Vjhlp6QCU4NLVL4ozH28G
         gr8hn4Y7nJ268myflzlChLHTR+KrJi1Nrde9jLR1NcFVw7p2EJraFmJV4wCxhfuZNTBz
         TmlRex6alY2khtsyx9xCS0rUWLs8CEWA79Yr1I/bEZtG+oqsETZLf0aUp3iX2zAtj3LQ
         WW9Q==
X-Gm-Message-State: AIVw111cVokbrSebM1kmlBEZsEVRvkgNR8n34H1e/naEDl/DCMEgdFAA
        s4Kpd+TAOftpWsMWLCrzTu3JiUZmG65SUJqJdw==
X-Received: by 10.84.129.69 with SMTP id 63mr6601787plb.0.1499896542709; Wed,
 12 Jul 2017 14:55:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 12 Jul 2017 14:55:42 -0700 (PDT)
In-Reply-To: <xmqqzic9z69i.fsf@gitster.mtv.corp.google.com>
References: <20170711233827.23486-1-sbeller@google.com> <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYftkxbDY2E_=2w0VYx8COF_yc61h78gs2qaraK9HRSuA@mail.gmail.com> <xmqqzic9z69i.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Jul 2017 14:55:42 -0700
Message-ID: <CAGZ79kZuMirZVrWTQ5eU7izYWyM8YtvDzMh4gRzvGXXVp=NMkQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> 2. collaboration.
>>     When I want to review a patch from the mailing list,
>>     I could (a) download the patch, apply locally, see the diff
>>     formatted nicely according to diff.orderFile.
>
> If you are not doing a review of a patch with complex changes that
> benefits by a local diff.orderfile (i.e. only in the mail client
> without applying and viewing the changes in wider context), then you
> either (1) have a much greater memory than I do and know all the
> code outside the patch context by heart, or (2) not reviewing them
> properly in context.
>
> I tend to suspect that it is the latter case, so that argument does
> not sound convincing at least to me.

Note that this request originated from
https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/

There are different sorts of patches to review:
(a) major new features, introducing radically new concepts.
    Example given above.

    In this case I neither need (1) nor (2). I want to get the abstract
    design and then decide if it is worth my time to pursue reviewing the
    details of the patch.

    The order file makes an impact!

(b) minor new features (in the big picture of a major feature), refactorings
    Examples: 96dc883b3c, repository: enable initialization of submodules
    lb/status-stash-count

    Reviewing these patches requires more diving into code, but you'd
    still want to make a call early on whether to reject the design
    before calling out the memory leak that you found after applying
    the patch.

    The order file *may* be useful.

(c) updating existing things
    (bug fixes, documentation, improving performance)
    Example: jk/reflog-walk-maint

    When looking at these changes, (2) is the answer.
    I look at surrounding code (there may be no need to apply
    the patch though, it depends)

    The order file is useless, IMHO, but also does not produce harm.

> No, I do not apply all patches before commenting from my mailbox; a
> one or two-pager patch can often be viewed and judged without much
> surrounding context, and can be answered in the mail client, perhaps
> while running "less" on some related files that may or may not be
> touched by the patch in another terminal, without applying the
> patch.  But such a one or two-pager patch can be viewed in any
> presentation order and do not behefit much fro diff.orderfile
> anyway.

This sounds like (c), which we have a lot more of than (a) or (b).

Thanks for your thoughts,
Stefan
