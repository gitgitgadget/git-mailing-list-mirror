Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16BC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 08:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiCIIzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 03:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiCIIzu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 03:55:50 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC01113D911
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 00:54:52 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id r2so1940675iod.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 00:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSFbfWcThFItYnFKPPxaHLR95pXJ+lXoxszwvnrHXWg=;
        b=vPkIb4wROq1dDiqdYzIuzEtIevuKyPHfISbQy5WOZtA6A+yCDzPAX+TcTOnznFB+zi
         46LBufBARNQGg+HLpvA/QD8R6sHGFYbw8srIoxnFBzIabCQB558IukOU88oJKPO1I0Qm
         m4ZvhhDOMhI3zLX7/f656qvOVw0lMxBli47YVM61l7X6gtrLTf1SAowV/9Wd24lPzhCU
         j8us3MHoPURKr4RZYhfdOilxhPgi5owXj2K+KJ70QkTRSmOqxrL9y+YxzNoYhNRF4GLK
         h3BWg4yBSxTsyCrsfVyAzp4O80NQqqEtQgV8IK44gFCnJjT1qCRNOYfZzsKicFzk5cRd
         687A==
X-Gm-Message-State: AOAM530AiPwUi/HDlUoYbByaxS7WjpMWeFMZMRtKxMlAX7xQbvPmWx/0
        8CTDN2wpzlVQPEZ+31X7lUF4COSF2sRFzsJYTznigR7ML10=
X-Google-Smtp-Source: ABdhPJzlruss4ZEVLG2iKSHtgtdAUmlF+xLOK0mTEBJZrqDAplWiQX3LKBBT2qBajk1onsjjYkR9l3ntAk0STDUDEZo=
X-Received: by 2002:a05:6638:1416:b0:317:9b05:8ce8 with SMTP id
 k22-20020a056638141600b003179b058ce8mr19082493jad.138.1646816091872; Wed, 09
 Mar 2022 00:54:51 -0800 (PST)
MIME-Version: 1.0
References: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
In-Reply-To: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 9 Mar 2022 09:54:15 +0100
Message-ID: <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
Subject: Re: git notes question
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nuno!

> Is there any way to remove the default "Notes:" line on git-notes? I
> don't really mind to have it in git log but when generating patches for
> instance, I would like my notes to be something like:

Just to be clear, in relation to which command are we talking about?

For git-format-patch there's
--notes
which I assume doesn't support customization.

For git-log it's possible to customize how notes appear in git-log
using the standard way of formatting log messages, pretty format.
%N
is for the commit notes
https://git-scm.com/docs/pretty-formats#Documentation/pretty-formats.txt-emNem
For example
  git log --pretty=format:%h%n%N
displays each short hash and it's corresponding note.

It's also possible to use it when generating todos for git-rebase,
however, they are written with a prepended new-line which breaks the
todo script :/
