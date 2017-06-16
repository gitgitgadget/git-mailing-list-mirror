Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6988E20401
	for <e@80x24.org>; Fri, 16 Jun 2017 00:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdFPAKf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 20:10:35 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35836 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdFPAKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 20:10:34 -0400
Received: by mail-io0-f181.google.com with SMTP id k93so21152407ioi.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 17:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VZZFtGfHpoNbl8NXDUIzBWNNKheLus5gqYWqqCra+mg=;
        b=fWrSOG+kIMOz8+iAlI2tkiGOfqC8VhPw5gHIBqoGb7yuCSPpmB+1IVtk0ps0w8NABo
         Y0+1415KXJVEQV2gumXB/bnFnx6TGlpC9j0kB/l4z6OI5oNju0NCdUxS55wt0UtGb/wS
         faVq9hTLVKStSsS5fEN/fhdpNo42ncVwmDAAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VZZFtGfHpoNbl8NXDUIzBWNNKheLus5gqYWqqCra+mg=;
        b=NxX9nXTrSKkkvRNiGe7h7erj3pzYoNgBbTbmiEg0AHZl2d2A9mj7vbQvhc+2o+9XEU
         l69mzhED1dUlz1+DU0zgP5/8VMiU+gu/+7pfT2ZT3Z/jvsdrdalM33cM//7L92/CXoNR
         3FsArSHsAx5ND+zvFwKI+Bdbmh3yEReJm8vrCYMdkmN0P1a0wE28NCb9DisS/2Fq+UZ4
         yn8cKD87zlL17Cf7rNNrIvr7MZzCWWnma/NKL3NgZKFn06Hj+KkJMynri/xwQBMLeke4
         8cNtQfple5cx1aqzjiUGdm+sk02ldgWP4QTeW+E2CHy3hUDu7yyYZDVuIQO8UUSPNKam
         NQKA==
X-Gm-Message-State: AKS2vOwSccdBnK0d2BLY5xMeDJHkjSXDWxG1FQFP9n32LDcYG3xoXCRH
        8mkGosUDAx2ps2cqifkoliZPYjDqdR0o
X-Received: by 10.107.169.220 with SMTP id f89mr8693983ioj.97.1497571833637;
 Thu, 15 Jun 2017 17:10:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.101.131 with HTTP; Thu, 15 Jun 2017 17:10:13 -0700 (PDT)
In-Reply-To: <CAJZjrdW=1MbT=Lmouswez3W4hGP=anuMqMnQPkLta_fhUU4hCg@mail.gmail.com>
References: <CACcTrKfPKdPCVONMcGRbisK_WOt70yLdjavZnLTMMVocrwzk1w@mail.gmail.com>
 <CAJZjrdW=1MbT=Lmouswez3W4hGP=anuMqMnQPkLta_fhUU4hCg@mail.gmail.com>
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Thu, 15 Jun 2017 19:10:13 -0500
Message-ID: <CACcTrKdatvtqoMDiR5DR6cP_0gsqZnQDGbpq6vj6MU-+ABWF_w@mail.gmail.com>
Subject: Re: [suggestion] Include commit-ish in git status output
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 6:55 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>
> Can you elaborate on why you consider this useful specifically?

Personally, primary usages of the current commit-ish info are to file bug
reports that include the specific git revision of any given branch that a bug
was observed in/on and to quickly note the currently checked-out revision prior
to pulling the latest changes from an upstream server so that I can rollback
without needing to tag/branch if needed.

But that's not really the reason why I emailed in with this suggestion. I think
semantically the "status" of a working folder is perhaps best summed up as the
sha1 of the commit (or its commit-ish, for short) plus the currently
staged/unstaged changes to the checked out copy of that revision to indicate
the _current_ status (there's that word again!) of the current git directory,
combined with branch information to indicate where any staged changes would be
committed to.

Currently, git shows two-thirds of the information needed to actually describe
the actual working state (status) of a git directory (being the branch and
staged/unchanged changes to HEAD), but does not describe what HEAD is in a
stateless manner.

>
> Do you think adding a $(git rev-parse HEAD) to your PS1 would do the trick?

This is a bit more subjective, but my personal preference is to keep a minimal
shell that retains its behavior regardless of whether I'm cd'd into a git repo
or if I'm transcoding my music collection.

I have no problem needing to execute something to view the commit-ish when it
is desired; this suggestion is merely focusing on what the something should be.
I have no problem using `git rev-parse` for other tasks, but feel that needing
a combination of `git status` and `git rev-parse HEAD` to accurately get a
summary of the current state of a repo is perhaps much.


Thanks.
