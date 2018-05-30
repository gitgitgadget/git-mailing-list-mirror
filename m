Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E021F42D
	for <e@80x24.org>; Wed, 30 May 2018 03:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeE3Dt7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 23:49:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50973 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbeE3Dt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 23:49:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so45083969wmt.0
        for <git@vger.kernel.org>; Tue, 29 May 2018 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=76fg93hGxFX3iRssLhrYnKgtXiujhEgXaQUNlBr1tiY=;
        b=PO1YYCbbWDGauYafynBCpMKmKRq9SqoT+GiAp3PJsfhkhypKetkHHpxUYTEtVYZFQb
         ByAefHf4uxCf2V6OLvPsjnR2upywlqeqVPqKKDkN3Raztfmg/vbU7pcd73/htx0c9RhY
         yfu6ey8KD+nGA3WqPIN6Y5Z+wo6rrOxWDEEQ7XUgTQYHphrUP0gVOCk5b16MQkTGCpcJ
         JfsAztlDXtV20h25IpFMurb1l7EMgvNaAu+WJ+/ei3JKG18beSj74WGrv0yqapNgbKfT
         PeAyCgkqQxKa6+b0Em+UtFj3RV1dvF3c/H5Hlcamr2u7SMooHl4XQ54cuTnH6ScwBqEA
         OqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=76fg93hGxFX3iRssLhrYnKgtXiujhEgXaQUNlBr1tiY=;
        b=bcedUnUSfIonfGH/NSrX0qxhIb/9nlFcuSOP3LuafaeonOmfh3glvooRtezAwl/JzP
         Rtt+bpAYId8Nb5zSnHSyqKndG9zG1YdDTGfL0HXNUAtJzxGPym3YZHQg3id9EmRSY9eq
         TmFC1cvmhLC/Pgx+km/rxzIGeITgQIg8MY5EohF8OjHMfYqgEfV6lI44g0+znGUa2hUh
         iaYeBQsVBmPX189264iMPjBXXanJGjHBB1u1AV2ffL3HoAMBV89rvWJFI+1dxy0otmtT
         CuALQsdQj+rz9mHKQjmapmJaondSCJ17DHcXgluveiUk/3kIipnjG9GFZbd6JMQD0LHD
         VEpg==
X-Gm-Message-State: ALKqPwcao3HhNW7pbZSWksShu/RFEMDOfFT2U5ufSTGIOK7lnJZ7aicu
        ASQRRfiAaXfZKk6GZIzBGo4=
X-Google-Smtp-Source: ADUXVKKbGvfElgillTTPDfTDHuGWfxfV63RpIiTmT4UcueLGExSGRg93l/VQXx6IU5Nr2yPTQrF8xQ==
X-Received: by 2002:a1c:64c5:: with SMTP id y188-v6mr137425wmb.45.1527652196499;
        Tue, 29 May 2018 20:49:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v31-v6sm42882388wrc.80.2018.05.29.20.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 20:49:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Subject: Re: [PATCH] completion: complete remote names too
References: <CGME20180525104848eucas1p28c88d657362066ea26d4eedaaef71f90@eucas1p2.samsung.com>
        <20180525104842.2930-1-l.stelmach@samsung.com>
Date:   Wed, 30 May 2018 12:49:55 +0900
In-Reply-To: <20180525104842.2930-1-l.stelmach@samsung.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C5=81ukasz?=
        Stelmach"'s message of "Fri, 25 May 2018 12:48:42 +0200")
Message-ID: <xmqqefhtera4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Łukasz Stelmach <l.stelmach@samsung.com> writes:

> "git remote update" accepts both groups and single remotes.
>
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Soliciting comments from usual suspects around this area...

Thanks.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 961a0ed76..fb05bb2f9 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2632,7 +2632,7 @@ _git_remote ()
>  		__gitcomp_builtin remote_update
>  		;;
>  	update,*)
> -		__gitcomp "$(__git_get_config_variables "remotes")"
> +		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
>  		;;
>  	set-url,--*)
>  		__gitcomp_builtin remote_set-url
