Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FEE91F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934119AbeGIRyE (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:54:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933860AbeGIRyC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:54:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so5360561wrr.8
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pXfuiDB2IiialPt+3vrMh1DcrnGpjH8VvchT/iLWDgM=;
        b=IXCF17bmCvcvE5nN+XPqQbg+5lPBJGU8l7nFid1yA6hEIx7tLyzFV45uQig5+T9zMl
         qgIkwY+mYXOdlyotVD5HOp29bSdsHGk1uQgA6BFQhv7qjKKgwiO4q1f1EbgLzcYBWwb8
         mzqS+OUviVrLnxulQd3kWNX0y99VMs+/ykXY9Ms96ES8QW5Cu/GohCBK6eoYCDlo5vY/
         Js5rzCwLf2WktFJPn2ZXFZFnIDzkTjtkfn1GHNcW+07NaQ+koZcNGOQlq+wA1qxyAX+t
         sewWYjzRWpdXu3t7ahkpH4hOvgpSXTLKR41YkQ7aKSjT4so+wiJrxuor2M+GVEZk+i48
         Z2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pXfuiDB2IiialPt+3vrMh1DcrnGpjH8VvchT/iLWDgM=;
        b=HdMcgYrBYO6JZf/9n+sxZi1sXWhfa7Zk2aEqTns/FjWjQPGReo1btGFGG6C0MGcMKb
         JEuoohpokhtxAU2VwKeNVGWkfe7DF5+jRaUaLddIKN1DXCivVck3A9pZzilLXspceimF
         cW5pZaKc4cRZFu9y2GvmNqQRBcDAFyOZX+ueKS8bhlMG1l5wTYFbgQxtUOYU0InwP1++
         jji4o2rU93T8PS/fTEbJlEDAQ8jGKEPyOnzSJoyaOiFHIbbvGYNpGpqJ0vADfr4L8grZ
         mVZa4jgOdB6NERFs+w5TxOLgEzaVvWzkeTDVVibcxPbsdmFrSFc+WM0smvLzFNaldbX3
         hzug==
X-Gm-Message-State: AOUpUlFvDEoJ1MIGmTt1vTMO0ibxJvantXYIWE2UwBWyqVQCo7MaLpsN
        Iaos84TFAmLWRwAGvrHr8zo=
X-Google-Smtp-Source: AAOMgpeVyFQ+sP7s2tNiodXJd2NVfg8U8g4m/5Ayd21tIATHLn0+hCxF2A+y9tkux4GeEq6NzokY7g==
X-Received: by 2002:adf:ec04:: with SMTP id x4-v6mr4785528wrn.245.1531158840656;
        Mon, 09 Jul 2018 10:54:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g125-v6sm16787864wmf.16.2018.07.09.10.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:53:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Add merge recursive testcases with undetected conflicts
References: <20180701041122.8753-1-newren@gmail.com>
Date:   Mon, 09 Jul 2018 10:53:59 -0700
In-Reply-To: <20180701041122.8753-1-newren@gmail.com> (Elijah Newren's message
        of "Sat, 30 Jun 2018 21:11:16 -0700")
Message-ID: <xmqqr2kce1mw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> SPOILER ALERT: This series contains answers to the "fun puzzle" at
>   https://public-inbox.org/git/CABPp-BFc1OLYKzS5rauOehvEugPc0oGMJp-NMEAmVMW7QR=4Eg@mail.gmail.com/
>
> When a merge succeeds, we expect the resulting contents to depend only
> upon the trees and blobs of the branches involved and of their merge
> base(s).  Unfortunately, there are currently about half a dozen cases
> where the contents of a "successful" merge depend on the relative
> commit timestamps of the merge bases.  Document these with testcases.
>
> (This series came out of looking at modifying how file collision
> conflict types are handled, as discussed at [1].  I discovered these
> issues while working on that topic.)

I have a topic branch for this series but not merged to 'pu' as
test-lint gives these:

t6036-recursive-corner-cases.sh:1222: error: "export FOO=bar" is not portable (please use FOO=bar && export FOO): 		echo "export PATH=~/bin:$PATH" >source_me.bash &&
t6036-recursive-corner-cases.sh:1227: error: "export FOO=bar" is not portable (please use FOO=bar && export FOO): 		echo "export PATH=~/bin:$PATH" >source_me.bash &&
Makefile:77: recipe for target 'test-lint-shell-syntax' failed
make: *** [test-lint-shell-syntax] Error 1

Arguably these are false positives because "source_me.bash" file is
a mere payload to go through the merge process to be munged and we
never intend to actually execute its contents with bash, but then
the test payload probably does not even have to be a string that
triggers such a false positive to begin with ;-)
