Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288BAC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0232861433
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhEMGqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:46:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F48C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:44:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c17so20841097pfn.6
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IJlvE6hKCOmdBq2Bovh18YaVNEHx939lWV90TAsMObg=;
        b=mv8PDipXtqCZi8qFEhf3Ts8T/rgW8TSzKsd1bu32l8T5s79ZFGcZdJIWxajMIIlQtK
         cckx0hKdMGi4EkqOgQ+a07RNSLZ+5Ub07dUlM4W/WjZhRayNBYgfo9j5mygX6aBp2Dzb
         0XBKU9gDnQTkXTYJ3lRzTeb18OT/Yw5xVRUank5AqnH4MVsi450a1t4t3F80ufTQ183i
         52twtl85RVYlzg3sL6yv8tvelo0qvMyICj1S6AtfvXHIScd8Rffn17CdUPG8PDVy4/Qk
         aJKYhz4aSla20AoY31zZrVczEtygQfIms7kMM7w0Bo7oj8ZTo9ClZ4IFrwwcPEjU57Tv
         f6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IJlvE6hKCOmdBq2Bovh18YaVNEHx939lWV90TAsMObg=;
        b=eXTvpEbcqf+BtmbQ2z+l5udj4szmglHs1nuMXmNUqI+0ScyKqI+261+5jpWnooCZi0
         6G7hCnAg+APGSOYrDwpyJJ79tuFC8qR6nq47La2SQTLCbyzbZ04d4CcN0NBNO87Qp2fN
         iskCUHggCbvvPutL3ntL41wf3I5gOG/1W/FOA3wdQydVsfJ7ftvWw1g2uhlxJgBMT8Zm
         DKqKJLtWVy9y51c3W40lJG+tXNjGybVqA7G6sqexg+/EAtQE10rUcCLAPF18++7hnpeC
         cBbl85vUX53Prh+4GRTMD/AepS0/1og4DzVhMqnFELykMzM2qzK4PeyZ8B/I8WJVBUhk
         Eq0g==
X-Gm-Message-State: AOAM533M1ZgsMUQGRS1ik03avBHbBGF+/ECUJ+CyfWRXabUPJTiLjsXX
        8ucUJbh0MifdqfzT7Pq9M/U+Dt0ExrqZEg+nq1E=
X-Google-Smtp-Source: ABdhPJwyPH+6NGG1lAIk4pvJRLpw+oHCavQsVNqq/pjL2Fhw3j8vWOSetWknHYgJSLRxFPZLg2qFf5lQSo04FZcp5ao=
X-Received: by 2002:a63:5947:: with SMTP id j7mr41024288pgm.248.1620888296579;
 Wed, 12 May 2021 23:44:56 -0700 (PDT)
MIME-Version: 1.0
From:   Teng Long <dyroneteng@gmail.com>
Date:   Thu, 13 May 2021 14:44:45 +0800
Message-ID: <CADMgQSR=f0kAnX0Fat2vSpVaG62WX9VAkU0xNeN_hiDaHXu-eA@mail.gmail.com>
Subject: Re: [PATCH v2] packfile-uri.txt: fix blobPackfileUri description
To:     gitster@pobox.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

>Yes.  Some people seem to omit the final response to reviewer
>suggestions on the previous round and just send a revised patch, but
>it is much nicer to cleanly conclude the review cycle for the
>previous round with a separate response (it could just be "yes,
>you're right---I'll incorporate your suggestions in the next round,
>thanks") before starting a new cycle.

If I  send a new patch cycle, the "--thread"  argument seems
to be recommended. This may be the reason why it is easier
to understand when submitting a series of patches?

I may try to use "--thread", but it may make this whole
patch more confusing, sorry for that.
