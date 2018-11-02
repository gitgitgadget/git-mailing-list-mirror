Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F31A1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 16:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeKCBRe (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 21:17:34 -0400
Received: from mail-it1-f174.google.com ([209.85.166.174]:39920 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCBRe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 21:17:34 -0400
Received: by mail-it1-f174.google.com with SMTP id m15so3856561itl.4
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=65KfXby784KcNoSsMmAWNJyggYDIZsMZkI0ZZGUF6Vk=;
        b=DowEYKGYdXohEVkVAWcKukGhWIoLB74poHgwMR/odcant91tQ3yB8cs7FeGvCDG1L0
         TJ2ehhvWsrWb9nN/oFU2j9vbNwpW8RgknOMvU8fLPoAi9LHPaHtyDtDj6kyKa+WI2Tjl
         LfM6ommveIPwgWykyrjzgwb7Kz8TveHSBsycW/qxD3ITdfEeVJepN9zy9yzRq9Ch6Fyx
         tOX1Q9sDTKzBq2sIPQLQTb47fbx/uQq4EwfK3qCIN1XEvy7xwCC+Wi7nMugPL4lEOxdP
         P7dHMKeEG08H0curi/5gQMNufFZ/H2C68eFZIOLGcL7c9rUwQnPNB9tp1AOhlScVWlUw
         g2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=65KfXby784KcNoSsMmAWNJyggYDIZsMZkI0ZZGUF6Vk=;
        b=KV1Bzl+sNktbzNjiQ/1gaLYUtX0PdOfQNwpGHHxQYdxOgAlVT2eruoDbFFwT9Vyz3Z
         cCVMrxIMyfKqneLPXcxpjDGSZK141m9xbkafHXbT/cR+hhfOm7IS1RDuet6zueVrgbxW
         gOd36b9KCC6QYkiz6mhQogAjn2AudaobFibzUxZIeqVFGmFaJrE+VITBANjbHSqG1+eE
         sSnOrkytOg3u2hgjFxOmqHwqIkPgGhypWHfp7C2/Qsx8Xp//RPIhHYqt+/27TJF7mr8T
         PzLueCH1XWpTxhGYpwQ0i1VSxIqySdDV7cHgcwPsCqkZnVTK6K3eLT6h2FTorUrcXYx1
         vVtA==
X-Gm-Message-State: AGRZ1gI9RwjC2YsIIzBY1EM83QhzIwJWj8hFjy1CmOPM67LLZSK/S1gS
        QJoLw83errKr5e/YFeW46yArU8gehpkRsoiHBxrfow==
X-Google-Smtp-Source: AJdET5ca1t7VmPUOl1kHvdIUWxRFEqmvToTbx/+LkkTXmusGzVDBRnpCmt1I8fekJQX2xfItD58o0tf3y3XxjG4qaww=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr287635itc.123.1541174997147;
 Fri, 02 Nov 2018 09:09:57 -0700 (PDT)
MIME-Version: 1.0
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Nov 2018 17:09:30 +0100
Message-ID: <CACsJy8AVfkWsAP_-CNd5RSbQ=tyCzdw-ix1k5zwmAKaj+z1qXw@mail.gmail.com>
Subject: submodule support in git-bundle
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I use git-bundle today and it occurs to me that if I want to use it to
transfer part of a history that involves submodule changes, things
aren't pretty. Has anybody given thought on how to do binary history
transfer that contains changes from submodules?

Since .bundle files are basically .pack files, i'm not sure if it's
easy to bundle multiple pack files (one per repo)...
-- 
Duy
