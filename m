Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE95C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 08:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D6461006
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 08:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhD1Igl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:36:41 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:56373 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Igk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 04:36:40 -0400
Date:   Wed, 28 Apr 2021 08:35:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1619598954; bh=NNK9MOP748vwwyt51F2s0ghbGG1YCGWlUZBiEWbyLdA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DQ9Tvck+erUdgD06wj61jl/9NkSlrCeNFAnQYc5E3WckvENxRFYb2+sH8i8Cp7QCd
         kbGJiYRXcsp9n7CpcsWtOlAhr0a6Xvd6xYcchJyKaObH/Wc3QQ8rDgYn6YWhp7NZu2
         mlF0U+rEsIpdKC6jvo97RoCZJ4H/XGnaG2pwz8u+OQM4VxfymePvNYQE8xyV9JVN6d
         ae3CZL5ebG9ZVpRyHtoLluSPzeKc5lRL9JCWL0tIwOTHuQenwKWLAIjcxWF8WdmBWo
         fMG/YnvdaRZLin51IOHIGg18Vf05y/YEdRmLzCqgCfxrb/vfyNQZZe6d5w/2rocYqT
         DHHbi6QmNkrXw==
To:     Johannes Altmanninger <aclopte@gmail.com>
From:   Robin Moussu <moussu.robin@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Robin Moussu <moussu.robin@pm.me>
Subject: =?utf-8?Q?Re:_Request:_`git_restore_$commit_$file`_shouldn=E2=80=99t_override_uncommited_changes?=
Message-ID: <I_ZK84DfFkUoO9FcqjidSjmsvktNt-k4tPiAGNIP5ztKjk0RQCfFmyRrRHaB414UaWsJO7kWPBcgHlRqAecH7r9mAj0TLm5k6T5_YzmiZ4c=@pm.me>
In-Reply-To: <20210427192906.7obdkopxwajqnv53@gmail.com>
References: <pYZzGPZTHnJjYBKrUAVGcso74I_xJgfzNpSwDN94fhYcDoOamp62-IFvxVrU056uw0txy3MTHYSwny_II0XY4trSY5_E25q7EXwhNHjy3VY=@pm.me> <20210427192906.7obdkopxwajqnv53@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I effectively did a typo, I meant `git checkout $commit $file` or `git rest=
ore -s $commit $file`. I forgot the --source in the `git restore` command.

> Is your question that you expect a command like
>
> git restore --source=3Dsome-commit some-file
>
> to error if you have uncommitted changes (to "some-file")?
> And instead you would run
>
> git restore some-file
> git restore --source=3Dsome-commit some-file

Exactly. If `--source $commit` isn=E2=80=99t specified, erasing uncommitted=
 changes is what I expect. I scream-up, and want to start from a fresh stat=
e.

On the contrary,  if `--source $commit` is specified, I would like to get a=
n error if $file has uncommitted changes. The reason I want to error when `=
--source $commit` is specified is because I most probably didn=E2=80=99t sc=
rew-up, but just forgot that I modified the file before copying its content=
 from another revision.

Robin.

---

Should I wrap my text in 80 column? I=E2=80=99m not familiar with plain-tex=
t netiquette.

