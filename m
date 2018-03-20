Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DE71F404
	for <e@80x24.org>; Tue, 20 Mar 2018 18:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeCTSTO (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:19:14 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:39182 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeCTSTN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:19:13 -0400
Received: by mail-qk0-f172.google.com with SMTP id j73so2709337qke.6
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eFg0RmbOs8qZDGXztJd89K33k4wBc6cIFsmdDe/YWOM=;
        b=PC2qWWSkzD330s2UA+UGEGSO5ogBprrfyEwKTMzvxHe7GsY0ArO+rY1ZldEFragV7F
         L00eqB5eD6aekg98MOYg96QC6Db6a9GxgVs2GKwYKFMbKjE3g16gtDH5xKkUErGiLZey
         1tJddZByrjSZodNIlgTZ72CHQwoeA4yY2cN5Z0BkDeeKcgYJNnSPH1qi7tIUPteDPbLV
         ZmKHPlPcG3FwSbCrFYXEV4EtnwI9V4nMQCoEBuF6J+R4f1GW7ROuHBcgvkMbpXbH6vqH
         pdh8QLkdVQyoWuAXyCfU4ZslK1JSz+sz5PopA3iW8axiy6pAt1eDW+CFELfNRSchl67Y
         y5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eFg0RmbOs8qZDGXztJd89K33k4wBc6cIFsmdDe/YWOM=;
        b=R4p5QxsrLSCmN66DyI+7ZcK0BOhi1OlOgDfnHqhMNDGxtGmXhzeIfDBZw4n0Y1QS3H
         2euvyIaJatlB2m4LhRQwxKv3XmdftmpGdRuvIYx8QrKSkHTwa0iSMP5eh2I0HmvpN8MG
         gYf5dmp0eHe67o3hz6ZBoO7yz1e9xFaPle5FmhzyuZLMnK0njo7bFVUd9/MjeScZvOYR
         uJ1+Rfe+0hnz41ZBHJ3lY7tb47EJUnw8M8WelkOm1gf5XTp3uXTeFf7+h5YM0MzmZhrf
         a19LX28MUEWqk8ZydXxCyDZaWD0X4A59/KUpMUos3b9T3oCR/vIJO8oRXAQ6wBFsdVj4
         rTtw==
X-Gm-Message-State: AElRT7GiU1slDKlQt2imSniKE2sQDx+BCzFswvXXCC9UXDvnJYmssPPR
        2iwW/oAJClDilOC89sWS+LlTfsyu9Qa6AUfWjgQ=
X-Google-Smtp-Source: AG47ELuZbC07GxOFtgRPC+uXRb4pVO2eGtjrMsEJknIfH6XCJ4fL2WCN9nPyCVNrCyLG7OB29KG7rbuBybEauqaUCjo=
X-Received: by 10.55.74.2 with SMTP id x2mr5347004qka.314.1521569952248; Tue,
 20 Mar 2018 11:19:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 11:19:11 -0700 (PDT)
In-Reply-To: <010201624428199f-b4b3d8ce-222f-4966-9171-7fcf932ca220-000000@eu-west-1.amazonses.com>
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
 <010201624428199f-b4b3d8ce-222f-4966-9171-7fcf932ca220-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 14:19:11 -0400
X-Google-Sender-Auth: v8RbGpjJQR-ijClkIyLm18uvcio
Message-ID: <CAPig+cSxGgG=1k95j+n4DZHBdtN++7F6_U5fu0gOcjwwPQ5GZw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] ref-filter: get_ref_atom_value() error handling
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 12:05 PM, Olga Telezhnaya
<olyatelezhnaya@gmail.com> wrote:
> ref-filter: get_ref_atom_value() error handling

This doesn't tell us much about what this patch is doing. Perhaps a
better subject would be:

    ref-filter: libify get_ref_atom_value()

> Finish removing die() calls from ref-filter formatting logic,
> so that it could be used by other commands.
>
> Change the signature of get_ref_atom_value() and underlying functions
> by adding return value and strbuf parameter for error message.
> Return value equals 0 upon success and -1 upon failure (there
> could be more error codes further if necessary).
> Upon failure, error message is appended to the strbuf.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -1445,28 +1445,36 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
> +static int get_object(struct ref_array_item *ref, const struct object_id *oid,
> +                      int deref, struct object **obj, struct strbuf *err)
>  {
>         void *buf = get_obj(oid, obj, &size, &eaten);
> -       if (!buf)
> -               die(_("missing object %s for %s"),
> -                   oid_to_hex(oid), ref->refname);
> -       if (!*obj)
> -               die(_("parse_object_buffer failed on %s for %s"),
> -                   oid_to_hex(oid), ref->refname);
> -
> +       if (!buf) {
> +               strbuf_addf(err, _("missing object %s for %s"), oid_to_hex(oid),
> +                           ref->refname);
> +               if (!eaten)
> +                       free(buf);

Since we are inside the 'if (!buf)' conditional, we _know_ that 'buf'
is NULL, therefore this free(buff) is unnecessary.

> +               return -1;
> +       }
> +       if (!*obj) {
> +               strbuf_addf(err, _("parse_object_buffer failed on %s for %s"),
> +                           oid_to_hex(oid), ref->refname);
> +               if (!eaten)
> +                       free(buf);
> +               return -1;
> +       }
>         grab_values(ref->value, deref, *obj, buf, size);
>         if (!eaten)
>                 free(buf);
> +       return 0;
>  }

Overall, with the need for resource cleanup, this function becomes
unusually noisy after this change. It could be tamed by doing
something like this:

    int ret = 0;
    void *buf = get_obj(oid, obj, &size, &eaten);
    if (!buf)
        ret = strbuf_error(_("missing object %s for %s"),
            oid_to_hex(oid), ref->refname);
    else if (!*obj)
        ret = strbuf_error(_("parse_object_buffer failed on %s for %s"),
            oid_to_hex(oid), ref->refname);
    else
        grab_values(ref->value, deref, *obj, buf, size);
   if (!eaten)
        free(buf);
    return ret;
