Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E904F1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 00:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbeBGAz1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 19:55:27 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40134 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeBGAzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 19:55:25 -0500
Received: by mail-pg0-f67.google.com with SMTP id g2so1828036pgn.7
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 16:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJ7r7Hn/FdGeB9OcW18UB5ULGdjAYrFTGlJjQeHSu4Q=;
        b=KVRT7hqYJCe32DEMDmVW/ss9QUueIeHUCc0FUT6eGR32irZA3kld3RBcqynVQHshUy
         0uV+OfUtw7hSy74Bl9e+3hEC+L9Z8m/chFRLxMnpAZODJK6BfjkuG9nhaXZc9/3NoJRD
         wAEulLu+t85x/qQEpozzVwz5kgTv/opSnTh5z+TsL0fzzsgoWQfn0akRZtQJiNcW1Igz
         Rt8W0MBlOVKhs0tcXRC/IoaVW9r5c7JIt2Vu4+AZ1hgUNcffTHL+U3bfrr4oVkisTd7l
         tLCO+2k1TYYbsx+R0WAAcRWjsvc2I46sJnW1q57WGCuS/fCv3gKE4Vn066pBiqFdEzdr
         QbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJ7r7Hn/FdGeB9OcW18UB5ULGdjAYrFTGlJjQeHSu4Q=;
        b=WwjALvZ6UUsNNBpYer0K7nSuLgf/I3czeeAp8sppHEhx6dJEtYlAg3NUgRfI2gM/Hs
         xTF966A1ZlErf8oLne7soM/DEHS+iUmhadc3bsGXeGevPbj7rBOcwWQUBHtbBh6b8MZG
         XCrsnAZWUdRf2LBr2HVESJef/M3YAmEXZ5VHIGPmzLmNJX5n1GZt+7onFhxTVmKYpR0U
         6qRKDi+RCC7ZA4icxzeEXjoKVPCQ427qe/I0YdSmmKaGginWUrN/Lb17XTpmpyx65/UR
         7CSdo+WvoYw5hTGvjOm/C/3Ui2+TwfShgfQo/7Y7C7v8x/dYaHQzzbdZY1TG5fg4GOfb
         Ku8Q==
X-Gm-Message-State: APf1xPB8cO3rEXl//pJm+1eX9TCg1652zlDLDmyj9rxC1Q7/rUQlYCl5
        kIHUffJ+AZe1m4V9NtbYkUGQpQ==
X-Google-Smtp-Source: AH8x224/1g0GO02dMe7uB1kvqTYJmHSNnJfQxx4IEoUaAQd8Z9KHJByc90y3shzFbVRDOBzWl+R2eQ==
X-Received: by 10.98.149.69 with SMTP id p66mr4090913pfd.183.1517964924806;
        Tue, 06 Feb 2018 16:55:24 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q184sm297894pga.30.2018.02.06.16.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 16:55:23 -0800 (PST)
Date:   Tue, 6 Feb 2018 16:55:22 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 12/26] ls-refs: introduce ls-refs server command
Message-ID: <20180207005522.GA222904@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-13-bmwill@google.com>
 <e2fb1a05-3cbd-5226-7796-c5b89c9d3955@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fb1a05-3cbd-5226-7796-c5b89c9d3955@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/01, Jeff Hostetler wrote:
> 
> 
> On 1/2/2018 7:18 PM, Brandon Williams wrote:
> > Introduce the ls-refs server command.  In protocol v2, the ls-refs
> > command is used to request the ref advertisement from the server.  Since
> > it is a command which can be requested (as opposed to mandatory in v1),
> > a client can sent a number of parameters in its request to limit the ref
> > advertisement based on provided ref-patterns.
> > 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >   Documentation/technical/protocol-v2.txt | 26 +++++++++
> >   Makefile                                |  1 +
> >   ls-refs.c                               | 97 +++++++++++++++++++++++++++++++++
> >   ls-refs.h                               |  9 +++
> >   serve.c                                 |  2 +
> >   5 files changed, 135 insertions(+)
> >   create mode 100644 ls-refs.c
> >   create mode 100644 ls-refs.h
> > 
> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index b87ba3816..5f4d0e719 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -89,3 +89,29 @@ terminate the connection.
> >   Commands are the core actions that a client wants to perform (fetch, push,
> >   etc).  Each command will be provided with a list capabilities and
> >   arguments as requested by a client.
> > +
> > + Ls-refs
> > +---------
> > +
> > +Ls-refs is the command used to request a reference advertisement in v2.
> > +Unlike the current reference advertisement, ls-refs takes in parameters
> > +which can be used to limit the refs sent from the server.
> > +
> > +Ls-ref takes in the following parameters wraped in packet-lines:
> > +
> > +  symrefs: In addition to the object pointed by it, show the underlying
> > +	   ref pointed by it when showing a symbolic ref.
> > +  peel: Show peeled tags.
> > +  ref-pattern <pattern>: When specified, only references matching the
> > +			 given patterns are displayed.
> > +
> > +The output of ls-refs is as follows:
> > +
> > +    output = *ref
> > +	     flush-pkt
> > +    ref = PKT-LINE((tip | peeled) LF)
> > +    tip = obj-id SP refname (SP symref-target)
> > +    peeled = obj-id SP refname "^{}"
> > +
> > +    symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
> > +    shallow = PKT-LINE("shallow" SP obj-id LF)
> 
> Do you want to talk about ordering requirements on this?
> I think packed-refs has one, but I'm not sure it matters here
> where the client or server sorts it.
> 
> Are there any provisions for compressing the renames, like in the
> reftable spec or in index-v4 ?

Not currently but it would be rather easy to just add a feature to
ls-refs to transmit the resultant list of refs into something like
reftable.  So this is something that can be added later.

> 
> It doesn't need to be in the initial version.  Just asking.  We could
> always add a "ls-refs-2" command that builds upon this.
> 
> Thanks,
> Jeff

-- 
Brandon Williams
