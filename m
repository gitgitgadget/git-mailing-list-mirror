Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2358D20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdLADpY (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:45:24 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:46556 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbdLADpX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:45:23 -0500
Received: by mail-qt0-f179.google.com with SMTP id r39so11492399qtr.13
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pnSIMjSWlx5fzkWpsD7O7wSe/3vAM972Kg/7D5vz5hA=;
        b=azoox5gVO/QgjJMfRa/hdFfEnA6IfmOjIaeoLV+5oTNVKOUBdm6oqYZRexwwEyySZW
         NWC6HfmgAkArsAJ/H4wPOhstCD5LmLRGSTqVGpO2UUfMVxviL0YEJGMzPB6x7c7BKuJW
         ITQ3E+Ri+ymAxZFzD0QhiK2S7iW0lhbE+LjaHa3bWOLVF2faaIeUIp1kLpD9Cbzzs5Yl
         DCg83K12jb59v+GwLyjG2OjADwBcu+2FS17mnt1DtN9px0wjWOR54yw5pjlbJYGuuo8w
         S+WhkSW0yzcEjmZ3RAhdpbRarry+ImfTlvs6jaTnv/VEQAk5vZmcfWToVlzVC22aRLJT
         aPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pnSIMjSWlx5fzkWpsD7O7wSe/3vAM972Kg/7D5vz5hA=;
        b=S3x3khgxHpzElIFd/Qp2RE2+8WUoPj+celmtBRGS5pKxOIEUZcc7tLZAS5x+HmRTuU
         xIX9c2CcMJ1XC7NkeQ4ziy7W62cqbZzrrc0+sEMN1mj7IV2N/ui+bSMt0gsr7opTR8e+
         KT4608nQyWFeDJWqc8rnpOcFIP+LIztJ5aNxyYCnrIqZ3vWPcIyr6liVhmqj4nh9Y97M
         V/IP1qjWJbS47awOnq2gWYQ5hUuNXCazQRwSPDTZhtaUpEH1fiGCW49wkyY/bRNK645M
         kQtmSaEUqNYtyCekXAqFCgueyPT0MPAJvCXcEvSAQF5xuQWDal9RPQ6wjVuWSGw61bTE
         XELQ==
X-Gm-Message-State: AKGB3mJcJ898IW2GVc7hcA+UIu2KlVKY/jjWCP47wFwtlEQEAHWJ4z3S
        L3J22VFvI8SibpY5c4+cglc=
X-Google-Smtp-Source: AGs4zMZ4VlfYdu/uRlLiNVj5n3zanuEiF3FRfR1KYp+6/sT3mYAbsIaZ26xG13s11a74hOk7ugMBuQ==
X-Received: by 10.200.20.152 with SMTP id l24mr6860620qtj.31.1512099922427;
        Thu, 30 Nov 2017 19:45:22 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id o65sm3946753qka.86.2017.11.30.19.45.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Nov 2017 19:45:21 -0800 (PST)
Date:   Thu, 30 Nov 2017 22:45:19 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201034519.GE3693@zaya.teonanacatl.net>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201023239.26153-3-tmz@pobox.com>
 <20171201030234.GF20640@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171201030234.GF20640@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Jonathan Nieder wrote:
> Todd Zullinger wrote:
>
>> Previously, setting SVNSERVE_PORT enabled several tests which require a
>> local svnserve daemon to be run (in t9113 & t9126).  The tests share the
>> setup of the local svnserve via `start_svnserve()`.  The function uses
>> the svnserve option `--listen-once` which causes svnserve to accept one
>> connection on the port, serve it, and exit.  When running the tests in
>> parallel this fails if one test tries to start svnserve while the other
>> is still running.
>
> I had trouble reading this because I didn't know what previous time it
> was referring to.  Is it about how the option currently behaves?
>
> (Git's commit messages tend to use the present tense to describe the
> behavior before the patch, like a bug report, and the imperative to
> describe the change the patch proposes to make, like an impolite bug
> report. :))

This is what I get for skipping grammar classes to go hiking in my
youth.  But I'm sure I'd do it all again, if given the chance. ;)

>> Use the test number as the svnserve port (similar to httpd tests) to
>> avoid port conflicts.  Set GIT_TEST_SVNSERVE to any value other than
>> 'false' or 'auto' to enable these tests.
>
> This uses imperative in two ways and also ended up confusing me.  The
> second one is a direction to me, not Git, right?  How about:
>
> 	Use the test number instead of $SVNSERVE_PORT as the svnserve
> 	port (similar to httpd tests) to avoid port conflicts.
> 	Developers can set GIT_TEST_SVNSERVE to any value other than
> 	'false' or 'auto' to enable these tests.

Much better, thank you.  How about this for the full commit message:

    t/lib-git-svn.sh: improve svnserve tests with parallel make test

    Setting SVNSERVE_PORT enables several tests which require a local
    svnserve daemon to be run (in t9113 & t9126).  The tests share setup of
    the local svnserve via `start_svnserve()`.  The function uses svnserve's
    `--listen-once` option, which causes svnserve to accept one connection
    on the port, serve it, and exit.  When running the tests in parallel
    this fails if one test tries to start svnserve while the other is still
    running.

    Use the test number as the svnserve port (similar to httpd tests) to
    avoid port conflicts.  Developers can set GIT_TEST_SVNSERVE to any value
    other than 'false' or 'auto' to enable these tests.

?

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Curiosity killed the cat, but for awhile I was a suspect.
    -- Steven Wright

