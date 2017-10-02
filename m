Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845B3202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbdJBFXa (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:23:30 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:45256 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBFX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:23:29 -0400
Received: by mail-pg0-f48.google.com with SMTP id 188so2451538pgb.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6tSaQU/gTN0xfIKnRV3GV1VunMq7SHJ8ldSiCsCZaDY=;
        b=fRzkw4xjPY6ZDlHGPwWjfXWpfPH2ZhWgWLwVbWM0CBUlcnv6qj1xWx43FE0SdFwTGc
         wFm19tNQzHvX3EV9CU2ky+qGx3WR28qqt/p38JYVbBDE8qWKzmb0NKn+nn+XDyOp0kss
         ndCye+OCVmUJkUqzGTh5EqP4LD2vl96VxQwqd2XgKv/aB4D/2BKqDM8ILb4XRPgQrU+3
         16t7eip0w9GrQZIslRJkFmScWE1qh+bSoyJHUBvhNs15QgqRugQbhH4a8UMl/WE1y8JO
         Mb9FzhA3VfRhdrh6qzyNXmIu6CkMHzBxzyCEhqBLlj2TjeF5K+TKecEySRQ0+6E2Ul5r
         kpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6tSaQU/gTN0xfIKnRV3GV1VunMq7SHJ8ldSiCsCZaDY=;
        b=pwxqou+H38zagfN/7YejTB4xektClxjy5WtZwqeATb7I9gMYORQIlzARSCFMJXoFfx
         /OCTz7xpHogoqfVMJ/B+NYsyuP2ZxWJQib87wY+Fpi1oasrcaLM0YkO9Dvy6ZJzXeDho
         dCmtOaujEYTvTh8n/oYZKqqAmnIOcwAOiB7L6VZ3F6v32rzwbzSEY6Yl6H/oh7wBO3iX
         b0BD2x0n3wkzl5h2Homz5Y08X4X7RD1hRontjeH3HgTUTQ8NmcvrGQ5SzI9KP+kJB1us
         m6PWPVlzn2jXBqY8N4qnbXU0pGq3HvNZKKP63LAklVjaeoQ5FqyNXhgzOhulQfSAXtIQ
         xBtA==
X-Gm-Message-State: AHPjjUhn1PuWs4An1EFtTGKvq9drL8/PqLFKDMr3IanNR2IZ+mZzzqV0
        3PFhbKJY/bUJq8/r6klzdfXEILAtXW4=
X-Google-Smtp-Source: AOwi7QBhKI34fUqcnQjKCI9nzShEoRLt4CYgkBznuBD1+1wM6RVpfT61ecvrF0UgJ22u+/UhXLuS0g==
X-Received: by 10.84.173.228 with SMTP id p91mr13566753plb.264.1506921808748;
        Sun, 01 Oct 2017 22:23:28 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id x19sm4322501pfi.173.2017.10.01.22.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:23:27 -0700 (PDT)
Date:   Sun, 1 Oct 2017 22:23:26 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v6 0/7] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the sixth revision of my patch-set "Support %(trailers)
arguments in for-each-ref(1)".

In includes the following changes since v5:

  * Added an additional patch to change t4205 to harden `unfold()`
    against multi-line trailer folding.

  * Added a missing parameter call in ref-filter.c to
    `trailers_atom_parser` through `contents_atom_parser`.

I believe that this version of the series should be ready for queueing.

I am going to address Peff's follow-up for teaching
`parse_ref_atom_filter` to accept "empty" argument lists as
`%(refname:)` in a follow-up series later this evening.

Thanks again :-).


--
- Taylor
