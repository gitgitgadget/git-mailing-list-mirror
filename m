Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB167C77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 08:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjESIU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 04:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjESIUW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 04:20:22 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 01:20:10 PDT
Received: from zucker.schokokeks.org (zucker.schokokeks.org [IPv6:2a01:4f8:121:1ffe:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C5171E
        for <git@vger.kernel.org>; Fri, 19 May 2023 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hboeck.de; s=key1;
        t=1684484106; bh=5Kg8VqFkXMVkPHB8FVpcXIRZCP3fT2jfvBb1rWr5UZk=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=SPCDOZ5D1eF8VrZLhECMHJo6SVb3m+M6uNKhs+ZgYNRmv/Rqqt0RoXFYYfaHZsBOu
         0IJYmKlcqWHuJ1zM8eclOOiXh569or6mFkTj6srMMqwlMEt0MGXWWRdV22x5JzBf3X
         gzGri4taROHgaqGJwh/qg0mli0uK6dSC7Twd3IX8/5S5J3Gy0ri8f4VP4pHwO84ejU
         90f2VPI6u2IjaWjsfUCP7YYVfOtFwV/yvXe1u2TAr+cKCEo+8DAE1HhqPjLEXA0Qvw
         5EfdR/dtq1jwhgnh+d18lpXRKUgWJ9nbSEgTOjx0PqjkLeNRs3pRYPvQPS1z+OGe2+
         6MKie7KAHOwKg==
Original-Subject: git push --quiet is not quiet
Author: Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Date:   Fri, 19 May 2023 10:15:05 +0200
From:   Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
To:     git@vger.kernel.org
Subject: git push --quiet is not quiet
Message-ID: <20230519101505.416d0963.hanno@hboeck.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe this is a bug in git: According to the man page for git push,
the -q/--quiet parameter should "Suppress all output".

However, it does not. To reproduce: Create a commit in a repo and run:
git push -q
remote: Resolving deltas: 100% (1/1), completed with 1 local object.


[System Info]
git version:
git version 2.40.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.3.3 #1 SMP Thu May 18 21:38:29 CEST 2023 x86_64
compiler info: gnuc: 13.1
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/bash


--=20
Hanno B=C3=B6ck
https://hboeck.de/
