Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE830C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 12:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiKVMGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 07:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiKVMGV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 07:06:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D931F90
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 04:06:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b62so13944851pgc.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 04:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8BoVB+DMhuzxVZxvVn79Th4T9O6z/D3pepUeweX3/qA=;
        b=EV9lVfQc1pmZ7dtjnOusFqYnljPL17oTB62f7LjTtKp4lptTYXO64P+JOe+5tIOZDq
         dbvHXyjiCTmT5e5BNlizdANgWaWjRgXfqwscWIfjQipRF2syUvI+fRUMffjmhtSKqR1y
         D7oM4JubLGNvN8791f15328gNg1/ZOyIynJ7eAcpdvLrm/e9TGj+K6C5fR+w1Sodj9BM
         LEDq04uXmfNXY1cYvXw0v9ukagT8A6Rawnh/7fFRZ7mOaHzAVPoA1TFv5zBulcbWuQok
         mJKa4pB7UKxLInSiEBDkJwCY8vgUoUqPWr4qRu+Te8y3mz8AeuGrEv9YuoGAxf64uCop
         wLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BoVB+DMhuzxVZxvVn79Th4T9O6z/D3pepUeweX3/qA=;
        b=gBz+lCm1uGHF+OpZ5SlkruM1rURk3uZq9VmPZAw5YjIPBcFwRXAS939SUL0RkMkgpK
         4wxMK0yMC7oGKWJ2201m4Zi//US8OL30qARbJYEYVv2Nf+LA3oJx1OPDaGqCsXRqmJ0M
         rZwiTrofcjBrlefMnLkrWxoW/PiE74H2X77+9IUiI398i1nUQVkh8YjGsPaukpgyFBpf
         PyrDb3xPJpZ9R/JsQVielpIDO8k1IGTWzaus0HLv/C19RyAMKtBD96/9l02+F2jMC6gR
         C7MnAQIiXbS3155aX+YCopXY6X/i1ZWf7SdrQvo1PQszoh9YnGvilZ1Li6h6s9era3zL
         0bUQ==
X-Gm-Message-State: ANoB5pkp8Vdp8d9DHRoS3UC+rgKXqOXaWHLUEfmrCVahGpdmtwP3oE10
        Tr9R/wuH7pnypbK3s7Qj8aMu3DggNmYKxvZ8U5HHhsNxjIc=
X-Google-Smtp-Source: AA0mqf642Do7fLbFCa+wsgM7iv+rsn2XJLnrfAPzOTMLtrfHiBOGAbjnJZ1LBwH9vnG9D6v+EFEU1CuY6I1vazwM8vw=
X-Received: by 2002:a62:b501:0:b0:563:771d:417f with SMTP id
 y1-20020a62b501000000b00563771d417fmr5437783pfe.45.1669118779239; Tue, 22 Nov
 2022 04:06:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
 <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com> <b4ad4c083c96d20873a649aab5f39cd061bd662a.1669033620.git.gitgitgadget@gmail.com>
 <Y3vId3rOmmkJnkGj@coredump.intra.peff.net>
In-Reply-To: <Y3vId3rOmmkJnkGj@coredump.intra.peff.net>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Tue, 22 Nov 2022 21:06:05 +0900
Message-ID: <CAF5D8-sAmxDkduPbvEf-myr6iBm0N00SEDgCcSfNE99t9qSBmw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] git-jump: invoke emacs/emacsclient
To:     Jeff King <peff@peff.net>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 3:50 AM Jeff King <peff@peff.net> wrote:
> You'll have to either shell-quote the contents, or stuff it in a
> tempfile and read it with something like "cat /path/to/tempfile" in the
> emacs command (though I'm not sure if that would be racy when you're
> using something like emacsclient which may exit before the main emacs
> process runs the command).

As you pointed out, the previous implementation has a problem in cases such as:
      git jump grep "hello world"

The reason I avoided using temporary files in the previous implementation was
a race condition when editor="emacsclient" (emacsclient exits without
waiting for
the asynchronous execution of the external command). But I found a way around
the race condition, so I'll change to use cat on a temporary file.

Thanks,
-- 
Yoichi NAKAYAMA
