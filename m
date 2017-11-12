Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9895201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 17:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbdKLRcq (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 12:32:46 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46657 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdKLRcp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 12:32:45 -0500
Received: by mail-qt0-f195.google.com with SMTP id 1so17095090qtn.3
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mPP646vvyqJrT9g/if9SdMmqFoXevduw4VmXyiXPXLY=;
        b=lhGQVahMHxe8nlxP64M6csge+2TFnjbMW4tHu3NWq+FERVaUo2ARtdYzANkSAah9N+
         WDXOCUFHu/vtcVmB/TaSHa7HHLeqyZlL5MK7fiYzzaui1MBcC+8BjLVwSUuy5md2oWn9
         mYTexdPnMWXUUV9FEZFtzdvNMg57M4DrJHFXzT7qKBWEenJgn6NXdiiWzryz62YNRydY
         k3Ejco8K+Q3Ba4APWLlw6w45O/lzbRxAO361bwiW0Xgthj6MMSyUnk/mH9HWIIrlI/HM
         vA8y23jI6oYUoD11srz0srYAWKjA2eDldI9aVDg3n+Dx/AfEtQ54FVv/WFaqrwJZfOb6
         O0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mPP646vvyqJrT9g/if9SdMmqFoXevduw4VmXyiXPXLY=;
        b=VMq/ydQdKvaBp0Q/esrJVYGzRdlhIITF7Zf/LLHIuM5qDfQ3FVcTUsnP5px72q5IY5
         DrpxxDCwzSu/KIjwn7MHgzK60G1Hdoki7FoFjw2fAzl/MMZhoDDXsOTPInPwLs1GcKBu
         jkvTJQZJ8hifXXDX0InTGmLwBWWLJbQUku5oaNvKNPzP00usmN8OlG72ci9qTRODbWZ5
         KSKi4xgj3IvCkyCF9c9Nt9LWMx71fvEZ++YVoWdRSUuty2LaRImJTxDVPJ2bPez3DX6l
         t9qjHusQ8pObWXN1VEr+MSHV6O2XQHCdZsU+bBHykFnENcN0MT1oOraD4SMN6v1BxqKu
         j9mQ==
X-Gm-Message-State: AJaThX6JOlMMw8xi+1u5giGttDeZXATJwFsq7R9YWDyK94BQaZBJ0UyO
        Cy7AT8sHfwjoTqiDezhx/5UUtQVBYy4srT9yoKA=
X-Google-Smtp-Source: AGs4zMZS3IL620MAkX3e1LoleDy+0P3NFtplGSPXb4lqQISoSvBG6U0ayfMxYenyQrCv7rKIKaPB3QTeKFtxS9Ml0wM=
X-Received: by 10.200.43.26 with SMTP id 26mr11300657qtu.51.1510507964335;
 Sun, 12 Nov 2017 09:32:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 12 Nov 2017 09:32:43 -0800 (PST)
In-Reply-To: <20171112130710.16000-1-jerzy.kozera@gmail.com>
References: <20171112130710.16000-1-jerzy.kozera@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Nov 2017 12:32:43 -0500
X-Google-Sender-Auth: N3zgwGb7Dn8pG6MVM18-FhGUxVw
Message-ID: <CAPig+cSR_GGog2vATwGgMWDofVzkgDE7K=VvZ4GEyrzYC1t-GQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: strip CR chars for Windows gpg2
To:     Jerzy Kozera <jerzy.kozera@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the re-roll...

On Sun, Nov 12, 2017 at 8:07 AM, Jerzy Kozera <jerzy.kozera@gmail.com> wrote:
> This fixes the issue with newlines being \r\n and not being displayed
> correctly when using gpg2 for Windows, as reported at
> https://github.com/git-for-windows/git/issues/1249

It's still not clear from this description what "not being displayed
correctly" means. Ideally, the commit message should stand on its own,
explaining exactly what problem the patch is solving, without the
reader having to chase URLs to pages (which might disappear). If you
could summarize the problem and solution in your own words in such a
way that your description itself conveys enough information for
someone not familiar with that problem report to understand the
problem, then that would likely make a good commit message.

More below...

> Issues with non-ASCII characters remain for further investigation.
>
> Signed-off-by: Jerzy Kozera <jerzy.kozera@gmail.com>
> ---
> diff --git a/gpg-interface.c b/gpg-interface.c
> @@ -145,6 +145,20 @@ const char *get_signing_key(void)
> +/* Strip CR from the CRLF line endings, in case we are on Windows. */
> +static void strip_cr(struct strbuf *buffer, size_t bottom) {

It's not at all clear what 'bottom' means. In the original, when the
code was inline, the surrounding context would likely have given a
good clue to the meaning of 'bottom', but here stand-alone, it conveys
little or nothing. Perhaps a better name for this argument would be
'start_at' or 'from' or something.

> +       size_t i, j;
> +       for (i = j = bottom; i < buffer->len; i++)
> +               if (!(i < buffer->len - 1 &&
> +                               buffer->buf[i] == '\r' &&
> +                               buffer->buf[i + 1] == '\n')) {

Hmm, was this tested? If I'm reading this correctly, this strips out
the entire CRLF pair, whereas the original code only stripped the CR
and left what followed it (typically LF) alone. Junio's suggestion was
to enhance this to be more careful and strip CR only when followed
immediately by LF (but to leave the LF intact). Therefore, this seems
like a regression.

> +                       if (i != j)
> +                               buffer->buf[j] = buffer->buf[i];
> +                       j++;
> +               }
> +       strbuf_setlen(buffer, j);
> +}
> +
>  /*
>   * Create a detached signature for the contents of "buffer" and append
>   * it after "signature"; "buffer" and "signature" can be the same
> @@ -155,7 +169,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  {
>         struct child_process gpg = CHILD_PROCESS_INIT;
>         int ret;
> -       size_t i, j, bottom;
> +       size_t bottom;
>         struct strbuf gpg_status = STRBUF_INIT;
>
>         argv_array_pushl(&gpg.args,
> @@ -180,14 +194,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>         if (ret)
>                 return error(_("gpg failed to sign the data"));
>
> -       /* Strip CR from the line endings, in case we are on Windows. */
> -       for (i = j = bottom; i < signature->len; i++)
> -               if (signature->buf[i] != '\r') {
> -                       if (i != j)
> -                               signature->buf[j] = signature->buf[i];
> -                       j++;
> -               }
> -       strbuf_setlen(signature, j);
> +       strip_cr(signature, bottom);
>
>         return 0;
>  }
> @@ -230,6 +237,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>         sigchain_push(SIGPIPE, SIG_IGN);
>         ret = pipe_command(&gpg, payload, payload_size,
>                            gpg_status, 0, gpg_output, 0);
> +       strip_cr(gpg_status, 0);
> +       strip_cr(gpg_output, 0);
>         sigchain_pop(SIGPIPE);
>
>         delete_tempfile(&temp);
> --
> 2.14.2.windows.3
