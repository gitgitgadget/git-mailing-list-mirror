Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9931EC7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjFGRJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjFGRJy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 13:09:54 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF131BE4
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 10:09:52 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-661fcfbafdaso229475b3a.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686157792; x=1688749792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ds/cShovVtvlgxXu9aWokHc+X9aouvMGcbRfxnUcsX0=;
        b=k+GsU1Qqv6czQwGOm77GSshH1F+xYifhC4usvPYkQzcRnCfJSOmpqLgg5C97b8VxYK
         morGFUOaXg59z/ODB8pltg3c1bGuZOXyeJWABjrKjujB5mbjXZRuUDtge0tA2rP+VINr
         aVhmx4baB1uWPfQ6H7b0wuqmxCekArGxAvSPUiAcL9U60r9ZuRRv977yKE36zqvoxg0Z
         Xp9GtiwXpeI6vf0/p+HY3Mxq+or48is05W2GtLC0ZbEKeyYirINyHFPz5PjScybTHlr4
         eE7eEcwFQVPwxYaT5ZL9K+N9OzWxcYCgyKO6B3UOD7EtTl5wu1AkjgYX/2vTxa5JxuH+
         bkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686157792; x=1688749792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds/cShovVtvlgxXu9aWokHc+X9aouvMGcbRfxnUcsX0=;
        b=IleMUNYKmdHN969lEqZV9WKqjzASAyA2abgy+OP3oprWbA9Vaz6QIzyq6u2tS4A9+S
         F+LOJmczG84V12C6gosDsvrWvw8xhS7SQwnuOFv3qmc1xlBjk6T2kcRxsDyqu1wMH+NO
         pu53q02qLU1Oy5AbrSVwmMmUm/BwAG2rLRgZqhKsfbkvjnO7lFCBIMpufyKnNoztNnO1
         unqjJmr8036lDpL5RY/lDMaabVnbh7vu7Pw0FZMoWH1pYxaBv0r5Coc4fqrDUtKTJgUJ
         kxM5gDzKvdjNnVseIpWQY1SIQ55Rl6Pv+skAo5kjIb0iAImswGyqh+6VipZcZ+0D+JSJ
         eiEQ==
X-Gm-Message-State: AC+VfDxlFwZTguvoP7onbfMyQ/U/aWHhhSLnUmgMkqanq8K2xfqrAsst
        iwLardFnQ1OeDWxFXp6V2g46fwoIi5o=
X-Google-Smtp-Source: ACHHUZ6fN8p9G/FEaes7x6tpB6sZYEUfbtUzggvojhPmX4/Lr7N0Zp8rc2RK2Qe9JjUL2hHn64h32fSoNJY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:16c7:b0:659:320e:c510 with SMTP id
 l7-20020a056a0016c700b00659320ec510mr2622129pfc.4.1686157792265; Wed, 07 Jun
 2023 10:09:52 -0700 (PDT)
Date:   Wed, 07 Jun 2023 10:09:49 -0700
In-Reply-To: <5b796f88-949c-4bba-b4a7-19ad61171812@app.fastmail.com>
Mime-Version: 1.0
References: <pull.1542.git.1686099081989.gitgitgadget@gmail.com> <5b796f88-949c-4bba-b4a7-19ad61171812@app.fastmail.com>
Message-ID: <owlyttvjnqqq.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] docs: typofixes
From:   Linus Arver <linusa@google.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> Hi

Hello, nice to meet you.


> On Wed, Jun 7, 2023, at 02:51, Linus Arver via GitGitGadget wrote:
>> From: Linus Arver <linusa@google.com>

>> These were found with an automated CLI tool [1]. [1]:  
>> https://crates.io/crates/typos-cli

> Did you run a command or a script without any manual afterwork?

I simply ran the tool without any configuration, which just outputs a
list of suggested fixes. There were many false positives, but not enough
to make the manual examination of it too difficult.

> If so,
> do you know what that command invocation/script was?

FWIW the tool appears to be heavily customizable [1]. I considered
exploring options to automate this some way (either as a script or maybe
into the CI that runs as part of GitGitGadget submissions), but have not
done so yet. I am currently more interested in reading the C sources in
this project, so any immediate automation effort in this area will
probably have to come from someone else on the list.

[1]: https://github.com/crate-ci/typos#false-positives
