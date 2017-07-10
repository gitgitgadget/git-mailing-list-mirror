Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33C92035B
	for <e@80x24.org>; Mon, 10 Jul 2017 23:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754966AbdGJXm4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 19:42:56 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33571 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754888AbdGJXmz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 19:42:55 -0400
Received: by mail-pf0-f175.google.com with SMTP id e7so57427896pfk.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3SHQVPMnKGxwp1Hd52YsnrTD4sNSS5wkgt/NMSLsLjg=;
        b=nn1+pS1w+Ia4yWUh9SYIyMXInHrfKwVIrflv9xSUO/WPdA8s5UsvivRB9M9ypZwIa7
         ECS1vvbQgtD8IxZaaaaTn9yq4LLotnZbSwwfF5GyzBi6xzIc2Hk6krCBWRCzgxQkTOa0
         XuGARXi9nNyIM+niRlAUL/jhBD0ISYTRFAW2xzPmzK0Th2ke3qL+aAg/6yqe59zW/OPh
         SOg6cksi+0YVHpAXqhmSNPSKd1uTmdS3PKEllkGW18lPv4mNgNWXdDMbhyweXhhJ0DLR
         0/al8AXFrEuQ9QCpiOEO26iGlXOVGU1Fqh16wd3sNpJQoy2Hdyg22wRVv6PQlO0EpIxd
         tw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3SHQVPMnKGxwp1Hd52YsnrTD4sNSS5wkgt/NMSLsLjg=;
        b=QbY9JKNKDVFAn/bqtcpuZKUx509KPzLHU5Wv9bfEmQ8HaTQ96CUjNSAQ/iSLngAPrH
         9FD0aUQsHdAff5TDbgNcRJvCZUxCB5AR5xxA7aSzeEgW7rT/tSWWmopPc7bD3Yh6tVM5
         ffgdVJVez4Mmnh8hZcXdl9wS6NnGMADJ8Sw6kZM2961K9R2bk11okDaBbrwUKvVWh9Gt
         YWgsVXPqrkLgVzFOF839HKbpkAxomCp9u5RBUHBjkg6clilDxj/OMMN7xF2dIZv2yLvF
         7+QM8snaqB8GP1JgWiPmxovgLeKhhzR6ID4TunAvD+LnRzHVByDYKlau15quWd3we4fW
         LzXw==
X-Gm-Message-State: AIVw110Dhq1ApoApsp3zc0D3D9nYQSmmBa9z727kFjUUZ/BPuvQ4ODou
        dmmiX6Bb1gEtrN4g
X-Received: by 10.84.177.131 with SMTP id x3mr20078879plb.83.1499730174717;
        Mon, 10 Jul 2017 16:42:54 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c8d3:611:f474:c770])
        by smtp.gmail.com with ESMTPSA id v64sm27370519pfk.126.2017.07.10.16.42.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 16:42:53 -0700 (PDT)
Date:   Mon, 10 Jul 2017 16:42:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH 1/8] submodule--helper: introduce
 get_submodule_displaypath()
Message-ID: <20170710234252.GF161700@google.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
 <20170710225407.29344-1-pc44800@gmail.com>
 <20170710233247.GC161700@google.com>
 <CAGZ79kYpFHkkhdkwYXEnQiWfuRONurintje575YVLE-ZVVRvzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYpFHkkhdkwYXEnQiWfuRONurintje575YVLE-ZVVRvzA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10, Stefan Beller wrote:
> On Mon, Jul 10, 2017 at 4:32 PM, Brandon Williams <bmwill@google.com> wrote:
> >>       if (!is_submodule_active(the_repository, path)) {
> >> -             strbuf_reset(&sb);
> >
> > Is this line removal intended?  It doesn't look related to the rest of
> > this patch.
> 
> It is, as &sb is re-used and has to be cleared first.
> With the code above removed, &sb is unmodified since
> struct strbuf sb = STRBUF_INIT; hence the removal is ok here.
> It is related, but only when looking at the entirety of the code. :-/

Ah I see. Thanks!

-- 
Brandon Williams
