Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E6C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 16:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjAYQGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 11:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjAYQGV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 11:06:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481012197D
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 08:06:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id y25so29700061lfa.9
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtPNSCeG9sbmRoyykforKNaROPYXPM20q09wmy0MgVA=;
        b=KmfDZUu117fQCulwTF0+7eii3lxEBFSbJYYfgJAXOyo0nbCLLDEfUN/Q3kaHH4voCj
         oAXpJ7H+vE2RJnAxf00Bx5CDqKpwtH/eVRgcPEMVRIh6indlv7BN4OqzSResT/983dx8
         8V1TnekJWUUhM08ozK+V0hGClULNTSXsQKl8kjfxsNBNHy30r6WufzzoGBdAtrUjNXms
         VwdKiu8GA8P3yfRqEEpCTlbIoP9IpHWKLI1g/U8mmv1b96NVFk9sn6Z45jbGBZmu0msp
         P5+U+I24BZHac/Gvmf+v97WwkVfCBTR0AzVdkCyJoHo8VpReTFApuZD3gasDt5pTrvi5
         S05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtPNSCeG9sbmRoyykforKNaROPYXPM20q09wmy0MgVA=;
        b=U9jQeK9rV5Z3MxUl5tOKw+w/KsXfEOO/3FUWcc0WLgAUN59dzxDRwJGXWnXiCyU9fP
         5L76apLUYLkgQlnmUGjt11BuNjMAASHUJyB8YuX9M967rST3eCqfKaC2CLq8c3qXLHzu
         mZO1iGzKWSgmjoHTh+ac1My/S16IOYMcOV88iJgGDobUjhW6r7hOBYhrKUgq/a1CLNXx
         amlse4eLLyeDPpAZJKRkbHxS0XL7zDcpnh+P5t9EWLQND19mC+5nav0p+/PeUYI8eHWZ
         UCnW//yDoWMoRbBvFcrdO5ZEshjYgs5WLxiiaBQUTtMzCVquZVJnCjpEIW1PaHFlXTEH
         xO5g==
X-Gm-Message-State: AFqh2ko6DyfQJeB2f0iPCmNqHQpEJIhvmq437sZR+XSw0U9iOpn35mWO
        OxMT+OmpmMXnePKAiZaw0Wmd89hIJ10ftJKbj+0=
X-Google-Smtp-Source: AMrXdXs3IDZ9VFZe7bITIX3Zx4C6FckOw0mfTmYbOrChx39WzcWho0LaVIRkmZtoutG7w0Mbo7VBjA66UwIiTE5Ntn0=
X-Received: by 2002:a05:6512:3b21:b0:4cb:24a0:27ce with SMTP id
 f33-20020a0565123b2100b004cb24a027cemr3968115lfv.238.1674662769255; Wed, 25
 Jan 2023 08:06:09 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7cxbftvu.fsf@gitster.g>
In-Reply-To: <xmqq7cxbftvu.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 08:05:57 -0800
Message-ID: <CABPp-BH0LwHvN_bXp0BpekQ+f+15KNXQRzf5LCn3_BhcPzB-3A@mail.gmail.com>
Subject: Re: A summary of in-flight topics
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2023 at 2:37 PM Junio C Hamano <gitster@pobox.com> wrote:
[...]
>  - ab/sequencer-unleak                                          01-18    =
      #8

Perhaps move to "Expecting a hopefully minor and final reroll"?  See
e.g. https://lore.kernel.org/git/xmqqedry17r4.fsf@gitster.g/ where you
commented on Phillip's approving the code changes but wanting a number
of commit message cleanups and fixes.  =C3=86var did send a v3, and Phillip
commented on two of those patches, suggesting one could still use some
commit message cleanups.

>  - ab/various-leak-fixes                                        01-18    =
     #19

Isn't this already merged as 9ea1378d04 ("Merge branch
'ab/various-leak-fixes'", 2022-12-14) ?  Why does it appear under
"needing review"?  (I started reviewing, and while looking at the
existing code noted it already had the relevant changes, then went
digging and found it was merged...)

> Will merge to 'master'.
>  + en/rebase-update-refs-needs-merge-backend                    01-22/01-=
23    #9

I sent out a v5 since you sent this email, to include some final
changes Phillip was suggesting.  He seems happy with those
(https://lore.kernel.org/git/94deff87-a4a0-e937-7549-3e5348361a12@dunelm.or=
g.uk/),
so I agree it can merge down, but please use v5 instead of v4.

> Will merge to 'next'?
>  - en/ls-files-doc-update                                       01-13    =
      #4

I'm in favor, but self votes don't count so...
