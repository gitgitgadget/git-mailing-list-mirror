Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C049A1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 17:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfH2REl (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 13:04:41 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:38504 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfH2REl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 13:04:41 -0400
Received: by mail-vs1-f52.google.com with SMTP id 62so2904156vsl.5
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6Esv0kcaoCUMgqbtv7WD2TJm4Tgm7Q4gTfw0QpaxE4=;
        b=gEaY8UQX1GX/X08ENTyJhIubsFoXuv2Lzh6W2EunZ4MY2x2n5nhR/ERU7bwSi4HHFD
         X9xn4D4hPJZf8QC3PKSLdTWg3Gr9IUVnAVcAia/g9X3x0N30nhjaTnc7XQRy2Bp7ZFYN
         kdAXD0Vs5CvNfdfw5iofjKW+T+dKCDCWFPyyCmKuFzM+e+KiNrUbJQfRPc5ScuvxwiIz
         oMHgs5rJBY0g4JbW7jJT5/RTQUjFTNS1X2tIY3bFl4YVjK1ScrH4+MH3eh5zwdbuu39K
         swizOU2IfrAz8P5tw6m9/8/RyFIjDO5T3PQt4MvXR6ugRpwBvi40vcD/lvQQQWB9oW2+
         2dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6Esv0kcaoCUMgqbtv7WD2TJm4Tgm7Q4gTfw0QpaxE4=;
        b=hQAMg5CmSizW3L7vY3+ka0IYVyueGWNtpIRMPFO0YjGtXQGN2OWllw/mCbKY9W8BZO
         3wNsxVSXUtivzru7/SEslf/2I/Nsl39EwcoACLCG9msUYIs1P3j938VHsv0qY7T+ZIRG
         ZXN3CT06vyveGaVMIKkp5WncuVmfhVLybTdc1vVMwcje0r7SZ5JT2u2zl8BUoZqBYU/v
         MyeK0/wIbUWnFVeGE+rrDCYZykzyWL5ydPwEhgn8KgnWCAEnyjSYwTt0jrap+j5JdXI8
         CxfV6AT126AjNb/Q5zOIPLeJlG/vvcLNRMEktZGcmbnuVLBFleMP3lkKMvqzbdOP2lsJ
         PuOw==
X-Gm-Message-State: APjAAAUrtdd0So4cmBWu3Awu+8lF3R9fgtbTfY/iTgvKvHfjemqVmTe4
        0t9k7vx+NN1Y6zbz5MiTrGdfQFcqtOe8wuga1Zw=
X-Google-Smtp-Source: APXvYqy49/xJPCzvYOKQ080EDLd7X7jTjT0H6ly9OWZSpmUV1jf8x5qe/VlVT1q+5U5WkTzUL6CRIBIcGnLqeBuYX5k=
X-Received: by 2002:a67:6244:: with SMTP id w65mr6174874vsb.117.1567098280378;
 Thu, 29 Aug 2019 10:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEV-cEryZZarfz5SQsRphBXeYMPJW7tdSfY8NYnzb_-ra-pGHw@mail.gmail.com>
In-Reply-To: <CAEV-cEryZZarfz5SQsRphBXeYMPJW7tdSfY8NYnzb_-ra-pGHw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Aug 2019 10:04:29 -0700
Message-ID: <CABPp-BE0ij8zF22xbvjbcq3vG-VwWjUmjNo45Lsm0BEnH=iZ-A@mail.gmail.com>
Subject: Re: How to track history of personal changes in a repository?
To:     Matthew McClure <matt@continuousdelta.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 7:34 AM Matthew McClure
<matt@continuousdelta.com> wrote:
>
> Hi,
>
> I'm looking for a way to track history of personal changes in a repository. I'd
> like to protect against accidentally pushing the changes to a remote branch. I
> imagine this working a little like `git ignore`, and a little like a separate
> branch. It might be like a personal sub-branch that is ignored by `git
> push`. Or it might be like a history of the work tree that runs parallel to the
> reflog and to the history of any given branch.
>
> Does something like this exist in Git or a complementary tool?
>
> I found `git update-index --skip-worktree`. I imagine it might be relevant in
> some kind of workflow where I can maintain a personal-worktree branch.
>
> Does any of you have a personal workflow that addresses similar concerns?

Perhaps put all the changes in a specific branch and run:
  git config branch.${personalBranchName}.pushRemote
Do.Not.Push.Changes.From.This.Branch
?  (And make sure that push.default is not set to 'matching'.)
