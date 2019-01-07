Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97DC31F803
	for <e@80x24.org>; Mon,  7 Jan 2019 21:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfAGVZY (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 16:25:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37947 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVZY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 16:25:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so751615plb.5
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xR+ACaZZBj+yMesgHTYGEEBhFo57b9Z/dKT62ixTiu4=;
        b=tPPo42XPLMX3TfKwFQCANZQM0nSS/ZJ1sKF44w47aRHhC5CH82EwcgRRO+4kyTpqRQ
         FAkrSDWWTRv6h8SWDWpdAHMSoivd3OkN4USO3f4RsvML61Tor9jpisAiQxGQcfkKvnYB
         2vrWqfVxbw4tq/tJ5OEdV7+7SOAUj9bxGSjiax33z5lRUFNDxzESGMTIvnOnweV4e9BJ
         tThKhePNey0d0Z0Wm0Lc9MD0y52koYsRHxNQSZZMYLdPNLfpoaqVuWkJSRI3dhgfuYKA
         59VXvX17/YECSNRoJbrq4MxACkyK3oszKloj8IyyBo9K56fms1xaMyQ4/v72PFkIH1/9
         dVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xR+ACaZZBj+yMesgHTYGEEBhFo57b9Z/dKT62ixTiu4=;
        b=EhkKvxx1e6mnSe9a/PQTkTvtJlWIZbJy+rIQrqSpzs/VENNxBCqk9a9g1Ej8M+aszN
         7MvaIwvUGJUSEHZcGtYoF6R3nYIlDw+S2regvtP7wZUMYdmMzfwl3AzUSw3XIVeog3iP
         JXbUvSqYRR6M77vC/ajJKzKIfZ80uI8sXUe/M7IivnWJHEJd3ydwfYSc6gnROrcfcrz1
         z2b20YhYNR7NxFaXfPPSy2m5gZSPtYZ+pC2vKlmqxGghH/btjdSSixV67RUXERWJIcmu
         xceEkw9ebGN3n5JR4ivoqgtqa/Gu2d4wbrqkEd+ggTKAVfzs8Xn/Z3xA6P/xUI/miGxl
         PeOQ==
X-Gm-Message-State: AJcUukdADrWelUg+a+GdEmz6XS/OVU2bhCdwP4x6BJuKDHymi3YWQ7uH
        UhmlqWeT3cR7qHlbvWM5uijp2g==
X-Google-Smtp-Source: ALg8bN5yL+9LRzwGAGEbiY7J1XTo1nOjkU9l3Jli4zht1/j5ZT4+RxccZFFsMiS+JDYZHCJnd1hXWA==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr60892793plr.245.1546896323231;
        Mon, 07 Jan 2019 13:25:23 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id h134sm134270274pfe.27.2019.01.07.13.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:25:22 -0800 (PST)
Date:   Mon, 7 Jan 2019 13:25:17 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] filter-options: Expand abbreviated numbers
Message-ID: <20190107212517.GA54613@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1545261186.git.steadmon@google.com>
 <d324e7836928940a4df0b43da3ffeb8526feac61.1545261186.git.steadmon@google.com>
 <xmqqsgyaircj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgyaircj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.01.02 15:15, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > When communicating with a remote server or a subprocess, use expanded
> > numbers rather than abbreviated numbers in the object filter spec (e.g.
> > "limit:blob=1k" becomes "limit:blob=1024").
> >
> > Update the protocol docs to note that clients should always perform this
> > expansion, to allow for more compatibility between server
> > implementations.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  Documentation/technical/protocol-v2.txt |  5 ++++-
> >  builtin/clone.c                         |  6 +++++-
> >  builtin/fetch.c                         |  7 ++++++-
> >  fetch-pack.c                            | 15 ++++++++++++---
> >  list-objects-filter-options.c           | 20 ++++++++++++++++++--
> >  list-objects-filter-options.h           | 17 +++++++++++++++--
> >  t/t6112-rev-list-filters-objects.sh     | 17 +++++++++++++++++
> >  transport-helper.c                      | 13 +++++++++----
> >  upload-pack.c                           |  7 +++++--
> >  9 files changed, 91 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index 09e4e0273f..d001372404 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -296,7 +296,10 @@ included in the client's request:
> >  	Request that various objects from the packfile be omitted
> >  	using one of several filtering techniques. These are intended
> >  	for use with partial clone and partial fetch operations. See
> > -	`rev-list` for possible "filter-spec" values.
> > +	`rev-list` for possible "filter-spec" values. Clients MUST
> > +	translate abbreviated numbers (e.g. "1k") into fully-expanded
> > +	numbers (e.g. "1024") on the client side, so that the server
> > +	does not need to implement unit parsing.
> 
> I suspect that it is too late now to retroactively say "MUST" here.
> The best we may be able to do is to say "The sender SHOULD send a
> plain integer without unit and the receiver SHOULD be prepared to
> scale an integer with unit".
> 

In that case, do you think we should also specify that units should be
interpreted as powers-of-2 rather than powers-of-10?
