Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3B41F954
	for <e@80x24.org>; Wed, 22 Aug 2018 17:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeHVVGS (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:06:18 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:40342 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHVVGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:06:17 -0400
Received: by mail-wm0-f42.google.com with SMTP id 207-v6so3002794wme.5
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:references:cc:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=41RGJIVDzjEOMP3tkIWuA9GCilbDU+Dz9mxYZTFkSDI=;
        b=vhV/NESea8LA14tcKPHEhiNixYAs/CrFXttGpNmkVsTHOsBImg0Tf2fFWxasb7sYxg
         goqSWl3PwwSQO8prA68VqKphWQxKzS0STJd1Q/jNlpHt0MUX1MS2IS1EIeDd2FIXG7ab
         u8mXtDsAmTniqxgoAYIhDqZONTvNzpUGhbvDbn/oACwIb7K2msAknrRCvVenbf21OCKf
         y1oAStWO9NFseHUfYGH4IqutYpUZZFUF1KrmVG64ESUP9bdZFGMbQHpIhNk17FO/nh+A
         0A0PP8/bbclmKdtFl1aHeuaejl9LkXnMhZKsxnZTu1bSq+CuyF9Q3zPJcQu1UigaXR0t
         NOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:references:cc:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=41RGJIVDzjEOMP3tkIWuA9GCilbDU+Dz9mxYZTFkSDI=;
        b=ilKHhzimWwddWvc5kmLqnCWSR7dz63azIpexlSudRrMd7oeGLp3OtNFMbMwIKNRvmh
         YhrZgV0nfqMgftQS9QWsbMn+BHjZniDkqRJvDOZmxCu4x3EeXd36fbb1oaPnDg92MfM/
         uXG6Ua3gr3yrFj6pgTRtlcE9OK0flHij4GWSpPbKu1aKGc9S0zdTHcKeUU0ablQXr6qr
         9Jpb2aabXLzNbksdQy4mRiteCj6jiKOhejLOXuOGMOgtGgIneZxF4zLH9UiltL431yM6
         7QKA2P09BUItn02GIDIAdoahzIWzSMuOqC9ZV99gs1ZtElrRUUYQlJEn/fYMrWZ0gz82
         1PSw==
X-Gm-Message-State: APzg51DB7a+iBgQ/FH86bJljsxg0BMmSJrHzqxVVUi2LQHD8GV42QWsT
        qEtkOFkWTt77aPThktmPMAA=
X-Google-Smtp-Source: ANB0VdYUQTs9lJEnfa6ALwrz/wJjB6M2OVNQ9qG0qAfNyuv+R0e6OH4933gPOoK6y31lOZIJfsoDPg==
X-Received: by 2002:a1c:1510:: with SMTP id 16-v6mr2866528wmv.74.1534959626888;
        Wed, 22 Aug 2018 10:40:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v7-v6sm1554904wrr.19.2018.08.22.10.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 10:40:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Aug 2018, #05; Mon, 20)
References: <xmqqsh38admf.fsf@gitster-ct.c.googlers.com>
CC:     Alban Gruin <alban.gruin@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Date:   Wed, 22 Aug 2018 10:40:24 -0700
In-Reply-To: <xmqqsh38admf.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 20 Aug 2018 15:15:36 -0700")
Message-ID: <xmqqo9dumh9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

Mentors (and GSoC students),

Two topics your students have worked on conflict heavily at the
philosophical level; "rebase in C" rewrite assumes that backend
implementations are forever written in shell and can be invoked by
dot-sourcing ". git-rebase--$backend", while violating that
assumption is the whole point of "rebase-i in C" rewrite.  Trying to
use them together would of course not work without a bit of "last
mile" further glue.

I do not think neither topic is ready for the upcoming release, but
can you help your students to come up with "the final step" to make
the fruits of their effort work well together?

Thanks.



