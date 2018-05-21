Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD2F1F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbeEURxi (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:53:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45778 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbeEURxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:53:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id bi12-v6so9211707plb.12
        for <git@vger.kernel.org>; Mon, 21 May 2018 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8AaHNoy1Gs68MRbqqSJik32L17mPf2grk8iAq9eOqHE=;
        b=CkR8e/T3c/Xp2O16ImPMXGCwdgkfPbffEFBRHBm5mspgBd2P6JbgtPFK+4CxwUeF1T
         S47kiV6PijgOlMquGtblc7V1jHufpbfq+fQMUoO13VX5Vq1PKKvNcbkbTULd4jme7+BK
         tDWuJkDvhFZ9IvbJ47Mux9VAGmcCZcA4qarUqSh9e16vMfAM/oIL8Xy8IFNN0TBGZRVq
         hwJNbtvsMW5ockqMLzz/lQN/OnETrebatuvyU4lXKLsWlxGjdmPFqKVMbUIg+spQS3yb
         ECJ7HT6x+eKbH6gUr9OL7YqTMgie5ad1ZSu9tLp4SJu0ijwqYWqmfZCor1ix7llB+kGA
         6HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AaHNoy1Gs68MRbqqSJik32L17mPf2grk8iAq9eOqHE=;
        b=tLfHoRa2bSfLB4vyJUZnSazijkMoqgQy6TpSVrm8G/cytUtz5gGQOEP+5XsFt/BMPT
         yZ5iUr4rDCN7V/T1SDpw5adlhoTH1Ln9AyM8V1LQEoCkoHig8MGzXoBQaZrv6NjZhTfo
         2lDd2uI6Za28bYv83xs9vkaEkBhikM973vpoBVH56j3xvwh0HrRV/TIKJEtJP8oWWsn6
         CXT7K+ZBo0d82aS6cHAC2E2zPz3GZh88KUr5BNagha2BdIVSHIZKH9LyIFb15rJmXCnJ
         ZfdIZrPiJHt7wU2ptxoF2wGwNjxRuuCDsLinEcFLM+udCCUxHaamygOVqkTcGT8+So/M
         6Uuw==
X-Gm-Message-State: ALKqPwfqcd7yzaHgJ6icTXIVkGcHzmG0cmUtazo1l6ZfK9dL23c6M182
        kFQ4tByCpZrQiAna+K4ENok=
X-Google-Smtp-Source: AB8JxZofynBa9EJMJpi23igsgrLo8jnNzaZr1VjTIT56hxKGgIoyTsI46vG+oNIigLT9sK9R9gK1vQ==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3-v6mr21472122pls.236.1526925217435;
        Mon, 21 May 2018 10:53:37 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g64-v6sm27765507pfd.50.2018.05.21.10.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 10:53:37 -0700 (PDT)
Date:   Mon, 21 May 2018 10:53:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
Message-ID: <20180521175335.GC10623@aiede.svl.corp.google.com>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
 <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
 <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert P. J. Day wrote:
> On Mon, 21 May 2018, Elijah Newren wrote:

>> Hi Robert,
>>
>> I had always assumed prior to your email that 'known to Git' meant
>> 'tracked' or 'recorded in the index'...
>
>   i *know* i've been in this discussion before, but i don't remember
> where, i *assume* it was on this list, and i recall someone (again,
> don't remember who) who opined that there are two categories of files
> that are "known to git":

My understanding was the same as Elijah's.

I would be in favor of a patch that replaces the phrase "known to Git"
in Git's documentation with something less confusing.

Thanks,
Jonathan
