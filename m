Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78A120248
	for <e@80x24.org>; Thu, 18 Apr 2019 02:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfDRCIz (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 22:08:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52312 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRCIz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 22:08:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so849693wma.2
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8gkzPxR++UHm0+mpQ7YV3TeOf8i6PotBF5+D2XisT9w=;
        b=cn5KlymhqWz06Bnf3UsLxv4SbCyRVoLqjWgIHuFGFuEyLqALtfRYcio8c6CpMlvaQk
         BdkVIX0ll0kMMtZXzueuP5xgSDKwvraYlPKFWecZ9jMwUP+wpcHkxjxbWhu+rTQYS4S5
         aFVsootovLQe79j51owjxP2p9SzBMonh2we/69ucgCGTQ//mn8h3T5UfjVh++QJewDmu
         tXPkH6zzgaKfNTWQh6qyW8CE6ZtiOG1CXl5373e1TVmm+Fgvmez6iXE5cHZCpPpwnklY
         niDH98B+n7gcZhbuACZ7tRvdUzEMqLdEyGCTXb2ntTOQHIyTbBTaPZEeO3a2ZpLuDPKh
         K8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8gkzPxR++UHm0+mpQ7YV3TeOf8i6PotBF5+D2XisT9w=;
        b=MxOJ7qPnRliQu9cV6gf88sIxdvlV/QK2t2b7jFbj8qOlw/3ADxl9DHrK7NjwtkfjBW
         +B2OAXkBY3Oau1R2k684q8dnD+q5/b0MuAFCqOUhtacVhsdDFy79ap8Z45oB9NMYTdtx
         buNGQsY0i9O3jF9driPEfB8JFEFG1DUk0/6XkJVm8qoSejl4aEqxVA8ZNQmTAbjjLxby
         19cTHD3HpnWh3vomttZs961Vtj3dtJ9gwM4wghm0Q6RONCSBlXRPg649QfCF/G7t8XwV
         CrHmgn3xILW0axYzxrnNJVDF5U6eYT3S+kKah/hGoWNkW4uXptakjly6RL7plWDPMtNg
         R1Pg==
X-Gm-Message-State: APjAAAWjWVos4ELije+PXdccY3VnNXrzVwY5wylUj8mShzldWfP1/gd1
        wi78jG0CzwHuulkOYyiyZpE=
X-Google-Smtp-Source: APXvYqzpTVIhZueAgQwEdup4bLUscST+wdKnE9UWtdEIMpS+IneNVR4T1Ckns88VNqI+nAv+khBv9Q==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr987476wmh.127.1555553333028;
        Wed, 17 Apr 2019 19:08:53 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t76sm692085wmt.8.2019.04.17.19.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 19:08:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Giuseppe =?utf-8?Q?Crin=C3=B2?= <giuscri@gmail.com>,
        git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Subject: Re: Feature request: Allow to update commit ID in messages when rebasing
References: <CAGV3M54XhRMDXdhbfTon5nRV59VOjw8W4YrNP63TqPYm8pxd8Q@mail.gmail.com>
        <878sw8bbby.fsf@evledraar.gmail.com>
Date:   Thu, 18 Apr 2019 11:08:51 +0900
In-Reply-To: <878sw8bbby.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 17 Apr 2019 22:56:01 +0200")
Message-ID: <xmqqtvewgj4c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Apr 17 2019, Giuseppe Crinò wrote:
>
>> The feature I'm asking is to add an extra-step during rebasing,
>> checking whether there's a reference to a commit that's not going to
>> be included in history and asks the user whether the heuristics is
>> correct and if she wants to update those references.
>>
>> Scenario: it can happen for a commit message to contain the ID of an
>> ancestor commit. A typical example is a commit with the message
>> "revert 01a9fe8". If 01a9fe8 and the commit that reverts it are
>> involved in a rebase the message "revert 01a9fe8" is no longer valid
>> -- the old 01a9fe8 has now a different hash. This will most likely be
>> ignored by the person who's rebasing but will let the other people
>> reading history confused.
>
> This would be useful. Done properly we'd need some machinery/command to
> extract the commit id parts from the free-text of the commit
> message. That would be useful for other parts of git, e.g. as discussed
> here:
> https://public-inbox.org/git/xmqqvaxp9oyp.fsf@gitster.mtv.corp.google.com/

That's a helpful input.

But in general we do not have an infrastructure to systematically
keep track of "this commit was rewritten to produce that other
commit", so even if a mention of an old/superseded commit can be
identified reliably, there is no reliable source to rewrite it to
the name of the corresponding commit in the new world.

For that mapping, we'd need something like the "git change/evolve"
Stefan Xenos was working on, which hasn't materialized.

