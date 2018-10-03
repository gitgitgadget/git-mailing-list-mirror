Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96FA51F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeJCXXM (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:23:12 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40457 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:23:12 -0400
Received: by mail-ot1-f47.google.com with SMTP id w67so6176381ota.7
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6jLVFYDIP13wsO5LV+qMjjBCuvdoy1nYaPwZxp+fcC4=;
        b=VCf6VWkTSrUff8bKtpeKSmDKtsM0HiHWI+trI/BUBhYj2NnlABIFrTbBe+9UEddz8V
         QYq/p9JcI5uZ5T1oVPlTysY7/KzmCutiE/h8lleuSnyt6yifOtd0KvkHVpm03AkZQN/F
         HLq3SPZ20rZcTCxaeHm8nZUHQo7PS62QNR7l3kb67HWbCkU8ZshEh+HRxnEQqrsNR2a0
         Wq7xUGqVQTnRavsp8HOeWNiQHbpmtBPeJJ2E88fHo4fgddMwGwr6tvb0LJy3D1+saOYw
         exX2AesoioZ7ti4J5lxVvLUy8pOK1rw3Pz7qA7y0My3K+HBFBt0yDIpVa0dhaIydlpel
         XpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jLVFYDIP13wsO5LV+qMjjBCuvdoy1nYaPwZxp+fcC4=;
        b=o4EWzVmuRce+fW5kixzshsos0TubbDQoXBNNuaAh8a6IvS6MGY7YZ3MLtHAxr+GIh4
         NqTfoQS5OoPtHNYcwEglBUsumtvOVOQIM2DheuTFnQC5Co+pmztMJsfbRab2uqDVrWq+
         +1xVh7/AgK3thRGx8dPW7Rrsp8BaPeVnhyQR53TwitCyrMTXSQ6ql/YrwjPk9l56A0D+
         bj91fF9sSYzxFveatHdF64Qt2tUKqPf5dtm+tf2zmGmfiWGZ5kEIdMZDKWIGyxaOHCcz
         x+hDefGiT7pH64ew3b2ChF6E7KVueVdSyeO2WuBUEyL1Fl7wFDvYIjT8tjuqrV4+Qahx
         20BA==
X-Gm-Message-State: ABuFfogvCKSMd6vhLGZaZyUGmlex+2+ZHgJYIGKguUw95jFzUYPO3JFN
        JK1YEaiSlG1Mb+jhq4RHMcenYte4oJlk+CxiEZe23a7v55pL
X-Google-Smtp-Source: ACcGV600DOUCUPf7c6PoozFzpVqclNluM2uOiy+j8cG6PxqDClYvAKC9JpQwYmuu0jAoJzUM45hM+gufZclRAg3ZC9Q=
X-Received: by 2002:a9d:3ea5:: with SMTP id b34-v6mr1187593otc.341.1538584442505;
 Wed, 03 Oct 2018 09:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538581868.git.matvore@google.com>
 <bc2b3ec030650c107bd07c63f48bd874bf5f1085.1538581868.git.matvore@google.com>
In-Reply-To: <bc2b3ec030650c107bd07c63f48bd874bf5f1085.1538581868.git.matvore@google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 3 Oct 2018 09:33:50 -0700
Message-ID: <CAMfpvhKyFrYVk53Z5-qkicj5eZWT6B_JBXijPDOazKqaCia9_Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] tests: order arguments to git-rev-list properly
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 9:26 AM Matthew DeVore <matvore@google.com> wrote:
>
> -       git -C pc1 rev-list HEAD --quiet --objects --missing=print >revs &&
> +       git -C pc1 rev-list --quiet --objects --missing=print >revs HEAD &&
>         awk -f print_1.awk revs |
...
>         git -C pc1 blame origin/master -- file.1.txt >observed.blame &&
>         test_cmp expect.blame observed.blame &&
> -       git -C pc1 rev-list master..origin/master --quiet --objects --missing=print >observed &&
> +       git -C pc1 rev-list --quiet --objects --missing=print >observed \
> +               master..origin/master &&
>         test_line_count = 0 observed

I screwed up by putting the positional argument *after* the
redirection. Sorry for the mix-up. This is interestingly syntactically
valid, though bad stylistically. Here is an inter-diff:

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index eeedd1623..6ff614692 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup bare clone for server' '
 test_expect_success 'do partial clone 1' '
         git clone --no-checkout --filter=blob:none
"file://$(pwd)/srv.bare" pc1 &&

-        git -C pc1 rev-list --quiet --objects --missing=print >revs HEAD &&
+        git -C pc1 rev-list --quiet --objects --missing=print HEAD >revs &&
         awk -f print_1.awk revs |
         sed "s/?//" |
         sort >observed.oids &&
@@ -93,8 +93,8 @@ test_expect_success 'verify diff causes dynamic
object fetch' '
 test_expect_success 'verify blame causes dynamic object fetch' '
         git -C pc1 blame origin/master -- file.1.txt >observed.blame &&
         test_cmp expect.blame observed.blame &&
-        git -C pc1 rev-list --quiet --objects --missing=print >observed \
-                master..origin/master &&
+        git -C pc1 rev-list --quiet --objects --missing=print \
+                master..origin/master >observed &&
         test_line_count = 0 observed
 '
