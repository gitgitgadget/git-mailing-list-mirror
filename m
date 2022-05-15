Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5664C433F5
	for <git@archiver.kernel.org>; Sun, 15 May 2022 11:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiEOLGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiEOLFz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 07:05:55 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA52196
        for <git@vger.kernel.org>; Sun, 15 May 2022 04:05:52 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id e19so12751904vsu.12
        for <git@vger.kernel.org>; Sun, 15 May 2022 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CYD4keXjvvDEXNHGoUetS1uCp5Id+hqQUgtjmhZN6Q=;
        b=c0TGHy9BUZhuBAucFfvf7yzickrSqFpP0ZSoaLIqjj+W7ZrO0wC/M058E7QmO687KD
         mkrlelOmYdQqb19nfa+F/A3ejyZUSuOOM3XP3K1XTlCkzgO8ZS/N/mKgbq0mHt5TQYCX
         5qOQzRdRBfvuhFBq54UdmcCVDwz5ZhYYEoM0my34VWy2sAHx7vi0Mz3YOLRj2CCmJF0r
         Vs2z5Kn7WC1MBDKsyuN9FNmJwJiHWJfThZE0SRhnf1V3zpsdNnLltOru6JcMhw6+GjpD
         1el+G7QGHN5f5VCZGeQlW0WsanWDxGXT1OFiN2sc3cUK2uuEr0jS6r/JOjyOI2SPietD
         3DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CYD4keXjvvDEXNHGoUetS1uCp5Id+hqQUgtjmhZN6Q=;
        b=njug29AIxPkfnFSwzeTmK3TZnarch0QuHIvsq5EBIjm+lx6fwoO376D2XDmwCHC+RI
         V/c6U987FfgXGstxc3ITRQb7hOQhhAEe/dMn5cx9PsMoWZFsceTU6xvqbxNf48GI3Cre
         BkQD476OlzAdOsIhTiiqGbDz/yyKiF8yFIl0U4Ii46o6Qiwf/vqxivsDsU3ewhOyoN7m
         g/lywmw2nbAZ34f8Mwz5SiY9oW2+zpY5nJJ4ygP/sIatYelSyso9N+wD8jjlIyOYwmh8
         fchUJ7KhDndXQI90VONJhC4I2EZU3TP+Hte/Y1oIPNJ5hoPB+Fywy1VP9kZuq4RsRmpz
         /XHQ==
X-Gm-Message-State: AOAM530hx3Ihh7NWlcSEEJIrhnacj76fArLICcB8eo0Bd36uQ2GgMvgM
        2G78u1ysbR9DqiuFFVV3ftBGsaGwdamHuAwzkhlXuoEp
X-Google-Smtp-Source: ABdhPJz9RsWzuCrzIuAP+GWvDcpw7NvCFsN4d0sJ5U+KTlZGOfb1/BwO0DojNEvmNHDTJA8104wzaofhAMI840WUM18=
X-Received: by 2002:a67:c905:0:b0:32c:69bd:18a3 with SMTP id
 w5-20020a67c905000000b0032c69bd18a3mr5046649vsk.5.1652612752076; Sun, 15 May
 2022 04:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <7bb71920-b840-5133-ceac-664c09942772@iee.email>
In-Reply-To: <7bb71920-b840-5133-ceac-664c09942772@iee.email>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 15 May 2022 04:05:41 -0700
Message-ID: <CAPUEspjGiyUOhEZpe1bZ3EQqAruyT-WoC8xorxNfp=ktOw__uw@mail.gmail.com>
Subject: Re: sudo: git describe during GIT_VERSION_GEN not as expected..
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2022 at 3:12 AM Philip Oakley <philipoakley@iee.email> wrote:
> Is this a temporary position, as the sudo safe.directory problem is
> still to be added to next?

yes, it should be fixed once/if that branch graduates to next, and it
is currently broken in master and all maint branches as well as the
last 2 releases from those.

Carlo
