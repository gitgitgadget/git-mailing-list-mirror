Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F723C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiDOVF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 17:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiDOVF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 17:05:57 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D178AE57
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 14:03:27 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id c7so5024481vsq.13
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EwcQ7d602Cj1xkMMbyOfhnAXea0AI9HEv632K0Xa6kk=;
        b=QBh7pbARPDbtkHsQ/b/8F6UTeXso8ItqVKV8mMjX1Yb+JA4q7vkR6qfi7Iuxuo61++
         VKAXU6tJIbEE6QZUjRYCKBZeNXPKsV3en8/XuDDpUv+Oz3yYq5ICx/1cz+a3YYaQl/50
         re+BnDv4AGXZbL4Nf8kzjIvJux3ff+htcGzcehHLX+GEWzCyu0c4AGX4fF4jSiIO7wHD
         hz1WYAEqcJO8Q0FSnYv/uRc8+dIysFDskeEcgmQF2tixzjc8YkoGsv3DCdEwsFfif3MG
         E/ufwovmIq4N9eOo59DalUh9pxB3pYOXtQgLw6UQg75ScZdnfuvwLxlv8KLjNZZPsym0
         6yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EwcQ7d602Cj1xkMMbyOfhnAXea0AI9HEv632K0Xa6kk=;
        b=CYFL0ehmOjDcO5ZQiJvXbhXnpnnN0rrUwgrk3tIPB0cH7sUS1+Vb2EC2SG5Ap1oO0l
         RfpMM55ul5rHVyjBOPrshlxxt4e4rMxlx8RcDCQQDglZa8aaYbXvjom8YOXk5/l266Gh
         0/gIWb+M1mYAHXMhIc7F/TXNXidccCxC8oJZdmxVNO+wkQrENrnxqUF7BqO7yxKFOmXT
         JttWg/dhoKwHgZJ/XUpi25hNF2Ed9v36WR0/V+a43KORbLw22aC2jx2ee80wjmEEprOv
         Q+fU8g+HYwv9g81NLOmJ53E3Xr5PkkEfO1bT3WTqAKh2TbEHT/YBEoiOfRk2D7HOtGe3
         3Opw==
X-Gm-Message-State: AOAM531+yczar6D/EMJaTlDCYEXS4bg2dGzVT3+PlND/HlGyS5VCCUSB
        uH42H6j5oep7rwoeEuYaKuq6eri2RfgoFihpxnsr2wk2Icc=
X-Google-Smtp-Source: ABdhPJzsKcL6+Z+UzHopBT8U/1nAc+H4syFvK4xaezQjzyY2d/902xsIbmclLlOUGwaDdTiZEg/SI/NMARBMc+TgX6M=
X-Received: by 2002:a67:cb11:0:b0:324:fa43:1408 with SMTP id
 b17-20020a67cb11000000b00324fa431408mr226652vsl.5.1650056607061; Fri, 15 Apr
 2022 14:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220415123922.30926-1-carenas@gmail.com> <xmqqwnfqci6f.fsf@gitster.g>
In-Reply-To: <xmqqwnfqci6f.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 15 Apr 2022 14:03:16 -0700
Message-ID: <CAPUEspgsfn71JEM5mdG2u9vO6YgEhvdZqtixW9kVyOetqz8RWQ@mail.gmail.com>
Subject: Re: [PATCH] ci: lock "pedantic" job into fedora 35 and other cleanup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 11:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > Fedora 36 is scheduled to be released in Apr 19th, but it includes
> > a prerelease of gcc 12 that has known issues[1] with our codebase
> > and therefore requires extra changes to not break a DEVELOPER=3D1
> > build.
> >
> > Lock the CI job to the current release image, and while at it rename
> > the job to better reflect what it is currently doing, instead of its
> > original objective.
>
> Please spell out what "original objective" is, why we are changing
> the purpose of the target, and how such a change is justifiable.

Will do in a reroll with the objective of "let's make the pedantic job
more useful" but that is IMHO less of a priority and orthogonal to the
objective of this series which was "let's avoid breaking our CI
because of fedora's gcc updates".

Original I had that done on top of ab/http-gcc-12-workaround (which
fixes a real, albeit likely harmless bug that compiler was surfacing,
and that will also break our CI in a few days) but after the feedback
from this thread, think might be preferred and also less likely to
conflict with current seen.

Would that be reasonable, eventhough it is so late in the RC cycle?

Carlo
