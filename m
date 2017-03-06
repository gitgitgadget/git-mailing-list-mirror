Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D4B20133
	for <e@80x24.org>; Mon,  6 Mar 2017 19:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbdCFTZg (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 14:25:36 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36373 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbdCFTZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 14:25:32 -0500
Received: by mail-pf0-f176.google.com with SMTP id o126so16956298pfb.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 11:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=B3Yq4plyqZvnbd4+ApPw3ZkL1gcasmrsShu8udYuWGI=;
        b=eh6vmBLf7uES2P/Sq5S0XiyVvI19O63TrkVK37nzmvwq7sXRn6nBuVZyeuZ4Qcni3j
         ODsZx431ycam21jjc6O16dFrbDP/CKrqblKOEaWr1P6QYZV3mGTGmFqvDaOIDOaLTs5s
         HnVzOV9dcaTyeEIo2MwdKZI178Pbb1m8Z7dWoulrC/3psdJOR/aMaInTQAtH6RMHMVNA
         4PkJLLsdPjXDl0HUFe8KsFAHSh03HSTyKszUH6GykXzgPoDzoDkMKof2Ai1JSMpuB+HK
         vdX1FVRLb4H1U6rnE7qnB/J3wUtI6iC3aa+2xSX0Zy8Umzcm7NcN703NbZqprd6XzTUt
         ykTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=B3Yq4plyqZvnbd4+ApPw3ZkL1gcasmrsShu8udYuWGI=;
        b=E0hF1W4BvyGGoQeDGZ7YXhEeLFQXKakY4DUNqkmTvOuoKu74nIAgTOSHNSQ/1Orfpo
         ocrVQp3VaJ9Qr4swgw1Eml0kPY6vS84LkJWCIlwEMC/Q13YpiFoPsIN/mUwLoa5Q/b/e
         bkErjfEX/VVs6OgSrY08zTuq9K7qXd/PCni4nRi/uEgHmrPy8hNyZ+w56u0m//b7vYFk
         rhECTVKxNkeoxr8ldEcn2m4tkfQz/0yPvs7ytfcKyghA75nJLqg+HctKi0qITcLMy58D
         zHs5o4y2V7g3jmnI3ZlxFaTC2IUw9tNdYfVoZDXDB3KrOWB7LzfTi6IegYQPXBjUQT+o
         S1MQ==
X-Gm-Message-State: AMke39leDAI0xWkhrtuQwWt8uXWqTP3vAoRyZnaEviBdPFvUhU3QKsl5FxIKyY6ah6b10Ib/
X-Received: by 10.84.172.1 with SMTP id m1mr28314489plb.5.1488827785212;
        Mon, 06 Mar 2017 11:16:25 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:1458:35b5:154a:3344])
        by smtp.gmail.com with ESMTPSA id 132sm24331051pgf.27.2017.03.06.11.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 11:16:24 -0800 (PST)
Subject: Re: [RFC 0/4] Shallow clones with on-demand fetch
To:     Mark Thomas <markbt@efaref.net>, git@vger.kernel.org
References: <20170304191901.9622-1-markbt@efaref.net>
Cc:     peartben@gmail.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <c8788f30-263b-c96a-239d-940743b96b53@google.com>
Date:   Mon, 6 Mar 2017 11:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170304191901.9622-1-markbt@efaref.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04/2017 11:18 AM, Mark Thomas wrote:
> I was inspired a bit by Microsoft's announcement of their Git VFS.  I
> saw that people have talked in the past about making git fetch objects
> from remotes as they are needed, and decided to give it a try.

For reference, one such conversation is [1]. (cc-ing Ben Peart also)

> The patch series adds a "--on-demand" option to git clone, which, when
> used in conjunction with the existing shallow clone operations, clones
> the full history of the repository's commits, but only the files that
> would be included in the shallow clone.
>
> When a file that is missing is required, git requests the file on-demand
> from the remote, via a new 'upload-file' service.

A reachability check (of the blob) might be a good idea. The current Git 
implementation already supports fetching a blob (perhaps a bug) but has 
problems with reachability calculations that I tried to fix in [2], but 
found some bugs that weren't easily fixable.

As I said in [2], I think that proper fetching of blobs on demand is a 
prerequisite to any sort of missing object tolerance (like your 
on-demand clones), so I haven't thought much about the topics in the 
rest of your patch set.

[1] <20170113155253.1644-1-benpeart@microsoft.com> (you can search for 
emails by Message ID in online archives like 
https://public-inbox.org/git if you don't already have them)
[2] <cover.1487984670.git.jonathantanmy@google.com>
