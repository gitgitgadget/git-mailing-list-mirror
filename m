Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8B120248
	for <e@80x24.org>; Mon, 15 Apr 2019 07:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfDOHTH (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 03:19:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40809 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOHTH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 03:19:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so18992653wmi.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 00:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=9DXxZKtHJijuRC8dfvzOju7mkKQ+tPoVaB/NXzTBbPo=;
        b=V+jZVDKz+kicoEBebQnBk0fWRZjYxDbvGYCy0upnOnalS/3JBH/iIGIBgLt+9s85R8
         wqG1VcQfa9Rv8xXWS1hN1KPWXVGa2UGZIRNt8wCTDq5ahTqgPj39G0c0roSBE3Hsb2TP
         MONmEYEBFREJ72J/1IxLVAOTXMPlNqAbxS6sj08dhdhij9E3OJ/fmlsDOp7217pHJvG8
         Fhbk9ptt4D20b/nT8DrEjv5gIPhr5n+SX6aSfOTfj9+OoOdRWn2Nmrj8iEoKJSc+jpvp
         VfacAqO7q/LtiH+I5f5SOGyk4xjd1AI42gG3ksskLoLcwGsBFpsGkOzEsqzSlaRioJPS
         hCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=9DXxZKtHJijuRC8dfvzOju7mkKQ+tPoVaB/NXzTBbPo=;
        b=V/E/ocXtGvfTrXUIXKCVlzew2zrEMTzRzXJaytPkjvoS4m9gNCdX78NPV9bpoBW5zN
         NrcHp5OwxrnMASqiBWsf2YnO97CiWgIEUVvxGKAIlXxejIpLu6/QW9C9WnlFzJSZB7ST
         xlSzY+rPihRFJoyYRXymvUs3NzpNgIDKFAV08U5aYAxd+zyy2DTtM8cieAE25qRyw+jq
         gDrB9FKo3npX1XsSbdbMXy7x5y6wr0zzKe57czX13jIekERsGwB0BEXZk3aSwlJeoMZB
         auPZ239rEMuKlcsc1EMtzIuXY2BuHDGrujucDKdgKs/kYlnaTMDGJV2Vg0a+A2WU7B9/
         5DnA==
X-Gm-Message-State: APjAAAWFFS7zZm9QAFU7IBAOBy9Cn/cv91YnREFjmWVkHqsApomZGAEM
        CrNDgTa3d9rUj2UT7OTGYztI85V/mF4=
X-Google-Smtp-Source: APXvYqwxtqMTP+NwlUQJoO/lp953al82gSCaaT/JJxQPx+g5+TLBC5yM7HcN0ZWcAlxK0zND4xlFEA==
X-Received: by 2002:a1c:9d8f:: with SMTP id g137mr21610427wme.26.1555312745067;
        Mon, 15 Apr 2019 00:19:05 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z140sm42054426wmc.27.2019.04.15.00.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 00:19:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/7] check-docs: do not bother checking for legacy scripts' documentation
References: <pull.168.git.gitgitgadget@gmail.com>
        <fb3daa6427595b1df24d3664212a704da171c95e.1555070430.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Apr 2019 16:19:04 +0900
Message-ID: <xmqqwojvrb13.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Obviously, those `git-legacy-<command>` commands share the documentation
> with the built-in `git-<command>`, and are not intended to be called
> directly anyway. So let's not try to ensure that they are documented
> separately from their built-in versions.

Yup.  

This is the "other" loop that goes over the list of ALL_COMMANDS and
makes sure each of them has its own documentation page.

Looking good.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index a5212c64bf..caa20923a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3074,7 +3074,7 @@ check-docs:: Documentation/GIT-EXCLUDED-PROGRAMS
>  		git-merge-octopus | git-merge-ours | git-merge-recursive | \
>  		git-merge-resolve | git-merge-subtree | \
>  		git-fsck-objects | git-init-db | \
> -		git-remote-* | git-stage | \
> +		git-remote-* | git-stage | git-legacy-* | \
>  		git-?*--?* ) continue ;; \
>  		esac ; \
>  		test -f "Documentation/$$v.txt" || \
