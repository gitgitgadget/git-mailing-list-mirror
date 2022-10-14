Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B6C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 22:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJNWeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 18:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJNWeR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 18:34:17 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B51D0D4A
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 15:34:16 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-360871745b0so59025557b3.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAQuVeWcmUOCQlfE7NWEAijNuPovuj2qWjuy2VkbFaU=;
        b=ijqXkRP4Ar9DTamSra28xRc1zMagMniHbdfdNqX/ul3+RuYKc/80SuwIvMv5Jk2sLE
         hId/uaGEmBeD63CoPAry7A1Nb4jC+9ZfACibJC1lhxblLOzb7/f7hGXX1x1086IwSFpc
         WSC1qLyQJuAY/iX9RyGrcMCwvjBR3DfzxwKRXXDfEtWWl8Ok8RpakwFQXdthsisp4HUh
         mAP4rLRtl0QGKCIEPBWw5fk0t9NbZBd/CHAcf5AJKc06PMgdgCtoipOfN2gTBMof0G/v
         L+0RtqizEcHfB+qfnM2p8Pn7N+HwnfN9WBxlr28pLYZ3qTUdbHxf6akHJV9B9EsMIXJt
         tf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAQuVeWcmUOCQlfE7NWEAijNuPovuj2qWjuy2VkbFaU=;
        b=lWp/6UnTrRM/DWEtZ9GlLcpmxnt7XFWw87XJo+cgWL7qFs2ulDjUIkPYypjvg7+BfR
         V9QAgny1RzOv7WrPsp1EV//W6kokUrmxVjO5/VBYBio/MohtgxhTydsGp6gvToS3wg3M
         JPpPtUz5SW+IpngxB6mwTQok0A1zdeaukmRfSpj6TpRD2Q64OPecT6ZAL0ylHbaDJTIv
         /xm0aNg0v9gJdHq/Q1TyqVMx1do6BVVDVZJNEouFrUc5XLTw9eOzoW88csXLubL6nN3W
         xuYlJg8qmmHifXy29y6fOM0uj4SKK/fE7Qouw4wrh9BMb2xN7DpnsUja6nIn2Ild1BhB
         UXVw==
X-Gm-Message-State: ACrzQf3lo/rL8gCt+NQ9VySNCCE9z9Ll14SQx7mCkMZbxO7WmkrY/NeB
        5fE78BfedeZcPXwTtQ2iFP/9v373+W0wV5t/ElXf+Q==
X-Google-Smtp-Source: AMsMyM4JRYnfoJFqvt8khbF/r0tP//UB9dCHW1531iHAXog3s4lxwfT66QFkHemFIReeCknpghqEq+6yLZvtaLapobg=
X-Received: by 2002:a0d:fac2:0:b0:349:f1d4:8b1e with SMTP id
 k185-20020a0dfac2000000b00349f1d48b1emr32167ywf.456.1665786855743; Fri, 14
 Oct 2022 15:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
 <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com> <2164212892712930cb34223499bb3e03bf2c2392.1665737804.git.gitgitgadget@gmail.com>
 <xmqqmt9y6rem.fsf@gitster.g>
In-Reply-To: <xmqqmt9y6rem.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Fri, 14 Oct 2022 15:34:05 -0700
Message-ID: <CAMKO5CvdDWEd6HPbkg7DP9bZMKNzcvmK+c1UPpuTk7vM1D8i9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] builtin: patch-id: fix patch-id with binary diffs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jerry Zhang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 2:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Jerry Zhang <Jerry@skydio.com>
> >
> > "git patch-id" currently doesn't produce correct output if the
> > incoming diff has any binary files. Add logic to
> > get_one_patchid to handle the different possible styles of binary
> > diff. This attempts to keep resulting patch-ids identical to what
> > would be produced by the counterpart logic in diff.c, that is it
> > produces the id by hashing the a and b oids in succession.
>
> I thought I saw that a previous step touched diff.c to change how
> patch ID for a binary diff is computed to match what patch-id
> command computes?  Now we also have to change patch-id?  In the end
> output from both may match, but which one between diff and patch-id
> have we standardised on?
Er yeah let me see if I can simplify.

Before:
Internal patch-id w/ unstable + binary was correct
Internal patch-id w/ stable + binary was broken
builtin patch-id w/ binary was broken

After:
Internal patch-id w/ unstable + binary is correct
Internal patch-id w/ stable + binary is now correct
builtin patch-id w/ binary is now correct

So the "standard" actually came from the one working case from
"before", which was the diff.c logic + unstable. I based all new logic
on that because it seemed reasonable and correct. Since "internal
w/unstable" is never exposed externally, it's perhaps true that i
could have invented a totally new format and standardized on that.
Hashing the oids in succession is pretty much representative of a
binary patch though, so I don't think there's much to be improved on.
>
> Puzzled...
