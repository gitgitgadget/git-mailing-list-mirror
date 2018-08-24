Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F43A1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 18:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHXV4t (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 17:56:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35922 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeHXV4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 17:56:49 -0400
Received: by mail-it0-f68.google.com with SMTP id p16-v6so3080151itp.1
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuC3qqBJtXstB3uzMfqEYgZA6B/csNjKokWsLS4Wrlw=;
        b=TldBW57mrt5tigMunALucmZ9Vqya91sV/bPpgVsxnH9p5yTg4+IwZ53DdvngPQM64v
         EZYm3zaGNkE81rSRJ55uzB83CjUQZqALQ4rBp4i3Fe3GxKlDLvLYxd1Tram4iblugev6
         ZcKnnikSXlAwsheiZF+x3Z6CJ7Q7ZNJOc+drNZ8NWktyNuMT2nZqmt/EM8ySU9yuISEW
         43iBXrvzVZyWD0j8Vy6H7n/CT9H98pCH2uizPuebVsSD+maZV2viSxWzoVbnrNU3shgW
         iXyMfTqGRzmL56z6F0yMAnKlh6zezbsKPqe40RrwT/+KBnB3sVEu1E6nINH33vPBOy+1
         5CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuC3qqBJtXstB3uzMfqEYgZA6B/csNjKokWsLS4Wrlw=;
        b=WBeYWSvpttM3evshXcr3V9ajBRVt4scy4iBrTGT7EA/Zrb/TOhQDDk6bJzZnGqdZ98
         IoM0x9ENsV9syyXY7RVPjUt2NuMkfqfDl0pJL/bCAP3Sp/GmcXQRyiOAzEZvmhOmjH7A
         lM5WLGiN7YuKgdDfI9GAr0vgQrCwxegueaUpoo4VJj9W2VdJdx5/AErOHx0M76lv5pLa
         j5QhV+DgQuKTPUf1OGVRCHNSs6FCDMm6xFKkTKB58eAWSKcx+0VnAoUopBfTn1AMDNk3
         r6d2Ghbpo6JwpDAV0WZ91fl//FtsXlQ649cRg2UFfiYiFQnbVtDhWGBeY0EgkReKDUs6
         dSLQ==
X-Gm-Message-State: APzg51AtAz0xSAGY5aR8cqReCPVGtFCI0TpjMlLMcFEIXBP+z3A6PVPx
        avzaV18T0zK1kknQ8CmI8Gnm7GiY3lUlbkSYDyo=
X-Google-Smtp-Source: ANB0VdbBHR9xx6pFWHo6gPfT9VhpZIAF9K8rltZyWBFRzA0fC0pOWv2CHefROMh3Qglg3SbQ/KkJzLo4OGMi/6IkR8o=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr2139212itk.62.1535134864140;
 Fri, 24 Aug 2018 11:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com> <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
 <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
In-Reply-To: <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Aug 2018 20:20:37 +0200
Message-ID: <CACsJy8BXy_7QbDtF8bY5YzwJf=JUwiODv0zKxoSXeu4rJ+xjwg@mail.gmail.com>
Subject: Re: [PATCH v1] read-cache: speed up index load through parallelization
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 5:37 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Aug 23, 2018 at 10:36 PM Ben Peart <peartben@gmail.com> wrote:
> > > Nice to see this done without a new index extension that records
> > > offsets, so that we can load existing index files in parallel.
> > >
> >
> > Yes, I prefer this simpler model as well.  I wasn't sure it would
> > produce a significant improvement given the primary thread still has to
> > run through the variable length cache entries but was pleasantly surprised.
>
> Out of curiosity, how much time saving could we gain by recording
> offsets as an extension (I assume we need, like 4 offsets if the
> system has 4 cores)? Much much more than this simpler model (which may
> justify the complexity) or just "meh" compared to this?

To answer my own question, I ran a patched git to precalculate
individual thread parameters, removed the scheduler code and hard
coded these parameters (I ran just 4 threads, one per core). I got
0m2.949s (webkit.git, 275k files, 100 read-cache runs). Compared to
0m4.996s from Ben's patch (same test settings of course) I think it's
definitely worth adding some extra complexity.
-- 
Duy
