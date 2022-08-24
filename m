Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E1C3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 23:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiHXXEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 19:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHXXEF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 19:04:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33275482
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 16:04:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id e11-20020a17090a630b00b001f8b2deb88dso1747376pjj.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=3YIXfv2n83dqQIauLzHqlrJguqvrAmLzbui1MmXyZkY=;
        b=lqCqqSSYlYM66eDRxgucevKP5JBFfPBPE4HGm4UGlbUwbOcnJ9Jd1GPQXYMcD2Ujda
         Ei9lZAWlUgAYPjAg7InCu2Pr1ZE4UrGmK2cmI4eO8+7Y6xS+fHAAa1+tNOUcoQjsZ+ON
         7+X8fCiZ7HAWH8gUG3SqrfeFP/sGliR5RUPPb4gN4SxxlyWaJKBv7Pya3FCBAwCAQUzx
         T4Ly8B5vqw/iRzz8f3MMiHOO1uu8qsqLRPhdtEnsgXhRqYszc4eLqiFHdR865NdPL4Mx
         wNLF6nn2BqCmYiuAQloVtopwVVkzt+WwtWMyvpR9+2G3LuIg3J10eeOYOONJEaDRVXyw
         eT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=3YIXfv2n83dqQIauLzHqlrJguqvrAmLzbui1MmXyZkY=;
        b=prMFTW2DorkLJ6kv5/steVLK1IX09mapt0ezPqm/YmXDdfIXupCazn6yTu/LrBoh7h
         kN17rQzFlAgDLkdEtCJRN2npiLXxLgzv2UfkhLVZPPBC4Y5J6W5JmCdzKJJq3RBIkAM0
         bM0dnaeAKKj5eFqv/R3QWM37Iled5RQ1HBvtSn1TzR/N6WH//ms8xJytBG3akPYA2w4Z
         dKqJy2D/V0TSNWVEZm+oZ7jDv6WnH5dpvkKzl0oJXNzu04FIy6iCN/EUDbBc+bzuzNPu
         KZRxPQEDgu5qKjpNhGcD1NHGxGZs6vmI0KNgZGDR0pUO809OPR4vmWTSIhJb1wEfpKt7
         +f6A==
X-Gm-Message-State: ACgBeo2K+Jee76jKsZF5DBgtFfTzUtPYI6In3rOnvx5PdGXSpY2Vi4BO
        pT41A7WbhqL4trkOMpf4ZoTH7k9MUAJDfQ==
X-Google-Smtp-Source: AA6agR7lIEm5H0n5U2o/BC7siJBayycbTGXwMxWJhIFw6JQBBMut0L27alvolPTmLoUDQOW9/ucVA6Y1ZI6QBg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f542:b0:173:a8a:d7bf with SMTP id
 h2-20020a170902f54200b001730a8ad7bfmr979028plf.134.1661382244008; Wed, 24 Aug
 2022 16:04:04 -0700 (PDT)
Date:   Wed, 24 Aug 2022 16:03:55 -0700
In-Reply-To: <patch-v6-16.17-a99a7736fab-20220821T130415Z-avarab@gmail.com>
Message-Id: <kl6l35dl452c.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
 <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <patch-v6-16.17-a99a7736fab-20220821T130415Z-avarab@gmail.com>
Subject: Re: [PATCH v6 16/17] submodule--helper: free rest of "displaypath" in
 "struct update_data"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Fix a leak in code added in c51f8f94e5b (submodule--helper: run update
> procedures from C, 2021-08-24), we clobber the "displaypath" member of
> the passed-in "struct update_data" both so that die() messages in this
> update_submodule() function itself can use it, and for the
> run_update_procedure() called within this function.
>
> To make managing that clobbering easier let's wrap the
> update_submodule() in a new update_submodule_outer() function, which
> will do the clobbering and free(to_free) dance for us.

The only feedback I had on v5 was on this patch
(https://lore.kernel.org/git/kl6l5yj7ubpt.fsf@chooglen-macbookpro.roam.corp=
.google.com)
where I said that update_submodule_outer() seemed like overkill and that
I'd test an alternative.

I tested this approach

  Assign and FREE_AND_NULL() update_data->displaypath [in
  update_submodules(), but outside of update_submodule()] since this
  is the only caller and it already does some prep work in this hunk.

by reverting this patch and applying this one

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3557665261..c932c857dd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2486,9 +2486,6 @@ static int update_submodule(struct update_data *updat=
e_data)
 	if (ret)
 		return ret;
=20
-	update_data->displaypath =3D get_submodule_displaypath(
-		update_data->sm_path, update_data->prefix);
-
 	ret =3D determine_submodule_update_strategy(the_repository,
 						  update_data->just_cloned,
 						  update_data->sm_path,
@@ -2593,8 +2590,11 @@ static int update_submodules(struct update_data *upd=
ate_data)
 		oidcpy(&update_data->oid, &ucd.oid);
 		update_data->just_cloned =3D ucd.just_cloned;
 		update_data->sm_path =3D ucd.sub->path;
+		update_data->displaypath =3D get_submodule_displaypath(
+			update_data->sm_path, update_data->prefix);
=20
 		code =3D update_submodule(update_data);
+		FREE_AND_NULL(update_data->displaypath);
 		if (!code)
 			continue;
 		ret =3D code;
----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

Then I tested the update_submodule_outer() version and the
FREE_AND_NULL() version by marking t7406-submodule-update.sh as
TEST_PASSES_SANITIZE_LEAK=3Dtrue and diffing the test output. I didn't see
any meaningful difference in the test output, which should mean that
both versions fix all of the leaks in "git submodule update" that our
test suite can catch.

For good measure, I also tested a version of my code without the
FREE_AND_NULL() call (albeit on v5, not v6), and I spotted the expected
memory leak:

  Direct leak of 10 byte(s) in 1 object(s) allocated from:
      #0 0x000000000000 in __interceptor_malloc ../../../../src/libsanitize=
r/lsan/lsan_interceptors.cpp:54
      #1 0x000000000000 in strdup (/lib/x86_64-linux-gnu/libc.so.6+0x000000=
000000)
      #2 0x000000000000 in xstrdup wrapper.c:39
      #3 0x000000000000 in get_submodule_displaypath builtin/submodule--hel=
per.c:119
      #4 0x000000000000 in update_submodules builtin/submodule--helper.c:25=
85
      #5 0x000000000000 in module_update builtin/submodule--helper.c:2716
      #6 0x000000000000 in run_builtin git.c:466
      #7 0x000000000000 in handle_builtin git.c:720
      #8 0x000000000000 in run_argv git.c:787
      #9 0x000000000000 in cmd_main git.c:920
      #10 0x000000000000 in main common-main.c:56
      #11 0x000000000000 in __libc_start_main (/lib/x86_64-linux-gnu/libc.s=
o.6+0x000000000000)
      #12 0x000000000000 in _start (git+0x000000000000)

The CI runs are at:=20
- FREE_AND_NULL(): https://github.com/chooglen/git/actions/runs/2920894120
- update_submodule_outer(): https://github.com/chooglen/git/actions/runs/29=
15661611
- control study: https://github.com/chooglen/git/actions/runs/2915671776

If FREE_AND_NULL() really plugs all of the leaks, I would strongly
prefer using that (possibly in a "goto cleanup"), over introducing
update_submodule_outer().
