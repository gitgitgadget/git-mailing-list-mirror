Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299B9C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 11:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiLFLUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 06:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiLFLUx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 06:20:53 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B32B7FD
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 03:20:51 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1p2W0H-0006DV-CV;
        Tue, 06 Dec 2022 11:20:50 +0000
Message-ID: <64522fbf-c006-700f-67b5-749093d6e962@iee.email>
Date:   Tue, 6 Dec 2022 11:20:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] check-attr: add support to work with revisions
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc:     toon@iotcl.com
References: <20221206103736.53909-1-karthik.188@gmail.com>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20221206103736.53909-1-karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Karthik ,

On 06/12/2022 10:37, Karthik Nayak wrote:
> Given a pathname, git-check-attr(1) will list the attributes which apply to that
> pathname by reading all relevant gitattributes files. Currently there is no way
> to specify a revision to read the gitattributes from.
>
> This is specifically useful in bare repositories wherein the gitattributes are
> only present in the git working tree but not available directly on the
> filesystem.
>
> This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
> allows us to read gitattributes from the specified revision.

Won't this also need a man page update? I don't see any changes to
git/Documentation/git-check-attr.txt.

Philip

>
> Karthik Nayak (2):
>   t0003: move setup for `--all` into new block
>   attr: add flag `-r|--revisions` to work with revisions
>
>  archive.c              |   2 +-
>  attr.c                 | 120 ++++++++++++++++++++++++++++-------------
>  attr.h                 |   7 ++-
>  builtin/check-attr.c   |  25 ++++-----
>  builtin/pack-objects.c |   2 +-
>  convert.c              |   2 +-
>  ll-merge.c             |   4 +-
>  pathspec.c             |   2 +-
>  t/t0003-attributes.sh  |  63 ++++++++++++++++++++--
>  userdiff.c             |   2 +-
>  ws.c                   |   2 +-
>  11 files changed, 170 insertions(+), 61 deletions(-)
>

