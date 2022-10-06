Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54906C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 17:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJFRQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJFRQq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 13:16:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C656DB48AC
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 10:16:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gf8so2268263pjb.5
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9+Ln5VqDaRnJuPM5Rs6MZmKiEpCS3r1kjAJ04j0gvQQ=;
        b=qR0kfwEC0jZ7esNr94uLQJMeLs27/YKt8S2Yk3oZnJm2Rqqe2vt54LxaZdSGUbClit
         1m5VL+7p+MNFZnppx7Lpe289A0ryyp3JpMLUPHk417T5WjEEn0+EIBfPPLB1Y0zHZCy/
         Th8n9jzimAjlwNYsOmsteHiyhAdVsupl15n+wozJ+Soxu4Mv0T6aSJZSZxDbHou9fPtP
         Erd7oP0uqTGac0MVrVE4YNd0+Q9CKE4nO5FA06MnB4qRr6q4wvUCcV2p70mrOqF1dUge
         uNYuXzpRmgfa2M/QrG6qz0g7qxVNK1MNgs+3TDXo6wzVLj/soflNYBWug0kftbwRmjEj
         yHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+Ln5VqDaRnJuPM5Rs6MZmKiEpCS3r1kjAJ04j0gvQQ=;
        b=ziZYSVsE8MHMs6xdNY9oRSqIpFq6vcJOLRWFR7JXbHlcEaOsecxpfl4UblZeo1dQ2W
         r+HPKKAPmXP2eJWF4jNl6craQJvX5g3pmqvA3nWLtj/EjYBWxNMH7k4tDVjNjoLEkrmn
         cfM4hR9L02sWeAGCCkDbi6QtsLj0A5E/BIjFB7fjzVrPn75GCls99pFMFzG2sjPyj+vl
         g6fJqh0h8rujpfDux1Ww3NAiZTCbcbWIb4abugrVdCGZtKx8PsUTa+N8Xh7jMJWv6IKj
         AB5S4tqEdViRz5U52RD3dRH+RPHNrRJJnHi7F8xyXOW1BjMDp9L75H/LEbmE5R17JPpG
         3p0Q==
X-Gm-Message-State: ACrzQf0l3UvTKDxmFE9LolD6l3PasFxpAUFVOwgyoNaxsWENXVKUV82F
        ea5QR+S/blWmC6J9GbslqRM=
X-Google-Smtp-Source: AMsMyM6El8ZgWPzIhAjntJkx2Bpx5RJ1VoHOHl2YT+eTRJrhthn6w5Laf23ReqgT0nq2FgFGjWwO8w==
X-Received: by 2002:a17:903:40cb:b0:17f:6e08:6eac with SMTP id t11-20020a17090340cb00b0017f6e086eacmr490413pld.80.1665076605141;
        Thu, 06 Oct 2022 10:16:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a100100b002005fcd2cb4sm3186385pja.2.2022.10.06.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:16:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "dsal3389 via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dsal3389 <dsal3389@gmail.com>
Subject: Re: [PATCH 2/2] removed else statement
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
        <c107ad9f6ff2d5e00134eb1348f24737774edbac.1665056747.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 10:16:44 -0700
Message-ID: <xmqqbkqolvnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"dsal3389 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: dsal3389 <dsal3389@gmail.com>
>
> there is no need for the else statement if we can do it more
> elegantly with a signle if statement we no "else"

Some people seem to use subjective words like "elegantly" but they
weaken your justification.  You are better off avoiding them.

As to the change in the patch, I do find it easier to read to have a
check for an error condition whose body unconditionally exits first,
and then the special casing of "version" and "help" as part of the
preparation for the "normal codepath".

    Side note: yes, you can steal from the last paragraph when you
    are redoing the justfication of this patch.

Thanks.

> -	if (argc > 0) {
> -		if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
> -			argv[0] = "version";
> -		else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
> -			argv[0] = "help";
> -	} else {
> +
> +	if (argc <= 0) {
>  		/* The user didn't specify a command; give them help */
>  		commit_pager_choice();
>  		printf(_("usage: %s\n\n"), git_usage_string);
> @@ -907,6 +903,12 @@ int cmd_main(int argc, const char **argv)
>  		printf("\n%s\n", _(git_more_info_string));
>  		exit(1);
>  	}
> +
> +	if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
> +		argv[0] = "version";
> +	else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
> +		argv[0] = "help";
> +
>  	cmd = argv[0];
>  
>  	/*
