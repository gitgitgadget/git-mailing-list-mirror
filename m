Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05E01F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfAJSCS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:02:18 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42459 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfAJSCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:02:17 -0500
Received: by mail-ed1-f50.google.com with SMTP id y20so10930952edw.9
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwLyzD73HPTlQP13uxQr8Hw/FAo0JZKmZto0Kqec1Ys=;
        b=sKskMmXdHbbhEXT7Op9PMozUkCooafev52IgMEKJky5RlIgRe0GnsDJnclwtSqN9xP
         DkACFMCuiV6tvty5isoywRXMCT8s9+9ETOWbb15M5I3axDiSHlV6u/GM4fObVSq6BOAO
         WbMhFeQkeztNlO6AGsK+TzpnRN0ZIIpg+LIQ9gwJOCVXX7hLdk7E8eR1ACugk/q4dRmb
         CRIe/xwummbLzdtN9fWnegZ+yAkUNqeOt8q+2Wg0kUtzvS1qPuW35cmi6uhJUnNyAKSb
         xtlHJdlQ/P4HuXwJqDYr/iLDJEWhIAcVkBsWhalXQAjqN1+6asPBkRzfWnJL8ENNYgvH
         Y4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwLyzD73HPTlQP13uxQr8Hw/FAo0JZKmZto0Kqec1Ys=;
        b=ftBaBXjc1RT9N0mBJ1KziNTyUBi77EzAFb5t4Y1URNpdfRt4qYxNDyAUljzufEMvni
         0jxXQcTUoqB+LCaeUccJnfOYC6S6KmxsNrgTULceJ5VPEnSvd9o7T7xAuacDXLI5HAJM
         LAyG3HTAbAW3OmnXiVVoHJOpvhJKZCfAS987IurECuIb2Q0VKaXrQzwpoQfW6PL2fJAg
         qiAdrzBbE+mtc97q7ZJpG+cg/+DJqE+yOGOvIrKi70yo/KdE8stpdiXXjD/yAO0g0vBZ
         l/pIJEdyMeWZsC4AkYXbijfAcI3fiN1CNdSh/HbqNkfY3T/c4UW7CWYCLQveUGHCBqSr
         rv+A==
X-Gm-Message-State: AJcUukdpbugNFkZTTsze12ANAQWIxssLdJAS4WWpR56ByBqHfX1IOrrz
        5k9XCFKWkiBPz5UbDFlFYsxQmAu/DTPWUB2ygQBV6OGuWDJIdQ==
X-Google-Smtp-Source: ALg8bN4yE5W4yjax0+DevsMbJE3+QIMGcrxoGZWneIjwfTMErIKlXEyGzopkwbCS10VPmWQQeKPo0P8adA4p+F8jj64=
X-Received: by 2002:a50:8343:: with SMTP id 61mr10618810edh.154.1547143335648;
 Thu, 10 Jan 2019 10:02:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Jan 2019 10:02:04 -0800
Message-ID: <CAGZ79kYJ0ZoyZrzr6+xgLjpOSbzHXXv2J4QpmHwzaU=gXbb-zw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/submodule-recursive-fetch-gets-the-tip (2018-12-09) 9 commits
>  - fetch: ensure submodule objects fetched
>  - submodule.c: fetch in submodules git directory instead of in worktree
>  - submodule: migrate get_next_submodule to use repository structs
>  - repository: repo_submodule_init to take a submodule struct
>  - submodule: store OIDs in changed_submodule_names
>  - submodule.c: tighten scope of changed_submodule_names struct
>  - submodule.c: sort changed_submodule_names before searching it
>  - submodule.c: fix indentation
>  - sha1-array: provide oid_array_filter
>
>  "git fetch --recurse-submodules" may not fetch the necessary commit
>  that is bound to the superproject, which is getting corrected.
>
>  Ready?

I checked the last discussion at
https://public-inbox.org/git/20181129002756.167615-1-sbeller@google.com/
and I think it is ready as I did not see any outstanding issues.

Thanks,
Stefan
