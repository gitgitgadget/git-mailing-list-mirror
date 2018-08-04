Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE411F597
	for <e@80x24.org>; Sat,  4 Aug 2018 06:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeHDIJA (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 04:09:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36892 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHDIJA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 04:09:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so4334596pfo.4
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 23:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Mi8GuSuWdYsGNyOL5xFlVTILQK60f93an3fWvnDebk=;
        b=mCSUmtMTR3tDhB5gUS4IUqQWaLtee5jMYmihAXGekoZU+z0k5ak7N6T26erNtnE8M/
         fGbUTUpbDutri4kn0jC/jw7OyqHpnK/NTPYDknZWTLHLZmlkfX6GaWaT2OxfZRiGot/G
         xVbode3UJxD5NgJ4GgXPPS3QAFMgaMP0A1o+jr0XplX4x1C86tJ9nWsae0tvE4V48RQX
         N3fR24Brzhb/lMye+1C/gLO0Bc4yUKTXnZ5GyyrxqqY5rmt2Uh6awbj7JQYI6Y/GoHrL
         C8sNSTnQ/40ie0fQWaUbn9Juho5mXf6HP7VtE9tl1vWx1OZknVAHrczmwMY9gXDLunnJ
         Tfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Mi8GuSuWdYsGNyOL5xFlVTILQK60f93an3fWvnDebk=;
        b=rOysMLTrwS/uaGa+sKODaJN6qroZXkprQRsE5AgQogVI7QD8dqDZDlGoGa27z+IQ51
         0Nm5HogFFpHlXTRpRPL2COGqKG17Thgad5C+BoJEaVMQKss/ptLBewe04KuKJ9gncR3F
         LT7DXIDcUIV+6V/ofSU5hKfnGVSlp/dDBYc+dpOY1VxM/8VKjhotNncuW72PmeRDVv4e
         NgN3QRm6xvyq9lL1hZjFFpli8eiNLXYjUhwpeNv2xpz7KVKjOG82NydRsZM05X7fkTv5
         SqOFpqlOOKHd5kKpyqpU8sfwHVjPkM6XcsvZOiqj434qXmmn5TmsmTsXZ7SbmZKULp//
         j23Q==
X-Gm-Message-State: AOUpUlGc1G2Wa4Qz2W9TuWBCFDACSj0fA84vHa6BeCfZvalSeoS/bqfm
        s5Lw39WQLf+t2jw/hzU5NQk=
X-Google-Smtp-Source: AAOMgpfJI98apl4qMWI97OqxlBDwFz0hGH5o15vktzfIgpSRlZw0S2TqsBq5WqGXL/C3YKSLmOXKGQ==
X-Received: by 2002:a62:ea05:: with SMTP id t5-v6mr7689675pfh.228.1533362970818;
        Fri, 03 Aug 2018 23:09:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c1-v6sm14283847pfg.25.2018.08.03.23.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 23:09:30 -0700 (PDT)
Date:   Fri, 3 Aug 2018 23:09:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org,
        git-packagers@googlegroups.com, hanwen@google.com
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
Message-ID: <20180804060928.GB55869@aiede.svl.corp.google.com>
References: <20180804020009.224582-1-sbeller@google.com>
 <20180804020255.225573-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804020255.225573-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Reviewer bandwidth is limited, so let's have the machine of the
> (potentially new) contributor warn about issues with the code by default.
>
> As setting DEVELOPER, the compiler is stricter and we may run into problems
> on some architectures. But packagers of said platforms are knowledgeable
> enough to turn off this flag. (Also they are fewer than the number of new
> contributors)

Which architectures would we run into problems on?  Aren't those bugs
that should themselves be fixed?

I think you are right that the packagers will cope with whatever
setting we choose.  My main concern is not about them but about other
people building from source in order to run (instead of to develop)
Git, and by extension, the people they go to for help when it doesn't
work.  I have lots of bitter experience of -Werror being a support
headache and leading to bad workarounds when someone upgrades their
compiler and the build starts failing due to a new warning it has
introduced.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 41b93689add..95aa3ff3185 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -497,6 +497,8 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
>  
> +DEVELOPER=1

I like the idea of making this more discoverable to new contributors.
It seems that Documentation/SubmittingPatches doesn't mention this
setting.  Should it?

Should a non-DEVELOPER build print a note encouraging enabling this
setting in case you're developing patches meant for submission to the
project?

Should we have a CONTRIBUTING.md file suggesting this setting?  Other
ideas for ensuring it's enabled for those who need it?

Thanks and hope that helps,
Jonathan
