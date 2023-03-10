Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266DBC6FD1F
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 11:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCJLi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 06:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCJLiW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 06:38:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62B70423
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 03:38:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id k14so6192198lfj.7
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 03:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678448295;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo6vEfJHdNFYaBLeFv7TfA26LqDZxdg/Gii9pI987IQ=;
        b=IW5/yIw1f2yrDEqBmejUVECMVgTUIpCM6uQ7bci5wKuDGcy/CzUWC9iKWBValRvQ9O
         T7vqYtid14th05NAqAJUGgL2DmiJmgQxNpGptaQUZpMjLKut22guGy0A6tq23t63RuCF
         ENBUUrkeQhBsNO6QeS93Qw4kK5BphZxHSzkZyucdXP54UureXDZamaiD1e+oRFysG6mx
         Q3BQ/FFoaz/d3OObfhi3i2/GlI2BL4LHBoVtr63Yc0Iigzi17pXqYzl4Njw/5l/i0aXj
         aw00REuQpV0QfhBSuX9AVqrTZnz5yzF3FcAcuIq3mVp8HAsKtOKTOTWjIF5udgkUHEcf
         gDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678448295;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo6vEfJHdNFYaBLeFv7TfA26LqDZxdg/Gii9pI987IQ=;
        b=3tqjhCMq3aHC+e4SmxBY+OwvsbebOe9tolRnmFLHzZikCvvCiYAfQ/jMP1xXU/qzHS
         XVawZk1gpwMrkawFHxsINv7y2BX++P87IGBeuuOUuFOxPi5E+7lO+MVOR/qSZUZy+zcA
         N7uetEvSK2Ai4roxXzvgCWIbKRajbPe5M00XkllEHV7EjkAdRos4LQkkeaQkoUyE87kY
         XUZj58nhFulbIsQOusAduw5PZGKUOZCOfWI8ya9Dyqa8YJwICcticXCbxvaJsDfiRtWm
         1MBBDZIygwaXqczeeiYtzTRBypFRYAa921YyQaJ5p+6SHZMHHHLzkdmH3YBz4qAmtOYl
         dhEQ==
X-Gm-Message-State: AO0yUKVfR9wlZ28TdfjzB4nI9VfKNL7d4kTcYfSZJLVxSkc824pj7dtK
        0IieTUdQ8ymocwn54Gj8Vmn11Tbxoyp2F1G7FZ8sf9/w
X-Google-Smtp-Source: AK7set8w3aJcG/I3j9YmPxH5LxiOEs06qTDiJgUFjvgKtN8KfsH4+485I/W4QRSQTK2nT7GwZd2OJ1WWgAmLtXUoGrA=
X-Received: by 2002:ac2:4827:0:b0:4e1:dbbb:493d with SMTP id
 7-20020ac24827000000b004e1dbbb493dmr7942328lft.13.1678448295672; Fri, 10 Mar
 2023 03:38:15 -0800 (PST)
MIME-Version: 1.0
References: <CAKc7PVD_65vB5+meeO3xcu4ASbqr85LBGUO8Ntb7SvbO+NNHmQ@mail.gmail.com>
In-Reply-To: <CAKc7PVD_65vB5+meeO3xcu4ASbqr85LBGUO8Ntb7SvbO+NNHmQ@mail.gmail.com>
From:   Sebastian Gniazdowski <sgniazdowski@gmail.com>
Date:   Fri, 10 Mar 2023 11:37:49 +0000
Message-ID: <CAKc7PVA14_mjZeuED1Ee0Mu5YoCSrR4FNNhSEKFHmnKnc-gESQ@mail.gmail.com>
Subject: A nice, beauty progress metter for Git Clone + a feature request
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check out: https://asciinema.org/a/566216

Feature request is: add a pipe={cmd} option to git, that would just
pass through the git clone --progress output into {cmd}. This is
EXTREMELY EASY TO DO SO, ONLY

FILE *pipe=popen(cmd_option_str, "w") ;

is needed, and one can then write to `pipe` file handler.

-- 
Best regards,
Sebastian Gniazdowski
