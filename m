Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BFEC1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 12:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfJ3Mj3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 08:39:29 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:47059 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJ3Mj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 08:39:29 -0400
Received: by mail-qt1-f175.google.com with SMTP id u22so2907480qtq.13
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NoQuliGaJ6e7Bhw98JZExevv/6zxVBNDIHlyIgx7ZXs=;
        b=OMTvccYM7HHaGZqI0C80Pj0CfDinrUyHiOJl8ggu28WcYIAeuNFom3C7MxpvSOt+UA
         rkkywKvQGaGj4Xhr3WXCVmZlPEJRrlE8PooLXHNzdOaAgld73QrPRI+k96MQcaTYswHL
         HlKNXw6w+CImVLuanrB8tQm5wqLjJV3YpO2lYSOgoeSLK0Sbq0WPG6QKf4+hdOQRe/tP
         ed/X7vPrUVwwdkNMivZDTdf1fgr4QJBJk+m2XFruc+Sqd/nh7Qf9BkHFYHRzGSJdriLt
         k59Y9ZgjtYSCYP5HAxdXB5fwM8rC4JbhSJN7Upejzz1oyZELQnAFz02GTJsZ8EwsNiOh
         dCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NoQuliGaJ6e7Bhw98JZExevv/6zxVBNDIHlyIgx7ZXs=;
        b=KEgF3uTZpM+tYl/lP50soBUCGTq2ITpJUdI/tPQagXhaioR2/tzwuia4hDvCWeQ+Wg
         PXYSdQx/J4DWQ2ANgkMFIjyJefENg34JOIcOHHPG9DTEqwlOA1K01Hno/U915JXTun8w
         XSTNSDWQ0WZaE58BIF6K5pksEuYFow+dtOlIj9zK6+n2JekAFNDdQEqqNQfb/EU4nlaq
         N6FPyok2FV9N8MNM3ep0fSFYXijTNlBx4wLo3SjSsBS8a9f9WS16NOkHml9whrwlA4MJ
         sPrRwVcPl5tz9xXjr33U0wdeBsqJOwd49fW1cBTzs3tjWg0H6FDO6aGyL7Ox4AKPZ/R2
         nhSg==
X-Gm-Message-State: APjAAAW9YkwTx3KbPJ+7QffhKzEp/AlZhxDd6mh4vtZ3qWP+EQp9/vz9
        M24BlXwtbpnUCy8fe9hpxkFdeUHZVfc=
X-Google-Smtp-Source: APXvYqw9Ax0SY+n3nNN039WdimptW1NnJkKryDCPldlmyol0QJrdbWmm6MQHB9N29k3r225fHnZmYA==
X-Received: by 2002:a0c:9083:: with SMTP id p3mr26775748qvp.210.1572439167424;
        Wed, 30 Oct 2019 05:39:27 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1c91:585f:86b4:347e? ([2001:4898:a800:1010:cdc6:585f:86b4:347e])
        by smtp.gmail.com with ESMTPSA id z72sm1179639qka.115.2019.10.30.05.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 05:39:26 -0700 (PDT)
Subject: ds/commit-graph-on-fetch (was Re: What's cooking in git.git (Oct
 2019, #07; Wed, 30))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0ee3du9.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <afec0f94-466a-2901-4dd7-528d0ae587fa@gmail.com>
Date:   Wed, 30 Oct 2019 08:39:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0ee3du9.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30/2019 3:13 AM, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> There is the v2.24.0-rc2 tag now; the contents of the release
> candidate hasn't changed much since the -rc1; hopefully we can see
> the final thing real soon now.

[snip]

> * ds/commit-graph-on-fetch (2019-10-25) 2 commits
>   (merged to 'next' on 2019-10-30 at 3ca711f743)
>  + commit-graph: fix writing first commit-graph during fetch
>  + t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
> 
>  "git commit-grph write" hit BUG() in corner cases.

s/grph/graph/

>  Will cook in 'next'.

I had thought this bugfix was worthy of making the release, as it
may affect more users than I realized (anyone with a submodule, fetching
after first clone).

I understand if it is held back because it only affects a new feature
that is opt-in for this release (the fetch.writeCommitGraph setting).
Just wanted to check on the decision here.

Thanks,
-Stolee
