Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96292C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C89C64E02
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBGS6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:58:43 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:43222 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBGS6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:58:42 -0500
Received: by mail-ej1-f44.google.com with SMTP id y9so21206259ejp.10
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xA+Q2BkRO8LhbWdLKoAjmyln3oaIwwXdxgqxmhdS5hU=;
        b=bAvHsRG/iMAt+mmrELtSrkTIjKA4pON0VEojLyIyGT8LV8Y2GnM+q4p+gXiBfAN6cX
         A0STB9fcJCmGFGlv/mWZ5UEZGqZhFvjIC537r9pI/XUUUii01n5Rfw0KgSHXiQxhtJgr
         pt7wtLH5U3Ykq2+B9SQye8k26WdrpkP7t52MatwebVEdvr/VmsgPXjDSklgh2Z/rTt9K
         optWQr00ralkyx6DJZfmPVMybU4G/CIjGe9M0eeWjBHQRrjlwcUhauab96txsnk1dnKH
         F7S+thyTPZgPqFr3NtBZUZez1vSRP0cBTS8xF0D5FIak0ssttqCwd3KLlz+tQ72zqMCu
         vd8Q==
X-Gm-Message-State: AOAM533zz4ZJ5pJ2UdUx5V7YU+L2Km8SKHi0xJXdu1Qy5Y7IH5KQ8Jyt
        /ApLiFvFhgw72rftM090++3lrAcBaqlb5G3tAjE=
X-Google-Smtp-Source: ABdhPJw6WEEVgPwlzU8OzPYfN9tPtSlCQHs/656hUO6dEu7oJgBBL03Tl2mLC6C72Oz2KxVwCgwqyoLNA8dbPGU7rzI=
X-Received: by 2002:a17:906:3649:: with SMTP id r9mr13388613ejb.202.1612724280701;
 Sun, 07 Feb 2021 10:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com>
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Feb 2021 13:57:49 -0500
Message-ID: <CAPig+cTQaP_FvixPiwosPybxy-C91pvV_FvQfwf7cO0QGpH7UQ@mail.gmail.com>
Subject: Re: [PATCH 0/7][Outreachy] Improve the 'fixup [-C | -c]' in
 interactive rebase
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 7, 2021 at 1:18 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> This patch series is build on the top of "cm/rebase-i" in the 'next' branch and
> improves it. It fixup the source code of 'fixup [-C | -c]' command in the
> sequencer, do some fixes in rebase -i, improves the 'fixup_-C' like commands
> in lib-rebase.sh, update the test-script 't3437' and fixes a typo in the
> documentation.

Thanks for working on this. I looked over the entire series and left a
few minor comments. As mentioned in my [6/7] review, you might also
want to consider splitting that patch into several patches (though
it's not clear if the extra work of doing so is warranted). Anyhow,
aside from some botched indentation in [6/7], it all looked clean.
