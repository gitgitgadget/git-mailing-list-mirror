Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AFAC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 15:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbjELP0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 11:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbjELP00 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 11:26:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC563AB1
        for <git@vger.kernel.org>; Fri, 12 May 2023 08:26:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f27b65bbf9so671193e87.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683905182; x=1686497182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgbdrf9BNDM3UfevCT6e9UgXY4bKZuoLybc17t60tS8=;
        b=sq8+TjLaPivnHCySoxAlbdHFv+067sOf+cLWkUXLJDPQXNRQNwQBMNP6lo0VKzALrn
         8wTOctevwfZrdalNaGzU3yAW/pl/xubSGeZdJWU4JVRpdjAPpZ0ClPrK4WQrr8iTwGIq
         2E2k9vMySSwTIQAov4ROaidQU35PaRqy1OMhKH+93+doNJ1+Q1t7wTz5j+DRN2aBkguV
         2iztVm+hkjej6wS0EcYxYfHRc+R37f7t342zpwDj+9QWpLDg6mC5vTU2ldw9n0kOmW6A
         D13cIIqw9NQgoqIgUxcGI8eEAFQA7vEfLuhJcaJyQ9ptnN+MPzX9hDDUG8ZNZZBEJx1t
         /zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683905182; x=1686497182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgbdrf9BNDM3UfevCT6e9UgXY4bKZuoLybc17t60tS8=;
        b=GshB0yHPN99td8KyuMR/6wQez6FPdzogFLgjXYs9vBF3U9GZd2bEr60G+ZB5rROokN
         u/zzHOn9I1hgu41Zj85sb3/JSFkVmp2GuswqGaKZmJEWemWAn98d9lcBqzqX302NyckA
         fFteAZmFd5/xM4olPmp3Chp0YcVJny6gG74clztwymJ8G0vcOjZ7gBicv3oJ0OG80oF5
         LqnD/x3nal4/zAHid4gelB26kTbxe9BoMEc/tzcrePAOZis03rc6JAwUicZNMr3Tzqvf
         Agnd6/eb9C51ZPdTwY3ELsgu1Nv9UoNr375DCpX67OqeelgX01v6dHsguhQD61ZejnPO
         NIEA==
X-Gm-Message-State: AC+VfDxLJLa82N1nLUlG03jQeY8Bk+4m4O9IoSqBp14uf2OLajZXH8oF
        EZi2jmdAKXGboTGVCT4UcArIiFiEQGQDBM/aFLFIsoQ5C2g=
X-Google-Smtp-Source: ACHHUZ501mkWiqORFsyviY1XpxeugoRRggBhhz7Yq05VY04ATsNOnjx2rkxy/dW7GHQFAcMhf+3PG5nVoL/WBqrt+v0=
X-Received: by 2002:ac2:47f4:0:b0:4ef:f3bf:93a6 with SMTP id
 b20-20020ac247f4000000b004eff3bf93a6mr4271176lfp.51.1683905181489; Fri, 12
 May 2023 08:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo7mqs7rp.fsf@gitster.g>
In-Reply-To: <xmqqo7mqs7rp.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 12 May 2023 08:26:09 -0700
Message-ID: <CABPp-BFLOpsm6wg+CidEHaQhJ4FTnszfj8SUeBWxkFZgSeJ8Nw@mail.gmail.com>
Subject: tl/push-branches-is-an-alias-for-all (Was: Re: What's cooking in
 git.git (May 2023, #04; Thu, 11))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 6:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * tl/push-branches-is-an-alias-for-all (2023-05-06) 1 commit
>   (merged to 'next' on 2023-05-09 at 1d8c3e5dcf)
>  + push: introduce '--branches' option
>
>  "git push --all" gained an alias "git push --branches".
>
>  Will merge to 'master'.
>  source: <20230506113408.61529-2-tenglong.tl@alibaba-inc.com>

This topic breaks the tests for me; it needs a trivial one-character
fix: https://lore.kernel.org/git/pull.1532.git.1683904156670.gitgitgadget@g=
mail.com/
