Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267451F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 15:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfKSPWI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 10:22:08 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:37049 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSPWI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 10:22:08 -0500
Received: from localhost (unknown [1.186.12.29])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8FEA620000B;
        Tue, 19 Nov 2019 15:22:04 +0000 (UTC)
Date:   Tue, 19 Nov 2019 20:51:56 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>
Subject: Re: [PATCH v4 0/2] git-gui: revert untracked files by deleting them
Message-ID: <20191119152156.tzsh2hxgcgcegvtt@yadavpratyush.com>
References: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
 <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/11/19 06:56AM, Jonathan Gilbert via GitGitGadget wrote:
>  * The initialization code in git-gui.sh (which I'm assuming 
>  translates
>    somehow to git-gui.tcl in the installation?) now explicitly clears the

Well, the design is a bit strange. git-gui.sh happens to be _both_ a 
shell script and a Tcl script. When you run './git-gui.sh', it is 
executed as a shell script. That shell script then executes itself via 
'wish' (which is the Tcl/Tk windowing shell), and Tcl ignores the first 
"line" (it is actually the lines 3-10, but they all have an escaped 
newline so it is effectively a single line).

It has been like since the very first revision of git-gui. I wonder why 
the original author went with this instead of just doing something like:

  #!/usr/bin/env wish

which seems to work just fine on my quick testing, but that is another 
topic entirely ;)

>    "Initializing..." status bar text, since the new status bar model won't
>    do this automatically when operations are performed.

PS: I am in the process of reviewing the latest revision of the patch 
series. But I have been short on free time recently so it might take me 
a couple more days.

-- 
Regards,
Pratyush Yadav
