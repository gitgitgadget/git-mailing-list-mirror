Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFD71F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeEDHX0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:23:26 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36189 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEDHXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:23:25 -0400
Received: by mail-qt0-f193.google.com with SMTP id q6-v6so26184953qtn.3
        for <git@vger.kernel.org>; Fri, 04 May 2018 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fOkyF4e8kANznwX49SYPThLe7CJDtciIgURWqloKdTs=;
        b=qO1GT0Xp3EI5MXNjPEFNPFLQx3D8JkbOzEp0fcSsItNv9HCo8FJLKZHL//e/DYIOxn
         gHMjv6OBZnwEUQrPtVgoGY44Livnx5GXWcgQC3YE8wDxxgMLsTy/xqh0PVzqwzROWRFB
         VstpR5IwOmB6dGiuN1gQkH466GIOrvK6J8F1sMTnXNqHqMpyM9e0a4kd5zNUukH9VbOI
         bMTf/M50Qwj5H7KXJB/RkxFVUJ5ztmIXsZyr+d36/CtVhQRZwIATpz9d4D/s6g0EH1ao
         RlmS18LUH0lybxv9mRW4KccKdgVvmsFzpJ/bGl9ZbpP1Fe8RuWuvW48ZByrx7aAgJ7Ue
         foTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fOkyF4e8kANznwX49SYPThLe7CJDtciIgURWqloKdTs=;
        b=XK1F6pul0XJ21CPN1JPTfvmBGI0BR/MiHJrsp8Q2X3BhSSA+PiAZBie7ML4hNO96yx
         yEiknpDxaiwYQMtnwcxuOjE7qQIRqlFxD4j0JzqkRfiEjbDPzCa+Z1U6vuS+h2C8tVIn
         kOMWjBdoPtYMLMQpVZXXJkVIFHK8ZcskOnlAfjM2YDLdgX15dzccSQIWYEA2FHRQ6n9K
         u61Q8sA/49pTAfUYrPzspivYnBQVnDsf07M6Z7bl8WMmh9qveicMCP4zK5qgsi3rPiFU
         /0UfScJedcIH+9UG/wgBYZSTp1FGViOtQ1orvA2UtYiziFBFlM2dd26ue8gyhCue8qeM
         5wbg==
X-Gm-Message-State: ALQs6tAuA0UrBkS0ZNUak/8NybL+He6pznGXQCtoeSn45600eWmJ1bKt
        6OXhza2HrnMXhZVicszQ+cTakdc6tlegqlLxHJgNJA==
X-Google-Smtp-Source: AB8JxZr9h0NXov921GTT9SouGlT29O3i90bWYgjfL5qd1YYtu743IcBT9RLip3QGW0mv1I/PyR/zf86wn8LNwP5pJik=
X-Received: by 2002:ac8:17d1:: with SMTP id r17-v6mr21890991qtk.314.1525418604911;
 Fri, 04 May 2018 00:23:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 4 May 2018 00:23:24 -0700 (PDT)
In-Reply-To: <CAPig+cSRBBzXDWMJd5k=ZGOt_ayATWB6fZQrcMqJkP8ja4Tq+g@mail.gmail.com>
References: <20180502105452.17583-1-avarab@gmail.com> <CACsJy8Ae9PP8BMbyX5mPJukGpC06jMvvbg0fMFL+fu+EUg1kPw@mail.gmail.com>
 <CAPig+cTZyYC-1_TxL2PrfOF6HAktUxxM+g5EXcByS5fCDMdCHg@mail.gmail.com>
 <87y3h1ykwn.fsf@evledraar.gmail.com> <CAPig+cSRBBzXDWMJd5k=ZGOt_ayATWB6fZQrcMqJkP8ja4Tq+g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 May 2018 03:23:24 -0400
X-Google-Sender-Auth: 1DB9LgGW0qoBMNKTKn4CHlkIxZs
Message-ID: <CAPig+cS90ro649V2Oy5kytwpAsmYWdGG3depHhd1AFq3Cxn=7A@mail.gmail.com>
Subject: Re: [PATCH] checkout & worktree: introduce a core.DWIMRemote setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 3:14 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The setting up of a remote-tracking branch is DWIM'd as of 4e85333197
> ("worktree: make add <path> <branch> dwim", 2017-11-26); it doesn't
> require an explicit option to enable it (though tracking can be
> disabled via --no-track). The "guess-remote" feature does something
> entirely different; it was added to avoid backward compatibility
> problems.
>
> In long-form:
>
>     git worktree add <path> <branch>
>
> adds a new worktree at <path> and checks out <branch>. As originally
> implemented, shortened:
>
>     git worktree add <path>
>
> does one type of DWIM, as a convenience, and pretends that the user
> actually typed:
>
>     branch=$(basename <path>)
>     git branch $branch HEAD
>     git workree add <path> $branch

This explanation isn't wrong, but it conflates two separate features,
thus is confusing. The $(basename <branch>) DWIM'ing from the short
form of the command, "git worktree add <path>", doesn't actually have
anything to do with the DWIM'ing added by 4e85333197 ("worktree: make
add <path> <branch> dwim", 2017-11-26), which merely tries to DWIM a
remote-tracking branch of similar name to $branch (whether $branch
came from long or short form of the command), so I confused the issue
unnecessarily by talking about the short form.
