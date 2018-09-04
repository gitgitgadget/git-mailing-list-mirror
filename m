Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51AE21F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeIEDxH (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:53:07 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45833 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIEDxH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:53:07 -0400
Received: by mail-yw1-f68.google.com with SMTP id p206-v6so1931009ywg.12
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L+MoJXH5g0SpaZ9XdWLL7wmlW4KXm9dhDZ7BVIPxGzM=;
        b=tTv/+XhUqlqeKGDbU3fIHgdXaeic15wpWgV7+1d1tTU7OMz0rtXZ0GDIzj3rkag8M5
         Iubv8Q/gGyLU9zSG+AFrn/H/pNd1nd+NF3I0z2RF9yXzOllXFrRR18ZhBYbfVxJtpybe
         5mlEPx1r5133XAkmBx34rSET054IPXh2690515JVBsHx7ABoGtxC0HTQ2+VNo2ZvyndM
         FEvJK+4per87B6rrxa7otuN056ZoQUfoGLVD1XFSl5dOKE9gO8fxsHtxTPSkcIjImnZx
         oeN1DpDL1ZovJPFP6ys4hGyweT2Wg+V0r+DB0hDfKwoY7DcuMKkGHVHT/RWV3dL9+4J9
         koXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L+MoJXH5g0SpaZ9XdWLL7wmlW4KXm9dhDZ7BVIPxGzM=;
        b=W8gcrO+nTxhx93nTxPknxhPJVoZDl/DRmnmZBuxaukFnvJB1gE+5ddYVXg2Rr7QUbS
         KMFKnxs3qIZORDpP1+/0dS0AlQZyw8zAVwWXVnA9fO2nih9xaNh9j26EdGcye/9fEy4Y
         QwXfoFYZgVlL8Ud3dXe8jwTa/ID27zWF8Jnckoeq2P438Hdl56HBA6nViIoQWS7MJXQ9
         PqQ1EitV+JamIISHHfA2HvenBNyi4O7gEImriXOhHU8NzThrFhmnP0i3+GhPMytRRQeh
         4j5Jf1FbmzqvIX0JXZAb0FRtNiP780nEDLf6LTD/5u3/6EJBfH+PtLyrwvYOe2O+Nv+G
         zcQQ==
X-Gm-Message-State: APzg51DSb/wqS1M27/3jDVloxkz+FIMI2sje/EJuhzcIosdTUc9qvuym
        vBtc0/suWiUJeVhQrdIJYx0=
X-Google-Smtp-Source: ANB0VdavIYGXNpa7lOEcSXaCgjJPdxsv6cMmWEi78BDI22jHqFkioYsFBFrMVBHhSpfhd2rOGqxaLA==
X-Received: by 2002:a81:3b4c:: with SMTP id i73-v6mr6465515ywa.121.1536103545258;
        Tue, 04 Sep 2018 16:25:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f5-v6sm65626ywd.53.2018.09.04.16.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 16:25:44 -0700 (PDT)
Date:   Tue, 4 Sep 2018 16:25:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] mailinfo: support format=flowed
Message-ID: <20180904232542.GC34268@aiede.svl.corp.google.com>
References: <e2f2ca18-849c-0ef4-98a5-9a1379bfcec5@web.de>
 <20180904231959.GB34268@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904231959.GB34268@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> René Scharfe wrote:

>>  builtin/am.c                |    4 +
>>  mailinfo.c                  |   64 +-
>>  mailinfo.h                  |    2 +
>>  t/t4256-am-format-flowed.sh |   19 +
>>  t/t4256/1/mailinfo.c        | 1245 +++++++++++++++++++++++++++++++++++
>>  t/t4256/1/mailinfo.c.orig   | 1185 +++++++++++++++++++++++++++++++++
>
> This mailinfo.c.orig file appears to have been lost when applying the
> patch to git.git, resulting in test failures:
>
>  $ ./t4256-am-format-flowed.sh -v -i
>  Initialized empty Git repository in git/t/trash directory.t4256-am-format-flowed/.git/
>  expecting success: 
>         cp "$TEST_DIRECTORY/t4256/1/mailinfo.c.orig" mailinfo.c &&
>         git add mailinfo.c &&
>         git commit -m initial
>
>  cp: cannot stat 'git/t/t4256/1/mailinfo.c.orig': No such file or directory
>  not ok 1 - setup
>  #
>  #               cp "$TEST_DIRECTORY/t4256/1/mailinfo.c.orig" mailinfo.c &&
>  #               git add mailinfo.c &&
>  #               git commit -m initial
>  #
>
> Known issue?

My bad: this was operator error:

 $ git status -s
  D t/t4256/1/mailinfo.c.orig

The issue was that I ran dh_clean, which removed the .orig file.  I'll
fix the issue on my side.  Sorry for the false alarm.

Sincerely,
Jonathan
