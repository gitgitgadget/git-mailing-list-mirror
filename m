Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA552013C
	for <e@80x24.org>; Wed, 15 Feb 2017 23:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbdBOX2r (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:28:47 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:37124 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbdBOX2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:28:45 -0500
Received: by mail-it0-f46.google.com with SMTP id x75so6438862itb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ySCVRctnmsTneKTGgZhIYJ1wcC5BNLF1n1nK2kkVG9Q=;
        b=cOddWRbtHIK/wT4TtMUWxBCQE5mN9PB1qkP8CtfNog6Ee3p/tbNrPsys16s/keYVVi
         cPRIfmwl69xAGPkVJXOp6vRC70SKliiYou5v/ZxtfCPOn28DWONxIgLJMrkswYIwSs22
         QZfGpeyrgaZP+hHA9vjOV1PBRU/uNwgmt8pMrF97eweHOvI9PhmFODAvoloGRjcDQrz/
         nsNrW5Zf7yyLaDGAAYZ6zTygZJqSwi4Zgcj4fNgmPSr/jsbiP5q0P1pDCnzmZ7ZTtO1D
         WGIfdkt/jSgPhlk/OcwtNdx3mGIBDaBq1c7714wY1iukSTm/GPUVwrM7+6PMWinlngvH
         5+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ySCVRctnmsTneKTGgZhIYJ1wcC5BNLF1n1nK2kkVG9Q=;
        b=ScJvVAlFd+7h7aq00yajq4yl8CsUmpJ0dpc4c13nvOkwAcOI7sxVCDrR7zKA23+gyh
         n3ZPd7gMelnUj6n4jxotqbOoAI+VbbE3T/hFptNmCiQeN8faXNQuGobul8I/QjcyJIXI
         x8Gkv9+wUuASszjUYxHZtSb94nmhpMvXoC0IRaPFkTA9wCv95VfQELPwstNQUxODWIID
         dQAGDZ1lVGbj8VUrr42VnvBX0w1YeJ45Sa7nFLAQpHwcZQHmBBHgW9l3EHspzn2RWgxU
         dpeTjZCfQVwW7bhuYcCOi9mo6SF2SJvfQEgihfwJYBvSiX9Ib/rFjDrVL9e2CDAatkPj
         LtEg==
X-Gm-Message-State: AMke39mGAk2g4d95qjY/RtPp6N4c7AcUaZl8+n3HeY3yvIdoqOuWPa7m+2Mhsqb8BD9P+cFT+ItDdVUNgW2YLgcZ
X-Received: by 10.36.34.79 with SMTP id o76mr10877623ito.116.1487201314537;
 Wed, 15 Feb 2017 15:28:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 15:28:34 -0800 (PST)
In-Reply-To: <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
 <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com> <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
 <xmqqy3x712if.fsf@gitster.mtv.corp.google.com> <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 15:28:34 -0800
Message-ID: <CAGZ79kaKhjNPGRVJ6H=CMKQ1RKXmVvSPOMo4c3haNeS60aWQXA@mail.gmail.com>
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> I had some time to look into this, and yes, command-line parameters
>>> are too aggressively downcased ("git_config_parse_parameter" calls
>>> "strbuf_tolower" on the entire key part in config.c).
>>
>> Ahh, thanks.  So this is not about submodules at all; it is -c var=VAL
>> where var is downcased too aggressively.
>
> Perhaps something like this?

Yes; though I'd place it in strbuf.{c,h} as it is operating
on the internals of the strbuf. (Do we make any promises outside of
strbuf about the internals? I mean we use .buf all the time, so maybe
I am overly cautious here)

>
>  config.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index c6b874a7bf..98bf8fee32 100644
> --- a/config.c
> +++ b/config.c
> @@ -201,6 +201,20 @@ void git_config_push_parameter(const char *text)
>         strbuf_release(&env);
>  }
>
> +static void canonicalize_config_variable_name(struct strbuf *var)
> +{
> +       char *first_dot = strchr(var->buf, '.');
> +       char *last_dot = strrchr(var->buf, '.');

If first_dot != NULL, then last_dot !+ NULL as well.
(either both are NULL or none of them),
so we can loose one condition below.

> +       char *cp;
> +
> +       if (first_dot)
> +               for (cp = var->buf; *cp && cp < first_dot; cp++)
> +                       *cp = tolower(*cp);
> +       if (last_dot)
> +               for (cp = last_dot; *cp; cp++)
> +                       *cp = tolower(*cp);
> +}
> +
>  int git_config_parse_parameter(const char *text,
>                                config_fn_t fn, void *data)
