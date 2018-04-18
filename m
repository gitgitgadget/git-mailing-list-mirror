Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF9F1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 03:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDRDnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 23:43:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42148 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeDRDnH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 23:43:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id s18-v6so716597wrg.9
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 20:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y39FSDosWW/wcTjQ+iICU8UmQsW+EtfduFk9jQ3F16E=;
        b=BYL5yKE1mZEBWooc6tFa2pLlwoCtxYsdXu5am/0q2oXYSV6kS542260oJI/LIOJeEN
         ukQFGBr57RH6g/zsZA4SQXaqLZ5BUqqAGW1lVUyUZVkW/ulLQXBttkGfDFlyjPpbSQj1
         JxGh3Je0DJXnqa5PNdV1bSdfMTrrPl+6KuZ447I7YpWm+C7jbPvX2UL53ABdz3KjN+GG
         Ss8MtMd+un7mG/QiNr7BI+kzzLfRQRLiGRCOtfl3OXQZNTUE/XbvgkIGVF0ow0ZgR1/V
         ogKs+nUtnrCu56OjhN+Sjfx2rlXC73he2j0mlrHMV3UM03oySHoC1nJOFaSNKULvl9x9
         w+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y39FSDosWW/wcTjQ+iICU8UmQsW+EtfduFk9jQ3F16E=;
        b=GiWresVUxn+wJtMOLdIUEOMbK2hkJ54E1kxOo/dMqu5H6sB4yehAu1dEa8QW8ryEF/
         aHhCIh0z3V+hggGj8/9RBc4V02vGGORkgJ6zRlUfr83nl26gEs9bWrMR/8AVZUM1ukIm
         o8XoOqmP2oOdYzlt+VCN43JgVcWOTbae3mFWPLnxpjcnBdTpK16VH53Mzw1ou7rAYUfC
         kb+gqKPk8takjQvFYLEjAnC1T7nsIOyGJoHLqBnhLBgvZP7pPudqLuuDyZ9OlLTzH0kr
         wq0MHnGA+cTpcpGvnTRI7BWjakfsNB1Jw/p9g9lrzJff5+yKZrjNe9+tXDDKw5vjxoqL
         NRzg==
X-Gm-Message-State: ALQs6tCoiYXMPVpkvqICrVit/7+CA0JTOFypLjuRhrOFuqUyRIs/mztm
        jJu+UMBDlQ8A+UD91Kxj52o=
X-Google-Smtp-Source: AIpwx48ZDLQW5ABOwyuKFVcR0TR6WC25zRfk+tXTN9j6FZytQhb2GLyeb1+s9ivMfXQYXBC8voeOPQ==
X-Received: by 2002:adf:86d2:: with SMTP id 18-v6mr254119wry.232.1524022985724;
        Tue, 17 Apr 2018 20:43:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m79sm13520050wma.0.2018.04.17.20.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 20:43:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
References: <20180417181300.23683-1-pclouds@gmail.com>
Date:   Wed, 18 Apr 2018 12:43:04 +0900
In-Reply-To: <20180417181300.23683-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 17 Apr 2018 20:13:00 +0200")
Message-ID: <xmqq604pji2f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> So the other half of this patch, the part in git-completion.bash, is
> to uncomplete --no- options. When you do "git checkout --<tab>",
> instead of displaying all --no- options, this patch simply displays
> one item: the --no- prefix. If you do "git checkout --no-<tab>" then
> all negative options are displayed. This helps reduce completable
> options quite efficiently.

Clever.

> Of course life is not that simple, we do have --no- options by default
> sometimes (taking priority over the positive form), e.g. "git clone
> --no-checkout". Collapsing all --no-options into --no- would be a
> regression.
>
> To avoid it, the order of options --git-completion-helper returns does
> matter. The first 4 negative options are not collapsed. Only options
> after the 4th are. Extra --no- options are always printed at the end,
> after all the --no- defined in struct option, this kinda works. Not
> pretty but works.

So, the earlier mention of "clone --no-checkout" sounded about not
losing this historical practice, but (desirabilty of magic number 4
aside) this "show first handful of --no-foo" feature is not about
historical practice but is forward looking, in the sense that you do
not mark "important" negated options in the source, which would be a
way to handle the histrical "clone --no-checkout", but let the
machinery mechanically choose among --no-foo (with the stupid choice
criterion "first four are shown").  That allows other commands to
have many --no-foo form without overwhelming the choices, but I am
not sure if it is much better than a possible alternative of only
showing --no-foo for more "important" foo's when show_gitcomp() is
asked to list all of things.  It would certainly be a more involved
solution, that might require an update to the way how the choices
are precomputed (you'd end up having to keep a separate "use this
list when completing '--no-'" in addition to the normal list).

In any case, count this as a vote to support an update in this
direction.  A quite promising work ;-)

Thanks.
