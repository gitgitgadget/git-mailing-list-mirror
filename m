Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21BDC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 06:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiKPGHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiKPGHw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 01:07:52 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCB21251
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 22:07:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g7so27965000lfv.5
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 22:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRUdPcFD36YqLGUQANdAu/ZDZMEUpuDxUsvdckH7KuU=;
        b=EPfFxL3mtUkbFsqcitVQYkN/hD3wDkY/uUfuXJLdZ3JhVAH9CinANj0ADDILTdJcNR
         l6RjbAiuSzMF5m7Zw57RYlNB2+GZC8gpmKJLE1ONum+dkwpivKU5cpTm/BTYRAXwBnvc
         oESDXrR8pAKrH7ZIGbK71bhUzqnQp6B/JLtQBR37HYiT08tzbRvh7oYSgUDoxZI1ihFB
         4GwxFBoX2bMQGZjvnxvx/ItqeccpTxt/9lOhT4iVeX291iSNrfwljxaMVkiHNCHMvPav
         uwiHO83+9wwt9smBqR1dShY5defMqZVXj0kdarSKHugg9V0jUl4eKKgFphw6St+8vlzU
         VG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRUdPcFD36YqLGUQANdAu/ZDZMEUpuDxUsvdckH7KuU=;
        b=dRub+Pdovw7CMwkEzuX2lLKWxirW2yCtJFUyGteDW+u3fYjgApvmZtZzh7WnuUfiJL
         o/9bQidQiKl74F44XJbc/4dD3kd5+2WmWfgezBaWe+yiELryWVM+m7JrceAdjX0Nc4ff
         soyGmVechWeYAjieb/8yJEnBoV0mrAH7Oh0OEmo+poO0VkrFyJevJNBLtS9eXlzMXwAW
         +DF8vvdxXrwjZlxr9/TH+c8hahy7E2HYGe14+p9Y2qBC06Y/hu+JRz+CF1EEIC3QzwGE
         ax7knJxX4Syfhg8dC8HXXp7V1je+LM7uX9QJtDkHfEoK0BcWs4gREazn/VbSr+r/021m
         64Bw==
X-Gm-Message-State: ANoB5pnw8VoIeRXDjHwKuBaIKKKfJ++496/1YV9rHu8yI1DuC2YhkNgP
        rVS1FBYruEi17iy6mQDFkk1PQC+44+iCnzwRN4s=
X-Google-Smtp-Source: AA0mqf4leUzdcGtzvo1OIxITCxDj/6ab/0giEdSvw4tA0qiJ0u1v0WZmUz/RAVk3WnMdcV47Jg5bjRE7yI1jrLPRMHQ=
X-Received: by 2002:ac2:5cc3:0:b0:4b1:3931:af with SMTP id f3-20020ac25cc3000000b004b1393100afmr7559129lfq.394.1668578869808;
 Tue, 15 Nov 2022 22:07:49 -0800 (PST)
MIME-Version: 1.0
References: <Y3Mag8qG2D3qjlmg@nand.local>
In-Reply-To: <Y3Mag8qG2D3qjlmg@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Nov 2022 22:07:37 -0800
Message-ID: <CABPp-BFJDYpOyAz1XGjqu3p9NVwQjFLta6HCux2y26TvLw5kjQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2022, #03; Mon, 14)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 9:26 PM Taylor Blau <me@ttaylorr.com> wrote:
> * en/sparse-checkout-design (2022-11-07) 1 commit
>   (merged to 'next' on 2022-11-08 at 42e164b490)
>  + sparse-checkout.txt: new document with sparse-checkout directions
>
>  Design doc.
>
>  Needs review.
>  source: <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com>

Labelled as "Needs review", but you merged it to next...is the label stale?

If not, Stolee reviewed and said he thinks it's ready to merge
down[*].  I suspect we'll still have some discussions (and I just
responded to some comments from both him and ZheNing), but none appear
to be things that necessitate changes to the document.  And I suspect
discussions are naturally going to continue until we have everything
implemented, and the design doc is a pretty decent starting point as
it is.

[*] https://lore.kernel.org/git/f3345a9e-e7f1-4230-d30a-0608eb69513d@github.com/
