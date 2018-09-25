Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71F9D1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 20:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeIZCXU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 22:23:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33065 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIZCXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 22:23:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so11992103pfn.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77PlfHxG/4WhV7B0pAcA1khiMvPHlcwvUrYg+o3sCRI=;
        b=BrZHvKEIocy7AASerMISBNele9PVoyTrLjjfYLND/KKY7ilF7C5vLJtplxYOXImIMb
         +aG1kAMLuWYKjy1BHFLL2CPXK4/ZVBRflskF7hhVc51oS5/TelzKJfCpYZQVucOGnjqd
         VCFwNXVa2SboFoIQQmzLoGVAZ1ki/t0Lk/cvLYJfFFkUgo2rUwR7Gp2Lk64+i4UhOvZ2
         pGHPs0M5DBrCBs2zOkNluf8hg7s3q2JkkgvQ6ZseQGfSdqG0ox0HYCJrzZMJXeP03mel
         CbvGX5ISYxI9wGGtW945M6m3vDd2NltWdMlfoxnorF3SRhUcMbY/NQVhLqrM6Ohuzgc0
         /TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77PlfHxG/4WhV7B0pAcA1khiMvPHlcwvUrYg+o3sCRI=;
        b=Zi+9Gcj+gOdR+4hziIQ00EKi9ZMIW704gPRVUwWB/Yawv6zfCLn91QsvoACz27zcbP
         fYqk/8UL3n+G5qKzZ4PufMozPWxWErQ/XAK+6qEb22MTDxIPSdtPeHSMEJBxL/z6FWMv
         SWkdg6Dv6rNFBpQb5gMBloQkHbCIreK4VZscY7a1fzTDW5M60t6mfqtVvHqv7Kx8xj6j
         hQQY/WpvQxZkmC3TknifE37p2pB2WT8sJP1+BwDlrRUPL7rZkNJs97kNKEj4ymPTKyEM
         qM5tp+D3QEtOHyHZv9MqJLmTUbiMa+RHoIALNkz4ooAZfwzD5iYVvw2t6CVZmxA3ZpIC
         Sp3g==
X-Gm-Message-State: ABuFfogSVQFvRzDcFyDHDfWT2vIddhW1iix9fL1Ua87xqjVW3p+6YO+U
        JEeVm6AcG1M/kH+Gz5M5PcUZNA==
X-Google-Smtp-Source: ACcGV63gJh2BTHus3ewcIoSsVN+O1uhWDPoV921o9idb/sq57V21e4hW70u7uAq+OaZ79W9wIdTNjw==
X-Received: by 2002:a63:fc46:: with SMTP id r6-v6mr2458530pgk.345.1537906445290;
        Tue, 25 Sep 2018 13:14:05 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id f81-v6sm12333518pfh.46.2018.09.25.13.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:14:03 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 25 Sep 2018 13:14:01 -0700
To:     John Austin <john@astrangergravity.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        id@joeyh.name, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180925201401.GA4364@syl>
References: <874leokw3p.fsf@evledraar.gmail.com>
 <20180917164705.GA28056@kitenet.net>
 <8736u8kpgu.fsf@evledraar.gmail.com>
 <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
 <000501d45366$cf437060$6dca5120$@nexbridge.com>
 <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
 <20180924140122.GC68796@syl>
 <CA+AhR6cyNqPW7YvEdanv_vA=T2oLrUm2ZyMZjLLFtdx8B+dqYQ@mail.gmail.com>
 <20180924195840.GG68796@syl>
 <CA+AhR6dzOUeJ0MsAF1C9-aUUJ9v4i5uaPKzxHJAPy0ZUjYtyVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AhR6dzOUeJ0MsAF1C9-aUUJ9v4i5uaPKzxHJAPy0ZUjYtyVA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 09:05:56PM -0700, John Austin wrote:
> On Mon, Sep 24, 2018 at 12:58 PM Taylor Blau <me@ttaylorr.com> wrote:
> > I'm replying to this part of the email to note that this would cause Git
> > LFS to have to do some extra work, since running 'git lfs install'
> > already writes to .git/hooks/post-commit (ironically, to detect and
> > unlock locks that we should have released).
>
> Right, that should have been another bullet point. The fact that there
> can only be one git hook is.. frustrating.

Sure, I think one approach to dealing with this is to teach Git how to
handle multiple hooks for the same phase of hook.

I don't know how likely this is in practice to be something that would
be acceptable, since it seems to involve much more work than either of
our tools learning about the other.

> Perhaps, if LFS has an option to bundle global-graph, LFS could merge
> the hooks when installing?

Right. I think that (in an ideal world) both tools would know about the
other, that way we can not have to worry about who installs what first.

> If you instead install global-graph after LFS, I think it should
> probably attempt something like:
>   -- first move the existing hook to a folder: post-commit.d/
>   -- install the global-graph hook to post-commit.d/
>   -- install a new hook at post-commit that simply calls all
> executables in post-commit.d/
>
> Not sure if this is something that's been discussed, since I know LFS
> has a similar issue with existing hooks, but might be sensible.

Yeah, I think that that would be fine, too.

Thanks,
Taylor
