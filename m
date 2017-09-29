Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B9A20281
	for <e@80x24.org>; Fri, 29 Sep 2017 21:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbdI2Vcm (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 17:32:42 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:49964 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdI2Vcl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 17:32:41 -0400
Received: by mail-pg0-f47.google.com with SMTP id v13so435076pgq.6
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cFoS/O160YgQd4a7VSDpgP4byEePY4PhYkN6j1OzBFk=;
        b=S5ROhfrewtW8pVPCf1JkzOxngVvhbIV9RWRAfLtumzzFviT0JhVs3C8SPelXuMw5kK
         mMlVOYe3jadhuXX9Nq2m0oJfc/gMnPKXk9BSu522SWMqiApECHwH6s69jIsNeSR20EXX
         ZeFCk/GZDp9ays0UgFT5UUJr68MZW3MnXyYRNHB1MA3j274xsxKl4Jf2vlqQ+dr1SQJJ
         zCTNV5HBJBEqs8Fa37iKrufk1Owapn7GzUDiTI2tK6CjNNOiRqqlb7awO0OIPwFxq6Nv
         xXrXltsQu89OnTv10JN+hH2FhBb9jKANidJe1qXM5K7d1XfyqzT4H9r/d7EXRUGhDHSX
         AxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cFoS/O160YgQd4a7VSDpgP4byEePY4PhYkN6j1OzBFk=;
        b=PV34/o3rS/Ap4oPqO4VPLzUNuUBMcsyUEBid+upRRy/m7whcSBgBCKXS8MIse18PgY
         1rLKR6Zxq1rg2gsSZ7nZOVvZAkYJmIQHvwDdKBe8E8iwXbvutp9GfJQKfVcT+ulc6995
         /DfSAob0LChL9oCSCj8+b4nhrKAnq68W4J50JD0U7gKYt7ZKnpfe6GF/vixZIW7Pvjlt
         4v08t9EB8ajy3R2ID0rXGjwLNmfFvMWC5tw3seEKHRg3cVqfOtZGDE8BrkokhvsI2iTv
         Wo6AmcrJqnBPMp4ijaL7AyVYo4By3QQpiZnEQ2diKbr9gL5EgfUgkFU2UYBAMa+0lJro
         ZB0A==
X-Gm-Message-State: AHPjjUjOpY4TAb/bKT9x+vGPwjobdFWBR1rt8w8K9vDz+sML0n4sMI9K
        3ysKH6Qm9sM7oZ/zBxWG+Kkh128GE4o=
X-Google-Smtp-Source: AOwi7QCo5jH9Hl7AkqGEPbAFi+KplmbffjEra3XezYauXDsb0ZNq5BD0I/0LQFhfIjZNgKHh91cqQw==
X-Received: by 10.98.56.74 with SMTP id f71mr9111974pfa.44.1506720761186;
        Fri, 29 Sep 2017 14:32:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:41cf:d592:f95a:46b2])
        by smtp.gmail.com with ESMTPSA id s81sm8964545pfg.162.2017.09.29.14.32.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 14:32:40 -0700 (PDT)
Date:   Fri, 29 Sep 2017 14:32:38 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 7/9] connect: tell server that the client understands
 v1
Message-ID: <20170929213238.GB92120@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-8-bmwill@google.com>
 <xmqqk20k64r4.fsf@gitster.mtv.corp.google.com>
 <xmqqbmlw64dr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmlw64dr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +	# Client requested to use protocol v1
> >> +	grep "version=1" log &&
> >> +	# Server responded using protocol v1
> >> +	grep "clone< version 1" log
> >
> > This looked a bit strange to check "clone< version 1" for one
> > direction, but did not check "$something> version 1" for the other
> > direction.  Doesn't "version=1" end up producing 2 hits?
> >
> > Not a complaint, but wondering if we can write it in such a way that
> > does not have to make readers wonder.
> 
> Ah, the check for "version=1" is a short-hand for
> 
> 	grep "clone> git-upload-pack ...\\0\\0version=1\\0$" log
> 
> and the symmetry I sought is already there.  So ignore the above; if
> we wanted to make the symmetry more explicit, it would not hurt to
> spell the first one as
> 
> 	grep "clone> .*\\0\\0version=1\\0$" log

I think you need three '\' to get an escaped backslash, but I agree,
I'll spell this out more explicitly in the tests.

> 
> though.
> 

-- 
Brandon Williams
