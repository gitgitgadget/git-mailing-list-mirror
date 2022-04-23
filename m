Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B86DC433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 17:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiDWRhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiDWRhI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 13:37:08 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085721B58E8
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 10:34:11 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id i186so10436926vsc.9
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z+lP3RbmBAQoiNEYhmUU50e4jKYByFbXQK2j3E4OJ+U=;
        b=cpXQEfwi3kPnNfMh3E1nr8X78MzvWHumOwPYdrVrcPpfeVQFsJYKklWwrVw6ULgHst
         UTS6Z0+PaPEz7lTwe5l9GyW8bUC9PM1tX37JT2xcz+y4p8VkAyy2aBQpkOAP9Dnnu+OG
         dRNv3fwxIb6wEk+Oeii1YxrYIo/uN70UnnaNDfqsk+au4ZjYa8QqqYtXRN4NHFPDn+gX
         cAXwTtEIsACs1rqARawrqtBLkD0f+YLEhuwBuytRorSnH0LDN+2/Yfr2VhJNvv26qDjA
         iqwCpn/gW3HapWMf0G86CBDJOZj//0FoBUPfwA6b1iyq9+AM80A9EL7J/bDytf0Nf/ep
         OGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z+lP3RbmBAQoiNEYhmUU50e4jKYByFbXQK2j3E4OJ+U=;
        b=IoY8zpbHCTe/exPWFYQN4+eEas7M6Gvqt58NChIv3QL1C9v/jUnLYggP19g1P721Cl
         9FTsH6UCQXsjzssn2RWC1QXOA0vAfNs1vZ9eAUcBV9UuOG9JIH8vwUWS86bA8x2FVPMs
         WCQtWr1uKMxEiadQeQt8aUB/WFjxIWW26wVCeF/Ba4qu93CqMEW57XDy2LBAdTQqUE0Z
         woeEOBYzz2cHTaCg0AFBHlPuSUUnLZ4zoln71cfUiu6Zn/Np7bA6oSjGUhXhd1iWt7O3
         s03muYgX7aKx3f2h5LA49FhKJ+z1AB70VPNgJKHWdCRsNh1dwYvj86QXe7O8Rwmqb0i/
         Ivwg==
X-Gm-Message-State: AOAM533c/g3uwELH0bS3GYoKcG9S1m+x3sAKa49gHygDWLkczavz0Ifw
        BNHsz8sIf9S5yaNG+5u8Rqp6YWMfQdaO/gHjC40=
X-Google-Smtp-Source: ABdhPJw/ICuSpwWULva6nazGbLAiNwbU4J7tI8t/z1BUxxQnEhR085DmszOIhMZPFWzXzrgy82rnImQRfo7gtYd0snw=
X-Received: by 2002:a05:6102:5f5:b0:32a:617c:159c with SMTP id
 w21-20020a05610205f500b0032a617c159cmr2770877vsf.76.1650735250140; Sat, 23
 Apr 2022 10:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <0220423142559.32507-5-carenas@gmail.com> <20220423154420.32885-1-carenas@gmail.com>
 <xmqq8rrv3hcw.fsf@gitster.g>
In-Reply-To: <xmqq8rrv3hcw.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 23 Apr 2022 10:33:59 -0700
Message-ID: <CAPUEsphvWke=09W_Bk2Hj+aaTbocjdtbPr99t7tXoutodO0cVw@mail.gmail.com>
Subject: Re: [PATCH] fixup! CI: use https, not http to download binaries from perforce.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2022 at 10:12 AM Junio C Hamano <gitster@pobox.com> wrote:
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > Not sure why this is suddenly failing, but this proposed fixup also
> > makes both server names consistent and would be easier to clean up
> > later.

I think my merge resolution was wrong and so it might not be as
obvious as I thought.

> Yeah, I was wondering why the other one uses a fully hardcoded URL
> that these variables do not know about.
>
> Would it make sense to rename LINUX_P4_VERSION to P4_AT_PERFORCE_VERSION
> or something and set it also in the macOS section in ci/lib.sh?

Will do (if I can just find which of the sometimes conflicting changes
in the later branches would be the best target),
but I was preparing a fixup or commit to a different series instead of
one for this one.

>  We have
>
>         # The Linux build installs the defined dependency versions below.
>         # The OS X build installs much more recent versions, whichever
>         # were recorded in the Homebrew database upon creating the OS X
>         # image.
>         # Keep that in mind when you encounter a broken OS X build!
>         export LINUX_P4_VERSION=3D"16.2"
>
> which if I am reading your series correctly has become stale; we no
> longer rely on brew/cask, and do this for macOS identically to what
> we do here for Linux.

correct; this comment is the one I punted fixing to avoid conflicts
and that I refer to in my commit.
I suspect that some of the moving around that was done in later code
could be avoided now that both jobs use wget to get perforce, but
regardless moving that comment into the linux branch wasn't correct
(we can't assume then what the other branch does) so at minimum it
should look like :

         # The Linux build installs the defined dependency versions below.
         # The OS X build installs much more recent versions
         # Keep that in mind when you encounter a broken OS X build!

Carlo
