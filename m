Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932FD201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdEPEjp (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:39:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35668 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdEPEjo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:39:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so18435151pfd.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OUW+hhJKotKhYV9FHU2VjJUGeSQZCCa9m/jGzLJV74E=;
        b=BNAyqbw6GZYSop6HGDMknvW083q15o4y4Rs6cUWJS1oJAACNMFqdKQgn+qOLhr4TkM
         ww93LiJH8fogJV521VQy2fU0O8Q983vYZvJraYR8Zjkzo/u7rnAJo88pNdqv8qSyEzpN
         EZgZTO6mt1uvKnuevP2KokZyVWrCYYYEkYfCYAwNSWvNRTmzUCfb/GyIir2nCIEjwX3K
         1HEfYd32y6Lyac8EH0hLqoJCIFoaespoZR+wXuGWg/xoSPMhN//HON+OAhTsshJCc2Jo
         tMou+k2G3D0METm4xS53d/Rn3OBXHuQk4Yc9jvnTUyjv9v+xhH4rc3A9FIYyqT/SownF
         /eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OUW+hhJKotKhYV9FHU2VjJUGeSQZCCa9m/jGzLJV74E=;
        b=cWJ6m72IeLEjNsri10k6yzCKio4qZNzsQJutmKjnEE/6QGXc5yGRpz7g/Nl8vI+IW6
         Zp33GbVqaMxh9DwIjFclP7wUbqFr1Nw54/+AxmZ8TQwBphZY1F/tMOgc08x0Z7W29xAb
         x3ruk52GXqn3TSMFzbqw+nwrL5/V3o2wc0FwJlo5nIw4xUlb4Opr5uztl9Ckv2PYdaFv
         Wm79LzC015REF+QUFoYVmX9BOj2BwtguO3jP5uiVu04xA38P602/654mGEV9I8RG7Z92
         M0VAEoak1NzBvzSaR6eVreo1YgbJRt7qxsDqdHzmBvn3NOkK7TlpVQ2hpAUZ7xWjwoM2
         NOdg==
X-Gm-Message-State: AODbwcBr7LsvDWqdD9lOt45X+gTQe1ol3OrhQpQxeNgVhFYhqMhCzDxx
        nvAWpXGHGsZ1PQ==
X-Received: by 10.98.204.130 with SMTP id j2mr10029231pfk.107.1494909583612;
        Mon, 15 May 2017 21:39:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id 26sm22674991pfn.43.2017.05.15.21.39.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:39:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 3/4] add--helper: implement interactive status command
References: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
        <1494907234-28903-4-git-send-email-bnmvco@gmail.com>
Date:   Tue, 16 May 2017 13:39:42 +0900
In-Reply-To: <1494907234-28903-4-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Tue, 16 May 2017 01:00:33 -0300")
Message-ID: <xmqqinl12z5d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> +	if (!q->nr)
> +		return;
> +
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p;
> +		p = q->queue[i];
> +		diff_flush_stat(p, options, &stat);
> +	}

Commenting just on the part that interacts with the diff machinery,
without/before carefully reading the remainder of the patches.

I suspect that refactoring this part out of diff_flush() into a
helper function "compute_diffstat()", like this:

diff --git a/diff.c b/diff.c
index 74283d9001..a42ff42e92 100644
--- a/diff.c
+++ b/diff.c
@@ -4770,12 +4770,7 @@ void diff_flush(struct diff_options *options)
 	    dirstat_by_line) {
 		struct diffstat_t diffstat;
 
-		memset(&diffstat, 0, sizeof(struct diffstat_t));
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_stat(p, options, &diffstat);
-		}
+		compute_diffstat(&options, &diffstat);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)

and then exporting that function and "struct diffstat_t" to your
helper, may make it a better API, rather than having the callers to
call diff_flush_stat() for each and every path.

