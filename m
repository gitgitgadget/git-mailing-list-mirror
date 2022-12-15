Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B6C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 23:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiLOXJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 18:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLOXJE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 18:09:04 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC1A4A590
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 15:09:02 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 142so654066pga.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 15:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DKZVmmX54DVGRfJ+y5JBwjOGQsbeo2P0pdumUxKvEZ8=;
        b=LQZrSMbq+DnkL4FC7XGrMMM4+LSIlNpk1RPTdX2q4RLdfuFLeEGt0eeMva+MrAofVo
         3CirNO3UzRTk3Y2Cofx996967ER3w6wW1CgXUTkOHz6r46hWYFjB7pUN3G15LznVDOMS
         QsVVJhojQ5U4ZNK5lGEQPt6utdcnxEiU+IvI7DmvLVA2NE3Qckr5Eu/I08E4X81XjB+p
         8+UgcvFiDhXQDboIyuw6mq9Sn3zZjoApSkhFmtHDf7KvY5SPkeAarUT+hGZ+JWrEQeJ/
         Lha53CwnLcObrBzDYRwBPn5BFVS+JC6b9eTeI9dePpqLVd//a2Avbx6jUcXOK0tggir9
         +wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKZVmmX54DVGRfJ+y5JBwjOGQsbeo2P0pdumUxKvEZ8=;
        b=RJAGD0H61SG7EJvBEKTx/XsfytRg5ZBEX9MAlTJBlt5uV1ebQwtgEb9JWtA9TvNNxw
         Yk1NAnlcyLY6pql0Hk3qXsihevFQ43NZaV59LzrIKhXqP2Va1eYKfLKhUn/5BiO/bFN6
         n7a+oBHW70qxDzx2HsoVkQU09DZA1t1Vd1Js0obTssS9euV+4i29r4zU0U6Xj5cBV/6R
         qss2Qt2NnzzU9Sl+LO1XN+qYDfCE4zYd/nJXHdAv7kdxL7Aizh1aEfqa6Wv+MRxb10kf
         lQeygljdq/Vn8oGiGGniSB6ieSFkjnjMFQhQLYB7kmWe2K1MB0ZHV9jLTuswPerk9qUR
         0zSg==
X-Gm-Message-State: ANoB5pm8LwD7I6208GwPyEHWkyeSOuxfVPhFongagnHxL38pulhIaaTZ
        p3QGBCiS8orEg90Am5UkQHLKqfHtIovVsA==
X-Google-Smtp-Source: AA0mqf7C9J+O6+UwC2y5A7jVknZT2BFIj78qNVUa+tT68WbUu8Qgl+0uWZlB59ZbqOTeibJaX0uwmQ==
X-Received: by 2002:aa7:982d:0:b0:575:bef5:1a54 with SMTP id q13-20020aa7982d000000b00575bef51a54mr28883988pfl.34.1671145741618;
        Thu, 15 Dec 2022 15:09:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 193-20020a6218ca000000b0056ba6952e40sm116404pfy.181.2022.12.15.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 15:09:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
References: <xmqqiliewbje.fsf@gitster.g>
Date:   Fri, 16 Dec 2022 08:09:00 +0900
In-Reply-To: <xmqqiliewbje.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        14 Dec 2022 18:59:49 +0900")
Message-ID: <xmqq7cysp8mr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

Continuing from the previous one.

> * js/t3920-shell-and-or-fix (2022-12-05) 1 commit
> * sx/pthread-error-check-fix (2022-12-05) 1 commit
> * jk/avoid-redef-system-functions (2022-12-05) 3 commits
> * jk/avoid-redef-system-functions-2.30 (2022-12-05) 2 commits
> * aw/complete-case-insensitive (2022-11-30) 2 commits

These are all simple, obvious and trivially correct.

> * rs/diff-parseopts (2022-12-02) 3 commits

Not exactly trivial but very well explained and easy to follow.
