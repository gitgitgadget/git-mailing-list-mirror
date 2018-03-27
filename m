Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7F01F404
	for <e@80x24.org>; Tue, 27 Mar 2018 22:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC0W4z (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 18:56:55 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34289 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeC0W4y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 18:56:54 -0400
Received: by mail-yw0-f171.google.com with SMTP id e17so193470ywa.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uL7o+qp6vsa6UOplg2A3YZA5U+vdBe6Zy/5/XFTLPW8=;
        b=GtW5HEUs5v5BMT6I1dAafYVKTJn12oc1CEpIgMcJ089rzp8bVrgrDR0XvYREVuNfRU
         m2kidpycfjNp0yjp0+KIspuXK6qexXn7w39/M+cqoQUKcQ5ZSD7R6LnMviV0sgGKI117
         rfxur8tkAS30w9uWeA55nDVVf+hGS9n1ymDQvuO7hFj1wb/S34fnDtDO8vCaoH3LcesN
         74JEvOb1z9p9du1jTW1KKIrzg0da6pr+rqKXFDPJqhdnBCKBUPgZX7H7LL1UXcJhlKCY
         qULpgTY8UrMSrx7FysRGZXQT9NWGQLDQFFGIxiKhL7HiGAAB9k7bXTpeJnhZmC+DqgoL
         3yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uL7o+qp6vsa6UOplg2A3YZA5U+vdBe6Zy/5/XFTLPW8=;
        b=mBHFUYynBlaukMCJZBMQwNHGanfYuAmpV+VPAcseTrfp3YQQHNEMK+UVMlj9q//TGe
         JC60EX2NX0h0ZmJ4n+ll/PXUA5akCwpgUeg96XAWUTEu8XVDjOcO9Bb27kqP6j+PbBTt
         e46ZFCXxb5R0RFnegomFtYl1cHjMflQxHy1B46B5E1POwu1QBSWQra0asKKWUtFvdOKW
         oTilw8QuzQM30ZKm4QBlz2S4FPV12uYa0M6D2viqO0dmN61I5yKi8GrODH0Nc38qC9fX
         9LpgJsZisfg5zwhblQTqcRu274BiE3xH7p7NLAoAjdFxkvN1efVit5UeYHe/n+gR9wIj
         LifA==
X-Gm-Message-State: AElRT7Hih2H+nnRbTexIbvygzWJGteMGPpskgehU83ITa8WlaN3DNQnB
        9xaqtymP4JgT0qjbpLCcDL7eHI0qOFx9JG8eX+USEA==
X-Google-Smtp-Source: AIpwx4//xcLjPczVQzxsRr7PxSIBug56SJMmbmmXaNZFS0y83FmCpauRIBzGldkvwSi2yP4VtzOu+WopEz8kRCB+0kM=
X-Received: by 10.129.232.5 with SMTP id a5mr860340ywm.421.1522191413426; Tue,
 27 Mar 2018 15:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <9e22b49e-6732-17c7-76fe-0ce241787db9@arcor.de>
In-Reply-To: <9e22b49e-6732-17c7-76fe-0ce241787db9@arcor.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Mar 2018 22:56:42 +0000
Message-ID: <CAGZ79kYGY5bjh0WPQh7xkXQxLkB9EQ-OcJhVuGE8YUnwmvk2Fg@mail.gmail.com>
Subject: Re: git submodule deinit resulting in BUG: builtin/submodule--helper.c:1045:
 module_list_compute should not choke on empty pathspec
To:     kumbayo84@arcor.de
Cc:     git <git@vger.kernel.org>, Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 12:55 PM Peter Oberndorfer <kumbayo84@arcor.de>
wrote:

> Hi,

> i tried to run "git submodule deinit xxx"
> on a submodule that was recently removed from the Rust project.
> But git responded with a BUG/Core dump (and also did not remove the
submodule directory from the checkout).

> ~/src/rust/rust$ git submodule deinit src/rt/hoedown/
> error: pathspec 'src/rt/hoedown/' did not match any file(s) known to git.
> BUG: builtin/submodule--helper.c:1045: module_list_compute should not
choke on empty pathspec
> Aborted (core dumped)

> I had a short look at submodule--helper.c and module_list_compute() is
called from multiple places.
> Most of them handle failure by return 1;
> Only module_deinit() seems to calls BUG() on failure.

Thanks for the analysis!

> This leaves me with 2 questions:
> 1) Should this code path just ignore the error and also return 1 like
other code paths?

This would be a sensible thing to do. I would think.
I just checked out v2.0.0 (an ancient version, way before the efforts to
rewrite
git-submodule in C were taking off) and there we can do

     $ git submodule deinit gerrit-gpg-asdf/
     ignoring UNTR extension
     error: pathspec 'gerrit-gpg-asdf/' did not match any file(s) known to
git.
     Did you forget to 'git add'?
     $ echo $?
     1

(The warning about the UNTR extension can be ignored that was introduced
later).
But the important part is that we get the same error for the missing
pathspec.
The next line ("Did you forget to git-add?") comes from git-ls-files which
at the time
was invoked by module_list() implemented in shell. I would think we can
live without
that line. So to fix the segfault, we can just s/BUG(..)/return 1/ as you
suggest.

> 2) Should "git submodule deinit" work on submodules that were removed by
upstream already?

To answer the question "Is this a submodule that upstream removed
(recently)?"
we'd have to put in some effort, essentially checking if that was ever a
submodule
(and not a directory or file).

When using "git pull --recurse-submodules" the submodule ought to be removed
automatically.

When doing a fetch && merge manually, we may want to teach merge to remove
a submodule that we have locally upon merge, too.

I view the git-submodule command as a bare bones plumbing helper, that we'd
want
to deprecate eventually as all other higher level commands will know how to
deal
with submodules.

So I think we do not want to teach "git submodule deinit" to remove dormant
repositories, that were submodules removed by upstream already.

> ~/src/rust/rust$ git submodule status
...
>   b87873eaceb75cf9342d5273f01ba2c020f61ca8 src/tools/lld ((null))

> -> strangely I get (null) for the current branch/commit in some
submodules?

This sounds like (3). Looking into that.

Thanks,
Stefan
