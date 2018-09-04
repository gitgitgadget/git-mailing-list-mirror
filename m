Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2B21F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeIEDrX (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:47:23 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33710 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeIEDrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:47:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id x67-v6so1947493ywg.0
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wb8LKTIeTCg7vFXmEnjK/MYsVmpOOhyMS+GbQ3wEUBE=;
        b=aSo0tekPaWlDVwT4Rc96aN2CDCr5iIF7Zy1syoZUScj77ll1Ti/ki65Xr2J9at5/16
         EZ1KqyWHhuyQ/P/Y+AzVbJpHbnwRcPffC2RmQ6p0zidt9ZxulZI4XGw4/TtcFF+jcLl6
         cYvd7NMaomZoHg781Fh3Bbo/1r6L4kaK5AGjTtqi36YmcvPe3Xd+sRqrkpN2xe4Ht+Dn
         3cnMONP2vXme1kmmGLHrv1VVRd48uWeDEx+qI0aiND+j7PCi4hbet96K9y8aIv3RLGgV
         tgju77fC9j6/NRatLBYME/3AhxbUOdY32oRrRK6G7FR8RtcXAtAQTV1hJetLT88Jhke/
         DolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wb8LKTIeTCg7vFXmEnjK/MYsVmpOOhyMS+GbQ3wEUBE=;
        b=lOgGmV5nuobEeeWOigSsKL/XTurUleG5AwYtOrmSsC34yNmUwf74pVHAjd19kPweQE
         a4jb5FNeravkJG8i5kGPCHtQmnVEym2m7dBgflufgg73vDD0hNSk7vTzeyDL+hgqxvjx
         GxvpRCk6MNUiQuKIt7JD/FjubwIElGC7Mai6Hv+BJQlQXbhUm4VgzCHVF/4iHSlWVhE/
         SThNRTVbZQ/IDIptRxEKVzwKv1EV5qurDtxCpW3Q9NYEDLOJUQLbc+udjceJPDTFgWE2
         PWlUn4ZBhsGuD0p01n3CR2sqFzT3kvGVzwcIWpsjqUz7HRpfL9a/VAwXJVIq3oKop0x+
         re5w==
X-Gm-Message-State: APzg51B9W+RMqfMGhU7JjTI6YVq9Og4Rj3e2AYzRvs+Knh3P7nJAfqY4
        +YDgtdIXPrxAkGs0+ksApME=
X-Google-Smtp-Source: ANB0Vdaqg0QMi3Fo591qWbSItHzbMol35jVTuJg1ORvXvzXkjQ4IXWDt0/wOqSW3alweZ9+5lyHu6A==
X-Received: by 2002:a81:8602:: with SMTP id w2-v6mr19546640ywf.61.1536103202878;
        Tue, 04 Sep 2018 16:20:02 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 129-v6sm79809ywq.26.2018.09.04.16.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 16:20:02 -0700 (PDT)
Date:   Tue, 4 Sep 2018 16:19:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] mailinfo: support format=flowed
Message-ID: <20180904231959.GB34268@aiede.svl.corp.google.com>
References: <e2f2ca18-849c-0ef4-98a5-9a1379bfcec5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2f2ca18-849c-0ef4-98a5-9a1379bfcec5@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

René Scharfe wrote:

>  builtin/am.c                |    4 +
>  mailinfo.c                  |   64 +-
>  mailinfo.h                  |    2 +
>  t/t4256-am-format-flowed.sh |   19 +
>  t/t4256/1/mailinfo.c        | 1245 +++++++++++++++++++++++++++++++++++
>  t/t4256/1/mailinfo.c.orig   | 1185 +++++++++++++++++++++++++++++++++

This mailinfo.c.orig file appears to have been lost when applying the
patch to git.git, resulting in test failures:

 $ ./t4256-am-format-flowed.sh -v -i
 Initialized empty Git repository in git/t/trash directory.t4256-am-format-flowed/.git/
 expecting success: 
        cp "$TEST_DIRECTORY/t4256/1/mailinfo.c.orig" mailinfo.c &&
        git add mailinfo.c &&
        git commit -m initial

 cp: cannot stat 'git/t/t4256/1/mailinfo.c.orig': No such file or directory
 not ok 1 - setup
 #
 #               cp "$TEST_DIRECTORY/t4256/1/mailinfo.c.orig" mailinfo.c &&
 #               git add mailinfo.c &&
 #               git commit -m initial
 #

Known issue?

Thanks,
Jonathan
