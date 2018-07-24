Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76EE5208E8
	for <e@80x24.org>; Tue, 24 Jul 2018 19:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbeGXUH5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:07:57 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:38334 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388429AbeGXUH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:07:57 -0400
Received: by mail-pg1-f175.google.com with SMTP id k3-v6so3525074pgq.5
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XcEdkb2ZwQomsBOm3j1OIfleqwDaVD9Z+m8uOCALRZQ=;
        b=g/67kXfYXdb6aOsm7z2bidizklqyJuKAkzY+YFhc0UWhaMNoRqUytwZ3dLKSMgBxtG
         Ca7ZZDR0ELayldvJeEeIsZuYcozUcAnKkBEt+OUXHVqkdSNKTOyErQiPq14mY6jcCZ1/
         ko7gJOotPvpe8i7OA4prX49wTEd+Kx06T0fjdOmprQK5hDuj/N10IjYzzLSISII1i2Zi
         TdGyU9Z3u3qweSvbymgVUXh7WdDOvG/DAK0BCtCeIwhC7/yNVgXeL4cmqW7AIrts2jWy
         SQSzGBnRy9l5/h7Og+cfcw/CnwnPEHNiKwxbhGEmwxqfceZxLZmZvpm9C0CtYgu+Xe0X
         +BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XcEdkb2ZwQomsBOm3j1OIfleqwDaVD9Z+m8uOCALRZQ=;
        b=o636pUKj0kFeAIBCetz8Hh343bNl7ve/MqxOoUUYccV19sYo3Sj1RUqx3MNMFx2gVl
         LBfRaP7WhP/kdPxTrCMKJXeOGOXbDXLuChnEX5VoSv2QasUUkfqu7dxEdgBuEEjVdOkN
         2fKuoJgnoA//5kJAFMbTEA5h1vzr4YKKceETSiaOvumg6sNZA0gwgvqv2CpokUwcvCU5
         gvdtqyVPuTiSHUzT+4IsAAUChKy9tK+nZib9J6sJiRzaDiP9mGD+NmX5VC5FJl7tXcks
         BKuXZhaSH/TjQYC6Y7b7IlDh8p4f8le3xyLW3Z0DhV3cZhz4kp4lCfjDFphMvnakCPK2
         WjFQ==
X-Gm-Message-State: AOUpUlHtay3VUqduYsA/OJXIJdvwJEh5YUVh+Rw38nqRDnG+tCYpc5wS
        fqZZje93hGWZG8ZzccDrhzfihA==
X-Google-Smtp-Source: AAOMgpdFy/qBej6iPZ8EyG/N81Vzpn0BMMwY6jURxHnmazIUW+ts7zt98W0o++XpRQDHKU7zL4AlIw==
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr17318828pge.75.1532458805370;
        Tue, 24 Jul 2018 12:00:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q21-v6sm21279048pfl.156.2018.07.24.12.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:00:04 -0700 (PDT)
Date:   Tue, 24 Jul 2018 12:00:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [RFC] push: add documentation on push v2
Message-ID: <20180724190003.GB225275@google.com>
References: <20180717210915.139521-1-bmwill@google.com>
 <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
 <CAGZ79kbLn-uwQOXfqhtO46v0EWevY43Tf4W5Rz9gDD9_qbmX=A@mail.gmail.com>
 <20180718171512.GC17137@google.com>
 <1dd6d9aa-0e96-bb8e-f7ae-873f619a2450@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd6d9aa-0e96-bb8e-f7ae-873f619a2450@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/20, Jeff Hostetler wrote:
> 
> 
> On 7/18/2018 1:15 PM, Brandon Williams wrote:
> > On 07/18, Stefan Beller wrote:
> > > On Wed, Jul 18, 2018 at 6:31 AM Derrick Stolee <stolee@gmail.com> wrote:
> > > > 
> > > > On 7/17/2018 7:25 PM, Stefan Beller wrote:
> > > > > On Tue, Jul 17, 2018 at 2:09 PM Brandon Williams <bmwill@google.com> wrote:
> > > > > > Signed-off-by: Brandon Williams <bmwill@google.com>
> > > > > > ---
> > > > > > 
> > > > > > Since introducing protocol v2 and enabling fetch I've been thinking
> > > > > > about what its inverse 'push' would look like.  After talking with a
> > > > > > number of people I have a longish list of things that could be done to
> > > > > > improve push and I think I've been able to distill the core features we
> > > > > > want in push v2.
> > > > > It would be nice to know which things you want to improve.
> > > > 
> > > > Hopefully we can also get others to chime in with things they don't like
> > > > about the existing protocol. What pain points exist, and what can we do
> > > > to improve at the transport layer before considering new functionality?
> > > 
> > > Another thing that I realized last night was the possibility to chunk requests.
> > > The web of today is driven by lots of small http(s) requests. I know our server
> > > team fights with the internal tools all the time because the communication
> > > involved in git-fetch is usually a large http request (large packfile).
> > > So it would be nice to have the possibility of chunking the request.
> > > But I think that can be added as a capability? (Not sure how)
> > 
> > Fetch and push requests/responses are already "chunked" when using the
> > http transport.  So I'm not sure what you mean by adding a capability
> > because the protocol doesn't care about which transport you're using.
> > This is of course unless you're talking about a different "chunking"
> > from what it means to chunk an http request/response.
> > 
> 
> Internally, we've talked about wanting to have resumable pushes and
> fetches.  I realize this is difficult to do when the server is
> replicated and the repeated request might be talking to a different
> server instance.  And there's a problem with temp files littering the
> server as it waits for the repeated attempt.  But still, the packfile
> sent/received can be large and connections do get dropped.
> 
> That is, if we think about sending 1 large packfile and just using a
> byte-range-like approach to resuming the transfer.
> 
> If we allowed the request to send a series of packfiles, with each
> "chunk" being self-contained and usable.  So if a push connection was
> dropped the server could apply the successfully received packfile(s)
> (add the received objects and update the refs to the commits received so
> far).  And ignore the interrupted and unreceived packfile(s) and let the
> client retry later.  When/if the client retried the push, it would
> renegotiate haves/wants and send a new series of packfile(s).  With the
> assumption being that the server would have updated refs from the
> earlier aborted push, so the packfile(s) computed for the second attempt
> would not repeat the content successfully transmitted in the first
> attempt.
> 
> This would require that the client build an ordered set of packfiles
> from oldest to newest so that the server can apply them in-order and
> the graph remain connected.  That may be outside your scope here.
> 
> Also, we might have to add a few messages to the protocol after the
> negotiation, for the client to say that it is going to send the push
> content in 'n' packfiles and send 'n' messages with the intermediate
> ref values being updated in each packfile.
> 
> Just thinking out loud here.
> Jeff

We've talked about working on resumable fetch/push (both of which are
out of the scope of this work), but we haven't started working on
anything just yet.

There's a couple different ways to do this like you've pointed out, we
can either have the server redirect the client to fetch from a CDN
(where its put the packfile) and then the client can use ranged requests
to fetch until the server decides to remove it from the CDN.  This can
be tricky because every fetch can produce a unique packfile so maybe you
don't want to put a freshly constructed, unique packfile for each client
request up on a CDN somewhere.

Breaking up a response into multiple packfiles and small ref-updates
could work, that way as long as some of the smaller packs/updates are
applied then the client is making headway towards being up to date with
the server.

-- 
Brandon Williams
