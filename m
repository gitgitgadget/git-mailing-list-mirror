Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A437208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 21:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbeHGXSC (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 19:18:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35571 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGXSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 19:18:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so511623wmc.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wVx0gWQ/+m8mKOC4TmdNpdc7f9EFx14NajPRM4tyU1E=;
        b=LFj3cIhzOK/DAgVXjTC2H9VyteD8LDhoDqzfpqxc9sFOS8LrYLihaxcj8rtXdW4xES
         YfVy1hF7Jx1Zxf3tSVvQpEgvQKQW78dVdgIE/8V/5DysrWod3KmqUnd5ax5mejkwrtHx
         JblWrJA4NTRqcUd4xl3jsaV/b/N6B4dfvByPomtNvbBKZkMcZgFzuyPz2q0IKljgaMJO
         QmKFFQyoZpKZxwJGhk4mN5p2Wurv7IhtJ3JuZdlfFMh/T/FbQeCFwY/pWxuvb8brSr3M
         drspxAPt20P+c7ffkFXhA0faaR2wvl9XEXL6aez9z8VltoASqqa8YXMiXNInfuqInpR8
         6OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wVx0gWQ/+m8mKOC4TmdNpdc7f9EFx14NajPRM4tyU1E=;
        b=IG2nSi7slrqxIz7a7hDXb7w7OFbuM+oRKLHvUr/6UIjj4f9D2T1god/ZB5L5GuT3fz
         K+3u67ykxXAx7l0ykOrgeQJsFBCCD2d0pnNpc4YveDFwT9rw2JslHEL6hwKfW/LiZcBP
         /RfxygIQR2RfApnbDJ+TQNIF7rw/tYUr0Xd0GaBM2pkdHmuIA45dmrSm1nENrszS6CdQ
         N36ok2sYy7G0olHDeJt6PqJkDyYbEu35Sbt4dSGrP44Ko1HHaEKXVOoMw0B8graQo+EF
         ZRH1KoPpteOkrZgF804jld8TbGmqvVeINO+t51Fxwl8WX2qsL2ZCuiHBH/eKh2N2CG0o
         MO3Q==
X-Gm-Message-State: AOUpUlH1SODGaSMvO8C8L3q4a3ys74KA/5CnuF/mF43G+zKoFhHPnWzl
        /lawpannngA5aThnyMn3hhc=
X-Google-Smtp-Source: AA+uWPxtBoLDySNlDqNNMJDsjZmIvVN52oO7t3LYpDfZ9BX7ST9q6X5tFzyo5SjQdzJfXIU9fD2JSg==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr36772wma.72.1533675704726;
        Tue, 07 Aug 2018 14:01:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2435980wrp.55.2018.08.07.14.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:01:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     sunshine@sunshineco.com, jrn@google.com, git@vger.kernel.org
Subject: Re: [PATCH v7 0/1]   sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
Date:   Tue, 07 Aug 2018 14:01:43 -0700
In-Reply-To: <20180807125108.104293-1-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Tue, 7 Aug 2018 14:51:07 +0200")
Message-ID: <xmqqva8lki14.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Fix nits; remove debug printf.
>
> Han-Wen Nienhuys (1):
>   sideband: highlight keywords in remote sideband output
>
>  Documentation/config.txt            |  12 +++
>  help.c                              |   1 +
>  help.h                              |   1 +
>  sideband.c                          | 125 ++++++++++++++++++++++++++--
>  t/t5409-colorize-remote-messages.sh |  87 +++++++++++++++++++
>  5 files changed, 217 insertions(+), 9 deletions(-)
>  create mode 100755 t/t5409-colorize-remote-messages.sh
>
> --
> 2.18.0.597.ga71716f1ad-goog

I'll squash in the following while queuing for

    <CAPig+cScb_7s4a_ZSVCsr+nBxAHGHZVMZOtnrOgbhZUi96-VFA@mail.gmail.com>

Thanks for sticking to the topic.  

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 33bc1a3def..9a38dd2cbb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1266,7 +1266,7 @@ color.push.error::
 color.remote::
 	If set, keywords at the start of the line are highlighted. The
 	keywords are "error", "warning", "hint" and "success", and are
-	matched case-insensitively. Maybe set to `always`, `false` (or
+	matched case-insensitively. May be set to `always`, `false` (or
 	`never`) or `auto` (or `true`). If unset, then the value of
 	`color.ui` is used (`auto` by default).
 
