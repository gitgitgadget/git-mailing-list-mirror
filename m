Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2567D208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbeHFSma (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:42:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52139 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbeHFSma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:42:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so14466864wma.1
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ai3g5OxVxo1JU1aj91iml3PQdaYtA++wjLb41B//dK8=;
        b=Fp2hZszgHh13dlDL04Kt4Rz2vHbpcKXlLEajl+Exa14s3G3WWyYi5pUx4rflFV3j/4
         9NlcXcqs1RGKeiFm0lSgjeCK7ncbKGFmUmtzCOlKqumoeNJSpBDOg4pqWFRuByOLIpsZ
         GdGJX2AEYTYzaONKv9pKHETqfR6O7W//XQeFKNG9cPPEuiGmv056VnhWQGkcGLNM2e2p
         oVOfaNDlXM6fXqKHaYi5SIcgrbnFTNJFXfqqw5fcJS3beiMVAfI6RNpmGTJ+eKWHdeu6
         kwHu5pz+sjnmDlwljGzRxu1l5ezLcx5v/fpXSakf7iLf3s8IRoxyl0YCq3RW4DW/wVHK
         hVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ai3g5OxVxo1JU1aj91iml3PQdaYtA++wjLb41B//dK8=;
        b=Yqgol4GNSOV7ZPiWmKWs/L2GZr5hpUQEqIqqeyLE9lIwlqjIirqnJbS17XtxZx4AZm
         zjDoUX5FDLm80+d0Ky8ml/M+dHoBUfk7evWBerfngNksk6ZcYW8Fsltd3xICWj1SSKmP
         bmWzlw5VJli3t7yhzttLg5DGGZJvzd8ptobkOhNwKXDi/tVn8s9Zni0cfovsRPLw2LWD
         pK5pULweCzyPEw/ewPEGK+t/MM7nn2AnGPg04RQswZ2llsImjH2u4NkOHWTyewGBiOFB
         6m4N7O5Z1Zu64JEapgc7d4NiDQvW9M/0PENfE8u+XjPB+JEhSDYrTQuUHsl1BCmbgDol
         ZgUw==
X-Gm-Message-State: AOUpUlHaY+/2cYRz9H8FdhEmBANbIvYmwufskVuntLaNjm/VH8rlYYxr
        wxjtLU/1niJ92qXh/sxRFZ8=
X-Google-Smtp-Source: AAOMgpeCDUgFZIMDDaG6pJvQPHaEYmcCNQFKAoRz83bXmAEFBXctxnagjaIQF354LHmDgjJhujORRA==
X-Received: by 2002:a1c:c507:: with SMTP id v7-v6mr11873895wmf.151.1533573156053;
        Mon, 06 Aug 2018 09:32:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q3-v6sm5531272wmf.21.2018.08.06.09.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 09:32:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     sunshine@sunshineco.com, jrn@google.com, git@vger.kernel.org
Subject: Re: [PATCH v5 1/2] config: document git config getter return value
References: <20180806143313.104495-1-hanwen@google.com>
        <20180806143313.104495-2-hanwen@google.com>
Date:   Mon, 06 Aug 2018 09:32:34 -0700
In-Reply-To: <20180806143313.104495-2-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Mon, 6 Aug 2018 16:33:12 +0200")
Message-ID: <xmqqsh3rpial.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  config.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

I think this is good (I read all the comments on v3 and v4 in the
archive before I said this).  Let's split it off from the other
patch and queue it on its own merit (not that I think the other one
is not yet good enough---I haven't even looked at it yet ;-).

Thanks.

>
> diff --git a/config.h b/config.h
> index bb2f506b27..183b31ebf4 100644
> --- a/config.h
> +++ b/config.h
> @@ -188,9 +188,14 @@ struct config_set {
>  
>  extern void git_configset_init(struct config_set *cs);
>  extern int git_configset_add_file(struct config_set *cs, const char *filename);
> -extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
>  extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
>  extern void git_configset_clear(struct config_set *cs);
> +
> +/*
> + * These functions return 1 if not found, and 0 if found, leaving the found
> + * value in the 'dest' pointer.
> + */
> +extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
>  extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
>  extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
>  extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
