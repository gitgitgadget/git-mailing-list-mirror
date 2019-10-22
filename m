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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCA51F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 20:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfJVU7s (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 16:59:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38602 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbfJVU7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 16:59:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so8919426plq.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZRD6Ju2Bo+/eReBN7/va7i25bx/cW7ZrpHotWOhfp1g=;
        b=PWSU3D5e/Y7jjEmOltUKH9xsCw6b/+AWF8pKzU0YjBFEOI4+CzlFg3HPSnDDycY9sh
         CG5WIo09/Dm2kODNxGpekdVhyPCeHGvuuv5HGrKtXPa3eLCLsHGQv2vIh/XsqFWc3vwj
         maGqMPY1Q7o/E8JenWdUP+Z+UI8Ws6ilh6zKtmpS/iCxTJPgaAq7shAiMk686knippEe
         LilSwhFigJQ8p88arJDtHI4pG9jBA9BNCf75oLoSl0wWpoHAj6vDmT27pAT+Hf/UbK1o
         Xmmfp7s/jXd2zqC+sMt3DrkM67oKydyHUfs9vRmBZEDSvqpASz+wKZp/nms7SdMyFG7i
         oKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZRD6Ju2Bo+/eReBN7/va7i25bx/cW7ZrpHotWOhfp1g=;
        b=Lj0S84BF0y3md6o64NpW+lbCW5Vgy96uwYasL+qN0g3t5nFgRqWtVOp9rjkBKfyShd
         bIynFD4lvPYPgUbZReROQC+KJR2QmTOodLmZt5MH6Mrs7l6PemKmiQPnIBSqMwYw26w6
         GKRsV8GTM3gsbvld/AsBPM0WM/c6heFSbUfVZStFBQ4SNGWIqyOacageMVrJrplDba76
         FLBkbGKKA0fyLaflTR7RceMBAfbDH804tM9Fk1ao9eDRiyY+rwTkVatplr1aKEtIqh3H
         HmhU3Q2qOvAHqFoK+sE+iJZ/rH9b35bRHgb8SfaZ9EMgtFmpy8/nuqVuZBDygzM3HmcR
         Iscg==
X-Gm-Message-State: APjAAAWwqbptDZBIFoNvj08mCHtM7Tflyurg3sM/KCSUGD2bPCAAFbAX
        SQIp8Rjvlc+mHdCMEvaNamVsdw==
X-Google-Smtp-Source: APXvYqynwnYZG2lweXUgfvVPiiD/h0dgLDVXOhbY4kDpNJQPPlGChAv6xhH/HbkeLCONst3Ont8eZw==
X-Received: by 2002:a17:902:7084:: with SMTP id z4mr5603433plk.15.1571777986369;
        Tue, 22 Oct 2019 13:59:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e127sm23588776pfe.37.2019.10.22.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:59:45 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:59:41 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] config: move documentation to config.h
Message-ID: <20191022205941.GD9323@google.com>
References: <pull.405.git.1571357219.gitgitgadget@gmail.com>
 <pull.405.v2.git.1571727906.gitgitgadget@gmail.com>
 <1a9aa33b4649e2b723a6107520c2b5ad70774714.1571727906.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a9aa33b4649e2b723a6107520c2b5ad70774714.1571727906.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 07:05:06AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Move the documentation from Documentation/technical/api-config.txt into
> config.h

This is still a little thin for what we usually want from commit
messages. Try to imagine that five years from now, you find this commit
by running `git blame` on config.h and then examining the commit which
introduced all these comments with `git show <commit-id>` - what would
you want to know?

Typically we want to know "why" the change was made, because the diff
shows "what". We can see from the diff that you're moving comments from
A to B, but if you explain why you did so (not "because my Outreachy
mentor told me to" ;) but "because it is useful to see usage information
next to code" or "this is best practice as described by blah blah") - I
wouldn't be able to know that reasoning just from looking at your diff.


> diff --git a/config.h b/config.h
> index f0ed464004..02f78ffc2b 100644
> --- a/config.h
> +++ b/config.h
> @@ -4,6 +4,23 @@
>  #include "hashmap.h"
>  #include "string-list.h"
>  
> +
> +/**
> + * The config API gives callers a way to access Git configuration files
> + * (and files which have the same syntax). See linkgit:git-config[1] for a

Ah, here's another place where the Asciidoc link isn't going to do
anything anymore.

Otherwise I didn't still see anything jumping out. When the commit
message is cleaned up I'm ready to add my Reviewed-by line.

 - Emily
