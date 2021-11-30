Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F4AC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 23:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbhK3XtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 18:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhK3XtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 18:49:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E52C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:45:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y13so93744354edd.13
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtVUH2ZhwSA4G/JuAE1ccUyLR0ts6rHo/1g5ufEMwR4=;
        b=O4klET135V6eFnqTg1zUobsftX049GrQSvXarQLkuo6/5KWMmPUkcQKxyn9Z6NQGPb
         FzCtjq9Q5t6SG07/7TfAgKZvQCdHFEQRxQmARfQ7G/vVF31gnGmuiELJEiFht2L4nf/G
         Z9ksSGiJopDxCGae/MCtQX715hZy0nHqkrA6Hr19jPgilL1IfhasCaXaWNw50kLJYXpK
         cEkebcDa4hZ8UHXVfmNLqEfmLpXMsiFghle4ybGW5sXZ9AMJdOJLuw9Jfg+kQItxaOkJ
         J+ISy0bAKrh3nS+lALzAM9etsqlTnv913ZsvB5mJyHy0l110e1hyb9T696Bg2b/f+wgH
         VONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtVUH2ZhwSA4G/JuAE1ccUyLR0ts6rHo/1g5ufEMwR4=;
        b=u0nHON2ZuRk+GH+SKj+cTLZlPpDPGyix0BOfBLIIjUQdAVCrJWUmL2aPQmD49qGF6h
         anUEcrJ9MKP9qUPtj81FopEPystnqUkxtEsqVzQzL3nWIRxyMwD5ZHBUsKFRO7O/ohC7
         ZI84992qm59t7RQ1buHtQ3F922Orh4AbRy9EYAMimLlIS2NokF+1I5lAuKlw1ZSBbVv2
         Xu7pyaqAFDxtzfuHObxIJjDH8OuBMd563q9f6+pUmD1P4dwxGFvOPiWKmU6ZQ7H2zpOg
         zoPxRuaIpVG9MFZbIblKKWIO7kiNHWm/tXDLD3yYotnj5sNMZAmLHZvlEogQrK3hwt+1
         Q+aw==
X-Gm-Message-State: AOAM5339faJo8WqMek1NIzExDrx12ci/wfypsvv01hw5yP3kaHKDp+IK
        glYo6ce3coR/bNQpGpoz0a2B4+Atzjw5GEmLVxo=
X-Google-Smtp-Source: ABdhPJz5uWyVP+o/NrXOaMDx5ppjNB4jJMeumw5poRu85ZYw48ocur6yt1IgprcE0QRp9suMwj4tr7g09P/ikq9fRKY=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr2662697eji.434.1638315945333;
 Tue, 30 Nov 2021 15:45:45 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g>
In-Reply-To: <xmqqzgpm2xrd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Nov 2021 15:45:34 -0800
Message-ID: <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 6:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * xw/am-empty (2021-11-22) 2 commits
>  - am: support --empty=<option> to handle empty patches
>  - doc: git-format-patch: describe the option --always
>
>  "git am" learns "--empty=(die|drop|keep)" option to tweak what is
>  done to a piece of e-mail without a patch in it.
>
>  Will merge to 'next'.

Please don't, at least not this version.  There have been newer
submissions with three commits.

I also still find the word 'die' confusing, since to me it suggests
aborting the whole am operation, and the documentation does not dispel
that concern.  Even if you don't like 'ask' (for consistency with
git-rebase), I think 'stop' or 'interrupt' would be much better
options than 'die'.  If you really want it to be 'die', I think the
behavior needs to be explained in the documentation, rather than just
assumed that users will understand it (because I didn't understand it
until I read the code).
