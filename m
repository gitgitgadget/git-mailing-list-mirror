Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00321FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeARWcn (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:32:43 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35257 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeARWcl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:32:41 -0500
Received: by mail-ua0-f193.google.com with SMTP id g16so16678802ual.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 14:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bcdkiXwm7wK9WCYWedkiK3gVXPKDyqikTXoTuX75CuA=;
        b=mt/D7I6HLbEYcM9CL/YAJWVUElovykUrKHEo9dDQiiWcGREMyvlkWuy6tu1uTOHKGg
         R1v3nFK92w6xKFiWdHE2SsdHOzJGbjBr3vmG16/roTD539xOD4v7Ak62C+un10wRroQ2
         C9vSV5dADlIWEk152rE0MCw9sR5AT2KGwH6dk81r3XP/Won+oKcX6OuOO2gHvJd5JTJV
         SLY4WSfnlBd5lQIRRE0bTwnhIG531gKbo2h8RLVMnz7+V9bMJF/MTjAlgGEaVUMpgYb+
         In9pWC01GIFbHN2a7oy6TJCy5W6yWWRiyyg/xSLV1M6mDFqG8LgDGpKQefUM5Ooxz7jS
         +Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bcdkiXwm7wK9WCYWedkiK3gVXPKDyqikTXoTuX75CuA=;
        b=j8LtNSVHVPn1cp7YT1p7amaQaGzhSJNHwTQfjsoMnzH3ECdmMbuodLAfewlXRgDZA0
         NWdusBzlY0Xf7qrqKQcWHvz47txvBxX/qkaORhvkeVmk6cy13KmLziNgICHXjQeKeUWU
         V3wEpDdLTGZuzmruaVD4SsTVKu5I4TgjyqksS9Pzrj2u/juz/SWj18q7LcMkm20ekluz
         uRBBqAU8OO2NJvMCOtlfHxs8ObuAzH7pDnr71Su/fMb+4di/x/hB7Ys6YvWbzSNBd+Xy
         UwfbhkTMMb9gfQ3cwyCjY32AmiNV2ujf4L9AQr1rxS3woLNcgRls8O7tv4dLTCjSFmOB
         y8og==
X-Gm-Message-State: AKwxytcNEJzYCuale5TniHDpxMWXgyltnqn/+9x4AG5IGW85hpM8iT0E
        9La3Fluh1MK///0rw6xpaiOwA2gzCrJ2RSjrf70=
X-Google-Smtp-Source: ACJfBos6cvIwSH2Lmhbx4p/IvmdDcR8D4zVjtbmhomz05a/6MbRvSqcD4gD6s6r0g80uYfbnKRiQJ4kav9jP1eDCHX8=
X-Received: by 10.176.72.178 with SMTP id x47mr6322801uac.24.1516314761060;
 Thu, 18 Jan 2018 14:32:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.10.140 with HTTP; Thu, 18 Jan 2018 14:32:40 -0800 (PST)
In-Reply-To: <20180118213732.GA7403@sigill.intra.peff.net>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com> <20180114101820.4273-3-pclouds@gmail.com>
 <CAM0VKjmGo5gjUBpTQp9M+pvZzBMDAmYYCu-5VfG-8LYRxU7i0Q@mail.gmail.com>
 <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
 <20180118132931.GA21914@sigill.intra.peff.net> <CACsJy8BkJXeaG3mYNEsfVK4N_-WxwU2Pk2pa1FThH1sMEW2yxA@mail.gmail.com>
 <20180118150014.GA2097@ash> <20180118213732.GA7403@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 18 Jan 2018 23:32:40 +0100
Message-ID: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:37 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 18, 2018 at 10:00:14PM +0700, Duy Nguyen wrote:
>
>> The test suite was run as root, no wonder why my removing write access
>> has no effect. I got the test to pass with this, but then it fails
>> with
>>
>>     Can't write .prove (Permission denied) at /usr/share/perl/5.22/App/P=
rove.pm line 542.
>>
>> Some more chown'ing or chmod'ing is required....

This is the fallout of running the tests as root in the past.  With your
patch 'prove' is run as a non-root user, but the prove state is loaded
from Travis CI's cache, where it has been written as root the last time
around, so now we don't have permissions to (over)write it.

I have patches in the works to address this as well.

>> Subject: [PATCH] ci: don't accidentally run the test suite as root
>>
>> This script assigns and adds a user named "ci" in a subshell so the
>> outer CI_USER is not affected. For some reason, CI_USER is actually
>> empty on Travis linux32 builds. This makes the following "su" useless
>> and the test suite is run as root.
>
> Are we sure this was the problem on Travis, and it wasn't just an issue
> with how I reproduced via docker?

Yes, we are.


G=C3=A1bor
