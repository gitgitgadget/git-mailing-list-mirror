Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BE31F404
	for <e@80x24.org>; Thu, 29 Mar 2018 17:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbeC2RCx (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 13:02:53 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35806 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2RCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 13:02:52 -0400
Received: by mail-oi0-f41.google.com with SMTP id z8-v6so5767992oix.2
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KpIB1yujpAFEWdBA8USEr3lDJIGHhqEQxiOCTcoGc78=;
        b=R17KGScBpvCrWcGmTIeZvr5cHEhHoIdZjv+Cqjx4d+zZErcFc+7Sgl7RQIk33J9yJ1
         ZA91kIC/z6O70F4e9Aj6mI1XKeyRqsQUtOj3qcptOtKTWS14BBNgKMb2Fb5B11rhqk+z
         9xPZb2XzLbGCkkSY3lsEzqRKiPXOQXI9aTsnGark+eM+njlb0nDoUET8FIqDBn71d/Qs
         HwUdP1YyrvGdVfl0UI5UP4xZGKe5unl3F+AHAUjiODfrAhVhGHzG4VhhgIEf9ogv047K
         1De0IOJTj9oKLahRdQeq4AvWHZRI2usSoQYtMXsn94ALvLzZ+jcUG8cLQMYjadoAg54e
         v+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KpIB1yujpAFEWdBA8USEr3lDJIGHhqEQxiOCTcoGc78=;
        b=tEEZlu21PHtZjJbW9CDgtrLGjTLIka0unfcTtnSihdWc554gWUe1vHZC8ngQpaSh5Y
         U7VN5czd0KgAqDxOtD/VOB9Ow8Sk5Q8M75qYdYs4iK/5q9QrwLG4OQPwS2sERjFcyJwJ
         zIcCnyVOIoLmw1w1ySlGaT9OHZZg90zUon6683Fim1jmI6zPyEBLK2Twwa/q5Icotpli
         I1gLnjg34SXuMDd+qdAIJ9XKXScOYTR6QGH6kQpSKh1dnrjJy7oKJE8GxV0QyKGn9tUp
         wcBRFzXJo8iJUDqC6QsQ6GLIg/BBeu4lqB1qNbYKY/00oFw9OQEYajQCkVNcL2aGghLT
         ZZ2w==
X-Gm-Message-State: AElRT7EMUVz67ywOAV7Ctxb4SQcaAhjcIy3nz7Du9v/BLVR+shWIQ+24
        rjm/M+5aQKrqJE7NHFJJCIJEDaC5HBKFG5jSJus=
X-Google-Smtp-Source: AIpwx488BdLlyWqLnDvZcCLVM7bPJuekfMdzFGlqpdx1mIcPi5XwMspCL1zHnbZ5Vac7OIGAgAT+oaG/i5pYIakvU7g=
X-Received: by 10.202.243.84 with SMTP id r81mr5102831oih.281.1522342971877;
 Thu, 29 Mar 2018 10:02:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Thu, 29 Mar 2018 10:02:21 -0700 (PDT)
In-Reply-To: <20180328174215.GC16274@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net> <20180328174215.GC16274@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Mar 2018 19:02:21 +0200
Message-ID: <CACsJy8CAjb4zdAgD5H9OZOAoHdrRFzGm9gaL8Wbna+GXJJCW4Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] set_work_tree: use chdir_notify
To:     Jeff King <peff@peff.net>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 7:42 PM, Jeff King <peff@peff.net> wrote:
> When we change to the top of the working tree, we manually
> re-adjust $GIT_DIR and call set_git_dir() again, in order to
> update any relative git-dir we'd compute earlier.

Another way to approach this problem is not delaying chdir() at all.
We have to delay calling setup_work_tree() and not do it in
setup_git_directory() because it can die() when chdir() fails. But in
many cases, the command does not actually need the worktree and does
not deserve to die. But what if we make setup_work_tree be gentle?

If it successfully chdir() at the end of setup_git_directory() (and
perhaps before the first set_git_dir call), great! The problem we're
dealing here vanishes. If it fails, don't die, just set a flag. Later
on when a command requests a worktree, we can check this flag and now
can die().

It's less code this way, but it uses up more of your (or my) time
because even though the first set_git_dir() call actually happens at 8
places. Is it worth trying ?
-- 
Duy
