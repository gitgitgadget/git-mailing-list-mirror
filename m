Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E577CC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 11:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiBWMAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiBWMAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:00:04 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C28E99EF9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 03:59:37 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y11so15096650pfa.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 03:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RM/2kwB0FIDlPHj3cDD2+AADn4Qa3VDs9EhkIUxe0VI=;
        b=VXyjlz2KP8HaoHRCoEarWA/hyhDzw+bizHYdSpgV1Jlg3zZ+L/cUXXjSpiEaR0fV9r
         H6vDmZuT9QWptKI0Ke6ilFYAy3iCznVUvT1mc8JRH0T6KXFV0e52H6rNh3zBWUUztXGH
         rCXVCyN8CKhSZNY8PmPJJD6XukzeBgloBkftXN8df7Vy7HAS/seU/w9IONfbDZw6KnUi
         n9rv9kiNr+15+fkKcOOHrvtOwzOktDMZHus+SOpWKHuQk6pkWCMUO/P8RbZRxCcGDhFg
         po8myCz31DBvX3Qc/Ces+dexVIDuyJo/18NqhDVWD/+hkFiJweIQbw/JAsUvVROaD078
         T+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RM/2kwB0FIDlPHj3cDD2+AADn4Qa3VDs9EhkIUxe0VI=;
        b=NbYskK550Z7CyYadEMiJwj6JhMQJ3g70sY/9jUs4gbPnwvDuVA+hNULqEP/JuPyd/U
         e2UzkTykuahBf6qjPATPPKFq6dZyu1OcyIjPOMbbMSU2AB77w/TLIZ9tdAQa/cYXMvTu
         oDRVKl5uegPhP/xBk37NSI1lgMoYnhXdSH8WpU/m+1vtg7hBU73VJLvIcMz1QygslAPo
         8n71to8m3t38hAKJSd64IYtD6XX9/Xjc0ahmKJERpO9yHYiVilxW9fPO76/WktaeTAhE
         bIJa6wW7hPMz3bXuAgiVuLGLaJbVwAeXU9PuUCbdfmbhDGwCaZ8VsKRd0LvUWQIZt6nx
         hvPA==
X-Gm-Message-State: AOAM532XERv2XpFsEmxY9mRQyQ8qllCkIejXO/DnipP++0vAQP0mh74n
        Tmw6vNlml10oNAyeXi9QCqE=
X-Google-Smtp-Source: ABdhPJw+Ot6QIpOLAXmmrgcAGP6XmYpyYMKVKjirIODOKfa1z03GIGuKfGRDm6j1N2fJUUKXPNhbBQ==
X-Received: by 2002:a63:6406:0:b0:373:b73e:ad4e with SMTP id y6-20020a636406000000b00373b73ead4emr22499527pgb.465.1645617576825;
        Wed, 23 Feb 2022 03:59:36 -0800 (PST)
Received: from localhost.localdomain ([202.142.96.98])
        by smtp.gmail.com with ESMTPSA id c15sm19812167pfv.6.2022.02.23.03.59.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Feb 2022 03:59:36 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2] add usage-strings check and amend remaining usage strings
Date:   Wed, 23 Feb 2022 17:29:25 +0530
Message-Id: <20220223115925.4081-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAPig+cRq7H2bnkcU-V5uiWA9z=FLvxj3ji0bhO3DMX9HfptHtQ@mail.gmail.com>
References: <CAPig+cRq7H2bnkcU-V5uiWA9z=FLvxj3ji0bhO3DMX9HfptHtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> wrote:

> s/requied/required/

Thanks for pointing out. Will fix it.

> This is a relatively minor observation, but it might make sense to
> split this into two patches, the first of which fixes the offending
> usage strings, and the second which adds the check to parse-options.c
> to prevent more offending strings from entering the project in the
> future. Anyhow, not necessarily worth a reroll.

I made a single commit because both changes are small. But I think You're
right - I should split it into two.

> This list of hardcoded exceptions may become a maintenance burden. I
> can figure out why OPTION_GROUP is treated specially here, but why use
> magic numbers 65 and 90 rather than a more obvious function like
> isupper()?

Hmm, this was a quick fix came into my mind. So, I didn't look at other
(and better) options for this. Will fix it :)

> Perhaps instead of hardcoding an exception list and magic numbers, we
> can use a simple heuristic instead. For instance, if the first two
> characters of the help string are uppercase, then assume it is an
> acronym (i.e. "GPG") or special name (i.e. "HEAD"), thus allowed.
> Maybe something like this:
>
>     if (opts->type != OPTION_GROUP && opts->help &&
>         opts->help[0] && isupper(opts->help[0]) &&
>         !(opts->help[1] && isupper(opts->help[1])))

Okay, got it!

Thanks :)
