Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53D71F597
	for <e@80x24.org>; Tue, 31 Jul 2018 23:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbeHABM1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 21:12:27 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:51085 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732680AbeHABM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 21:12:27 -0400
Received: by mail-yw0-f201.google.com with SMTP id 135-v6so10355516ywr.17
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z3Piw/T29IyhvEtE3Yib2AKYQkgr8xafDAs9bnI6M/E=;
        b=i/JIpyZV3R5KNkczoHyZZBcbRmFFs68vUj8vzKnEbdzjE5h+rQerwF6Lc+ZL4HUyVo
         rUKEqOhHA6RsEuLFLt91DPHaqaeoqn3VG//ZBtTuCdbQXL8LPpwpC44UmiIMxacX1XRi
         6lhWxsRxXaPBsV9s6YeMWNhyTCXC+Rj1ehSorFIZ1gVZ0OsS8b30Om5B/aJnScF5WMSw
         niToFnJ/LFlHI2H/E9H5cZjEJBIom/7rogpoMLFL3o8CLDu0eJ6ZkM+c05s1qJG7pdbc
         BuqfT99E8FZafdzkHsEIXqeXvpXDH8ZxfpmY1QRNHLHSjAJcZCa2zI/pQ8BDmEwlEU+k
         PJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z3Piw/T29IyhvEtE3Yib2AKYQkgr8xafDAs9bnI6M/E=;
        b=gj4zx5E12sWz3TDY6VBpWBPXjM28HsNAEI4P3DBgOZmKfB1WaD1xH9wYlxbuc/1b8D
         8xHaYwSDUg3Vc3bKmAUEyy/0tCluECVgERFN2ccGwGhOFz8rWqx9tEJps2J2BppcDK5+
         ++q8DKrH1ZfuoTkKPa/aRxWQXa/bj5rU/ajRYf2Spm35AdQQJAfLT2hh3QD7ljs3wlYu
         j3Rd0KFya3A0kRd2xlIw2KGCstGqq8s7zXLam4n24frwakcPT43006MfiMgoqBdE1srz
         J6ehaMUcCp9AmaQKFPoaZUqDr0YQlFOvvkwW4BQDDQe/+gHu2f/ggFS7aDzKklfkSE7L
         zA5g==
X-Gm-Message-State: AOUpUlEYrNowAqQYFs2rwZhAjSp68Gvy0erTdQzoGXnNRN8K1MNYpBxJ
        xFXEyTMG/PKkHqhWEbFKrJeNb8mJlCikkMHGONzt
X-Google-Smtp-Source: AAOMgpdn1XcIcm/KzY2P0PHsXXmie0PJtn8bWvpbr7PTOTYy5/1uD0rhstcp3Ymfa+oNYRX7aUaTKS/g0/Ew9FPsHpiY
X-Received: by 2002:a81:a8f:: with SMTP id 137-v6mr6905671ywk.41.1533079786571;
 Tue, 31 Jul 2018 16:29:46 -0700 (PDT)
Date:   Tue, 31 Jul 2018 16:29:43 -0700
In-Reply-To: <xmqqa7q79jcf.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180731232943.186226-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqa7q79jcf.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3.dirty
Subject: Re: [PATCH] transport: report refs only if transport does
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What leaves me even more confused is that the entire log message
> does not make it clear what the end-user observable problem the
> patch is trying to solve.
> 
> Is this "we sometimes follow and sometimes fail to follow refs while
> fetching"?  Does it affect all protocol versions and transports, or
> only just selected few (and if so which ones)?

Normally I would respond by creating a new patch with the answer in its
commit message, but I'm now not sure about whether it's better to revert
back to the non-"fetched_refs" API entirely (as I explained in the reply
to Peff I just sent [1]), so I'll answer your questions here for now:

 - Yes. We fail to follow when we fetch at least one ref that is
   up-to-date and one ref that is not, and when we're using the "fetch"
   command in a remote helper (for example, HTTP protocol v0).
 - I haven't checked exhaustively, but as far as I know, affects HTTP
   protocol v0, and does not affect anything using connect or
   stateless-connect (e.g. HTTP protocol v2, ssh).

When I create a new patch, I'll also include these answers in its commit
message.

[1] https://public-inbox.org/git/20180731232343.184463-1-jonathantanmy@google.com/
