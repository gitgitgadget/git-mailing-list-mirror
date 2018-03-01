Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262F11F404
	for <e@80x24.org>; Thu,  1 Mar 2018 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033178AbeCARLC (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 12:11:02 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:43765 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032742AbeCARLB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 12:11:01 -0500
Received: by mail-wr0-f178.google.com with SMTP id u49so7330066wrc.10
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MHtf8vJatXtQ7TQmPQJTHtNkUmODMjRDZo2kHg4P1pc=;
        b=YI7zN/WAONAasXCQW7pvM0txqel0JlXecfj4uTdzHqSmHz9IqgMWNJ0huVgJzojnWL
         U83FaH+YbDnqH7XAxXoPbWBlrwYB3K0/InaYUyjGcHVBEoAeQk7slhGr6Vo6QaJK3u/3
         YMhNhcy2uG3w2kq0kYWq4THgCIjXpH3YAeGlTkXKpPOv+YFKphdyzlQu1X5jtnLtERve
         LjnPzK645eKSyyCEgfenNRokEAQD5zVZL+89/VYGBsfEy2AR34EdFWL5g3e24Cg0Uz6m
         liDzEK2GuYAq0Yd2pSpQVoQviePrwjs/rhE0K3CROliUi0axyLfs8BEWdWeyR0gtCtj4
         QP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MHtf8vJatXtQ7TQmPQJTHtNkUmODMjRDZo2kHg4P1pc=;
        b=jXg09X4eOGhLfdcA3pJcbCy8YbP/qom7UgXpiPBAJG3vzDLdaDf7qSLzOfPcw1QJY8
         SRue368vl9E7DuKJNrlldmCu6vlcPZ973Oh1MQHX1k+1/uO0TkhuHCQIr3+Ty5XXI1wu
         8Q9VaHemPUsaQK2ZUkLS4kOwHTWC0BNrt1AnVQVaxpYFQoh0T9OaWCwOyadRxXZws+fO
         90P6xHekdNBhC8o77snYMjwb6ql01AZliDnAbid8SBb1oy/mymOXugpY9baxFsHPg1RF
         e8D/ZW+keCOJFigzaHBB5Xa2+VS2r5Uji57hFfj0PYSGzF1UgGz7oTBcMKr/gjnwxo8B
         EWeQ==
X-Gm-Message-State: APf1xPCNBQtSs8v4kq7u9+tN4xepBJkpNUMVVw8yvC915KCKFgfEAlOC
        am2z287WeuK4vK91Uycf4ks=
X-Google-Smtp-Source: AG47ELszF23xSWuuzVPdnwraGnFDa6wOCPhkHczOYnYePmKHPUossLB1AabKvu9PYejdIQUTkEPxOw==
X-Received: by 10.223.173.18 with SMTP id p18mr2644503wrc.29.1519924259723;
        Thu, 01 Mar 2018 09:10:59 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 142sm8215678wmq.47.2018.03.01.09.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 09:10:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leah Neukirchen <leah@vuxu.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] color: respect the $NO_COLOR convention
References: <87zi3reoez.fsf@gmail.com>
Date:   Thu, 01 Mar 2018 09:10:58 -0800
In-Reply-To: <87zi3reoez.fsf@gmail.com> (Leah Neukirchen's message of "Thu, 01
        Mar 2018 17:44:20 +0100")
Message-ID: <xmqqefl3iuvx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leah Neukirchen <leah@vuxu.org> writes:

> NO_COLOR (http://no-color.org/) is a comprehensive approach to disable
> colors by default for all tools:

The list of software that supports that "convention" is, eh,
respectable.  Is it really a "convention" yet, or yet another thing
the user needs to worry about?

> diff --git a/color.c b/color.c
> index d48dd947c..59e9c2459 100644
> --- a/color.c
> +++ b/color.c
> @@ -326,6 +326,8 @@ int git_config_colorbool(const char *var, const char *value)
>  
>  static int check_auto_color(void)
>  {
> +	if (getenv("NO_COLOR"))
> +		return 0;

Our convention often calls for CONFIG_VAR=false to mean "I do not
want to see what CONFIG_VAR wants to do done", i.e.

	NO_COLOR=false git show

would show colored output if there is no other settings.  But this
code contradicts the convention, deliberately because that is what
no-color.org wants.  Makes me wonder if that convention is worth
following in the first place.

>  	if (color_stdout_is_tty < 0)
>  		color_stdout_is_tty = isatty(1);
>  	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {

According to no-color.org's FAQ #2, NO_COLOR should affect only the
"default" behaviour, and should stay back if there is an explicit
end-user configuration (or command line override).  And this helper
function is called only from want_color() when their is no such
higher precedence setting, which is in line with the recommendation.

Which is good.
