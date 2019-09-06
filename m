Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5121F461
	for <e@80x24.org>; Fri,  6 Sep 2019 14:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394003AbfIFOIO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 10:08:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43187 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbfIFOIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 10:08:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id d5so6115694lja.10
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJHdXMlOaYH7j+wK9WDDmEmeMVdUarabarcVdTmIBYI=;
        b=bedcqF8W3/+ceadIXxC8G4PUMq1dWiZTzz4Hkwme/KoxbHRp1z4UOId2os247tCoug
         +zBhB+BU9lzRHl4JJsX2rsOTQ2bfM/LxcBSXFeSjFBejH+S/vA9/2SyV+PYa7omKvFm5
         SIHn4yoUNEq5EMbKpPNUfai6pyJwEVAW9qVz5fxqqjuwKloOyk8EJE1hozBNXfkwfXuY
         01rGDcMrGsiINoD+ZbzDNynwFjy6WpVja3UvacRJbfP5xsOrIchb/oAbcvJOhGvRLcy/
         PsUP/CRFOmanTmHNljU4c3WN18Dz6wYTrHtU7tMzh74uiZpeO7zGSh0D2Urtu3WB5wK9
         /C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJHdXMlOaYH7j+wK9WDDmEmeMVdUarabarcVdTmIBYI=;
        b=WvnZxhXIMMRlqvqic47Kvl2Nt9zM81vsmDtn4tTLPfIiDIrghC5E2ZiQOB3adWyqv1
         mfwqfCbFLO9xyAjGEFm4c0wlrHo1688VD+TE5uBpor9GVOIGcaEKq1wvaekFBZy/ARr9
         sbayZvOWBDM/MQF0r8crHeLKdfgiY2yNTXOLxTqzxCldvfQS9Zr1BN1rR2OvhHizl72a
         OWBvx1u5UpMX/GhjCoccFeur2+R0tFI4cw3h4LtGGndv5UrFn/Ih5I6re+EJPovCbGvE
         qAGzYxhDsMLeM7dZcO3AE/yrlWWvdTYYuESsSHZ30Isqmihxh09GbCli/GrZZQSxVAVF
         npoQ==
X-Gm-Message-State: APjAAAWuJOVvYtG9upAjICvV1MD+1b0q+GFsg1MLebs6nnvHsJO57IBZ
        coZacmMVoY55hr/J5IdRAp1ehLJFtZq9YT2pggDKDTmD
X-Google-Smtp-Source: APXvYqzmwVd4gzYCLj8xC2RgrbUYS9IiC1JeoD/YeV1m4ATZWYpBYiEvcf8X90YyVKBXVp2qmfazbMW+W+cpw0IPNL0=
X-Received: by 2002:a2e:95d0:: with SMTP id y16mr5988390ljh.166.1567778892734;
 Fri, 06 Sep 2019 07:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
 <20190904224821.mgh4srhc22grkraz@yadavpratyush.com> <CAGr--=J1YmMbud4tcZjAZ06m0CmRbAqQTzs+FTgeJkJp4d2FzQ@mail.gmail.com>
 <CAKPyHN1VeK4bR3Dn5yjrs2UwT5XGKOPU_FHaMBsP+riM-bjeWA@mail.gmail.com>
In-Reply-To: <CAKPyHN1VeK4bR3Dn5yjrs2UwT5XGKOPU_FHaMBsP+riM-bjeWA@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Fri, 6 Sep 2019 16:08:00 +0200
Message-ID: <CAGr--=JpsgESv8W90-iT11VCAD3xQYipN3+Tt7cNyeZrsvhP_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,


We should probably distinguish between what is wrapped in git-gui
(i.e. purely visual), and what is actually wrapped in the commit
message.
I believe the former is referred to as "soft wrap", while the latter
is "hard wrap".


On Thu, Sep 5, 2019 at 7:46 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> Please exclude the first line, i.e., the subject. This should not be
> wrapped at all.

I think all lines should be soft wrapped. Scrolling sideways is just
not something I'd want to do in the gui.

How about we soft wrap all lines (in gui). But when the commit is
created, the actual hard wrap (newline characters) happens only on
lines other than the first one?

But then again, the user might get frustrated when the resulting
commit message looks different than what it appeared in git-gui.

Honestly I'd prefer just wrap the first line as well. If the user gets
frustrated that the first line gets wrapped there are two options:
- Refrain from writing such a long line
- Disable word wrapping (it should be configurable, like you said)

Thoughts?



Birger
