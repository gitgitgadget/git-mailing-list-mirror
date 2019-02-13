Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F8B1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436951AbfBMVsu (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:48:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43313 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBMVst (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:48:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so4225597wrv.10
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 13:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vcEivfl5yD5vq1XYTkJcMUCA0VjXiB5WW8pEQG8LrMQ=;
        b=WwPYN7f7Jr+2AUm4PepfApt59tFZ2UedkVaQ+0qwBevc/nrYm7efVf48fEo1LJD/N7
         TyS0ziBoYyqYUASbV4JIxbO56WPqp3dseOgtar5BPI0HT0y3egUtL2vPmLTkIdFrmgeY
         FvcU1dUyEfI5k7MwfMCQYCLw0Htjfh88ek0YS1dXizz1IBBwffYy/vE7CMOnN5TIM7Tn
         xCXB6ddgkjYYuRNxutVtjm2zM6dXOxmJ2dF3lus4+4NDeqLIzzwiKZC5azaEu7dFXnP5
         X+Qd75CWO/iWqQKAx2KUsMQJwX/yzT9gD5yGAwvw/hLhEWQX/A/pXMPI4CVRgKgCDM/G
         EHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vcEivfl5yD5vq1XYTkJcMUCA0VjXiB5WW8pEQG8LrMQ=;
        b=Vt8tfzk/IrflJcV5pOxd/3cF7RTjsJerJeRXy30ugB8a1A+ScMr+ak/8lh8EgiQ+Xk
         c/wi7lH6T6vU56mVO7u3rV8V412x7HBBwu+6Pihq6W1dwY3D53OQyukYeZrDjynI4tVG
         0tAhFokyxBaPhWQ1f3sM7Fyd58vm3JbCnW9s9+tNlrQetDHcnwdAZIdqiz6hazjLXfXr
         cXcLTwkLltwkFlm0HV9DC8YCfmWKTp/gebVRAgsBFlPRnLDqHbbjigsyohGOQ13s/c44
         yCmIv3HB3gi6Ng4yY2T0vYX7nUauHGmJahXwPFLV8AsDdw+0bzbNRclUcyUFxPogELXI
         StsA==
X-Gm-Message-State: AHQUAuZ8j6W4PYHBNu1dNTOZHlwoJj6eRtIospbl509o6KE0z87z8y1T
        WyVAGgSczUqAio1cxR1MNrw=
X-Google-Smtp-Source: AHgI3Iahbgub+vpo2rWL56IieuYk2Dcc0iCZYfu6IUgP31zqI2CJnVtEV0x25uCOdu1P0sH8LT4FrQ==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr160980wrw.87.1550094528001;
        Wed, 13 Feb 2019 13:48:48 -0800 (PST)
Received: from szeder.dev (x4dbe07c0.dyn.telefonica.de. [77.190.7.192])
        by smtp.gmail.com with ESMTPSA id c65sm696810wma.24.2019.02.13.13.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:48:46 -0800 (PST)
Date:   Wed, 13 Feb 2019 22:48:44 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, hsed@unimetic.com
Subject: Re: [PATCH v2] tests: avoid syntax triggering old dash bug
Message-ID: <20190213214844.GI1622@szeder.dev>
References: <xmqqo9a9stbs.fsf@gitster-ct.c.googlers.com>
 <20190213115951.12096-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213115951.12096-1-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 12:59:51PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Avoid a bug in dash that's been fixed ever since its
> ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
> released with dash v0.5.7 in July 2011. This failing test was
> introduced in 5f9674243d ("config: add --expiry-date", 2017-11-18).
> 
> This fixes 1/2 tests failing on Debian Lenny & Squeeze. The other

Do I understand this "1/2" right?  There are two tests failing on
Lenny and Squeeze, and this fixes one of those bugs?

> failure is due to 1b42f45255 ("git-svn: apply "svn.pathnameencoding"
> before URL encoding", 2016-02-09).
> 
> The dash bug is triggered by this test because the heredoc contains a
> command embedded in "$()" with a "{}" block coming right after
> it. Refactoring the "$()" to e.g. be a variable that was set earlier
> will also work around it, but let's instead break up the "EOF" and the
> "{}".
> 
> An earlier version of this patch[2] mitigated the issue by breaking
> the "$()" out of the "{}" block, that worked, but just because it
> broke up the "EOF" and "{}" block. Putting e.g. "echo &&" between the
> two would also work.
> 
> 1. https://git.kernel.org/pub/scm/utils/dash/dash.git/

Could you please link directly to the commit fixing that issue?

  https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=ec2c84d3c4dba4b74440d72bdd1de416a9acd2a9

> 2. https://public-inbox.org/git/20181127164253.9832-1-avarab@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
