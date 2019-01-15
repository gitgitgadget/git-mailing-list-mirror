Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5A9211B4
	for <e@80x24.org>; Tue, 15 Jan 2019 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfAOWIj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:08:39 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49059 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfAOWIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:08:39 -0500
Received: by mail-pl1-f201.google.com with SMTP id m13so2502652pls.15
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bDE1gCDSsMStY9EIjb75JWDjLEKVNLNA+aibJzHqpxM=;
        b=Mz7MgwH7QL9/nxg28vRyjChlYWnJ9am1uqmqBtViWuDtTH39ESCAuC8tM4CGI3dpNG
         ePVisGVA70jMU+sTDkXN0T+gfln4VM/qphTxGfhqtyborul9Fvv43WTLZuboi1uQfk0C
         1O4eg3KTv78goTjkXrvGkWFk/TWGG4CpJMxwTCsh04DmkKRePjiS76khRfldOnQYFBRU
         6J1QGJE7wTIM7Jo8UopmfoOXmzXMrD6AaWPYxVS7SOuGlJCm8CLXQP3nL3CIeGhZLUln
         24Cftj/yVANpRybG39sAr+IfRslkK203LoIpogZAxCHnPAFd8MkiRJagzFAB7lvIPVah
         uO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bDE1gCDSsMStY9EIjb75JWDjLEKVNLNA+aibJzHqpxM=;
        b=k/znGhYfYE/aBknZoV3lYbV7aIQcUMFXLfc7FC/8gfi7mMZorbOdSxg8h8xjuplXEZ
         RM1viqg8JSoCGAlvq2CXli/1YJ1uKmnKZpVVsK/NM337GGKtu1SZ/pjLkPjJWERXNynm
         U+ZChS3jzY77DSTCoyKmbbYtnQqDBZIzJp6o0GkCViGhhNhfJpFYK0Fh5GmWo8u0xtlH
         VJLGmeNfFCOh/ofbnmzcqGm/8/3QfQP7U2ZOA2VxTEEiwuVcJruv45kmLriyytVr+jQM
         i6ZR+ktEeGTUUp9peepKCeJxaCgUOW4DF+U4PVAe5vIs7sUXc++kgFdNHrpXmePE2gar
         IYwA==
X-Gm-Message-State: AJcUukcqQkcU7WxgjVJL2fV421BNtxMs0EM3FJAu4Sqr3T32m0qCD5ZK
        J8MImcmemVqEps1LvjbjW0Hdosh/X2sESdt878O0
X-Google-Smtp-Source: ALg8bN64f7BGz/Fx8hfrhwlKl6FoMdatSrHFC9A4T1mryKgc2TCNHNiv+Y2b3NP2wkYAAh6OzsTeQRHKCj8zUxMmLpAK
X-Received: by 2002:a62:80cc:: with SMTP id j195mr2270888pfd.134.1547590118916;
 Tue, 15 Jan 2019 14:08:38 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:08:35 -0800
In-Reply-To: <xmqqa7k1r5h9.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190115220835.61384-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqa7k1r5h9.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 0/4] Sideband the whole fetch v2 response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Like v1, this is on origin/ms/packet-err-check.
> 
> By the way, when merged to 'pu' as one of the earlier topic, t5409
> starts to fail under --stress.
> 
> 	$ git checkout 'origin/pu^{/^Merge branch .jt/fetch-v2-sideband}'
> 	$ make
> 	$ cd t && sh ./t5409-col*.sh --stress
> 
> This is not new to this round; v1 exhibited the same symptom.
> 
> Thanks.

Thanks for checking. I don't think this branch is the cause of this
issue, though. I ran the same stress test on both:

 - f3035d003e ("Merge branch 'sg/stress-test' into jch", 2019-01-14) and
 - the result of merging sg/stress-test into master,

and the test fails with the same result.
