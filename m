Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6B81F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934999AbeF0SPW (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:15:22 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35655 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934492AbeF0SPV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:15:21 -0400
Received: by mail-pf0-f172.google.com with SMTP id c22-v6so1347006pfi.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RuveBp5cHRyXIZMTq5dV2Wo1RJ3gBxdDxQ9wvR9dV3E=;
        b=EfWj39gz3u9uDub6K8a5JgHKhgWFum7AtNKYK875I/ptmc4KNjes3y08c7+baUbRr8
         jX7eEYcpQNXzUHje4kFFMGR9QarOnivqIVv/s4EGck9DUrAHai8sBL8LCeQ8yLRKBVq4
         2laXqielM0gyKSEku8FlRUwXEMiryxNNUS4T/Eho38vwZ7erwEkayu9Z6e3dedIzv8B8
         Yrtqmw5cLU6shKJyY5WhLsQk6iLmYQw2aVy/MzZXy+Okhb42lX+9DRtVYe649pYDxcrx
         RKDzld6d0wP9E93kUphSSWy7Yt2qcXdPjwzH8wYuuafmmgIaYtBRbrw1+lp+lwielLRJ
         8j7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuveBp5cHRyXIZMTq5dV2Wo1RJ3gBxdDxQ9wvR9dV3E=;
        b=hzgr9cPo3WTlMvOwmpmzgnI0ik73K4smmT0TW6CkD54hjjCnnkLLMe5snBX3snufsT
         rmrBtse2Y3EJwWH3EQd7wbYMCnuMzPT2xk1t30+mQc0VWN8v4u4EqsSUI3ZKJ5LydD2h
         +lu9paIWCerNeNSdEG0lm52Qe8ao1FvNxvlvkK4s5w0926XMDzYc3NbYmpIgendwk5YH
         PkHDxuP0FbhhZtSr2FZkb6t4HudGcZusnfQXxTPXWpL+KOkC+L9XTLty4aQ8M05bp0X9
         CS69WjfMtSS/xascWaGWUvpLZ1okcj+CK9N3FPLRr1F7psYc6DdM00a0is4XCfGM9XmS
         dkJA==
X-Gm-Message-State: APt69E0VMYdl5ZbFDbDDkpij08ciVM+bkELN8dccabvh3SnZZ87yblvY
        1VaRpSgZn4Sd5fKlF1L64P51/g==
X-Google-Smtp-Source: ADUXVKIjH0jB3zmTFTXlqwXodt9Ne6WK2Cqntoc5GrUk4PYhi8Uy4+/peJj+Kn89ADXLfD2ZVJ15vQ==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr6149916pgs.350.1530123320630;
        Wed, 27 Jun 2018 11:15:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 81-v6sm9069050pfl.125.2018.06.27.11.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:15:19 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:15:18 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 7/8] fetch-pack: put shallow info in output parameter
Message-ID: <20180627181518.GI19910@google.com>
References: <20180625185332.164142-1-bmwill@google.com>
 <20180626205438.110764-1-bmwill@google.com>
 <20180626205438.110764-8-bmwill@google.com>
 <xmqqfu19i5rq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfu19i5rq.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/26, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Expand the transport fetch method signature, by adding an output
> > parameter, to allow transports to return information about the refs they
> > have fetched.  Then communicate shallow status information through this
> > mechanism instead of by modifying the input list of refs.
> 
> Makes sense.  Would this mechanism also allow us to be more explicit
> about the "tag following"?
> 

Yes most likely.  We could change it so that when a packfile is sent the
result of tag following could be sent along too (the actual tag refs
themselves that is) instead of having the client rely on the ref
advertisement for tag following.

-- 
Brandon Williams
