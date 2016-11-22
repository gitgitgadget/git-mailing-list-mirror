Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E051FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 23:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbcKVXzB (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 18:55:01 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35920 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbcKVXzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 18:55:01 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so12514229pgc.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 15:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=svIFZuvKrZLd/0bmdQnHx5fPJgkbMCnZ+u8l6YvGlWQ=;
        b=Il/S35vbGyQAS0W+aXpxPb2QnOHqjOXMGZnx6iunIX9aBwky7QVJUzEFeo2jfErWNJ
         xEF3vS1NZRY/KVVb+74jOG2U5E/kYH+el9/V9Cj4b4Nte865MzY6GPwBR+uxck3eqVZW
         Y72SGqMT6Jqm76vR/Ntx25QR477UtvnMR+wjGaEu55gJNQ3Z/W6Jz4NLmX4caQq57MdF
         AqhfizpK7K6JyUHRPHcUGEjp/IxboRFITcOvPbumQyHlad1IaLS9gDlZIasidcps1vSO
         7USLV1AcYMbhG1RpxXEh9G/tDivDyP3atd9Y0cpTHXe94S2ljUsJJ726Il0lI0874FWy
         BcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=svIFZuvKrZLd/0bmdQnHx5fPJgkbMCnZ+u8l6YvGlWQ=;
        b=DDCRuYcL75GkHbScHPLlt+UbFFDc2o+5nkNyuEOWk04uiHQ923kgZdxCeHNrdtj3fX
         d+Z8Q6HDGPXb6YGar7YrzjbUWp1IFlJDRCw6N6xY8SJLCRyxvCB593fU3ycKTDD3DRq3
         RE2b5cR/6fVSxQJ2TFihZiEftspokHdPUOTJpnQbCatpmuWvyiseL1jXzBE9+LOyOlW1
         mXRomZy5VhLmcAokq3fVQ2mhQbrvewkyTkCFwerFRsbz80chB+78zQkv7TV6R7vnCyoA
         nf2ao7AAG7aup3gZY/HURxtciQFODTvbnRPSMGtxkp08aUUtgkXX8QFi/2NNiHzU3fh9
         6TFg==
X-Gm-Message-State: AKaTC005mR9A/PfFXSK4UD8D1V+ep5FpExQxGavMy0zC/MpjwQZEtWe9PotEApRqVgXS3owf
X-Received: by 10.84.143.68 with SMTP id 62mr552780ply.63.1479858900280;
        Tue, 22 Nov 2016 15:55:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a049:6e3d:16a5:8086])
        by smtp.gmail.com with ESMTPSA id w17sm29646994pgm.18.2016.11.22.15.54.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 15:54:59 -0800 (PST)
Date:   Tue, 22 Nov 2016 15:54:58 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161122235458.GE65825@google.com>
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1479840397-68264-6-git-send-email-bmwill@google.com>
 <xmqqshqjnmtc.fsf@gitster.mtv.corp.google.com>
 <20161122232105.GC65825@google.com>
 <20161122232815.GD65825@google.com>
 <xmqqk2bvnl1e.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk2bvnl1e.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> > So this change may have an impact on "git ls-tree -r" with pathspec;
> >> > I offhand do not know if that impact is undesirable or not.  A test
> >> > or two may be in order to illustrate what happens?  With a submodule
> >> > at "sub/module", running "git ls-tree -r HEAD -- sub/module/*" or
> >> > something like that, perhaps?
> >> 
> >> Maybe unrelated, but it looks like wildcard characters are overridden in
> >> ls-tree.c per '170260ae'.  As such wildmatching just doesn't work with
> >> ls-tree.  so `git ls-tree -r HEAD -- "*"` results in no hits.
> >
> > Wrong commit.  Its this one (f0096c06bcdeb7aa6ae8a749ddc9d6d4a2c381d1)
> > that disabled wildmatching since it is 'plumbing'
> 
> OK.  Things that share tree-walk other than "ls-tree -r" are still
> affected, no?

Yeah potentially, though I'm having a difficult time finding a case that
would actually be affected.

-- 
Brandon Williams
