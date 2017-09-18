Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CE32047F
	for <e@80x24.org>; Mon, 18 Sep 2017 17:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933032AbdIRRCL (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 13:02:11 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:45994 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932904AbdIRRCL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 13:02:11 -0400
Received: by mail-pg0-f49.google.com with SMTP id 188so463279pgb.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQW6rVTtZ1qUar9iNfASImJ0RR17yREQNtzSwAghiKM=;
        b=W0XBUYyPNs0MnEf32ShwDLNGvCZZnletT58HVBYnDH1iBOka9SV+f1YMmH29Wn2VHA
         L7eCiZXRp4IJV/xvZClojD6c06fi1W9tYSGaSMcIft0TdVdRJHAXrqyI57dmlWfGQGVJ
         aRNtImmcAzGeV07zncd9xqBYRxaKXjD/95tMrkRRgi2TL0lsGDNwF259V80DRox8AzHP
         cn3wbP0T1+T0SZLm0hoZS6m8sgS8wCvr6UCNW0vF1Z7YnHEzLPmqIUB7/fn4CSrIdcE5
         /cWB/W7pNU/2SAiuPcr50h+siAynDaHmRHSrYGqe4QaGkJCzC3bXcM2X5I3tjkm7uNp3
         Xemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQW6rVTtZ1qUar9iNfASImJ0RR17yREQNtzSwAghiKM=;
        b=XxQnFkoFWwJrGvAQddkS7joZsbsJGo2yxGrYVuf49SBV5aQBSsiRhlSuhohWZzVmaK
         fmIxfVhONDWtFJWdtPHVZtcR0SwoopI3dDFdNO27VzdV0zGdhQbEfKShJXCBxpt2PSME
         a7biLjjfEoF+sDMM1ZKwq8CtPh+cYd0Ictlj1mfu67Rao7YA4+gHDLfDJJhf7zRtyrcn
         z0NOBpAgTOq3XCg/CF6reB4SUpqnCYXoJ1V2Ozzu003AzD7RV2QHWSU5K3Kkb/J5L7lq
         6a98XcSDMeuoUKrWuX3VmzhKkJI0Gm/ZK3jvus+oFa3DH4hoW466jVJR/RuSQ9aAAIuI
         mEUg==
X-Gm-Message-State: AHPjjUgbn6huiV27qOHjRHDRitLVsNCNZ3QeN/h9sKqG7rrcYCmaKkwv
        /74vbDc9Yn9ISjm5kuR0IA==
X-Google-Smtp-Source: AOwi7QBMmaK2qpdTjurZwCc2ckdOWQli2p4G83sjZT1sbaSl4jm8sW8fd4guhG+4pcremVadNMKo8w==
X-Received: by 10.84.240.67 with SMTP id h3mr21390789plt.422.1505754130219;
        Mon, 18 Sep 2017 10:02:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c140:486c:cfb0:5862])
        by smtp.gmail.com with ESMTPSA id f69sm16468057pff.4.2017.09.18.10.02.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 10:02:09 -0700 (PDT)
Date:   Mon, 18 Sep 2017 10:02:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, bturner@atlassian.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/8] protocol: introduce protocol extention mechanisms
Message-ID: <20170918170207.GF144331@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170913215448.84674-3-bmwill@google.com>
 <CAGZ79kaeWsWdhoC7VDy-YkL1wVWqaQ9=TQUti9HfwjbT2poQdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaeWsWdhoC7VDy-YkL1wVWqaQ9=TQUti9HfwjbT2poQdw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/13, Stefan Beller wrote:
> On Wed, Sep 13, 2017 at 2:54 PM, Brandon Williams <bmwill@google.com> wrote:
> > Create protocol.{c,h} and provide functions which future servers and
> > clients can use to determine which protocol to use or is being used.
> >
> > Also introduce the 'GIT_PROTOCOL' environment variable which will be
> > used to communicate a colon separated list of keys with optional values
> > to a server.  Unknown keys and values must be tolerated.  This mechanism
> > is used to communicate which version of the wire protocol a client would
> > like to use with a server.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  Documentation/config.txt | 16 +++++++++++
> >  Documentation/git.txt    |  5 ++++
> >  Makefile                 |  1 +
> >  cache.h                  |  7 +++++
> >  protocol.c               | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  protocol.h               | 15 ++++++++++
> >  6 files changed, 116 insertions(+)
> >  create mode 100644 protocol.c
> >  create mode 100644 protocol.h
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index dc4e3f58a..d5b28a32c 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2517,6 +2517,22 @@ The protocol names currently used by git are:
> >      `hg` to allow the `git-remote-hg` helper)
> >  --
> >
> > +protocol.version::
> 
> It would be cool to set a set of versions that are good. (I am not sure
> if that can be deferred to a later patch.)
> 
>   Consider we'd have versions 0,1,2,3,4 in the future:
>   In an ideal world the client and server would talk using v4
>   as it is the most advanced protocol, right?
>   Maybe a security/performance issue is found on the server side
>   with say protocol v3. Still no big deal as we are speaking v4.
>   But then consider an issue is found on the client side with v4.
>   Then the client would happily talk 0..3 while the server would
>   love to talk using 0,1,2,4.
> 
> The way I think about protocol version negotiation is that
> both parties involved have a set of versions that they tolerate
> to talk (they might understand more than the tolerated set, but the
> user forbade some), and the goal of the negotiation is to find
> the highest version number that is part of both the server set
> and client set. So quite naturally with this line of thinking the
> configuration is to configure a set of versions, which is what
> I propose here. Maybe even in the wire format, separated
> with colons?

I'm sure it wouldn't take too much to change this to be a multi-valued
config.  Because after this series there is just v0 and v1 I didn't
think through this case too much.  If others agree then I can go ahead
and make it so in a reroll.

> 
> > +       If set, clients will attempt to communicate with a server using
> > +       the specified protocol version.  If unset, no attempt will be
> > +       made by the client to communicate using a particular protocol
> > +       version, this results in protocol version 0 being used.
> 
> This sounds as if we're going to be really shy at first and only
> users that care will try out new versions at their own risk.
> From a users POV this may be frustrating as I would imagine that
> people want to run
> 
>   git config --global protocol.version 2
> 
> to try it out and then realize that some of their hosts do not speak
> 2, so they have to actually configure it per repo/remote.

The point would be to be able to set this globally, not per-repo.  Even
if a repo doesn't speak v2 then it should be able to gracefully degrade
to v1 without the user having to do anything.  The reason why there is
this escape hatch is if doing the protocol negotiation out of band
causing issues with communicating with a server that it can be shut off.


> > +       Supported versions:
> 
> > +* `0` - the original wire protocol.
> 
> In the future this may be misleading as it doesn't specify the date of
> when it was original. e.g. are capabilities already supported in "original"?
> 
> Maybe phrase it as "wire protocol as of v2.14" ? (Though this sounds
> as if new capabilities added in the future are not allowed)

Yeah I can see how this could be misleading, though I'm not sure how
best to word it to avoid that.

> 
> 
> > +
> > +extern enum protocol_version parse_protocol_version(const char *value);
> > +extern enum protocol_version get_protocol_version_config(void);
> > +extern enum protocol_version determine_protocol_version_server(void);
> > +extern enum protocol_version determine_protocol_version_client(const char *server_response);
> 
> Here is a good place to have some comments.

-- 
Brandon Williams
