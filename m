Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4AE01FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 16:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971373AbdDTQ6a (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 12:58:30 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35518 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971354AbdDTQ63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 12:58:29 -0400
Received: by mail-oi0-f47.google.com with SMTP id j201so58886374oih.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lWKOJk/w+Z1cA3XJbkqmbl6FP31BnTiqqdE5uCiWewc=;
        b=Pyig9I9Ac6gw5GHE6F31IjBOXnbegqu8B4gHLzBNdmBDdFV3u2r1glP/o2RB0mvlgd
         Dm+Bk5d9MOT8o3tct+PWoztZT5bHWslR9Q1JeMq/WX/AyAk0KHA8uDuxK4U1DzaNN+EN
         sfvgEBAEDi2X/h2Bpdr5T3qN7Lm7aAZs9pFNuNKPbBz2Eqf++UNj5ejoiMB0unTrVzyr
         8r/hblnaOqwCATPgrC65BBlK7HV6pZrNTMiFngFemWdtyAJ+yL4tTBpnr0Vk1/Wm4M0H
         2PJWMnyctszbFsJGnH9uoooTCgaPQGFNoZMPd2jZrZBnxNXgyx+HLh9lW1FkwZjSE/3P
         6P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lWKOJk/w+Z1cA3XJbkqmbl6FP31BnTiqqdE5uCiWewc=;
        b=XQVZjWxFYeMmVkGSSHegVpDaPJ18Oix5XrBWT2OiiCuYGbrAMiJ34AWTCPTRLcoVXL
         O7lucCxZnJ7OYYHzCpNPqRxyMzgPY8F1BvKwvgPRiLb3OYq/x3YFsAxr+zJPFhiHvgDS
         cB13VBqYreGY60YqRpIlsZQOBhrUxZcXoal3s8FbA5UG7TgJMFrr1g3AtZgt2GBWmJO+
         rxa9s/BylIR3Jqim7nG5Og1/8TZfMdtU1rlk07ydLcACoxm6/QNCyLtZDvaXVecruAwV
         Fr5ovmRPmM2F5D0+Ej5WVIQ9UqFLpo+gqCoRuATCMu7xHGsOMTGcEYYusxNVSxp+FAzH
         Q0Qw==
X-Gm-Message-State: AN3rC/6QqLQ9Jxs1KzUepU4lVmw5X+NwbPCmqkN78z7ztoxzM4g16Qfq
        7VBRzPruQkF+2HyX2/CmHQ==
X-Received: by 10.99.168.77 with SMTP id i13mr8647837pgp.148.1492707508098;
        Thu, 20 Apr 2017 09:58:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:90d3:adf:57a8:ebdc])
        by smtp.gmail.com with ESMTPSA id d187sm11533310pfd.47.2017.04.20.09.58.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 09:58:26 -0700 (PDT)
Date:   Thu, 20 Apr 2017 09:58:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, j6t@kdbg.org, sbeller@google.com, e@80x24.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v6 02/11] t0061: run_command executes scripts without a
 #! line
Message-ID: <20170420165825.GD142567@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
 <20170419231327.49895-3-bmwill@google.com>
 <alpine.DEB.2.20.1704201248290.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704201248290.3480@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Wed, 19 Apr 2017, Brandon Williams wrote:
> 
> > Add a test to 't0061-run-command.sh' to ensure that run_command can
> > continue to execute scripts which don't include a '#!' line.
> > 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> Please add something like this to the commit message lest future readers
> wonder where that !MINGW comes from:
> 
> 	On Windows, shell scripts are not natively executable. Git has a
> 	workaround to execute them, looking for the shebang line. Shell
> 	scripts without a shebang line will simply not execute on Windows.
> 	Therefore, disable the new test on Windows.

I'm fine with including this in the commit message.  If another reroll
needs to happen then I can make the update otherwise hopefully Junio can
just squash that in.

> 
> Thanks,
> Dscho

-- 
Brandon Williams
