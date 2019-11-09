Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7D61F454
	for <e@80x24.org>; Sat,  9 Nov 2019 02:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfKICAp (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 21:00:45 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:44494 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfKICAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 21:00:44 -0500
Received: by mail-pf1-f172.google.com with SMTP id q26so6293852pfn.11
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 18:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QF5+dGeh3fwjvsPynzSkv+ZmZ9e/DMGObu/8wIf96To=;
        b=Gs3s8VjpWZQZ7EHBFhCo+MvdGkKdz2vf+RuZglYoVjFDbAzlOowHP8M1alqH9Q1fB/
         oF01aoqQMpkHgsLN+cwSarhygO4ybYFPHOJcGLSgfpOaAo/LlUoIjFS11KrHqsWIzohq
         XkGhXqKfzXDeDVQMlFYFZ2RzSI4JJqNuQ5ifOXwZFNTITzSghKylpPawtBuBJP4Hbc/B
         csSnAev1qSFlo77YXVaTeDlsrh1PHjAiQDyKSCp5oSGxTmL8CTyUQSKnPjW+348C2vyb
         zRLwO7zzIb3TJmOELqFKz61z/0pPyL/Epgyw0/n8iAFloYTS1343X7A7KMxMkuNtICYE
         fTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QF5+dGeh3fwjvsPynzSkv+ZmZ9e/DMGObu/8wIf96To=;
        b=lNvCFjFvxGevdXW2/TjEMYUsIJxYAoweDAEusIstjlf9Z9RyvXimJKUR7vlMXzHYH2
         ZjuslmBNfmJAjNDBqT53+msRTU6F+1CMxxRheJcXTiiGlAztdK+IIF6prg97pShO/4KP
         6Gd/sQMMFYoZvtsYvB+/m0aap1GJyHY1uJ1hc6jU0e1EeRj4AxyF89F/PzmsZ0MQopjp
         YdMjbQpVSpPnSCFZ924vM06vATipDNVHXhjr50ZabQ8aAm5PI6JIJuhCz+D2J1S6AKfP
         4OKD95laUQThDl/wJYrF1JE2MpUCngFqQF55cao9NQ35gxWhDcZQ8wOWChqh4/QBjK7G
         0LCg==
X-Gm-Message-State: APjAAAW0JVGNdCGVWXEurzI+8qXqXQIGVvY/7h1eA2LWxx4G8mzcSrRA
        Y/aHSvHKtsNC/GVz6qtKucBxUc6pbFU=
X-Google-Smtp-Source: APXvYqwAvvtb8cZpMiLYabL8S6XtcQTkrUtr/Ntzww44uKilnqbNeHyu4qm6kXbEANtAj9g3aIJQPg==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr15596746pge.276.1573264842883;
        Fri, 08 Nov 2019 18:00:42 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b9sm9094111pfp.77.2019.11.08.18.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 18:00:42 -0800 (PST)
Date:   Fri, 8 Nov 2019 18:00:37 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: Should we auto-close PRs on git/git?
Message-ID: <20191109020037.GB60198@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

It seems to me that the friendly template text we prefill when someone
opens a pull request in github.com/git/git isn't being fully appreciated
by many interested contributors. For some time now, Johannes has been
slogging through the list to try to narrow it down to folks who are
still interested in contributing, and yesterday on #git-devel said he
was pretty happy with the progress so far.

But to me, this seems like a sort of Sisyphean task - more folks will
want to make contributions and not read the template text, and we will
have more PRs being ignored forever, especially if Johannes decides he
doesn't want to shepherd those changes anymore (I would have decided
that long ago, in his shoes).

To that end, I wonder if we should add an Action to automatically close
PRs on that repo. It looks like https://github.com/dessant/repo-lockdown
would do the trick. We could close incoming PRs automatically with a
kind, maybe more succinct or prescriptive version of the prefill text
encouraging folks to open the exact same PR against gitgitgadget/git
instead.

Here's the prefilled template now:

  Thanks for taking the time to contribute to Git! Please be advised
  that the Git community does not use github.com for their
  contributions. Instead, we use a mailing list (git@vger.kernel.org)
  for code submissions, code reviews, and bug reports. Nevertheless, you
  can use GitGitGadget (https://gitgitgadget.github.io/) to conveniently
  send your Pull Requests commits to our mailing list.

  Please read the "guidelines for contributing" linked above!

Maybe we can close PRs with something like this:

  Thank you for taking the time to submit a patch!

  However, Git does not accept submissions via GitHub pull requests.

  You can open an identical pull request to this one against
  https://github.com/gitgitgadget/git and follow the instructions there
  to submit it to the Git mailing list, where reviews are performed.

  If you don't want to subscribe to the mailing list, you can keep an
  eye on your patch at https://public-inbox.org/git, or by watching
  comments on your GitGitGadget pull request.

  More info on GitGitGadget: https://gitgitgadget.github.io

I was aiming for "same message, but firmer", and "write down something
so we have a place to start". I look forward to the discussion.

 - Emily

PS: Today we have 17 PRs open against git/git, and I think all of them
have been nudged by dscho in comments to open against GGG instead. Many
are in a state where dscho is sending a ping every few weeks to see if
the committer is interested in following through.

https://github.com/git/git/pulls
