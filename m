Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9381F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 06:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbeKQQWn (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 11:22:43 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33229 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeKQQWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 11:22:43 -0500
Received: by mail-it1-f194.google.com with SMTP id p11-v6so2815120itf.0
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 22:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sO/a9C8NCV8TuBpOpsMhD5Lxsu3LMjK/CMEhnNGkO/E=;
        b=jhSh3WDS/Ft1ZJTNzQKK8usjfTG5/I2fVuYuyONY+BneLarwxDpZA09m4ebex+F0K2
         CMk1W7gBEK4gzL8lZWfOSn0gHJrCPDfm1M6aEmWjsBFg6x1HKU0zKqzq7grYveYP1iw3
         JtPe9iyNMlYHDX5hVr3tM4Dw65sjXu19o3TWrOMIUWM9AzNwUHsKGC2w35Ub5YHoHMTB
         czGaykTQZIX6uDmRkaYoai8oPIi6voZ3G8HnP/rPzcJx3coh8w18eg7u1lQ3WcUyHwmA
         hb7WnkX8EpNhVkscKGV5U5qnnYItoJOZL551ug9XDD0KSb8pWAjAVxZscDoHZMhwHoi3
         p0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sO/a9C8NCV8TuBpOpsMhD5Lxsu3LMjK/CMEhnNGkO/E=;
        b=s4ip9OL4+kOAMO6fF/P00kSJsvhfRfLDskc0TAbuj94ysfnYOByfbtXIdDqtlyl7I7
         EyBuKHQHOMGC2vN8ZKtciS9cLgDk8T5GyeiutCcUbmxyrWMqPzdBy5tF2Ar/sp1ftBy0
         wQg6jKLyZ8MlAvjWw0IJvkGvyHCH8SaSbP5xoBFXVJfjZiras5zS1BWtWBqyI4KKtB8y
         rDvePcTpLLH83n1nxtWjj4kyFiQ56sLisM+qKeGEVVdxB5RKhh8P1Gz5BCIgZXwJPWZR
         T+iE4KqfUKad2sgITQEuktoGLrqiuwgBeC/aXVbMMPygT0WNdjl56O0Qv0rzbbFEK2NB
         Aiaw==
X-Gm-Message-State: AGRZ1gKAJvxsw2JWILd3aBnH8/TsLdwKuqQUxAmQocAn+Bicgdl8KPXt
        vNi9Edy2Nf5s4dNk48oVwPRdurislpuXTJ2sGms=
X-Google-Smtp-Source: AJdET5cD2B8X/RseVKMLa7g6Bzorl4x125Z4aDSxnFnzwqn8aaKTqi6B9eLVJf97QZkJMNNYB4elxG0qtL908uhnED8=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr11963359jak.30.1542434828496;
 Fri, 16 Nov 2018 22:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com>
In-Reply-To: <20181115005546.212538-1-sxenos@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 17 Nov 2018 07:06:41 +0100
Message-ID: <CACsJy8Dk=Z4z5BD-XD_uTJg9Aysd5A--BUjnZR4i5=PfoabAPg@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     sxenos@google.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, carl@ecbaldwin.net,
        dborowitz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 2:00 AM <sxenos@google.com> wrote:
> +Goals
> +-----
> +Legend: Goals marked with P0 are required. Goals marked with Pn should b=
e
> +attempted unless they interfere with goals marked with Pn-1.
> +
> +P0. All commands that modify commits (such as the normal commit --amend =
or
> +    rebase command) should mark the old commit as being obsolete and rep=
laced by
> +    the new one. No additional commands should be required to keep the
> +    obsolescence graph up-to-date.

I sometimes "modify" a commit by "git reset @^", pick up the changes
then "git commit -c @{1}". I don't think this counts as a typical
modification and is probably hard to detect automatically. But I hope
there's some way for me to tell git "yes this is a modified commit of
that one, record that!".

> +Example usage
> +-------------
> +# First create three dependent changes
> +$ echo foo>bar.txt && git add .
> +$ git commit -m "This is a test"
> +created change metas/this_is_a_test

I guess as an example, how the name metas/this_is_a_test is
constructed does not matter much. But it's probably better to stick
with some sort of id because subject line will change over time and
the original one may become irrelevant. Perhaps we could use the
original commit id as name.

> +$ echo foo2>bar2.txt && git add .
> +$ git commit -m "This is also a test"
> +created change metas/this_is_also_a_test
> +$ echo foo3>bar3.txt && git add .
> +$ git commit -m "More testing"
> +created change metas/more_testing
> +
> +# List all our changes in progress
> +$ git change -l
> +metas/this_is_a_test
> +metas/this_is_also_a_test
> +* metas/more_testing
> +metas/some_change_already_merged_upstream
> +
> +# Now modify the earliest change, using its stable name
> +$ git reset --hard metas/this_is_a_test
> +$ echo morefoo>>bar.txt && git add . && git commit --amend --no-edit
> +
> +# Use git-evolve to fix up any dependent changes
> +$ git evolve
> +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> +rebasing metas/more_testing onto metas/this_is_also_a_test
> +Done
> +
> +# Use git-obslog to view the history of the this_is_a_test change
> +$ git obslog
> +93f110 metas/this_is_a_test@{0} commit (amend): This is a test
> +930219 metas/this_is_a_test@{1} commit: This is a test
> +
> +# Now create an unrelated change
> +$ git reset --hard origin/master
> +$ echo newchange>unrelated.txt && git add .
> +$ git commit -m "Unrelated change"
> +created change metas/unrelated_change
> +
> +# Fetch the latest code from origin/master and use git-evolve
> +# to rebase all dependent changes.
> +$ git fetch origin master
> +$ git evolve origin/master
> +deleting metas/some_change_already_merged_upstream
> +rebasing metas/this_is_a_test onto origin/master
> +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> +rebasing metas/more_testing onto metas/this_is_also_a_test
> +rebasing metas/unrelated_change onto origin/master
> +Conflict detected! Resolve it and then use git evolve --continue to resu=
me.
> +
> +# Sort out the conflict
> +$ git mergetool
> +$ git evolve --continue
> +Done
> +
> +# Share the full history of edits for the this_is_a_test change
> +# with a review server
> +$ git push origin metas/this_is_a_test:refs/for/master
> +# Share the lastest commit for =E2=80=9CUnrelated change=E2=80=9D, witho=
ut history
> +$ git push origin HEAD:refs/for/master

How do we group changes of a topic together? I think branch-diff could
take advantage of that.

> +Detailed design
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Obsolescence information is stored as a graph of meta-commits. A meta-co=
mmit is
> +a specially-formatted merge commit that describes how one commit was cre=
ated
> +from others.
> +
> +Meta-commits look like this:
> +
> +$ git cat-file -p <example_meta_commit>
> +tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +parent aa7ce55545bf2c14bef48db91af1a74e2347539a
> +parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
> +parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
> +author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +parent-type content
> +parent-type obsolete
> +parent-type origin
> +
> +This says =E2=80=9Ccommit aa7ce555 makes commit d64309ee obsolete. It wa=
s created by
> +cherry-picking commit 7e1bbcd3=E2=80=9D.

This feels a bit forced. Could we just organize it like a normal
history? Something like

*
|\
| * last version of the commit
*
|\
| * second last version of the commit
*
|\

Basically all commits will be linked in a new merge history. Real
commits are on the second parent, first parent is to link changes
together. This makes it possible to just use "git log --first-parent
--patch" (or "git log --oneline --graph") to examine the change. More
details (e.g. parent-type) could be stored as normal trailers in the
commit message of these merges.
--=20
Duy
