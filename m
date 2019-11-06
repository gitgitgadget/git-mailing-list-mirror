Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D9F1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 22:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfKFWDb (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 17:03:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35267 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKFWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 17:03:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id q22so10520453pgk.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KgaBLsgzibLLWM6xMCL59L8rq1geZI2rE8lh3e3uPXE=;
        b=Z50EhekmGM6AfabM50Oe65XUbGiEZ9Otl+ByuURa5AZsMqpaO+WhNsHDQSotYFXgIw
         fM3Uy7wOtpz/O5OGCs4Fi3Dv+som5YtZBGa7TwzJj1zk18g8u5008lNWTfJd8C89wL+T
         Fa/i7uQVewUPyQdiAph9xXo8SEVgw7I1AgMUeLwkDUEaAVqCAmsoeMzEttQjeApllXeD
         25T4lzgWc7aKUFRCqE4dI8RlEFrhNgjTgJhQg/yha58XhcCkb33bhboZnhtlHBwFsKw/
         YNdl4nRfw6bcNDPOttap/4F1mUmPjxMB92nWGytRpTjNl4IW6F5FON3uFhcXE6dfwupT
         gHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KgaBLsgzibLLWM6xMCL59L8rq1geZI2rE8lh3e3uPXE=;
        b=GNTEqo4pgHGyk3cbjQWhGDi+g4go05W+0BI7+5vPwzBvAB1TlUym/VGYLtJzgxHieK
         zITRY6uMZWo/GKQWm3cV6KGTstxcXsIMZxt+gbiFltUIOab/tpT31xu9K/bOU422HX9U
         KooXK1lWWKOj7PqwCFMdKPM6sQVE22iRlxg6Aly7Aq4BcmZ48vzzDsi2dhI/bHbrjc0x
         pX+Xutm28jws8BY2k6sK6nioTyWdFgQYhxG66wA45qk8MfAaOAr06Odj5AEupdRNbcKa
         a/zjhROje3Qhs28kemrQZmr3vZHkXuA9tgn3Ynv6UJkBWpga5ETvthKXUzrRHxdNFxQA
         Jg5g==
X-Gm-Message-State: APjAAAX1a9vcwJawg5nFFGg43B6RlfUT1t4nK3SbiGX9N5LCx22v5d5w
        OX72mVWwp3GhT7YYlaBQreRP4ixUB0I=
X-Google-Smtp-Source: APXvYqzWHnYfRtV9rxsqNzu3JzM7xDBPme4FnOGrw9MeEcHr8XIBEYq15CeYxLLJn1ZLENZlptti1A==
X-Received: by 2002:a17:90a:86c1:: with SMTP id y1mr125471pjv.71.1573077809199;
        Wed, 06 Nov 2019 14:03:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id o125sm2144217pfg.118.2019.11.06.14.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:03:28 -0800 (PST)
Date:   Wed, 6 Nov 2019 14:03:24 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/20] sigchain: move doc to sigchain.h
Message-ID: <20191106220324.GD229589@google.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <3499b99538425f9605fead842c10bc63238f94b9.1573034387.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3499b99538425f9605fead842c10bc63238f94b9.1573034387.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 09:59:38AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Move the documentation from Documentation/technical/api-sigchain.txt
> to sigchain.h as it's easier for the developers to find the usage
> information beside the code instead of looking for it in another doc file.
> 
> Also documentation/technical/api-sigchain.txt is removed because the
> information it has is now redundant and it'll be hard to keep it up to
> date and synchronized with the documentation in the header file.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  Documentation/technical/api-sigchain.txt | 41 -----------------------
>  sigchain.h                               | 42 ++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/technical/api-sigchain.txt
> 
> diff --git a/Documentation/technical/api-sigchain.txt b/Documentation/technical/api-sigchain.txt
> deleted file mode 100644
> index 9e1189ef01..0000000000
> --- a/Documentation/technical/api-sigchain.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -sigchain API
> -============
> -
> -Code often wants to set a signal handler to clean up temporary files or
> -other work-in-progress when we die unexpectedly. For multiple pieces of
> -code to do this without conflicting, each piece of code must remember
> -the old value of the handler and restore it either when:
> -
> -  1. The work-in-progress is finished, and the handler is no longer
> -     necessary. The handler should revert to the original behavior
> -     (either another handler, SIG_DFL, or SIG_IGN).
> -
> -  2. The signal is received. We should then do our cleanup, then chain
> -     to the next handler (or die if it is SIG_DFL).
> -
> -Sigchain is a tiny library for keeping a stack of handlers. Your handler
> -and installation code should look something like:
> -
> -------------------------------------------
> -  void clean_foo_on_signal(int sig)
> -  {
> -	  clean_foo();
> -	  sigchain_pop(sig);
> -	  raise(sig);
> -  }
> -
> -  void other_func()
> -  {
> -	  sigchain_push_common(clean_foo_on_signal);
> -	  mess_up_foo();
> -	  clean_foo();
> -  }
> -------------------------------------------
> -
> -Handlers are given the typedef of sigchain_fun. This is the same type
> -that is given to signal() or sigaction(). It is perfectly reasonable to
> -push SIG_DFL or SIG_IGN onto the stack.
> -
> -You can sigchain_push and sigchain_pop individual signals. For
> -convenience, sigchain_push_common will push the handler onto the stack
> -for many common signals.
> diff --git a/sigchain.h b/sigchain.h
> index 138b20f54b..a990f18cf6 100644
> --- a/sigchain.h
> +++ b/sigchain.h
> @@ -1,12 +1,54 @@
>  #ifndef SIGCHAIN_H
>  #define SIGCHAIN_H
>  
> +/**
> + * Code often wants to set a signal handler to clean up temporary files or
> + * other work-in-progress when we die unexpectedly. For multiple pieces of
> + * code to do this without conflicting, each piece of code must remember
> + * the old value of the handler and restore it either when:
> + *
> + *   1. The work-in-progress is finished, and the handler is no longer
> + *      necessary. The handler should revert to the original behavior
> + *      (either another handler, SIG_DFL, or SIG_IGN).
> + *
> + *   2. The signal is received. We should then do our cleanup, then chain
> + *      to the next handler (or die if it is SIG_DFL).
> + *
> + * Sigchain is a tiny library for keeping a stack of handlers. Your handler
> + * and installation code should look something like:
> + *
> + * ------------------------------------------
> + *   void clean_foo_on_signal(int sig)
> + *   {
> + * 	  clean_foo();
> + * 	  sigchain_pop(sig);
> + * 	  raise(sig);
> + *   }
> + *
> + *   void other_func()
> + *   {
> + * 	  sigchain_push_common(clean_foo_on_signal);
> + * 	  mess_up_foo();
> + * 	  clean_foo();
> + *   }
> + * ------------------------------------------
> + *
> + */
> +
> +/**
> + * Handlers are given the typedef of sigchain_fun. This is the same type
> + * that is given to signal() or sigaction(). It is perfectly reasonable to
> + * push SIG_DFL or SIG_IGN onto the stack.
> + */
>  typedef void (*sigchain_fun)(int);
>  
> +/* You can sigchain_push and sigchain_pop individual signals. */
>  int sigchain_push(int sig, sigchain_fun f);
>  int sigchain_pop(int sig);
>  
> +/* push the handler onto the stack for many common signals. */
It was lacking in the original doc too, but I want to know which common
signals it pushes for. Is it too much work for you to peek in the
implementation and let us know?
>  void sigchain_push_common(sigchain_fun f);
> +
>  void sigchain_pop_common(void);
>  
>  #endif /* SIGCHAIN_H */
> -- 
> gitgitgadget
> 

Otherwise this one looks fine for me.

 - Emily
