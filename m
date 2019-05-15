Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3848A1F461
	for <e@80x24.org>; Wed, 15 May 2019 00:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfEOARX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 20:17:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44795 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEOARX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 20:17:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so367302pgv.11
        for <git@vger.kernel.org>; Tue, 14 May 2019 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1mZkP71DTWJ39+FcH6xI9rvBEYnEnzwChtRel8jpaTc=;
        b=TfS/6qdTgzon7Sg1y5sAOi6Ay+ygKbUGUMtJiVKLVnxUktuJPtCezvbbFMMDdXWXld
         CqP0J+Nn5iKCwQuMazppoetmRCVhn/utO5Ej2icunMfFgZKIv+QigyT+HZHD/SWddzOz
         EqIU5dK2Bq6fj1nEBtw/b0VzlOnXpWsTsYj+n+gIUmMbTxhqKwjBQHpqjwTPCUQ8I31e
         r+Xugr9KQ+klOZP0MXFCqxKP8ijuPhsbA0PhHQw7t9wIs6+sI1xe4PIGgBFm2OAk2/+y
         U0V5pcqIvhDUBQJYMagR3k+jX/b3/Kl4Ne0qxWXLJAHNJ8uy/SWbiqhlKfVDlGz9Gpcz
         +qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1mZkP71DTWJ39+FcH6xI9rvBEYnEnzwChtRel8jpaTc=;
        b=goRj+ks1rnOsSQ1j/EScBCDSI7WhczMLaXhHRjYZKE/tXZvifJPYNqTa2yzSAQE+K7
         EPemfyi5QCPSVRFAF+0fP9rVwY+ZcvJ2rc/e83mC+nc74PWgqudUOgCCctzSABGN2UNM
         Uua82O0H1STO+j425eUvXXsh/wBTTimrfhn3hjfmefFz4yj7XDc4JSUvS5Sw9ITjm0tK
         3NpvAsGBYDPKt03/cH3eB+ufAhTMUI+xuv6+jZbSc3ipyzpR5EYabmngGjAwRiYjumHZ
         +3DDNl8Jx90grGPUlU3qSAaOb/KQ2PBNrxNZyrP6AB6qjjoXocIqORyeLR6oVPQhlgUm
         +lTA==
X-Gm-Message-State: APjAAAUSGleRUufoC9JHfrBLrVNyy7p1u7f1c0Wu6g8eScAPEqjxPEwu
        TbdgEysy4s1kAsHoi7M4kUA/bw==
X-Google-Smtp-Source: APXvYqzJRDOZhatSsWeXrEmJkfgftq6R/gazokXxSQ3mX6Sn5YuWBWlkgIF6Tcz1UrJrP2IwaIQfZg==
X-Received: by 2002:a63:d70b:: with SMTP id d11mr38627173pgg.178.1557879442291;
        Tue, 14 May 2019 17:17:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id y10sm343782pff.4.2019.05.14.17.17.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 17:17:21 -0700 (PDT)
Date:   Tue, 14 May 2019 17:17:17 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git.c: show usage for accessing the git(1) help page
Message-ID: <20190515001717.GA138048@google.com>
References: <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
 <20190514152450.15220-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514152450.15220-1-philipoakley@iee.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 04:24:50PM +0100, Philip Oakley wrote:
> It is not immediately obvious how to use the `git help` system
> to show the git(1) page, with all its background and ccordinating
> material, such as environment variables.
> 
> Let's simply list it as the last few words of the last usage line.
> 
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> This follows from the discussion <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
> ---
>  git.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git.c b/git.c
> index 2324ac0b7e..9a852b09c1 100644
> --- a/git.c
> +++ b/git.c
> @@ -33,7 +33,7 @@ const char git_usage_string[] =
>  const char git_more_info_string[] =
>  	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
>  	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
> -	   "to read about a specific subcommand or concept.");
> +	   "to read about a specific subcommand or concept. Or use 'git help git'.");

I'm not sure the wording makes sense here. It sounds like you're saying,
"Or use 'git help git' to read about specific subcommands or concepts."
which isn't really what I think you're trying to say.

What about, "Or, use 'git help git' for a detailed guide of the Git
system as a whole."

(I'm still not sure that's quite it - since `git help git` mostly
details the flags you can pass to git before invoking a subcommand. But
I'm not sure that `git --help` is the place to say that...)

>  
>  static int use_pager = -1;
>  
> -- 
> 2.21.0.windows.1.1517.gbad5f960a3.dirty
> 
