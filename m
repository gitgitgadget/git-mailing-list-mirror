Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4FB1F454
	for <e@80x24.org>; Fri, 21 Sep 2018 17:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390742AbeIUXrm (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:47:42 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50810 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390566AbeIUXrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:47:42 -0400
Received: by mail-it1-f196.google.com with SMTP id j81-v6so2963348ite.0
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z10TzjldgJibz2yONzYPopjWenRt7akM0aROPN5ZAl4=;
        b=x5ZUEEcNPfBsPQln82G6c8ZUmpJwYZcUr5RTik9gWS81yuQl5ZUzkSYxTRm3gNdo60
         /mh1t4UrrUoJa7G+bBLaqlCmm+Qm6I0fYUcSW4e0CKKLPucZC0sxutl6PTFvh3AUyiWK
         e+qWXw4DHamFQJglxqL9GfLIAl+oDqm9xHdPDqF9v7im5CBz1rpX+Ne1AgUyRUIguAf+
         dDRKl6WFUdHKcRHrFNyj0nGjUMqtOMawRp3kEvcuxAFiEDbJ1Ixnl/J3sXhMUcruTDaO
         /OGmqpVEu7eTDS1uzX/NwLrFHFjwcjy0psjJD8DuM1t3UMcZJQedMCISGugY+DGVvyfq
         07pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z10TzjldgJibz2yONzYPopjWenRt7akM0aROPN5ZAl4=;
        b=W5dJgHgAH9oVt68W0g8FIyGJGhez7fOFCAH1KXLKZyO4M23NBbtLtZbV3cLXFjSUgo
         uXOIbY+Vo8g8FNVZvkQeYPHrewjbF+z0eO8DSUnKNuscPiQrZmywPYZLa/aARXoBYcxK
         REVWmsTZN5yoclm+6cehA+wa3Jmnvvv1PnejqBJaCaeS1D1C+xMfWiI7ZQ5ICAX5k53L
         LkDpVYD/+yYW1uO9pdH7sE1FekN3cuj2qqa9qkumoCg/MvoD1d2tkVxS7RYqutuNzb7G
         YvG/woT82vz2aUXnJ0dBs/4vcMJ83US3JaxrWPARDY9/vYNAxcTxj4wg5OGgoRll2wRJ
         amqA==
X-Gm-Message-State: APzg51DUP6fT/0FVy99V/RLJZgu1m4kd9jfDQZfRiKABKs6a0qT81zcG
        ecb8Kn7O/ZIH4lm/sXrE6cPoTA==
X-Google-Smtp-Source: ANB0VdbUuChTER0IdroHpOzB1m2GBEevX7lottUO2TpKE+WGUogxUCl1Xr31nazB9LGNU+7rRmvyTw==
X-Received: by 2002:a02:952a:: with SMTP id y39-v6mr42234599jah.60.1537552662422;
        Fri, 21 Sep 2018 10:57:42 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id q10-v6sm9773623ioh.64.2018.09.21.10.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:57:41 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 21 Sep 2018 13:57:39 -0400
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180921175739.GA21514@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
 <xmqqlg7ux0st.fsf@gitster-ct.c.googlers.com>
 <20180921174825.GA17718@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921174825.GA17718@syl>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 01:48:25PM -0400, Taylor Blau wrote:
> On Fri, Sep 21, 2018 at 09:39:14AM -0700, Junio C Hamano wrote:
> > Taylor Blau <ttaylorr@github.com> writes:
> >
> > > +extract_haves () {
> > > +	depacketize - | grep -o '^.* \.have'
> >
> > Not portable, isn't it?
> >
> > cf. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
>
> Good catch. Definitely not portable, per the link that you shared above.
>
> Since 'depacketize()' will give us a "\0", we can pull it and anything
> after it out with 'sed', instead. Any lines that don't contain a "\0"
> only contain an OID and the literal, ".have", and are fine as-is.
>
> Something like this:
>
>   extract_haves () {
>     depacketize - | grep '^.* \.have' | sed -e 's/\\0.*$//g'
>   }
>
> Harder to read--at least for me--but infinitely more portable.

In fact, I think that we can go even further: since we don't need to
catch the beginning '^.*' (without -o), we can instead:

  extract_haves () {
    depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
  }

Thanks,
Taylor
