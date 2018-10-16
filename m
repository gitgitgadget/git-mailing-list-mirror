Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12471F453
	for <e@80x24.org>; Tue, 16 Oct 2018 17:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeJQBFg (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 21:05:36 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35208 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeJQBFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:35 -0400
Received: by mail-ed1-f41.google.com with SMTP id y19-v6so22110247edd.2
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wo7tTg643FVx+H1D7a+oiFbPSkhwbxEN10egzrHXfZo=;
        b=YqnCLgQ8VflAp7qTXwEflicxyzaAEFljeO7EeQdvhkRNOVZPzr6Z3wom+N+O500vy0
         7pz9+TuijpKapIos6npcStl00jMR9xddqAaBa48mAk0j6sxAF1wM9XWt8vhY2Lz3Zn1n
         C4+aTQgNbEakjWFLrieDiAdnHpYR4xJXBfll9OtpvsSzyx3JwEwJn6RSQ5Zu/4rtpG9t
         VyE509kb/vrqtM6SDAcXRXEMdXATToLkSC8uwpwLyqr4mFDxRy0smM58z6TP+25F2ohZ
         appM9LAXKBc5ap7xpTEeuYGrXqmrgHcBmFFca+cX+vJ2/MnjhSkAHhe4egVeyTXdeq/7
         vPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo7tTg643FVx+H1D7a+oiFbPSkhwbxEN10egzrHXfZo=;
        b=HVSt2wM2AdYt+Sefdeelt7JUIeCmluvxOFx4yNYioI6C8bK4acHrdyKvSdiGuAjJ/t
         z9nqNg7Gqs/QTEdYIVGAilrEmYm3xL9aBuEmUSWvgUjBjc5EHns1P0kL6SFvOd2L7sbf
         C7CQ3G2wrG0DIv3Y0+1rShJzx4HLx1RH1vzXR658EJOQmCZD2p277dp2PK6oMilbVEEf
         Bqjv3UFOFsyhsCUJez5j2dXUDHm8C3N5C61L6QyVs8IYlWMLsByE4jKjThcQ4eCuhvNO
         692rJYp+7EK1cN9mIpymvxahsBQJTsEUSaIODmfmue8/SB2x0c+Wjja9QPv4StVTHXqd
         00cw==
X-Gm-Message-State: ABuFfojwvYorzFAUVRdCnN7t/+7+G4FtkY7UjkesuxvBaqQwO/RfFdok
        Aeze00GRUP4tNkYVZztoJzCY90N9h4JhObWLadPCHg==
X-Google-Smtp-Source: ACcGV63Nq560xQqkbYFaTnFa/4CZ7Fo6ee0vNzjKP91Mk5R2sjiEuL7XB676gpBu8vO42xqjyk91Sak//WfuFm5z6H4=
X-Received: by 2002:a50:ba89:: with SMTP id x9-v6mr17597551ede.191.1539710051106;
 Tue, 16 Oct 2018 10:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com> <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
 <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com> <ca3b162d-d1c6-1ed1-cb20-4232d91f7b51@talktalk.net>
 <xmqqbm7zb81z.fsf@gitster-ct.c.googlers.com> <9521f0a8-efa7-46d7-1aeb-aea700fc2fed@talktalk.net>
In-Reply-To: <9521f0a8-efa7-46d7-1aeb-aea700fc2fed@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 16 Oct 2018 10:13:59 -0700
Message-ID: <CAGZ79kZqnbmMS_iE6hAXtA5F=_PZUrAiND1W5ictO1QMR-_wxg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 6:39 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> > If you mean "--color-moved-ws=no" (or "--no-color-moved-ws") as a
> > way to countermand an earlier --color-moved-ws=<something> on the
> > command line, I fully agree that it is a good idea.
>
> Oh I assumed --no-color-moved-ws was allowed but it isn't it. Allowing
> --color-moved-ws=no as well would match what is allowed for
> --color-moved. I'll try and look at that.

Thanks for taking a look!
Stefan
