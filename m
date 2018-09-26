Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972671F453
	for <e@80x24.org>; Wed, 26 Sep 2018 00:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeIZHJa (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 03:09:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45321 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZHJa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 03:09:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23-v6so4717532pfi.12
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 17:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cx83MUd+o7fw9YCfqrexQdmDBxvpdG3eiGxXo+7cL+E=;
        b=r7va3V/BD36eE4iYOyc5+bvYk4bueYlNxPUQJAVsotQebsZySugirfnlpD+reUDIpn
         Zld2LRdmJC11hQYquYD/iqWhvl0ExOXgXbuLq4/wlhCmoDZFF7mLx9d2NCYzYP6DO5Lk
         g2vHz+3IbdD/AAY5hCXxHTijbhfEGMtTqHqYQwIIRO+0dF3fKwY9f0ecY7lhmvRPuHiz
         opc612Cm/aCyUHLZYBKke2gzfFvy2TkJVlfeNW3jqctUzJyHxXWmkmMw1kUIkj4KV7Cv
         B+CnBFFjqHKwN46THi24lYSogfQiV1V+aNpEbW7vqJzubCoV3IZUC12X/d/wUf/nVgkM
         ARDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cx83MUd+o7fw9YCfqrexQdmDBxvpdG3eiGxXo+7cL+E=;
        b=TCn79rhbWZdCloFCvLVF3RuqrCblAzJIVqWcbFZrAI9Mo45oxaSOAsl1621OsIzhUs
         wa1DpKQpCjNb7ERrZ6zCaXMXQ/OIHiui8jdl2fV8MRQp2x/zCYn65Vwjxdl16acVzZX0
         QgRrwye2a0h6QRNm+sKP/h786XxvE/DheCX82cZoxNg+HuDD41NE7BksFAyWIj9sB2TO
         xZ7mi7OigJfrlRkDIhQNA6pymlQmLyIeJoXApp1Fo+RTJyivlUt/1X8wn68q6rvJDYOa
         +yMj0b0bsESjXK9poHzYmgnkhzT/VQ0xyM3MI82GTH0gGPDvgBunwLC4WBCKtpnWiGYH
         kLrg==
X-Gm-Message-State: ABuFfogfrNl/BBuFe9bLltaQ7EZdumSkp3G0bqHfOyRHXZgr28evvPQd
        lkQDmryBGJ8u2VCFMaDnF7NcAZlkO69kXA==
X-Google-Smtp-Source: ACcGV63yqHbR8tVLCtjsMPALivWxZSyjgkm3zp/vmwJZHVaESr+POWJbCAe2r7MoK6Eb0D5Cbojreg==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr3189014pgc.351.1537923557208;
        Tue, 25 Sep 2018 17:59:17 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id z7-v6sm7003986pff.146.2018.09.25.17.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 17:59:16 -0700 (PDT)
Date:   Tue, 25 Sep 2018 17:59:14 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180926005914.GI4364@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <CAPig+cSx0vxegy+ENtiYgV=x-A=0upFZGuFbW-=cwwknko_f4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSx0vxegy+ENtiYgV=x-A=0upFZGuFbW-=cwwknko_f4A@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 04:18:03PM -0400, Eric Sunshine wrote:
> On Fri, Sep 21, 2018 at 2:47 PM Taylor Blau <me@ttaylorr.com> wrote:
> > When in a repository containing one or more alternates, Git would
> > sometimes like to list references from its alternates. For example, 'git
> > receive-pack' list the objects pointed to by alternate references as
> > special ".have" references.
> > [...]
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > @@ -0,0 +1,54 @@
> > +expect_haves () {
> > +       printf "%s .have\n" $(git rev-parse $@) >expect
> > +}
>
> Magic quoting behavior only kicks in when $@ is itself quoted, so this
> should be:
>
>     printf "%s .have\n" $(git rev-parse "$@") >expect
>
> However, as it's unlikely that you need magic quoting in this case,
> you might get by with plain $* (unquoted).

Yep, thanks for catching my mistake. I rewrote my local copy with "$@"
(instead of $@), and also applied your suggestion of not redirecting to
`>expect`, and renaming the function.

These both ended up becoming moot points, though, because of the
Perl-ism that Peff suggested and I adopted throughout this thread.

The Perl Peff wrote does not capture the " .have" suffix at all, and
instead only the object identifiers. Hence, all we really need is a call
to 'git-rev-parse(1)'. I doubt that this will ever change, so I removed
the function entirely.

Thanks,
Taylor
