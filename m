Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75DA1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 18:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfBKSwH (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 13:52:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35669 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfBKSwH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 13:52:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so339789wmt.0
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 10:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y36ux0JWCeCobOAYSnUw9UxJK6ZHswOikMw/GcSl6I8=;
        b=YO4cMlwcgFwPS9rv8GoU7qpJ68kALKnHA4+zytORS293+8OghGtmh/VkqEBus0WrVM
         2elGO4ywLqh5JK6LWEnrFfydeJVIewaw9J+aaV+BrSyCwJrQKynJvgOL1w85tauhGgoE
         Exi7jcSkobJgwCcG6H8W5cDeT9S1f14FE8JJCvw+uMy2amwPHvuqsCcx+YGmi0GpOU9u
         +f/rxxTNsgj33rpA/UR7Ow3Ud41vXFbU51+aUuGe6dssouc9mibyhISRkU0qvui2P4km
         WclOZDLewC3pETZpcbSdK315u+Y6Sx69pwwqqf20iwjT/zkQCWdH8cB843ogHofjSFtU
         6mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y36ux0JWCeCobOAYSnUw9UxJK6ZHswOikMw/GcSl6I8=;
        b=cU8rFHwMEHaOX4hdss0hFTeY29bT+6LvXHdIiVSJYKWXvKstGSaSz+Gl3H0Ne6WjEE
         tcohIF3OyEFExw4EOlUMpVs0g9/vJXfpGkPWOpkkqatAANKMXkRzZz+MOftT1wmv2wm6
         nA/5XvxTDrSEED+FqKqilJ9bkhoLdSc58OHBr/qSY7oMfMzM8z4V29hjR94quAwVi3ok
         ws9/KsIZqbUFJOqFfUgD3a+JfnqavpvH9dVdRAuGLQ0ucvwEAgTg0tThCOFZwmuqNq3c
         teHz2G/9pX85CLdqjrhRhou182JPkWmOp7MVQs9anZVuX4Y5ApLO9Od04oeIyD68NRz5
         JVqw==
X-Gm-Message-State: AHQUAuZ1dCGl3lWuwoY03LcJI7OwyzLDBvaLWLrI8Jtw8dA22vSs/mjL
        3cL4hJTzJibtTDI9HdGnVrQ=
X-Google-Smtp-Source: AHgI3Ibm6xZija9gr3WBZh3Oos5KfG3fklmpDnToW4NVGwkgvHhyttQpnypJz5scrZSovUoa83stqQ==
X-Received: by 2002:a1c:f20a:: with SMTP id s10mr634558wmc.123.1549911124728;
        Mon, 11 Feb 2019 10:52:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q8sm20876683wrr.9.2019.02.11.10.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 10:52:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: add more parameter value completion
References: <20190129102111.15333-1-pclouds@gmail.com>
Date:   Mon, 11 Feb 2019 10:52:03 -0800
In-Reply-To: <20190129102111.15333-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 29 Jan 2019 17:21:11 +0700")
Message-ID: <xmqqbm3ii2ek.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This adds value completion for a couple more paramters. To make it
> easier to maintain these hard coded lists, add a comment at the original
> list/code to remind people to update git-completion.bash too.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  This 6 month old patch was part of the attempt to automate value
>  completion. That might never come, but at least this is still good.

Perhaps this is not yet good without proofreading.

> diff --git a/builtin/help.c b/builtin/help.c
> index 7739a5c155..eef8b7c802 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -70,6 +70,10 @@ static enum help_format parse_help_format(const char *format)
>  		return HELP_FORMAT_INFO;
>  	if (!strcmp(format, "web") || !strcmp(format, "html"))
>  		return HELP_FORMAT_WEB;
> +	/*
> +	 * Please update _git_config() in git-completion.bash when you
> +	 * add new rebase modes.
> +	 */

Huh?  s/rebase modes/help formats/, I guess.

>  	die(_("unrecognized help format '%s'"), format);
>  }

> diff --git a/builtin/replace.c b/builtin/replace.c
> index affcdfb416..1c312725d1 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -82,6 +82,10 @@ static int list_replace_refs(const char *pattern, const char *format)
>  		data.format = REPLACE_FORMAT_MEDIUM;
>  	else if (!strcmp(format, "long"))
>  		data.format = REPLACE_FORMAT_LONG;
> +	/*
> +	 * Please update _git_replace() in git-completion.bash when
> +	 * you add ne format

s/ne/&w/;
