Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 534561F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbeFNTVy (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:21:54 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40582 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbeFNTVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:21:53 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so4055311plo.7
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dqirnZiLWgtq/WH+zORwxX9Wx1QWsTbJDLwUpXFTcQI=;
        b=UdXYJADYLxRjrSF0V8SvWXt0qTjcC99AD7LooJSNmR4l2Dhtz6vVwMtlaG5lyCzq2X
         hf4jt0WSGvKAUA2JK0Fpg/CTE4nzOnZtsCXY8hwd3ehKZBLjp31t2UatJI5NfZUUvIeA
         Milz1Qk77Pc8qKoJY3u+AMjjaWh9Rswa4jaXzld8g4g+IGhcK64aJOUOM72kUF4BKe0o
         3PCSddF+LbKQd4kSRp4iXTyXkjh7g+TIU2DOk92pgQhZZSix7fhAwNgCvnRanLFEmoFh
         O/g+Nhb91tYRrJHFoqkUQi6P+dotr0sOJ6bA6qRt0RivG/7KVLzQzApCBc5VE0E3AjSa
         48CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dqirnZiLWgtq/WH+zORwxX9Wx1QWsTbJDLwUpXFTcQI=;
        b=fJwBwROjIAHoPYW8drL4y3WfzejV7Dq1lqDrC72nEAKpn4mL0h29kirxi0VCyMcyje
         IBpWMWiSqcKFW/ZWq1GHPOfDjC0B/pFymTUKkDt3mWYblLZwnb55G4ot7aTf84S1LFKU
         JYwzb/A55OFird9HYae8KVjp2KcjUNyXEOTw8dtf95M4HmEaq+7Npxy6A6+615FnketK
         jT/NPLDJMjhqW47h/O525sVFYq4kJOy/0wsGwl70CNQq8GdCruyFSyOK4kNeaq4unrFw
         qMO++KVwob+ZycvI2O0Dw6UmUqE1uz7GIr7UXKa53JnazDpSQJBuJ4UCuDETYpjxt2Ri
         AxPQ==
X-Gm-Message-State: APt69E2zdqZVpQbDazUZFGi6TkIaPOu88gg6GIUXumQdhZfvaMZhtWkQ
        4hkeXbN4wtSWsTGSVeDENqjV6w==
X-Google-Smtp-Source: ADUXVKI4uW8/HYjZFaKYxN2Sghki7IFXr+woysx+rXZ/A0eIk8hqNB8Yebylzfjt1QK0Fvn/gpPM/g==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7-v6mr4370191plb.129.1529004112702;
        Thu, 14 Jun 2018 12:21:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id x5-v6sm8604505pfh.67.2018.06.14.12.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 12:21:51 -0700 (PDT)
Date:   Thu, 14 Jun 2018 12:21:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/8] test-pkt-line: add unpack-sideband subcommand
Message-ID: <20180614192150.GI220741@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-2-bmwill@google.com>
 <CAGZ79kbThoJBriGOQnEBOr73NPKsz91x1W_ZgJLSi=hgYD5b+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbThoJBriGOQnEBOr73NPKsz91x1W_ZgJLSi=hgYD5b+Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Stefan Beller wrote:
> On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:
> >
> > Add an 'unpack-sideband' subcommand to the test-pkt-line helper to
> > enable unpacking packet line data sent multiplexed using a sideband.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  t/helper/test-pkt-line.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
> > index 0f19e53c7..2a55ffff1 100644
> > --- a/t/helper/test-pkt-line.c
> > +++ b/t/helper/test-pkt-line.c
> > @@ -1,3 +1,4 @@
> > +#include "cache.h"
> >  #include "pkt-line.h"
> >
> >  static void pack_line(const char *line)
> > @@ -48,6 +49,40 @@ static void unpack(void)
> >         }
> >  }
> >
> > +static void unpack_sideband(void)
> > +{
> > +       struct packet_reader reader;
> > +       packet_reader_init(&reader, 0, NULL, 0,
> > +                          PACKET_READ_GENTLE_ON_EOF |
> > +                          PACKET_READ_CHOMP_NEWLINE);
> > +
> > +       while (packet_reader_read(&reader) != PACKET_READ_EOF) {
> > +               int band;
> > +               int fd;
> > +
> > +               switch (reader.status) {
> > +               case PACKET_READ_EOF:
> > +                       break;
> > +               case PACKET_READ_NORMAL:
> > +                       band = reader.line[0] & 0xff;
> > +                       if (band == 1)
> > +                               fd = 1;
> > +                       else
> > +                               fd = 2;
> > +
> > +                       write_or_die(fd, reader.line+1, reader.pktlen-1);
> 
> white space around + and - ?

Will fix.

> 
> > +
> > +                       if (band == 3)
> > +                               die("sind-band error");
> 
> s/sind/side/ ?

Thanks for catching this.

> 
> What values for band are possible?
> e.g. band==4 would also just write to fd=1;
> but I suspect we don't want that, yet.
> 
> So maybe
> 
>     band = reader.line[0] & 0xff;
>     if (band < 1 || band > 2)
>         die("unexpected side band %d", band)
>     fd = band;
> 
> instead?

Yeah that's must cleaner logic.

-- 
Brandon Williams
