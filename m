Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541BF1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 19:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbdHVTf0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 15:35:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38322 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbdHVTfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 15:35:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id y206so92851wmd.5
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=instituut-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rO+r1VCjgPQxS/UnIdBjZcMqKAVi9ASYQZUUjoFW/Eg=;
        b=C3fqaIISRAwVMkqtmxr3y39247d7UwKE4TE8QW+SLt7mNq4jt0dSKwa+PJYFPQKLv9
         f5AmQJLZddcjD+J9AKT2FwFPuBRyL+ePbsMfDwhaXsT/PQXuB+ec6L6pXmg5HHigkuXQ
         laKa7CtXJqvBoIYeYdJZlcLxupTxqzCYFFgt0KiA2lTWykDvu4CcRLnz2M1wrLG0DMWB
         IGQCqFTXtbztbIVTGQb/fqqiNfF5OIEOpo3P8vNM/VcUqF+CKXJQsJyuzcaw//7i/P6e
         n7fJnLHqfe4Ds2EwMCJL/XawZ9H23mpsFqZLp0lJaM0KqSqRf8B/+PmCN0Y0Ix4mP1pN
         hINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rO+r1VCjgPQxS/UnIdBjZcMqKAVi9ASYQZUUjoFW/Eg=;
        b=kFxRon5Hwz7PBIYfFdw/R8eFJcCZqlkQa2k/3uwxmX3oinIBa1gCEVuoknLDIOrNMW
         MnxqjIFSMvAbA7kEwTWECzxO7p/QcCHWBxRCwuFj57qUg72D7wUFt192SFF8aJ4D4zLW
         6+XT/FcSUX5L9qIws9CB9s9TGz4sY4cKfoVkWL5DMoOlPMFdsZxIvjYppSngMUmlaGsS
         CfI66Ox2ZLRoT+yaHOpsHp4RV0HWQ+gz+UCme99fDd0LzPSQ0lMNr9QepnCGgW3Ihkpg
         KOrghFCgEg8Vjnku7qwa+JmjGDLvd/5YRLbd9OFpPjkR2BetgAdHW3Qee7jm6IiPiWEr
         0ucA==
X-Gm-Message-State: AHYfb5gGRlO5JLo72YNtZ6T01s7O3P49Aqk7tAmrLTPobbrzur1eht3a
        H/JD0ofshCdcAdLO
X-Received: by 10.80.206.73 with SMTP id k9mr1035542edj.20.1503430521804;
        Tue, 22 Aug 2017 12:35:21 -0700 (PDT)
Received: from localhost ([2001:67c:208c:10:105e:203f:f35f:c921])
        by smtp.gmail.com with ESMTPSA id o36sm33736edc.39.2017.08.22.12.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2017 12:35:21 -0700 (PDT)
Date:   Tue, 22 Aug 2017 21:35:20 +0200
From:   Job Snijders <job@instituut.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
Message-ID: <20170822193520.GJ39363@Vurt.local>
References: <20170802185901.GA27243@Vurt.local>
 <20170820180332.GC39363@Vurt.local>
 <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
 <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net>
 <CAOxFTcxaxRjdsd0OSQX9E9ncEnO4XFLoa-0puXm2AByv6dZUow@mail.gmail.com>
 <20170821141306.wnlfn5a4hmgnj3yn@hanna.meerval.net>
 <xmqqo9r72yrg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9r72yrg.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 12:22:43PM -0700, Junio C Hamano wrote:
> Job Snijders <job@instituut.net> writes:
> > Add 'raw' blob_plain link in history overview
> >
> > Reviewed-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> > Signed-off-by: Job Snijders <job@instituut.net>
> >
> > ---
> 
> Thanks; I somehow thought that your earlier one not just said what
> it does (twice---that is not needed) but why this change is useful,
> but that is lost in the patch description?

We often work with very large plain text files in our repositories and
found it friendlier to the users if we can click directly to the raw
version of such files.

Without this patch the workflow is to go to the history of a file, click
the 'blob' link, and then click the 'raw' link. If the file is large
(multiple megabytes) - rendering the html enveloppe to the blob can take
quite some time in the browser DOM rendering. 

This patch adds a 'raw' blob_plain link in history overview so you can
immediately click to the 'raw' version, saving time and improving
workflow.

Here is a screenshot of a gitweb instance with this patch applied:

    http://instituut.net/~job/screenshots/b0f30e21eb64d5dda75ddabd.png

Kind regards,

Job
