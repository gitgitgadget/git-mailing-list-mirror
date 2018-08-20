Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB3C1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHTXBu (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 19:01:50 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33456 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTXBt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 19:01:49 -0400
Received: by mail-yb0-f196.google.com with SMTP id d4-v6so1132508ybl.0
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mP+xc+wDFZ7ELheEh7NIW0gbVA7CVTawX2ZZ6WWy3ew=;
        b=fTLp5UStDyRk9fpky6vBUafgSSfKiQ0pRptdB2UFEiBEXsrdGsYc2N4ppg0hEFAI0g
         gCZIA6LOnyL7Zjm2itUKnoZmqttXgKSb+cRehlDJVinDPDhUwdLH9/JXRTY3lvhjBJjf
         3h0+oFqYtpg6rBU70vxBC3++KZ+S9xRuqMUaHS9GKoDkRN91tGKWatUn1R+2paq3ArHR
         0B/nRSFjD4z2nmLuCbA7IFCgk8b8zfgSvhz7Ng0o57aoxZbCAN3XsoA0im6cyjwNIOHD
         Z6soQ2qIh6Pv2JKGp38lVVyaoVdLluMV/Z5aTDeNTu+7++PnntPzH2v7ALp4FAF/zD51
         hKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP+xc+wDFZ7ELheEh7NIW0gbVA7CVTawX2ZZ6WWy3ew=;
        b=pN2JvJmc4S92o9W26g5/VfMB3tYogZ/KOEGWRo7Jdt7RXwMsIX72x8PzlcehZHo47n
         tlwExsNslpNX3pI3DOD+wPJQPYoGCorFX8kb98iNtPC86Omi41ktPqhXn/ppOUlVPJnI
         iFePK7x8Bd7AwIKVPbetAwpsR+bTzvxviPR4sKhwxgZcE3PDQEfhqz+ejMrLTSHzS/VI
         5PEm7cBv3pFS3Dz6I1ktGON2j+tiaiAfTc9SlIOssycLBCJ+3CAMqibXAmwk25vWrq6R
         9Qpt9jsXo1xj6TCmUxEE+pzcQWQwOsfF35E1R+gE/VxOfBxzELOKDM95skCrC3+aYu2O
         uJow==
X-Gm-Message-State: AOUpUlGYtmcLIkgHRiF8iO2gXtNvfiSfy/gcOtGvT+hcASYJu3eg4GgS
        Km2zGM0luvjuaboFRq8glQTkW7FRfSxMtP/7oQUYfw==
X-Google-Smtp-Source: AA+uWPykOlJ8Y/sNB3IpsyFJUpHBrAiyiVx6cfRlhViT+9k+jtuWUieKvi6usi6i1xoSQQN2R6gnKo2UAtgAVU6JmYU=
X-Received: by 2002:a25:6007:: with SMTP id u7-v6mr13938561ybb.191.1534794294464;
 Mon, 20 Aug 2018 12:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
 <20180813224235.154580-8-sbeller@google.com> <CACsJy8BWTd5LEtZ00z7a1sOwx3n=RfPDqguNb+zTW0CZUUyJaA@mail.gmail.com>
In-Reply-To: <CACsJy8BWTd5LEtZ00z7a1sOwx3n=RfPDqguNb+zTW0CZUUyJaA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 12:44:43 -0700
Message-ID: <CAGZ79kYALb4=uth1mMFdYLQCz=Z0m0VJDaGe5zWmXbYNDFui-Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] submodule--helper: introduce new update-module-mode helper
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 9:11 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Aug 14, 2018 at 12:45 AM Stefan Beller <sbeller@google.com> wrote:
> > +static int module_update_module_mode(int argc, const char **argv, const char *prefix)
> > +{
> > +       const char *path, *update = NULL;
> > +       int just_cloned;
> > +       struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
> > +
> > +       if (argc < 3 || argc > 4)
> > +               die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
>
> Maybe _() ?

I would rather not, as the submodule--helper is "internal only" and these die()
calls could be clarified via

    #define BUG_IN_CALLING_SH(x) die(x)

After the conversion to C is done, all these submodule helpers would go away,
so I'd not burden the translators too much?

Thanks,
Stefan
