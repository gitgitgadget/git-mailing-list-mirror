Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553F020281
	for <e@80x24.org>; Tue, 19 Sep 2017 02:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbdISCwz (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 22:52:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34643 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbdISCwy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 22:52:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id g65so937907pfe.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 19:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wySc5L9+zFp8RKqcIgQjFLjltcFTiUF7n6t2hD6yo1M=;
        b=fnzjSKBA22Slb1779dRHZy5QQ4+m2sgaLhCM9WV+aWsUyoz1n9RtsjCBKNML8VMtY5
         VLtYDXWNJqNZm59XDfS9hx5E+28Uu8DUzZ9FbXuHNdaoWSakun9b268K2U7/8t72AthA
         FZNdiehMBnCT2hNjc6bJGlualYqMWztPqVzXpEdee6Es357Z2ReG78KFwKTnlFoBpgu6
         yQ7eVJoNC10d13AfJbiCCqPMKgJZd1MI3BtXh633bRYg5+F4paz1bzgIhV/68R9vnNRn
         WNAhH1rQjrYbDLYE+jzzZDBy39P33XbYnfSJ3GmG0y97VZkmbi7dwkhKXgUTZLSH/m3y
         lG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wySc5L9+zFp8RKqcIgQjFLjltcFTiUF7n6t2hD6yo1M=;
        b=l3hhoLXZ5x/eXXjZZflV6azPIUwL5bObGuNTRx4dEnuWqttJXtgDFpaT3M8E+U/wxf
         oFqgl4EjkpZfSFMe7sc42uLymREoZtHLsh4MCZfOd/fwzWOPlOM/YD+2S/gtukc33L1w
         NtAqeDuonWsy9zi0httXR47G1kkJ2vtvYXMDkKU0jVvmMSSSHzM92uNczvribcwToLRS
         6G2J8bPGS2OP6o1ilmm8EPogDqhMaWf0C5lxEeKKE4hOkB0o6xBSoFsdaRyRNJYN5pGJ
         m5St8KUMaNgnf/FOEZ8eXZElAsmCpcF2D8XVA60RysPdR/nEFYzr7YUUBi4zVE0oUNDS
         m9Nw==
X-Gm-Message-State: AHPjjUinR7yal20WcQng1qcjp9go/YIOBgavRMcNwUClLANQr42QLkbr
        CC8MAJhSaZvlqA==
X-Google-Smtp-Source: AOwi7QAI6cJ0Z8aT0i1YuqqlZz+4QbhuyB6NxDZBzQMzn4N/hH+p1cufXvWbRZNLDxsU7M7urdOsuQ==
X-Received: by 10.98.178.133 with SMTP id z5mr596797pfl.312.1505789574023;
        Mon, 18 Sep 2017 19:52:54 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id a25sm891084pfc.143.2017.09.18.19.52.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 19:52:53 -0700 (PDT)
Date:   Mon, 18 Sep 2017 19:52:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t9010-*.sh: skip all tests if the PIPE prereq is
 missing
Message-ID: <20170919025251.GF175206@aiede.mtv.corp.google.com>
References: <ffcf72e9-b724-3312-ca63-c21d0b8a235c@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffcf72e9-b724-3312-ca63-c21d0b8a235c@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones wrote:

> Every test in this file, except one, is marked with the PIPE prereq.
> However, that lone test ('set up svn repo'), only performs some setup
> work and checks whether the following test should be executed (by
> setting an additional SVNREPO prerequisite). Since the following test
> also requires the PIPE prerequisite, performing the setup test, when the
> PIPE preequisite is missing, is simply wasted effort. Use the skip-all
> test facility to skip all tests when the PIPE prerequisite is missing.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  t/t9010-svn-fe.sh | 55 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)

It was always the intention that this test script eventually be able
to run on Windows, but it was not meant to be.  It would need to use a
socket or something for backflow to work on Windows.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
