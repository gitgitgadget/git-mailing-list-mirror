Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6A9C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359054AbiELWIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359053AbiELWIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:08:32 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FC5280E04
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:08:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id fu47so5563631qtb.5
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=SQgdtv/YjLbXH86Hq08MEB18WWytDLYDDSms3dc/EmE=;
        b=gWdGuWndMEBS6Ntd1lxDcrMgz2yOKi+HKVS92Le1CMaEt2F1CHE7BI9Xmqell97OJ4
         FjxHZDLZr21QCYD4u96W/NJ6zG82ubFHcMx/96ShEXFwRhLKaEAh6+hUir1FhX5bvU7m
         dqX76vfIiGOMV0tgcGstGx4Zki5dCGCCKuPCIp/RgcwzhOlXT5yK3EInvXF0X1OqNWpk
         d6XcusPmjhic022K32mrguKkAmayd5lgi+uQfKupC8JUWd1r34vddm/CmTxy9IWW9VQ1
         0kE+bv5Lb8z5EPRc2CV6g5KpUf3Q545HMtNGWQO+HjkSqvO9DUESF8g0nQTP1x96vs3d
         msRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SQgdtv/YjLbXH86Hq08MEB18WWytDLYDDSms3dc/EmE=;
        b=8RciTZDqFYH11JmjGrUxkaccZAbYLpK8DQpjkBJaBHmJvw6vWm+YugkkWX9psms0Pz
         OBK7hA0TML8HaC6DFdkSjuaKUJ6v/b9ACwKag+Smu/vJxvP6c7D1jOxUixC1Kv7u6guI
         kakimd+RRsergl5SSVzYgLjISx9KYYkQ/ux97R8/ZEZ3qSiBVm+knLF5MSIdvjSkezrB
         S/q7WTypqoYHGAbiWsU3X3FLjTvsiyc6TRjU7CoE/j64X3mSY4pZGpaIR94y33+vPJ6U
         hKJFBNotEEPuBpYvysEQmRR/EXF90OLCAr6hFA1J6KOETlngUiFIKzpjgXa6qIkaLMV0
         y6Jg==
X-Gm-Message-State: AOAM533LBR1gGFN+gOLxrfJujwkeZrPNx9VivC4J1vDAl5Wv23yiLcAs
        LAMsLtS3EVVc8lbJ+aH/9y0ydKpDVC8Ece5lrjtKO48owB8=
X-Google-Smtp-Source: ABdhPJwIc8MZ5RRYMgkA6Jo/CksxlrtZtaCAfrLTmQJuNjys0h4RnV/d7Rc8H4R+swALMd4aToaPvhaAiByLyBk7OkQ=
X-Received: by 2002:a05:622a:148f:b0:2f3:b46a:f197 with SMTP id
 t15-20020a05622a148f00b002f3b46af197mr1929144qtx.233.1652393307295; Thu, 12
 May 2022 15:08:27 -0700 (PDT)
MIME-Version: 1.0
From:   Tometchy <tometchy@gmail.com>
Date:   Fri, 13 May 2022 00:08:16 +0200
Message-ID: <CALihXsDEJBrvt08F5SnNoFkQ21nJixnb7b+L_arAJCV6pWWKyg@mail.gmail.com>
Subject: git restore --all
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi I suggest adding "-A / --all" option to restore command which will
actually do
"git restore :/". It will be consistent with "--all" option available
in "git add" command :)
