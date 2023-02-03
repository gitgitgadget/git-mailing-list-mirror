Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DA8C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 18:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjBCSXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 13:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjBCSXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 13:23:01 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EDAA9121
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 10:22:59 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id k28so3372367qve.5
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeQsLTpZE2WmsicG7bfDW0YxM+z+ua41aUm/FBgEqqw=;
        b=JLNbiRjejYJsnr9GDTFDVkYgaR/0Xt5vOfdJkvR0D6DSUa4OQfSdJ2OZZAzRGW28XS
         vzcUDpM3jf04TAnmBz74xcaNED7vGPGzrnC/GnqiwyKKD+gTHs77KYebEadWF8UKdFUp
         q+cVf6z3v24k1OQBFyGQNNRpJIukJZWABY6Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeQsLTpZE2WmsicG7bfDW0YxM+z+ua41aUm/FBgEqqw=;
        b=JYx5GW/JLzCWctg5pScwRLHmBgBXr5fuzZI/YDThhqPNeukjXLtfBP9WZPTo/gvzbo
         pARcz5QJHzpcQM5m+LdSfr+oE+8GjM5ei1nzZaTaAU3K3M7j/Dv6ihSRnqp20qJrqBhi
         3CJJlenzkyeKR+xcpR5ixvBo6HM5/8a7/MqZb4pQ5cmOYlnI2+g86Udn8/v+mE8up2Yh
         jlHn2w6Gl+tUjWxna7NDpPPQQKpXLppjgHnkqyLDKesZ4O28NlTgnuHDUX7r+DahMNMo
         h3VpuaWKk80NEO96y7o02CR7Ec5STmsB0Mt6Vzo+dW/QRqnfZCkUJGRrf/GqiEPr5SyN
         DAcA==
X-Gm-Message-State: AO0yUKXZziknCB743DsTB+4/OjAnBuhV5B4kW2GZhIuCdYVrlix519IQ
        FW1Tf+5WYMzvf16uT39ReW5An5pYavtNJJxW
X-Google-Smtp-Source: AK7set+UqTT1Fkx8DYxBO6MNuPcYuApqnRI1bE9GZcBKb+Z3w5AqloCwWAT7NARp8SJIKiq3nOa8Tw==
X-Received: by 2002:a0c:ab04:0:b0:53b:38e:3782 with SMTP id h4-20020a0cab04000000b0053b038e3782mr14359881qvb.18.1675448577953;
        Fri, 03 Feb 2023 10:22:57 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id o7-20020a375a07000000b0071b368cf074sm2242428qkb.118.2023.02.03.10.22.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:22:57 -0800 (PST)
Date:   Fri, 3 Feb 2023 13:22:55 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: The sad state of git.wiki.kernel.org
Message-ID: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, all:

There is a very sad and unkempt wiki instance running on git.wiki.kernel.org.

It grew up in the age when Internet was young, bright-eyed, and "anyone can
edit it" approach was seen as a net positive thing. Then, as the armies of
bots and SEO consultants became increasingly difficult to fight off, the
instance ended up being locked down just to avoid having to spend all day
rolling back spam edits.

Today, most information found on the wiki is probably outdated and therefore
potentially harmful. I would like to solicit ideas what to do with this
resource.

# Should it be migrated to RTD-style docs?

We have stopped providing new Mediawiki instances at kernel.org quite some
time back, replacing the offering with Dokuwiki. Today, we don't spin up new
Dokuwiki instances either and everyone is steered towards readthedocs-style
documentation instead, which is a much more sane and manageable medium than
wikis, especially when it comes to technical docs (see
https://korg.docs.kernel.org/docs.html).

However, it's unclear if this is even needed for this wiki, considering the
existence of https://git-scm.com/doc.

# Should it be archived as a static site?

It's possible to turn git.wiki.kernel.org into a static site with a large
header on every page that it contains historical archival information, with a
link to https://git-scm.com/doc

# Should it be archived and put out of its misery?

The last option is to just archive the site and put it out of its increasingly
irrelevant existence.

Thoughts?

-Konstantin
