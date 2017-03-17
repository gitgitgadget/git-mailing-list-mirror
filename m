Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B409C20951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdCQTHy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:07:54 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36261 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdCQTHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:07:53 -0400
Received: by mail-pf0-f175.google.com with SMTP id o126so41316052pfb.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WPtse0bVBjXWQ9JMJIi1BN0pqW2d9jT6LTgSSs5Z0WI=;
        b=BeeyYClaSKIjLqS3sDnNA/05GHuKqDL++//t2/oWhQ/qUMtdMhhZk26lHpbpi3rnMi
         HX8/29+PxTgcJZ0YedolBu7kI9HN+UQ1+FbkdSTXRsmjQLBRdsH2liG4fxAQjqF2Z2H7
         /h7XG77RkOUryNgfoM8JkA2pS7anzzD8nnzwbYx1P7KplvmOrt5HJGRjqDUr0+6yCX40
         Wvhv/22siIoDg85B+9UkUchoIfaye2W755ybNWUGyeUhNovFQsFKbj735mXot4NDc/Ru
         rCJysFSBXZpWz6Re5JRWCHwRiiZikBhh9td0xVMDRagO2UuB0llQVovztTN2xnycBlWt
         /vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WPtse0bVBjXWQ9JMJIi1BN0pqW2d9jT6LTgSSs5Z0WI=;
        b=gOhyIFeIqMyVCRvascRrPaU3leC+OUnSQKetiRNti2ug68HEdhIcI5cJpszB+FvM09
         rtualR2YcfIEdKxt1x2V6mxd5qWyX4x0w2MS2eUqLAJI4wHKcPwjRpH6JwmPW7U9jRD7
         Yocw+2Y3lDWjnwziR0YtK2JWOTr4pINbAsy00KKWUYDeDKGUaX7QG6mKpgvmxDaifAFV
         DVYgPikSdDzXjw76OveRemGfxXn6sLk1HFwCx4s7vYvnIBkynC8eIlBL+i0BuQbphOnZ
         u/eG3q893/PtNCGt1H+/8vhitvNChL6P7Wo15c7lV1ruMtBPE/YRVKoY7jDBajU87j17
         FY5g==
X-Gm-Message-State: AFeK/H19wmAVywOoox0ahC3qPEQiLQortq1yTrMIP6XAwejmhnaenQ/z/V6HcrY6SKgLNy5IqBs/s83WoWVGFGec
X-Received: by 10.84.239.8 with SMTP id w8mr22037703plk.73.1489777666754; Fri,
 17 Mar 2017 12:07:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 12:07:46 -0700 (PDT)
In-Reply-To: <20170317172257.4690-3-bmwill@google.com>
References: <20170314221100.24856-1-bmwill@google.com> <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 12:07:46 -0700
Message-ID: <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git commands
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>         prefix = setup_git_directory_gently_1(nongit_ok);
> +       env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
> +
> +       if (env_prefix)
> +               prefix = env_prefix;
> +
>         if (prefix)
>                 setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);

so we load that GIT_TOPLEVEL_PREFIX_ENVIRONMENT prefix
first, such that we essentially copy it into GIT_PREFIX_ENVIRONMENT,
such that e.g. aliased commands will know about the superprefix, too.

ok, sounds reasonable to me; though I do not use this feature,
so my judgement is not as good.

Do we need a test for this behavior?

Thanks,
Stefan
