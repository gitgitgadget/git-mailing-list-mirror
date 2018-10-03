Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B8D1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 13:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeJCUZV (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 16:25:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46843 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUZV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 16:25:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so6154959wrr.13
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r/Kxy5TQzkqmqWXlhFYM87TfOrS6xBqpGfd5kRHQJUw=;
        b=gbQ+4E31iDX8KjBYZyYUMav+Wl7fQvWwRfLixyIpvx/LdUDXMX+KxddSZoTc1ebHY0
         XHP+KfS7k8TmLFM9wib2KXeCinni8t/+tTL8+WYpDL1WLmSNKidgXRhdY/Pm1gqTzs3M
         CTyWZSqoG57VoNM4xmqverfY5NrXgEXs+FWxY5OvRay2ek3C/Ago6wdZkw5cjFHp8zYF
         hbBWwUzaSpVfXsqXnI6UJ3FUPpQ2mmmL5wZdF1lMBGCu2j0OPKWB8h+CMFr9t9EHegGb
         5107SwgvwPrulIZTNIBnfYwYKYtzPCN9ByclxDuynpTuXwroyXsUcQy7S6Q5CNK9h3fK
         UvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r/Kxy5TQzkqmqWXlhFYM87TfOrS6xBqpGfd5kRHQJUw=;
        b=P0sMdU4jACUJHnyEsEZ15+fadAG8tvQl4+wCkFozwTdJC+cmRx1UUPhz4RnZNqSwi2
         6cU+HCy6K2AsqfCQaqyXFyPRXFmI1CaJE4WGlrn0xgFGPq76ZYH+rMQlGffccOotQKt+
         wI//rFEwBVuXRBJp9hX0ByfjYI/hYo5xaQ9EK89r+r9Eaf3iwq+W77y+sRbGbmh6E8dF
         JKbfC7MHfR9W8NJLLqseJYUjg41RvrZG1HGeljy2kTMpZbpx2yxQBtvANgmw9rAyOQW2
         NL1cVRKL1uyjdbSpAc1+/lnNAR5MHyQUizvgqwV30FWVk8OORMQtQGoONZ1IxPq9ZkJy
         dB9w==
X-Gm-Message-State: ABuFfojVLvTNzrvm8rs7MW1sIdBFCh5jexlEsz4mNnofvydotZIyKP+s
        oFUdtXO1CvTNyQ1O1yuXfTm84w8b
X-Google-Smtp-Source: ACcGV61MMXGr/G0qHPXnFu03cTv7bDGk7fHfJA39sOL0to3YpdHAZQ6O9xuxv8cN3C8RQqM6wSFcnQ==
X-Received: by 2002:a5d:6490:: with SMTP id r16-v6mr1241691wru.99.1538573813174;
        Wed, 03 Oct 2018 06:36:53 -0700 (PDT)
Received: from localhost (x4dbea401.dyn.telefonica.de. [77.190.164.1])
        by smtp.gmail.com with ESMTPSA id c2-v6sm1679472wrt.77.2018.10.03.06.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:36:52 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:36:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181003133650.GN23446@localhost>
References: <87tvm3go42.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvm3go42.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 03:23:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Don't have time to patch this now, but thought I'd send a note / RFC
> about this.
> 
> Now that we have the commit graph it's nice to be able to set
> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
> /etc/gitconfig to apply them to all repos.
> 
> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
> until whenever my first "gc" kicks in, which may be quite some time if
> I'm just using it passively.
> 
> So we should make "git gc --auto" be run on clone,

There is no garbage after 'git clone'...

> and change the
> need_to_gc() / cmd_gc() behavior so that we detect that the
> gc.writeCommitGraph=true setting is on, but we have no commit graph, and
> then just generate that without doing a full repack.

Or just teach 'git clone' to run 'git commit-graph write ...'

> As an aside such more granular "gc" would be nice for e.g. pack-refs
> too. It's possible for us to just have one pack, but to have 100k loose
> refs.
> 
> It might also be good to have some gc.autoDetachOnClone option and have
> it false by default, so we don't have a race condition where "clone
> linux && git -C linux tag --contains" is slow because the graph hasn't
> been generated yet, and generating the graph initially doesn't take that
> long compared to the time to clone a large repo (and on a small one it
> won't matter either way).
> 
> I was going to say "also for midx", but of course after clone we have
> just one pack, so I can't imagine us needing this. But I can see us
> having other such optional side-indexes in the future generated by gc,
> and they'd also benefit from this.
> 
> #leftoverbits
