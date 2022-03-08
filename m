Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB0C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 13:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiCHNIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbiCHNIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 08:08:52 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B16643E
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 05:07:51 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 11so15985317qtt.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=MIipkH1LEeGQ/rk5vIT/UxeehNnFDfnLH0ClJHl00zs=;
        b=A645KUWq0ZL+qBNAHAuFbx8DC64A3axsVSK4OCZXLwEGt/PpSid7fTluM0PdFmQzM5
         mKHOuc0Pga77RLQtLvAbwFzat/z4fYJji3NukV85+cAyeBVpKy7k4Gwc7PKZBYDGHJA5
         eGTPf+xv5n7EqNK65yApIaP3e3FbhTr82yy5opQPbSSl/pJ/sRH2Z9zZ7Q/v7zP+3Ft7
         vHsA066mr/tuCbTr5DysLNrotO2l87ZgE1uKGbkboSBZghQWdZLOCLPwbOpCJwwx62EH
         ukv0m6m+rPEp6gaI9QseCWBiYSzeco6yy9uZ/RpcSAKqCkzuhH0ljA6xWe51ZeLgGMhz
         /EZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=MIipkH1LEeGQ/rk5vIT/UxeehNnFDfnLH0ClJHl00zs=;
        b=Z1AvaAoGSgvFm8GoO2hkIBo+2KJeAilyW6RsZBHpBps6RhSUKiT3n7eTx72ILVRGYT
         Qfq9u4fYNpmpcCCkj0WMXz5b1oZKNTTgykow+fKQRBCQyfpwpe306Manbm4RvIvhfyR1
         8dZOkEbVjl7hIJokh7uwKeDRuAoT6tTvQ3Zv8q/gjePHLdlhTjQ57xfmqa4HC8aC7KNh
         Kj/zk5EEkEggT2gVSCy+PopLaHgiVNo/UgxhAz8v88bxybkfvWZdkEcqFxZ9lE+p0CDU
         vJU3gQOPXPyYiFkhNzC+ApLtx7nk71bOMJyYlJxCOQSI3Uk+rRxlBVU/t+fr8b2jhlRR
         4aEQ==
X-Gm-Message-State: AOAM5314KKp3ay8i4wdxRC4RUkdc1y7YJSEm5wA2dy5aWJVo0tEtwZsL
        DN+0hj6r3CI4O+SPesU6ki8G6bAMFIFZFQ==
X-Google-Smtp-Source: ABdhPJydEvHg5gvUkpW+mBLgUynvMkGMNvhTpBr5fySbespYMlY+sDYeb8GzvgNljIkTaWZEqtDMFQ==
X-Received: by 2002:ac8:580c:0:b0:2dd:d863:8a2d with SMTP id g12-20020ac8580c000000b002ddd8638a2dmr13285904qtg.469.1646744870721;
        Tue, 08 Mar 2022 05:07:50 -0800 (PST)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id r184-20020ae9ddc1000000b0067ca2630aa8sm1356569qkf.114.2022.03.08.05.07.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:07:50 -0800 (PST)
Message-ID: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
Subject: git notes question
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     git@vger.kernel.org
Date:   Tue, 08 Mar 2022 14:08:23 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Sorry if this is something already asked before...

Is there any way to remove the default "Notes:" line on git-notes? I
don't really mind to have it in git log but when generating patches for
instance, I would like my notes to be something like:

commit title

message

tags...
---

v3:
  notes on v3

v2:
  notes on v2

instead of having it like:

...
---

Notes:
    ...

I did some code inspection and I guess that using a USER format would
be a way but I'm hopping there's a more direct way.

Thanks!
- Nuno Sá
