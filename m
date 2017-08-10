Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A5A208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbdHJRgr (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:36:47 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35731 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdHJRgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:36:46 -0400
Received: by mail-lf0-f51.google.com with SMTP id t128so6587162lff.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GfOpii2iB0pAZEaABFllReZTGTKZxCuJyCvx8EiWpTM=;
        b=M+VJaPhFMqgTglJs6/mkiYvwM8a+ixys3ONBXNgGYEdVvGlZoPIKI7fErMOhGMMEJg
         UaGy7HWQq5xAzSHmo+6fHgz7NnCcf3TndIUeaX0QvM+5y3cInCcyDQQD7cKiZ5I7W8GT
         yXBEB76AGd2dg1mMItCw0yTMWSbsWsSD2cEz6eRe9tiAiNn7757nma0BA8w4UhTWPEuc
         W9ZlaNq1ku8Bpq6PNzSXlyagvCyXLrovX8KG4x3WxfTW4dZI7+Wt0uOadCzz4yJE4n7i
         RLqkWA9vBjyq91WX9CH7j7rmUZ/aA5N+9ZHh/2u+AOnVPyJXT6xk9l3YPWeHXsjOty6V
         ieRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GfOpii2iB0pAZEaABFllReZTGTKZxCuJyCvx8EiWpTM=;
        b=moCkxJxJ53+uJkYVLKKlmPb8BUasV+oH/rxV/oZ0oFBu4SMvaZ5o6T3OnjYmxZqmeC
         2XVEmvyOV+BxKfuhPCuUMhViaRJs94LtG3KXhBrVLelEqLBQ7uL3ziS/0BilAcCrXYjb
         rZls24va8rnUQB0KxLnYzxx3LZVoNLzRqBx7pJlJrExpcp8lvsGxMwCEme4w9zOh5Skw
         gG3NZY5M7LVYav/f+5Y5f74Da5YfjVetgYaKNDpLyh9QVqgk/KbDLhIfFJQBM2FYESyT
         7JuqQyMf7FPlFzsCQAbhl8M0OJjReAX+bXUnscU3J3Opq1F8/U5/Ee75UDAeINatqADh
         CIbQ==
X-Gm-Message-State: AHYfb5iwq2lt+yPLWmlqA/CeSD5t0GbFAf5V997ikEcE4lhhL84gQxmJ
        s9drrjvwzFzwxwhngxPLjozIMbbqg6Ehhg92sw==
X-Received: by 10.25.92.9 with SMTP id q9mr5704606lfb.117.1502386605060; Thu,
 10 Aug 2017 10:36:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 10:36:44 -0700 (PDT)
In-Reply-To: <87mv7773tp.fsf@local.lan>
References: <87mv7773tp.fsf@local.lan>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 10:36:44 -0700
Message-ID: <CAGZ79kbgb2P7KT_b9xuMj1pN1+jsPfH7YSJNDyDB5dY3cwXCQg@mail.gmail.com>
Subject: Re: Not understanding with git wants to copy one file to another
To:     Harry Putnam <reader@newsguy.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 10:03 AM, Harry Putnam <reader@newsguy.com> wrote:
> I ran into a line in git commit ouput I had not see before
>
>   #copied:     d0/etc/hosts -> misc/old-readerHOSTvcs-files/etc/hosts
>
> So googling I learned that this might happen if git thinks the two
> files are the same.
>
> I was pretty sure they were not the same so checked them>
>
>  <inside git repo>
>
> diff d0/etc/host misc/old-readerHOSTvcs-files/etc/hosts
>
> The output is a bit long but shows them being quite different.
>
> Some 2 dozen or so lines that dramatically differ.
>
> Here are two that are at least kind of similar but would never be seen
> as the same:
>
> < 192.168.1.43      m2.local.lan       m2       # 00-90-F5-A1-F9-E5
>> 192.168.1.43    m2.local.lan        m2         # win 7
>
> Not to mention they are quite different lines as well.
>
> So what is going on and what should I be looking at?

The diff machinery has a threshold for when it assumes
a copy/move of a file. (e.g. "A file is assumed copied when
at least 55% of lines are equal")

https://git-scm.com/docs/git-diff

See -C and -M option.

git-status seems to use this machinery as well, but does
not expose the options?
