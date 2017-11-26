Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFF020A40
	for <e@80x24.org>; Sun, 26 Nov 2017 14:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdKZOAw (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 09:00:52 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:32992 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdKZOAv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 09:00:51 -0500
Received: by mail-io0-f174.google.com with SMTP id i184so26210693ioa.0
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 06:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xmOzwIF+amx2THxg/6gVwA9X8rlSYpwNrT4tu/BDsQo=;
        b=uyAUMDrzOOsQkFVm1QtiNmP1h3Aly03wGlZ5mDg1FUu7yvBRb5veKwngXyqfSDbxW6
         Fm9soV9zuYwFnX/MCzRnrBSYULYyCmmrF/oD45ChjfifDFB/Zco8FHpae7dOjQsPNgk+
         kr9qpt/e4vrbW7PwDixw6W5AtnxlMd8sFroo3rd4jPkMqno+TkEXvwWmBSj/sSJZzhyf
         Kf1lYqUtFHQzbBy8oV7fe0a9OeZUbzj118lBuqNiYAuRl+b0so6FGdxhhrLB3vsTlZ9c
         +M4I0eQwmogSowhCU6g1e7oFc9ZXBEvxb1rw+YzI1C5tAVkbSqqDIBuw6VB9btmMrU5H
         twgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xmOzwIF+amx2THxg/6gVwA9X8rlSYpwNrT4tu/BDsQo=;
        b=ocT6a0m+9HzV7AhjtJwRksUxnXSaHytpiZhuAt9nb2+JDuWxvREg8/bMCpu6ssQVRl
         +MPqMGo+HXsnA2NPIzOwVsNK8nbVcnP5TfmeSchBihnfccJLpWS+pVe/ueyxaTKEGo2X
         DoH1Bm6+Ryc0ter5ZYMhmwU/CB1n9YCmkvIhecGOdb+1k0JVeAJkKneISOE42q3pDWWz
         XaK+s2QxlfjsbSu1gIQdJPCPMn9mnvEKp/lbC8HZkT+vJWW4Lg+alWV1OZbrZ7NRT2YQ
         SMUHmDjklZekdhEGt/JB4Gvtn5kwq8CjJKw9AqdZBgZML2de5p6leh3fJjQZ4npA5IQH
         cGuQ==
X-Gm-Message-State: AJaThX7Ev9IgXJS8D9P0ITPAl/opE1jm7VSz+mH/gZbJcGYTBSZhyzZb
        83fv2ggRlgbIsBaZ9WRvoyFxV7Hn8ftqDpozk8I=
X-Google-Smtp-Source: AGs4zMZjxFJuCHS18Xuna1TgyS+YryiAsQXp3CfaW83yJjyzhUS9D0Wlz0ed/m0m7XxwZNfVr8dDObdftLEHkVz2DJM=
X-Received: by 10.107.47.234 with SMTP id v103mr29061215iov.96.1511704850286;
 Sun, 26 Nov 2017 06:00:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 26 Nov 2017 06:00:49 -0800 (PST)
In-Reply-To: <xmqqbmjpitl2.fsf@gitster.mtv.corp.google.com>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <CAP8UFD1YY_f4Ds0sYK86OBb7Wyud_YWr2Wx8nx1pdnwSsPgJ8A@mail.gmail.com> <xmqqbmjpitl2.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 26 Nov 2017 15:00:49 +0100
Message-ID: <CAP8UFD2sWE9cZe=OO1UQjf6Boih=Go9xJg=gDgEUzbXNuood5w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 4:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, Nov 20, 2017 at 6:15 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> By default running `make install` in the root directory of the
>>> project will set TCLTK_PATH to `wish` and then go into the "git-gui"
>>> and "gitk-git" sub-directories to build and install these 2
>>> sub-projects.
>>
>> Has this patch fallen through the cracks or is there an unresolved issue?
>
> I had an impression that the conclusion was that the existing error
> message at runtime already does an adequate job and there is no
> issue to be addressed by this patch.  Am I mistaken?

This patch is mostly about what happens at the build step. Its goal is
not much to improve what happens at runtime, though that is improved a
bit too. If the build step was good enough, then I would agree that
what happens at run time is adequate.

Let's consider only people installing git using "make install" to use
it on their machine, as I think I already discussed the case of
packagers and added the BYPASS_TCLTK_CHECK variable for them.

When those users run "make install", let's suppose they don't have
Tcl/Tk installed. (If it is already installed my patch changes
nothing.)
Let's also suppose that NO_TCLTK is not set. (If it is set my patch
changes nothing.)

Then there are 2 cases:

- msgfmt is already installed

Without my patch, the "make install" step works and installs git,
git-gui and gitk. But the user might not want to have git-gui and gitk
installed in the first place. As Jeff says there are a lot of other
graphical tools, that are more advanced these days, so there is a big
chance that they just forgot to set NO_TCLTK or just didn't know about
this variable. Now if they actually want to use git-gui and gitk, they
will get an error at run time (which is adequate) and they will have
to install Tck/Tk then before they can git-gui and gitk.

With my patch, the "make install" step fails right away telling them
to either set NO_TCLTK or install Tcl/Tk. If they don't want to use
git-gui and gitk, they will set NO_TCLTK and then run "make install"
again and things will be exactly as they want. If they do want to use
git-gui and gitk, they will install Tcl/Tk and then run "make install"
again and then things will be exactly as they want and there will be
no error at runtime.

So my opinion is that whether they actually want to use git-gui and
gitk or not, forcing them to decide is probably a good thing because
it ensures that when "make install" succeeds things are exactly how
they want them to be. The only case when it might not be a good thing
is if they don't know yet if they will actually want to use gitk and
git-gui. But even in this case, which is not the most common, they are
not much worse.

- msgfmt is not installed

Without my patch, the "make install" step produces an error message
while building git-gui. Debugging and fixing the error is quite
difficult especially for new comers. They will have to either set
NO_GETTEXT or install gettext, and to either set NO_TCLTK or to
install Tcl/Tk before the build can fully succeed.

With my patch, the "make install" step fails right away telling them
to either set NO_TCLTK or install Tcl/Tk. Then the build will fail
again and they will have to either set NO_GETTEXT or install gettext,
but this error is easier to understand and to fix than without my
patch.
