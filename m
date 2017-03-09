Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E26D320135
	for <e@80x24.org>; Thu,  9 Mar 2017 02:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbdCICRD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 21:17:03 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35856 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdCICRC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 21:17:02 -0500
Received: by mail-pg0-f54.google.com with SMTP id g2so2811810pge.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 18:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WV+P2YbHJfr31EwEvU7kFE3Bin96sCrOGnyaXETFzIY=;
        b=TB1stZdY+J6LZt3NlSIRBk5cw66nW8MF78fpRv6GtGV0w7Ddaj2bYoGW4gLB+5cf45
         Nq076vXk5P656waDGVT+44U48rJuX5oMHChSajwFbRT4aLY1ZfUpOmidTXp8IrRmtCLv
         cIkht75w2mMonIzCX6+fumjtNc9J6ycKR5KDJ+xgZ8sFXw+bJS5fWSZTHK5rZNUkyTLB
         DS/kFsRsrd6VuPPEB4VPbXtg1VBZmfA8a/3TbnsglYch2onS7HujwyBJJxItn8aixgWc
         IM9UWTYTeDCn2sDcK8lXSkagxOjppRh5t0whMdkKbYa/tzdnhpYLJeQmflCt3/LHclbQ
         9Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WV+P2YbHJfr31EwEvU7kFE3Bin96sCrOGnyaXETFzIY=;
        b=g635N8czepUm88OW1Qe6IibDXgJWflhwvyiezTJ56F62TDwa8gb4TnKVV2Vg3TxBGJ
         AXWfNh+cY9PX55HX9YHvYwdY5ZZmKuRvR+gyhMQUwnxgk1f4IUoeCHEUO1KIR/u7AhST
         JfcI2K/unbM1COKmRsFuYDFEBlS8WGAPB3wHegCLaLC2YFhOhbcPwCjytHku+8JMQUlm
         3xqBGcNMXYeiJI7MIG0B4rx1FDRme7GZDk5DP6df9MRYBFlzEJqoMR/5R1foYuBJaZ5B
         XVqRTZa9Uv5UeaJU/lZZGb4wI8mxk9ikhuiss0ZvDOo+CqinRjKfJrbTKaoUFYFQYs3s
         V5kg==
X-Gm-Message-State: AMke39kfqE1eREtVzDI38imspgt5OVfnKXuvEriPqn1H5SrhFQ41dEhWZLSwizZtAo0rP2ZE+YvzIejj6U5Z3mpm
X-Received: by 10.99.98.6 with SMTP id w6mr10722344pgb.223.1489025783918; Wed,
 08 Mar 2017 18:16:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 18:16:23 -0800 (PST)
In-Reply-To: <20170309012345.180702-8-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com> <20170309012345.180702-1-bmwill@google.com>
 <20170309012345.180702-8-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 18:16:23 -0800
Message-ID: <CAGZ79kbyyJCZ7iP6c7RBgrv8NNSMjb9fov3eFazpOb2QL5aAcg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] submodule update: add `--init-active` switch
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 5:23 PM, Brandon Williams <bmwill@google.com> wrote:
> The new switch `--init-active` initializes the submodules which are
> configured in `submodule.active` instead of those given as
> command line arguments before updating. In the first implementation this
> is made incompatible with further command line arguments as it is
> unclear what the user means by
>
>     git submodule update --init --init-active <paths>
>
> This new switch allows users to record more complex patterns as it saves
> retyping them whenever you invoke update.
>
> Based on a patch by Stefan Beller <sbeller@google.com>
>
> Signed-off-by: Brandon Williams <bmwill@google.com>



> @@ -568,7 +573,17 @@ cmd_update()
>
>         if test -n "$init"
>         then
> -               cmd_init "--" "$@" || return
> +               if test "$init" = "by_config"
> +               then
> +                       if test $# -gt 0
> +                       then
> +                               die "$(gettext "path arguments are incompatible with --init-active")"
> +                       fi
> +                       cmd_init "--" $(git config --get-all submodule.active) || return

What happens with submodule.<name>.actives here?
