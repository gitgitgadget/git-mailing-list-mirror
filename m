Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87C61F424
	for <e@80x24.org>; Tue, 24 Apr 2018 01:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932733AbeDXBuF (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 21:50:05 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:42459 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932665AbeDXBuE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 21:50:04 -0400
Received: by mail-wr0-f177.google.com with SMTP id s18-v6so46138998wrg.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 18:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rPfvXVwraKeKsanq9B89LjrFD/9sK1Aun7U2XEgNmi4=;
        b=PtatLGGXkkvpuzpHNYymX8H7v5dagKHmt7RVBGtZiupqJk1mYx5yQkuXGe2/psU7wk
         sNwe8RZ/yE/n5btuX9doDa91uvtFsGzspsehSj613FylZinSlopV1xYEBphIfJ4OZabA
         SaKmZkztKkSHLkHqoeWB+scof+7frfj+K7EBrIn0BTXcYlU5kT5IbLif+M2rWwz/MObq
         38yt8V+2DZOEDcNS6AMlIRJ3mOFpmjStp+rHFNZlb75FgSx9Mv6l6z/qlMvjkJNah7KU
         6exgxQxmt6plF5VcUI7UkH55lmcYmWyyhruNsDgXOmo8yr4PjeO7f3vjqzAiCsDFtjQ7
         LD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rPfvXVwraKeKsanq9B89LjrFD/9sK1Aun7U2XEgNmi4=;
        b=q0AK3B49d7PcUyvklJaj64XDVIBMTKUHU/+o5OHQZtF2TloPuGMXzdgROgnZq3P9pg
         hOe9tC8If4ApySVlkbSM4LK71/DxGk5hTFX7BOTmmqtrgGBHE8bcIH3TDF31NR7UcIki
         bH35N5S+nxPXtBXPbR62Cb5qA+Mm9M036Bms+u0afQQJjqDld470M6efNNJBziG3D42p
         DYdFaAgkxmQ50lfi7PCVbtftgJXdG25lcJ6Ec8Z/e0M32sIcJ+app1vOcTnW7falX9g1
         NTmT6hMm/P5ae5LHsLMh0wfmTX+dN5iLEdkB4PYQAhACogxecI+yC+7pqRuYCmiobXJu
         kOYw==
X-Gm-Message-State: ALQs6tD5hBxHmb8kHN47BTgVpuchnmQFbgxAOt+4PAPWmX9FPE1PHpbM
        I3/X9VQfDRM0up2is6L4g08=
X-Google-Smtp-Source: AIpwx49v0EamVA+C2v3EntI3iaR8qZ24fP20fDmhT9it0uh6uqe61L5pNCLElmJnopsF9y/iBNOBAg==
X-Received: by 2002:adf:ba85:: with SMTP id p5-v6mr19584414wrg.196.1524534602746;
        Mon, 23 Apr 2018 18:50:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w40-v6sm18916407wrc.69.2018.04.23.18.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 18:50:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Dan Jacques <dnj@google.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Some add-on patches on top of dj/runtime-prefix
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
        <cover.1524309209.git.johannes.schindelin@gmx.de>
        <xmqqzi1t74zo.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 24 Apr 2018 10:50:01 +0900
In-Reply-To: <xmqqzi1t74zo.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 24 Apr 2018 10:44:27 +0900")
Message-ID: <xmqqvach74qe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> base-commit: b46fe60e1d7235603a29499822493bd3791195da
>
> Basing your work on the tip of 'next' is good for discussion, but
> not readily usable for final application.  Let me see if I can
> untangle the dependents to come up with a reasonable base.

I'll queue this on top of a merge of 'dj/runtime-prefix' into 'master'.
Merging the resulting topic into 'next' and applying these patches
directly on top of 'next' result in identical trees, of course ;-)

