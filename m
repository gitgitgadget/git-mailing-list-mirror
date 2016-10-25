Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1732022A
	for <e@80x24.org>; Tue, 25 Oct 2016 10:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941563AbcJYKGh (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 06:06:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36743 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbcJYKGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 06:06:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id e12so6182185oib.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jX9BhC4DETm0rC650Q9doGZsdOF34931O8TOCBVgD/Q=;
        b=Ah6bmfeNj87nfLIofw5xrc8ULOKw8Z2UbY4xRs/6JAVZtrtjXaJ5M/VcpVrxHO8sqg
         U1iM9vehZM6hnrWFvcYSoMvC3AKYyN26KZNdJUH7ck3n8hotifU1RJKviV0prgXWJk63
         7avpDWERefejsh7XliahWwgqoCvYlWvGdbMzO+zMs811Hu7sbXXfM6vw3CNu9esp++jx
         BCaY70jSswcTdiLtSwD6dzbGZ1x19EHA5v8TiCQ9BYiZjDxaSl+7I2YGgC58ss5zDia0
         syESrFi3/sX2qkjGGvfAc4hd0CqLgj7TfQVTlAKKV7mio60ixW56IxlzARb1ik8cy0pI
         xLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jX9BhC4DETm0rC650Q9doGZsdOF34931O8TOCBVgD/Q=;
        b=h6vWqeKVny2svKSpG1Zja+BK5YYp0cWTrPQsqwqhFiJ+u9SfPOl5FNLSikg3lZG94v
         aeiZ5UHkvRpY/BesY5KVMXncJE/RtCu+zLlHDKZaDKZeC9nRQmhN8QcXSWO8k1nG5TRh
         pXcZ/BJWunmpJ3egfkamnuXc5xLIcwfiRJkuCuW7XS707sS5ah3FckHj2PC0FHHyitGy
         6G3SQyrR6LMUck0aH2NgcBp6gcWqeooKbC+iCzS49K/VF0oXqw5J8Kd8bK9BCu/2bYwq
         Sdx9PEcunUrb77Eb1zo9zhTkHuNeF8x1RZIA5m8hXT169WVbNOq+zZYaUtSxVMgQH4zi
         Y1wA==
X-Gm-Message-State: ABUngvcvhfWZ6+QoUUFJkNzZ4m9CIMsuwbL+gCe6VaJm/2qA76hke5RnlQGJV+ljAwfwcqVDPKbq4MExzWxSlw==
X-Received: by 10.36.103.201 with SMTP id u192mr1019471itc.3.1477389995674;
 Tue, 25 Oct 2016 03:06:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 03:06:05 -0700 (PDT)
In-Reply-To: <20161023092648.12086-10-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org> <20161023092648.12086-10-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 17:06:05 +0700
Message-ID: <CACsJy8A0djR6=s0AY0tzVehYY5b1-o11uRsFdGtOUCeu4Z6Xjw@mail.gmail.com>
Subject: Re: [PATCH v1 09/19] config: add git_config_get_max_percent_split_change()
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> This new function will be used in a following commit to get the
> +int git_config_get_max_percent_split_change(void)
> +{
> +       int val = -1;
> +
> +       if (!git_config_get_int("splitindex.maxpercentchange", &val)) {
> +               if (0 <= val && val <= 100)
> +                       return val;
> +
> +               error("splitindex.maxpercentchange value '%d' "

We should keep camelCase form for easy reading. And wrap this string with _().

> +                     "should be between 0 and 100", val);

I wonder if anybody would try to put 12.3 here and confused by the
error message, because 0 <= 12.3 <= 100, but it's not an integer..
Ah.. never mind, die_bad_number() would be called first in this case
with a loud and clear complaint.

> +               return -1;
> +       }
> +
> +       return -1; /* default value */
-- 
Duy
