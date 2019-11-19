Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC881F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 20:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKSUkT (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 15:40:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46271 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 15:40:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so12820880pfc.13
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X1v39SgS+eUkGDwBoFtmWCO/6sNIZVY0zFBG0Fbr8mw=;
        b=GG7PNpOzJc7j+KrV8cFpNSEg2WifInyZOXgUQwLu53Xl5d0KTtN9+WXIuMofzmk4Ts
         LtDBBTr/B3Doc38AFlwF3/diS6ioSGAxYskvxH5g8WUKgyQIFNZMnEtSrLJh7zBfQpVQ
         SAWeiVHLAHjkEY+Ht3p9oQNT9bD0DYz0Ba94o4UGV4Vl8C5r4HWn1wYXGa7X/pKdH+zk
         7qFUfjsbW2YUwk3VDd/vv0NKPVlbH9Xnw/caifWC7rqekBG1MfdvyMvTl6PXGZ0231mW
         kHBh7jMV6ZSMj/jcPYxla328DMT8aAfr4ye2BsE+ggLO3VUzxPASETyBxt+MfqIniWks
         2OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1v39SgS+eUkGDwBoFtmWCO/6sNIZVY0zFBG0Fbr8mw=;
        b=dqIIPu5YyqkFsTn5JFibGC3A9ZQOT3+i0PnokuJjvfjztUURUzNMrDQr7q6jiSzbiC
         R8QC4GUTPf0XQ0WrEJSoPrS3h3aikvkXcrK2P2pIn21cwafOzXIzHxSpUS3FlxLeYy7q
         JlwKBX3sgWGyiiEwHfzCzVs7P0XiG1K+wTbUmHXm2L7xbjH5hRL7mFIqdaa220/D3VwQ
         92oX78Ky+vGHvJjdB3W8yZfgAhfXcbPnEAIsp6agQEviU7rirU+OD0RuPiiO96iGxGI7
         I7GpyABw62Ik527UdLLec26MeTaFYHJY2pFAXod3hRxSmr2R/R+A67Dr5Z5f4zz9AnMp
         UXqw==
X-Gm-Message-State: APjAAAXwfPbLe65U90MtTv5pPoxL7+jrD8OrrGgDwXX089haSucZLY/j
        J5cmmK7i2HjtPtcxRKueMDAUvg==
X-Google-Smtp-Source: APXvYqwpyhNmShzdIs4az5NUM4WhxZeV7f5nx+QUO/KugiiVQ3kkkLXSQ9lcHHs+mmI6TUtKXri+lA==
X-Received: by 2002:a63:4a01:: with SMTP id x1mr2575256pga.312.1574196018335;
        Tue, 19 Nov 2019 12:40:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r203sm24469489pfr.184.2019.11.19.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:40:17 -0800 (PST)
Date:   Tue, 19 Nov 2019 12:40:13 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 9/9] bugreport: print contents of alternates file
Message-ID: <20191119204013.GC36377@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-10-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1910281655420.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281655420.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 04:57:01PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 24 Oct 2019, Emily Shaffer wrote:
> 
> > In some cases, it could be that the user is having a problem with an
> > object which isn't present in their normal object directory. We can get
> > a hint that that might be the case by examining the list of alternates
> > where their object may be stored instead.
> 
> Doesn't this open the possibility of leaking project's (possibly NDA'ed) names?
> 
> I could imagine that we might rather want to count the alternates, and
> maybe separate into those alternates that actually exist and alternates
> that do not exist (which would produce a warning that the user might
> have trained themselves to ignore).

Sounds reasonable. Will do.

 - Emily
