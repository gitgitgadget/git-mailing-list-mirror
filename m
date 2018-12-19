Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E4A1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 21:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeLSVm0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 16:42:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37658 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeLSVm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 16:42:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so16182568lfj.4
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 13:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r55+tHszjoL+yARc47YZ2ap00DJE6XFjQmLmgJp6jxI=;
        b=rLVTDb+O+NOon7xbfGLlksLLvZ5FxDPmVVzXITrVT0NoTn2GFxJSyE1706smFv5Opa
         nA/YNrfsXb1JyhuMOi+NyxrqW1FWzWoETQw/D3LhJUSMlIpfyIlViMi6U0LBvlkdRKHa
         gcvB0T3ZIy9QA4GQgivmHjLH7zmlt6Nhr9b8K6FJVNEsDXJD9glWl+JwbhQc9a45Vn+k
         QYMAQ5RCk1SvbGBUvdKwwleX9Gsbgtfg1xoNoWR+vtLxM6nTpSviALpqipwxEKOn0OrQ
         RpLp57Zv2qBO8j7remOWZ2PDmJgPezRm/A+aLUJAKSh9iYd8KtuLA7GqzWr459soGDbu
         UR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r55+tHszjoL+yARc47YZ2ap00DJE6XFjQmLmgJp6jxI=;
        b=Yw70Z4NL53VPVdeFJUHtD9oFS99XRLjwxqP3gGxVAgrHDb881il89D1itBe/Y4qrvu
         XpnIQADkAI5vJTUbaGiS+trB4Vr8UPIkza6vjMBNtQGJDuZ3tJUgRtNSYOTqfgspGbLH
         QpI+Gd2pMOJr4UAObzOSnudZM0T/69j8jVcVJNlQG7bjifeoDtT/2oNlimgYoKssN4Z6
         4RlSXey15o6poQrITpx2+0a6fd+9BXyg/qgYFQpdqWL2Lf/wr5aiBPdrCx8mujm9KH2T
         cHUJaapUjBiws+dd8b9aP1uNYp7ZfQ4x+yjKzCfyPWjKp3tNfDarnxiGk9FO/TnQZKBd
         mCXw==
X-Gm-Message-State: AA+aEWbDu3LLC5Bq26wCC5ICXdaXPG//Ti3XkOLoL84K+MBq2o9PS+k4
        GNENUBFvmd2bDBsugntrNy/ot85qDxdM7RWzNPA=
X-Google-Smtp-Source: AFSGD/VaFyj1PHfA0S9FLb1owUY/tyVk9I9UpiiWzZLksJv+vLDEAxlN1jgCt/qwk/CRJo1oJdWF8WHfiZIVVd01GXQ=
X-Received: by 2002:a19:f813:: with SMTP id a19mr12992778lff.67.1545255743829;
 Wed, 19 Dec 2018 13:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-2-martin.agren@gmail.com> <20181219152735.GA14802@sigill.intra.peff.net>
In-Reply-To: <20181219152735.GA14802@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Dec 2018 22:42:12 +0100
Message-ID: <CAN0heSpfksXsKZrFNSaO_qitAB6gbF7QePQkuN37kAerSe2xWA@mail.gmail.com>
Subject: Re: [PATCH 1/3] setup: drop return value from `read_repository_format()`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Dec 2018 at 16:27, Jeff King <peff@peff.net> wrote:
>
> On Tue, Dec 18, 2018 at 08:25:26AM +0100, Martin =C3=85gren wrote:
>
> > No-one looks at the return value, so we might as well drop it. It's
> > still available as `format->version`.
>
> Hmm. If we have to pick one, I'd say that just returning a sane exit
> value would be the more conventional thing to do. But looking at the
> callers, many of them want to just pass the struct on to the verify
> function.
>
> That said, there is a long-standing curiosity here that we may want to
> consider: read_repository_format() does not distinguish between these
> three cases:

[snip several valuable insights]

> I dunno. This is one of those dark corners of the code where we appear
> to do the wrong thing, but nobody seems to have noticed or cared much,
> and changing it runs the risk of breaking some obscure cases. I'm not
> sure if we should bite the bullet and try to address that, or just back
> away slowly and pretend we never looked at it. ;)

That was my reaction when I first dug into this. :-/ It's only now that
I've been brave enough to even try to dig through the first layer.

> FWIW, the patch itself seems fine, and obviously doesn't make anything
> worse on its own. The question is just whether we want to do more
> cleanup here.

Well, if we do want to make more cleanups around here, one of the more
obvious ideas is to actually use the return value. If such a cleanup is
going to start with a (moral) revert of this patch, then we're probably
better off just dropping this patch.

Thanks for your thoughtful response


Martin
