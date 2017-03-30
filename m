Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F2C20966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934520AbdC3S1H (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:27:07 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36729 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934331AbdC3S1G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:27:06 -0400
Received: by mail-lf0-f43.google.com with SMTP id x137so32792441lff.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=63/0AmCOuwnxWsKbGQjsXSqNNHmmdTt6jXeY2Sgyx7g=;
        b=EWP9eZkVFxIgibnrZEMbTheOcBrv0SjS32aMng2Lxp1E1uonNZ+oY2JZT72XxaNaHw
         kWg9G1cyJKIGpqkJ+I91ZDXO2e3GZrU9+00J666dz0zj6lps+OWa5ioL8iCUPskSGrwH
         lYKvREnyCNzNGpmSgbYQflDGPTZKTQNNgXo3qmhLFL/7x0HUNcjVL4RVNKdRht0BdYZQ
         FZGhfA6GCBIyG37IvRRBRtupcauK+gISPeQXIaSPRgMQqdW2iv7exzndUMda+GJqgsM8
         HYR8mfgYbhxtU7EmDrGUtHgtPGuvjBdnFadnCsbImgtwf1Jfn3WIL17AT4PIF1MYhCiD
         Kj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=63/0AmCOuwnxWsKbGQjsXSqNNHmmdTt6jXeY2Sgyx7g=;
        b=MsNDDWgFrwRhfY2CZdh+xrkljpHP9uUyXPEPzvNu4zR49EHj6q8hfo8F7+nHwrQv/8
         H1O3gHFiA8UtDcSY+pHDBL+2y6bl5JH/cVgTSkeITmj4K8b7plOh1RdOBFercNMQX8al
         QFz3w9f/SEiTKRDERBHueP3QZ0ERpREOPOULd0+AV9gjpx/jly6wgn6uDrcO7Kx9Aeiu
         XiL19UUO0X06o/HQdBouvPPXMGE7MnsBAVgwLmS+X4mQlt7Mr8S9d1/wxdkYorKEY8M6
         KNfq6+Y8GW6+ta8Dz7GPwNLG58LJJRqJi9olKf2SD4YQLLB2W8dUq99pZDlFmubxr1S7
         c/fw==
X-Gm-Message-State: AFeK/H3XxReLokLpRfYRWB43PHVvdIqffeEoHg1PJWVMA8lSFcTbbh8d8AyD+0OwNvOtOdRJNZIDWdWeWBvbLQ==
X-Received: by 10.25.18.169 with SMTP id 41mr311946lfs.129.1490898424095; Thu,
 30 Mar 2017 11:27:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Thu, 30 Mar 2017 11:26:33 -0700 (PDT)
In-Reply-To: <a738d683-0f2d-61b9-5ecf-ef8bc8f98ff6@alum.mit.edu>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-5-git-send-email-bnmvco@gmail.com> <a738d683-0f2d-61b9-5ecf-ef8bc8f98ff6@alum.mit.edu>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Thu, 30 Mar 2017 15:26:33 -0300
Message-ID: <CAEA2_R+w+Pty41RykqBt0XKeNi-4eowNSc=Yh9RL=Lq+Xo=mJg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] dir_iterator: add tests for dir_iterator API
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Oh I forgot to mention, in the Git project we don't allow declarations
> to be mixed with code. Apparently there's some ancient compiler
> somewhere that doesn't allow it. Declarations always have to be
> together, at the top of a block. (Compile with
> `-Werror=declaration-after-statement` to detect this.)

Sorry about that. I'm compiling git on clang and it has a bug that
ignores this warning (it shows up on gcc). I'll watch out for it.
