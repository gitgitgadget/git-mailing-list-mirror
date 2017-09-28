Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7132E202A5
	for <e@80x24.org>; Thu, 28 Sep 2017 12:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbdI1M7Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 08:59:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37831 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbdI1M7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 08:59:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id u48so1972727wrf.4
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dkuSii6yY15E++06V+5DOjSpSvEXpv0ZBm1erlqDhYI=;
        b=TCtuYRiU3m+QXiU9wQ5KO7kjl1VqjQo+krDKk/wihJboIVvLlm4rlABH0T9oIjTnP2
         LX2+QzEciviSDg1AD9mKzebNOqMfmlgZ7NH1kqYta7VOzszAyPaSGEEXDAktLNyLV5sH
         zba7RsGRcv1GYJ6MBueWRrt+LVdmearWlDzRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dkuSii6yY15E++06V+5DOjSpSvEXpv0ZBm1erlqDhYI=;
        b=PsT67iZ+Z0+4TjLWhjEgnDGzT8IsZ2l+LtQhHod8LGPznfteott1fCLFXeUi/DKvmh
         si0tDYfqcbsD9zvYs5jmF+5vcFstFG2U5owQhzS+qhvp37rPg7QJaARglaJjZaNmmZwR
         euGAJ5CYg/hJxPpPT9gWheKxmCDRN1fhTGtEiXW+ocWjmmjg8vIwRsnQJ3cZ697JYj8I
         zdu3R9zl0Cl08MtC7WeH7ZZ6lDaTKglNRxn4O/om0HPD6Jtw155/BXa2I5zln2l8m1HR
         iRU0XMpAkAkMUdDirAi3RXsJT7dZ8nFogGebdsmEX812SlOWJAWYV/hOO1vAZe8gRu7j
         ZyaA==
X-Gm-Message-State: AHPjjUgn/y57vQgtE88n0femOOOBwK3tlFe6NRq3DjcR/sAB6LcRfRqf
        N6zuWHoVsahFqyRDvu0ZDP8xsQ==
X-Google-Smtp-Source: AOwi7QDa4di++3YIJfCHWQtQKwelC4xnFp7Ws7vy7Wg7CBp+cspx7wpvMk5ZNnHCaFZ9XVVTxKJMZw==
X-Received: by 10.223.155.157 with SMTP id d29mr4610171wrc.24.1506603559416;
        Thu, 28 Sep 2017 05:59:19 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id w2sm2067775wrb.67.2017.09.28.05.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2017 05:59:17 -0700 (PDT)
Date:   Thu, 28 Sep 2017 13:59:16 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Eric Rannaud <e@nanocritical.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jeremy.serror@gmail.com, "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/1] fast-import: checkpoint: dump branches/tags/marks
 even if object_count==0
Message-ID: <20170928125916.GB9439@dinwoodie.org>
References: <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
 <5b6001e7db3c57fdd9e6354ed4294e2192524061.1506574951.git.e@nanocritical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6001e7db3c57fdd9e6354ed4294e2192524061.1506574951.git.e@nanocritical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 10:07:41PM -0700, Eric Rannaud wrote:
> The checkpoint command cycles packfiles if object_count != 0, a sensible
> test or there would be no pack files to write. Since 820b931012, the
> command also dumps branches, tags and marks, but still conditionally.
> However, it is possible for a command stream to modify refs or create
> marks without creating any new objects.
> 
> For example, reset a branch (and keep fast-import running):
> 
> 	$ git fast-import
> 	reset refs/heads/master
> 	from refs/heads/master^
> 
> 	checkpoint
> 
> but refs/heads/master remains unchanged.
> 
> Other example: a commit command that re-creates an object that already
> exists in the object database.
> 
> The man page also states that checkpoint "updates the refs" and that
> "placing a progress command immediately after a checkpoint will inform
> the reader when the checkpoint has been completed and it can safely
> access the refs that fast-import updated". This wasn't always true
> without this patch.
> 
> This fix unconditionally calls dump_{branches,tags,marks}() for all
> checkpoint commands. dump_branches() and dump_tags() are cheap to call
> in the case of a no-op.
> 
> Add tests to t9300 that observe the (non-packfiles) effects of
> checkpoint.
> 
> Signed-off-by: Eric Rannaud <e@nanocritical.com>
> ---
>  fast-import.c          |   6 +--
>  t/t9300-fast-import.sh | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 129 insertions(+), 3 deletions(-)
> 
> 
> Updated to include Junio's latest remarks.
> 
> Also adding the necessary PIPE prereq, as pointed out by Ramsay Jones.

Cygwin doesn't have the PIPE prereq; I've just confirmed that the
previous version of this patch has t9300 failing on Cygwin, but this
version passes.
