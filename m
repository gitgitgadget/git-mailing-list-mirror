Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770EAC433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50210611C5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 16:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhJEQwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhJEQwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 12:52:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5D2C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 09:50:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p11so1272657edy.10
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kO1Yjk1GwoP09myMepASnMjuZAjVqeP8ed1Z4fkY/zQ=;
        b=dtbSONBFsy6hmduBhqmWdLK9v5SDT0oruShnxCDziRM9LkYnJ8uJiNjwXTAPu8XYnI
         ljB9mPHvpHiPoiKm9M2nAJnMfb7I3Vga+4dE0e2nseENUWnMleRI/oyJ3Q+oDi1umZAy
         LJtUAf1U9Vt8DxpRa5PabGB5BLLDcNNcj55qGFRR4Ad8AcsRAxwBF5cglUgm5OiW46Kq
         YOIKABhN51wqMCl2TF4LueKmlObaquuaAGq557TKtko/IF2UvCTAAX2FS4YKjLYisIb1
         eTPNFAc7Bsy+SJuexmMvdasD9EsyR6X2tk6lq5QyPzui07DziaETzI+stTnARnbdU/Xx
         EEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kO1Yjk1GwoP09myMepASnMjuZAjVqeP8ed1Z4fkY/zQ=;
        b=q7/vxzZdAt44WkxxiUJaVZimcqMU17IU5cpyoKx40sDTu8tIAH73i4PPTvWcvkWtta
         5q6G/G0OS4XwEqnKvXz1T52uDQ1Car7eAx+L554bBlLOiFweoNUfX3673gZYo+HVVuHZ
         OypYQDXyyPmLrTGxQCkCrMvNs6Nzw3NUb5HV+PKzu3gR/CP6J9jK67WNxSxSR7bgZAT4
         9d8T7EOBUixAEeJmHQoPFdhBIliw/smST59hDa4h/k05+9kPgQu4dPdO/IIKPxdksN3G
         BQPyN/GNQJkNBdbzV1yI+ns2L9ZwhMK+Dk6OvChBHrK5IXxDUHQGrLNzLFk9ysGsA9ej
         OjbQ==
X-Gm-Message-State: AOAM530gVFLzUADH74ndGjEQGSA7IJW9VOGVhj6Gr8/Pn4c7eH6sZ0vN
        C90roBytYD5QA6eucQgF7do=
X-Google-Smtp-Source: ABdhPJz69gocbnY06vg47VMay3viNDtElypY+qzuiD2PfSY/SAqsroOXsaSULtoXU9en11AAA3jBYQ==
X-Received: by 2002:aa7:dcc5:: with SMTP id w5mr10279072edu.169.1633452646909;
        Tue, 05 Oct 2021 09:50:46 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a1sm8420136edu.43.2021.10.05.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:50:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: hm/paint-hits-in-log-grep
Date:   Tue, 05 Oct 2021 18:47:46 +0200
References: <xmqqo884tkxd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo884tkxd.fsf@gitster.g>
Message-ID: <87r1czjtzu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Junio C Hamano wrote:

> * hm/paint-hits-in-log-grep (2021-09-29) 3 commits
>  - pretty: colorize pattern matches in commit messages
>  - grep: refactor next_match() and match_one_pattern() for external use
>  - Merge branch 'jk/grep-haystack-is-read-only' into hm/paint-hits-in-log-grep
>  (this branch uses jk/grep-haystack-is-read-only.)
>
>  "git log --grep=string --author=name" learns to highlight hits just
>  like "git grep string" does.
>
>  Will merge to 'next'?

Encodings, timezones and ... taxes? Anyway.

I tested this and it LGTM, but I found a bug in how it handles UTF-8 &
interacts with i18n.{log,commit}Encoding. See
https://lore.kernel.org/git/87v92bju64.fsf@evledraar.gmail.com/

I've got a WIP patch there on top (which I forgot to include a
Signed-off-by, but Hamza: You can assume it's there:). It *should* be
fairly easy to fix in a final v11, but maybe I've only gleamed the entry
of that particular rabbit hole so far ... :)
