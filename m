Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2741B1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeHBWgF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:36:05 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36202 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeHBWgF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:36:05 -0400
Received: by mail-yw1-f66.google.com with SMTP id v197-v6so143765ywg.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owo4y7joCe58Km0BvBun/Bcq66vOSO6nLS774wHp4Jc=;
        b=rIsj6LwuJQNZ/V52pfCp8bKGqW96k4O/2SHFEu4yBR6LLapdKxJ1GNIiI87iLuxFNX
         QsAPV7FmyTnLAFeHmSWZq2fqFG0uMw0obSFlB46e/o8rlp7LM0eafxlmeLnUigx+aCfa
         v3N5H8zvMUJ4TZbxS+hXRkebqrtOkmnYQK0KrXx4JypOt71YQ/9Muw8ZrvNZ8fApypxF
         MPBAedbdbF6aHw7kKjYqpY1OgHqi07lDK3UnUBXYIQn4or6rqG5Jcw5SJbCisZN19fEb
         GIojBJ851bqtEJVfGKiiW5cZE+/mbF0etJluj9iXLkERysuJKY4WrC7qYOhrD0ZfZfUF
         WCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owo4y7joCe58Km0BvBun/Bcq66vOSO6nLS774wHp4Jc=;
        b=s8zdUHN0+TAAGiUOniP+Nsu0GaCIYLFmNw4GsD0cf0JyD3t1Q46D5dGQE7QBA7I4fJ
         cvV0dQ2XtgV69G7rKExeGqqmVkiHTKSocxfbl5JfsKGgo9V2+Uo4OxITNwsVoMeDmUu9
         0GUHgMH3vm1nAeu2RQfGg81CHC2MBLgH0n9efA1DnV7eOX5/4Jm6NOemMQX6sD37MXau
         4okAZPBohi2aTh+lpW6OHImwHFqEYTGAJWWbcvp6SDWYjOcclEdNrbE+OJiQHJW8Infg
         wOJp3NxSpV0IFpFWAC7OVAICDgjV7O/rbzawuZZxyd5Fb03kAA+9GKH0Xpkj14rQhjXC
         JbmA==
X-Gm-Message-State: AOUpUlEllC5O/l4T+A/CllOmkLOkjIovhaGbQBQi4k/b36S+AJ/j5xX1
        YIGqmvhMk4Og5pSXJacsrfjSS2UGoaIwAm0kMtt9Ng==
X-Google-Smtp-Source: AAOMgpdBf9EelwDz72jsC2sJ5UpgevZxpJWN0Tzzwb1+sR1hhHy6IMLF1Bc7D6piGuYB3Q7adKSkn9diyVpIhy89qh4=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr666653ywa.340.1533242596346;
 Thu, 02 Aug 2018 13:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-11-ao2@ao2.it>
In-Reply-To: <20180802134634.10300-11-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 13:43:05 -0700
Message-ID: <CAGZ79kbQ0DsAXZrvpp3_2CrMU6Jburf6UdjTxNSd72JqQCczWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/12] t7416: add new test about HEAD:.gitmodules
 and not existing .gitmodules
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> git submodule commands can now access .gitmodules from the current
> branch even when it's not in the working tree, add some tests for that
> scenario.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>
> For the test files I used the most used style in other tests, Stefan suggested
> to avoid subshells and use "git -C" but subshells make the test look cleaner
> IMHO.

Oh well. Let's not dive into a style argument, so let me focus on the tests.

IMHO it would be nice if (at least partially) these tests are in the same patch
that added the reading from HEAD:.gitmodules  (although I like short
patches, too).

>
>  t/t7416-submodule-sparse-gitmodules.sh | 112 +++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100755 t/t7416-submodule-sparse-gitmodules.sh
>
> diff --git a/t/t7416-submodule-sparse-gitmodules.sh b/t/t7416-submodule-sparse-gitmodules.sh
> new file mode 100755
> index 0000000000..3c7a53316b
> --- /dev/null
> +++ b/t/t7416-submodule-sparse-gitmodules.sh
> @@ -0,0 +1,112 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2018  Antonio Ospite <ao2@ao2.it>
> +#
> +
> +test_description=' Test reading/writing .gitmodules is not in the working tree
> +
> +This test verifies that, when .gitmodules is in the current branch but is not
> +in the working tree reading from it still works but writing to it does not.
> +
> +The test setup uses a sparse checkout, but the same scenario can be set up
> +also by committing .gitmodules and then just removing it from the filesystem.
> +
> +NOTE: "git mv" and "git rm" are still supposed to work even without
> +a .gitmodules file, as stated in the t3600-rm.sh and t7001-mv.sh tests.

"supposed to work" != "tested that it works" ?
I am not sure what the NOTE wants to tell me? (Should I review those
tests to double check them now? or do we just want to tell future readers
of this test there are other tangent tests to this?)


> +test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
> +       (cd super &&
> +               git submodule init
> +       )
> +'
> +
> +test_expect_success 'showing submodule summary when the gitmodules config is not checked out' '
> +       (cd super &&
> +               git submodule summary
> +       )
> +'
> +
> +test_expect_success 'updating submodule when the gitmodules config is not checked out' '
> +       (cd submodule &&
> +               echo file2 >file2 &&
> +               git add file2 &&
> +               git commit -m "add file2 to submodule"
> +       ) &&
> +       (cd super &&
> +               git submodule update
> +       )
> +'
> +
> +test_expect_success 'not adding submodules when the gitmodules config is not checked out' '
> +       (cd super &&
> +               test_must_fail git submodule add ../new_submodule
> +       )
> +'
> +
> +# "git add" in the test above fails as expected, however it still leaves the
> +# cloned tree in there and adds a config entry to .git/config. This is because
> +# no cleanup is done by cmd_add in git-submodule.sh when "git
> +# submodule--helper config" fails to add a new config setting.
> +#
> +# If we added the following commands to the test above:
> +#
> +#   rm -rf .git/modules/new_submodule &&
> +#   git reset HEAD new_submodule &&
> +#   rm -rf new_submodule

Alternatively we could check for the existence of .gitmodules
before starting all these things?

I think it is okay to not clean up if we check all "regular" or rather expected
things such as a non-writable .gitmodules file before actually doing it.
(This is similar to 'checkout' that walks the whole tree and checks if the
checkout is possible given the dirtyness of the tree, to either abort early
or pull through completely. In catastrophic problems such as a full disk
we'd still die in the middle of work)

> +#
> +# then the repository would be in a clean state and the test below would pass.
> +#
> +# Maybe cmd_add should do the cleanup from above itself when failing to add
> +# a submodule.
> +test_expect_failure 'init submodule after adding failed when the gitmodules config is not checked out' '

So this comment and test is about explaining why we can fail mid way through,
which we could not before unless we had the catastrophic event.

I think we should check for a "writable" .gitmodules file at the beginning,
which is if (G || (!G && !H)) [using the notation from the cover letter]?

> +       (cd super &&
> +               git submodule init
> +       )
> +'
> +
> +test_done
> --
> 2.18.0
>
