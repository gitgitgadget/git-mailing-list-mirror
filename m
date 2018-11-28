Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2BF1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 20:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbeK2HEZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 02:04:25 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33469 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeK2HEY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 02:04:24 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so5525883itk.0
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yP9EHwEO2JqGNm/r8Lj1MFmYRJKkhxi3WNmaycNQVA8=;
        b=LCvxO79IKEuXfc4KpMLAcdnC2pUrAvZk7ezIGZsJqGlyib3mxaaGrByIP3Mv7IPd4f
         s1Y/ULuisK94xJn8kIYH554zWFGfzuWH6c3sl6/VpVUQoL9FJlkg3YYMQskclpep/Ke3
         WHFIoraOd7aJilRA+6bepfiGTUjeJQ9T6fOIEegfq5W2HsEYTQuPg4nloU9I/qgrrwud
         uP8bJHf+K+XG9kZzqhGMVVQoqnz5h36ReE+kXCYx2uzh+mqaNz6p4umJB3pX5tH3+c28
         NJ4wgKPWgnvCYTnpmgmX2cPM0waDHMnTHt5AtfEgTXbgBkT9j26q4ttUWcs2j+Djz9Wn
         vsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yP9EHwEO2JqGNm/r8Lj1MFmYRJKkhxi3WNmaycNQVA8=;
        b=DlkGLQDAZ5rkgVU9m6NrA2MidsY5ZVXG/6+kVU32jJTBwpmSV9AIhzzAvW6R1uFDwZ
         0ijKKkwx4mUrleOvZ9gX0cmglLP295nkdy45FDXSbqFw62ZXF6E97+IOkUZS0iiPTtSn
         yyY17t+zVhAQxirfXFladBgeWe3gu5tPXwBCpsvgJRyhK0D8hpFzY9GRIemm09KlSEm0
         f0JeuJ7cKJ5rsCOZWczkDdWn1s/SFXiFOC8FMEzIjqVkc+/RDc9mTkgZi8UTEFabZ1fY
         3SDwJmgSmQwF7QFaW0OJVGgOl0vBGbZSijDprJc5elVVDsTgXpm68nVmWy29Ir4StJYM
         QVig==
X-Gm-Message-State: AA+aEWYkUbMArARpEUAD3/zHKxjKSh7F/E0JY/1dmdpmHbp6v6/TO7r9
        /W3cXRcV7FKqQTNzzBOlQABnNPwIgU/99UKKy9Y=
X-Google-Smtp-Source: AFSGD/Vgtf1NrhU/agE4prCkDddUS2QSul88vhLSrAGo09LpG3mshDk6PZT90R4RkqJLaDOB1SlDldlFuLLBkaJXoso=
X-Received: by 2002:a02:8943:: with SMTP id u3mr33213991jaj.92.1543435296599;
 Wed, 28 Nov 2018 12:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 21:01:09 +0100
Message-ID: <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 5:53 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> v2 is just a bit better to look at than v1. This is by no means final.
> If you think the command name is bad, the default behavior should
> change, or something else, speak up. It's still very "RFC".
>
> v2 breaks down the giant patch in v1 and starts adding some changes in
> these new commands:
>
> - restore-paths is renamed to checkout-paths. I wrote I didn't like
>   "checkout" because of completion conflict. But who am I kidding,
>   I'll use aliases anyway. "-files" instead of "-paths" because we
>   already have ls-files.
> - both commands will not accept no arguments. There is no "git
>   checkout" equivalent.
> - ambiguation rules are now aware that "switch-branch" for example
>   can't take pathspec...

Another thing. Since we start with a clean slate, should we do
something about detached HEAD in this switch-branch command (or
whatever its name will be)?

This is usually a confusing concept to new users and I've seen some
users have a hard time getting out of it. I'm too comfortable with
detached HEAD to see this from new user's perspective and a better way
to deal with it.
--=20
Duy
