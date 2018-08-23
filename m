Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E030A1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 17:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHWUuw (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 16:50:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33253 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeHWUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 16:50:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id i134-v6so2566012wmf.0
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 10:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3bFleMKO1E/Y/FuLLK6VwjgJK4Ixz7332upCypUiqpU=;
        b=I5EDRscEsyEG2UOXm9CKPpMeaTusXqNe44zCdJiJwuYT9qVama6mguBOal61IZAuMo
         iqZgpfmL0Zp3mGQmne2TpmidpE2UHP/S/aL6SaQN8cDxka0hWiN8SwguTk526QprV8xM
         pCMiJZxC0KS/lSwrUaaKqufQs1ZSXMFlfPeWSlhIxB6+UmE5zLpXyJqCT+/89SJXrOcB
         vWmrQ6Rq44YEMJnd6CyN85Y9L3PuTIRHwsEc2FB5dh4xNq5p773m0qNRzIJ5H+py7J7C
         SaS97BwXIJXAzMQ2sPfk4vG4ww1vQEChEPmaiOPWu70Vkwh0986xd0RbNWMFEN++lgD6
         LuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3bFleMKO1E/Y/FuLLK6VwjgJK4Ixz7332upCypUiqpU=;
        b=PsHQxIWwbhte6yX2RGNFfSRTrRDRS7WZUIPAch48QhZ8s2ML38qwo1Y7kp+U4WUmco
         JYUXOUUB0Jc1gNepgDO4RJPyNJQPQacDXz9eldotQONQt7Ze9+Nt+VP3pnN3FPOlnVwp
         Ye/2+gOCA44MetatJkb9LOH8MHm0buTN1zthcpn0Xr/PHn58jQbIO6BEZBp56NeOKNGL
         Q0hIIWYlgHKs5n27IO3vbGLZxDOK9unJlfxy8FmIMQ3M4kGmshX6E8rBy8kASLUkKNgg
         GaorP7SAdfs1ukMdck7AXQe1X1PbcOjGSz6q4VqDVT0c/QObSgZS0PeHSerZK2vKTSxj
         37qA==
X-Gm-Message-State: APzg51CMv5ZMbGRkDp0Hy5v1c7iqZX+c6imi9+b2vmB08Qg1+nm0v9VR
        Sk5H0lW9QX6s2s6R/zJFXfo=
X-Google-Smtp-Source: ANB0VdZs7E1crGOqZJFeUkdWZyKNfq+QeDd3quYhSBe/crnGdT0ifqSMuDvGOC8ngdXie4nEaWYNSQ==
X-Received: by 2002:a1c:7711:: with SMTP id t17-v6mr3336089wmi.35.1535044808194;
        Thu, 23 Aug 2018 10:20:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i125-v6sm7566810wmd.23.2018.08.23.10.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:20:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "szeder.dev\@gmail.com" <szeder.dev@gmail.com>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "j6t\@kdbg.org" <j6t@kdbg.org>
Subject: Re: [PATCH v2] config: fix commit-graph related config docs
References: <20180822131547.56899-1-dstolee@microsoft.com>
        <20180823155107.16658-1-dstolee@microsoft.com>
Date:   Thu, 23 Aug 2018 10:20:06 -0700
In-Reply-To: <20180823155107.16658-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 23 Aug 2018 15:51:19 +0000")
Message-ID: <xmqq1sapj8zd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The core.commitGraph config setting was accidentally removed from
> the config documentation. In that same patch, the config setting
> that writes a commit-graph during garbage collection was incorrectly
> written to the doc as "gc.commitGraph" instead of "gc.writeCommitGraph".
>
> Reported-by: Szeder Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config.txt | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Thanks; that's an appropriate update before the release to tie the
final loose ends.  Will apply.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1c42364988..6ee1890984 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -917,12 +917,10 @@ core.notesRef::
>  This setting defaults to "refs/notes/commits", and it can be overridden by
>  the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>  
> -gc.commitGraph::
> -	If true, then gc will rewrite the commit-graph file when
> -	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
> -	'--auto' the commit-graph will be updated if housekeeping is
> -	required. Default is false. See linkgit:git-commit-graph[1]
> -	for details.
> +core.commitGraph::
> +	If true, then git will read the commit-graph file (if it exists)
> +	to parse the graph structure of commits. Defaults to false. See
> +	linkgit:git-commit-graph[1] for more information.
>  
>  core.useReplaceRefs::
>  	If set to `false`, behave as if the `--no-replace-objects`
> @@ -1763,6 +1761,13 @@ this configuration variable is ignored, all packs except the base pack
>  will be repacked. After this the number of packs should go below
>  gc.autoPackLimit and gc.bigPackThreshold should be respected again.
>  
> +gc.writeCommitGraph::
> +	If true, then gc will rewrite the commit-graph file when
> +	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
> +	'--auto' the commit-graph will be updated if housekeeping is
> +	required. Default is false. See linkgit:git-commit-graph[1]
> +	for details.
> +
>  gc.logExpiry::
>  	If the file gc.log exists, then `git gc --auto` won't run
>  	unless that file is more than 'gc.logExpiry' old.  Default is
