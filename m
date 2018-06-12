Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6161F403
	for <e@80x24.org>; Tue, 12 Jun 2018 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeFLUgR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 16:36:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33652 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754263AbeFLUgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 16:36:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so384095wro.0
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ixIPQNhTaHcdM0I06aOfdFwWg/Sj100/B31kSgNmPeY=;
        b=ev4eATgMrR0S1JYsT11jF0CJFMqPqPCORKUlfrUzahyv4fZ5j+fEFjaYRNkQo/UWca
         1nMUWQT4n2r9ntC6ISq6YDSyn+8PiIBLMLV0QE+PxZpwFIG7StGn2GhoktcQFchS7CV/
         H0xpsEnnqgIe13rzgDYNKG4bIXA1e3jecJk0dtI4uzpDbwrDmV077BbtlWC/OOq38pyb
         E/GpzLHWZesm67QQ8b0aTzFEisfbxG0aSTnwq8aUVo6blztLhpnfNVLmuUZZMPZkPikD
         48NfhChYemK1hOGMvCBphq5bD8sVCzqaJQl/Uuw+ble9masTrFb1opiLAFWjiaRzd+7N
         l35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ixIPQNhTaHcdM0I06aOfdFwWg/Sj100/B31kSgNmPeY=;
        b=nRqOwT+vmGnnmpbyj/1EKKb6SUql+IsPNxNCu+0wp5aey0IUG0UkijO9YJjsvIP4CG
         Nc7ZZYXmAmDUuJkfzxtgbRDJW4P39vx+axrY3rerBYO6OE8BTG+9K46yF/wbma91pT9b
         6UdQg7qLy5xZxAWRE7ZaSNAP2Dz9t5cLCN1pzQDvA/12+7fVEo/NN35O8VKN6dyxPpEm
         LbaIIVReF2lFThDxhs4OGdHGx3WLJkgBBihBX9UcD3osxZfpTlnDrdb1gBKXj5Fq5vmq
         RvDAQ9jpGf3IiUOaKv9tU1NWnmdAkCwfKq1RG8fcxSi40ndcX6kcxPB3B+fBbs+f84Vh
         wcXQ==
X-Gm-Message-State: APt69E0pCYvdoTIVdcaDgRqi+nRqBOscUjTp8+CIdGDu1MvB+L1BLRbX
        zQQlpJYsYTVVooxQF7LmFvCQ3BHX
X-Google-Smtp-Source: ADUXVKKwMYBgtrLAvmAlNbkc3U5OISE0dWwVq5utL1h1DibG8fQKliKeDkwUSjECPiI5RJUfjsN3NA==
X-Received: by 2002:adf:8f23:: with SMTP id p32-v6mr1735241wrb.193.1528835775497;
        Tue, 12 Jun 2018 13:36:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v138-v6sm2041756wmd.47.2018.06.12.13.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:36:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steve Litt <slitt@troubleshooters.com>
Cc:     git@vger.kernel.org
Subject: Re: How to delete files and directories from git commit history?
References: <20180612154413.3df64441@mydesk.domain.cxm>
Date:   Tue, 12 Jun 2018 13:36:14 -0700
In-Reply-To: <20180612154413.3df64441@mydesk.domain.cxm> (Steve Litt's message
        of "Tue, 12 Jun 2018 15:44:13 -0400")
Message-ID: <xmqqk1r391z5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steve Litt <slitt@troubleshooters.com> writes:

> But then I view all filenames from that directory that have ever been
> in the project, as follows:
>
> git cat-file --buffer --batch-all-objects \
>  --batch-check='%(objecttype) %(objectname)' \
>  | grep ^c | cut -d " "  -f 2 \
>  | xargs -n 1 git ls-tree -r | sort | uniq \
>  | grep propdir
>
> The preceding command lists directory docs/propdir and all the files
> it's ever contained....

In which repository did you run this?  As cat-file's documentation
clearly states, --batch-all-objects does not *care* about the
reachability, so even after rewriting the history using
filter-branch, as long as you have the original objects before your
history rewrite in the repository, it _will_ see those trees with
propdir, even if they are now unreachable thanks to your
filter-branch.  If you are doing the above in the original (or in a
local clone), try running "git repack -a -d && git prune
--expire=now" after filter-branch.
