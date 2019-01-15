Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8820A1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 01:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfAOBFc (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 20:05:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35220 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOBFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 20:05:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so460213plo.2
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 17:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xKXTRlwJ3s83XZJQthj2i8as7yCXY+06iR/1h8KV92c=;
        b=pECXcfcCLuN/AwDlm2XiIQg09SaMbTLdNKZKSACshcUXTZeV47GnsHQjtT8KMc/qPP
         eQkGNO1GNiIx2viiTAmf+XDxJIjFAymMeuXfRBQoXS0lBfLuDD5QWGhfCK95+p9M+2qx
         NEpxY/tQs7gqXfAG2iqCgog3lxU5Oad+HjY7QoLPu5MI7SyTFUHFQL8JLUAd3RyecxS0
         0dA1GCPb5bvTkd4hOK1nOL0J8SDOlAP1dpvYA4tLelagEfmSXJQks9STLksJCnTskUay
         rilbuWpCV1y1JHvHRHDWvbdxTTqlhkQW7UkWvo4jsIiY5omzqrHNVp9a3jVjJWeCvDvL
         IRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKXTRlwJ3s83XZJQthj2i8as7yCXY+06iR/1h8KV92c=;
        b=VMTUAITHPeG0OHZ2Cio+V8vDwe6RVwKiX/l2bsW40s3DbtExQ6BmvHQhKxCp07FUZE
         s08n3tbIcMnaYOE84tAjAyCyQVJoJDYGQbyNvtRcOypT6d1fvuhGqyXYdOWw7QLy7gW2
         4SKYbFHH8uvFVdQsKpfSgCsEC3+Y1wWBoeYR8nXFF0Wexy8qke3Mqipp3hjgsgsjFOpJ
         HxfZmFJcSFq4Z4ZSjAfC7AdhLELh1PCvcOPOFjvpUsln/iJ7TTjQJY0x0WCFm7ygvcbr
         +xE73Zw3LK3APP9u2g9g1ArK7Kt/niGZfZRJtM2SQUr7xMXFGp+Nv68iLKusGtGQLi6G
         eo7g==
X-Gm-Message-State: AJcUukeyjkrItmNiQ6fRcSaOC2JUMiOb7X7ZxRaXH5RJe+3PmE7qlMvt
        tl/UY6bQzmJ5l5QSFebcNrg=
X-Google-Smtp-Source: ALg8bN57VOFHOil/6gpGNU6ybWfcwbKMhZ61yd1nn82/5/FXdX8QM3mguKOA/JuYP2dzoZht89TOMQ==
X-Received: by 2002:a17:902:8607:: with SMTP id f7mr1303474plo.123.1547514331224;
        Mon, 14 Jan 2019 17:05:31 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id v5sm1956529pgn.5.2019.01.14.17.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 17:05:30 -0800 (PST)
Date:   Mon, 14 Jan 2019 17:05:28 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/8] WIP: trace2: a new trace facility
Message-ID: <20190115010528.GJ162110@google.com>
References: <pull.29.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:

> This patch series contains a new trace2 facility that hopefully addresses
> the recent trace- and structured-logging-related discussions. The intent is
> to eventually replace the existing trace_ routines (or to route them to the
> new trace2_ routines) as time permits.

I've been running with these patches since last October.  A few
thoughts:

I like the API.

The logs are a bit noisy and especially wide.  For my use, the
function name is not too important since we can get that from the file
and line number.  Should we have a way to omit some fields, or is that
for post-processing?

We don't find the JSON easy to parse and would prefer a binary format.

When I apply the patches, Git complains about whitespace problems
(trailing whitespace, etc).

Aside from that kind of easily correctible issue (trailing
whitespace), I'd be in favor of taking these patches pretty much as-is
and making improvements in tree.  Any objections to that, or do you
have other thoughts on where this should go?

If that sounds reasonable to you, I can send a clean version of these
based against current "master".  If I understand correctly, then

 https://github.com/jeffhostetler/git

branch

 gvfs-trace2-v4

contains some improvements, so as a next step I'd try to extract those
as incremental patches on top.  What do you think?

Thanks,
Jonathan
