Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5F32022A
	for <e@80x24.org>; Sat, 29 Oct 2016 12:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756619AbcJ2MZW (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 08:25:22 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35737 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756576AbcJ2MZV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 08:25:21 -0400
Received: by mail-lf0-f66.google.com with SMTP id x79so5007619lff.2
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+1T+gnlXEfQcVA0KXMzjJMq+xA2ap7LXp4q8SiEindM=;
        b=YboLzPTyQE1bdnJ3yOkywGfbrGOkxtQGe0zykUkwSSVgZV2YO1bpSBnE9zH4XZBjgO
         65J5WnOb7fk8x6CzdOTtVnJQsoH1MOQpYfO24gpp7j2EsJJbjx7Zud//oEDy1Kcgqm4p
         05Zf5snofleiw6B8U7HVL1vfVhj1McZ98W4bxwVoj+2u7+W6yen1FaZaamV+iCW0yltz
         Mimq3C8OWUtQqwlV8zOPQaVUjM/YfvobUikEP6RPMf/PiiDUzfELjA0q/8tpjAz7mDlB
         7ULqDLZqmBgzXIrNbGIGQyvJwN5ijsOthVN/BHEdg8ylYHb32Yjttf17YeMhTA0uHVL7
         vXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+1T+gnlXEfQcVA0KXMzjJMq+xA2ap7LXp4q8SiEindM=;
        b=U1XPkfXo8gZUb5vgjsoHqEXkmGUoN/KwFEacvRjkB8AyLwm+yzrPKjHMWUu0fCfF2o
         o4vjQkOgkRqNcGPqf9g8dI8H9s0QexGg11jJkYXANX1V2IJnEzy+Q76xOaiMXbUtt6LQ
         GhjtedNaD+gsT8+vgVPuL+E5riTFtlWRGKFShIvwJ8OepPc9k3Z/PvV9CEidQNCnVA68
         8N62uYmgMNjiNbS7RfayJhQpc3BX18yeN5PYzPzDepCFrA6K8L0GyapTLNOBrZfJfF/Q
         sCyB+krkW5oo2oROqemwB1vQMcfBYvxf0SencMz6sOR+aMnUNMr8Ez1ZhfPz6wOtWc+U
         w/JA==
X-Gm-Message-State: ABUngvf7AYdGaA8N7QHnkjxDANIydQdHeW9BFQLi9x3mp5S3t+y0PnQVLqJxC2BIhBGISq4mcyInPnijUVkmtA==
X-Received: by 10.25.159.141 with SMTP id i135mr13094270lfe.123.1477743919773;
 Sat, 29 Oct 2016 05:25:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 29 Oct 2016 05:25:19 -0700 (PDT)
In-Reply-To: <db609e13740415ac4e5e357493661347b0f681f7.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <db609e13740415ac4e5e357493661347b0f681f7.1477698917.git.jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 29 Oct 2016 14:25:19 +0200
Message-ID: <CAP8UFD3o89EzQLLsMtLWxBhKCG4RmbG6u+UrLwzyAAEyezv1cA@mail.gmail.com>
Subject: Re: [PATCH 2/4] trailer: avoid unnecessary splitting on lines
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2016 at 2:05 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> trailer.c currently splits lines while processing a buffer (and also
> rejoins lines when needing to invoke ignore_non_trailer).
>
> Avoid such line splitting, except when generating the strings
> corresponding to trailers (for ease of use by clients - a subsequent
> patch will allow other components to obtain the layout of a trailer
> block in a buffer, including the trailers themselves). The main purpose
> of this is to make it easy to return pointers into the original buffer
> (for a subsequent patch), but this also significantly reduces the number
> of memory allocations required.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  trailer.c | 215 +++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 116 insertions(+), 99 deletions(-)

IMHO it is telling that this needs 17 more lines.

> @@ -954,7 +971,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
>  {
>         LIST_HEAD(head);
>         LIST_HEAD(arg_head);
> -       struct strbuf **lines;
> +       struct strbuf sb = STRBUF_INIT;

We often use "sb" as the name of strbuf variables, but I think at
least here (and maybe in other places above) we could use something a
bit more telling, like "input_buf" perhaps.

>         int trailer_end;
>         FILE *outfile = stdout;
>
