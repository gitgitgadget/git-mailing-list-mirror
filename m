Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7508B1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 01:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfBKBNQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 20:13:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55026 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfBKBNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 20:13:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so14286366wmh.4
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 17:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Eotzm7i150KzxZaFCkznJIXBr0tpMb/oMVp+JkeR3Xc=;
        b=LCVfHnRh23XQA4SBjgJ2b1cJMjoUs0qVCyjz4tLvywSc3pQr+fOKEzBxxo1MzmnvP7
         XZ0azHiJd2WsmF6rKtDS1irf68VqSnO4PmPy6Y/n81mWI44dcUp9B740ZImz18E5+o7r
         oNmQ7eEME7gpVAYGiVDLD29Wmo3FSbubpY6rHoqoNmUY8d1uw4Uu5z/MIqXqekZHX7mC
         kbGfFGYsHs72X78DHGUnB2hzPWHwgxRYOExoX7SLfGkrgDgdGRZzVbCh724ARw1lOpdH
         17EmsLIyAz5VKPkA24UZiRfVqo0JRPc6q9eewPbzvqLg0nx8TMBto6+zhUHphZiVO1D8
         nfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Eotzm7i150KzxZaFCkznJIXBr0tpMb/oMVp+JkeR3Xc=;
        b=fMO8hOHQQ08A6LZMaJNMCUl/TdGtZkzaosVwhN3h/KmmqfBJCndcBeeE8VrRiIvY15
         G/B32ShcWC/wCiJIN1lh0pU5les4o18rZEUeU0cUAF74DfszraT1Z3+jdo2MygKiOHJX
         wQMJyfOtdH4qHGebrnihcdaDfcnFXvAZkpi3rCuv/4CZV4sJVqghSEswOWvkIeaUnvVT
         0KVJGj60V7kzUYocP4zoOvKD11+Xo+a8E2/X/G3WeKVQN5fZ/ApCUu4cjgzWDqnj1f9P
         FQKDX3gynlSbnOVmt0QMdOsDr1xIOJb3ND/G3ytD5ge1z8xvuPvx/+6v55Rxn0Q1qNSA
         552g==
X-Gm-Message-State: AHQUAuYugPu8FcFhd9AiAsgmwBc7FIBW9IEIT9J5ZkwxsenosDmkR0Po
        BgUlHyh0xoF1KFm6S/1gOVs=
X-Google-Smtp-Source: AHgI3IbdQgiOmEzPRSXoE/+uee8DwZLJ3lZtYaUWfuqiKVbvwfddcyBxGDLWa2JrjTz1fYx9RFyhgg==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr13699965wrr.175.1549847594404;
        Sun, 10 Feb 2019 17:13:14 -0800 (PST)
Received: from szeder.dev (x4d0ca102.dyn.telefonica.de. [77.12.161.2])
        by smtp.gmail.com with ESMTPSA id y24sm18418437wma.0.2019.02.10.17.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 17:13:13 -0800 (PST)
Date:   Mon, 11 Feb 2019 02:13:06 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
Message-ID: <20190211011306.GA31807@szeder.dev>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
 <20190208113059.GV10587@szeder.dev>
 <20190210221712.GA9241@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190210221712.GA9241@hank.intra.tgummerer.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 10, 2019 at 10:17:12PM +0000, Thomas Gummerer wrote:
> On 02/08, SZEDER Gábor wrote:
> > On Thu, Dec 20, 2018 at 09:44:34PM +0200, Paul-Sebastian Ungureanu wrote:
> > > Add stash push to the helper.
> > > 
> > > Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> > 
> > This patch causes rare failures in 't3903-stash.sh', I've seen it
> > break for the first time today in a Travis CI build:
> 
> Thanks for reporting this.  I was going to take a look at it, but
> unfortunately I can't seem to reproduce the issue even with --stress
> (I let it run for ~1000 repetitions and then aborted it).
> 
> Which platform did you see/test this on, and which compile options did
> you use?  I went through a failures on
> https://travis-ci.org/git/git/builds, but couldn't find this
> particular one.  Could you point me at the failed run?

It was in a Linux build job in one of my custom CI builds [1]:

  https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/490420713#L3401

and I tested it locally on Linux as well.  I don't think there are any
unusual compiler options.  I run it with --stress on Travis CI's macOS
as well, but couldn't trigger a failure there.


[1] That build log doesn't include the trash dir of the failed test
    in the log, most likely because of a faulty merge conflict
    resolution on my part, but you can find a failed trash dir
    embedded here:

      https://travis-ci.org/szeder/git/jobs/491401882#L2309

