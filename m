Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EC8C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 13:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiJSNqH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 19 Oct 2022 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiJSNol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 09:44:41 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA21DEC12
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 06:31:47 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id s30so25282971eds.1
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 06:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVtaHXW4qM63EFIEeLXG+N0l+nLUV2JKYQaEBM1u1bs=;
        b=E7YnTsGfOAk1QIUbwqMBVPCtkMNGbmlWNttq+fmbK9ZOSChQ401XbKaw6N1zw9ulLT
         dTCGlNWHUiDrSny9UxPbaPihHQnU6b1xiDDGg4lAbAaliOFQ5G/ajLuxoUahAVYKq9uE
         +wLkgpYgL0f9LEvHPUfW156H3cRBxYZtCvaj6NH8xtcrTRCzh9HfXzJgRH6JPP1sBbch
         vgp0CXiEmKWtPVw2fOXxOY2xLsQ9rRuEclJeRgopasILNGF694xuvOIzpGMRAj05jlMo
         kGoyedH5svavcLdg3272/7eP2DzFoHBCiGRm2BjJ4gDaEllcQru0unOxL6o9xVKC4WBK
         wA0A==
X-Gm-Message-State: ACrzQf2sdsimTrmuIVGKl5bGrWez9IDS+fQd0Yxva1DEgUoxRXSdWd9P
        yTf+xdjUmEfGHQvbuTEqdG9jHcG7jYXd8NBi91SB+FeAWxM=
X-Google-Smtp-Source: AMsMyM4ORDCw+pJTxxJFKbObmsenx8PyRnIkKtsO4tUgZ57Fmp0Zgt5GWWbRldySznkDAQ87gOjwTkIJVHDZ7SYjc8I=
X-Received: by 2002:a05:6402:524a:b0:45c:e2c6:6ef7 with SMTP id
 t10-20020a056402524a00b0045ce2c66ef7mr7721770edd.421.1666186252824; Wed, 19
 Oct 2022 06:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-15566df8-59d7-4597-b59d-2143ec978b12-1663845799823@3c-app-mailcom-bs01>
 <53a8b40f-1740-581f-e2df-709b13046ffc@iee.email>
In-Reply-To: <53a8b40f-1740-581f-e2df-709b13046ffc@iee.email>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 19 Oct 2022 15:30:16 +0200
Message-ID: <CA+JQ7M-48KZmnqFYfWvNeoFTxFrQAndwEZf7uuMxOw9PZSHktg@mail.gmail.com>
Subject: Re: Handling rebasing better
To:     Philip Oakley <philipoakley@iee.email>
Cc:     djvortex@gmx.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022, 1:34 PM <djvortex@gmx.com> wrote
>
> Perhaps git could even support the "reset-to-the-remote-history and then cherry-pick your new local commits" directly, to help the developer in this task (so that you don't need to write down any hashes and do all that manually). But even if this isn't really feasible, at least detecting the situation and the clearer messages would help enormously.


Are you aware of
  git pull --rebase
?
