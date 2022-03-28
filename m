Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23238C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbiC1Tui (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344947AbiC1TtR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:49:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3652B6C952
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:45:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h11so20657636ljb.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaTouNhkkua23DfeNj3GohMqayjzQcFZ6Pb4dHGoHGc=;
        b=SFkDocjYKWolHWf1U9OXCrwON3DnR7R4JBUS+R5JflkCZtxJQ8YDlmWpGzTdrTevTy
         +YexbeBqsM67bmjAOtAIf5Yw4qEvStyygqAzj8ftRRVFBqga3ePkrEUO+GkwTw/QL/ZN
         75GSVvY/ucKbUH8CBE0DTdfkrpShSVhJzRPSbFhLhpSiXSZoaumRlTry20ICtVFU41WO
         k+yN9KvpEG2ECKuFsHZiW+D3W1uNoIFA0d6Z5MHerCo64x4rixqrmSad2ueKTC7Lt3BL
         EPB4EAn/6mVre2KgbFXUWl5Zn1UNjo3uZOEWANvhZ7aVkY30sIEoIn+WHGkXehl4ImRd
         rBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaTouNhkkua23DfeNj3GohMqayjzQcFZ6Pb4dHGoHGc=;
        b=ifaJ4cAMaFlbpYoi9IGMXHjP/6Cj2NqmzoXuz9AjrH7UhPtsZr+hrYzjyEeUuBHUDV
         IUOS+mHKCU5czCbVnJEWSjES/+ad2tE/wIUaCHsG2jxvSnePVaAJWcbbHa6AFXmGQvef
         sBVr1qL4XbKqPA0+q5xE/YVucOGV0UfYbG/j8c96eBD09tmpvBIemv3K6eSbdGCswo2f
         18kMrS7WFIRZG1Q3dslHbCFEjzz59XXJ3RJQniZIC9duRgQun+Es9trm3k3V51FO5txY
         Jmp442azevy7c0cxjnpYnAApROywBwtTeMCiTjZnx2hvuxU72v1VzEWtmE3TMEx2Ed4w
         2hSg==
X-Gm-Message-State: AOAM531Q3D+CU6h3NnMTnNhaJIX09+SyO8v/jdppH63TR7Na4ZBi24D+
        nWUvnKelxpZKvT3dxABb1nJ2tijVa7yJGiq6VFA=
X-Google-Smtp-Source: ABdhPJzyPuRNyyjnvAK1arQ7hFZJ2XOamS/B8ti14JBueinF0bv7go0YgJn/feUW4XtY8WuwlmEw8ZAn6ZqHOe5Uvwk=
X-Received: by 2002:a2e:8186:0:b0:249:9dc2:9ed7 with SMTP id
 e6-20020a2e8186000000b002499dc29ed7mr22335872ljg.406.1648496731931; Mon, 28
 Mar 2022 12:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com> <6adc8dc13852c219763a9830f848fbc8663f2fa9.1646952205.git.gitgitgadget@gmail.com>
 <CANYiYbFjRMV-_opvFn78mq7tgtZFMrfPyDjDa+kyaZZfk_LmWQ@mail.gmail.com>
In-Reply-To: <CANYiYbFjRMV-_opvFn78mq7tgtZFMrfPyDjDa+kyaZZfk_LmWQ@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 28 Mar 2022 12:45:20 -0700
Message-ID: <CANQDOdfJVdCzqk-98i7E7XZN25+0ZLYPjKWOVs9YNUPwx1JDWQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] core.fsync: add configuration parsing
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 4:07 AM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> On Sat, Mar 12, 2022 at 6:25 AM Neeraj Singh via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > @@ -1613,6 +1687,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
> >         }
> >
> >         if (!strcmp(var, "core.fsyncobjectfiles")) {
> > +               if (fsync_object_files < 0)
> > +                       warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
>
> s/core.fsyncobjectfiles/core.fsyncObjectFiles/  to use bumpyCaps for
> config variable in documentation.

THanks for pointing this out.  I'll fix it.
