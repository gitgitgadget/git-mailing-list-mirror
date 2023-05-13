Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35346C77B7F
	for <git@archiver.kernel.org>; Sat, 13 May 2023 06:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjEMGFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 02:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEMGFY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 02:05:24 -0400
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 23:05:20 PDT
Received: from ares.ptitoliv.net (ares.ptitoliv.net [IPv6:2001:41d0:303:4d9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF3D35B3
        for <git@vger.kernel.org>; Fri, 12 May 2023 23:05:20 -0700 (PDT)
Received: from [192.168.0.3] (c83-251-90-0.bredband.tele2.se [83.251.90.0])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ares.ptitoliv.net (Postfix) with ESMTPSA id AA9DBADE2
        for <git@vger.kernel.org>; Sat, 13 May 2023 07:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnieh.org; s=ares;
        t=1683957348; bh=IEBu8gBn4B2lbnSP7Rke6ICeWIJ5PnRsUBa7xVTs9oM=;
        h=Date:To:From:Subject;
        z=Date:=20Sat,=2013=20May=202023=2007:55:47=20+0200|To:=20git@vger.
         kernel.org|From:=20Martin=20Monperrus=20<martin.monperrus@gnieh.or
         g>|Subject:=20bug=20report=20git=20ls-files=20format;
        b=HdzSs4nKmqqrsRrOaC18NzDHrHr/eyZwQwZhhpWyCRghQq9ddvo9q+ArUdMzLbknZ
         U/O0phLY87koo4gDAfCMm1IHH0/aTo68Zoqk+y3S2coBPj7ZL/SnGL7hvyrJDvbCjZ
         aZVY1mVzSXorRiEMGszuuh1WzpCItbEBh8cKa6OOesJW3wdhu2+9SLxyngT+lq+HDh
         ZN2W5d1tAUb/kp8N7O9Exz1hdcEVb8Sf/2qbVnhbNEDgMqJW1RH83xtbZzgi34HzEM
         lsFaaDU7uqNXTfyxLE6yNYWHTtHyewvUsoT5qbbqHfgjGn2bcF9NvgPH+QiMPovCF9
         ljWTbkDVqEggwgga5xu24wQuUSHpjBiOwCypfRYG8MzIU4L57dx76UnsQ9YAT1jhe9
         hv4Nen3KR4EfK1gNDbWlbw1ZgH5QmgvWvjl20VhGcgurMqR00EmVpPbMHH7vS1+eby
         Q1fp7JPwl5044HNPnnVjI7Vxe2mU9MJTlBoHxOf3JlrVNc+lq0sPJuhZRloEb0FUiS
         QpRZea+31XnU2L9GBTba2m8pUh/ZyO0/B9cKZlzl92ou6Ke4J/4XqZypX9zVHaIc6+
         aBrptmFap/KfvHQpGSzAzQ6+xWJozFTiMQ/r9uFO4LHW3dxB66wiAmIaWfrNStMwJt
         4mxBk6zd6rO2r/ZRypHuaxC0=
Message-ID: <21183ea9-84e2-fd89-eb9b-419556680c07@gnieh.org>
Date:   Sat, 13 May 2023 07:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     git@vger.kernel.org
From:   Martin Monperrus <martin.monperrus@gnieh.org>
Subject: bug report git ls-files format
Autocrypt: addr=martin.monperrus@gnieh.org; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Run `git ls-files . --format="%(objectmode) %(objecttype) %(objectname)%x09%(path)"`

What did you expect to happen? (Expected behavior)

Have the full output per the format specifier

What happened instead? (Actual behavior)

fatal: bad ls-files format: %(objecttype)

What's different between what you expected and what actually happened?

%(objecttype) is not supported. It is supported in git ls-tree. For sake of consistency it would be 
good to have it here.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-69-generic #76-Ubuntu SMP Fri Mar 17 17:19:29 UTC 2023 x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
pre-commit

