Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A91E21F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfJ2U6a (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:58:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39062 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfJ2U6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:58:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id t12so3657460plo.6
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+5QdaZMSpUJMtdPCdrL0KNgTsvzXg9j5GqzCDsTtk4=;
        b=lJ40vzsoGEyX2J8x+sd3DU2eW4PkC80eYVpcFm9p7TiRrf+CSqJpkXX9Fzrsr8Nekc
         XnTQ0v8mJxo52grPmtx9X81eP5+k806zMh7m4u1WxdTU0StCllMdpXIzCJFqNHWKwrEB
         FxstliOw679BYaFhAJpxM2E3CTQP1MESQ4OBEgeGyLfzv37+naSfqOgrTH1co3V7lE42
         x7HCd5tDqbTwGYir/ifM80HjwHC9q7Ty2xNEAnb5Rhf2sRMcGG1R5vZKL/Mj7oGMYDW+
         H3xI4PFC8Bzdr2ss5qBqly1CDevu5vItGfGk4qAtJIcBWD6HEfpYtnIrrh5QQQlsziXW
         GBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=J+5QdaZMSpUJMtdPCdrL0KNgTsvzXg9j5GqzCDsTtk4=;
        b=XPFQ6gInXjh6G3MngU/QVZxakI3BSHbdfcfXls777T+Xn+yGe9sEL/keFRNKDo3du4
         lDWC06as5q5M+v1UdyQUPJsffS4LNClf4cUSYaJwiBrOA2qjPAGbf2VwFzzpRf/qLoUd
         VncMISN5sUvShm35Ydu3yW/xiHv5EXrQkuwoP1IbCgstlFuNW27eYUrAv76q8k3md5Hv
         9pcWoLqyqw9fEbjEUqyb3KccLPbdO34Kkwog94Ppbk9BF/0RvBsHEW1LLXGmYf7itbu1
         KIMbRKIrPR59nicQ8HIC5AIohWNSw9ZOfqbQ3LyW2vU/azhJpYRohyGURhsHwKqUrPTc
         jExA==
X-Gm-Message-State: APjAAAUfts/yNtFoPX4e5inu0oaBupd8uboyeqqcWOjl+7eipr1TrRvg
        p5hwbEq1iT1X8IdMYQlS22Y7D2yFD5I=
X-Google-Smtp-Source: APXvYqw01wVZIGiOaCUa1KcsIpA7yCZaHIgdie7yBxu+jjjMQY3x0F0yXWv/Yn6X03CH6d5eW1XRbQ==
X-Received: by 2002:a17:902:7289:: with SMTP id d9mr690799pll.121.1572382709136;
        Tue, 29 Oct 2019 13:58:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id s24sm12936pfm.144.2019.10.29.13.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:58:28 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:58:23 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/9] bugreport: add config values from whitelist
Message-ID: <20191029205823.GC12243@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-5-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025025129.250049-5-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.24 19:51, Emily Shaffer wrote:
[snip]
> diff --git a/bugreport.c b/bugreport.c
> index ada54fe583..afa4836ab1 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -1,10 +1,24 @@
>  #include "cache.h"
>  
>  #include "bugreport.h"
> +#include "config.h"
> +#include "exec-cmd.h"
>  #include "help.h"
>  #include "run-command.h"
>  #include "version.h"
>  
> +/**
> + * A sorted list of config options which we will add to the bugreport. Managed
> + * by 'gather_whitelist(...)'.
> + */
> +struct string_list whitelist = STRING_LIST_INIT_DUP;
> +struct strbuf configs_and_values = STRBUF_INIT;
> +
> +// git version --build-options
> +// uname -a
> +// curl-config --version
> +// ldd --version
> +// echo $SHELL
>  void get_system_info(struct strbuf *sys_info)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> @@ -53,3 +67,39 @@ void get_system_info(struct strbuf *sys_info)
>  	argv_array_clear(&cp.args);
>  	strbuf_reset(&std_out);
>  }
> +
> +void gather_whitelist(struct strbuf *path)

This and git_config_bugreport() below should both be static as well.
Rather than repeating advice on the later patches, I'll just note that
any new functions that don't show up in the corresponding .h file should
be marked static.
