Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3851F453
	for <e@80x24.org>; Tue, 19 Feb 2019 16:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfBSQve (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 11:51:34 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:37634 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfBSQve (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 11:51:34 -0500
Received: by mail-ed1-f53.google.com with SMTP id m12so17321552edv.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u+wkIivKCfARh+UzqFXSF5Zg8t0zBjbfawtnxOy7lOU=;
        b=e4MoupaSoCvr+62f3QKh6F9B63iMRqjw+WsPg039BZjZPyTobEPRWPoieaB6MnTUiV
         66pMmk8q5Wn9VRm3ItCzIDZFtF/0lv8vZN9/YcJWc2wnqVqbigowXMClStXWIAKd/EPR
         2Qca3G1tBQN4A8kInjKvhEYPOyHnqcPdNApWyxBSnLglguJGqBGlXdcGHYAZkuL/zXwi
         /vMNRwj2nXNS/OR+4zrZsTYoWss0BVfL8LRRxo7l3wpcmXQMT2vfZgnskCKCc6jvu7YY
         meBvr5tLE9xTgunay29LHQKtyG9O1MIclBsLdDfMN6hsSnewMB8mFsla9Jf05l9kjz3Q
         99uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u+wkIivKCfARh+UzqFXSF5Zg8t0zBjbfawtnxOy7lOU=;
        b=pyg1+Zr0A83OrVSX9jWbb8KaVlNaZ99a6guVRCZRRoHuXgrBxh4TVcoak91WQNHFL0
         jzYfoZXVNO1mBXhuOOVDsrBLkASuTpHhMzUynTuKJqRR+L1Lfhqj8sl+iQXW8rjXUOcZ
         7v2UkwnX8UuXoXWkjknT7aVtpIrEAdE+8OdIbtNOflVw/EQFh2Q4c7EXGJ8iS4Rncbxo
         7r1cduozjbJTxlTJQHQ+Kf5LzWpTtszOAG12GIDZNQxBiOZFlhjqBj5EzGEdFw6rPfn1
         mNC75C2vv18su3LZNfTbQ8GO96Wce3JAOHFGXch/aSOEnaiWL38Zg/7FY0WYVUo/WccA
         UHJw==
X-Gm-Message-State: AHQUAuaZ7xnD0BivOkG26FadtEmh+RIyPMk8HShamC0ezkOoHVUNEVeH
        7M7RVvTe2m2XF2h5Gzn6Ar6qipJ29BshasRpqs6MsS05irTFzw==
X-Google-Smtp-Source: AHgI3IYiMi4QQf+I3IfYGgYNEoa8uuO1sMcF2Zhn/MqFoafT5CPeXLxsAQc3Uk9jpUoTr2RB66N01MSjeL5v3wfSvRM=
X-Received: by 2002:aa7:c153:: with SMTP id r19mr24088621edp.139.1550595091910;
 Tue, 19 Feb 2019 08:51:31 -0800 (PST)
MIME-Version: 1.0
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Tue, 19 Feb 2019 17:51:05 +0100
Message-ID: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
Subject: "Submodule registered for path" output with config aliases mixed in
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

$ git version
git version 2.20.1.windows.1

I'm running `git clone --recurse-submodules https://XXX`
The command seems to run well and completes with success.

However, I noticed strange output from git:

```
Submodule 'Binary/A' (https://XXX) registered for path '!f() {
~/AppData/Local/Fork/Fork.exe $PWD; }; fBinary/A'
Submodule 'Binary/B' (https://XXX) registered for path '=C3=80   =E2=99=82=
=E2=99=A6Binary/Intergraph'
Submodule 'Binary/C' (https://XXX) registered for path '!sh -c 'git
log $1@{1}..$1@{0} $@'Binary/C'
Submodule 'Binary/D' (https://XXX) registered for path 'ls-files -o -i
--exclude-standardBinary/D'
Submodule 'Binary/E' (https://XXX) registered for path
'mergetool.TortoiseGitMerge.trustexitcodeBinary/E'
```

I managed to identify where that garbage injections come from:
from git aliases I've got configured [1]

Could anyone explain what is happening here?
Is there anything wrong with my ~/.gitconfig [1] ?


[1] https://github.com/mloskot/wsl-config/tree/master/git

--=20
Best regards,
Mateusz =C5=81oskot, http://mateusz.loskot.net
