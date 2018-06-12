Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F42341F403
	for <e@80x24.org>; Tue, 12 Jun 2018 20:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933518AbeFLUa7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 16:30:59 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37699 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933419AbeFLUa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 16:30:58 -0400
Received: by mail-yw0-f195.google.com with SMTP id j134-v6so108191ywg.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3RMp94u5ph8JTZpJKCzKAOwftm6OIm3eKa8yeFUhfxo=;
        b=o5o1S7fwTimF8d4yOeYTApYS4hugbMofKo204rhDIbjjQWdJBR7u2+QC1S1+e+r/eM
         jlDhncsnq2BExHJKfURruZHZzwgSM40ikhJUFP889lOHlzql6/naHdP+KcM7GIIKQfAc
         X58vXZ1IB6rbYvN6f7c3lrDGYoUvx3Kfg/S47kI3cJheWErFRsV/Q+NuQkO1LbKTirKj
         wQaNqkNRux3NjVWTSYMHmJMG50htOkSrj5RoNDLZucPxIRadRGxwy8un6R1NzTne4gRy
         3c+eR+L7rRAKbCsLvFEDF8C9Q2OaDq6/NOiHFeur+Gdg7adnxVk92Q+yLy9yFttTLlKM
         eWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3RMp94u5ph8JTZpJKCzKAOwftm6OIm3eKa8yeFUhfxo=;
        b=ThAysJDLN5JgaT8sADJ82acjz+JaPjKm8okbHgO2uzrmyorqIEsRVg/B2LimTCv3iB
         CHJKNOIB3gvsVxmlPoz6blblCT2MVZXz3udHZ0ZSP/E8CZTKxqMQaoH/QPUcD+NfjS35
         3cUoog/1YV+1/EbHAj/vST7OXXwr8AIe1iDheHvEv6qW4DA9lTrk1TCuTwcKqmlWZ32C
         eKE7ukOcj+wIi5ahTGttGoi1gyXzPaFPUI4w0I71mxieoBGZW2EfqT7YfUaYTmM0TvUO
         RkBu9yZe9P/+AFvnYVUNTa2B0WJ1Wfh5mH11aww8EcvskoPJWNy6KHAdZ6kc5kPOJuU4
         JPSw==
X-Gm-Message-State: APt69E2nWy+Ln+s/K16rKYW4gtp3xjmQy41ixaizFQkmFQYbmmLCn2O7
        Og5Np3/KypDH93GACM0MWqFoi9lj1fIIUTXUHws=
X-Google-Smtp-Source: ADUXVKJOw0uu908NhZFWTQ7HgEvMhAGHUE4rI5jzIbDRPjVFZWE8GTb7AhJZnjd1XzCr3Ido6CJv8raken9xR6Gldrc=
X-Received: by 2002:a81:3c0d:: with SMTP id j13-v6mr961697ywa.16.1528835457735;
 Tue, 12 Jun 2018 13:30:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 13:30:57
 -0700 (PDT)
In-Reply-To: <20180612202201.94733-2-git@jeffhostetler.com>
References: <20180612202201.94733-1-git@jeffhostetler.com> <20180612202201.94733-2-git@jeffhostetler.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jun 2018 16:30:57 -0400
X-Google-Sender-Auth: yHQXJvf585Y3IxgTLM4avczg1zk
Message-ID: <CAPig+cTMeR-pNtScGwXL=9z-wCLFvioe53ppMOyQ-S-LwQwPig@mail.gmail.com>
Subject: Re: [PATCH v9] json_writer: new routines to create JSON data
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 4:22 PM,  <git@jeffhostetler.com> wrote:
> Add "struct json_writer" and a series of jw_ routines to compose JSON
> data into a string buffer.  The resulting string may then be printed by
> commands wanting to support a JSON-like output format.
>
> The json_writer is limited to correctly formatting structured data for
> output.  It does not attempt to build an object model of the JSON data.
>
> We say "JSON-like" because we do not enforce the Unicode (usually UTF-8)
> requirement on string fields.  Internally, Git does not necessarily have
> Unicode/UTF-8 data for most fields, so it is currently unclear the best
> way to enforce that requirement.  For example, on Linx pathnames can

s/Linx/Linux/

> contain arbitrary 8-bit character data, so a command like "status" would
> not know how to encode the reported pathnames.  We may want to revisit
> this (or double encode such strings) in the future.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
> diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
> @@ -0,0 +1,564 @@
> +void get_s(int line_nr, char **s_in)

s/^/static/

> +{
> +       *s_in = strtok(NULL, " ");
> +       if (!*s_in)
> +               die("line[%d]: expected: <s>", line_nr);
> +}
> +
> +void get_i(int line_nr, intmax_t *s_in)

s/^/static/

> +{
> +       char *s;
> +       char *endptr;
> +
> +       get_s(line_nr, &s);
> +
> +       *s_in = strtol(s, &endptr, 10);
> +       if (*endptr || errno == ERANGE)
> +               die("line[%d]: invalid integer value", line_nr);
> +}
> +
> +void get_d(int line_nr, double *s_in)

s/^/static/

> +{
> +       char *s;
> +       char *endptr;
> +
> +       get_s(line_nr, &s);
> +
> +       *s_in = strtod(s, &endptr);
> +       if (*endptr || errno == ERANGE)
> +               die("line[%d]: invalid float value", line_nr);
> +}
