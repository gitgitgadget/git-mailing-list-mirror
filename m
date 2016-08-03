Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7901F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbcHCWaI (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:30:08 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33730 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbcHCWaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:30:07 -0400
Received: by mail-yw0-f196.google.com with SMTP id z8so17752780ywa.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:29:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HYbP4S8u3nGcEo9TLShCSMErRROtXMeA4qLqb2UzZUE=;
        b=iMYxLCdvfQiDG2A6MpivY63d6vcF7fQGupTLBrG1hm3giLHI74fMZ1HAWPcVIzhNjO
         RD+/CeZWLVnAokqf3+/3ebhDkduxZePgEJgYhY8q/SOkpkE0eHbxzO0k8z4YC5XwqBXT
         B04MvszNTkl6C3YRxWF/phHDz03xU+7WhxHTEJQbBzZmPc82wq972+G8NuFKZ6nSvnE1
         fDwo6X7LvbCcywx/5+gMaAqcqTe3wGgpcUHp2WAYGPdKUHpxPSBEORFpEcUozmWZYq8A
         WXaq8/PI+kJZVG2bzNqdICpFsXbysqJ8ZXxB4x2iLcWCzmMf5drhk8/Xb05ZKTHHKu34
         J6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HYbP4S8u3nGcEo9TLShCSMErRROtXMeA4qLqb2UzZUE=;
        b=myEek7vbHvWmUWVFsrgrzkPFLCXSBv2An/JBJKa1XKmvaDVVdMws1nCClmnpE98tUH
         5C0T+Tmm1QURZOz++eEdXgO5IUkUd9YWrpoynvUm8atYjo5vMpJrXmWwkuMvo5qdaCYY
         WqL2Jr2fHGRiCyZ6TQQZcxxocIz1TAUFCfdF/ugGpA7zahdvSevU0hriNfwYpOKbSwVp
         TWkXq4oHk0FLt87ayFdbPiCVao94hmA+ipdAYYjKOfm1JjUImwbYzXMU+rPIvCT5fngl
         mR9NiQ4bDKMXJSjIjjCnftpo7crdnzA92yy0rIbamZUaO0l+5fusqJXZtfRkHDfaQKcu
         wAFA==
X-Gm-Message-State: AEkoouuvDqUyUGNbC7lGiKfPorgiVrCtpfAGAgnnLOziqeoL/0EtiSVP5+riI+oIRfat3nQU0/qgwEyG1ZXC4Q==
X-Received: by 10.37.60.67 with SMTP id j64mr16247941yba.111.1470263381178;
 Wed, 03 Aug 2016 15:29:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.132 with HTTP; Wed, 3 Aug 2016 15:29:20 -0700 (PDT)
In-Reply-To: <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Wed, 3 Aug 2016 15:29:20 -0700
Message-ID: <CA+P7+xo6q0pveVQdt1mynfsWq75DzBXsbPcgVYdd5s8rpO+97A@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> +/*
> + * If a line is indented more than this, get_indent() just returns this value.
> + * This avoids having to do absurd amounts of work for data that are not
> + * human-readable text, and also ensures that the output of get_indent fits within
> + * an int.
> + */
> +#define MAX_INDENT 200
> +
> +/*
> + * Return the amount of indentation of the specified line, treating TAB as 8
> + * columns. Return -1 if line is empty or contains only whitespace. Clamp the
> + * output value at MAX_INDENT.
> + */
> +static int get_indent(xrecord_t *rec)
> +{
> +       long i;
> +       int ret = 0;
> +
> +       for (i = 0; i < rec->size; i++) {
> +               char c = rec->ptr[i];
> +
> +               if (!XDL_ISSPACE(c))
> +                       return ret;
> +               else if (c == ' ')
> +                       ret += 1;
> +               else if (c == '\t')
> +                       ret += 8 - ret % 8;
> +               /* ignore other whitespace characters */
> +
> +               if (ret >= MAX_INDENT)
> +                       return MAX_INDENT;

Should we return -1 here?

> +       }
> +       /*
> +        * We have reached the end of the line without finding any non-space
> +        * characters; i.e., the whole line consists of trailing spaces, which we
> +        * are not interested in.
> +        */
> +       return -1;

It seems odd to be that a line with "199" spaces and nothing else will
return "-1" but a line with 200 spaces and nothing else will return
200..? Would it be safe to just return -1 in both cases (if a line is
all spaces or starts with more than 200 spaces just return -1)?

> +}
> +
