Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBD2C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 04:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjECEca (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 00:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjECEc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 00:32:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A481FF9
        for <git@vger.kernel.org>; Tue,  2 May 2023 21:32:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5932627e87.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 21:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683088345; x=1685680345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6fMi/Nq26ow66NpzO15B1n1QHUL0n508mOu4QfG8JY=;
        b=RX7fp9HF6jejCRvEh36mBY5s8TaYO+zDceIPKrTsDFRzAzxcdaOhy7qD8Kf6jESTja
         pm4/fvckWCFQZ9am6pxbz5gCcmVrEtcGEx106c7BQDvrs+AHwsYAYDG00lbLjs/G15pT
         b63K4BW4CuSTRuybNQ7lL33veZDY8qsftrKMTjtjga6gpZ7ihu384TVDh9DuDyI1JPfZ
         dxS73hcoYI+3XchxdZwDOf+kCy1r1YZ1N7QwVhXux+a9y2V8yvdAY1xl4q8R1sMWRG4x
         THvQ4HqEAxbDKVGSEEKt/GgSmhrSzqjVXTGiqCAFUXkGboYtZ4absh6hNnwa4HZqNBjd
         7eMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683088345; x=1685680345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6fMi/Nq26ow66NpzO15B1n1QHUL0n508mOu4QfG8JY=;
        b=awQ1iTiraNIUKUgl/PAyCQ+457RuIrZr+qXfnpk19H/yofgdyQ7zacTG0YaD7ZdaKM
         LFMW9Not2qZmdXbam2qflm6j3jemymlpEZQh8N1v0KbMVbIzQ0xX0NJjaVeM5vDc6Z3q
         KXKRBhHDMNu5bPP3wg45P6rZPoVVYT0WxsHwjpL2eBFJBr/DsY5LsbFHxSoY09ZkPM8F
         d8dh66qtGPKFVYrw7nzYmwdZu+TwESOOIi/UrA0h+LJdZt/lTHHsvyfX6h1Wrd9g6pHu
         fdQfVbiOP/30R/8Gz/ABlNaYs7o9TcLbMO44LYPyIvVFm6zAgokr+tPYy3cIzULyON0F
         3rMg==
X-Gm-Message-State: AC+VfDyWCi1PjUetblW/QMNxXT6C6qd7/LpM8HZP5MM2Gvar63t2UGCO
        DgGfrlAFnqJwMD0ODrP9pCyHAvCoAlFHWNBUuGA=
X-Google-Smtp-Source: ACHHUZ6PmNZb5t6Nd3V7ImCo5wMpa3dAx7UfRV4JT+bg4ZfDKukYPcJq/8BjoUCZYDnXkQXPL4lkNL+dJ7NfOev4Nzk=
X-Received: by 2002:a05:6512:207:b0:4ed:c537:d0c2 with SMTP id
 a7-20020a056512020700b004edc537d0c2mr654526lfo.69.1683088344969; Tue, 02 May
 2023 21:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.862.git.git.1601888338644.gitgitgadget@gmail.com> <20230503000932.153612-1-sohomdatta1+git@gmail.com>
In-Reply-To: <20230503000932.153612-1-sohomdatta1+git@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 May 2023 21:32:12 -0700
Message-ID: <CABPp-BH8Mw=Fi8heF9C9g3M-wX+FyAB8FzVR58ck2zxgrdHqbw@mail.gmail.com>
Subject: Re: [PATCH] docs: clarify git rm --cached function in gitignore note
To:     Sohom <sohomdatta1@gmail.com>
Cc:     git@vger.kernel.org, sohom.datta@learner.manipal.edu,
        gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, May 2, 2023 at 5:33=E2=80=AFPM Sohom <sohomdatta1@gmail.com> wrote:
>
> Hey maintainers,
>
> Friendly ping regarding this patch (I assume it slipped through the crack=
s).
>
> It would be great if the change could be made to the git documentation, s=
ince
> it still is a common misconception amongst students that merely adding a =
file
> to .gitignore will lead to the file being automagically ignored by git wh=
en that
> is in fact not the case.
>
> P.S: sohomdatta1+git@gmail.com and sohom.datta@learner.manipal.edu are bo=
th me,
> that email was used by me previously when I was affiliated to my universi=
ty.
>
> Regards,
> Sohom Datta.

Yeah, looks like it slipped through the cracks.  The documentation
change looks reasonable to me, though given the time that has passed,
the context region has changed so it no longer cleanly applies.  Could
you rebase it and resubmit?

Also, while rebasing, the "isn't analogous" part of the commit message
feels like it misses the mark in the explanation, and the body of the
commit message would be better worded in the imperative tense.
Perhaps change the main paragraph to something like:

Explain to users that the step to untrack a file will not also keep it
untracked in the future.

When you resubmit, go ahead and cc me.
