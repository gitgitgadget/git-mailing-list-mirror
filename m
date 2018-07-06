Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364361F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbeGFTiw (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:38:52 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:33899 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934548AbeGFTiv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:38:51 -0400
Received: by mail-qt0-f201.google.com with SMTP id l23-v6so13525349qtp.1
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=MgY3rXF0NePyp1h7ufRY04lV9G0cRPbuk6QdagrNqJ0=;
        b=VAsG96I2WpyBKEwRGCFupQDD/Go41RmhIvl5CQyen8qRYCoaZ4jjfMbxiCuqLHCbgr
         DowT7BRmc2dgEQ6Tcql2I4JiV5p3BZ6Pl+osWihSHY8G7enRU+dwoOGrVvGQYMDITDMk
         bbbo6hEBsGqzOxidlfK+X1A2lS4BPkm/DxV9lJJOHeF5NELr6xkd8Jf6Oi6IoMuS0hzb
         Bt97FB7Re+5C0/9zXcczRYkDrr+3htZPtIwh7ZybJL0dRFRA1zEVIzWbiIodnAFV0JJV
         pG7vePP97iGN0wGz1Rw8mMfrrna4GmcJOVM727d2VXWq63beczDUKKl8dq/dNO32NghU
         XLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=MgY3rXF0NePyp1h7ufRY04lV9G0cRPbuk6QdagrNqJ0=;
        b=NBeNgeTerV85rJ2kY3qtZpAa1cQjIaeb7qau1lmx9aWodLPHWF0jPpHVzQy6K1FCGX
         8LOOrmEQaPn3PLBxOnt/Rt2172U3mEDcLzYADWDSgI3AUz3ftGRHTo7lDBWvIejgcRIs
         yN1GUsHm+dk3ZwhmoyacXaASc76F1OcxZ/av1c8w1jdP13kFWCIhAJiXIglJFic8vfsI
         +u7DNZIFyoH8VPOTgX+XbiT5VCEldy3zjdo/eT2MfEt1Cj4f6BX1X9zbVbtayJmp/QP2
         t0wGOy46qLNb7QLaDZDh181J4WBibE71KcvwqrsgmPjE0sX3irB8O5dg64sjbhbFuICE
         ldJg==
X-Gm-Message-State: APt69E0LBSBrNdOSnYRXhrlaiz/mW+5EIjZ/UqHRzGf+dRb07hPmhwtM
        Gu7pnp4VtXrruwbNP8yhKn8dKGywNJzrqSzqx4OV
X-Google-Smtp-Source: AAOMgpfWLwMQ62726qPVuinkQLvHosedWBjMoqB4rWc7jnrP9LPWdbgD6vxcLQkh7fmvafpfpVnEtor8GghlXXUpv512
MIME-Version: 1.0
X-Received: by 2002:a0c:fad2:: with SMTP id p18-v6mr6621942qvo.50.1530905930751;
 Fri, 06 Jul 2018 12:38:50 -0700 (PDT)
Date:   Fri,  6 Jul 2018 12:38:47 -0700
In-Reply-To: <cover.1530905323.git.jonathantanmy@google.com>
Message-Id: <20180706193847.160161-1-jonathantanmy@google.com>
References: <cover.1530905323.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> When cloning a repository with a tagged blob (like the Git repository)
> with --filter=blob:none, the following message appears:
> 
>         error: missing object referenced by 'refs/tags/junio-gpg-pub'
> 
> and the resulting repository also fails fsck.
> 
> Patch 1 fixes the protocol documentation and the server side of Git, and
> patch 2 makes clone error out when such a situation occurs.
> 
> An argument could be made that we should not merge patch 2 just yet due
> to the fact that some server implementations (such as Git and JGit)
> still exhibit the old behavior, and the resulting clones (albeit failing
> fsck) are still usable, because when attempting to load the blob, Git
> will automatically fetch it. I'm on the fence about this, and have
> included patch 2 in this patch set nevertheless for completeness.
> 
> Jonathan Tan (2):
>   upload-pack: send refs' objects despite "filter"
>   clone: check connectivity even if clone is partial

Forgot to mention: this patch set is based on bw/ref-in-want because I
needed its one-time-sed functionality.
