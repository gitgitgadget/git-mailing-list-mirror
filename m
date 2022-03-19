Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6425AC433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 18:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbiCSSKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 14:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCSSKh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 14:10:37 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA0515B3
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 11:09:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2dbd8777564so120487397b3.0
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=plANITBDmc09ZtLWm8wcq6nI9Pu7RGoao1F6Vj7Lvrg=;
        b=EDWjcmquIfPmJS+wkh7r2MuWK/ZimTVJ9Q4J1Z9TVVrArmuCMS+pHzCmiwiR0vKVKv
         hcsD02Z0RFWkrJZCuNv6kCZquCzgCRSmUjZYFPc0uL6LCAqtcJ3EJAa8QCbvzmGzt60E
         WEH5nEMGhr0mom1p25gTTjHlnWf4n2E5y9K3x6eKCaFU+145w9fRdvEloz10uz5hZ/2v
         jlU/mnfsxKD/UuNFe3RRVKQZFYBQU8YS+aMboels8sQGm6r9S/X1XTrCZ+rL+mFkJdcM
         G2togWdQ0q03DPUe3xIXc8G8gteDB5xzYoTgSz1bd/x5ZnlyVoKSkfaiA//2AxFK6D6n
         Ic3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=plANITBDmc09ZtLWm8wcq6nI9Pu7RGoao1F6Vj7Lvrg=;
        b=xsw+UrII7Xnoww+J4JJqOWkBxzRZpddpZqMWKxh5pUahvwme4UN0U7RFjX6ySX5y4X
         DHi+4AlGDVxd/+WJirBRhbfqf+f6WJa0uScj0IZhWATAN09yZLpDpKj1kwC0EWgB1cCm
         XsLaVCdYt0e52i8MsBWqYc7SZ+i5qqRWcROehrQHNbKyW3LhqMhLVTuiOE5JW2rmv5Bs
         2odcTYyjIZKe2WtbcjiknaQBrXRk+vjsIE15E87PiSEkPLVPa4iQWC43jCF+ARQary53
         aYU3QzRQLuytBRLEQCDkpb4rk6kApkIXx1QXuk9cjxjRCzh5Ux/oUzZXsc7Yf7MCKN/H
         CcuA==
X-Gm-Message-State: AOAM5303VzvLTgS6/nx6YDqLtlNr7f6/Y2IeXwsqlDaD5e7NQwF7xnVB
        xWlDxR8fQNzFLQ2twS4zQFywexzADpmYmHsuecmnDZepsDU=
X-Google-Smtp-Source: ABdhPJz7ObVWEMNI6IttcOVMdxOYQ+qkGtK4bwc0Vwq9FyCIODy08qn4S2sR9K6AbX1iPXDq+U8um9ZQh/nVwNlOQsw=
X-Received: by 2002:a81:7054:0:b0:2e5:8ece:1a88 with SMTP id
 l81-20020a817054000000b002e58ece1a88mr16377568ywc.16.1647713352904; Sat, 19
 Mar 2022 11:09:12 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Sat, 19 Mar 2022 14:08:37 -0400
Message-ID: <CAGTqyRzeYqXT_HXKZ794XmtD7HodvHEQeK3efUw=Pb0ObLvXPg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>* jd/prompt-upstream-mark (2022-03-03) 4 commits
> - git-prompt: put upstream comments together
> - git-prompt: make long upstream state indicator consistent
> - git-prompt: make upstream state indicator location consistent
> - git-prompt: rename `upstream` to `upstream_type`
>
> Tweaks in the command line prompt (in contrib/) code around its
> GIT_PS1_SHOWUPSTREAM feature.
>
> What's the status of this one?
> source: <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>

Hi,
I'm the author of these patches. I'm not too familiar with the
workflow and I just want to make sure this question isn't directed at
me and you don't need anything from me right now. =C3=86var provided
initial feedback and FWIW I think these are ready to be merged.

Thanks.
