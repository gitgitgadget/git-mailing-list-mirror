Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A671F461
	for <e@80x24.org>; Tue, 20 Aug 2019 03:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfHTDzX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 23:55:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37401 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTDzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 23:55:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so2993993lfh.4
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbR3spte4TgjwsLzFEB5uqq+qdUnYHTF/zSD7gzmZ7w=;
        b=cbwXUaa405YeHN8DtyRc9tTJMPyb8hE942tV36Qksqk4QOIE0kn0rsVscOyVFCUGFH
         8F16WOm3udyMaGlRfOjcymHjZxCvtLd1kw6HP9qAR2Exc2dCecTZvZMS6pU9ik4ZR11t
         KylqcnEtlZe8Ify4AQu8ZhFK0NUsxyoEtRd8WH+m13TVdxLe5/wtnlZtkbWfHj029oEW
         otm1eJRVD8kLC74pw11m/ecgeFEoEKGFyjzlNw29jGSlVS6HP3uDXAvSoGWHVMv2eOE8
         nXGKgEVR9Lzt0yTVxbYlwj1VbUbzbdVhZ7V3+s/jmoqgmrv2Zm7dnrKemkwhb5Q1tfX4
         iMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbR3spte4TgjwsLzFEB5uqq+qdUnYHTF/zSD7gzmZ7w=;
        b=fdSn69moRRIHCCvhtrN1GcoEM/TjqaqI4Vf2cvN21TD1Owk3F2sOIPDv5nenpHfLvY
         8K/WkvIu2GLvrPMchML5lJgzUTVnEXZJIPsjm7N84oTD/KWVCRjjumcDz+xbvK4d6f9A
         2XVdT2UCFRBq+y4yxyTOURCwuPifBDnctLJ4kdbrySjDQe3WtS8jSoaNr3s61lmhVgMu
         6obETlqOkE6X+xK2tN5EGkI3B9iN9hW7y65W113egUIURXtaIBaqfIED/bPkrmjAiy2w
         0HJ0kvY7VzQoL0soUyLRmugJpbCZ14aSujDOXTM6sluMzh/EBTVdTIhHV2iDM6F8G18S
         VbuQ==
X-Gm-Message-State: APjAAAUo3cKH+8d3wEucKqwmMYf4ffmUIG/enMVdf4AIIovoWCldTsa6
        g7HI12ICsZX4ey0S4dY31EyG/6S14hLVxSUkTes=
X-Google-Smtp-Source: APXvYqxjaaE7nzuahxHHqV2/5qWge2X71gwkAzScLCCYCiVtYBb34wYARJRmb0tJQKIcevTcI+8wl0iKHHNtCt7FvGU=
X-Received: by 2002:a19:4aca:: with SMTP id x193mr13658460lfa.146.1566273321168;
 Mon, 19 Aug 2019 20:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com> <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Tue, 20 Aug 2019 09:24:44 +0530
Message-ID: <CAL7ArXpKggCm2Ex0Kk3m+jDbfd3roCYmj=6DFG=k-1kJm-j+tA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] rebase -i: support more options
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 9:15 AM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> I've tries to incorporated all the suggestions.

I've tried to incorporate all the suggestions.
