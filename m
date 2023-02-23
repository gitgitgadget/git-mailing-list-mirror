Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4406AC64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBWTyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBWTyD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 14:54:03 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33D4DE2F
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:54:00 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id j17so12140962ljq.11
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPoOPM38yOSwqluEOy7fMMWJpQMIjMZ8/vyEILtoDGU=;
        b=aRbOFaW06FTZ6jI2rTR6l+GsNqTSoeHgsou6jz+YZYPwRl5SfJX04uVOaAl4E2DbcJ
         U3HguliBJcY15jR+/uE2tBHh1Jf/tq0vVZddDdHImqOR9fwLAtoyJa2CYHjnWK/pkLMa
         /oFkWcqtFkEMDx4xJGz7dE/kVXOzwZAusxTuZoSVzTRFi1pn+lJ3f2mrDkd4g8KOYW1k
         x9KnE1Vd767mTPaBefewG1EFB4kQRBU5kgStVONIYLAAcfSQ09EdTHR7mnYe5mSEwADk
         p/5Hvfzivbftz4CDYBOl7HoewKLSldBGdIex9JwNRy00tBBzGON4Oj6mWAKCoqacznwk
         iikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPoOPM38yOSwqluEOy7fMMWJpQMIjMZ8/vyEILtoDGU=;
        b=rtRX5fn/6GKE734DZWbwqVfnBvHO7ddvI3GWW0J21iIMP/SxGPjSdbgtlAKHF6RKKW
         oBBHWByCzqqseRR1DurYS99hw0VuEGoN2NU1x/PbWoLcUXTof+fuI4QfYpaQCHd9PnwX
         CKSQSU43OJfZn2mViFPlV0rryfCKB47Unb73V2sgbEG56aE8HCb+Tx2LmEoVeL+JSAFD
         4BsEFYFKSk+i6fdOwa7xxLOp8vRpMCjDDfrGZ+g/hjASUhDF7AGMFhyoI+V6pkB7p6ph
         4N70DvfmViOPKEtLwAwM1lhsM9wz8f0ICR8b7WUdl+TUph3/CMeUjv+WedStC/GyrFKH
         QPxA==
X-Gm-Message-State: AO0yUKVRYCxHxxh9OOUOPgXNSUsa0KhWEChQtQudZwzjorUBs1TGROLV
        UYYCe8JLWyBagiBs6b69Wyn8So7DUcV2v/pNjDU=
X-Google-Smtp-Source: AK7set/OSmxvrEyq4cMRXEWcYErjSan517ztrne1GGQNIVxlB5V9GsyQXPhrGa7u5MZ4QhCDPEXa6ZcWTy89TwstXsM=
X-Received: by 2002:a05:651c:1614:b0:293:4862:5e31 with SMTP id
 f20-20020a05651c161400b0029348625e31mr6012851ljq.5.1677182038608; Thu, 23 Feb
 2023 11:53:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
 <xmqq1qmg899v.fsf@gitster.g>
In-Reply-To: <xmqq1qmg899v.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 11:53:45 -0800
Message-ID: <CABPp-BHizCj2e454w3vtHrDNip3Rm-gUMT0oJiAsbkAvr_QvVA@mail.gmail.com>
Subject: Re: [PATCH 02/16] treewide: remove unnecessary git-compat-util.h
 includes in headers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 11:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Since git-compat-util.h needs to be included first in C files, having it
> > appear in header files is unnecessary.  More importantly, having it
> > included in header files seems to lead to folks leaving it out of C
> > files, which makes it harder to verify that the rule is being followed.
> > Remove it from header files, other than the ones that have been approved
> > as alternate first includes.
>
> Hmph, doesn't this cut both ways?
>
> I like the idea that the removal of compat-util from other
> header files may increase the likelihood that a C file that includes
> such header files without including compat-util fail to compile,
> because it would fail to find what is defined or declared in
> compat-util.
>
> But from "include what you use" point of view, shouldn't a header
> that defines or declares its own stuff using what is defined or
> declared in compat-util be including compat-util itself?
>
> Or do I misunderstand what "make hdr-check" is trying to achieve?
>
> Granted that the check does not fail with this patch in place, but I
> suspect that it is by accident (i.e. there happens to be nobody who
> depends on what is defined/declared in compat-util for their own
> definition or declaration).  Also I am not sure how to interpret
> the fact that "make hdr-check" succeeds with this patch.  Does it
> mean C files that include these header files while forgetting to
> include compat-util may not be caught by the compiler after all?
>
> So, I dunno.

I did something like that before, and Peff objected; see
https://lore.kernel.org/git/20180811173406.GA9119@sigill.intra.peff.net/
and https://lore.kernel.org/git/20180811174301.GA9287@sigill.intra.peff.net/.

I think for sanity we should do one of the following:

(a) make C and header files both depend upon everything they need
(b) consistently exclude git-compat-util.h from headers and require it
be the first include in C files

I think things get really messy if we let half the headers follow (a)
and the other half are forced to do (b).  I was pushed towards (b)
before, but now that I've worked on this series, I think there is even
more reason to go this direction: this work I did during this series
shows that if we allow a mixture of (a) and (b), then empirically we
end up with C files that don't include git-compat-util.h directly, and
those same C files likely include some headers that don't include
git-compat-util.h at all, and if the other headers are included before
the indirect inclusion of git-compat-util.h then there are risks that
things will break in very subtle ways (as pointed out by Peff in the
above-linked emails).  So, I'm inclined to go towards (b).
