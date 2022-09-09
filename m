Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36599ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 17:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiIIRMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 13:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiIIRMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 13:12:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC778591
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 10:12:44 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so1250688pgl.8
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=AUpXece88N+SfQHqKnoV6xydUuI1nqQ+cJWorhp7Jvc=;
        b=C5rkhwG0oxPUvdWh5eausGDhVjZdhBnwkaH6oEUBzDxA6bjxahWrUhHHqxoua7AM/A
         6vgIUqpLzrooJsNApZiuaSmeI5i/i+81N24ZZ9cjWs9oCK4DYSjQY4UjhrqGSpL9zeIR
         e+S6eefRzDXntYs9Wc9yHsBFEfDMR9KfW57EmIw3HSgwTi7WYaPIbV1QATd8NTI0Ou9e
         g3gAZgRZhm8om0vgTlzWdf1Ao+qn1tOOWx+tFBuktDIi0FqPx3ztZagpBTRlItMTkP+q
         ENsg0IOZDgNcyya+oG8GIptI7ZKQ0LCntep61o2iBvbjlM+S1LSMXYd5dNyBoca0lhCX
         MQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=AUpXece88N+SfQHqKnoV6xydUuI1nqQ+cJWorhp7Jvc=;
        b=ZQWftwSZbD6pFoDjwZHTg4kg5MCuGurH0ZfcfNdceHNiUNP3IQecJvllnMM619+htm
         wPXjVLLDWAz5i64Kw0hkIw8LOJ1EKSFH7JuGSKgjUm5y+EJuqdcM+Rx9IbR+lElM64xV
         C6RcGjhQhD0J0nm0ntFVqS7wfR4Rf4eO2DgyXU8qzhoVZrtuUeeFdYL8xeqZkwNS3dks
         iGv7yT/bqfTeriWzZW1y+6XhM5IE8RHPpzWVWvxE32gZNxzAW5dNvkRqvha1CRn16YyR
         qGWfvYuRehMXbu4yNKg0yzRHkPwTt7A58NSHBU0hB+6tJ+X7TVvGXcvSc79uV1Eha82/
         qGLQ==
X-Gm-Message-State: ACgBeo3ZKvgxXNJuBLA9pc4phu1cLUeyxM9umsIbBf8V/fmW2lMoiNlu
        fjxTcCUxg+eMp3zSni8qvLyP1Povv36rUQ==
X-Google-Smtp-Source: AA6agR7g36Qvnrr6oM29gBU5gIzGqvcPlt8d85KIVPvIlLBqAh83NkUZK0VMUO/fGpoUG8RAq03lKQS7dUoljg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1995:b0:52d:5c39:3f61 with SMTP
 id d21-20020a056a00199500b0052d5c393f61mr15122574pfl.83.1662743564031; Fri,
 09 Sep 2022 10:12:44 -0700 (PDT)
Date:   Fri, 09 Sep 2022 10:12:42 -0700
In-Reply-To: <xmqqbkromsfx.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com> <c249bface2a6dcd0355620f92579b42a6fa4ea58.1659722324.git.gitgitgadget@gmail.com>
 <kl6lr10l8t7y.fsf@chooglen-macbookpro.roam.corp.google.com>
 <42db9da3-3f69-1bf0-6d88-692e18eb74c1@github.com> <xmqqbkromsfx.fsf@gitster.g>
Message-ID: <kl6lk06c8oad.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 07/11] log: add default decoration filter
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <derrickstolee@github.com> writes:
>
>> It was an intentional omission because the refs/bisect/* references
>> are not part of the color.decorate.<slot> category.
>>
>> Looking into it further, the bisect refs look pretty ugly (especially
>> the ones like "refs/bisect/good-<hash>").
>>
>> If you would like to include these in the default filter, then I
>> would recommend also adding a color.decorate.<slot> category for them
>> and possibly replace the "refs/bisect" with just "bisect". Alternatively,
>> you could take a hint from replace objects and just use an indicator
>> like "bisect good" or "bisect bad" instead of listing the full ref name.
>
> I suspect that the suggestion to use them for decoration is based on
> the gut feeling: "People during their bisect session would want to
> know which points they already examined and what their states are."
>
> But during bisection, there is a specific command to give them
> exactly that information: "bisect visualize".  It is roughly
> equilvalent to:
>
>     git log refs/bisect/bad \
> 	$(git for-each-ref --format='^%(refname)' refs/bisect/good-\*
>
> i.e. show the history surrounded by all the known-to-be-good commits
> and the known-to-be-bad commit we currently are chasing.  Bad and good
> commits are at the boundary you can tell them without decoration.

Thanks, both. I think "bisect visualize" covers the use case I was
thinking of (seeing the bisect result in the commit history), so
omitting refs/bisect/* sounds fine. And if users are unhappy about the
change, it seems simple enough to add it to the list.
