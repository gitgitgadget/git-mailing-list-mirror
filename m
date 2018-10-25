Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D241F453
	for <e@80x24.org>; Thu, 25 Oct 2018 08:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJYQkN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 12:40:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50560 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeJYQkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 12:40:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id i8-v6so532028wmg.0
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zaBDwTg26XYttJj6t6oo+Pf2PY9Kensjkd+K1OA4BiU=;
        b=ig8Vq1I/Tt4OqaA0m0Ivoe2N2qR9J5GAwxvlY6QinOeIKVSUjw1uEAenqBCofn/yoM
         mHaxVhSp5ahS814wJxXA1IrCJC6Hf/f/gmIDGLkdCOWkQrhu6DxD5smtqUswHTjwG0Pw
         jDPcmMM8dWrg4XDEtreJ+F8/tyWGFbTvAc4W1Tj7p0rksfNX3o8nGReVCozj6t2DcuCp
         i0PrmPWwI2psjAWSVI8yoxr7X8mTpyt+Ux3+nSvMXOogFa4VOGTw/panblLKsKmFAKqK
         MlVUEikx/tmOiRXxL7jjFi7fU8JdIJ6EQojK97nufMy2RLdD8+EZlCjPc7n5MrZbGs0u
         /Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zaBDwTg26XYttJj6t6oo+Pf2PY9Kensjkd+K1OA4BiU=;
        b=qznFmEF+h7ulCI3NYPCe11x6uxjZKYHvq6XqCW4kp3Gc0Z3qNh3B8ZYdncg6ehgs6S
         ocaw5rJauymo8dZijOcrCtYpvUFbMwG07yboQGRxLkohTOeCXZ98klzLP0xKE3qYgOtb
         4ICZE+MEgBTxsKYn62HyrZVlBriGHIutEWzjSYWBksAxb3PGK/qpnOIjdPOJsq5qQrfY
         nwWNt+GpMuFLAqDycSYYp8x36LzOqzWhaG4UR9jUZTvUg4oRjh2rKIcfv302l8Jy4zR6
         epSNs5YWEnXKZcU3TYDbzG1sWYCrw1h92IPMghBaUbpBRTRIIbAmpBWJtMHq5BJ8P3a+
         N4Eg==
X-Gm-Message-State: AGRZ1gIg9SmLlVb4QI5/nReHYGcKi80GxovnDZGmLmfdFhyYbIVtYj8i
        FOUp7yobcy/kKWc0RYBytqU=
X-Google-Smtp-Source: AJdET5cTf+bCj/Z/N37VJ8f8QGpSIDz86frdF4l0fwW0zdhpC0Y3mQEC+as+YFRqF5VMNMECSMAJbA==
X-Received: by 2002:a1c:f53:: with SMTP id 80-v6mr728416wmp.58.1540454913399;
        Thu, 25 Oct 2018 01:08:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 76-v6sm1230263wmf.19.2018.10.25.01.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:08:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com
Subject: Re: [PATCH] sequencer: cleanup for gcc 8.2.1 warning
References: <20181025001406.6729-1-carenas@gmail.com>
        <xmqqlg6mk2pd.fsf@gitster-ct.c.googlers.com>
        <xmqq8t2mk0jo.fsf@gitster-ct.c.googlers.com>
        <CAPUEsphHsWVzdGXBB0EOSNuUb5gNgjyJ+i7PnDJx7LBqejQrNQ@mail.gmail.com>
Date:   Thu, 25 Oct 2018 17:08:31 +0900
In-Reply-To: <CAPUEsphHsWVzdGXBB0EOSNuUb5gNgjyJ+i7PnDJx7LBqejQrNQ@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 25 Oct 2018 00:10:50 -0700")
Message-ID: <xmqqwoq6ih34.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> would something like this work better? (not to apply, and probably mangled)

At least call it "create_empty_file(path)" instead.

"touch" is primarily to update the last-modified-time timestamp of a
file.  If the file does not exist, it is created while doing so, but
when readers of your code sees a "touch", you make them anticipate
that you are relying on file timestamp somehow.  Using it to create
an empty file wastes time of readers who read your code by forcing
them wonder why you care about the file timestamp.

For a single-use, not using the macro and just using "%s", "" should
suffice.  If we want to hide the "%s", "" trickery from distracting
the readers (which is what you are trying to address with your
touch_file() proposal, I think, and I also suspect that it may be a
legitimate one), I tend to think that it may be a better solution to
introduce the EMPTY_PRINTF_ARG macro and use it everywhere, in
builtin/commit.c, builtin/difftool.c and wt-status.c and not not
just here.

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -35,6 +35,8 @@
>
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>
> +#define touch_file(path) write_file(path, "%s", "")
> +
>  const char sign_off_header[] = "Signed-off-by: ";
>  static const char cherry_picked_prefix[] = "(cherry picked from commit ";
>
> @@ -2389,7 +2391,7 @@ int write_basic_state(struct replay_opts *opts,
> const char *head_name,
>                 write_file(rebase_path_quiet(), "\n");
>
>         if (opts->verbose)
> -               write_file(rebase_path_verbose(), "");
> +               touch_file(rebase_path_verbose());
>         if (opts->strategy)
>                 write_file(rebase_path_strategy(), "%s\n", opts->strategy);
>         if (opts->xopts_nr > 0)
