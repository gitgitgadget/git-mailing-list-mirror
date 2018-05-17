Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78341F406
	for <e@80x24.org>; Thu, 17 May 2018 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEQNWW (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 09:22:22 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:40029 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEQNWV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 09:22:21 -0400
Received: by mail-qk0-f170.google.com with SMTP id s83-v6so3551056qke.7
        for <git@vger.kernel.org>; Thu, 17 May 2018 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=kHQcnRiyVoaXh55aBitMlr7wCp57KtkCE9EPWx4dXgU=;
        b=tS3gowvzCcIAfPsT1dEyqatlvKDNTte/i2RU0ZIKEV5Zqr5/f0QWxUxWv27u5Mpyrn
         /uBkjg34cR3YoIY/PkrLiMcPpkyLJL2wYlTG7xNSxiAtJ/uKESVY5wLjFneA402zVl3s
         1B9Lfj6vCuouW/bSNof5ANqBpXqvPQdv/AdqN1mCP89yNddw8FtZDUFP0n7QBBC4Bv0c
         Xis/a4xPNFRNq0enC0kHAXBmQ+TEnXFLDGLQZXC33mjU4Q2HrDkksN8xo3SAGgfQfHxh
         tNMCPEIGt1B0FEcxoSDyd5DOVIjETraA+1voZtO+w2B62y7ILNRjxjn+su6JkmWgmB/n
         h2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kHQcnRiyVoaXh55aBitMlr7wCp57KtkCE9EPWx4dXgU=;
        b=dqWpdHmr4NucC2ACDzmNoWX25eimwE6I9YpT0cFSXZLfwAa2Ks+U3Rqjd8/J3vi2Qj
         /r1azSnKTh9OX6KJCkv9CBY0LoFVo2ab66aJq6qLYQTwHwayZybl2Q2GESgftYFTtMLf
         jlh3+a3cBvsXCQRU2NUVRRpvPDbQb3zfWsdN5E5k2j1mtbMDLbFQbr9t3VQAL2Fy15cK
         P5RpZtLYc1u2Q8+5LH+Wydv6aFFRwZJWcCwTg4R5p4jCmT7b38JDdQ0qqFsmWyKS1OEy
         SwQXpHYvWZ2VLFIiFEBvZ1JUIw38/dJ4GEgLDp3C9tyrPWst96n48tXRH727uz3cBB1S
         SmAA==
X-Gm-Message-State: ALKqPwd8XR7VSBuNzCbcKO7ff7Mf4mu2zp5+SL6a/Wv69lRHo6d2ribq
        jk5eQNuPIGdZ5635MvvwMnXGEH59
X-Google-Smtp-Source: AB8JxZpx9it0AlYkUS3Y+MoWsTB3zHOl8zs6gq/UxhLQvMKgBh7VARXsDshf6PkFYJS4vxMgO4WXOg==
X-Received: by 2002:a37:4383:: with SMTP id q125-v6mr4579609qka.191.1526563340057;
        Thu, 17 May 2018 06:22:20 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id a83-v6sm3596304qkb.22.2018.05.17.06.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 May 2018 06:22:19 -0700 (PDT)
Subject: Re: What's cooking in git.git (May 2018, #02; Thu, 17)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <759723ec-3f48-bdf6-2edd-6f69d1e7d12c@gmail.com>
Date:   Thu, 17 May 2018 09:22:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2018 2:01 AM, Junio C Hamano wrote:
> * ds/generation-numbers (2018-05-02) 11 commits
>   - commit-graph.txt: update design document
>   - merge: check config before loading commits
>   - commit: use generation number in remove_redundant()
>   - commit: add short-circuit to paint_down_to_common()
>   - commit: use generation numbers for in_merge_bases()
>   - ref-filter: use generation number for --contains
>   - commit-graph: always load commit-graph information
>   - commit: use generations in paint_down_to_common()
>   - commit-graph: compute generation numbers
>   - commit: add generation number to struct commmit
>   - ref-filter: fix outdated comment on in_commit_list
>   (this branch is used by ds/commit-graph-lockfile-fix; uses ds/lazy-load-trees.)
>
>   A recently added "commit-graph" datafile has learned to store
>   pre-computed generation numbers to speed up the decisions to stop
>   history traversal.
>
>   Is this ready for 'next' with ds/commit-graph-lockfile-fix?
>   A commit with triple 'm' needs its title amended, though.

With the lockfile fix, it should be ready. I've been giving this 
significant testing on my machine and a few other developers here. The 
next version of GVFS is shipping with this code and with GVFS 
controlling the maintenance of the commit-graph file. That code has been 
cooking with our CI builds for a while, with full functional tests 
against the Windows repository. The only bugs we've found are the fix in 
"merge: check config before loading commits" and in 
ds/commit-graph-lockfile-fix.

Sorry for the triple-m.

Thanks,
-Stolee
