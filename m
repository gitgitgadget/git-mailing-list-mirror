Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD470C05027
	for <git@archiver.kernel.org>; Sun, 19 Feb 2023 10:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBSKkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 05:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSKkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 05:40:23 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E91025A
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 02:40:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s24so1547306edw.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 02:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JkqI9tociuWoImAhZyHflH0tq6p5KZIqSE91yIxlc7s=;
        b=gRWYdcMPm4biVZO+c8bZagQAqp14r5JldK7/3ULokWYJzyIfaET1NciQOG1BIBX0p6
         R7s5wnC3cr6zVUWbFpVxhME82SMuaNrFvnxJXk1kD3ABjc151XEDhGhOl/7yJ09F92UQ
         Ej2UjMt/vsP+hF6Z304UCUsM0cwHRTbIssaAzmvW2HgL3391pGFBhyuVg6NBlBhcTtlE
         G4nCpWdX1iB7sEC0u4aYzMePOPiL3ruHZRoShX7tG58E45cWLNDnSLLZgnjuiEP76vP/
         DkUmyQvNJZiaXDkNay4oM2fN7qh/L3h2PUATHbZq70gDgh3oOb9a6LSpew2f8nmzQJbi
         B/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkqI9tociuWoImAhZyHflH0tq6p5KZIqSE91yIxlc7s=;
        b=PHI7eqfywipUjvytsiWgi6grZurNo3Twa1zgnRg3+xqlOllilLWWwslUJH896gL1rK
         7Mp1qMAwaTfgdHbAPttCc8GmV7bGPDrlXE/sb4frIXwi6gAtcKstD04JLRXWzCj/oV/S
         e43PQZC0hIwXwGU5oRyToGc1umzh6J3GozgHbNzBjKaSVY4nSW+qEOrkrV8xXqHaz2xi
         BvtAm5pnp15/6ZJ1jL2012WImp/2twWNOmL02zySY1pupFQj7rEWHpSXBRj5XvOkNvMc
         8pzDpHpQ6VDcVipLuABT46H+f36L+HdZKYdiuZAVAmjpIo97/cKOJnU++TS1wQOdBWf5
         iI0Q==
X-Gm-Message-State: AO0yUKWYuLpYlG0JqJ1kZv+1JeTXTA8hi5GL8mwk1KSMIDUf0faAskSn
        pVq/5Yis9xaQpdwLp1DhVHs9bPfSXQTBCkJbiTs=
X-Google-Smtp-Source: AK7set/T609TwGDlDQCBZ9sobq/6/kYU1mJhBVb/XMqVedM1M7DWFAzLkzsqMvrzwIpivr7UWiqZNYVSvMq4YPxa7hI=
X-Received: by 2002:a17:906:938b:b0:8a5:c8bd:4ac4 with SMTP id
 l11-20020a170906938b00b008a5c8bd4ac4mr2560728ejx.15.1676803221044; Sun, 19
 Feb 2023 02:40:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.606.git.1587412477.gitgitgadget@gmail.com> <20230217172035.79864-1-five231003@gmail.com>
In-Reply-To: <20230217172035.79864-1-five231003@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 19 Feb 2023 16:10:09 +0530
Message-ID: <CA+CkUQ9AMFc9DHE1tknJvX_XhuezoWvWFSXw97FLwdGHVGXWHw@mail.gmail.com>
Subject: Re: [PATCH 0/2] [WIP] removed fetch_if_missing global
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI,

On Fri, Feb 17, 2023 at 10:50 PM Kousik Sanagavarapu
<five231003@gmail.com> wrote:
>
> Are you still working on this? If not, then I would like to take this up
> and write the tests, if it is worth doing. I think it would be a better
> exposure of the codebase and would be helpful for GSoC.

I'm not working on it. Feel free to take it forward.

Thanks,
Hariom
