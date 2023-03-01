Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EC8C64EC7
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 10:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCAKUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 05:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCAKUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 05:20:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136B1448B
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 02:20:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso6795116wmq.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 02:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CfBw/OW3OB82NfOrwCebw51QJqAFdIhtLhmVW6DGWY=;
        b=XMP586ot8o89u7PJ9bXyqYNJlhP+H6woxgXS+Xyw0sJiUJF1yTmJwSXRFLB/FVHQJ8
         5i9ROX+9/DbGSCvtGTMpoTpiahO5Q+QPwuVyrQNVlzEnq32sdi1rSogUY29EsP7nmsjI
         hq0oCa63zUrchZjF5bRdez/zDbOsabv8Fi3tsZVMY6CdiZoX5lR5ACMLANJXyW00mD0K
         6OlGn+6i4whENXIZCH0mGy79qixWZIo4/kaVLTR/utle3Afc9w2gwYnKnPzotFwHeBE1
         FGn9vgnWhWpE1xClBIBpC/yhvtH3ss8RtNhLu/Mh0UlZMLnBR9xO6+Vsd8SNjqzLt6km
         aBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CfBw/OW3OB82NfOrwCebw51QJqAFdIhtLhmVW6DGWY=;
        b=aw/sxUGtRCv//UYU8hm5D6T/n926XjtWuxpfcb1zQOMnFOKyfRiFyclPqAsg/AVr2+
         Q0Qe1iKR93cRvpRtecxpWIB59Y3kyMfW722luDZx98HBmlkNq3J+5S7JPtMehqa6rV/N
         hSt0Z/STkBnXBEIUhF4h35giru0N7DnLGiajngE+lTseghErf696hw4y3R2vMH9+mR4f
         FFkAkJL77lag6ajo6Pw4PY+HWTm5ARyBjdKIUKlG0CWVkkZmn8pOAyTO7WGIsbgDK5Pn
         p62R5I/TV9+hvebB77zDWXKQyUPiuovrpj5RRL+Qs0T+A6HLiG9vkF3KqeADIYFSiuTK
         TLEA==
X-Gm-Message-State: AO0yUKX3/Z0Mf0WaQGqJ8ktXRkmmTi6BezyZy8+bBcJ9GcRDsTi6CxSa
        yLD/Xm0lwXvejUtkMuEcWRuAThEY/NU=
X-Google-Smtp-Source: AK7set91aQM+kTdjARU6BwPGu20T7SDfwc9D+W8Ens3Lt4kZ2olXJrhA9IfMKQQ1leiNWcf1itmPKg==
X-Received: by 2002:a05:600c:19cc:b0:3ea:f882:bb3d with SMTP id u12-20020a05600c19cc00b003eaf882bb3dmr4532340wmq.4.1677666030841;
        Wed, 01 Mar 2023 02:20:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a1c7901000000b003e2058a7109sm18571924wme.14.2023.03.01.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 02:20:30 -0800 (PST)
Message-Id: <pull.1465.v4.git.1677666029.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
References: <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 10:20:27 +0000
Subject: [PATCH v4 0/2] [RFC] push: allow delete one level ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This might be an odd request: allow git push to delete one level refs like
"ref/foo".

Some users on my side often push "refs/for/master" to the remote for code
review, but due to a user's typo, "refs/master" is pushed to the remote.

Pushing a one level ref like "refs/foo" should not have been successful, but
since my server side directly updated the ref during the proc-receive-hook
phase of git receive-pack, "refs/foo" was mistakenly left at on the server.

But for some reasons, users cannot delete this special branch through "git
push -d".

First, I executed git update-ref --stdin inside my proc-receive-hook to
delete the branch. As a result, update-ref reported an error: "cannot lock
ref 'refs/foo': reference already exists".

So I tried GIT_TRACKET_PACKET to debug and found that git push did not seem
to pass the correct ref old-oid, which is why update-ref reported an error.

"18:13:41.214872 pkt-line.c:80           packet: receive-pack< 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 refs/foo\0 report-status-v2 side-band-64k object-format=sha1 agent=git/2.39.0.227.g262c45b6a1"


Tracing it back, the check_ref() in the git push link didn't record the
old-oid for the remote "refs/foo".

At the same time, the server update() process will reject the one level ref
by default and return a "funny refname" error.

It is worth mentioning that since I deleted the branch, the error message
returned here is "refusing to create funny ref 'refs/foo' remotely", which
is also worth fixing.

So this patch series do:

v1.

 1. fix funny refname error message from "create" to "update".
 2. let server allow delete one level ref.
 3. let client pass correct one level ref old-oid.

v2.

 1. fix code style.

v3.

 1. clarify in the docs why single-level refs are allowed to be deleted but
    not created/updated.

v4.

 1. move the testing part of the first patch to the second patch.

ZheNing Hu (2):
  receive-pack: fix funny ref error messsage
  push: allow delete single-level ref

 builtin/receive-pack.c |  6 ++++--
 connect.c              |  3 ++-
 t/t5516-fetch-push.sh  | 12 ++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)


base-commit: dadc8e6dacb629f46aee39bde90b6f09b73722eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1465%2Fadlternative%2Fzh%2Fdelete-one-level-ref-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1465/adlternative/zh/delete-one-level-ref-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1465

Range-diff vs v3:

 1:  857d2435caf ! 1:  eef7bca63c6 receive-pack: fix funny ref error messsage
     @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
       		ret = "funny refname";
       		goto out;
       	}
     -
     - ## t/t5516-fetch-push.sh ##
     -@@ t/t5516-fetch-push.sh: test_expect_success 'push with ambiguity' '
     - 
     - '
     - 
     -+test_expect_success 'push with onelevel ref' '
     -+	mk_test testrepo heads/main &&
     -+	test_must_fail git push testrepo HEAD:refs/onelevel
     -+'
     -+
     - test_expect_success 'push with colon-less refspec (1)' '
     - 
     - 	mk_test testrepo heads/frotz tags/frotz &&
 2:  4dc75f5b961 ! 2:  022818f0e9f [RFC] push: allow delete single-level ref
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [RFC] push: allow delete single-level ref
     +    push: allow delete single-level ref
      
          We discourage the creation/update of single-level refs
          because some upper-layer applications only work in specified
     @@ connect.c: static int check_ref(const char *name, unsigned int flags)
       	/* REF_HEADS means that we want regular branch heads */
      
       ## t/t5516-fetch-push.sh ##
     +@@ t/t5516-fetch-push.sh: test_expect_success 'push with ambiguity' '
     + 
     + '
     + 
     ++test_expect_success 'push with onelevel ref' '
     ++	mk_test testrepo heads/main &&
     ++	test_must_fail git push testrepo HEAD:refs/onelevel
     ++'
     ++
     + test_expect_success 'push with colon-less refspec (1)' '
     + 
     + 	mk_test testrepo heads/frotz tags/frotz &&
      @@ t/t5516-fetch-push.sh: test_expect_success 'push --delete refuses empty string' '
       	test_must_fail git push testrepo --delete ""
       '

-- 
gitgitgadget
