Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B35C1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbdBPRt3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:49:29 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35903 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755133AbdBPRt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:49:27 -0500
Received: by mail-lf0-f67.google.com with SMTP id h65so2031248lfi.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 09:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7dOWsKraLSdvkE48S+XiLgu+TifAYEsbSrpL1tVCr3I=;
        b=Qp65t+SgZC37S1L4A/H1S3DBoiDgNtgtWUR7GOOddL+ua4z8cFYdQ3bmYgmAuy0F+w
         jzyd9iExuxHNXubxq/K3B9tKaJhH/NuoPrBsZ/X8o9/mAvTMY/X1ooPL0FUexrN7QS3Y
         vPFXYIvef5o67v/t0ndz9mW3t1Y8w/UW3X98R8t3jf7V0H4EKBkCFTghBgKrHlQFP2r2
         Sc/IFQc3B7RpmuDV5U4P9eByp4krd8kx11nFSVuU9bqvNs+Dc0bZLnu4OMxj4D739bDq
         Pw+CZdZhPo1Essz8EsysCZrSOGWWaqeY9Qr83reNYPoiLycpGKHTE3jqZK/7G5jO+951
         Jnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7dOWsKraLSdvkE48S+XiLgu+TifAYEsbSrpL1tVCr3I=;
        b=cwg4aZshwdu/JfxZWZksBVjkmNtVu1L0dRYhfXXPsCTddYMTMHjmFAlcaGyORxOEdS
         9x4oAneuj1Vnnf/SKTHi1LGblZh9waX01+r6gGmSD0BHdaqfWIflk4bLUIMAX0gKFOfS
         Fz8KrmF50MOLaBM9GD8/R0FHm3A3vzhDhZW3smLSylRJiKk7ZV7Et89YECKfOsidRvns
         b/bxah/Qbq8QZpE6K5/Hxhjc2R7RQNdp8AQInslrT7AAgws2x5kRvazbdz28xbn4UhTZ
         JwIpXTkEwcMgd9oXGj2qzAHNM9rb+JJnWF8/SNjWop0wqVwMvnUZeA5rqvQrxaPsw0gx
         1Xjw==
X-Gm-Message-State: AMke39nwljQsT8qrfKMyEb8HLh+ppkcwkYrVbNOMwszcjBYFQ1z/Ee4x1e/Qi8NuN7diLA==
X-Received: by 10.25.74.72 with SMTP id x69mr1104995lfa.66.1487267366038;
        Thu, 16 Feb 2017 09:49:26 -0800 (PST)
Received: from xi.terra ([84.216.234.102])
        by smtp.gmail.com with ESMTPSA id v21sm1891339ljd.9.2017.02.16.09.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 09:49:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.88)
        (envelope-from <johan@kernel.org>)
        id 1ceQBI-00046E-Mb; Thu, 16 Feb 2017 18:49:25 +0100
Date:   Thu, 16 Feb 2017 18:49:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: body-CC-comment regression
Message-ID: <20170216174924.GB2625@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently noticed that after an upgrade, git-send-email (2.10.2)
started aborting when trying to send patches that had a linux-kernel
stable-tag in its body. For example,

	Cc: <stable@vger.kernel.org>	# 4.4

was now parsed as

	"stable@vger.kernel.org#4.4"

which resulted in

	Died at /usr/libexec/git-core/git-send-email line 1332, <FIN> line 1.

This tends to happen in the middle of a series after the cover letter
had been sent just to make things worse...

I finally got around to looking into this today and discovered this
thread ("Re: Formatting problem send_mail in version 2.10.0"):

	https://marc.info/?l=git&m=147633706724793&w=2

The problem with the resulting fixes that are now in 2.11.1 is that
git-send-email no longer discards the trailing comment but rather
shoves it into the name after adding some random white space:

	"# 3 . 3 . x : 1b9508f : sched : Rate-limit newidle" <stable@vger.kernel.org>"

This example is based on the example from
Documentation/process/stable-kernel-rules.rst:

	Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle

and this format for stable-tags has been documented at least since 2009
and 8e9b9362266d ("Doc/stable rules: add new cherry-pick logic"), and
has been supported by git since 2012 and 831a488b76e0 ("git-send-email:
remove garbage after email address") I believe.

Can we please revert to the old behaviour of simply discarding such
comments (from body-CC:s) or at least make it configurable through a
configuration option?

Thanks,
Johan
