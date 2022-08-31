Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA319ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 18:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiHaSnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiHaSnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 14:43:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428BB20A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 11:42:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso173182pjk.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=F59uyLdvElIGwPA1XhuUe7jMt9EWQFXThGQAJPqOfjc=;
        b=er8M29HASKygxhlcImwHjGy+CuyUlEqTlKFZ5+SYVJyhqJsFJQwPb6YhkHAqDgJTi7
         EK3ovVTz5/M1Qo+vntsXArdtkOk/H8GdoD5SLEVR27iLm2OnD7cmi2NclFFZ9/C2WFTN
         m2Wq93B9c40kwDkZAfXkdQChoWyHC3abz5Xt4Xautf0ciauP0L1nLzme4ZUqvCMou9+M
         pISwi04cZgrOykPwCclD2MVMEvIy47lq8F15p1jFIZJj0kNxbd/VnEn3xK0dLu6yvON8
         syE9lwybqtEIwAtOkjkoBuRy2F/vQvtMG/e1CJj87j4Qb9WlRo5i09NC5I58dzCC5wSz
         y00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=F59uyLdvElIGwPA1XhuUe7jMt9EWQFXThGQAJPqOfjc=;
        b=EHOoTzIykFXN8K0HNpgMAEdxoQl8P8qS62YVqSG4jH9/26kwHfdIPHgAUvv1g53bLo
         v+fwngRyGLsX/aJa0yI8FFMnKUDZQDWTIMBX6s6ksBR8IoTIsNKt9otIGks8BnEvWUS8
         sUBsLQbdsgjkg4X/MyvWSXaO6Hgy0ZjYDThY0xW6J5gCzGhWs+hw1BugBnA51OS3/bNS
         OTduVOwdtch4yjV2ibrSQoghl/9KIwiKyihc+JEE/QWD94eQGGZLr8RS1tabsBxgaHAH
         oFE2/jjfA4JZ9+X6g2zoWV2sbKcbljXg8ZOPFChCO262DZVSTkMNBH1rZDQ9U7e6l5i1
         tN9w==
X-Gm-Message-State: ACgBeo37wWPwKuTKlSTtgliohECNaC3xsj+yVn/dt2O3xh/BuDSi5U+n
        /qUMHt4O2HbtJPRQyxPcIv2s
X-Google-Smtp-Source: AA6agR5It2YtPZDuLoCZZk74JTEtJ+urs3syKfiTNCmK8C8/j/SLYlqkMVQYTxjV2ut+R+o/OFSwFA==
X-Received: by 2002:a17:902:b607:b0:170:c7fc:388a with SMTP id b7-20020a170902b60700b00170c7fc388amr27276967pls.29.1661971342644;
        Wed, 31 Aug 2022 11:42:22 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902ce0600b0015e8d4eb1dbsm11956148plg.37.2022.08.31.11.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 11:42:22 -0700 (PDT)
Message-ID: <85ad26ba-8461-fdda-fb26-c99080dfa10d@github.com>
Date:   Wed, 31 Aug 2022 11:42:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 0/8] scalar: integrate into core Git
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, gitster@pobox.com
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
 <220831.86y1v48h2x.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220831.86y1v48h2x.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Aug 31 2022, Victoria Dye via GitGitGadget wrote:
> 
>> This series completes the initial implementation of the Scalar command as a
>> core component of Git. For readers new to the topic of Scalar, the
>> roadmap/design doc [1] provides some background information including how
>> the project started & evolved, as well as its current intent & high-level
>> design.
>>
>> [...]
>>
>> Prior series
>> ============
>>
>>  * Add 'scalar' command in 'contrib/':
>>    https://lore.kernel.org/git/pull.1005.v10.git.1638538470.gitgitgadget@gmail.com/
>>  * Introduce 'scalar diagnose':
>>    https://lore.kernel.org/git/pull.1128.v6.git.1653145696.gitgitgadget@gmail.com/
>>  * Add '-c/-C' compatibility:
>>    https://lore.kernel.org/git/pull.1130.v2.git.1643380317358.gitgitgadget@gmail.com/
>>  * [DROPPED] Integrate Scalar into CI builds:
>>    https://lore.kernel.org/git/pull.1129.git.1654160735.gitgitgadget@gmail.com/
>>  * Document Scalar's role in Git & plan remaining work:
>>    https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/
>>  * Generalize 'scalar diagnose' into 'git diagnose' builtin & 'git bugreport
>>    --diagnose':
>>    https://lore.kernel.org/git/pull.1310.v4.git.1660335019.gitgitgadget@gmail.com/
>>  * Add FSMonitor support to Scalar, refactor enlistment search:
>>    https://lore.kernel.org/git/pull.1324.v3.git.1660858853.gitgitgadget@gmail.com/
>>
>> Thanks!
>>
>>  * Victoria
> 
> I'm happy to see this finally coming. I can say I've thoroughly reviewed
> it & tested it for the better part of a year now. Since most of it is
> the same or functionally the same as previous patches I sent at [1] and
> [2]. It's odd not to see any mention of that here:
> 
> 	1. https://lore.kernel.org/git/cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com/
> 	2. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/

For what it's worth, the lack of mention wasn't meant as a snub. I
intentionally wrote this series (with the exception of patches 3 & 4) in a
vacuum and avoided using any prior approaches as a reference. In this case,
that includes the series you linked, the 'microsoft/git' implementation with
'INCLUDE_SCALAR' [1], and Dscho's dropped CI integration [2]. 

Like updating the docs & roadmap, my goal was to start "fresh" and keep
myself free of any prior discussions/assumptions about the role/purpose of
Scalar that may no longer apply to my approach. Although there's something
to be said for learning from prior work, I preferred combing through the
code to fully understand the *existing* architecture, then using that
understanding to figure out where Scalar best fits in. Then, of course, I
would iterate on and revise that design based on review comments. :) 

[1] https://github.com/microsoft/git/commit/4f553e0027190484899afba955c7cd3f1de77532
[2] https://lore.kernel.org/git/pull.1129.git.1654160735.gitgitgadget@gmail.com/

> 
> In any case. I applied this & a rebased version I've kept of [1]
> locally, and I'll be commenting below on the diff between the two, which
> I produced with:
> 
> 	git diff --stat -p avar/scalar-move-build-from-contrib-3 HEAD -- ':!t/t9211-scalar-clone.sh' ':!Documentation/technical/scalar.txt' ':!t/perf/'
> 
> I.e. you can get my version at
> http://github.com/avar/git/tree/avar/scalar-move-build-from-contrib-3 if
> you're interested, and I omitted the changes to paths unique to yours:

For the sake of readability/saving space, I cut out parts of the diff you
noted as "ok" or otherwise didn't seem to need comment (like nits). If I
neglected to comment on something you'd like me to respond to, though,
please let me know!

> 	 
> 	diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
> 	index f33436c7f65..505a1cea0fd 100644
> 	--- a/Documentation/scalar.txt
> 	+++ b/Documentation/scalar.txt
> 	@@ -163,4 +163,4 @@ linkgit:git-clone[1], linkgit:git-maintenance[1].
> 	 
> 	 GIT
> 	 ---
> 	-Part of the linkgit:git[1] suite
> 	+Associated with the linkgit:git[1] suite
> 
> You just kept this, but it really should be the former. The target
> audience of this bit of the documentation is some sysadmin that's
> wondering what this "scalar" thing is, and does "man scalar".
> 
> Let's not be cute, we're shipping it as part of git, it's not
> "associated" anymore, it's part of the git suite.

I originally chose to leave the "associated" to distinguish it from the
builtins invoked with 'git <command>' (since 'scalar' is invoked directly).
However, given that every single other "GIT" section in the docs (including
other directly-invoked commands like 'gitk') says "Part of the
linkgit:git[1] suite", it should probably be changed here as well.

> 	 
> 	+SCALAR_OBJS += scalar.o
> 	+.PHONY: scalar-objs
> 	+scalar-objs: $(SCALAR_OBJS)
> 
> This part looks missing from yours. I.e. we do this with the rest of our
> "objects", just gravy of course...

This hunk is from my series, I believe it's missing from yours (unless I
missed it elsewhere in the diff). It's also mentioned explicitly in the
commit message of patch 2 [3].

[3] https://lore.kernel.org/git/4d69e5eaccb8873eece666a3d2bb2b22abdde7ea.1661961746.git.gitgitgadget@gmail.com/

> 
> 	@@ -3536,6 +3514,7 @@ ALL_COMMANDS += git-citool
> 	 ALL_COMMANDS += git-gui
> 	 ALL_COMMANDS += gitk
> 	 ALL_COMMANDS += gitweb
> 	+ALL_COMMANDS += scalar
> 	 
> 	 .PHONY: check-docs
> 	 check-docs::
> 	@@ -3571,7 +3550,7 @@ check-docs::
> 	 		    -e 's/\.txt//'; \
> 	 	) | while read how cmd; \
> 	 	do \
> 	-		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS) scalar) " in \
> 	+		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS)) " in \
> 	 		*" $$cmd "*)	;; \
> 	 		*) echo "removed but $$how: $$cmd" ;; \
> 	 		esac; \
> 	diff --git a/builtin/help.c b/builtin/help.c
> 	index 09ac4289f13..6f2796f211e 100644
> 	--- a/builtin/help.c
> 	+++ b/builtin/help.c
> 	@@ -440,6 +440,8 @@ static const char *cmd_to_page(const char *git_cmd)
> 	 		return git_cmd;
> 	 	else if (is_git_command(git_cmd))
> 	 		return xstrfmt("git-%s", git_cmd);
> 	+	else if (!strcmp("scalar", git_cmd))
> 	+		return xstrdup(git_cmd);
> 	 	else
> 	 		return xstrfmt("git%s", git_cmd);
> 	 }
> 
> Works, but I wonder if 3/8 here in your series is what we really want,
> i.e. isn't the point of "git" to be a holistic thing for git, and for
> "scalar" to be set apart from that?
> 
> But OTOH much of the docs would need to cross-link anyway...

Like you noted earlier, Scalar is *part of* the Git suite, despite being
invoked with 'scalar' (rather than the 'git' executable). Having 'git help
scalar' work the same way as, e.g., 'git help gitk' is, to me, a sensible
approach both from a philosophical "what is Scalar?" perspective and a user
experience/ease-of-access perspective.

> 
> 	diff --git a/command-list.txt b/command-list.txt
> 	index 27bd54af49c..f96bdabd7d9 100644
> 	--- a/command-list.txt
> 	+++ b/command-list.txt
> 	@@ -16,7 +16,6 @@
> 	 #   synchingrepositories
> 	 #   synchelpers
> 	 #   purehelpers
> 	-#   optionalcontrib
> 	 #
> 	 # The type names are self explanatory. But if you want to see what
> 	 # command belongs to what group to get a better picture, have a look
> 	@@ -236,4 +235,3 @@ gittutorial                             guide
> 	 gittutorial-2                           guide
> 	 gitweb                                  ancillaryinterrogators
> 	 gitworkflows                            guide
> 	-scalar                                  optionalcontrib
> 
> You don't have it in command-list at all, shouldn't you?

I missed that part of the docs, but I agree that it should be in the
command-list. Thanks for pointing this out!

> 
> Thanks.

