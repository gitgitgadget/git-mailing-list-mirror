Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182752082E
	for <e@80x24.org>; Sun, 25 Jun 2017 14:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdFYOUx (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 10:20:53 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35537 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdFYOUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 10:20:52 -0400
Received: by mail-it0-f46.google.com with SMTP id v202so10709096itb.0
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xBc1iSxIUvvm0lDRpu+VuA+bIo6Oqu5M5xmqC4o/iC8=;
        b=nxm4jleLwPeOvy+rNrDUfXLCoAIp+mmdzXV9kYxANHPmq2o8ZOEbiZlXIlY/n3txDf
         Fa2gh4C0mkEaxIDFV2mLD9cGmlb6LzMJL1LIOwHv05GlONvUfxqutNYP//y+Dds/THlx
         vBgJbiQygL+rI4N4ZziqWY3tUomEG/dmyXv2fO3PbfQboE6rF1Bv2bWGy14SwdGYZNos
         vFjwIk0w0zn6ZFTyeK+m9cVSJVljFA9ulb6fg7EGp4lmzF0VidyB5IR1qQeNWttxNMFM
         mQ3L26dlIEJULzpz5V55rb+ou4fUTK9HCr1+DpLPNctUXVYv/BHQdrFr/9hP1f5IaJFL
         crlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xBc1iSxIUvvm0lDRpu+VuA+bIo6Oqu5M5xmqC4o/iC8=;
        b=HK50IhrYFKxqYNAaSqRnALdpTP/lJKs1TxZYR6MQUx0KMvXypBh8gfH4dQx8jpF/f/
         Mu5EBbeW0zxp9JFA5DIYdcOYC+opJNzHRFQoHricjWcPs3P2k/RGqIH6IdV4lPR5/o+K
         dZhXnNCDqH6JPbQAGu7KcOKs+ViSFH49xnlm0ryvt21K+Fs5CeuQTy/oVX5DiNY40C1a
         vHb/4iCYPWdBrOp1cKWXwU3GVh/X8bqWjcUQZtNCEUziRh35Dgsyp78D5ASIWu46+08X
         LklkhUAmu99pg9BCFkZEaxK7K1azdW0zEP0bLafJXsiZAySR1ClFGa8MJkgYGyTDRbDF
         d60A==
X-Gm-Message-State: AKS2vOxInh3rWz9Rsm3qbHQ1JDFxRRLDizj+xlu4NrSg/c5wTSTQNrYr
        1E30sYX50aheuHIimTJv2WSlbMqmBA==
X-Received: by 10.36.74.148 with SMTP id k142mr17461480itb.94.1498400451792;
 Sun, 25 Jun 2017 07:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.31.10 with HTTP; Sun, 25 Jun 2017 07:20:31 -0700 (PDT)
In-Reply-To: <20170625140957.kjkctkaesm6il5u2@sigill.intra.peff.net>
References: <20170625140957.kjkctkaesm6il5u2@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 25 Jun 2017 16:20:31 +0200
Message-ID: <CACBZZX59LvCsp-rf4DatJahwgsY0cki=6E6keMiUgxK0v0KTSQ@mail.gmail.com>
Subject: Re: NULL dereference in ab/wildmatch
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 25, 2017 at 4:09 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 25, 2017 at 02:50:10AM -0700, scan-admin@coverity.com wrote:
>
>>
>> ** CID 1413016:  Null pointer dereferences  (FORWARD_NULL)
>> /config.c: 213 in include_by_gitdir()
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 1413016:  Null pointer dereferences  (FORWARD_NULL)
>> /config.c: 213 in include_by_gitdir()
>> 207     {
>> 208           struct strbuf text = STRBUF_INIT;
>> 209           struct strbuf pattern = STRBUF_INIT;
>> 210           int ret = 0, prefix;
>> 211           const char *git_dir;
>> 212           int already_tried_absolute = 0;
>> >>>     CID 1413016:  Null pointer dereferences  (FORWARD_NULL)
>> >>>     Assigning: "code" = "NULL".
>> 213           struct wildmatch_compiled *code = NULL;
>> 214
>> 215           if (opts->git_dir)
>> 216                   git_dir = opts->git_dir;
>> 217           else
>> 218                   goto done;
>
> I think this comes the "goto done" at the bottom of the context. After
> that label, we call wildmatch_free() unconditionally. Probably it just
> needs:
>
> diff --git a/config.c b/config.c
> index 515f8518e2..cfee92ebbf 100644
> --- a/config.c
> +++ b/config.c
> @@ -260,7 +260,8 @@ static int include_by_gitdir(const struct config_options *opts,
>  done:
>         strbuf_release(&pattern);
>         strbuf_release(&text);
> -       wildmatch_free(code);
> +       if (code)
> +               wildmatch_free(code);
>         return ret;
>  }
>
>
> though arguably wildmatch_free() should be taught to handle NULL.

Thanks. I'll fix this one way or the other in a future submission;

Junio: Could you please eject the RFC patches in the series (i.e. 2/3
& 3/3), i.e. just keep "wildmatch: remove unused wildopts parameter".
I'm slowly refactoring / fixing bugs / adding tests for wildmatch() &
handling the dir.c / tree-walk.c cases. I'll submit that later after
the current obviously-correct "unused parameter" fix has cooked for a
bit.
