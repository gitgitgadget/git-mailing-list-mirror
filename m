Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BBEB1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 00:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKOKLM (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 05:11:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44118 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOKLM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 05:11:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id b81-v6so8227933pfe.11
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 16:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5U7gTzsUR7zwT2jdDOjEwNWC5/EFg+ItgyE7mN1ub1k=;
        b=XAsV6OgGT+gtk5BHlMY1nT36jDdHMCpjWGX3FPaLo8hUhdFrxbaEmx2tCJawNwQZjN
         xUNOI6kVHD9MXBcoTLbASTFNXULepYg5TDx9iAtkVntPU0kRkgNKjZ6zwdjhhnjCmZn1
         0GAcnnnjXeEuUChR+sIxyYk2666qnoHbGHfS+k/iG0XcLUjjqL00kKO71E+Cr+1hk0vM
         KCvj7cLuyKPqAV7SflZzGNLk8mUNQDFtsB2stcmKfWAFjvbxVyEhgBFZEO8dE2Y13nvn
         rfyHcR3jV7KP6xsKZ9WtL6JezEqrNwr94r8baJod2q8ks9pnR1moFDj9FXdSWD1Ni0qd
         3dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5U7gTzsUR7zwT2jdDOjEwNWC5/EFg+ItgyE7mN1ub1k=;
        b=ZHkwdD0mRaUihOkGscpuvX36od+mMINbURDN5RPJMG2Xdh5+m6pqIj9qC0uQO0lhSl
         DJu1+Sfyu3VDg09ICNGASOKPpFcvAfyIEptZFC0+bFHxHHUezBM+UnUU9AKXPpFHRPi+
         LcXS94yBxAYYCwWKMgqnDz56f1zg94VKnJpXVxiYEJbdv/bXW2kvOGv5n06ZDBwEmCRj
         e9El2eWirOodKe5Vvs8NAchGAwoR2JeN2PsV8Mo1ft8tmD7tWd5k7NUtg0EazA2AObiy
         0N3uNKMO3lkGiXSwyZAJTWrj1RNif9dwPSXoiui/6OurVWyllWPBxgd0AZYHlNQwEUQc
         y1fQ==
X-Gm-Message-State: AGRZ1gLzyNgKMehzAG71a8qpwdUvgPnXoSPiYgcNLohfZvF3aZ0n++3r
        62wmK0+08cajdvg3mveKR3U=
X-Google-Smtp-Source: AJdET5eplMBkob620Et9eKsYquMFJesUa/yljqjJT6AxzRK+ynT+D1bloKZ5+vuJFnWyk0k7LQzbeg==
X-Received: by 2002:a65:5286:: with SMTP id y6mr3681380pgp.439.1542240342578;
        Wed, 14 Nov 2018 16:05:42 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id l26-v6sm44593055pfg.161.2018.11.14.16.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 16:05:41 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:05:39 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
Message-ID: <20181115000539.GA92137@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <20181113181855.GB68106@google.com>
 <1b890149-ee7f-c391-9abc-46d120e4324c@gmail.com>
 <20181113210815.GD68106@google.com>
 <75c91c81-f66f-ab2d-2b29-339deb3a6557@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75c91c81-f66f-ab2d-2b29-339deb3a6557@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:

> There is no way to get multi-threaded reads and NOT get the scary message
> with older versions of git.  Multi-threaded reads require the IEOT extension
> to be written into the index and the existence of the IEOT extension in the
> index will always generate the scary warning.

This is where I think we differ.  I want my local copy of Git to get
multi-threaded reads as long as IEOT happens to be there, even if I am
not ready to write IEOT myself yet.

I understand that this differs from what you would prefer, so I'd like
to find some compromise that makes us both happy.  I've tried to
suggest one:

   Make explicitly setting index.threads=true imply
   index.recordOffsetTable=true.  That way, the default behavior is the
   behavior I prefer, and a client can simply set index.threads=true to
   get the behavior I think you are describing preferring.

My preference is instead what I sent in patch 2/3 (for simplicity,
especially since the default of index.recordOffsetTable=false would be
only temporary), but this would work okay for me.

I'll send this as a patch.  If there is a reason it won't work for
you, I would be very happy to learn more about why.

Thanks,
Jonathan
