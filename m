Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713C120958
	for <e@80x24.org>; Wed, 29 Mar 2017 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932299AbdC2SkX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 14:40:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34166 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbdC2SkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 14:40:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so3878660pga.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1iZPuI2HB96vJm5eyljFlRz3dVNeSRneEsJTSlqBQ0=;
        b=L9Rz40upwzUWgd+DpBRUiq8qcI8aufuQg9ZrbNUdhHn1T+n19l88bOGPRInBWCryI1
         8CmUcOy/ZrLBH53USPuDL1ZiEb6dQiX/yKSQID2VFvbZ06ljO4LfI3lXinrw2eBfVqPN
         p24CTNwFGb9+fboRn+i0g7EFn1F9FOfMeUpSeSp9ePCUqRn4QTaL4bdvbmk0NEnFSjG+
         LApnNYnb4QCH6lTXR1b7al7/xz2DoA3j25aHoU5mNJdmxH6vtVJDoPy86Z2IqKFppZe3
         eFNX380ZWReItqJvBbxfcXVXzHMX7VtF8W+cTmzkgmtW0YUqLyaUalOlRxms27ipw+V9
         y7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1iZPuI2HB96vJm5eyljFlRz3dVNeSRneEsJTSlqBQ0=;
        b=D2YBSLt/wREDSQhdCS+L1lDqPW2cxLWfgZwdVNYA4jMolFfM0Xw53iVnHBTJHiUdTm
         BIsJncBxJj5k433+PQYPFcDR3kixKmQJedD40dAxk8icGqEIldbJhfwq2tsIYKvjENYv
         kBrbRayvqILzipsCDyFTU+TXjiNJkfV1PF7FBVhOURrRbkU14SXDM2oBeBu62el1K6+k
         hDLUJJm7FfzQAuc3pNl+YuinBEKKqU8/K3WzqZScL5Xoy0k5G96JwiMBc/zFIzCmcCzP
         RLCULPotS4U1HLcyl4YnFLcyb0E+uPiaATNBGSElFg4rXWIlGhUytLj0/dKBPavSLd3S
         +JMQ==
X-Gm-Message-State: AFeK/H2yLWben3HEPns0TvceV231IdsHVfWwfPWTP96IlB+DSJV7kmiGLprCylAVh5R9Gw==
X-Received: by 10.99.112.22 with SMTP id l22mr2056420pgc.94.1490812820927;
        Wed, 29 Mar 2017 11:40:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:1cae:64a4:6d7e:ad6f])
        by smtp.gmail.com with ESMTPSA id y64sm14976393pfy.3.2017.03.29.11.40.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 11:40:20 -0700 (PDT)
Date:   Wed, 29 Mar 2017 11:40:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eyal Lotem <eyal.lotem@gmail.com>
Cc:     git@vger.kernel.org, Kazuki Yamaguchi <k@rhe.jp>
Subject: Re: BUG: Renaming a branch checked out in a different work tree
Message-ID: <20170329184018.GV31294@aiede.mtv.corp.google.com>
References: <CALA94fPqm5UnYBwqZ5fDJ=DL_9EaZeRfqHB5ZzUQt11FSz4ZMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALA94fPqm5UnYBwqZ5fDJ=DL_9EaZeRfqHB5ZzUQt11FSz4ZMA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Kazuki Yamaguchi --- thanks for writing the fix!)
Hi Eyal,

Eyal Lotem wrote:

> git version: 2.7.4
> installed from Ubuntu repos:
> Ubuntu Version: 1:2.7.4-0ubuntu1
>
> When renaming a branch checked out in a different work tree, that work
> tree's state is corrupted. Git status in that work tree then reports
> itself being on the "initial commit" with all files being in the
> staging area.

I believe this is fixed by v2.8.3~42^2~1 (branch -m: update all
per-worktree HEADs, 2016-03-27).

Thanks and hope that helps,
Jonathan
