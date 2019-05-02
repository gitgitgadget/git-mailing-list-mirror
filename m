Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7C21F453
	for <e@80x24.org>; Thu,  2 May 2019 12:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEBMaR (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 08:30:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36173 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBMaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 08:30:17 -0400
Received: by mail-io1-f67.google.com with SMTP id d19so1951546ioc.3
        for <git@vger.kernel.org>; Thu, 02 May 2019 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipVs3vXIPabjpOPUzf1eLEIDI9xczo2+ClHLL3hYpJQ=;
        b=G1F6J9MFMHlQWnrKu1AHvkUs2Ji0q2vlI75QF4tXwfS7jhbY6VdeME+0sYFQcj77On
         78YoP7QABt4yV56bCj/IgCWGb45lESVoIBGsq4qUGLLkTcA3M071TINXflGmO4VvgXuD
         pPyfS/+dhNDWTeBUU64t/aBrPofQzfALBJSJCS4x+/gefcDiIBK2RKp3rLaWFJNiNucr
         f1TywEsCATr8DcieF5y5uulIGkR8104OiZhQFlKi3eK9UPAIHjokpN3nKrtKgBD5jmPQ
         ehVR1NGprIT3pNYOohBN2VB3L1ZznrINeR7mjlvroKcoFFcloi1OlC1nh57P4LpFipUM
         nxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipVs3vXIPabjpOPUzf1eLEIDI9xczo2+ClHLL3hYpJQ=;
        b=IxGr5Jth+gTVvd0aobnnTl4dP5m6O+sWGUAEwMyaslZvDrS7Bp43MOgUkIUhN+3NOr
         QvczbUGS+NRUZAFf3UxVEW3LlyQK5SZt6G151EOc6MwKkKijkrIZFRXzvm38gMRy06uq
         zvOAlaP9H92g5dlyeeTmRUZapWqM6FMCwRuAxqe/+LVhWI3t07XCdyEfh/DrMc3sz/XZ
         WJgOhnMLlNriA5jwmLVM4kqiBkxfZOwA3NYCeUcAHRolC4GWvuXUx/BQmZLag3JxRL6K
         1kJvLCMy61bqiF+r9K3UwoRgTp0tJgHAAjqrnIi+xytz9RDSKgE7G12DAGSwY9hYWcMJ
         cuGw==
X-Gm-Message-State: APjAAAV4kjFcKlEE0gFH9RXs+bWXWucgCxFAx9XO7ES+4uUWPrcrlD3s
        IwmpoSQKqRiAm9GBmVpcN2BjEdjYXSmi4axgT+MVww==
X-Google-Smtp-Source: APXvYqxNbHRLVo3WUAdllhIRw23rNbAiVanF5Dqz7wWe61X1GEd7Gp+wGbf39rnxH98j5fxw2wXQ/J1r8fauB/gFZ0U=
X-Received: by 2002:a05:6602:2042:: with SMTP id z2mr1999248iod.282.1556800216543;
 Thu, 02 May 2019 05:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAA2qrhBmbSe5R0xQPBZiRcz0MGG=JcF4BjxHqmyeTFNR19FKbg@mail.gmail.com>
In-Reply-To: <CAA2qrhBmbSe5R0xQPBZiRcz0MGG=JcF4BjxHqmyeTFNR19FKbg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 May 2019 19:29:50 +0700
Message-ID: <CACsJy8CJ_PB+QKp-T-yTHNPYgjEEVN39QbnAu4kKzGGcEQ0ezA@mail.gmail.com>
Subject: Re: "git branch -f" corrupt other worktree
To:     frank kulow <kulow.f@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 2, 2019 at 6:59 PM frank kulow <kulow.f@googlemail.com> wrote:
>
> git version 2.21.0.windows.1
>
> > /c/tmp/gt (Branch_702091a0)
> $ git worktree add ../wt master
> Preparing worktree (checking out 'master')
> HEAD is now at f534c32 4
>
> > /c/tmp/gt (Branch_702091a0)
> $ git branch -D master
> error: Cannot delete branch 'master' checked out at 'C:/tmp/wt'
>
> #but this is possible:
>
> > /c/tmp/gt (Branch_702091a0)
> $ git branch -f master HEAD

I admit I didn't see this. But I don't know how far we would go
protecting other worktrees. You give --force and that usually means
"Yes I know what I'm doing, don't stop me". If --force rejects in this
case, what would be the real force, --force --force maybe, or fall
back to "git update-ref"?

>
> #and the other worktree is now corrupted:
>
> > /c/tmp/wt (master)
> $ git status
> On branch master
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
>
>         modified:   txt.txt
>         deleted:    txtb.txt
>
>
>
> greetings f.kulow



-- 
Duy
