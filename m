Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7AD20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 21:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeLLVh7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 16:37:59 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43630 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLLVh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 16:37:59 -0500
Received: by mail-ed1-f54.google.com with SMTP id f9so274822eds.10
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 13:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xhtxeis0M6SPDZIn6ikXWr+a1lqBPBL8/5cqSmf0EOY=;
        b=HyCi4dpJUjbUXRiL0+6HBv0qugYK7YTTUxoK/em2waep02bDid0TEmAk+iUBRWo0Wx
         qMawA99FguRDYlt7+h+PiNVGyPJ++Vq4zrmHQFc+ARnfGz8FQf2gwoGjVq5gaHxaMLyN
         07DYtDt9IhOZV/cnTTIJ70Fd0kmi7hWvNhz8vOc+b2wRthxBu8O2Xqgt/TDNEaYOSN65
         /BuDyMr2UfjuuS9aJwKDNqHhzEQmKFrbDpRFENUBimJRVWRgmU1ZGnU4WZth7DnPwQNi
         bYGUnlv9pdOTYXgzOW9oV+nAtijv8TW2f5+FBUgPUG6lo6lYs/0M/ELI7oX5IkbYzgpD
         nfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xhtxeis0M6SPDZIn6ikXWr+a1lqBPBL8/5cqSmf0EOY=;
        b=nXpi9seVfJ1hp9CCszKUAxKLi9nCAkOTMJwoopSAC3Zq2Ya4Z5Vqm9mrJfm1WTqLzX
         jx3ENT/oGAgTaD++ID4ygI4bWZm9/8afdqnsTwuS8O/jQr13ABHZSNxUvQ0tAHvgJW7C
         ULie1LhfqZBn5dk07ZPcIk9sPFVz3zVIvBar6gsB9jIPt/REXrt18D8HzG2jHTuZG/x4
         VDXkwsTgM62UIjjFJ3r0IhR7I87GN3Vn8bkyw5euYvdUgfD+cUXDh4oNW34Ohvw/qK6m
         y7uFejjQ1f3hqc4cFWXS7lFxUmYcSSCZmr0Goo2AKNiiWXLT2UC0a1zBwIqnVi8vyD2y
         LdKQ==
X-Gm-Message-State: AA+aEWaAfJBDykGjKl6wXt8OG8dpofw69Wd0MOgVnyfO627tw8BkZauL
        n/F+jE0oGIwfR8TbykITBzfTLoANumaRlwXWrcTlEdvneiq3aLfc
X-Google-Smtp-Source: AFSGD/UHvKya4P08wtgt5yNQ0FWI6hcVVg7YpTXwbh/coZZw1PGfNidLsb8K6hn8B3l1F4a54P4+2m+CVJ6932eb0kQ=
X-Received: by 2002:a50:c182:: with SMTP id m2mr20322887edf.139.1544650677038;
 Wed, 12 Dec 2018 13:37:57 -0800 (PST)
MIME-Version: 1.0
References: <9181bfae-8a36-2051-179f-438706ba7968@3ds.com>
In-Reply-To: <9181bfae-8a36-2051-179f-438706ba7968@3ds.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Wed, 12 Dec 2018 22:37:30 +0100
Message-ID: <CABUeae-a5jQSgLzEzuNzuJ-e2hycdFCe4LFjaGDg2FicsqbmHg@mail.gmail.com>
Subject: Re: How to perform efficient incremental update of a git repo from a
 large SVN repo? Bug or clueless user?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 Dec 2018 at 21:13, James Mason <James.Mason@3ds.com> wrote:
>
> I have a large and active SVN repository.  More than 36,000 revisions,
> thousands of branches - new ones created daily - and a non-standard
> layout.  Also, a secondary git repository that serves as a faithful
> "git" copy of the work accumulating in SVN (git version 2.9.5).  I seek
> an efficient way to routinely (nightly?) update the git repo with new
> changes accumulating in SVN.

SubGit [1]

I've been using it to translate SVN repository with ~40K revisions,
producing ~25GB Git bare repo.
SubGit is x10-x100... faster than `git svn`.

[1] https://subgit.com/

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
