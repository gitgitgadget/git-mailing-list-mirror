Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C976202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965259AbdIYW0M (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:26:12 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:56547 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936149AbdIYWZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:25:59 -0400
Received: by mail-pg0-f43.google.com with SMTP id 7so4802156pgd.13
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zhwtIu01qqzV0fAxF91/MeGDojKawgq2f63M7PAKEok=;
        b=szBNqrsq0idirlOHgaooDnrb73MT5gRwxUujvNNqzmj6CaDvOQWQfrzXR1AVuia7nQ
         MLg5lgNwX9uBqLkyYFTW3F8LCKW5ExJ/8N+IW0ViXuzoVF1/r+HQ633JXIu6FBdkKCaE
         wqjT/l1HLXCL0/rlDwd/j9zPY8DsgLdkYSOo32FU/yybCtJZfyjdgsNrT5nsKiny1ZnM
         BMpL+1QO6TnCXpyLJjb2yhVqApPUwYlW6GkXOAm46JRGs89oJxWOvGhs8KyTPja1Ri6y
         VPwcYIQJydZCD58Tod11np9s5KHkvq0GG41z3KS0jaeNZOh8QvW93uEO34CJvNydb8KY
         oqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhwtIu01qqzV0fAxF91/MeGDojKawgq2f63M7PAKEok=;
        b=Yr2+eDWpXH/5J5SYT0sAXOmMLaYFi2B0K8D8aH+B1NC4MNPfv5A/wIcNRArcLHrcRL
         R7ebPG2RJNsNcdlCChXKQ1hFWStcapmcaPVxOU/cLbEasXF4qrg4vebnMHla8nnW9RLY
         9/O0SOy1qjF3u6xJ+XbOxNmox+rfBUSFk1mxKaqidwiV/KV4j9ya3aWkDAj67qtZPuCJ
         TYZReHAvWM68IXG+AZO2d07PPAmokcQqcjoV/Nzp1AJBJ9Ius/tqXbbCUhn2O/k91jyF
         2Q9swafIT2obRIg4xu0xlYdg9kGk4B/UaYjbRtDo0Y/y6C9XrZL6mUyeoyLofXywcfPm
         5IGw==
X-Gm-Message-State: AHPjjUj9xiFAeR71LdpPmDUXFTEz4u8F7IGQ46Z8V1Ps8KfSnKDn6FtJ
        6Rg7VHwFNtiICvr+o+fsMqM=
X-Google-Smtp-Source: AOwi7QDuUdYHVMNvB3aEeRWxKgqjJ59Eyxd2PIVw2FlB35GA++C+615HWi6KD/Q3Grszf1Nb4BYUgg==
X-Received: by 10.98.23.75 with SMTP id 72mr8985155pfx.68.1506378358503;
        Mon, 25 Sep 2017 15:25:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id n18sm12306594pgd.69.2017.09.25.15.25.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:25:58 -0700 (PDT)
Date:   Mon, 25 Sep 2017 15:25:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Roy Wellington <deathanatos@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git ls-tree -d doesn't work if the specified path is the
 repository root?
Message-ID: <20170925222556.GH27425@aiede.mtv.corp.google.com>
References: <CAF5E6=pqGZt_BUDRDeN2uAQK7qBTeO+zcR8NsvSPg-rLjbsqdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF5E6=pqGZt_BUDRDeN2uAQK7qBTeO+zcR8NsvSPg-rLjbsqdQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Roy Wellington wrote:

> When I run `git ls-tree -d HEAD -- subdir` from the root of my
> repository, where `subdir` is a subdirectory in that root, I get the
> treehash of that subdirectory. This is what I expect.
>
> However, if I merely replace `subdir` with `.` (the root of the
> repository), (i.e., `git ls-tree -d HEAD -- .`) git ls-tree returns
> the treehashes of the /children/ of the root, instead of the root
> itself, contrary to the documented behavior of -d.

Can you be more specific?  What documentation led you to this
expectation?

I don't have a strong opinion about this behavior, but in any case if
the documentation and command disagree about the correct behavior then
one of them needs to be fixed. :)

> Is there some reason for this? This behavior seems like a bug to me:
> it means that prior to calling ls-tree I need to check if the
> referenced path happens to be the root, and if so, find some other
> means (rev-parse?) of converting it to a treehash.

Does

	git rev-parse HEAD:subdir

work better for what you're trying to accomplish?  To get the root of
the repository, you can use

	git rev-parse HEAD:

Thanks and hope that helps,
Jonathan
