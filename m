Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF191F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfA2XKf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:10:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43757 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfA2XKe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:10:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so23976703wrs.10
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LzE1bYicaGcx4siBqnmlEwNYUeLIL2rDBgwQtTABOMo=;
        b=Myq+dKxdA3FJcIby2zwl4nmFnvSUUUJhqlyUyP4x1xB+t9Rl0EYLG9WecONNZCFeZn
         uIsnTgXSCPjVOGJ3oBg4XJUnZ7BRqcJGawpg+OPZQZdoCRAiDrtUKWlQJXXWAWJ9MmpS
         NqHNtYL8qid83JBfjj0iL8jUeVLFNa+XGs4Bat6ZZ02Pr/KCk+M9qZT/3oEF0sc9HNc4
         Zo1hMUhcWHHK8pihIx01BV7i8A2G68SQ9vqG3adChu6+mmfFe1Yz1JeR9HM9ZTpu001T
         7E4nLX/AtOlsOBjsE6jrtwCs+mgb/n1a8M1Z9wktOHuvrIo4auk6FjA2UOJIWrm0A5fs
         wemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LzE1bYicaGcx4siBqnmlEwNYUeLIL2rDBgwQtTABOMo=;
        b=ojSOmRgnRJ3uNdMheWRS0XfSzHDfcoVawwOiOlKkWf84TtaHCe5D5ZBfZMjgbX3DJg
         8okukRz3969yKrq3rq4Ci14kGqwFIWSPFFqhUabRJ6/n/mDofH9Azzm2aYZ2XdcjDj6C
         g62ie7XTeT34SkfbcJapuCdK0Kh6I4V76Pl0i1KSEpip1q7bTmP5+T1A2W87prYeuQG0
         T8Qy4eOPr9SCVVTyDWKL/OsJqbJFJDxaiWDTGN7nvOI4A42Xu1dVDiGQfpP4NrDyTlow
         GKJsy1xHQyr0wuQ7cUPMeUY/K9QhIfnp0z71ria6cMmDzCrLKrYSkzRyQgrjDYfR2O8k
         CuQw==
X-Gm-Message-State: AJcUukeqH7/QLA+boJgeGSUahg7L1bORh2EBVm2C9iqMJ6n8BDmc9QJG
        AXanx8rP/k8osf5G+1JZikg=
X-Google-Smtp-Source: ALg8bN6pFYCHMr8GYo2+mytrYQcSlSNlTt1cdMApBxCl+lFzOg5PeuSUo3/xBt5boLhPcZu4IyoNBQ==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr28359041wrw.123.1548803431754;
        Tue, 29 Jan 2019 15:10:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l6sm108106678wrv.70.2019.01.29.15.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:10:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled gitconfig
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-13-jeremyhu@apple.com>
Date:   Tue, 29 Jan 2019 15:10:30 -0800
In-Reply-To: <20190129193818.8645-13-jeremyhu@apple.com> (Jeremy Huddleston
        Sequoia's message of "Tue, 29 Jan 2019 11:38:18 -0800")
Message-ID: <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

> Useful for setting up osxkeychain in Xcode.app's gitconfig
>
> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> ---

A concern shared with 13/13 is this.

While it may not hurt too much to look at one extra location even on
non-Apple platform, it probably is a mistake to have this xcode
specific change in generic part of the system like config.c or
attr.c.  For that matter, would it make sense to force Apple uses to
look at one extra location in the first place?  In other words, we
already have "system wide" location (i.e. system_path(ETC_GITCONFIG))
defined so system owners can give reasonable default to its users.
The value of not using that facility and instead adding yet another
place is dubious.


  




>  config.c | 13 +++++++++++++
>  config.h |  2 ++
>  2 files changed, 15 insertions(+)
>
> diff --git a/config.c b/config.c
> index ff521eb27a..656bfef8ab 100644
> --- a/config.c
> +++ b/config.c
> @@ -1631,6 +1631,14 @@ const char *git_etc_gitconfig(void)
>  	return system_wide;
>  }
>  
> +const char *git_xcode_gitconfig(void)
> +{
> +	static const char *xcode_config;
> +	if (!xcode_config)
> +		xcode_config = system_path("share/git-core/gitconfig");
> +	return xcode_config;
> +}
> +
>  /*
>   * Parse environment variable 'k' as a boolean (in various
>   * possible spellings); if missing, use the default value 'def'.
> @@ -1673,6 +1681,11 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	else
>  		repo_config = NULL;
>  
> +	current_parsing_scope = CONFIG_SCOPE_XCODE;
> +	if (git_config_system() && git_xcode_gitconfig() && !access_or_die(git_xcode_gitconfig(), R_OK, 0))
> +		ret += git_config_from_file(fn, git_xcode_gitconfig(),
> +					    data);
> +
>  	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
>  	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
>  		ret += git_config_from_file(fn, git_etc_gitconfig(),
> diff --git a/config.h b/config.h
> index ee5d3fa7b4..f848423d28 100644
> --- a/config.h
> +++ b/config.h
> @@ -115,6 +115,7 @@ extern int git_config_rename_section_in_file(const char *, const char *, const c
>  extern int git_config_copy_section(const char *, const char *);
>  extern int git_config_copy_section_in_file(const char *, const char *, const char *);
>  extern const char *git_etc_gitconfig(void);
> +extern const char *git_xcode_gitconfig(void);
>  extern int git_env_bool(const char *, int);
>  extern unsigned long git_env_ulong(const char *, unsigned long);
>  extern int git_config_system(void);
> @@ -131,6 +132,7 @@ enum config_scope {
>  	CONFIG_SCOPE_GLOBAL,
>  	CONFIG_SCOPE_REPO,
>  	CONFIG_SCOPE_CMDLINE,
> +	CONFIG_SCOPE_XCODE,
>  };
>  
>  extern enum config_scope current_config_scope(void);
