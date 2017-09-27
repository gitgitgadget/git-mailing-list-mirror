Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D795D2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 22:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbdI0WjC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:39:02 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:48883 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdI0WjB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:39:01 -0400
Received: by mail-qk0-f179.google.com with SMTP id a128so14854635qkc.5
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 15:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2F99SvgdRWzW5PiO7pEqNf+LH5hRN+3WJdjURv4PXKA=;
        b=D833iGG1OHHAdkSYqYD9rlSc9hgCdlRm5iSDSNW4VsD/x1dLZ6PXS+VFW9XheXxXBj
         dUPvVoN0EVefJ6jThbvifK3NdOUu4Wq0qWbAEWYl0DDc/TyoO6sA6UNyFN3U95FKM/5p
         hN7lApap0VUJ0rdz00heDXtjEkyelInSqrMrL+s270pyP+QLg3zVP7LIxv9puNU6fO77
         dsTJ8Lnd9+DkGykeFjEKaq2154CwmjKsSj5HOlW043j3HEazwp4hkUaiL7v3eFn8Y/rK
         8VzviOrmNtfHJ0Ts7E1a0MSYRUUu9n+RgMUcCrJncIiYbdto0xEVC2+Y4s0SgUESC1yw
         jgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2F99SvgdRWzW5PiO7pEqNf+LH5hRN+3WJdjURv4PXKA=;
        b=pL3eEs4krF7Ta7MLp5gQBVA9oPn12/BSLCarFlh7Y+We+upkuCyKBzv3XHNcjHT19p
         cLRK/h10TElLlx0aarNXzvU/V9xOi8ow9LXD2D0cXyTbh2pnURDFU3wp26mExTss5kAI
         yruUGAAwxz48zZ98iQGyZUEjTf15KqshLOq3VAIj0pdoHFmdFnaLknHiAUf56dZ90Ahc
         hUepHe/deTuWgyMPvm+B9/T0vncZtTV4RbztsgwRoD7EDdtXZ3ER8HULXAyJKNke1cW6
         LY5j2aNyGwFaij6fDuA4Tn4hW/8xgV+VZVDCKWEt+Ds+Fm0rPwHGV/mrr90J6CXq5fsz
         fQag==
X-Gm-Message-State: AHPjjUjUIRTFWFdlrpqZ8aMboxgDvcBYXk5vgXdpsQJtPgx1G4Cy6FEm
        eHP0js0+h1P0zvdmA2mPgqDS8wfuTPmD3uvXmVGj0A==
X-Google-Smtp-Source: AOwi7QBzOM1ckFTCNwyP8zGlkKe07fqUbpbn/k+WCbbaFoRA1nLhw5sVyqWmHtafY1IUrh9Wc33x5RUSyJABIAnkMKc=
X-Received: by 10.55.90.199 with SMTP id o190mr4757253qkb.180.1506551940856;
 Wed, 27 Sep 2017 15:39:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 27 Sep 2017 15:39:00 -0700 (PDT)
In-Reply-To: <20170927223239.t6gvfztkdjn2vltb@sigill.intra.peff.net>
References: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
 <20170927215852.20163-1-sbeller@google.com> <20170927220925.u622metv2fcdtcfq@sigill.intra.peff.net>
 <20170927223239.t6gvfztkdjn2vltb@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Sep 2017 15:39:00 -0700
Message-ID: <CAGZ79kYAfii=vwXwSkx-QE+tXSfPE5h1c39gZSB=c5Asfq9P3Q@mail.gmail.com>
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 3:32 PM, Jeff King <peff@peff.net> wrote:

> The most appropriate place seems like t4013. I tried adding to its big
> list of tested formats, but it's quite fragile. The patch below is what
> I came up with, but it still needs updated to cover the cases which call
> "log --all".
>
> I think we'd do better to just do a set of new tests at the end (or even
> a new test script for diffing mode changes in various formats).

Thanks for providing this patch, I think it is actually reasonable to
do it here. I can fixup the rest if you don't mind.
