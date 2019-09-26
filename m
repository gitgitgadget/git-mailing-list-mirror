Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EB71F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfIZVR7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:17:59 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37685 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfIZVR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:17:59 -0400
Received: by mail-lf1-f41.google.com with SMTP id w67so281499lff.4
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/YbzlGrIqHSVsOx2TF38NdbZDKmHkaZCa6WIvSe7fk=;
        b=XHSWRaS0D+bGKjsWdlok3qzyz91EfxypjaUMdGFU9TAi2iJXGPlKuM5km+UISsLpW9
         5Ori2kYUIbXkDNUyGlEHDSi/Kd4PC1a4We3Fusbnod+Jt5F1R0W7H5MCOysdNqFtjoI5
         jIOjNv05a9dPJMArzfES4cd1O0c2fokmUglP7PfhCs225p2/Q+IYnzwEhoInBuLp9W/N
         yPENxu3nlOs2S7wweN7BIIvR8Ub/iR3RakXfoSRG2Gm16jV/uWgAHYMXraFGaKdb4kdO
         l+7xDLX02qIiaMQRcFVbxPXKjgKljIlSsm6yRb1FzbBWKZMGHDP6cLl0XGae31shZ0DA
         Jz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/YbzlGrIqHSVsOx2TF38NdbZDKmHkaZCa6WIvSe7fk=;
        b=TUo5aIp3vBZf5HqqH5Ks83oolOVv9XFfDVlR8mc8GSLJTqX8YTucq8qobNuB0xzGsW
         L2C4dIjFXLR9RCsZxnsbbxNxEz+GLE5Gnd2klKZ2QB4XvX5sSmW0ASyeffhzyQyQOGWX
         KZheAbZFzT293nP4/+sUD8aHRxkZuL0m7uketsH7/yPHxsfRTTx+SuhF3Jf/dCvDubE6
         prW4U6hboFKvMRyEp0DSwSP885mKaoYi75VvowxRCZz3xXdauR4XTScgFDRbnk5Talnj
         hBXXCmT79kkhbuBv3E0eOFbROoOUsaOkee9PdXW3d15UGD4Mv+oyrPG8XXY91njLTlfq
         JfAQ==
X-Gm-Message-State: APjAAAVrz7/6RrWpPHhU8eF4nYSUtSzSEcOAu46Rtu8VR8VimbefUlFS
        +Ov7p2gO3t8bow1EO3ell+/tJ8/DzWPbwVtnIVE=
X-Google-Smtp-Source: APXvYqyNV8mlSch2jPRabMeee+wxyFTJKrsohWmp2zv1L8hVp1CsG0qQveyrgfqr6l90xyhYAmIL5FoW+vJM0NVbK84=
X-Received: by 2002:a19:f801:: with SMTP id a1mr346254lff.166.1569532677551;
 Thu, 26 Sep 2019 14:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com> <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
 <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com>
 <20190916180059.aifw5r4c4k5o5hur@yadavpratyush.com> <CAGr--=+SNO7GuHH-dE_ZnrJDCa8tv8EA5LMrVGwsMTRpxhzEZA@mail.gmail.com>
 <20190926193004.jspiirmb4ejxznjo@yadavpratyush.com>
In-Reply-To: <20190926193004.jspiirmb4ejxznjo@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 26 Sep 2019 23:17:46 +0200
Message-ID: <CAGr--=Jiu-haHMX2fc8AB1uGWT1OMw5=M3_CuGWVzrYmO0uq3A@mail.gmail.com>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 9:30 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Why are you changing the Alt+4 binding?

I couldn't really find an easier way before.

> This means your feature won't
> work for people who use the mouse to move around in the UI (which I
> suppose would be a majority).

True. I would much prefer that the staged file is selected on commit
widget focus, regardless of how the focus was changed (hotkey or
mouse).

> Did you try binding a script to the FocusIn event of the commit message
> buffer? You can do this like:
>
>   bind $ui_comm <FocusIn> {your_script}
>
> I'm not sure if $ui_comm is the correct widget, but you can experiment a
> bit by printing something in your_script to find out for sure.

Ah, that's pretty neat! I'll play around with that. Thanks, Pratyush.

Birger
