Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF11A1F42D
	for <e@80x24.org>; Fri, 25 May 2018 19:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968241AbeEYTtt (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 15:49:49 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43955 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967858AbeEYTts (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 15:49:48 -0400
Received: by mail-yw0-f194.google.com with SMTP id p14-v6so2074633ywe.10
        for <git@vger.kernel.org>; Fri, 25 May 2018 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=poHPlvqSc9UAVFhMflS4UKR9wEIolhnWrwnk7ldLo4Y=;
        b=ae5GxDBH77m5iaqBJQgVxg8C+tQvmYl4Wz/WxHE+sXkijFcJQi49zTP632uXo29GFq
         mp1uJH657tdY6/WD3N3G2o0u8y8gNPAqgErwajUoJieQg2T/JAGWEdCS51NqHlHgqdSn
         XYgGh1uB2p3TvBS+qrEY8WMOBOeQQ96x4fQHXl29lMHnnB2T/eC76Z9uRJU0Qtj5+BAH
         9CAKPGWgFvy+qJvDUaDx+5vkxR0qo7hOCX8cQZ/k9SNmcZEa8V+adXxQyO4CrQWdA58s
         Tr8b34KKZ3hUdtFMUnfKV0ASxvzjuxustOQUBhY9wnY0KKW2hmWenz44fWN5KfmQdI8O
         a8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=poHPlvqSc9UAVFhMflS4UKR9wEIolhnWrwnk7ldLo4Y=;
        b=eCqmjESfXyFuoAzuPD4NVCTkvGvCeFdtPj69PnaTxWMMs8zqeIAzKcYgqp+kBD/DnQ
         RYdR8BXFBaiRe3cUoXh/IDMCb9xzGZgIZKe3KCfTtDXTzBeMHb9ZgoJJ/10vwb9mr+OW
         +FJNEmlEm4KwjMKIuN2i3A5Vo9GZExEL/t8vuGhLLHb3WIaSYf4LcB46QEefsRM4VRQi
         ywIxWZQ9zwqECqFXzCJ73Mu+yccvKtjQlXAK1YSsHB24ybbPK03IWy1wy2ZRCx4vEs5G
         areBgWu436JsIaLpjX/AK/YRA/RoP00XpgQPzLRYXhlEike1N/mx4kE06AaSYH+4sGRB
         uCLQ==
X-Gm-Message-State: ALKqPwc7bIbuFyznNnmmayXAkmSGJpEc8i0QdjHmO9lI6SE7jhgNhDHE
        DYJoDVQ1G0mGq++Gk7WZ9unzB0rNK4jbeDYbbBoIuA==
X-Google-Smtp-Source: ADUXVKLs8e3SqMDctmkVLYY3QV//nsKtrjgYeWjg4ELJNaTXOsAhDsX11DpyH15uPpyEU340MC9Sp/DpcQSDj0bjPvE=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr2157361ywf.33.1527277787684;
 Fri, 25 May 2018 12:49:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 25 May 2018 12:49:47 -0700 (PDT)
In-Reply-To: <87lgc77wc7.fsf@evledraar.gmail.com>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <87lgc77wc7.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 May 2018 12:49:47 -0700
Message-ID: <CAGZ79kae4k=uLx-oX5emxas4KrqObzQhzgir0coOSBzzpO8APw@mail.gmail.com>
Subject: Re: sb/submodule-move-nested breaks t7411 under GIT_FSMONITOR_TEST
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 5:28 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, May 17 2018, Junio C Hamano wrote:
>
>> * sb/submodule-move-nested (2018-03-29) 6 commits
>>   (merged to 'next' on 2018-04-25 at 86b177433a)
>>  + submodule: fixup nested submodules after moving the submodule
>>  + submodule-config: remove submodule_from_cache
>>  + submodule-config: add repository argument to submodule_from_{name, pa=
th}
>>  + submodule-config: allow submodule_free to handle arbitrary repositori=
es
>>  + grep: remove "repo" arg from non-supporting funcs
>>  + submodule.h: drop declaration of connect_work_tree_and_git_dir
>>
>>  Moving a submodule that itself has submodule in it with "git mv"
>>  forgot to make necessary adjustment to the nested sub-submodules;
>>  now the codepath learned to recurse into the submodules.
>
> I didn't spot this earlier because I don't test this a lot, but I've
> bisected the following breakage down to da62f786d2 ("submodule: fixup
> nested submodules after moving the submodule", 2018-03-28) (and manually
> confirmed by reverting). On Linux both Debian & CentOS I get tests 3 and
> 4 failing with:
>
>      GIT_FSMONITOR_TEST=3D$PWD/t7519/fsmonitor-all ./t7411-submodule-conf=
ig.sh
>
> -v -x output follows:
>
> expecting success:
>         mkdir submodule &&
>         (cd submodule &&
>                 git init &&
>                 echo a >a &&
>                 git add . &&
>                 git commit -ma
>         ) &&
>         mkdir super &&
>         (cd super &&
>                 git init &&
>                 git submodule add ../submodule &&
>                 git submodule add ../submodule a &&
>                 git commit -m "add as submodule and as a" &&
>                 git mv a b &&
>                 git commit -m "move a to b"
>         )

when you add a test_pause here and dump the
state of the setup, then it can be observed that when the fsmonitor is acti=
ve
the last commit is different; without fsmonitor the moved gitlink and the c=
hange
to the .gitmodules file is part of the commit, i.e.

$ git -C super show
        commit d3d90b70a01bd17d026f75a803c8b65f5903a7c0 (HEAD -> master)
        Author: A U Thor <author@example.com>
        Date:   Fri May 25 19:21:58 2018 +0000

            move a to b

        diff --git a/.gitmodules b/.gitmodules
        index 3f4d474..6149210 100644
        --- a/.gitmodules
        +++ b/.gitmodules
        @@ -2,5 +2,5 @@
          path =3D submodule
          url =3D ../submodule
         [submodule "a"]
        - path =3D a
        + path =3D b
          url =3D ../submodule
        diff --git a/a b/b
        similarity index 100%
        rename from a
        rename to b
When running with the fsmonitor:

$ git -C super show
        commit 57022a92acf46f303498c045440ec099cbc35a2d (HEAD -> master)
        Author: A U Thor <author@example.com>
        Date:   Fri May 25 19:22:52 2018 +0000

            move a to b

        diff --git a/a b/b
        similarity index 100%
        rename from a
        rename to b
$ git -C super diff
        diff --git a/.gitmodules b/.gitmodules
        index 3f4d474..6149210 100644
        --- a/.gitmodules
        +++ b/.gitmodules
        @@ -2,5 +2,5 @@
          path =3D submodule
          url =3D ../submodule
         [submodule "a"]
        - path =3D a
        + path =3D b
          url =3D ../submodule

This hints at a problem with git commit;

I tried adding test_tick, to unconfuse the fsmonitor, but that doesn't help=
,
digging further, the problem is in the git mv command, which fails to
add the change in
.gitmodules to the index.

Adding the verbose flag to stage_updated_gitmodules() that is called by
git-mv very late in the game, such that

void stage_updated_gitmodules(struct index_state *istate)
{
    trace_printf("staging .gitmodules files");
    if (add_file_to_index(istate, GITMODULES_FILE, ADD_CACHE_VERBOSE))
        die(_("staging updated .gitmodules failed"));
}

We would get a message if the .gitmodules file is staged correctly, as
add_file_to_index() that calls add_to_index that would print

    if (verbose && !was_same)
        printf("add '%s'\n", path);

I could not see that message, so I suspect, that there is something
racy.

Will debug further.
