Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C965D20281
	for <e@80x24.org>; Thu, 21 Sep 2017 00:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbdIUAb0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 20:31:26 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:57156 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbdIUAbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 20:31:25 -0400
Received: by mail-pf0-f170.google.com with SMTP id g65so2353988pfe.13
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u7ycGgcPZZT6ItX7uezf67XqbmAQZvdl/q0Ap6txEwU=;
        b=rv6L/GNnIwza+E9ntziW7+zGsewZn2lPVj6LDMG20b2jWSlgrnptWqwnqeHXuztHMq
         NMQEwGtrssm0EPv7R23ae3bM1DKCaRKM3HD3aRVDt2pjOJmpQTi7XpBzFJRsG1iQNW9m
         qsKPiyCc9oUqjAVfqxdj7Vecj5PPrVddGyno9jFPReWmT1A90kGaizbLcYgdB2QxrJet
         5QLi0UJB/s6D0Q7CnbVPFm/qng+josg+QQ0g3iQxlQidKaJ8GFd0e1FDu/gIvKfzfoJU
         MjbHijD4W0MNmv42t8eM5ADDYOolfYMyq3snVJs5cxw4gwvn4W5XXBEBitna7Dc235tb
         BYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7ycGgcPZZT6ItX7uezf67XqbmAQZvdl/q0Ap6txEwU=;
        b=rtxcBL998eIewc1gn9eZod65o7S83AyTBgYLdmfaaHYIwQY1+163e4kTaj3YID2YHK
         ik5RFuT+pRQ3rqgiaOYno2I57P8eTHyUHwiOzEzqWvkc/r/AuefsEBaFuNPIdeICF0Um
         YeHqOWYIA0FkktEXp4luP0McMwPWbufOxMONHxX7JKcJiXoicucH9/CZ1sUWkV7SKS30
         SxyYzQC3V2yuT06OtJGMTiVobRbOcU7CTt3r66D67A/B4SnYHMgABHWlCbxfIqZojXlW
         f8BbxEcaP/nv0ulvA+m9IRaKD1GXObfovNVcNfzh/UaiflXBkTHnSwiBpr2ed1xtz68L
         o5nQ==
X-Gm-Message-State: AHPjjUjVfnRAjaYCSRah0rW0igM6BfvgZ3Y6YB05/Wxm7syG/LoJQhWG
        xBXiPh4yb1iklBgLdcuahDf3w6sF568=
X-Google-Smtp-Source: AOwi7QDHgJSIcF6n14nvHRcvDts5lObz8J5k12Smo664zu+4d8nsx4QBVNvCZnEigu65l4hzVFENGA==
X-Received: by 10.99.2.214 with SMTP id 205mr3841533pgc.375.1505953885294;
        Wed, 20 Sep 2017 17:31:25 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:9912:5681:f7d0:a00c])
        by smtp.gmail.com with ESMTPSA id e66sm155704pfb.48.2017.09.20.17.31.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 17:31:25 -0700 (PDT)
Date:   Wed, 20 Sep 2017 17:31:20 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com
Subject: Re: [PATCH 3/8] daemon: recognize hidden request arguments
Message-ID: <20170920173120.2731e761@twelve2.svl.corp.google.com>
In-Reply-To: <20170920172443.6b42c9ba@twelve2.svl.corp.google.com>
References: <20170913215448.84674-1-bmwill@google.com>
        <20170913215448.84674-4-bmwill@google.com>
        <20170920172443.6b42c9ba@twelve2.svl.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Sep 2017 17:24:43 -0700
Jonathan Tan <jonathantanmy@google.com> wrote:

> On Wed, 13 Sep 2017 14:54:43 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> > A normal request to git-daemon is structured as
> > "command path/to/repo\0host=..\0" and due to a bug in an old version of
> > git-daemon 73bb33a94 (daemon: Strictly parse the "extra arg" part of the
> > command, 2009-06-04) we aren't able to place any extra args (separated
> > by NULs) besides the host.
> > 
> > In order to get around this limitation teach git-daemon to recognize
> > additional request arguments hidden behind a second NUL byte.  Requests
> > can then be structured like:
> > "command path/to/repo\0host=..\0\0version=1\0key=value\0".  git-daemon
> > can then parse out the extra arguments and set 'GIT_PROTOCOL'
> > accordingly.
> 
> A test in this patch (if possible) would be nice, but it is probably
> clearer to test this when one of the commands (e.g. upload-pack) is
> done. Could a test be added to the next patch to verify (using
> GIT_TRACE_PACKET, maybe) that the expected strings are sent? Then
> mention in this commit message that this will be tested in the next
> patch too.

Ah, I see that it is tested in 6/8. You can ignore this comment.
