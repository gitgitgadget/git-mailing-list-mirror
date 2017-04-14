Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBF920970
	for <e@80x24.org>; Fri, 14 Apr 2017 19:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbdDNTig (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 15:38:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34650 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754492AbdDNTie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 15:38:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 24E0820970;
        Fri, 14 Apr 2017 19:38:34 +0000 (UTC)
Date:   Fri, 14 Apr 2017 19:38:34 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3 06/10] run-command: don't die in child when duping
 /dev/null
Message-ID: <20170414193833.GA5290@starla>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
 <20170414165902.174167-7-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170414165902.174167-7-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> wrote:
> +	if (cmd->no_stdin || cmd->no_stdout || cmd->no_stderr) {
> +		null_fd = open("/dev/null", O_RDWR | O_CLOEXEC | O_NONBLOCK);

O_NONBLOCK?  This was in my original patch, too :x
Wow, I wonder what I was smoking that day...
