Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A0A209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 16:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdINQgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 12:36:49 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:49679 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdINQgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 12:36:48 -0400
Received: by mail-pf0-f182.google.com with SMTP id l188so564517pfc.6
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMtrOLU6iOf3o9wm8WN9uxMf7SMe+eLwn/dilHXTSIw=;
        b=HRFLpIqLMRhXM+bSqZmUMqG44OF41c4+Y660xHUSgzyxNLj/rVBXDYasBwgjDpf4e9
         hcVyRLBEqScwbjIEYEtJSVXVl9TA0/nuga/BF5utiFxjwrEFkYDW4WeUJNIxXGuduCYU
         azsHKmzVEa2veR/aZZVpCNcTbNFLOBZlDxgr+uxUAJGI7U8reZY8ssEPJfW2umU/I6eM
         ToQYxczYtr08PejsYWmsQsELWjb4jiyC5adVVcHVQBTbSniZHLfl5VwwfAFE9lRmzR7p
         RC3oGFxw9+mXZlfRClOz70myRJptyf4SDLAkErTpUTrNsEZkoaJpTDCE4fBPcFjq9jS7
         iZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMtrOLU6iOf3o9wm8WN9uxMf7SMe+eLwn/dilHXTSIw=;
        b=db+SlStprUTTDWi5xEBbdHc7UavweeFy96TauLclmfwJuTDyQ/aHkVsTBtd3N5yC5y
         5zUBvEnPWovX0jLM0tXBCSa23HEQZvHnlVR2gad8easiTaXdA5k36rPtyOaM0vXRuwVk
         GtOn/vt1LA+Sg3NvrmKzKQ5ryzedUbi5UgvXvBjFAyGIMcnBxIdI9JcdDuQBdTlbEwDe
         V4XY/oMpZg5K/cT1sDawChSO77AdY121VORviPpaGwV5en196V959LvRyru31iSB0W0u
         tfxftUpo5XyF/IIcXb3dVbHdesZ9Dxi1z9KMXg7fqMvoERp26XTVK78xHOs4uzfXZULN
         lIOA==
X-Gm-Message-State: AHPjjUgT3wPwyiM5yCUkg4Et0P2RlsYUS5y6qp5AaiDK3w9wVpNRx31w
        DfLxEZr0Y2U1hQTe
X-Google-Smtp-Source: ADKCNb7oV9HqXucC9+4CCwDbnDs0gwZBcExcKLu9iIgmB02dnmre/XN/hwiXYeQY+obPMO4ej0RO1A==
X-Received: by 10.98.160.29 with SMTP id r29mr22025583pfe.176.1505407007800;
        Thu, 14 Sep 2017 09:36:47 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:f57e:c43:82f1:1dc3])
        by smtp.gmail.com with ESMTPSA id s86sm6987027pfi.74.2017.09.14.09.36.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Sep 2017 09:36:46 -0700 (PDT)
Date:   Thu, 14 Sep 2017 09:36:45 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170914163645.GA111021@google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <20170913163052.GA27425@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709141119140.4132@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709141119140.4132@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/14, Johannes Schindelin wrote:
> Hi Jonathan,
> 
> On Wed, 13 Sep 2017, Jonathan Nieder wrote:
> 
> > As a side note, I am probably misreading, but I found this set of
> > paragraphs a bit condescending.  It sounds to me like you are saying
> > "You are making the wrong choice of hash function and everything else
> > you are describing is irrelevant when compared to that monumental
> > mistake.  Please stop working on things I don't consider important".
> > With that reading it is quite demotivating to read.
> 
> I am sorry you read it that way. I did not feel condescending when I wrote
> that mail, I felt annoyed by the side track, and anxious. In my mind, the
> transition is too important for side tracking, and I worry that we are not
> fast enough (imagine what would happen if a better attack was discovered
> that is not as easily detected as the one we know about?).
> 
> > An alternative reading is that you are saying that the transition plan
> > described in this thread is not ironed out.  Can you spell that out
> > more?  What particular aspect of the transition plan (which is of
> > course orthogonal to the choice of hash function) are you discontent
> > with?
> 
> My impression from reading Junio's mail was that he does not consider the
> transition plan ironed out yet, and that he wants to spend time on
> discussing generation numbers right now.
> 
> I was in particularly frightened by the suggestion to "reboot" [*1*].
> Hopefully I misunderstand and he meant "finishing touches" instead.
> 
> As to *my* opinion: after reading https://goo.gl/gh2Mzc (is it really
> correct that its last update has been on March 6th?), my only concern is
> really that it still talks about SHA3-256 when I think that the
> performance benefits of SHA-256 (think: "Git at scale", and also hardware
> support) really make the latter a better choice.
> 
> In order to be "ironed out", I think we need to talk about the
> implementation detail "Translation table". This is important. It needs to
> be *fast*.

Agreed, when that document was written it was hand waved as an
implementation detail but once we should probably stare ironing out
those details soon so that we have a concrete plan in place.

> 
> Speaking of *fast*, I could imagine that it would make sense to store the
> SHA-1 objects on disk, still, instead of converting them on the fly. I am
> not sure whether this is something we need to define in the document,
> though, as it may very well be premature optimization; Maybe mention that
> we could do this if necessary?
> 
> Apart from that, I would *love* to see this document as The Official Plan
> that I can Show To The Manager so that I can ask to Allocate Time.

Speaking of having a concrete plan, we discussed in office the other day
about finally converting the doc into a Documentation patch.  That was
always are intention but after writing up the doc we got busy working on
other projects.  Getting it in as a patch (with a more concrete road map)
is probably the next step we'd need to take.

I do want to echo what jonathan has said in other parts of this thread,
that the transition plan itself doesn't depend on which hash function we
end up going with in the end.  I fully expect that for the transition
plan to succeed that we'll have infrastructure for dropping in different
hash functions so that we can do some sort of benchmarking before
selecting one to use.  This would also give us the ability to more
easily transition to another hash function when the time comes.

-- 
Brandon Williams
