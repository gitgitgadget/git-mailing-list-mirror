Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2716420286
	for <e@80x24.org>; Tue, 12 Sep 2017 07:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdILHAi (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 03:00:38 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34517 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdILHAg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 03:00:36 -0400
Received: by mail-io0-f181.google.com with SMTP id v36so28043761ioi.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=1Ec5jSshmaNbCYAyMgf4QR9cBEfA+OcORtsD3oyfpWw=;
        b=r7xt2OuNO9FrScOR2spklkvxZ1qdrGLgj29FW8JM3WgLU+zNKvbhlhgtg1WZB3t4TZ
         /pg9Ysdfedxzh4obZtDmwdYwYZYITOoMORxYndwRd0usFMEPa2AagwYOJVGX5WV/qTNo
         gt9kbwerGHzJM2u8cTchL9xLWRZnjw/qMkXknAU1inxJbrX6XWCf67S/+3d0nEEYRCj6
         9Ye770dWxKub8YSLDgTAaL19IDu/i/jkQ/tM1xY+/sy1lB1JEcacgZ0OX+Cdm32tiAZZ
         pQyT7RWu+kCC9NGUI/qbxiR/YpE5dynsLUn5sewkBk6abPTFIR7APzuplDWrio3Y5C0N
         N+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=1Ec5jSshmaNbCYAyMgf4QR9cBEfA+OcORtsD3oyfpWw=;
        b=EJdWeflZB+awjb9uNnzKtDRBq6qHHf62b4Z5uUZqi3LH1bDYpYpIrSWvgSvSk+9UZe
         sF70wu0ebf0EKCV6K+wgYCjIHxCLCzlnuHtZ5aVI4Y/n2HHLjQ+lRQzqGtVpQ/1796Fb
         Vv2Gb8WlaC2R4iat7NGifNr8ZzotfmE6JBGXJ/T0bvGPC8fqJDGJPdEcCzKh3tpL3vlr
         GvzfznT51U3AZeetpRpPwnJjSHxLZRE2cvhWsAa8Q7XLUUBdSv3zLaR5kXWswH7cATBX
         sE4yhzTCitIhOuqWns6nHORcciuppgn3Li0+62m+AACtWZvkIwJhkRl2JeKpnTn3dwt6
         qwwA==
X-Gm-Message-State: AHPjjUgSRPz83l/5hMBhSAVrzUrbHpOS1RtSKNrKhaTJdXub38JE+xCG
        qlmalfXQkDaPceicKeM=
X-Google-Smtp-Source: AOwi7QCrxvYWPdRP9G2AxZyPns2emEvOd26LEwBNgkjCCl6mk8bERMy4D+P6L4F3fhtYYT3FfdybnA==
X-Received: by 10.107.179.139 with SMTP id c133mr4635603iof.281.1505199636271;
        Tue, 12 Sep 2017 00:00:36 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id z13sm5242598ioz.63.2017.09.12.00.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 00:00:35 -0700 (PDT)
Message-ID: <1505199638.2556.2.camel@gmail.com>
Subject: Re: [PATCH v3 1/2 / RFC] builtin/branch: stop supporting the use
 of --set-upstream option
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
In-Reply-To: <xmqqtw081kep.fsf@gitster.mtv.corp.google.com>
References: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
         <20170814085442.31174-1-kaarticsivaraam91196@gmail.com>
         <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
         <772aaebf-81ea-ac22-9d2f-35d0778f502f@gmail.com>
         <xmqqfucsr73w.fsf@gitster.mtv.corp.google.com>
         <09ce545a-31ff-aa9f-d03c-3cb68ed26230@gmail.com>
         <xmqq378rl479.fsf@gitster.mtv.corp.google.com>
         <1502935475.1710.5.camel@gmail.com>
         <xmqqtw081kep.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 12 Sep 2017 12:30:38 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-09-12 at 15:49 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > Thanks. Now I get it. What about doing that check in
> > branch.c::create_branch or branch.c::validate_new_branchname? I guess
> > creating a branch named HEAD isn't that good an idea in any case. Doing
> > the check there might prevent a similar situation in future, I guess.
> > Further "branch" and "checkout" do call branch.c::create_branch which
> > in turn calls branch.c::validate_new_branchname.
> 
> The above analysis sounds sensible, so it appears that you already
> found a function that is shared in the two codepaths, and have a
> good plan to make them consistent?
> 

Yes, I was just waiting for this reply. In the mean time I thought of
sending a patch for this but was procrastinating as I felt a little
lazy.

> I was sweeping my mailbox to collect loose ends that haven't been
> tied down, and noticed that this topic does not seem to reach a
> conclusion.  Do we want to reboot the effort?  Or should we just
> throw it in the #leftoverbits bin for now?
> 

Don't worry I'll send a patch for this, soon. I mean it :)

-- 
Kaartic
