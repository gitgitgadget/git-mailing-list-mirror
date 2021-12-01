Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC73C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353637AbhLAWel (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353625AbhLAWe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:34:29 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB88BC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 14:31:06 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id a2so25648750qtx.11
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voiceflow-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=beZkwI2gjg8fHGrSO2AqDGlho/yYx+ZCfoZXGRx03bU=;
        b=eBTuqFTYYv9eYAY7anI2YetFeeVLK/9B74zc5DDMaT8rrxUgDSSWhuwvAZT/r/N0zn
         hs3jhnQ1PIOwrGo64a4D/La2Wvcci3honmEOsuTv10cwiDUcIpW8VQYrfOCgX5ClsjuK
         zm23GiZsrp+O7wDNfZxs+89ggQCy6Su/Mpdf1b2c8UIhjJ6hskp8vWn/6zu4Nd6MxBc2
         /s+o3hCwbaucyny2FdRVK0hAVLHA34eVMU7tpVD3KbHwVDWurfXnnPP4e4FLyVYNZ/x8
         WG+oQTDfIb7FP+RomWCquZPISDmgsTYYxA/JEwcxCRk+pwychaw/c5+j8LEQXl8+R4fz
         TfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=beZkwI2gjg8fHGrSO2AqDGlho/yYx+ZCfoZXGRx03bU=;
        b=TbPJeK8jhJl6/uJpRzHxihIMKPcWn1DaFUachpmpxe93AfljOYsgfb0i7wSd+0UuSE
         h0+DKqhK909mRTOxEc5kxjfiQOyw7JVycLlKweMgVyHURIZGhWPeTXAW2ffcVSYfImRZ
         fgw5MX9ozC8JoItd4h2GokjLaYiNNEeXx3jqK15meUgGlkXo4v3aUG8Grecv7jVdCMGV
         w2ov5dpCK0QUlhBch24e+ZKoT3MnQHfSJoxn5411FvUh6ULldK6wmetN+hG7v3htLGZX
         gm6WzH5MS5Bj4Lt2J6K+1jtJHHJmQrsVEiDP6OZSHTEsKoAJr5+po1tb0MaI+KBWjH7u
         zW0w==
X-Gm-Message-State: AOAM533AYyXvyliZ8yK1Ls+hpO+QuU/OZ/AiwMUBKyXWEPTAUVd+aNwN
        pe6pec9lP9HnJ4zeAkj0u5Kr95KJeC+1QQ==
X-Google-Smtp-Source: ABdhPJyroVoSQ4tdPag3ZAvuefA4hJnyt9rcBlxYXrfx1pPbrLDzzZKrNvtqTt2p/MIpZ/zwkP7DjA==
X-Received: by 2002:ac8:4e28:: with SMTP id d8mr10256765qtw.11.1638397865071;
        Wed, 01 Dec 2021 14:31:05 -0800 (PST)
Received: from smtpclient.apple ([97.108.238.149])
        by smtp.gmail.com with ESMTPSA id k2sm577609qtg.35.2021.12.01.14.31.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 14:31:04 -0800 (PST)
From:   Josh Rampersad <josh.rampersad@voiceflow.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Bug Report
Message-Id: <C29F5770-5092-40A6-9604-DA5F7166575D@voiceflow.com>
Date:   Wed, 1 Dec 2021 17:31:03 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Navigated to a non-default branch of the repo.
I wanted a list of tagged commits for a specific tag pattern relating to =
a
package in my repo.
Ran the command: `git log origin/master --no-walk --grep=3D'my-package' =
--tags=3D'*my-package*' --decorate-refs=3D'*my-package*'  =
--format=3D'format:%ct %H %D'`
The output was as expected with the tags not relating to my-package =
being filtered out from the output by the decorate-refs option.
I then, wanted to pipe this output to a separate program.


What did you expect to happen? (Expected behavior)

I expected that the piped output would be the same as the output in my =
terminal.

What happened instead? (Actual behavior)

The filtering I got from the decorate-refs flag was no longer being =
applied. Thus giving me a bunch of tags I did not want

What's different between what you expected and what actually happened?

Whether the decorate-refs option worked as expected.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.31.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Wed Jun 23 00:26:27 =
PDT
2021; root:xnu-7195.141.2~5/RELEASE_ARM64_T8101 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.29)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]=
