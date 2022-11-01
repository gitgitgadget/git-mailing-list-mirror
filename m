Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC21FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 03:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKADz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 23:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKADz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 23:55:26 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C2113FBF
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 20:55:23 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13be3ef361dso15589531fac.12
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 20:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AAKqVKguR7R9C0R7HDddmQjzj+WlzoHuFea/IudIwI=;
        b=mKJY2wA+36OEAYf4RoJi49vWfOUso3Jm5LNfLY7ZgR1Sf8/jMDbtGS0WOKUF46J2pV
         QLlc4yOwzhzxZJ6wQUerCBKSclZQmggRmeSeSIit/vmKeNkqkXmarsnWJvoMplRMcTEg
         8LEgwrMCoASXA2Qn5SwjvHzPuSEkXZxkv6oI7IfBl7ZJndjgolnjSlzN5YPcU+NhIOEN
         sxlmLvCneGth7dvCGFx/X24wcdcbBkZIleUUsf7pd9DFgWy6vE4JCTCyKxmJhjlDvvih
         O0qBB2YZIrAKf9Poyq4PrmiV66D2Pa7WPrszmbj0FMQiyk/IO3oFA658cy9A39pFaT+K
         hO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AAKqVKguR7R9C0R7HDddmQjzj+WlzoHuFea/IudIwI=;
        b=dL+UHAIQFskB0aU49IMOJblstXWkAKHC92ohR+flF6+YL3CjcIUrmR7osiwowuc1Rn
         2WqaqIcNchQ461aOVguyqv6U6uNnvpTvm46jLlPXOAjxxts7nuL5e5nn7cl9OVzQscDB
         gJOk+Qmfl7OqF4Rjm+roHWH3wLIJwoXEXO2vNU7RyZ8+iWd+6OMTsXRCucj3D16B7eio
         eYyWaBBuBivWzhjjNEZpdlG3eqwml6Rg5UPip27AQz3/MQiyOYUYIUgzKFy+zPgGfVYe
         NjAO3tVeUfBjESbaXPyVW9PWHnAcYkEsUDDLufIOjo5Vm7ALYZecAjLBRJq0uc3mAnIK
         vmPA==
X-Gm-Message-State: ACrzQf1uHw6G0/Mup6cEJuf2FFeWfiTy9OH7MF3TjTUKqRkUcUuEru+g
        emU6fiLmzoy5QRIRyV5Ykhf9t7VLVqbQWUiXn6c=
X-Google-Smtp-Source: AMsMyM5Ez1ATMuhZWSTyACzyPneMulJ7W+xayhZralRU+Qcqf8Do1c5F2XJepsAU9Id6yisZpt+k7ZA+/pKmd07xowI=
X-Received: by 2002:a05:6870:8091:b0:13c:50b8:23de with SMTP id
 q17-20020a056870809100b0013c50b823demr15106855oab.183.1667274922719; Mon, 31
 Oct 2022 20:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com> <xmqqk04lmagy.fsf@gitster.g>
In-Reply-To: <xmqqk04lmagy.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 1 Nov 2022 03:54:46 +0000
Message-ID: <CAGJzqs=PovTFeVFJAT1HLcKQxHdRjozUACh3Z-x8ih6yuYSb7w@mail.gmail.com>
Subject: Re: [PATCH] Mention that password could be a personal access token.
To:     Junio C Hamano <gitster@pobox.com>, peff@peff.net
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 27 Oct 2022 at 18:40, Junio C Hamano <gitster@pobox.com> wrote:

> Also, I wonder if the specific "it can be access token and not
> password" is something worth adding.

Personal access tokens are ubiquitous nowadays, maybe even more common
than passwords since GitHub disabled passwords last year. I wanted
to acknowledge this in the docs, even if Git's own behaviour hasn't
changed. Maybe the introduction to
https://git-scm.com/docs/gitcredentials would be a better place to do
that?

     Git will sometimes need credentials from the user in order to
perform operations; for example, it may need to ask for a username and
password in order to access a remote repository over HTTP. **The
server may accept or expect a personal access token instead of a
password.**

[1] https://github.blog/changelog/2021-08-12-git-password-authentication-is-shutting-down/
