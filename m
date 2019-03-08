Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB1520248
	for <e@80x24.org>; Fri,  8 Mar 2019 17:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCHRnS (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 12:43:18 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52719 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfCHRnS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 12:43:18 -0500
Received: by mail-pg1-f201.google.com with SMTP id w4so7716297pgl.19
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 09:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EkadiOLW40XePgyGAIqSKMRqf3qsklSS/yMJgfwaFYY=;
        b=HlodU8E7HGpHfiIVlq+VeFdYvOrd/SVlmmqnvpNIFCHxAh81RhAcvXv3V1fAedkw9X
         CPG1aJKTznXxICVGpcPMy0IruzMfQz5RPrmknJ1phimEi4nvzidaQa5+9Fc/lCuasDoz
         i7dmMN+iLYz+70dQKuChWXFORPyv42t9i0RbwBGqLbzjGpXbDP9XpBLOT2ERkBi/fcL5
         HYt6vpJ5/P4EqZ9zLQs03jqIovmPyQHtvUfcPtcgfgodsvkx/rinVCiwjE8ocfAKQYsw
         JUDKJ0yYTDTCW1cIs3u2wBPfYt5nXtdcH3o/Ki0DBzLvWtBD/zvJVfwPo4hl2Z7OObl3
         Gw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EkadiOLW40XePgyGAIqSKMRqf3qsklSS/yMJgfwaFYY=;
        b=YNDsHEO+Qxod4u68qxjpR8+A6eTUucdUySRh95SR/rAkSfC+bLBFozxa9XNbER/G9B
         J4pza3jPnF0QaJN0QAxUuKPqIDbxWFqm4PqO75Bg7oJ2QRCAgDW6IkCLPPDHSbJdvh2+
         g7w0GUfcpbYgZdQ3sGFbS/rws71EuY1rFJyHUgWdnAw56wnEwuWXiLNxVu/QoD6N66Iv
         1+dVHbh2hGIEu5brh8R0ebg8SZtPLEUP+Kvuq2knLrP5Fz8AKOH5EQmqLIdlTplIhglF
         5S7Tc3ic5RlpPiWgb0lTBZyY8CpELe534wKeYl+0UeAz+qibFFsPgkBYdj2N1+BVPKME
         p16g==
X-Gm-Message-State: APjAAAVqqHXP34nd3pxjXHrbxcBU0xF2Jjywhrc/jX3LcJ5jj4QIEVLF
        3AsYzcnL5Ei1ECAerT5DXuvCSm1FLe86DwqcjEOy
X-Google-Smtp-Source: APXvYqx0Q3LQdbw3rWMM64qmpHzN9y5QYabHHduUhWfbxaCLwqSirA2g5USFYCaGXFc+L7C4bPmuIQNtNJU2G+BnP9lr
X-Received: by 2002:a62:11d0:: with SMTP id 77mr7526582pfr.126.1552066997691;
 Fri, 08 Mar 2019 09:43:17 -0800 (PST)
Date:   Fri,  8 Mar 2019 09:43:14 -0800
In-Reply-To: <CAMknYENWOW0mj6Bn9OooqKg-sZi9bZUO461Gv1F00=phNwLFQQ@mail.gmail.com>
Message-Id: <20190308174314.129611-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAMknYENWOW0mj6Bn9OooqKg-sZi9bZUO461Gv1F00=phNwLFQQ@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: New Ft. for Git : Allow resumable cloning of repositories.
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jkapil.cs@gmail.com
Cc:     git@vger.kernel.org, t.gummerer@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Objective: Allow pause and resume functionality while cloning repositories.
> 
> Below is a rough idea on how this may be achieved.

This is indeed a nice feature to have, and thanks for details of how
this would be accomplished.

> 1) Create a repository_name.json file.
> 2) repository_name.json will be an index file containing list of all
> the files in the repository with default status being "False".
>    "False" status of a file signifies that this file is not yet fully
> downloaded.
> 
> Something like this:
> 
> {
>   'file1.ext' : "False",
>   'file2.ext' : "False",
>   'file3.ext' : "False"
> }

One issue is that when cloning a repository, we do not download many
files - we only download one dynamically generated packfile containing
all the objects we want.

You might be interested in some work I'm doing to offload part of the
packfile response to CDNs:

https://public-inbox.org/git/cover.1550963965.git.jonathantanmy@google.com/

This means that when cloning/fetching, multiple files could be
downloaded, meaning that a scheme like you suggest would be more
worthwhile. (In fact, I allude to such a scheme in the design document
in patch 5.)
