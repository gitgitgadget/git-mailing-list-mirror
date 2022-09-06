Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14441C6FA83
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 14:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiIFOKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbiIFOKH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 10:10:07 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28B86FF9
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 06:47:11 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id x10-20020a4a410a000000b004456a27110fso1931940ooa.7
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=g3r/sp7frMzDSgZmQKiBARqy9EDKZog/51sVuvId/Zk=;
        b=Rpuk3caA08luFA/uSF1xxugYYA3ASPdT2EetsxN7xj0hbGkJCo9wMgrpqHzZQk5Sab
         QxLNvrXj7eEJooyGmaAx9tA9x4Z5NxJcALyNf9FVjOR8YcrnH9ahpT3SKOUM1Un/T3+1
         eVVMfsUZbxoIhhr6JVdAFn0ADErK0nSWblSkl7uaqV60TmNOP9vk9cmWnuCNLoVEsVbG
         /ZsAYu4NQXt8bfk9U9/HDRi/pRpDm8hUzecsmfbJ76V3WzQ+B9o3zxoUhSMHanf4I9iH
         SJp2rpQxmWM5mITaod60BiuAxHZkWN7+kmcm8KoaHw9hXthJ9zJO39TbSN3ZSjS6yHL9
         0xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=g3r/sp7frMzDSgZmQKiBARqy9EDKZog/51sVuvId/Zk=;
        b=RXsSygs9yX0BpuyE3YdhOqkDuDQNc7Pi0INbbeZ0BMIeeF+2wn3pK7NztrgmQ6GIVU
         Ykzpw8zqmS8LAeVi1/E6Etd0PcimJ6CsEDW9Tm0EeDZtGMifPPXnxMjs7fEEAFcVPEcn
         MjCokJoenJf1ycdSZeZ9lNCEDuprLm1EJrZr/THmeTdF7XOxggNZ+FOqyr2x2uXbx1Iz
         vqljobmRZsbghMki7tbO60kRkWAIxJcTKYedPh0n6yWUyhja5gQjp6gDNpQYlemEYk+B
         VtkaPnUgQm5NK1j076KtgwXcIbmSuLwC/Ds3V3EjoM//iO7qDdjLn6aOdIfHKyMi6wAL
         BT5w==
X-Gm-Message-State: ACgBeo315RZJyxmOjamv65NwGFnsVVw6Iuyw8OdJqaARRWp5u/smuW8W
        uH8hwIfSuNOJYooTy1VVfvGPtsZD4XvVsqHX7Na2PjvBuCo=
X-Google-Smtp-Source: AA6agR6mIV0PCe2XFPyzlqMZeRtI8C6PnUZQ/17ykBjRDS/2NXvIkDf4AgOKZslPjnPXNWO1PjVAGiyJdC1wkuFVzuc=
X-Received: by 2002:a4a:4847:0:b0:443:347d:6617 with SMTP id
 p68-20020a4a4847000000b00443347d6617mr18338591ooa.94.1662471953033; Tue, 06
 Sep 2022 06:45:53 -0700 (PDT)
MIME-Version: 1.0
From:   Felipe Oliveira Carvalho <felipekde@gmail.com>
Date:   Tue, 6 Sep 2022 10:45:41 -0300
Message-ID: <CAOC8YXak_QfPgxc=JWvzpaPGe9ZnFhDnR-36PrMG16qXFkQmsw@mail.gmail.com>
Subject: Patches produced with format-patch under specific config aren't applicable
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches produced with format-patch under specific config aren't applicable

Inbox
I have diff.noprefix=true on my ~/.gitconfig

    [diff]
        noprefix = true

I generate a .patch file from the last commit with

    git format-patch HEAD^

Due to noprefix=true, I get this line in the patch file

    diff --git src/filesystem/PhutilProcessQuery.php
src/filesystem/PhutilProcessQuery.php

instead of the default

    diff --git a/src/filesystem/PhutilProcessQuery.php
b/src/filesystem/PhutilProcessQuery.php

So when I try to apply that patch, I get

    $ git apply --check ./0001-my.patch
    error: filesystem/PhutilProcessQuery.php: No such file or directory

In trying to remove the a/ and b/ that apply expects, it removes src/
from the path, then fails to find filesystem/PhutilProcessQuery.php.

As a mitigation, I'm setting diff.noprefix to false, but a more robust
solution would be for the format-patch command to ignore this setting
as patches are expected to work on repos configured by different
people.

git version 2.37.3
--
Felipe
