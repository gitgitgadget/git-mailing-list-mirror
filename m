Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52103C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiF3RfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiF3RfH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:35:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B531837A1E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:35:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id h187so32806502ybg.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TY4HjP8/bnphxZ83qG8BNp41GVJFbCFQkj8+BODCTmY=;
        b=nS6QiFq3Xa6wMDxE53djD9YcDAFIG3U5toqvQdWbyedq6+UpMHZEqxQ+3Z3zAFiZLt
         MZrcEj428P3NH8MLJVFc34pnCqQPKXN9ssQ2cLmaqhvpRB+L9JaH4O7hhJcB1ob0UIq5
         OW/jb5ERGsHIAW3nez3IO6JOsNjK5e/desoe4BSVHOQFvpKLFG4jGDMDrNsAVLrO6HGP
         t1YRnFG7qfM653LV3iZd3a+XESPJqCv51rt+ECxigb/oCH9b6N2nFh3D0HslYm7XHnK0
         N6hNcc7tQ1eiWmDdlsyKOAZv49rA3bL5kSW/7optrZzh3aGu7j4UwWwilVJ+5JXcywwc
         Ssng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TY4HjP8/bnphxZ83qG8BNp41GVJFbCFQkj8+BODCTmY=;
        b=CyNeGG3uczksbc9BqIm0xBegcB7j5Dl/D/vwvKQKkO/X0gsGIRu+6OSP1e8K9dOBm1
         IHpiWFNYJxbHtFNHBWc0LTN2EvWY6+d6wRvFeXP7+qpgDg5MitI7+UjJMylcqbEbQfhd
         /Bjf0rzT0za2R03xkL/eIRLr40sXgxm/f6kzZS332VQyPPhN7mnuJ/rhP7J+Fe17aQSA
         sUutpI9YB69GVJ3mrME8CS0dRBC7zHnxWzED3HKg3QUjcqN/2ZLH8qqm+5msVV9pQTrN
         njpMV9LJjiXnlU5/S+sMw5LcEd6sS41ro/BNt5ZcZCesxbb9xNfXSdpigWLP4jaQzZRK
         BrNg==
X-Gm-Message-State: AJIora9mIcaelGd0bidLK3jJGkeZTeIRRY+H8UqAN6ew2cAQPJxeJuyk
        4vmbjn5ow1argGruD7UAkFnahfFygt2dMIGx2qt6R7/SY5c=
X-Google-Smtp-Source: AGRyM1vgd8MLmgwjh0eVb3UoGaA8ir+Jwl+KTuXLEueI/XPJPMkMRqH0sS+mG/efuQTo9iLbH+SUyNc1MNveTozFL4E=
X-Received: by 2002:a25:b9c7:0:b0:66c:e02d:9749 with SMTP id
 y7-20020a25b9c7000000b0066ce02d9749mr11007404ybj.494.1656610505815; Thu, 30
 Jun 2022 10:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
In-Reply-To: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Jun 2022 19:34:54 +0200
Message-ID: <CAP8UFD1Ar13wqQP0ecb37saShSVj5Gxcjdpz=pckXZ7X9TRfSQ@mail.gmail.com>
Subject: Re: Non-interactively rewording commit messages
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jun 30, 2022 at 5:35 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Hello, all:
>
> What's the best approach to non-interactively rewrite specific commit
> messages? In this particular case, I am trying to automatically retrieve code
> review trailers sent to the mailing list and put them into corresponding
> commits.
>
> For example, I have a set of commits:
>
> abcabc: This commit does foo
> bcdbcd: This commit does bar
> cdecde: This commit does baz
>
> They were all sent to the mailing list and a maintainer sent a "Reviewed-by"
> to the second commit. In a usual interactive rebase session this would be:
>
> pick abcabc
> reword bcdbcd
> pick cdecde
>
> When the edit screen comes up for the bcdbcd commit, the author would manually
> stick the new trailer into the commit message. However, I can automate all
> that away with b4 -- just need a sane strategy for non-interactively rewriting
> entire commit messages at arbitrary points in the recent history.
>
> Any pointers?

Have you tried `git interpret-trailers`?
