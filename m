Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8A3C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 18:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA1564F8C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 18:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhBCSAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 13:00:01 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:41617 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhBCR7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:59:03 -0500
Received: by mail-ed1-f48.google.com with SMTP id s5so654418edw.8
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 09:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPRPhqA8t12OPD1QrX7cfeu7AdUiM+pi4UnOyV9VTMo=;
        b=QkRi1stumoyGUxpR+JG6qSo1g6uqaCdbpp8OFj/aR4gYsQDRgkNlfuLQoy0oybrRN4
         3qxf2+Igx34yCZZH4s6M7/+Dx9kIkrgU/nvBjIXtoLiYor494uPJfpNO+9bnj+kx7qfk
         BoqpqYvK+1QXKVUZDg4cOMmEM9A0aGFjTSi5QA8pvCpKaKWQCIxeIJKyEOVVGTKta/Xg
         yi6M4es0Il0gY2vIzGHsG2aP2SdbdZa+n+nMDOcNAtC8EGILCdV5NRv2ugumRRr8zbtw
         vmz1zLa2MFnTyFOThc9ZiM4Rj/IepxGmRZlj4ozGfbuM38jhIfTNjJOeMnddoOWyPeZA
         ibmA==
X-Gm-Message-State: AOAM530z13EdyHWmjuQpmATxDl64AnwhFBpVIjyGzSK/tZce95iW0Z8F
        dSMdj0/DjrgOIXdkymdu56lWlH+KJoVuEIgCX4I=
X-Google-Smtp-Source: ABdhPJytaqMojNqD4pxMcsc4OZrOBw8bJTlh3XVBGFoi62JlQzvtRUG1Xr0nts9wERwr252uqV3HM52xtGeOrryuZVE=
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr4252026edb.233.1612375101484;
 Wed, 03 Feb 2021 09:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20210202200301.44282-1-me@yadavpratyush.com> <fdfe1661-463b-fc18-02cc-4c6e22ce0463@kdbg.org>
 <CAPig+cTQaPTNnGcd583B=xoVUR1qPb372Y_x9szROfMcA5h+tA@mail.gmail.com>
In-Reply-To: <CAPig+cTQaPTNnGcd583B=xoVUR1qPb372Y_x9szROfMcA5h+tA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Feb 2021 12:58:10 -0500
Message-ID: <CAPig+cQxASd8YNm+6E4XkiEoR__hAW8nrUbEkaBoJSicpq_rmA@mail.gmail.com>
Subject: Re: [PATCH] git-gui: remove lines starting with the comment character
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 12:48 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> So, perhaps one way forward is for Pratyush to emulate that behavior
> and insert some text into the edit box saying "lines beginning with
> '#' will be ignored", or add a label above or below the edit box
> stating the same. (Of course, the actual displayed comment-character
> should be determined dynamically.)

Even more fancy would be to add a checkbox below the edit field which
both enables/disables the "stripspace" behavior and allows the user to
specify the comment-character. For instance:

    [x] ignore lines beginning with [#]

where [x] is the checkbox and [#] is a text field in which the user
can type the comment-character.

For convenience, the checkbox would be checked by default, and the
comment-character would default to the user's configured
comment-character or "#".
