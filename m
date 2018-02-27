Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84DE21F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeB0SF7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:05:59 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43762 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeB0SF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:05:58 -0500
Received: by mail-pf0-f196.google.com with SMTP id z14so8270664pfe.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gc11UILCDJhe2daThwHb6sdExgOSQgU3ZJ6hoQYBfTI=;
        b=fAp6J/KkjwHmrL5oXK7LeeGH3BnYJlk09/k8IWNIZ/Dod2cb/qA8l6CXOuDE1r//PB
         i1Grq+7zMkcWacYFdnhTug9srjoLXRKFayUVz0RQZQwahcpZxR+80yAJHrVkedbnyCUW
         HeaRKkHZzl3JfuAzPEniXinkuRvt1oHUU3I8mkb7xVQjM/XhtI5D9DT9roA6LM9+yiic
         IWk5ZFio1HLzrUEaxD7fVE3R/TjgBmAUmoG6ejtrLUHCFOPUiLWs1TMUtVWWlKDVUOyF
         CAiGIUfnQvgyRCYE/2n0ias2DjkkIw/mMJjYRFZaDdwL3qLDFmCht5DzNiuHYMOMtbQS
         0/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gc11UILCDJhe2daThwHb6sdExgOSQgU3ZJ6hoQYBfTI=;
        b=El3QIzE3OfP6Z9zVYEinsWfRqVAOoX9xO20A/199QGqlNNJwLzrRwCYtOAKK4mSyjO
         M7rUXvpE/Fg3q3b9+F6Fd+afsgUJAXaDwwNkT8470uSrM6ImpkpsbIDex1ZlRWggRcgQ
         /zM9kTSoRlg4XXYFWkAfj96Ufcom60JoVBPMh9/ec/o8OhScfpggrlSfj2TSIwY7PgZm
         UITgY+R3I+1VCChepmN3sQyHMWfH/efIOnvpCB5d1OztR+Nl5k7Zn6x+tUzqjumR3rEf
         Y8OCuPloopleLhtBzj+YPcXdNrKbwwzQ6vlsBuhn6K6GKUXjtXDPm0QCQ1EyDJECICaj
         mZ9w==
X-Gm-Message-State: APf1xPCwLEU5M5svCjBtkoCzL+rZ/VgMBRjJ0cr7RfMa9R/16TRUWQGA
        R4r2ZAxF/5AOmd2GUQ05xh5kuw==
X-Google-Smtp-Source: AH8x227l+zOGRhqwrZ2Y8nJYW43TpaNb4GDn8OJEjAJG7Dr2gpLKw0nXnO/kalzWQokuf2wAft1xlQ==
X-Received: by 10.101.90.203 with SMTP id d11mr11796302pgt.366.1519754757458;
        Tue, 27 Feb 2018 10:05:57 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id d70sm12420768pfl.119.2018.02.27.10.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:05:56 -0800 (PST)
Date:   Tue, 27 Feb 2018 10:05:55 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-Id: <20180227100555.91f2a5e196bff3968871a16e@google.com>
In-Reply-To: <20180223213315.GE234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-13-bmwill@google.com>
        <20180221144515.d180a26627a33168b19e0a4f@google.com>
        <20180223213315.GE234838@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 23 Feb 2018 13:33:15 -0800
Brandon Williams <bmwill@google.com> wrote:

> On 02/21, Jonathan Tan wrote:
> > As someone who is implementing the server side of protocol V2 in JGit, I
> > now have a bit more insight into this :-)
> > 
> > First of all, I used to not have a strong opinion on the existence of a
> > new endpoint, but now I think that it's better to *not* have git-serve.
> > As it is, as far as I can tell, upload-pack also needs to support (and
> > does support, as of the end of this patch set) protocol v2 anyway, so it
> > might be better to merely upgrade upload-pack.
> 
> Having it allows for easier testing and the easy ability to make it a
> true endpoint when we want to.  As of right now, git-serve isn't an
> endpoint as you can't issue requests there via http-backend or
> git-daemon.

Is git-serve planned to be a new endpoint?

If yes, I now don't think it's a good idea - it's an extra burden to
reimplementors without much benefit (to have a new endpoint that does
the same things as upload-pack).

If not, I don't think that easier testing makes it worth having an extra
binary. Couldn't the same tests be done by running upload-pack directly?
