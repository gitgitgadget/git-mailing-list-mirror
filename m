Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2178D1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 18:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933804AbeGISdc (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:33:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41851 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932789AbeGISda (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 14:33:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4-v6so54446pgo.8
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2MQ11cXDwYqy8LmwQcTnJTaCSU9CF2DzgYpTG+W4jik=;
        b=CdUePpZEKVL65kDFOW4puIm3A87xYnqGxOUFnQbNPnLNY97qsx/nlmrm9plXeZTcrG
         PXNOd/PhmLPBtW/OExItspFVQo7q2xa0uag1mFcRQUMjOYWkW72HNnPCXZuLgHkZse4k
         zZ0t78J1j/2Pdbb41x8ddz6zkqMGanSYQq1EK7JfBSMang5hyN0pbsMMv09UOm7Bj3Cd
         ckZyxhHb+Uysg+mw2ttmuLcMJkmJWqTq5d5ycWr1jUB8tFvDhmyxMb+tpddTMe6pFp1s
         ACJarA4R8JsK52c6RcFpTOHZMYF7visgEA/l2fPy0i1S6UBQYi+lLEaV/4cn0aRwltan
         yJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MQ11cXDwYqy8LmwQcTnJTaCSU9CF2DzgYpTG+W4jik=;
        b=CxAgfwwtIl0kWj+Pwnl5cWCmTFPwVX1GlOqHkeUgVCe+i7Zttc4LkQDZc0X/n7+YVm
         GuqiTLDeTlzRuQAlUuJD7LL2bxb+DfatPetetaAI5uxdySoVhaBdypAuf8Mh6+wyL3mI
         KzOH3lVv0KJbtqcbZF4TlJ+/1Pav/VhX5uEEaWzgL0yWdwXQ7BIPJP2eA0QnY4M592/m
         RALEi2GuUKSUj4AyzWSXw/J3sE78jIRe3KD6aSiqq8UKILAfnuOPTFAKu8AotjIygJ8h
         +qjVDKyE6tQqWuGO0KnONL2H7tOVOLX04uFiOrt9u03vAALmVfubD8H2zW2DM5aDn8iX
         3Q5Q==
X-Gm-Message-State: APt69E08wPEvm/gkoc7A4djpwdjJ6zr6OB4ax22Q9/UAxy149OPpxlLH
        8lJZC8PuiR+TcLTaB3hQxODLoQ==
X-Google-Smtp-Source: AAOMgpd1RaaGpal6sbyWPjt59vST42xE/g9gQOabOjon34Fk3N89ftJtAb2f2yp1zEk2H9Y5U7ZnLQ==
X-Received: by 2002:a63:41c6:: with SMTP id o189-v6mr20251648pga.323.1531161210076;
        Mon, 09 Jul 2018 11:33:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id e21-v6sm14549182pfl.187.2018.07.09.11.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 11:33:28 -0700 (PDT)
Date:   Mon, 9 Jul 2018 11:33:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
Message-ID: <20180709183328.GD81741@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
 <cover.1528234587.git.jonathantanmy@google.com>
 <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
 <20180709173813.GA14196@aiede.svl.corp.google.com>
 <20180709175939.GC81741@google.com>
 <xmqq8t6ke07x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t6ke07x.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > I agree with this observation, though I'm a bit sad about it.  I think
> > that having tag auto-following the default is a little confusing (and
> > hurts perf[1] when using proto v2) but since thats the way its always been
> > we'll have to live with it for now.  I think exploring changing the
> > defaults might be a good thing to do in the future.  But for now we've
> > had enough people comment on this lacking functionality that we should
> > fix it.
> >
> > [1] Thankfully it doesn't completely undo what protocol v2 did, as we
> > still are able to eliminate refs/changes or refs/pull or other various
> > refs which significantly add to the number of refs advertised during
> > fetch.
> 
> I thought JTan's <20180618231642.174650-1-jonathantanmy@google.com>
> showed us a way forward to reduce the overhead even further without
> having to be sad ;-).  Am I mistaken?

That's true, what Jonathan mentioned there would avoid having to send
"refs/tags/*" when requesting the refs.  The question is do we wait on
implementing that functionality (as another feature to fetch) or do we
fix this now?

-- 
Brandon Williams
