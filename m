Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2EF1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 23:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbdLNXts (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 18:49:48 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:43214 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbdLNXts (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 18:49:48 -0500
Received: by mail-qk0-f180.google.com with SMTP id j207so8410916qke.10
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 15:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YceBEfQRe3YLufLDymqxsywsgwj5+s21HztQvwIbJts=;
        b=GGRWaykBcMOTjbm9r35jShyOIBmXLVuoj24gLNKZ1DXLsZblZNfuzPfU/ArXX2/YXw
         lHG03n6xwJZqKrBLAHdNCGEwJi9FDlOmQLr8FexjmAT5CaC6mitCohmyfEHk9haQHNF7
         gdZ22kVuMAOIoCAgchEn/TQqK/UVctKC+sPUJDWaA+Jj8eFeQWYRvO3tImDaABqjGgoS
         DMTIQy5du0IJ9UC0kVtWd7B86VqTb3oiLk/U524Bxq0LbiA4u9SD12i1EqUQCbKiftzX
         CmZBEP3CS+9SZx6N8rZ9hZ0EoAVfMBPnNhv1sLSGYtfgrp4PyH0SmST97Dq7VPWPbFm7
         8Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YceBEfQRe3YLufLDymqxsywsgwj5+s21HztQvwIbJts=;
        b=M6K9hvXwAUyxeOuKYR0rDHJh9Sxf6K5LIzamL48GhvLzkLWmrYvJYdWx4fyBl3O6s8
         fL6UuOrEBxwLea5hO3mw+elfsWaIrlPftFPPd1r0VkJQ8b1qraM/nBWxuO2xnFwr3uLf
         GYtX6dF/PfgMOER1b6Ovu5Ot3MSr8UXs872xbdFwzrUNKjlCQvGxWgV+bBt4P6p5yjPU
         VkHETxyqBvHy8Uvo9uO5eEwz2VA/jzKHXXZ8wbtduSffgDwh5S9cQNOd4xF2vWHfwuJx
         kmUvxHgrkKKjKYFLC4oLk60wdDTfgIH35Xdv/G6r3Uzvi97eKeI6lQqLx+C3AcTwjHYj
         7UUA==
X-Gm-Message-State: AKGB3mJ8nq1Zwqfp9e01FiWflRFVXgYUUJV6il8zbxA02zRrw2GTSJme
        cICOYJhktJXNNA2ATqbIleI=
X-Google-Smtp-Source: ACJfBot4VbMmITI2tVr5iQuni8gv2v9xrsBbIKXbbQxiXFD04t1qvEWrfu0TSHkjqrUgWALs0NJJRg==
X-Received: by 10.55.197.81 with SMTP id p78mr19978787qki.56.1513295386922;
        Thu, 14 Dec 2017 15:49:46 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id z128sm3246984qke.92.2017.12.14.15.49.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Dec 2017 15:49:45 -0800 (PST)
Date:   Thu, 14 Dec 2017 18:49:43 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "Bennett, Brian" <Brian.Bennett@Transamerica.com>
Cc:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-svn: convert CRLF to LF in commit message to SVN
Message-ID: <20171214234943.GF3693@zaya.teonanacatl.net>
References: <BL2PR05MB2179DEBF7123ACD090E60F2685340@BL2PR05MB2179.namprd05.prod.outlook.com>
 <20171214002050.GA32734@whir>
 <BL2PR05MB217980546899C5B8EFDE06FF850A0@BL2PR05MB2179.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL2PR05MB217980546899C5B8EFDE06FF850A0@BL2PR05MB2179.namprd05.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

Bennett, Brian wrote:
> Thank you for your fast response,
> 
> I haven't done a build of this type before (so I could
> test the patch first) so I'm trying to do that and get
> this far:
...
> I don't want to drag out testing the patch, so if either
> of you are able to quickly guide me on what I am doing
> incorrectly I am willing to get the build done so I can
> test it. If not, could one of you build with the patch and
> somehow get that to me so I could test?

I don't know about building git for windows, but since the
git-svn command is a perl script, it might be easier to just
patch that file.  I think you can find the path where
git-svn is installed using: git --exec-path

For this one-liner, I'd just manually apply it.

(If you want to use 'git apply' or the patch command, you'll
have to edit the patch to adjust the name of the file, as
it's git-svn.perl in the git tree.  The .perl suffix is
dropped in the installed version.)

Hopefully that makes it easier for you to test Eric's patch.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I am in shape.  Round is a shape.

