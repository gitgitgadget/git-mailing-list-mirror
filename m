Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893EB1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 12:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeDVMHW (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 08:07:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46246 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeDVMHV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 08:07:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id d1-v6so33818174wrj.13
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWoEO0B45zA79YCsNxAO852M8O6ycqjneAcPdNUj/MQ=;
        b=FgwdmS50nJq9okudRG5qJBLX/SEIuMnkPpxhhN3bj4cWGc0rL9kxZ8DmXyT4iO93xE
         es7iiNL072ZacBwpc4pZ4Q9JVUiPDZV2BiW/SkvPl39xgFbKYaMDzouS7JyhgnhzS8qI
         /x5gW5vquD4yOQ3p/QkLIoshBCBXhnhxultODmmycPZXeEsOUEAFsc6MZXNqT6RWRFBY
         h18ApSJU65c583t8LWT1IriPwtZ2CWTxexbjzs0SvILUm4biCrl3sJfVWDwIuipto9Ow
         6VrZrzidY6vMG4scUqiLE7qpiIfmER7ApRPzqXhghMpVVy3qrdbV7Bjs44PBCBQeWUeh
         tYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWoEO0B45zA79YCsNxAO852M8O6ycqjneAcPdNUj/MQ=;
        b=dpWZ2/lX880ULqJX5qWCAsQ2Ce8zGvsl8vFiORNaP/ohpkz6ae/JhISziZhYy7P1ja
         NT2MtnApxDxtlXhyZohjv4M/Zsh4qXFKxlg8zcs3eYm4T4W50Nb0WdDLcDU9ZydWrkvI
         fZDAAsdyjMlawPj7J0CADlRSGNnadIPz7h/tOEJppNQgxvthEYtEByEtaFt4WFuP6QXE
         iOGthOCpaGoMYsAaqR0Di8y3zLczIOF+aGC+AnZ2SpPXwvZhZsSuBq0KwiXQhmrqVaZt
         vcSFEM+Gu1KK50+SyhWuD3Qe5VAmfCF1K7Z7MzIhKiIDr2k0B3xMMs+gyssGTfBkvcv9
         mSRA==
X-Gm-Message-State: ALQs6tADmYm/Q94Gt91Jww9UdjKVYeQLtFPqPawZdIo4HPICGPh3dn9+
        b1KdcUV3gnfOwgtR8nc6k+I=
X-Google-Smtp-Source: AIpwx4+nYUJLvHXiCX6pc7rgCocGl2dQ6Khx4UNNa8yNVtjkml7ozzTwOQNqnREXsuth7z63GytZYQ==
X-Received: by 2002:adf:9267:: with SMTP id 94-v6mr14389079wrj.206.1524398840658;
        Sun, 22 Apr 2018 05:07:20 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id i30-v6sm17099475wra.38.2018.04.22.05.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 05:07:20 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Sun, 22 Apr 2018 14:07:18 +0200
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
Message-ID: <20180422120718.GA29956@esm>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com>
 <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
 <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 11:34:25AM -0700, Elijah Newren wrote:
> Sorry, I think I wasn't being clear.  The documentation for the config
> options for e.g. diff.renameLimit, fetch.prune, log.abbrevCommit, and
> merge.ff all mention the equivalent command line parameters.  Your
> patch doesn't do that for merge.renames, but I think it would be
> helpful if it did.

I wonder here what the relation to the diff.* options should be in this
regard anyway. There is already diff.renames. Naively, I would assume
that these options are in sync, that is you control the behavior of both
the normal diff family like git show and git merge. The reasoning, at
least for me, is to keep consistency between the outcome of rename
detection while merging and a later simple "git show MERGE_BASE..HEAD".
I would expect those to give me the same style of rename detection.

Hence, I would like to use diff.renames and maybe enhance this option to
also carry the score in backward compatible way (or introduce a second
configuration option?). Is this idea going in a good direction? If yes,
I will try to submit a patch for this.

Ah, by the way: for people that have not touched diff.renames there will
be no visible change in how Git behaves - the default for diff.renames
is a rename with 50% score with is the same for merge. So it will only
change if one has tweaked diff.renames already. But I wonder if one does
that and expect the merge to use a different rename detection anyway.

Greetings,
Eckhard
